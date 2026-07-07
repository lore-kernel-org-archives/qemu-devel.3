Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F27C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2uf-0000Za-0r; Tue, 07 Jul 2026 06:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh2ud-0000ZQ-Ot
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh2uc-0004fH-AF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783419620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8B4zzPsLef8mehjbVzmOYQnyc9I3V+Z9J5fDs3Xg2KA=;
 b=LGWGkhOGW3W7I6EgurHP5hnvjmVd8PgImNvWzfv1VdANRSZo6jtilFVcPB8cCAkMa9W2tL
 jhVZZbTBxSDMobaWBUYhQBUlapR9Et1ewK8tKWzDQRZpkyq6x6pHBKsVsNU1UCJA032SMT
 NMP9Lhu4WqIUGZt3WpQxCAFl7k02Kyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-vRwfhcdyMyWD36NblEQ2bA-1; Tue, 07 Jul 2026 06:20:19 -0400
X-MC-Unique: vRwfhcdyMyWD36NblEQ2bA-1
X-Mimecast-MFC-AGG-ID: vRwfhcdyMyWD36NblEQ2bA_1783419618
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493c619bb52so28456965e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783419618; x=1784024418; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8B4zzPsLef8mehjbVzmOYQnyc9I3V+Z9J5fDs3Xg2KA=;
 b=uBsH8Ll3up7t2z0nA3bpvT4s305ERDvG3TSrKtgO8cQd8T9fuXlqAzIx63EPkBGRFB
 LhdiOy4SdYb8BqLyaSC11vmufBo1iQ13v7pS/pVBACs3e/PguSOWjW0wR06uJOyj0E5u
 ktba7/wxXTPTzZd/aqDf+/MAeqKEgDpyZRpLARTSejSCS7SoiK+OsdPmZy4fnSuVr/ga
 yWkXOJKhh8/YMLNU0zX8qFF7fgiDgEahpnya0bAehEIkEr52Yf6xokIUeiuQM0GDXaS7
 435lBdx2b7BPdIXHmV43GBhZTYbnzI1Ro54N5Fs8vqb0mEtHYFXAYSqvhf+Kh/JFiRAn
 YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783419618; x=1784024418;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8B4zzPsLef8mehjbVzmOYQnyc9I3V+Z9J5fDs3Xg2KA=;
 b=Iqu2A35TM2C5MLR+RhktdhUfwL/mLZ8SeMOseqYyaievX36c5HxPwKpzdg1DfFsfeU
 /Mk9+W+vzeIapWmwSociYXS9EOhRBDtau1O/vEo1aV3nXmVKWtllHOoynia3NqEjB++j
 kDNy7nS51nRBpPP9XLbCeIkvdGCg3UUk23RZL7cG7zX1AtDJasav/nOaJTEj0P95MfLO
 qPjg++c4YNVM/9jIp7qHJN2sMgqs/fPOVGwJMtXW+LOc9J4Bch57qGxQbveq8iSo7CpJ
 2Fsb2kJbRWXZxRTfnGyANavcEB/wLxc2LxWa+pKULpDQ2gkvLlLSL5sy4NunPIzKFyLD
 fDuw==
X-Gm-Message-State: AOJu0YydZEbjNQh5C1zTwAvgHFZbij+dAJZ7ceUa53wlHW2wyXq72orw
 IAFF8cRecsQiz4dtzbJ+IwXI8gIfFYQFPEvjSO8RN2IfE+WD/IEHqD0yOEcEG/+HNIMF4YTholo
 Vxag47C4NbXGGuOdvD3Udg2VLMn319uGwCGF/cc6+c6r2Qm7yG6Y0yRQ2
X-Gm-Gg: AfdE7cl6ysy3NZZWh5k7xnDnQVsZs00l0pTOpTAqDAdaLJUuyMahR4ACQ9xwrcrtMqa
 uAp8+oGb/MFl62bAqDnQe3qmxVGivIllr+Y+BW5kISKclRanCjtlXBU0Fh2mK14gYbIqdIY33Lt
 2uxzXZXK+g70YTzI073dXi6OPMDU+f5l5J3O28ouFlXnt9eav1lBEKN1E5TKxfQnuEItsC6zvat
 ghBpmskqXiygE/K/yPmecz2BGAcQSdhEz4NttA8jivxKam75zuv8p8Iamc2rcDQwEMmj24D+DS+
 zcgxAaMW/lwP+yz2gGCa4SCkzBtkHT4krYjFqe5/JdnHmXuEcAyK6rWPrIzBtAKWcTx5+T/Lq/D
 Cpmvo2ulqFqurduyt/sKb2K1MhkvDwhbJ
X-Received: by 2002:a05:600d:4452:10b0:493:e3e9:85fb with SMTP id
 5b1f17b1804b1-493e3e98622mr5084385e9.20.1783419617658; 
 Tue, 07 Jul 2026 03:20:17 -0700 (PDT)
X-Received: by 2002:a05:600d:4452:10b0:493:e3e9:85fb with SMTP id
 5b1f17b1804b1-493e3e98622mr5083835e9.20.1783419617035; 
 Tue, 07 Jul 2026 03:20:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f3677asm41165115e9.4.2026.07.07.03.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 03:20:15 -0700 (PDT)
Date: Tue, 7 Jul 2026 06:20:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] hw/pci: Consider reserved slots mask when checking
 PCI bus is full
Message-ID: <20260707061902-mutt-send-email-mst@kernel.org>
References: <20260707084050.32137-1-philmd@oss.qualcomm.com>
 <20260707084050.32137-4-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707084050.32137-4-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 07, 2026 at 10:40:50AM +0200, Philippe Mathieu-Daudé wrote:
> Do not consider reserved slots as available.
>

Philippe this is not how commit logs are supposed to look,
just repeating what the patch does with no explanation.
You know that.
 
> Fixes: 8b8849844fd ("pci: add reserved slot check to do_pci_register_device")

especially if it's supposedly a regression?

> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  hw/pci/pci.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b04e94a150b..2e5412137b3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -62,6 +62,7 @@ static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset_hold(Object *obj, ResetType type);
>  static bool pcie_has_upstream_port(PCIDevice *dev);
> +static bool pci_bus_is_full(const BusState *qbus);
>  
>  static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
> @@ -293,6 +294,7 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
>      k->print_dev = pcibus_dev_print;
>      k->get_dev_path = pcibus_get_dev_path;
>      k->get_fw_dev_path = pcibus_get_fw_dev_path;
> +    k->is_full = pci_bus_is_full;
>      k->realize = pci_bus_realize;
>      k->unrealize = pci_bus_unrealize;
>  
> @@ -1329,6 +1331,21 @@ void pci_bus_clear_slot_reserved_mask(PCIBus *bus, uint32_t mask)
>      bus->slot_reserved_mask &= ~mask;
>  }
>  
> +static bool pci_bus_is_full(const BusState *qbus)
> +{
> +    const PCIBus *bus = PCI_BUS(qbus);
> +
> +    for (int i = 0; i < PCI_DEVFN_MAX; i += PCI_FUNC_MAX) {
> +        if (pci_bus_devfn_reserved(bus, i)) {
> +            continue;
> +        }
> +        if (pci_bus_devfn_available(bus, i)) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
>  /* -1 for devfn means auto assign */
>  static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                                           const char *name, int devfn,
> -- 
> 2.53.0


