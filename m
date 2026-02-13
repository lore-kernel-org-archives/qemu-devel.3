Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E859EDF151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqaF-0006iR-3A; Fri, 13 Feb 2026 05:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqqaD-0006hP-Dr
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqqaB-0003zr-Iq
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770979170;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6z9EnFpK1T4C5girtnQAEY3w64X8KqUPjfCgTEkxLBc=;
 b=ahz8+tiPa+k4K4s/TP1k/64FuRdQyNjQaIG0G3IiGygxm34ENm8WQCFxGFmuhJIdowuq5A
 IyABq20RnQivXUOpZvo7JvH/dsoLpc7tk0Dp5X0pTlwEGVfsh2p9URAwjNd6hbkhsRREfP
 Aj27/YtxA+EEzba2JA7wbi3nl1KhbvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-KQmza3emNcirFYG6sHcAsQ-1; Fri, 13 Feb 2026 05:39:29 -0500
X-MC-Unique: KQmza3emNcirFYG6sHcAsQ-1
X-Mimecast-MFC-AGG-ID: KQmza3emNcirFYG6sHcAsQ_1770979168
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836e35292cso6183705e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770979168; x=1771583968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6z9EnFpK1T4C5girtnQAEY3w64X8KqUPjfCgTEkxLBc=;
 b=IowJTqy4Kj8PDBdgL9liE68jzl6WMI7DnUZRe0jWKF+tegrzfwHXx6A2rBQJWClgiP
 rEjzy3m2fZq1LidvYjtP3U4iEssFw51mV2WdiS2vCmBgAvT9SU4fUErRiSkSHQV1fWew
 TG3jFKzHgC32Xdavn/VC2j+QATkryOMQhEbWlbh3GiI0EGVYYlI1jpNL/roUBy0AF84f
 4NuTFsCCKuHnK4iKD1kZ8lXS9IyLgctFAjqJ+LE4lNZlXl6Z4igxwKUGw+lsJ4aRQWU+
 8Ef24uS3rK0s5WF0vZsBqp7j4/ld7WbDAtAhEEIfd+ZikS5HOlQ8dlGMnV7PbtBqvOx5
 h/XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgd45vrmPPF4u3S5l7knI2aBgttZGOhXfJxrGO2LQ7sRmo+9Opu1eBm5IoI33l2At6Qu5VUO9eHnDj@nongnu.org
X-Gm-Message-State: AOJu0YzWszOFF1zfgJbWjaEjFIBT+5X5kwTq4M1rBhz1wJpP7c/3HuZU
 vMwXAOL2Bt5bfFSgMl6+Z+FZ2VKZ9tbRGGkcKc0tqelE0Nw3CPlOPmSi3u8eQA4XgeVJGikOg6e
 dkLNJSpTcnXFOifgNfVMt3MOVYF5iBdf2SKW/ApaqAJ5tmPs9TaKdq2PF
X-Gm-Gg: AZuq6aI3TzL6scS36jEKsoLcazDj5TvQq5eqKMYy6ttNVT3Rb+PLN1PKw4xQ98ckwxC
 Gr8dkyPDBS1fUmcECmC/o5q0iCjUSahla4N43hqTQQ9xAMdCOTtk5voEcQLDNT9XTEIDxLSgD6N
 iP5oJI6U0CHNoe/e2B/+oc9oLpqZ7RmXKGvwLR24Wu5XDIhvvaHS/Q6NUp4USAcfLka5bPihzUO
 BLdtfnI/z2EYU3UvIYdZ8RCfb1MBdJllM5X4wGuJvFHPSmH3YxLPhn1CueVhzOyG3dkwcE5B90p
 j+dSitH/MvjBd8Ip14w8orFuXYSG334zvoDsORVOAr2aZJxvr3ohq6wPgJNToRbBFjXx/LxRLeJ
 JggeFZhU+TCDg6w9/tIPFPMSvuLFTo9u/SwUSpK1oU7TXoLKNGaxmDWlC4Owolnd+BBVNIw==
X-Received: by 2002:a05:600c:c16b:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-48373a546b1mr22761285e9.28.1770979168001; 
 Fri, 13 Feb 2026 02:39:28 -0800 (PST)
X-Received: by 2002:a05:600c:c16b:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-48373a546b1mr22760715e9.28.1770979167516; 
 Fri, 13 Feb 2026 02:39:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a29c13sm14049455e9.16.2026.02.13.02.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 02:39:27 -0800 (PST)
Message-ID: <dac416bc-a55c-439d-a374-63572d9d58ea@redhat.com>
Date: Fri, 13 Feb 2026 11:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/24] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-10-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Shameer,

On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
> (VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
> into 64KB pages as follows:
>
>   0x00000: Global CMDQV registers
>   0x10000: Global VCMDQ registers, Page0 (control/status)
>   0x20000: Global VCMDQ registers, Page1 (configuration)
>   0x30000: VINTF0 logical VCMDQ registers, Page0 (control/status)
>   0x40000: VINTF0 logical VCMDQ registers, Page1 (configuration)
this shall rather be introduced along with the whole mmio region. In
this patch you focus on rather VINTF0 page0
>
> Global VCMDQ pages provide a VM wide view of all VCMDQs, while the
> VINTF pages expose a logical view local to a given VINTF. Although real
> hardware may support multiple VINTFs, the kernel currently exposes a
> single VINTF per VM.
Maybe you shall simply name it VINTF
>
> The kernel provides an mmap offset for the VINTF Page0 region during
> vIOMMU allocation. However, the logical-to-physical association between
> VCMDQs and a VINTF is only established after HW_QUEUE allocation. Prior
> to that, the mapped Page0 does not back any real VCMDQ state.
>
> Prepare the VINTF0 Page0 mapping by mmapping the kernel provided region
> when CMDQV is accessed, while keeping all CMDQV MMIO accesses trapped
> in QEMU. The mapping is not yet exposed to the guest address space.
> A subsequent patch will install the RAM backed MMIO subregion for VINTF
> page0 once HW_QUEUE allocation completes.

So we are likely to mmap a page whose content is undefined until
HW_QUEUE alloc, is that correct? In that case, why don't we do that only
after HW_QUEUE alloc? Please can you clarify?
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.h |  3 +++
>  2 files changed, 41 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 596b1c5595..97c9b9c8dc 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -13,14 +13,52 @@
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  
> +static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
> +{
> +    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
> +
> +    if (!viommu) {
> +        return true;
> +    }
> +
> +    g_assert(!cmdqv->vintf_page0);
> +    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
> +                                     VINTF_REG_PAGE_SIZE,
> +                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
> +                                     &cmdqv->vintf_page0, errp)) {
So I would rather directly implement iommufd_backend_viommu_mmap() here.
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>  {
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +    Error *local_err = NULL;
init is not needed since you don't test it.
> +
> +    if (!cmdqv->vintf_page0) {
> +        if (!tegra241_cmdqv_mmap_vintf_page0(cmdqv, &local_err)) {
> +            error_report_err(local_err);
> +            local_err = NULL;
not needed either
> +        }
> +    }
> +
>      return 0;
>  }
>  
>  static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
>                                   unsigned size)
>  {
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +    Error *local_err = NULL;
same here
> +
> +    if (!cmdqv->vintf_page0) {
> +        if (!tegra241_cmdqv_mmap_vintf_page0(cmdqv, &local_err)) {
> +            error_report_err(local_err);
> +            local_err = NULL;
> +        }
> +    }
>  }
>  
>  static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 6ea0087f61..94bef8c978 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -29,8 +29,11 @@ typedef struct Tegra241CMDQV {
>      SMMUv3AccelState *s_accel;
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
> +    void *vintf_page0;
>  } Tegra241CMDQV;
>  
> +#define VINTF_REG_PAGE_SIZE 0x10000
can't we rename that into VINTF_SIZE. REG does not mean much. Before you
talked about Control/Status vs Configuration. Besides, I am not sure
having a define brings much in that case.

Thanks

Eric
> +
>  #ifdef CONFIG_TEGRA241_CMDQV
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void);
>  #else


