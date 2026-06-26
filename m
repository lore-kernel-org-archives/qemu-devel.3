Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A22CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3j3-0007lh-33; Fri, 26 Jun 2026 06:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3iy-0007lR-6P
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3iw-00061B-MP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9YIyqFrkv0d2IGlXZEOTHX7qMOBttJwoIjnhpWtz6c=;
 b=GzTm3hXri1GMKwkiKvEWZe8hteof4PQmow+XejRRFH7h2w1DCJ9QYcux4xwDlv7X4u/Alg
 LiwAN+H8nRyPb0GZG5QuWvcxPqspNqNLnSk5Cu87CAEVyUl3/fJa56UsWk/dkQGwH7ZnlG
 XC3R1B61oe0bUUtZsHaWxFrQb6G12B4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-tJXJwmk9N56es8ErC3sesA-1; Fri, 26 Jun 2026 06:23:47 -0400
X-MC-Unique: tJXJwmk9N56es8ErC3sesA-1
X-Mimecast-MFC-AGG-ID: tJXJwmk9N56es8ErC3sesA_1782469426
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so5412325e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469426; x=1783074226; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u9YIyqFrkv0d2IGlXZEOTHX7qMOBttJwoIjnhpWtz6c=;
 b=FZ9QYGWqXjLvkX/jVK+fIsbNNORTqOAHf2IDH87c0yBgk9J0ssu1W/CPEUUHFUECQ1
 q9/Pc7oVfW8IHTQuOzh+XXmdCKnvoYKrX6aNT8RLMMZtyfq3JFVEIPgn5RAEWIMeMuGP
 xhNPlcvaPi0MX4EVmA9JlhHxx9OWezHO7tD4egf45u4fUpvo+6Y6pU9nu/Cfg3CL4GOJ
 Ad2HIua5dWsQEEQJaBg9VUazIgPwYD19YBW23N8drSr91O2KR/hW63Ps+uI8v64rqYyU
 TiTw23GalcPcw3JnJig4DdPlw198pFxvclPF3s4TUwMujD7A95Bm1vms9jeIdt0FvC+W
 gphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469426; x=1783074226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9YIyqFrkv0d2IGlXZEOTHX7qMOBttJwoIjnhpWtz6c=;
 b=iPOqDfiOjXL43tmLfhLoP4xXiyEF6AGtGPBDRea5w6nNH2znjveYoeql1s8a+5xAq6
 eYDx/omayzfg3hqax63lDHFZLQRwh7hy84IEKFAqiVHN1Or47oi0XbuOUaxFyF1zZ0+B
 VBJgcp8UgtMB2344uen8n38eYAnpi0Rj7LYIsd/yzIsQoQcDCNiCWSnt7v6kh1U348Hk
 Le90nfK8Vp3Fkk152hZ3otdoMPJmbwZfJ5sfYzkSNYHBF5cSFO6uDoK8MpJ71fEEtYpF
 Y1BIGsIqEBVnZJ9PGkJ5HKadIBTYXmx9pi+/0CKR2EMBSIt/Ojb+jkQHmmFLYaNQGX5E
 fPrA==
X-Gm-Message-State: AOJu0YwYlwKTcl7PdflyPms/car6d2z4eavVl5l5SoTSQv0BPPS4tLfv
 IoA8fC+h4dr6D2GfOxM0bxY5OQRjXANlV0q3XC8Yl4eGDuMrch2Qnnl2W/W6BHNNbIlFQ5O3bhA
 L1cBiWgtS/4BXxeMszNf/Fip1Kxn9pomMzoCJk8uD8B93wpaH3VtJcEv0
X-Gm-Gg: AfdE7ckKTklOs5Ut/M1X85+uD9dSQGKJN/ABUb3azKbSZbTEGeA2PwjGuq7s/Nn+/qS
 yBSpXfNCf/LOCzMUNqXIn0M83Hec982c9yJPpjJXOTIoRDzydvp6yHYHjJEtATp8QrxXKPRNoJ6
 Ly8W+efRuaK3JmnqgFOSi2HFp2LGzNNWfZ3sFKMxNdbfgmf4ZX5B5Kh6HXmqHc97WEnUCoEZn0h
 UTe6s5HE8N45EbrCj4FY2GCau6UCqBQZ2IcDnpl/rs1G/JnJqeDFhnWNNbJia4xmGFyJmAgYM4V
 oR60q05li77siPtLBoeoO2neiOI7Uwpfn4jrKnak6sSEop+IL98N9HWr0WzvaZFWU57DPUWn8UN
 Sjng0DRylyT0Yxvmhfa/TMIFVYgzJVUWFPSE5/i0Kmg==
X-Received: by 2002:a05:600c:4692:b0:490:4b89:535d with SMTP id
 5b1f17b1804b1-492668677ebmr97019665e9.1.1782469425530; 
 Fri, 26 Jun 2026 03:23:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:490:4b89:535d with SMTP id
 5b1f17b1804b1-492668677ebmr97018985e9.1.1782469424909; 
 Fri, 26 Jun 2026 03:23:44 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fde98csm72947955e9.6.2026.06.26.03.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:23:44 -0700 (PDT)
Date: Fri, 26 Jun 2026 06:23:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 K S Maan <kirandeepmaan45@gmail.com>
Subject: Re: [PATCH v3 1/7] hw/pci: Recalculate option ROM checksum before
 patching ID
Message-ID: <20260626062248-mutt-send-email-mst@kernel.org>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <20260617100646.28326-2-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617100646.28326-2-tomitamoeko@gmail.com>
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

On Wed, Jun 17, 2026 at 06:06:38PM +0800, Tomita Moeko wrote:
> pci_patch_ids() only adjusts checksum based on the new IDs. For an
> option ROM with invalid checksum, the patched one will still have
> an invalid checksum. Always calculate the checksum and patch it if
> necessary to ensure the option ROM is valid.
> 
> This is intended for fixing the romfile used in IGD passthrough as
> multiple IGD devices share the same rom with possible non-matching
> device ID, and its checksum is known to be bogus [1].
> 
> A helper function pci_rom_calculate_checksum() is added and exported
> for reusing in IGD-specific quirk later.
> 
> [1] hw/vfio/pci.c:1090
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>

This seems very aggressive.
Why not recalculate in vfio then?
It has a chance to do a targeted fix.

> ---
>  hw/pci/pci.c         | 32 +++++++++++++++++++++++---------
>  include/hw/pci/pci.h |  2 ++
>  2 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index cec065d108..601d65aef3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2479,6 +2479,18 @@ static uint8_t pci_find_capability_at_offset(PCIDevice *pdev, uint8_t offset)
>      return found;
>  }
>  
> +uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
> +{
> +    uint8_t checksum = 0;
> +    uint32_t i;
> +
> +    for (i = 0; i < size; i++) {
> +        checksum += ptr[i];
> +    }
> +
> +    return checksum;
> +}
> +
>  /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
>     This is needed for an option rom which is used for more than one device. */
>  static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
> @@ -2514,25 +2526,27 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
>      trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
>                                rom_vendor_id, rom_device_id);
>  
> -    checksum = ptr[6];
> +    /* In case the checksum is bogus */
> +    checksum = pci_rom_calculate_checksum(ptr, size);
>  
>      if (vendor_id != rom_vendor_id) {
>          /* Patch vendor id and checksum (at offset 6 for etherboot roms). */
> -        checksum += (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
> -        checksum -= (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
> -        trace_pci_rom_checksum_change(ptr[6], checksum);
> -        ptr[6] = checksum;
> +        checksum += (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
> +        checksum -= (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
>          pci_set_word(ptr + pcir_offset + 4, vendor_id);
>      }
>  
>      if (device_id != rom_device_id) {
>          /* Patch device id and checksum (at offset 6 for etherboot roms). */
> -        checksum += (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
> -        checksum -= (uint8_t)device_id + (uint8_t)(device_id >> 8);
> -        trace_pci_rom_checksum_change(ptr[6], checksum);
> -        ptr[6] = checksum;
> +        checksum += (uint8_t)device_id + (uint8_t)(device_id >> 8);
> +        checksum -= (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
>          pci_set_word(ptr + pcir_offset + 6, device_id);
>      }
> +
> +    if (checksum) {
> +        trace_pci_rom_checksum_change(ptr[6], ptr[6] - checksum);
> +        ptr[6] -= checksum;
> +    }
>  }
>  
>  /* Add an option rom for the device */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 5b179091de..2d8a4ad0eb 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -1103,4 +1103,6 @@ void pci_set_enabled(PCIDevice *pci_dev, bool state);
>  void pci_set_power(PCIDevice *pci_dev, bool state);
>  int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
>  
> +uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size);
> +
>  #endif
> -- 
> 2.53.0


