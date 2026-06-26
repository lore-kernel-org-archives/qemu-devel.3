Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187BACD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3pd-00021q-Ng; Fri, 26 Jun 2026 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3pb-000204-Ay
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3pY-0007cX-K1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1Djf3EcwAN9Do0rul/OjRYpxU1vnTsyHTIkOoXG8Zo=;
 b=GbFSASKhisDI3pVZC6Tws5OwSe2zvgq3qPdJXb8zH8ktmSQznPu9RG3X/p6mPgHE3UaMgr
 XRm2HBynJM0gh+bb3+1asmnoRQfaHUr9lb13LzFseE9evW+WTjkL0ffEKEC/tFybDYZfxk
 vuGFqvaWI+6hkAc44D4760bKy8GkGlg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-QffTPGYVPXqDialKw4LM4A-1; Fri, 26 Jun 2026 06:30:38 -0400
X-MC-Unique: QffTPGYVPXqDialKw4LM4A-1
X-Mimecast-MFC-AGG-ID: QffTPGYVPXqDialKw4LM4A_1782469837
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-46d71a1791fso519121f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469837; x=1783074637; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C1Djf3EcwAN9Do0rul/OjRYpxU1vnTsyHTIkOoXG8Zo=;
 b=X8GCty5TYhVrODi2+wfjLmnFF9L1loqYpQDuZ71YoZti/4lJKLu3QHL4ELW2tkCaaz
 y+QL0lDZuz4BLV3xZ3nGsVo8CZgEg9qPO1QezjSxLMZK/8z3CKHrOJDabEXtFh13Q4w0
 eoFyPiRyRpOB1kpM4gWibt4ir3Ib4G1UtM9PPSg+hOMsCXBKlZdBOZZkWDgNagOVoejJ
 gKpRWo2goCYFVTcGgSWqAmC9y6BFcQi31+6xiXa8hO4uCx5Nb3eBPr0O101hq8jcs/Nw
 ip94s8SLZcqFHKWZT+JhfShM7EIq4spiVNB9s7CUap/Cg/6PgYVhpB8JIDr/OVG58e3/
 1UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469837; x=1783074637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1Djf3EcwAN9Do0rul/OjRYpxU1vnTsyHTIkOoXG8Zo=;
 b=Hlua/VOY9NeSdPU5yX6hqpJs41JI7b0PRwk9tcXwiykU7Oe0Dc6mOi3VQWhitTs1AE
 TkTNF32jBOfyslbYOqi38ZgR9xP0YGUze8Cgk0v5BkWlY051txonCI8M9+svI3/0Repp
 qqtLW8QMznOwKdvqB7ZQ3BgIW1ubNJGh0c63PRPUot3rYpPolRmhrXSX5X0kXVEob5rm
 vBVvD5fEG2sgqBArccD7TvpHA0rGL2f1rqts1kCBmmn/lpXvmw9Zlf5z53skfrkysOL1
 HaDWLrY1x3ULAGjEN/+v4GbS2bdxcmxuMCRrb2JqqhYK7PakZPbHlQs/+knmHOjqQXJ4
 AinQ==
X-Gm-Message-State: AOJu0Yz5qFmXA6nt5rm3Nkecaxz9POEHDdRvTZ+/EDfQoD5uhhM5Vt3f
 2kfqlLbYH0tkTDBlPZhHkw8vpvciKSY7uwXu6itgQeBfClmJUGKe66QW0sntmQ5n+PCmdm3nSir
 YuS68wh3hhm4Nh6YmgKfsXNzllbKInWa7vCM807M5dDM01BRAkv09nII0
X-Gm-Gg: AfdE7cl8OjuABVVPz9yV/Rq6SudIsnmv0CHY/h45sMf3gCYktFfyMTal9S+oPfJnH/l
 YwTPcSaaFSPslPi1Dd57tL13Eoso6zzItUmA+XoihSjhGvXat1hQIS57GfwTCZWlzExLCa79GdA
 wrV0BbFWs5LqLHBWC31qZdlMDc8udsrN5RwrDqAekUlNDVDOrbNQxZ3YhAZIY3L5HRJwU5FpFsi
 hTtXdOX2c8/LHNlpN+kicZPUsMlvBUcnbTiAL6Jh/sAK5RindMv+5KnNvnJwwYjxpB2o51JLHJR
 GnjtPZHHJ+R7ucwXjU41o0Lxa1lg7bbVZtcMV2K584tv7UF3hAGXJyf3kmKiL2UywdIj/WUFxNa
 C+tzjKAuSFHYrpY2jONL13ds99iHrzK+XyeHJQScHhg==
X-Received: by 2002:a05:6000:4901:b0:46d:2c51:63d4 with SMTP id
 ffacd0b85a97d-46dc398a28dmr10562357f8f.41.1782469837154; 
 Fri, 26 Jun 2026 03:30:37 -0700 (PDT)
X-Received: by 2002:a05:6000:4901:b0:46d:2c51:63d4 with SMTP id
 ffacd0b85a97d-46dc398a28dmr10562307f8f.41.1782469836643; 
 Fri, 26 Jun 2026 03:30:36 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d46sm22096732f8f.13.2026.06.26.03.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:30:35 -0700 (PDT)
Date: Fri, 26 Jun 2026 06:30:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 K S Maan <kirandeepmaan45@gmail.com>
Subject: Re: [PATCH v3 4/7] hw/pci: Promote pci_patch_ids() to public
 pci_rom_patch_ids()
Message-ID: <20260626063026-mutt-send-email-mst@kernel.org>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <20260617100646.28326-5-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617100646.28326-5-tomitamoeko@gmail.com>
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

On Wed, Jun 17, 2026 at 06:06:41PM +0800, Tomita Moeko wrote:
> Remove the static qualifier from pci_patch_ids() and rename it to
> pci_rom_patch_ids(), adding a declaration in include/hw/pci/pci.h so
> external callers can reuse it.
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci/pci.c         | 4 ++--
>  include/hw/pci/pci.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b4235834a0..92d4e71c04 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2492,7 +2492,7 @@ uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
>  
>  /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
>     This is needed for an option rom which is used for more than one device. */
> -static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
> +void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
>  {
>      uint16_t vendor_id;
>      uint16_t device_id;
> @@ -2654,7 +2654,7 @@ static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
>  
>          if (pdev->rom_need_patch_id) {
>              /* Only the default rom images will be patched (if needed). */
> -            pci_patch_ids(pdev, ptr, size);
> +            pci_rom_patch_ids(pdev, ptr, size);
>          }
>      }
>  
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 2d8a4ad0eb..298e0e6c31 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -1104,5 +1104,6 @@ void pci_set_power(PCIDevice *pci_dev, bool state);
>  int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
>  
>  uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size);
> +void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
>  
>  #endif
> -- 
> 2.53.0


