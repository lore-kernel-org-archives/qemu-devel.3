Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54793D4979D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 05:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHyzW-0000p7-KS; Mon, 02 Dec 2024 00:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHyzP-0000oI-Ak
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:28:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHyzM-00078r-Cx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733117330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DsogGWoSDhxz3F23iYPE+hH1ZGSoYTaVp3Fkc/U7GMQ=;
 b=JxJ2nDo74vWL74czJkd4EjqfIOopA+uBUJhnITH8JsBZkl77jsWaYyXPzzZq2nV7d40EzA
 5AYMOTVC0Vsd/zUV65SsPxuO9b86SUGPumVCkQWRt6VE1k5kYECxBzdpGq4jU474Tb5fYf
 jeL1qI3Ihm9L0SxY+KDp1hGPNDaA3kY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-PULP_ZwDMSKw31f3pNmwCw-1; Mon, 02 Dec 2024 00:28:47 -0500
X-MC-Unique: PULP_ZwDMSKw31f3pNmwCw-1
X-Mimecast-MFC-AGG-ID: PULP_ZwDMSKw31f3pNmwCw
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-29e43db18b4so150033fac.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 21:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733117326; x=1733722126;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DsogGWoSDhxz3F23iYPE+hH1ZGSoYTaVp3Fkc/U7GMQ=;
 b=SyOgFY3irpOmcsNHr1ASRcn/brAQwc3A53C9e5iKMi9s/qExFb3xtEcX4JCQwzanju
 T4j4kOe849GyTbEfVy6LFoLfiAQosl3heAp+krOZwwesbrX66BEYGE1Fv999vDh3mDkg
 rImEudboSd9OQ+aBZwgwKer9LretzveP6l3Wl2h6pMSNjE/5iTYxzggmAVCjF2p6WH9Y
 7k1wi21AUzJc9LCL87+DMMkOe/crHZ0S1r/Kv5INIwwgteQmP4Uo05KduZo1o2RVf7V+
 TKnaph2TvEI5LN+BDyGQjx9/ZhicGjQz0wQivXRSZFLuuGLaEwI/BxdCRCz4DSjerQsY
 nezw==
X-Gm-Message-State: AOJu0YxlisJukXaw28j/hxPJT+MVrDTm0rvFn+hzUAXfLnc4NU/q3RGI
 cQ/2QvhhncjsCFua5ad+YAJESIsh/3wlsDRJgm8iIGUSWnBWGoxaBiMnU1lU/zvCksPp3TogXug
 IjkngeeGlUA6ti6lguiqPFZJCam0APJxV5WNzGkqGS4+I2Ay/duAn
X-Gm-Gg: ASbGncsdwWmK4YsjafxIj5r3LmKEr8H4fpqFsqDESOn+hrYmci0A9UMeViif8fIE9Gk
 fePQ8QGDYhWIxKQJnl1EIwCOrQpaTU68IQMTGoQb0X47fpiD4fO/obuDWxB81DtIdEH5eE/I2Hp
 Gky7INO/PsPJlHpZDb+bsAh/fq0/W8QHV1+rZd6EtOAhuY9snSD/4kkXOpa2wJ8odlJcHmUkP3L
 RN0KPPBNwxj1KMd87tGXO6PVl4kVWrIJVa1BJs/yvrFyCzoCrBFeA==
X-Received: by 2002:a05:6830:3146:b0:717:f7b9:e229 with SMTP id
 46e09a7af769-71d65d30197mr5015890a34.7.1733117326565; 
 Sun, 01 Dec 2024 21:28:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRRuCxYfaMW9aEVYsHacxqAIgdu3YQxLx+156TCB/XRwG4wsWryW+EZm8JTRcdfaC9RIxv9g==
X-Received: by 2002:a05:6830:3146:b0:717:f7b9:e229 with SMTP id
 46e09a7af769-71d65d30197mr5015882a34.7.1733117326270; 
 Sun, 01 Dec 2024 21:28:46 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm2133753a34.54.2024.12.01.21.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 21:28:45 -0800 (PST)
Date: Sun, 1 Dec 2024 22:28:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <c.koehne@beckhoff.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 2/8] vfio/igd: canonicalize memory size calculations
Message-ID: <20241201222843.6f415e29.alex.williamson@redhat.com>
In-Reply-To: <20241201160938.44355-3-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-3-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Mon,  2 Dec 2024 00:09:32 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Add helper functions igd_gtt_memory_size() and igd_stolen_size() for
> calculating GTT stolen memory and Data stolen memory size in bytes,
> and use macros to replace the hardware-related magic numbers for
> better readability.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 101 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e40e601026..b449316ec0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -116,6 +116,54 @@ typedef struct VFIOIGDQuirk {
>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>  
> +#define IGD_GMCH_GEN6_GMS_SHIFT     3
> +#define IGD_GMCH_GEN6_GMS_MASK      0x1f
> +#define IGD_GMCH_GEN6_GGMS_SHIFT    8
> +#define IGD_GMCH_GEN6_GGMS_MASK     0x3
> +#define IGD_GMCH_GEN8_GMS_SHIFT     8
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
> +        if (gms < 0x10) {
> +            return gms * 32 * MiB;
> +        }

igd_get_stolen_mb() used:

        if (gms > 0x10) {
            error_report("Unsupported IGD GMS value 0x%x", gms);
            return 0;
        }
        return gms * 32;

Therefore this should use <= to be equivalent.

> +    } else {
> +        if (gms < 0xf0) {
> +            return gms * 32 * MiB;
> +        } else {
> +            return (gms - 0xf0 + 1) * 4 * MiB;

This does not match the line from igd_get_stolen_mb():

            return (gms - 0xf0) * 4 + 4;

Explain.

> +        }
> +    }
> +
> +    error_report("Unsupported IGD GMS value 0x%lx", gms);
> +    return 0;
> +}
>  
>  /*
>   * The rather short list of registers that we copy from the host devices.
> @@ -264,17 +312,10 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
>  static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>  {
>      uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
> -    int ggms, gen = igd_gen(vdev);
> -
> -    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
> -    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen > 7) {
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
> @@ -481,30 +522,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
> @@ -514,7 +531,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      VFIOQuirk *quirk;
>      VFIOIGDQuirk *igd;
>      PCIDevice *lpc_bridge;
> -    int i, ret, ggms_mb, gms_mb = 0, gen;
> +    int i, ret, gen;
> +    uint64_t ggms_size, gms_size;
>      uint64_t *bdsm_size;
>      uint32_t gmch;
>      uint16_t cmd_orig, cmd;
> @@ -676,13 +694,8 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>  
> -    /* Determine the size of stolen memory needed for GTT */
> -    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen > 7) {
> -        ggms_mb = 1 << ggms_mb;
> -    }
> -
> -    gms_mb = igd_get_stolen_mb(gen, gmch);
> +    ggms_size = igd_gtt_memory_size(gen, gmch);
> +    gms_size = igd_stolen_memory_size(gen, gmch);
>  
>      /*
>       * Request reserved memory for stolen memory via fw_cfg.  VM firmware
> @@ -693,7 +706,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       * config offset 0x5C.
>       */
>      bdsm_size = g_malloc(sizeof(*bdsm_size));
> -    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * MiB);
> +    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
>      fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
>                      bdsm_size, sizeof(*bdsm_size));
>  
> @@ -744,5 +757,5 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>                       vdev->vbasedev.name);
>      }
>  
> -    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
> +    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, *bdsm_size / MiB);

Technically this should use le64_to_cpu(*bdsm_size), or retain the
addition logic.  Thanks,

Alex


