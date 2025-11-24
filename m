Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6EECFD359
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 20:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNdXW-0006EH-9G; Mon, 24 Nov 2025 15:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vNdXS-0006DU-Gi
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 15:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vNdXP-0000ux-KR
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 15:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764017513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aThV+OKVdzTcF3kwgT/HsL5o0e5zpvlKw6Ew/DNQnfg=;
 b=Oxty/CsbOYM+Y5zu9GY42NcyD7jqPgVDntqLLFn2xYvdG+dFEWqXzu5HiL2RiPHXtb4Gkh
 dCS5PyhWvYyVFl2Skw48yxBYbF5vNZ+I93sVp/lb+l539IhX1ikeyc+znOv+CIkTImfGhT
 xjS8PgllUhjTRIWO9DcxcGJBN+u0IOA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Af0IxeGkNjqo-F4iQzbYeA-1; Mon, 24 Nov 2025 15:51:52 -0500
X-MC-Unique: Af0IxeGkNjqo-F4iQzbYeA-1
X-Mimecast-MFC-AGG-ID: Af0IxeGkNjqo-F4iQzbYeA_1764017511
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47106720618so60549895e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764017511; x=1764622311; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aThV+OKVdzTcF3kwgT/HsL5o0e5zpvlKw6Ew/DNQnfg=;
 b=d1eQbbCIF1PI4jHXkLcXZ3Xmb5/5FQDC2bA3NkU46c2ERBgxpCQNQd7sz8FfqZesPS
 4/IPZ3EVLtHYrPVsoEr8+S4BKknidfUsZol+BMnhUhGzuvIrUR6RPNJIuyMzHLrvUunk
 I8OKPrtUVTJQBFa3AVTdwWfumuvayXClT4+EWmupEsF/yZC27DufHriWgy+q5qtu3iBC
 AtlZoPyizbOiFkj3f+7fHMu8lVrUd75sX98C8IkotKN34nBMIGuu4YDuKvBOrdA4ka3D
 0VJwfUfJpJ8f51L6XRSwkQiXNOEFTusEC1hkGiNPjAk026udu2LtMH3oR5iyHxtjqHDq
 vUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764017511; x=1764622311;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aThV+OKVdzTcF3kwgT/HsL5o0e5zpvlKw6Ew/DNQnfg=;
 b=Z4ZXpLqY7T/8rNcDhQCeDDqhat7quZY4a3IDw+KW1Wsm7Mz3/CH+C/8jtzJo2PpMa8
 6DZy9XA9Qvl786nz9PbbjjMGUJ0JVg0x/hyQ08w6JdjE+J9tloyMNqhw2ISwbOZOCgXt
 qQ0yxxCb9vgrK5B9HLrzN7lZWjPqalSj4Uz0zCB9a7ykioMwx4FWeRKsQ6LPrrEur5s5
 yMxJGTFFIUDUI68k6OXvtGR0+Ni5WeEg5pudb2JWU6qVueAthoGCe1NLsluhK/7wUNZ8
 TXeQspP+3T5Az6OeKaCOtAAC3chQjZUHyA14e8wNO2h8OKeQZxEnrirlRy+olYKnbLRX
 ETvA==
X-Gm-Message-State: AOJu0Yxh9JHpT8FhmGZ0a359f+1AI5r/wFdK21HYKSoYtqiAZIRJVJn4
 rcj7tPdiowrbiLf0TQr3SI5FqNGXPwM6A53CsCKuBMffWzOw1K7qVh03vmWH5pDG6W9lsoalVeb
 mBhSVla7pb3os40jNSjgW9oK7EhG2e01aHQwSvJYF7bFt+d9UjLO/qWuS
X-Gm-Gg: ASbGncsHjM7QyBT+2+GKz58wHJeRvnm7UpnYOgRnt9fpbVWSviWLL9MrnPQGSeKbwTo
 pQ+qgJgVoPenHyHJsn7S3KbWR+Q34lYTAe2OMh44CFPkVXd+kFHQIlyNWIFgRfpKCv4aaFdrDLc
 puTDEzMsPH1RefJKtHt5lkE/wbiKumFdKDvUz7UWAkoR/Ihxr2kr+8GOH0abbADYSrNcM2nvCKE
 ZMpCIWmfUO5c8QWsSGpegMak/LutoQbhnKSOINNRzLysI7tuHsTHQzwbF70JZ5+4ThFv3XQyqwJ
 f6Lf1KVPdtCm/Qpj7a+THYvolSHMMQi4eGGAzCUWbvi9OkYrXS6GPy8IxY0XnFQKUjh9IUpV8SA
 4PB2PrFTXi7NG3AesGKurJzsVtSIS8A==
X-Received: by 2002:a05:600c:1993:b0:477:abea:901c with SMTP id
 5b1f17b1804b1-477c0184be0mr126040315e9.11.1764017510831; 
 Mon, 24 Nov 2025 12:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg5cImm01lv6szGq4KG6Th4ecjzsGGDfwdBY8Jhxb5QqGB2Ubxhh4Y0HvkOFi4pj4odHZ1JQ==
X-Received: by 2002:a05:600c:1993:b0:477:abea:901c with SMTP id
 5b1f17b1804b1-477c0184be0mr126040155e9.11.1764017510318; 
 Mon, 24 Nov 2025 12:51:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1e872esm213587405e9.5.2025.11.24.12.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 12:51:49 -0800 (PST)
Date: Mon, 24 Nov 2025 15:51:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [Qemu-devel] [PULL 16/17] hw/pci-bridge: format special OFW unit
 address for PXB host
Message-ID: <20251124154615-mutt-send-email-mst@kernel.org>
References: <1435326248-24291-1-git-send-email-mst@redhat.com>
 <1435326248-24291-17-git-send-email-mst@redhat.com>
 <c782890b-1dc5-4ac6-9792-d31a07c2354e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c782890b-1dc5-4ac6-9792-d31a07c2354e@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Nov 12, 2025 at 11:35:21PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Michael and Marcel,
> 
> (old patch...)
> 
> On 26/6/15 15:46, Michael S. Tsirkin wrote:
> > From: Laszlo Ersek <lersek@redhat.com>
> > 
> > We have agreed that OpenFirmware device paths in the "bootorder" fw_cfg
> > file should follow the pattern
> > 
> >    /pci@i0cf8,%x/...
> > 
> > for devices that live behind an extra root bus. The extra root bus in
> > question is the %x'th among the extra root buses. (In other words, %x
> > gives the position of the affected extra root bus relative to the other
> > extra root buses, in bus_nr order.) %x starts at 1, and is formatted in
> > hex.
> > 
> > The portion of the unit address that comes before the comma is dynamically
> > taken from the main host bridge, similarly to sysbus_get_fw_dev_path().
> > 
> > Cc: Kevin O'Connor <kevin@koconnor.net>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel@redhat.com>
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/pci-bridge/pci_expander_bridge.c | 53 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> > 
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index 70708ef..57f8a37 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -43,6 +43,8 @@ typedef struct PXBDev {
> >       uint16_t numa_node;
> >   } PXBDev;
> > +static GList *pxb_dev_list;
> 
> This list is static ...
> 
> > +
> >   #define TYPE_PXB_HOST "pxb-host"
> >   static int pxb_bus_num(PCIBus *bus)
> > @@ -89,12 +91,45 @@ static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
> >       return bus->bus_path;
> >   }
> > +static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
> > +{
> > +    const PCIHostState *pxb_host;
> > +    const PCIBus *pxb_bus;
> > +    const PXBDev *pxb_dev;
> > +    int position;
> > +    const DeviceState *pxb_dev_base;
> > +    const PCIHostState *main_host;
> > +    const SysBusDevice *main_host_sbd;
> > +
> > +    pxb_host = PCI_HOST_BRIDGE(dev);
> > +    pxb_bus = pxb_host->bus;
> > +    pxb_dev = PXB_DEV(pxb_bus->parent_dev);
> > +    position = g_list_index(pxb_dev_list, pxb_dev);
> > +    assert(position >= 0);
> 
> ... and for some reason when calling pxb_host_ofw_unit_address() twice
> it triggers the following:
> 
> Assertion failed: (position >= 0), function pxb_host_ofw_unit_address, file
> pci_expander_bridge.c, line 154.
> 
> Any idea why it got implemented this way and how to modify to
> avoid the assertion? All other devices implementing the
> SysBusDeviceClass::explicit_ofw_unit_address handler don't abort
> when being called multiple times, what is so particular here?
> 
> Thanks,
> 
> Phil.

IIUC what is weird about this one is that the ofw address depends on other
devices.


The fix is probably to scan the list once at machine done time
and save the position in the device.

> > +
> > +    pxb_dev_base = DEVICE(pxb_dev);
> > +    main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
> > +    main_host_sbd = SYS_BUS_DEVICE(main_host);
> > +
> > +    if (main_host_sbd->num_mmio > 0) {
> > +        return g_strdup_printf(TARGET_FMT_plx ",%x",
> > +                               main_host_sbd->mmio[0].addr, position + 1);
> > +    }
> > +    if (main_host_sbd->num_pio > 0) {
> > +        return g_strdup_printf("i%04x,%x",
> > +                               main_host_sbd->pio[0], position + 1);
> > +    }
> > +    return NULL;
> > +}
> > +
> >   static void pxb_host_class_init(ObjectClass *class, void *data)
> >   {
> >       DeviceClass *dc = DEVICE_CLASS(class);
> > +    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(class);
> >       PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> >       dc->fw_name = "pci";
> > +    sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
> >       hc->root_bus_path = pxb_host_root_bus_path;
> >   }
> > @@ -149,6 +184,15 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
> >       return pin - PCI_SLOT(pxb->devfn);
> >   }
> > +static gint pxb_compare(gconstpointer a, gconstpointer b)
> > +{
> > +    const PXBDev *pxb_a = a, *pxb_b = b;
> > +
> > +    return pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
> > +           pxb_a->bus_nr > pxb_b->bus_nr ?  1 :
> > +           0;
> > +}
> > +
> >   static int pxb_dev_initfn(PCIDevice *dev)
> >   {
> >       PXBDev *pxb = PXB_DEV(dev);
> > @@ -192,9 +236,17 @@ static int pxb_dev_initfn(PCIDevice *dev)
> >                                  PCI_STATUS_66MHZ | PCI_STATUS_FAST_BACK);
> >       pci_config_set_class(dev->config, PCI_CLASS_BRIDGE_HOST);
> > +    pxb_dev_list = g_list_insert_sorted(pxb_dev_list, pxb, pxb_compare);
> >       return 0;
> >   }
> > +static void pxb_dev_exitfn(PCIDevice *pci_dev)
> > +{
> > +    PXBDev *pxb = PXB_DEV(pci_dev);
> > +
> > +    pxb_dev_list = g_list_remove(pxb_dev_list, pxb);
> > +}
> > +
> >   static Property pxb_dev_properties[] = {
> >       /* Note: 0 is not a legal a PXB bus number. */
> >       DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> > @@ -208,6 +260,7 @@ static void pxb_dev_class_init(ObjectClass *klass, void *data)
> >       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> >       k->init = pxb_dev_initfn;
> > +    k->exit = pxb_dev_exitfn;
> >       k->vendor_id = PCI_VENDOR_ID_REDHAT;
> >       k->device_id = PCI_DEVICE_ID_REDHAT_PXB;
> >       k->class_id = PCI_CLASS_BRIDGE_HOST;


