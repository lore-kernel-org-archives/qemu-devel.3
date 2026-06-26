Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B4DCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3p1-0001kE-BG; Fri, 26 Jun 2026 06:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3ox-0001iv-5v
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3ou-0007H4-Am
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ND4zOm/5bmQl4bcmBHmG2VHK3pqfekC3lcEb4oPH36o=;
 b=FHyj0JtzITINESuaT5MH8HS2tK7+fryRqejq5Tw3LGhoyT+VIm7uF0dOkUgLmhiP+qQgOo
 zxq/I7Px6ElDwlFvHQNqWxNwZVwWb1cBXBxOwGExLupjJrGlxZ0q9s0QT/K9ph9LNkjl9n
 PX7AOg7ENg/OL/vo5BueWLSgp/J1kyM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-3p9oGA9tMUqI7S9Nlgp3Ng-1; Fri, 26 Jun 2026 06:29:56 -0400
X-MC-Unique: 3p9oGA9tMUqI7S9Nlgp3Ng-1
X-Mimecast-MFC-AGG-ID: 3p9oGA9tMUqI7S9Nlgp3Ng_1782469795
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so5632375e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469795; x=1783074595; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ND4zOm/5bmQl4bcmBHmG2VHK3pqfekC3lcEb4oPH36o=;
 b=kQtouPr93B467dVQDPGvKiSpYlJr7HC5swAD38qXYBCjZz67GTwtg2gFHpPpaEJ9AN
 0eJreHYHQzgWqGCpGy0mhYhTjEPBHhvWsDby/fu1R22vSZcN/bcl+evwxze5rBmPKBhJ
 WG+6l4KXc40JPYsQ2X4Bwcv1ow1yMWgLwT0oXYpTD0Nqezo0is7HksleghSrpoKgANle
 rqfLyCFBZoUQyv/dnQ4QYruXHZ3eb4IvjubajjjOON/XL3M78Ncr3Ys1tE4GA4Mahs1j
 63kMl7p1nr5eWb++qE4d1ys4thBIXD4qNPKtAWT+tnrYPS9U5wrf6ASCFcRYTi16fl0k
 Bqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469795; x=1783074595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ND4zOm/5bmQl4bcmBHmG2VHK3pqfekC3lcEb4oPH36o=;
 b=dln1akMWbxyL0hL0vVNVzZILrMYlktKz8Hnv8VL1gkmS1Z/VT0pOz2TOISEgoYkA8T
 /uL9OewhTr3JtnydYVgHv7Mg02WsK+ZFA2Hb0DKG8qFmz0ru/ydzsHJspD3yaoTs31yX
 F30TeTKIs4g+sLwxQ9e3W78c+qEF58G4A8YEdpQoQyu0bcdnApuVSfW6sWa9MZv4XTUo
 l4UFT0IRRcUAHkCaHTe5Tu/dHpius1LAcamiJpFwNQeggyAWbKZ5xKQrrC8Wlw/08+RU
 gkiwYhFC6hG/1O9+Ix1fBelLFNczHVjMCprVcvtvZ/Bk2K16EWJEBR8qf1oR69M5h56K
 Wrhg==
X-Gm-Message-State: AOJu0Yy7yiIQcbSpvilbREvplYOymW8wsNLmLHwytoUWI6Apvo6xCj37
 NA8LOPv2gKqM2sf5y+L4qZtz4c9od9eR7f/AIMqOUZhSOADmpxP+xgu6j1B2/aPdmCFo3yVKqYi
 zy8UE8nkVdhRic61H/SIOttwzX5gZMLtITdG0aF7m0WzbnKXcxNVyFDLj
X-Gm-Gg: AfdE7clMikuF1GzRRSPglTs+nTZKhdtucC9H6LpbZRBKydk7Gz1g2RAqk5TlSRkAkRY
 mtC2EtYDchue3v4RzPYbI0c2rGEsWk35TwQs1uKmO+1r/9EUGxJYLH42X84cSaKVb4h4ya8FwcD
 L0R6Lh6Xhlp+qOYFxO1C6Vge6eQFEnzhQcagSuALPEiPNuu9wfbdBgKuVhYMGx1z/aAde/dycNq
 1fGHKI2XKGfzsKwJ/ybzB2gaaShHpm6w/xpHVwAVrFJgVb30DLoBN1jwKOFoVpi0d6jFFqJ3SKB
 qTIM0w4agjs7UwsVHY9nh/9OK859M/MpU5Khoy1M2XKnAMciolja1qyF71GO0D32RRJPkpityzV
 ZUwPv9eWh7KOtMiFZAP164e9FULGyCDI4IxeGm5B12w==
X-Received: by 2002:a05:600c:3483:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-492668561d8mr94475605e9.16.1782469795284; 
 Fri, 26 Jun 2026 03:29:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3483:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-492668561d8mr94474925e9.16.1782469794734; 
 Fri, 26 Jun 2026 03:29:54 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e95f3d71fsm7388264f8f.12.2026.06.26.03.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:29:54 -0700 (PDT)
Date: Fri, 26 Jun 2026 06:29:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 K S Maan <kirandeepmaan45@gmail.com>
Subject: Re: [PATCH v3 2/7] hw/pci: Skip EFI option ROM in pci_patch_ids()
Message-ID: <20260626062946-mutt-send-email-mst@kernel.org>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <20260617100646.28326-3-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617100646.28326-3-tomitamoeko@gmail.com>
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

On Wed, Jun 17, 2026 at 06:06:39PM +0800, Tomita Moeko wrote:
> pci_patch_ids() patches the checksum at the reserved 0x06 byte, but
> for EFI option ROMs the 32 bits at 0x04 are the EFI signature and
> must be 0x00000EF1. Since OVMF does not check vendor/device IDs in
> the PCIR header or the checksum, skip patching for EFI ROMs.
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 601d65aef3..8e7872523a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2513,11 +2513,16 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
>          return;
>      }
>      pcir_offset = pci_get_word(ptr + 0x18);
> -    if (pcir_offset + 8 >= size || memcmp(ptr + pcir_offset, "PCIR", 4)) {
> +    if (pcir_offset + 0x14 >= size || memcmp(ptr + pcir_offset, "PCIR", 4)) {
>          trace_pci_bad_pcir_offset(pcir_offset);
>          return;
>      }
>  
> +    /* OVMF won't check IDs in PCIR header, skip EFI roms */
> +    if (pci_get_byte(ptr + pcir_offset + 0x14) == 0x03) {
> +        return;
> +    }
> +
>      vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
>      device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
>      rom_vendor_id = pci_get_word(ptr + pcir_offset + 4);
> -- 
> 2.53.0


