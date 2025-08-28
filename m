Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC771CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 08:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urY92-0001Fv-Pb; Thu, 28 Aug 2025 04:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urY8z-0001Au-8y
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urY8w-00085E-41
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756370279;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CR32s0TAMxMf/LqtoUuSWEjWYVZf9XtUtEvKi5acCiA=;
 b=SjZxRpE9yjVzvq+rg9iNFRmqT7p4Q7ugnWutDVgaAGdMvtoRRuitfcDYHxqep4ModKAX0G
 SIdAV/q/cOMVqllM4i9deS/vnRDxdVWqvbxV4kVuuMPg/StoWX2PClL5RRBlPelLulY9Tg
 qMsnJ4+0UBLBeb1mxe8tk+RNcp6RxCs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362--OQLyVuAM2STnQI1HwQHAQ-1; Thu, 28 Aug 2025 04:37:55 -0400
X-MC-Unique: -OQLyVuAM2STnQI1HwQHAQ-1
X-Mimecast-MFC-AGG-ID: -OQLyVuAM2STnQI1HwQHAQ_1756370274
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b51baec92so1303355e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 01:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756370274; x=1756975074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CR32s0TAMxMf/LqtoUuSWEjWYVZf9XtUtEvKi5acCiA=;
 b=Bzh/lQTolpM7GAvr6vcjdGCtHy1N1VgnrVT5DebwjcoFX1ng0BYWGeCHntBxPzM52Q
 VZ4NnYje0oScoPfkhXPEomnbZqfXgCFqzdtUjQ6VrWa+TgWN7JQJyhWWW6FAXBBw+Xh0
 eBwaxxUpaikt+/hv+W2piBuj5/slzyembq5bqS1dlGX+wqo/6i2tfOKdwQbCV7QN5OJK
 ypQNzhHvmbWJGxT8aZrKoLL/VExQcCxERago83eXpTtvJttI5D6s0uF1FwtOLE14UDCu
 WKJ4sNQAzuMDLy9E1wzGnEJsa/+1FsT4fzFybxn4rIt4nrtLVRgYI2L27jZx+ooFPUxa
 vpVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViW/BhKw3Hg4r1+fn/23XL78TWMrdfXxBtyKVxTliTMH9AHF9B7Ux26wAiREXMEJ0aSmb8s6Crsi/h@nongnu.org
X-Gm-Message-State: AOJu0Yw3tznKt2CTU9Yp2eA1jLlyY2s7w4NeACtGmnDBgjtgFnGuOueg
 fkZYXr8C62BW/r+26thDGE8IS7GpaN2wPS67SnoE0LakOtNeOUyfC0yUILAwi7Uf8EntgRYs0W3
 ruuNJU+G4JLLCUn7RpYQKvLCW6aRMxgtNHAQD6fGuT5joROdS2lCzfUXS
X-Gm-Gg: ASbGnctesoB2z24TX0pmd4tFJpEKuQ/3nondnZJx9gX925p9+OmF6umHRs3wq3RAWGT
 lnNjFnxLH+WagHGgtLc2POcHaWmVJGVJzbBORZdFy1UFCkx4y5o8jh/q4IzKJ6I+g74mi4WzhRJ
 HN5s7LYXZj/s1QL1JZShzSXod+wqUaJBTjgpBRBNPr6GhQIsybw2Yu5opW1Qq17rwKuSCZHdlIt
 +BAe6gdSS73lc44hExdzbFY4x9uRB0OndV6UDFq5/t7PVmUZQcrScW7XyVKFfDHI8asoz4mBCxO
 Yp6iGN7bZdhk2dGNm2kHUtNEZ0WHK1rg4CnnlfrbTnkQMJe+3wiR3y2L3lAHh3Pnqkxhuhbfegt
 atrrN+F8z1v8=
X-Received: by 2002:a05:600c:3149:b0:45b:47e1:ef73 with SMTP id
 5b1f17b1804b1-45b517df336mr171048365e9.34.1756370273585; 
 Thu, 28 Aug 2025 01:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnqVAMRA4UPTb+kl6MTwJPOyS7Il5lEPovktm+Wc3F2d4PaZQ7CYPU0zjPHfZHOykqARMCgw==
X-Received: by 2002:a05:600c:3149:b0:45b:47e1:ef73 with SMTP id
 5b1f17b1804b1-45b517df336mr171047885e9.34.1756370273044; 
 Thu, 28 Aug 2025 01:37:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d3073sm70414705e9.7.2025.08.28.01.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 01:37:52 -0700 (PDT)
Message-ID: <092300de-c1e2-4a93-94b3-0a06a5a901b6@redhat.com>
Date: Thu, 28 Aug 2025 10:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] intel_iommu: Bind/unbind guest page table to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-16-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> This captures the guest PASID table entry modifications and
> propagates the changes to host to attach a hwpt with type determined
> per guest IOMMU mode and PGTT configuration.
>
> When PGTT is Pass-through(100b), the hwpt on host side is a stage-2
> page table(GPA->HPA). When PGTT is First-stage Translation only(001b),
> vIOMMU reuse hwpt(GPA->HPA) provided by VFIO as nested parent to
> construct nested page table.
>
> When guest decides to use legacy mode then vIOMMU switches the MRs of
> the device's AS, hence the IOAS created by VFIO container would be
> switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
> switched to IOMMU MR. So it is able to support shadowing the guest IO
> page table.
>
> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  14 ++-
>  include/hw/i386/intel_iommu.h  |   1 +
>  hw/i386/intel_iommu.c          | 221 ++++++++++++++++++++++++++++++++-
>  hw/i386/trace-events           |   3 +
>  4 files changed, 233 insertions(+), 6 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c510b09d1a..61e35dbdc0 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -564,6 +564,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  
> +typedef enum VTDPASIDOp {
> +    VTD_PASID_BIND,
> +    VTD_PASID_UPDATE,
> +    VTD_PASID_UNBIND,
> +} VTDPASIDOp;
> +
>  typedef enum VTDPCInvType {
>      /* VTD spec defined PASID cache invalidation type */
>      VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
> @@ -612,8 +618,12 @@ typedef struct VTDPASIDCacheInfo {
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>  #define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>  
> -#define VTD_SM_PASID_ENTRY_FLPM          3ULL
> -#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
along with renaming, use extract64()
will be simpler than
intel_iommu.c:    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
intel_iommu.c:            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;

also this will take care of the upper bits.

> +#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
> +/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
> +#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
> +#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
>  
>  /* First Level Paging Structure */
>  /* Masks for First Level Paging Entry */
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 0e3826f6f0..2affab36b2 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -104,6 +104,7 @@ struct VTDAddressSpace {
>      PCIBus *bus;
>      uint8_t devfn;
>      uint32_t pasid;
> +    uint32_t s1_hwpt;
>      AddressSpace as;
>      IOMMUMemoryRegion iommu;
>      MemoryRegion root;          /* The root container of the device */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 15582977b8..a10ee8eb4f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qapi/error.h"
> @@ -41,6 +42,9 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "system/iommufd.h"
> +#ifdef CONFIG_IOMMUFD
> +#include <linux/iommufd.h>
> +#endif
>  
>  /* context entry operations */
>  #define VTD_CE_GET_RID2PASID(ce) \
> @@ -50,10 +54,9 @@
>  
>  /* pe operations */
>  #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_FL_LEVEL(pe) \
> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
>  #define VTD_PE_GET_SL_LEVEL(pe) \
>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
> +#define VTD_PE_GET_FL_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
this change and above one are cleanups. They can easily be put in a
separate patch to ease the review.
>  
>  /*
>   * PCI bus number (or SID) is not reliable since the device is usaully
> @@ -834,6 +837,31 @@ static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
>      return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
>  }
>  
> +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
> +}
> +
> +/*
> + * Stage-1 IOVA address width: 48 bits for 4-level paging(FSPM=00)
> + *                             57 bits for 5-level paging(FSPM=01)
> + */
> +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
fl = first level? You may prefer fs (ifrts stage) which is used in fspm
terminology.
> +{
> +    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
> +}
> +
> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
> +}
> +
> +/* check if pgtt is first stage translation */
> +static inline bool vtd_pe_pgtt_is_flt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FLT);
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
> @@ -1131,7 +1159,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>      if (s->root_scalable) {
>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (s->flts) {
> -            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
> +            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
>          } else {
>              return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
>          }
> @@ -1766,7 +1794,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>               */
>              return false;
>          }
> -        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
> +        return vtd_pe_pgtt_is_pt(&pe);
that change can be put in the cleanup patch too
>      }
>  
>      return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
> @@ -2433,6 +2461,178 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>      vtd_iommu_replay_all(s);
>  }
>  
> +#ifdef CONFIG_IOMMUFD
> +static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
> +                                  VTDPASIDEntry *pe)
> +{
> +    memset(vtd, 0, sizeof(*vtd));
> +
> +    vtd->flags =  (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE : 0) |
> +                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE : 0) |
> +                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE : 0);
> +    vtd->addr_width = vtd_pe_get_fl_aw(pe);
> +    vtd->pgtbl_addr = (uint64_t)vtd_pe_get_flpt_base(pe);
> +}
> +
> +static int vtd_create_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                              VTDPASIDEntry *pe, uint32_t *s1_hwpt,
> +                              Error **errp)
> +{
> +    struct iommu_hwpt_vtd_s1 vtd;
= {};
and get rid of above memset?
> +
> +    vtd_init_s1_hwpt_data(&vtd, pe);
not sure the leper is needed. Is it reused somewhere else?
> +
> +    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                       idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                       sizeof(vtd), &vtd, s1_hwpt, errp);
> +}
> +
> +static void vtd_destroy_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                VTDAddressSpace *vtd_as)
> +{
> +    if (!vtd_as->s1_hwpt) {
> +        return;
> +    }
> +    iommufd_backend_free_id(idev->iommufd, vtd_as->s1_hwpt);
> +    vtd_as->s1_hwpt = 0;
> +}
> +
> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> +    uint32_t hwpt_id;
> +    int ret;
> +
> +    /*
> +     * We can get here only if flts=on, the supported PGTT is FLT and PT.
> +     * Catch invalid PGTT when processing invalidation request to avoid
> +     * attaching to wrong hwpt.
> +     */
> +    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
> +        error_setg(errp, "Invalid PGTT type");
> +        return -EINVAL;
> +    }
> +
> +    if (vtd_pe_pgtt_is_flt(pe)) {
> +        /* Should fail if the FLPT base is 0 */
OK I see there is a mix of FL and FS terminology. Forget about my
previous comment.
> +        if (!vtd_pe_get_flpt_base(pe)) {
> +            error_setg(errp, "FLPT base is 0");
> +            return -EINVAL;
> +        }
> +
> +        if (vtd_create_s1_hwpt(idev, pe, &hwpt_id, errp)) {
> +            return -EINVAL;
> +        }
> +    } else {
> +        hwpt_id = idev->hwpt_id;
> +    }
> +
> +    ret = !host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
> +    if (!ret) {
that double ! looks pretty bad ;-)
> +        vtd_destroy_s1_hwpt(idev, vtd_as);
> +        if (vtd_pe_pgtt_is_flt(pe)) {
> +            vtd_as->s1_hwpt = hwpt_id;
would deserve some comments
> +        }
> +    } else if (vtd_pe_pgtt_is_flt(pe)) {
> +        iommufd_backend_free_id(idev->iommufd, hwpt_id);
> +    }
> +
> +    return ret;
> +}
> +
> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    uint32_t pasid = vtd_as->pasid;
> +    int ret;
> +
> +    if (vtd_hiod->iommu_state->dmar_enabled) {
> +        ret = !host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
> +    } else {
> +        ret = !host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +                                           ret);
> +    }
> +
> +    if (!ret) {
gere as well, !! lost me sorry
> +        vtd_destroy_s1_hwpt(idev, vtd_as);
> +    }
> +
> +    return ret;
> +}
> +
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
> +                                Error **errp)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(s, vtd_as);
> +    int ret;
> +
> +    if (!vtd_hiod) {
> +        /* No need to go further, e.g. for emulated device */
> +        return 0;
> +    }
> +
> +    if (vtd_as->pasid != PCI_NO_PASID) {
> +        error_setg(errp, "Non-rid_pasid %d not supported yet", vtd_as->pasid);
> +        return -EINVAL;
> +    }
> +
> +    switch (op) {
> +    case VTD_PASID_UPDATE:
> +    case VTD_PASID_BIND:
> +    {
> +        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
> +        break;
> +    }
> +    case VTD_PASID_UNBIND:
> +    {
> +        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
> +        break;
> +    }
> +    default:
> +        error_setg(errp, "Unknown VTDPASIDOp!!!");
> +        break;
> +    }
> +
> +    return ret;
> +}
> +#else
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
> +                                Error **errp)
> +{
> +    return 0;
> +}
> +#endif
> +
> +static int vtd_bind_guest_pasid_report_err(VTDAddressSpace *vtd_as,
> +                                           VTDPASIDOp op)
> +{
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    /*
> +     * vIOMMU calls into kernel to do BIND/UNBIND, the failure reason
> +     * can be kernel, QEMU bug or invalid guest config. None of them
> +     * should be reported to guest in PASID cache invalidation
> +     * processing path. But at least, we can report it to QEMU console.
> +     *
> +     * TODO: for invalid guest config, DMA translation fault will be
> +     * caught by host and passed to QEMU to inject to guest in future.
> +     */
> +    ret = vtd_bind_guest_pasid(vtd_as, op, &local_err);
> +    if (ret) {
> +        error_report_err(local_err);
> +    }
> +
> +    return ret;
> +}
> +
>  /* Do a context-cache device-selective invalidation.
>   * @func_mask: FM field after shifting
>   */
> @@ -3248,10 +3448,20 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
>       */
>      if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
>          pc_entry->pasid_entry = pe;
> +        if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_UPDATE)) {
I would remove that helper.
> +            /*
> +             * In case update binding fails, tear down existing binding to
> +             * catch invalid pasid entry config during DMA translation.
> +             */
> +            goto remove;
> +        }
>      }
>      return false;
>  
>  remove:
> +    if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_UNBIND)) {
> +        return false;
> +    }
>      pc_entry->valid = false;
>  
>      /*
> @@ -3336,6 +3546,9 @@ static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
>              if (!pc_entry->valid) {
>                  pc_entry->pasid_entry = pe;
>                  pc_entry->valid = true;
> +                if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_BIND)) {
> +                    pc_entry->valid = false;
> +                }
>              }
>          }
>          pasid++;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index c8a936eb46..1c31b9a873 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
>  vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
>  vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
>  vtd_reset_exit(void) ""
> +vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
> +vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>  
>  # amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
Thanks

Eric


