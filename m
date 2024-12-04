Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15F5E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIxyb-00064k-Ap; Wed, 04 Dec 2024 17:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxyZ-00064T-U8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxyX-00083t-Vg
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733351765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0NmL+V8G6DdfcWgmZGNLhrvHQ3Qjkcu8tbJbptPguo=;
 b=bIzhErBVIpVKZXG8pwOPw2TT0CNd0QSqh+2gwbywxb7EU+j7gROsZUOC/DIBSC98kZnILM
 mMsS3CHQJ5kft6vRK1eQyu4OKwHTvyPk71QXaX7S24L6lxogtWxveIGjjMR3fLs2q1/SYG
 GmprQ/MnZDfplWEU3CCR960jsjzb4bA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-WpFKXfKBPr-5pZn1d89Iwg-1; Wed, 04 Dec 2024 17:36:01 -0500
X-MC-Unique: WpFKXfKBPr-5pZn1d89Iwg-1
X-Mimecast-MFC-AGG-ID: WpFKXfKBPr-5pZn1d89Iwg
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83b7cce903cso3916439f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733351761; x=1733956561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0NmL+V8G6DdfcWgmZGNLhrvHQ3Qjkcu8tbJbptPguo=;
 b=XcHh3xY5IP9ixkP4yQHkuZJr3DKmZIsPEajHoidoZ8OU/k+WutyQn3CULa/tViSfZ/
 WlaohVaJzw3pfhlpnESkgpIMK8+7tq3QvdTESTzglfuQv920gZAtlOIpiTeXWWkZPamW
 t8drsc4qTiCx4s6lWT9jfXPRY/dyTPYC9kiuJYTmz8WgU8fxbJ4ci5TlKuZj97exSiKj
 ttQlhRSYyHRIi9LBzNiVjbiNGeHYdZXLshREq99aNfFOjaBehZdzUZJfoz/GA7kguh/K
 cqRhrGsTSK3AvAGkLYDVsgzMxt4/uZQ9+B59slxMQVXwfW6YgHEzKsq9T7hFWy1sBkvt
 EnJw==
X-Gm-Message-State: AOJu0YzeeXO4l+rNnEUDlqzWroWPzy1qnPdIr9DZn1ezXcCPcHwXKsMW
 6p7rR6cnELt/RCniPTeWqkyN2t89BFe2ZbewNF2LKcVOPcQaC2K3Is5HTy3RoAC8nZ2qCCZm172
 3iqtaC6lRO7Zz9kLd39KCfJSeZt8j6x6VQpv2AM3COW+yBI43jdT+
X-Gm-Gg: ASbGnctb8czHNaEFq7DMEO5vM17b33y2XnM2OIo7w6IOvYz7fuMNuy2dT4oaxb1vkby
 Jfx5sved4vQ0QOyHL3s8G8htE21bgx3Zhc0+EHynkZeQX3sC186xomzD4Q0JP8NKPvvfgafPsoD
 uM5Sa3kJH75MRRrRn2q++nbUV2PEpXpz/iVvITKESFZ5vGrNtnZ5KxGVfUkWaqWuk1Vfi+wOHbm
 u34XyO3ZnDKxqvpzsomNYB5WmFpJw9kW3kulaiQ/TItPAQqGrjrpQ==
X-Received: by 2002:a05:6e02:1fc6:b0:3a7:bfad:5032 with SMTP id
 e9e14a558f8ab-3a7f9a38f83mr21906835ab.1.1733351760790; 
 Wed, 04 Dec 2024 14:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrirjhZIo2NNe3Lmv0Fsar6PtyJcC6SOwp0kLyB8C4f+aYs/YfBoJDIbv9BvwlVN82BQ0PQg==
X-Received: by 2002:a05:6e02:1fc6:b0:3a7:bfad:5032 with SMTP id
 e9e14a558f8ab-3a7f9a38f83mr21906765ab.1.1733351760432; 
 Wed, 04 Dec 2024 14:36:00 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e28611ad15sm26224173.33.2024.12.04.14.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:36:00 -0800 (PST)
Date: Wed, 4 Dec 2024 15:35:59 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH v2 3/9] vfio/igd: canonicalize memory size calculations
Message-ID: <20241204153559.18b9847f.alex.williamson@redhat.com>
In-Reply-To: <20241203133548.38252-4-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-4-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue,  3 Dec 2024 21:35:42 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
> calculating GTT stolen memory and Data stolen memory size in bytes,
> and use macros to replace the hardware-related magic numbers for
> better readability.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 99 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 55 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 2ede72d243..b5bfdc6580 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -106,6 +106,51 @@ typedef struct VFIOIGDQuirk {
>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>  
> +#define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
> +#define IGD_GMCH_GEN6_GMS_MASK      0x1f
> +#define IGD_GMCH_GEN6_GGMS_SHIFT    8
> +#define IGD_GMCH_GEN6_GGMS_MASK     0x3
> +#define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
> +#define IGD_GMCH_GEN8_GMS_MASK      0xff
> +#define IGD_GMCH_GEN8_GGMS_SHIFT    6
> +#define IGD_GMCH_GEN8_GGMS_MASK     0x3
> +
> +static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
> +{
> +    uint64_t ggms;
> +
> +    if (gen < 8) {
> +        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
> +    } else {
> +        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
> +        ggms *= 2;

I tried to ask whether this was a bug fix in the previous iteration,
but I think it was overlooked.  These are not the same:

	ggms *= 2;

	ggms = 1 << ggms;

Comparing the 4th processor generation datasheet[1] to that of the 5th
generation processor[2], I see:

4th:
	0x0 = No Preallocated Memory
	0x1 = 1MB of Preallocated Memory
	0x2 = 2MB of Preallocated Memory
	0x3 = Reserved

5th:
	0x0 = No Preallocated Memory
	0x1 = 2MB of Preallocated Memory
	0x2 = 4MB of Preallocated Memory
	0x3 = 8MB of Preallocated Memory

In your update, we'd get ggms values of 2, 4, and 6, which is
incorrect.  The existing code is correct to use the ggms value as the
exponent, 2^1 = 2, 2^2 = 4, 2^3 = 8.  It does seem there's a bug at
zero though since 2^0 = 1, so maybe we should pull out the fix to a
separate patch:

	if (ggms) {
		ggms = 1 << ggms;
	}

Thanks,
Alex

[1]https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf (3.1.13)
[2]https://www.intel.com/content/www/us/en/content-details/330835/5th-generation-intel-core-processor-family-volume-2-of-2-datasheet.html (3.1.13)

> +    }
> +
> +    return ggms * MiB;
> +}
> +
> +static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
> +{
> +    uint64_t gms;
> +
> +    if (gen < 8) {
> +        gms = (gmch >> IGD_GMCH_GEN6_GMS_SHIFT) & IGD_GMCH_GEN6_GMS_MASK;
> +    } else {
> +        gms = (gmch >> IGD_GMCH_GEN8_GMS_SHIFT) & IGD_GMCH_GEN8_GMS_MASK;
> +    }
> +
> +    if (gen < 9) {
> +            return gms * 32 * MiB;
> +    } else {
> +        if (gms < 0xf0) {
> +            return gms * 32 * MiB;
> +        } else {
> +            return (gms - 0xf0 + 1) * 4 * MiB;
> +        }
> +    }
> +
> +    return 0;
> +}
>  
>  /*
>   * The rather short list of registers that we copy from the host devices.
> @@ -254,17 +299,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
>  static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>  {
>      uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
> -    int ggms, gen = igd_gen(vdev);
> -
> -    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
> -    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen >= 8) {
> -        ggms = 1 << ggms;
> -    }
> -
> -    ggms *= MiB;
> +    int gen = igd_gen(vdev);
> +    uint64_t ggms_size = igd_gtt_memory_size(gen, gmch);
>  
> -    return (ggms / (4 * KiB)) * (gen < 8 ? 4 : 8);
> +    return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
>  }
>  
>  /*
> @@ -471,30 +509,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>  }
>  
> -static int igd_get_stolen_mb(int gen, uint32_t gmch)
> -{
> -    int gms;
> -
> -    if (gen < 8) {
> -        gms = (gmch >> 3) & 0x1f;
> -    } else {
> -        gms = (gmch >> 8) & 0xff;
> -    }
> -
> -    if (gen < 9) {
> -        if (gms > 0x10) {
> -            error_report("Unsupported IGD GMS value 0x%x", gms);
> -            return 0;
> -        }
> -        return gms * 32;
> -    } else {
> -        if (gms < 0xf0)
> -            return gms * 32;
> -        else
> -            return (gms - 0xf0) * 4 + 4;
> -    }
> -}
> -
>  void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  {
>      g_autofree struct vfio_region_info *rom = NULL;
> @@ -504,7 +518,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      VFIOQuirk *quirk;
>      VFIOIGDQuirk *igd;
>      PCIDevice *lpc_bridge;
> -    int i, ret, ggms_mb, gms_mb = 0, gen;
> +    int i, ret, gen;
> +    uint64_t ggms_size, gms_size;
>      uint64_t *bdsm_size;
>      uint32_t gmch;
>      uint16_t cmd_orig, cmd;
> @@ -666,13 +681,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>  
> -    /* Determine the size of stolen memory needed for GTT */
> -    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen >= 8) {
> -        ggms_mb = 1 << ggms_mb;
> -    }
> -
> -    gms_mb = igd_get_stolen_mb(gen, gmch);
> +    ggms_size = igd_gtt_memory_size(gen, gmch);
> +    gms_size = igd_stolen_memory_size(gen, gmch);
>  
>      /*
>       * Request reserved memory for stolen memory via fw_cfg.  VM firmware
> @@ -683,7 +693,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       * config offset 0x5C.
>       */
>      bdsm_size = g_malloc(sizeof(*bdsm_size));
> -    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
> +    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
>      fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
>                      bdsm_size, sizeof(*bdsm_size));
>  
> @@ -734,5 +744,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>                       vdev->vbasedev.name);
>      }
>  
> -    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
> +    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
> +                                    (ggms_size + gms_size) / MiB);
>  }


