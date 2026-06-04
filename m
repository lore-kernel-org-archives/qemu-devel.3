Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A718CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4yI-0004PI-Sz; Thu, 04 Jun 2026 06:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4yH-0004Oh-Gp
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4yF-0000qG-8B
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780567597;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3zH3TjmLzMxUJqyBdnhBWUE1GArYhlyaLnRetGQ/sQ=;
 b=cTDXsuTbNia754Z9UAc+GoC8DGAtDII5mdfTEsVM1XFCDAM6PQLOKMNisAwcLeXUyHT1Uv
 GX0ajVAFYQNJXRNpdQBs4V722G7MWf9NRWesZVelpCEdT3RPRIylr/I3Rpd/peFy3onju4
 4NoC/C+3NGPtDna2pfEoumROi1DT6dM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-5GaVRTjjNnmtSQGm_PsPtg-1; Thu, 04 Jun 2026 06:06:36 -0400
X-MC-Unique: 5GaVRTjjNnmtSQGm_PsPtg-1
X-Mimecast-MFC-AGG-ID: 5GaVRTjjNnmtSQGm_PsPtg_1780567595
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef3aeeb41so372620f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567595; x=1781172395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3zH3TjmLzMxUJqyBdnhBWUE1GArYhlyaLnRetGQ/sQ=;
 b=BozzB+HOPlOUcF6BTQPDgidGL4MnqwSE3Ak2pnnp+01lHEpqVaeyRmFC1fRA5CvmIR
 He/vPnB/d6zpI/CG1FC/tlTwXUi1FD2am1QXXUwcLwqB1WxVgUVUHXHTfoREbCzaqaDQ
 9tvxwz/KplZ1w4jakF9jleRbordg45J86B4jXvHOJrp79snZiavEMierzsDa/GY1b9y+
 DUGRnvdxP1+Fa5WwNB9jwDIug16fNVnHZzBqbAZ7yLTeCMZi985fkm+op8fSjyDZM/3L
 8BTkzjSnInV/dDBnk9Fj8OglpsoU5GKSNq/++NdqTSxBx92EFbNoMwG7RBUjO7uazl68
 VfEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NfDd3WlziOsHHBlpqavYLZO1yHMRC8N4jdyLlMNqj+e7xcUQjy+7LX0nYkC3mJ9o8cDld7p/2ucaK@nongnu.org
X-Gm-Message-State: AOJu0YyDFIM20WuKdsvgSk05oO0wy6XZntcWYqSZzJZ+Tlyio1flNZCg
 ow1DLkUlc6WyEQZHjG09bhl6CdPLTwOdd8fRZmQZ7lyAc+qhk8SNdhV5oc8jHHE+jDKERzrLWtY
 tFWGdRM5fdqDp2syBwCA4ksH66VtMlUDKGhSd1/gbzsOto2wS8Dgt+NrO
X-Gm-Gg: Acq92OFeAUS2VJA/yPShgtWEmfd78/djuKhfnWo5lnS6I6yA7EcjtvIg3NtpW/cBKRt
 jXPIDVtaLlzoSvL8L0/1eaCyZu2s1R7aA7vj8WM2pWa+B8YtqT08I85+vbl+f8QeJIHhSe/eITY
 lnImi96cKMXDKqMUsNxivg44K65B47GNT4WykCKNjQ1s3RSQTVgCzN21wdcEDJYTuSqr74xYfCr
 v8t7RzeI2+fkRkYjrhWObPwX/HchkZojlbcNtwtguO82lnHcizHj+9AL/jlXJ8TopBHl5kO05cm
 d723BFzu3NHp/JGCbO3mim8tJI7qDvj5GJ80CyU+nWhYFeNfmrc1WDNVodT92S5JMLCCrhhBOjY
 JPZ6D55tm2EnPOYqVMp7OSKpz/C1rYcoJcQNwDE6oiAN/THmuDHT6tfHsXadyQpeKxfwD9h08th
 jxRpVy
X-Received: by 2002:a05:6000:180a:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-460218654afmr8464617f8f.34.1780567594753; 
 Thu, 04 Jun 2026 03:06:34 -0700 (PDT)
X-Received: by 2002:a05:6000:180a:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-460218654afmr8464572f8f.34.1780567594356; 
 Thu, 04 Jun 2026 03:06:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm24939717f8f.27.2026.06.04.03.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:06:33 -0700 (PDT)
Message-ID: <aa1ce930-5ce9-48b5-9ece-6569b3d61f19@redhat.com>
Date: Thu, 4 Jun 2026 12:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-22-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260601114221.457995-22-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shammer,

On 6/1/26 1:42 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
I would disambiguate the title a little bit:
Use mmap'd host VINTF page0 for virtual VINTF page0

Also in previous patch titles you could emphase the mmap'd page is the
host one in a similar way.
>
> Install the mmap'd vintf_page0 region as a RAM-device MemoryRegion at
> guest MMIO offset 0x30000 (the VINTF Page 0 aperture) when VINTF is
> enabled, and remove it on VINTF disable. This eliminates QEMU
> trapping for hot-path CONS/PROD index updates via the VINTF aperture.
>
> After this patch, the two VCMDQ Page 0 apertures use different
> access paths: the direct aperture (0x10000) remains QEMU-trapped,
> while the VINTF aperture (0x30000) is a guest-direct RAM mapping.
>
> The direct aperture is intentionally kept trapped (not aliased to
> the VINTF mmap) so that writes to an unallocated VCMDQ remain
> well-defined. The CMDQV architecture allows software to program a
> VCMDQ through the direct aperture without first allocating it to a
> VINTF; aliasing would route those writes to unallocated logical
> slots in the VINTF page, where the hardware silently drops them.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h |  1 +
>  hw/arm/tegra241-cmdqv.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 84499b840d..01cd6af97d 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -49,6 +49,7 @@ typedef struct Tegra241CMDQV {
>      IOMMUFDVeventq *veventq;
>      IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
>      void *vintf_page0;
> +    MemoryRegion *mr_vintf_page0;
>  
>      /* CMDQ-V Config page register cache */
>      uint32_t config;
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index dce7089697..cdd4fa4f1a 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -18,6 +18,40 @@
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
>  
> +static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
> +{
> +    if (!cmdqv->mr_vintf_page0) {
> +        return;
> +    }
> +
> +    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
> +    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
> +    g_free(cmdqv->mr_vintf_page0);
> +    cmdqv->mr_vintf_page0 = NULL;
> +}
> +
> +static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
> +{
> +    char *name;
> +
> +    if (cmdqv->mr_vintf_page0) {
> +        return;
> +    }
> +
> +    name = g_strdup_printf("%s vintf-page0",
> +                           memory_region_name(&cmdqv->mmio_cmdqv));
> +    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
> +    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> +                                      name, VINTF_PAGE_SIZE,
> +                                      cmdqv->vintf_page0);
> +    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
> +                                        CMDQV_VINTF_PAGE0_BASE,
> +                                        cmdqv->mr_vintf_page0, 1);
> +    g_free(name);
> +}
> +
>  static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
>  {
>      IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
> @@ -445,6 +479,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>          if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
>              if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
>                  cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
> +                tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
don't you want to do that only after the tegra241_cmdqv_setup_all_vcmdq()?
>                  /*
>                   * VCMDQs whose BASE was programmed before VINTF was
>                   * enabled need their hw_queue allocated now.
> @@ -452,6 +487,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>                  tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
>              }
>          } else {
> +            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
>              tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
>              cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
Thanks

Eric


