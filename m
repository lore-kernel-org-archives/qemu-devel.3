Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42314CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3pK-0004ok-Pi; Thu, 21 May 2026 09:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ3pI-0004YZ-4E
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ3pG-0006de-1b
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371557;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7ul/ogmZIh7TnpXpCqXxFeP5s/7MMeW5pcW9MA+YzU=;
 b=UaXHbQAxCQpMu3L2iswn9xtPfE6r23DN8HBKTKX09fGhoB/NitE3zuv87M8p3t19TjoUD/
 n47y6foYJg2/Bm4FXOIsHAfSWz6q11HW/XzkDumft35PIAim7Yv2ujWF2xpC2TgEDglskL
 z82/OAYTsP7Viu/3UaHR0YkcRe2+ulo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-XGeW-U_2MUKfHTOSRDKxxg-1; Thu, 21 May 2026 09:52:35 -0400
X-MC-Unique: XGeW-U_2MUKfHTOSRDKxxg-1
X-Mimecast-MFC-AGG-ID: XGeW-U_2MUKfHTOSRDKxxg_1779371554
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso50609035e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371554; x=1779976354;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7ul/ogmZIh7TnpXpCqXxFeP5s/7MMeW5pcW9MA+YzU=;
 b=bCWkBkmGd9efMRoyKfOtPYXzDiuvYmvE1+btF68iTqRwcbDBui4pBODo3h0WlGEVY7
 yoF7xByoMi4bjWfeWqJjSACTg8/DOVWHoPm0sqX1qMB+jWplJqdZzNjqFC3iWjF7H2vN
 JdVHlOhM5pvFEWsOsPttViaHkQv04LPFpHy7FyjZ+7yYgYOifdOaCTG8nbuG34ZTyIdB
 RoQDTO06luHqaHKWAH0K30i2NcUAax0WJ5V3PMVQ7mYcCn9Zc/4//KSmuBW3FtSV7q4d
 8kBXu7dURHXyfrARgG/1qxAeCa5c30AxoWj50h/G7yOhQ3EUx5MeK0rEKSchqkDwhvnU
 7gFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ89nNCtxZ5P5EB3xVvl4GpkJhOH5aWUlU+DBeldxQ59UGd1y242HxwVvBG3lCtFLoYChkBdZKv7FeUn@nongnu.org
X-Gm-Message-State: AOJu0Yxra01agra5u9y1ZDA0X8VuNJXh+VOFISeifurTu0ICbRpiq/M/
 dGaFnFFdW0vy6J2nVKvps43OjkuILL24W57fx/eBaWJx0LvJ5AxHKsWTwGjuEsr+s6dBQFpe+WM
 zOzA3yaukjjb/EfsWOwdme1CnHEHuoCTAkhzfu4WumFrGTPhioAVx4VXP
X-Gm-Gg: Acq92OFXl3e9Zm2mlPJDMgRoHLox52d8EvVUGBIkUClL9/HqG/eL4WQ8mfKmdDrKn9q
 O+9UgNdSO+Wg4rPHC4OKmkOtKcIxo9bhELhDRxnN+NHuC/S1tRnzPmNLiVig433ARau8QHKTyWQ
 ffhjeDfAQZmjzj/pdn3GiPY1CLQlUUWJ/Hf+yDdQ7RmNuMftm+Gi3TYpXRjf2IfZIlbPwQsjWLs
 LSMNlTpeksCxs9miK17JBOLNK3BUYsiuBIPN2a/qotw5r2x7pb9BMs/k6EPiTX4YLHPcGkLsYfm
 EJkB/pViODxDBeHdGKhqZZlCYUhd0JFXdcnFu+vUO/kqQQuwFoBjpiiJkWKiOR8tEOctlHVphvN
 ISC2S5zFVH+LqIOLNRms95LRDHO+i6gJCPZvTgG5dRR6tAiDWgCtQqwIwBoYKYyUPnAb6/A==
X-Received: by 2002:a05:600c:848d:b0:48e:60a3:220a with SMTP id
 5b1f17b1804b1-49035fbac92mr43316595e9.0.1779371554460; 
 Thu, 21 May 2026 06:52:34 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:48e:60a3:220a with SMTP id
 5b1f17b1804b1-49035fbac92mr43316125e9.0.1779371554032; 
 Thu, 21 May 2026 06:52:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903cadc119sm22835675e9.11.2026.05.21.06.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:52:33 -0700 (PDT)
Message-ID: <2cfef4ff-6eca-4915-8d41-8d43139cea31@redhat.com>
Date: Thu, 21 May 2026 15:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/32] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-23-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-23-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/19/26 12:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Once a VCMDQ is allocated, map the mmap'd vintf_page0 region directly
> into the guest-visible MMIO space at offset 0x30000 as a RAM-backed
> MemoryRegion. This eliminates QEMU trapping for hot-path CONS/PROD
> index updates.
>
> After this patch, the two VCMDQ apertures use different access paths:
> the direct aperture (0x10000) remains QEMU-trapped and writes via
> vintf_ptr, while the VI aperture (0x30000) is a direct guest RAM
> mapping. Both paths write to the same underlying vintf_page0 memory,
> so no synchronisation between the apertures is needed.

Please further explain the rationale of having 2 separate paths

Eric
>
> The mapping is installed lazily on first successful VCMDQ hardware
> queue allocation and removed when CMDQV or VINTF is disabled.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h |  1 +
>  hw/arm/tegra241-cmdqv.c | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 7a8cb2ebc7..e9e1933a19 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -47,6 +47,7 @@ typedef struct Tegra241CMDQV {
>      IOMMUFDVeventq *veventq;
>      IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
>      void *vintf_page0;
> +    MemoryRegion *mr_vintf_page0;
>  
>      /* CMDQ-V Config page register cache */
>      uint32_t config;
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index a7e89905df..853c548e58 100644
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
> @@ -130,6 +164,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
>      /* Pre-alloc cached writes survive the cache-to-hardware transition. */
>      tegra241_cmdqv_sync_vcmdq(cmdqv, index);
>  
> +    /* Map the mmap'd VINTF page0 into guest MMIO space. */
> +    tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
> +
>      return true;
>  }
>  
> @@ -449,6 +486,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>                  tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);

I would rather put the     tegra241_cmdqv_guest_map_vintf_page0(cmdqv) here 
to have symetric map/unmap
>              }
>          } else {
> +            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
>              tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
>              cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
> @@ -566,6 +604,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>               */
>              tegra241_cmdqv_setup_all_vcmdq(cmdqv, &local_err);
same
>          } else {
> +            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
>              tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
>          }
Thanks

Eric


