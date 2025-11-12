Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC5CCD4855
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 22:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJJRH-0007FB-2a; Wed, 12 Nov 2025 17:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJJR2-00075N-8x
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 17:35:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJJR0-0003Ss-Et
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 17:35:28 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b3108f41fso100639f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 14:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762986924; x=1763591724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1g0NEWhSiHjpehnnY5FpjAg6Ilpau6hRglCYbGcTLu4=;
 b=iNsf1UvhR4frg6ig0tm6Sl0JoYAdwUlarPnpoYtE940M9011zHn8Gcguf/NMavAaHV
 WR49LraD3RE7jQDcUfROmfFRUJtgMtCtDEYHQXbC8JDm9Q3RXKa+7JOoTFLAefu+MZjl
 BnGJLFrHyH/ia6qYHmP5jrOp10ueX4P8tx2gTyLtdo04HEaOBVHGC+GYb6jwdFPZTMbc
 nsAMytebjB9FlWquPsscxhiY3Zl0ga2rGbQKmjddAfSWvf9PmHDAPTVl+t9IzOuzg3U9
 3X9v/xBwcFvmGb884usexfseaTGjdKs1FFZE16cmxTAkG40xQqkISUn2xvGjv0jcLTUr
 R1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762986924; x=1763591724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1g0NEWhSiHjpehnnY5FpjAg6Ilpau6hRglCYbGcTLu4=;
 b=KG9n06mHzmwXm0O8bBDFMlGUWSIYMqlCyQRBxbGu+o1ilPtlkxqQwyH17auiXnEU/c
 owbPRRZp89r3MlhzIRAOfzSZvtyytyQphjgh1Q2f8zoLa7xMsxfXID6gLCuJa4y+VMu4
 p9Wzm7bY5C/SHXe+RjWIx0AkK7IkaMYImdJq8FnU/fAzkbMRsVE/o6MZL0or/O+AaqbJ
 ABoYHnU9t6iyEwWs5n7LlUTkobC+S4eBNHRVYWUdNQpZqEBL9wKdlJruUyO2Udvu3al9
 TQkSq72waPx45YLwSwu+lU25l/UYEPcPDZLCJ2d/BaRfZEzWuteE6kkMEBXneuKuqeWB
 Wpig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOa10YzuEpzU7BM/1ubHOYuen10BeqpMI5BG5Oqd4nf4nUNKhpfW3MDwkGcndlUju69dDZoK0UW94m@nongnu.org
X-Gm-Message-State: AOJu0YyLEBFo3barXWrxch3nVAs8xK9LUliNuQjT3e4pVktI9vkHOYR5
 61dBc3ClSWbgmnZMLUOO42bliD6qV9kqPuRNG+b6n2ZVfHMUGP5sE3x20NMSCDOc/ms=
X-Gm-Gg: ASbGncuocDRYLO9MsZq4qfJ2NAygKcntd4op7Ad+IR1Bb3XrkM+tYe7LPBBhI8ioHR2
 3Qy4awsiA+fxRqYEaQnqMmgi0BYdlPexrxTgCJ5EA1fqR+HBvWrWXPIguRYMEvJFyafKOYJhjk4
 8CvAPxqXsQe302Lupj7gCCiWQtEZGEmoHC2FmNddWAsT4V/5TSmvmvvw4+AR5ypH+ifubliTBgA
 rq0w/mRf2MdvfKs7uhUb1jM1MBQzwHRWG2YIGwthO+oOvU+QCBMXaOZ1ARtyE8IKRU6rKoUuye4
 469GhzVXfeOoVDU1lmKCDNUeLbfsQRp+WxtDyQ5h+gy62imQWO2012hZNTHw3EKxP7BDc2GZhHB
 0HjHt/0s8iCTNO9OdaeIPiqv5ZWdsV+nTcZioI/oSc+AXfCuERwNZW5GYEppfV32wLE02hCS3sq
 6VChRX4ntTpShRxjgunoohiY8aJz6tjiRNZ27OMPHyLHJunDJSYe6blQ==
X-Google-Smtp-Source: AGHT+IEtTCiltdIs7bGHhoHVEhQuC2YCaLu+VlCSh30cf7LIKkTyhglYr4uh8b1FssBNMB4bZ/mX3Q==
X-Received: by 2002:a05:6000:4008:b0:42b:4219:269 with SMTP id
 ffacd0b85a97d-42b4bdb0029mr4543025f8f.41.1762986924424; 
 Wed, 12 Nov 2025 14:35:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84a4fsm169125f8f.11.2025.11.12.14.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 14:35:23 -0800 (PST)
Message-ID: <c782890b-1dc5-4ac6-9792-d31a07c2354e@linaro.org>
Date: Wed, 12 Nov 2025 23:35:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PULL 16/17] hw/pci-bridge: format special OFW unit
 address for PXB host
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin O'Connor <kevin@koconnor.net>
References: <1435326248-24291-1-git-send-email-mst@redhat.com>
 <1435326248-24291-17-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1435326248-24291-17-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael and Marcel,

(old patch...)

On 26/6/15 15:46, Michael S. Tsirkin wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> We have agreed that OpenFirmware device paths in the "bootorder" fw_cfg
> file should follow the pattern
> 
>    /pci@i0cf8,%x/...
> 
> for devices that live behind an extra root bus. The extra root bus in
> question is the %x'th among the extra root buses. (In other words, %x
> gives the position of the affected extra root bus relative to the other
> extra root buses, in bus_nr order.) %x starts at 1, and is formatted in
> hex.
> 
> The portion of the unit address that comes before the comma is dynamically
> taken from the main host bridge, similarly to sysbus_get_fw_dev_path().
> 
> Cc: Kevin O'Connor <kevin@koconnor.net>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/pci-bridge/pci_expander_bridge.c | 53 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 70708ef..57f8a37 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -43,6 +43,8 @@ typedef struct PXBDev {
>       uint16_t numa_node;
>   } PXBDev;
>   
> +static GList *pxb_dev_list;

This list is static ...

> +
>   #define TYPE_PXB_HOST "pxb-host"
>   
>   static int pxb_bus_num(PCIBus *bus)
> @@ -89,12 +91,45 @@ static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
>       return bus->bus_path;
>   }
>   
> +static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
> +{
> +    const PCIHostState *pxb_host;
> +    const PCIBus *pxb_bus;
> +    const PXBDev *pxb_dev;
> +    int position;
> +    const DeviceState *pxb_dev_base;
> +    const PCIHostState *main_host;
> +    const SysBusDevice *main_host_sbd;
> +
> +    pxb_host = PCI_HOST_BRIDGE(dev);
> +    pxb_bus = pxb_host->bus;
> +    pxb_dev = PXB_DEV(pxb_bus->parent_dev);
> +    position = g_list_index(pxb_dev_list, pxb_dev);
> +    assert(position >= 0);

... and for some reason when calling pxb_host_ofw_unit_address() twice
it triggers the following:

Assertion failed: (position >= 0), function pxb_host_ofw_unit_address, 
file pci_expander_bridge.c, line 154.

Any idea why it got implemented this way and how to modify to
avoid the assertion? All other devices implementing the
SysBusDeviceClass::explicit_ofw_unit_address handler don't abort
when being called multiple times, what is so particular here?

Thanks,

Phil.

> +
> +    pxb_dev_base = DEVICE(pxb_dev);
> +    main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
> +    main_host_sbd = SYS_BUS_DEVICE(main_host);
> +
> +    if (main_host_sbd->num_mmio > 0) {
> +        return g_strdup_printf(TARGET_FMT_plx ",%x",
> +                               main_host_sbd->mmio[0].addr, position + 1);
> +    }
> +    if (main_host_sbd->num_pio > 0) {
> +        return g_strdup_printf("i%04x,%x",
> +                               main_host_sbd->pio[0], position + 1);
> +    }
> +    return NULL;
> +}
> +
>   static void pxb_host_class_init(ObjectClass *class, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(class);
> +    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(class);
>       PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
>   
>       dc->fw_name = "pci";
> +    sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
>       hc->root_bus_path = pxb_host_root_bus_path;
>   }
>   
> @@ -149,6 +184,15 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
>       return pin - PCI_SLOT(pxb->devfn);
>   }
>   
> +static gint pxb_compare(gconstpointer a, gconstpointer b)
> +{
> +    const PXBDev *pxb_a = a, *pxb_b = b;
> +
> +    return pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
> +           pxb_a->bus_nr > pxb_b->bus_nr ?  1 :
> +           0;
> +}
> +
>   static int pxb_dev_initfn(PCIDevice *dev)
>   {
>       PXBDev *pxb = PXB_DEV(dev);
> @@ -192,9 +236,17 @@ static int pxb_dev_initfn(PCIDevice *dev)
>                                  PCI_STATUS_66MHZ | PCI_STATUS_FAST_BACK);
>       pci_config_set_class(dev->config, PCI_CLASS_BRIDGE_HOST);
>   
> +    pxb_dev_list = g_list_insert_sorted(pxb_dev_list, pxb, pxb_compare);
>       return 0;
>   }
>   
> +static void pxb_dev_exitfn(PCIDevice *pci_dev)
> +{
> +    PXBDev *pxb = PXB_DEV(pci_dev);
> +
> +    pxb_dev_list = g_list_remove(pxb_dev_list, pxb);
> +}
> +
>   static Property pxb_dev_properties[] = {
>       /* Note: 0 is not a legal a PXB bus number. */
>       DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> @@ -208,6 +260,7 @@ static void pxb_dev_class_init(ObjectClass *klass, void *data)
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
>       k->init = pxb_dev_initfn;
> +    k->exit = pxb_dev_exitfn;
>       k->vendor_id = PCI_VENDOR_ID_REDHAT;
>       k->device_id = PCI_DEVICE_ID_REDHAT_PXB;
>       k->class_id = PCI_CLASS_BRIDGE_HOST;


