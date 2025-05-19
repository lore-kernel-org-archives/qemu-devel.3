Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED75C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH45U-00045G-9y; Mon, 19 May 2025 13:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uH45S-00043m-Ak
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uH45P-00024O-Sj
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747674933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFctatdD7Z/cK/Bv/QAKAvpW1j1nWjBmTp5u1mv0a+A=;
 b=QBARIqaCAzg4BMbxwMyCsEuvmv14RCi8DKEDS3SMsiqA4xyVB8t/4/lkNGc4NGxwe3mN8r
 18CKguWuOSmsU7ZVMnjvyjJg6EIv9bmnY89OXPv/3EuMsf+K0pFRBOzi2QTHxB8aRNMX6o
 lKfm6mqOx0eU9ASbNI5cMsuULoz58mA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-SLko6tm_N5eI8UBUCRrYcA-1; Mon, 19 May 2025 13:15:32 -0400
X-MC-Unique: SLko6tm_N5eI8UBUCRrYcA-1
X-Mimecast-MFC-AGG-ID: SLko6tm_N5eI8UBUCRrYcA_1747674931
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-8614a8474f6so69527339f.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 10:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747674931; x=1748279731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zFctatdD7Z/cK/Bv/QAKAvpW1j1nWjBmTp5u1mv0a+A=;
 b=I93m7YJV7B8PirHJLpPL2rVUuV6xo3aCAfwadYglHPpor8eJoXtF5RMEK8e5yg3GUW
 OzsAorpQkN/e1YUiU3upL5015rL2xoKUg7dDKrgYH/xCwra8FN4+QngcXl3L+KMOHGMm
 PQptBSiadcbHs9Vsg0R9nciwYipvp7PAG7RNaOiLSwVmSIZ8XCBLZmYbcuctsDGF2kuf
 D8mzX75bAiSaTH2IvrWSuRmlO9zFwZB7Zod02BVv10Cx2ZEqQTgC55dC1gP955qYokhy
 MpxcNZDdfNxqMWlc5fdRUME5tcH/n7yySbgtUMQCgm1Wu90Gbzdap8Urz1Q5yMkOF42v
 m+sQ==
X-Gm-Message-State: AOJu0YzYOaFuEFGnwXMYcZwiqcy6Hms+VN96DhoS4kFXccJR1Tbw6538
 NmmyC8SePLRpe5VdzX8FJFUTqj+COqLwxLKgD4BXyKrC5xPFI/zDwVZrVUmF/oqVvPtZbvjgapw
 VJshg6CriQwAdQCw1dyFPBYt6xgzT9/7kgY4Whz+uVQZxIftenvA790ZE
X-Gm-Gg: ASbGncs2bWlVu/NbkuHbAYtREhrBO8csCYLxouC+GbyfXfuPrIqxRX0ftyngwZ+Li8/
 OXPNpspjCqQZR4IOlPePji0f+BAe9/FsPzW79dTWaMJMPVWxmULFDjsFjl6zVVKLYU1Ugf891zt
 ZEdcox4WtDqbgxYROk+FNJ2p3RG8QPKrQVV7NkRpDKtFpoJEQTaduwZapN+eTyTxP2hB76AcV7U
 NkdofapPEYhmlX1wkx7zAYLMhZ5+ENcryFobpt8GALry9GSHieyq9WdfgCa/X9IZOiCmPy0QcdC
 SjvYPB3ewW9okcc=
X-Received: by 2002:a05:6602:3416:b0:856:2a52:ea02 with SMTP id
 ca18e2360f4ac-86a233b0544mr376294639f.5.1747674931116; 
 Mon, 19 May 2025 10:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQtkyRSlb+jab5Nitu4r9h3Xm+Bqf6nmhewjPKhjEmGXvZBaM71dDcUCzGLgPCrShy4Gwm+A==
X-Received: by 2002:a05:6602:3416:b0:856:2a52:ea02 with SMTP id
 ca18e2360f4ac-86a233b0544mr376292539f.5.1747674930619; 
 Mon, 19 May 2025 10:15:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86a2372cc53sm177861439f.44.2025.05.19.10.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 10:15:29 -0700 (PDT)
Date: Mon, 19 May 2025 11:15:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Qwinci <qwinci222@gmail.com>
Cc: qemu-devel@nongnu.org, Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/igd: Support non-boot gpus
Message-ID: <20250519111527.6cafd01a.alex.williamson@redhat.com>
In-Reply-To: <20250519150837.23146-3-qwinci222@gmail.com>
References: <20250519150837.23146-3-qwinci222@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[Please Cc maintainers - added here]

On Mon, 19 May 2025 18:08:39 +0300
Qwinci <qwinci222@gmail.com> wrote:

> Change the IGD detection logic to also accept gpus with
> PCI_CLASS_DISPLAY_OTHER class which is used if the igpu is not
> set as the primary boot gpu.
> 
> Signed-off-by: Qwinci <qwinci222@gmail.com>
> ---
>  hw/vfio/igd.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e7952d15a0..1ddfcc2c17 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -454,6 +454,16 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
>  #define IGD_GGC_MMIO_OFFSET     0x108040
>  #define IGD_BDSM_MMIO_OFFSET    0x1080C0
>  
> +static bool is_igd(VFIOPCIDevice *vdev) {
> +    if (vfio_is_vga(vdev)) {
> +        return true;
> +    }
> +
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
> +    return class == PCI_CLASS_DISPLAY_OTHER;
> +}

But the function isn't detecting IGD, it's detecting VGA or DISPLAY
class devices.  So it's misnamed and we might want a new
vfio_is_display() and if necessary a wrapper for both that tests
vfio_is_vga_or_display(), or maybe a vfio_is_base_display() if we want
to test only the base class.

More importantly maybe, sure there might be IGD as non-primary
configurations, but are the quirks still relevant to those devices?
Which ones?  Thanks,

Alex

>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  {
>      VFIOQuirk *ggc_quirk, *bdsm_quirk;
> @@ -461,7 +471,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      int gen;
>  
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev) || nr != 0) {
> +        !is_igd(vdev) || nr != 0) {
>          return;
>      }
>  
> @@ -519,7 +529,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      Error *err = NULL;
>  
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev)) {
> +        !is_igd(vdev)) {
>          return true;
>      }
>  
> @@ -685,7 +695,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      int gen;
>  
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev)) {
> +        !is_igd(vdev)) {
>          return true;
>      }
>  


