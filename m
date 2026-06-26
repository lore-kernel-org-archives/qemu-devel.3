Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A6CDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3pA-0001uC-3D; Fri, 26 Jun 2026 06:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3p9-0001tp-2l
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3p7-0007W5-Jz
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hdCjlxiFBx9/zc+80TcpxnpCdt7PrSwe3SjHpkdscPM=;
 b=Z/0gHocNx2Y1TlGlf1i6GJvyoGn3FWBTnfCv3pcXUA5x+Pi+e/h57hvkN3/vwvWU12mKKo
 M5Y+io/fCNtFOhJsyHO1/tLrbQb6hKJVydL+V9S9EKk5dbumh9MY3fammukR4R69PdzFko
 zovJTntPUEEAVH0xo1I2dzGU4Aa5EEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-72k-OtP8NFyhJGq6aldbdg-1; Fri, 26 Jun 2026 06:30:09 -0400
X-MC-Unique: 72k-OtP8NFyhJGq6aldbdg-1
X-Mimecast-MFC-AGG-ID: 72k-OtP8NFyhJGq6aldbdg_1782469808
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4924583c7baso9582065e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469808; x=1783074608; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hdCjlxiFBx9/zc+80TcpxnpCdt7PrSwe3SjHpkdscPM=;
 b=GhKfxNytHZ5KJeeL6cNSKxPX43i/AABr9B/6P1IBMjq4m1l//mnxwCbGBkxeLGlBCV
 apEXgQZzpMimxIGc/2CJEE6qvY36fE4y8utk2Eyq4md+0p5CKlyskQ09tWBgWVbSxryH
 fX/AC6xBFUW7SKodEoMBv7tpEOdfH91M3iwwbFsCVGBoi52X9f8kJWYY46PSKvR4l9Yt
 pCIMLw131q3EN/qFRrM0bmX3qhAX4WhVwYm20A65ovmd+OliAZFOVR7lGXHNyXFUQCMk
 OD9ylJgdO29HUeZ6PIy3liwjtD+Wixj+lYzKtjqqdbWIMVnFyGAZUW8oCVzIawbmECCa
 mzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469808; x=1783074608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdCjlxiFBx9/zc+80TcpxnpCdt7PrSwe3SjHpkdscPM=;
 b=I4mq/KS7WbLe7dRZjmtZxCapG5Mw4WsN/IHHUQCdQcmkcqijGfOoCtuEXZz9oeevDN
 1jdl1vQdgvhNGOxJdIPA9Lt3EAKuRzV5v99GnlME+/tvAygd4T5zyb3mmplpB5ADFFTH
 W3uN5FGru2hgtPqDi0BCU2P4ubyJH3u/cOeXRHa9+E1QMyD3DN+4YI7Y7DN0ko//2hGZ
 9rLcYK8KJ9V0MUdb+0qcCSmsapbbuO81iWbQNH/n4Yg+40GzNQ6ZFMfkGCzR5PCSyOxC
 LK+W7wbm+CLB+nL0tOsz/UjLMlbpMxcZ18C088YvWTMVUhsEYdH83R6ZWINpBpvRC6tz
 s+8w==
X-Gm-Message-State: AOJu0YwPLgDmsGzddEyayc5A13h0NbFi+bRpqnJhMF4912rhRWeq6Uty
 eBieQVtkO91Y1pcy+WB87yDB+fb2MOJWxtHIkmWboUG81tLQQLgqJzdBv+kW0Cx5dPLMfnyXMmT
 yQepdjXl4VyKDUYPsrTNnuBCovMUFxuHrgS+heGCobUO2ioWjtG4bQgwx
X-Gm-Gg: AfdE7clKh9iYYFuaMeNgSSfcAp8AkyyqsfCEJU/v80eHLHrjLlxelFocrj+sM8a+Llm
 le6ZnrBu47mY3XodmIVJtbJUXKSwixTTbrMJ6M3Iwl4bDJAV21zl/CSdW9f6TaoFoJcm8Cj3PDL
 2lOYNy1ZRpqUPC9p7DVzi6/yQ9tgxmG+TE/KmvFNwJqSY8LoiftW8YhyFZkHC5DcxkcgVFJ5vKG
 GZO+lI2q6xavVnMSq8dT2tMZ1m4TTRWStF/2KHw97xleA0TpvrCaKeGqT1m0OgsKubxGomvGWLU
 tvyMiODF0/e/OvJ9iIukjIxuBU6IuLB3MeO9GvwmVvyi5qfUOfVZPoHdCwo0T9RCBxOap+WWJRP
 QBeuZcSDb0pAXtS8q8vhll803kNHg+Q8xMp1Gt3ta/Q==
X-Received: by 2002:a05:600c:4e0b:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-492668933d8mr92968515e9.33.1782469807759; 
 Fri, 26 Jun 2026 03:30:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0b:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-492668933d8mr92967615e9.33.1782469806964; 
 Fri, 26 Jun 2026 03:30:06 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fce5a8sm67222015e9.3.2026.06.26.03.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:30:06 -0700 (PDT)
Date: Fri, 26 Jun 2026 06:30:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 K S Maan <kirandeepmaan45@gmail.com>
Subject: Re: [PATCH v3 3/7] hw/pci: Introduce rom_need_patch_id flag in
 PCIDevice
Message-ID: <20260626062957-mutt-send-email-mst@kernel.org>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <20260617100646.28326-4-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617100646.28326-4-tomitamoeko@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 17, 2026 at 06:06:40PM +0800, Tomita Moeko wrote:
> Allow external code (e.g., VFIO IGD passthrough) to request PCI ID
> patching for a custom romfile, replacing the existing is_default_rom
> flag for this purpose.
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci/pci.c                | 14 ++++++--------
>  include/hw/pci/pci_device.h |  1 +
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 8e7872523a..b4235834a0 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -352,7 +352,7 @@ static const TypeInfo cxl_bus_info = {
>  
>  static void pci_update_mappings(PCIDevice *d);
>  static void pci_irq_handler(void *opaque, int irq_num, int level);
> -static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom, Error **);
> +static void pci_add_option_rom(PCIDevice *pdev, Error **);
>  static void pci_del_option_rom(PCIDevice *pdev);
>  
>  static uint16_t pci_default_sub_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET;
> @@ -2257,7 +2257,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>      PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
>      ObjectClass *klass = OBJECT_CLASS(pc);
>      Error *local_err = NULL;
> -    bool is_default_rom;
>      uint16_t class_id;
>  
>      /*
> @@ -2370,13 +2369,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>      }
>  
>      /* rom loading */
> -    is_default_rom = false;
>      if (pci_dev->romfile == NULL && pc->romfile != NULL) {
> +        /* using a built-in default rom */
>          pci_dev->romfile = g_strdup(pc->romfile);
> -        is_default_rom = true;
> +        pci_dev->rom_need_patch_id = true;
>      }
>  
> -    pci_add_option_rom(pci_dev, is_default_rom, &local_err);
> +    pci_add_option_rom(pci_dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          pci_qdev_unrealize(DEVICE(pci_dev));
> @@ -2555,8 +2554,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
>  }
>  
>  /* Add an option rom for the device */
> -static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
> -                               Error **errp)
> +static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
>  {
>      int64_t size = 0;
>      g_autofree char *path = NULL;
> @@ -2654,7 +2652,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>              return;
>          }
>  
> -        if (is_default_rom) {
> +        if (pdev->rom_need_patch_id) {
>              /* Only the default rom images will be patched (if needed). */
>              pci_patch_ids(pdev, ptr, size);
>          }
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 5cac6e1688..8b9b6470e9 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -157,6 +157,7 @@ struct PCIDevice {
>      char *romfile;
>      uint32_t romsize;
>      bool has_rom;
> +    bool rom_need_patch_id;
>      MemoryRegion rom;
>      int32_t rom_bar;
>  
> -- 
> 2.53.0


