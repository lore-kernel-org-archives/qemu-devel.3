Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30B3CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFr0O-0007GJ-GP; Mon, 03 Nov 2025 04:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFr0M-0007G2-SQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFr0F-0004IZ-44
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762162646;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7jmtvMIyGPorJRsPjTVxb3CMnhu4bS5Ues3W4PXBCg=;
 b=Dxoos5cDgn4yFwYRC7So8clY4HozaZh0klyAWpsCaCWUNng8ZYdiQKo6pKegVGX12cn96T
 Nu3z62qVfvZSXBT/25eJ2PlSp2XQf/k/vZKNQXG9oVOcvzJQJXe/8QUiQ+gvQovk3iU8kC
 Jpa2uG24eH6xMxeM3hOD57ce3frK4Ho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-l7hALRXzOHeUq-3qbixhxQ-1; Mon, 03 Nov 2025 04:37:24 -0500
X-MC-Unique: l7hALRXzOHeUq-3qbixhxQ-1
X-Mimecast-MFC-AGG-ID: l7hALRXzOHeUq-3qbixhxQ_1762162643
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c5da68e5so1688818f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 01:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762162643; x=1762767443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D7jmtvMIyGPorJRsPjTVxb3CMnhu4bS5Ues3W4PXBCg=;
 b=qEPcdo4oB7ik1iTrrv8VC7yZiXfu5BPLF8V5drmcnAeLBMO/tfz5+OqG9R6l6B8Pre
 CONND/aKAMBr0Qb+qX7/qL+9iHu5cKgCM6cecPBIAwwKfqdBIo8k2kHirYsUD2SaGUnp
 i48+u9kcLjiDqSg3lWsxbtzDFjrFHd3xvSfDh+tOuLHXlfJwPqqS6rgS0Ocoir8trSAj
 guC5ZAsF2lSOisVv8zfiu50pp1fuFDyVFtmS28V/eCko2E86/hs9XihS4pkefx3cP13a
 Y1iLOnu+NgyvjFPhgblhcEbyaOnQ+XiQANO+88StmSi8m+ux4/olWVmpT/hLYgIhYJcM
 SF3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgHchR+aq0HnXBC/dA7NzkzqlIuUsXEDO0OxQKLmghbSVOKdDWji9UDd8DtaeXve0fa5nGSJpQRLbr@nongnu.org
X-Gm-Message-State: AOJu0Yy39wvNg2ul2z1KMXxJllvlJp2kxzkZTI17HyUo+h/wJE5NU8M5
 z+hJTYaHd30CwSmiQdUtgYKyN9VqA/zXYeZ1YfoWs23MUl1pr+UuyM9NmS8mPZoCAAXl52I6BA1
 nZDqh3zrQGdqo8+TYw1gQSsgRDr7jLh1KpJu923TtizWPtq/m5g+Gsve3
X-Gm-Gg: ASbGncs6O2WrFWeKtbdnOCIAcWi7C+UhUZY92cMTvKLtPI0bN8oxSkBnnvEpRkNVHIv
 neNOc/RHWREC2cwXUK+kLqc1ygdsnqi9/6/3x2kpJFOyDZj0Pt1cBIgsO4LpJNJJG3wvjuYJTsR
 ILaJ+V388TQSpoXViPgYWbYnxqXC4fOpPxacFlPVPxkhGo9Sk2f45n6iGOMZaYZkd8oKvtdKIzW
 NpjfmurFRLBHaghgpHrvHDDn/bDJE5LkYw1flBJaqBZHvKspSnmg7pZrLbl2H8Y9iHiLsn8mUru
 PyQAHaOdAnPfccRuXolzUxOUNT7BXsXBIYo7X5icuuIrdF34gruOrnewvd5KTVS5xqxYoRx81ll
 nYz4UBE4EqYy9P2BH9D9QLedA+0pCA7PTNopb5GwJYUjWTg==
X-Received: by 2002:a05:6000:4020:b0:429:d40e:fa3d with SMTP id
 ffacd0b85a97d-429d40efd89mr1643558f8f.28.1762162643058; 
 Mon, 03 Nov 2025 01:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHilcGVr7xQc4leQRCfIC+SXuMHI+vPG067+k0T+AuG20IHprpyve1WzxhpXv8TAt26wDSLxw==
X-Received: by 2002:a05:6000:4020:b0:429:d40e:fa3d with SMTP id
 ffacd0b85a97d-429d40efd89mr1643358f8f.28.1762162639788; 
 Mon, 03 Nov 2025 01:37:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c110e77esm19053585f8f.10.2025.11.03.01.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 01:37:19 -0800 (PST)
Message-ID: <e1f930b6-ddad-4500-b4a0-ac3dfd8ef7aa@redhat.com>
Date: Mon, 3 Nov 2025 10:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/23] intel_iommu: Bind/unbind guest page table to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-14-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> This captures the guest PASID table entry modifications and propagates
> the changes to host to attach a hwpt with type determined per guest IOMMU
> PGTT configuration.
>
> When PGTT=PT, attach PASID_0 to a second stage HWPT(GPA->HPA).
> When PGTT=FST, attach PASID_0 to nested HWPT with nesting parent HWPT
> coming from VFIO.
>
> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/i386/intel_iommu.h |   1 +
>  hw/i386/intel_iommu.c         | 150 +++++++++++++++++++++++++++++++++-
>  hw/i386/trace-events          |   3 +
>  3 files changed, 151 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 3758ac239c..b5f8a9fc29 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -104,6 +104,7 @@ struct VTDAddressSpace {
>      PCIBus *bus;
>      uint8_t devfn;
>      uint32_t pasid;
> +    uint32_t fs_hwpt;
>      AddressSpace as;
>      IOMMUMemoryRegion iommu;
>      MemoryRegion root;          /* The root container of the device */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 871e6aad19..3789a36147 100644
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
> @@ -42,6 +43,9 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "system/iommufd.h"
> +#ifdef CONFIG_IOMMUFD
> +#include <linux/iommufd.h>
> +#endif
>  
>  /* context entry operations */
>  #define PASID_0    0
> @@ -87,6 +91,7 @@ struct vtd_iotlb_key {
>  
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>  
>  static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>  {
> @@ -98,7 +103,11 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>      g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
>      while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
>          VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> -        pc_entry->valid = false;
> +        if (pc_entry->valid) {
> +            pc_entry->valid = false;
> +            /* It's fatal to get failure during reset */
> +            vtd_bind_guest_pasid(vtd_as, &error_fatal);
> +        }
>      }
>  }
>  
> @@ -2380,6 +2389,128 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>      vtd_iommu_replay_all(s);
>  }
>  
> +#ifdef CONFIG_IOMMUFD
> +static int vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                              VTDPASIDEntry *pe, uint32_t *fs_hwpt,
> +                              Error **errp)
> +{
> +    struct iommu_hwpt_vtd_s1 vtd = {};
> +
> +    vtd.flags = (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE : 0) |
> +                (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE : 0) |
> +                (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE : 0);
> +    vtd.addr_width = vtd_pe_get_fs_aw(pe);
> +    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
> +
> +    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                       idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                       sizeof(vtd), &vtd, fs_hwpt, errp);
see comments below
> +}
> +
> +static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                    VTDAddressSpace *vtd_as)
> +{
> +    if (!vtd_as->fs_hwpt) {
> +        return;
> +    }
> +    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt);
> +    vtd_as->fs_hwpt = 0;
> +}
> +
> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> +    uint32_t hwpt_id;
> +    bool ret;
> +
> +    /*
> +     * We can get here only if flts=on, the supported PGTT is FST and PT.
is FST or PT
> +     * Catch invalid PGTT when processing invalidation request to avoid
> +     * attaching to wrong hwpt.
> +     */
> +    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
> +        error_setg(errp, "Invalid PGTT type");
print the wrong PGTT value?
> +        return -EINVAL;
> +    }
> +
> +    if (vtd_pe_pgtt_is_pt(pe)) {
> +        hwpt_id = idev->hwpt_id;
> +    } else if (vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, !ret);
why !ret in the trace? I think e chose to return true on success for

host_iommu_device_iommufd_attach_hwpt()

. Let's keep this consistent otherwise we end up not knowning what is
the success value.
> +    if (ret) {
> +        /* Destroy old fs_hwpt if it's a replacement */
> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +        if (vtd_pe_pgtt_is_fst(pe)) {
> +            vtd_as->fs_hwpt = hwpt_id;
> +        }
> +    } else if (vtd_pe_pgtt_is_fst(pe)) {
> +        iommufd_backend_free_id(idev->iommufd, hwpt_id);
> +    }
> +
> +    return !ret;
argh. Eventually it is difficult to follow ;-)
> +}
> +
> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint32_t pasid = vtd_as->pasid;
> +    bool ret;
> +
> +    if (s->dmar_enabled && s->root_scalable) {
> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, !ret);
> same
> +    } else {
> +        /*
> +         * If DMAR remapping is disabled or guest switches to legacy mode,
> +         * we fallback to the default HWPT which contains shadow page table.
> +         * So guest DMA could still work.
> +         */
> +        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +                                           !ret);
same
> +    }
> +
> +    if (ret) {
> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +    }
> +
> +    return !ret;
> +}
> +
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +    int ret;
> +
> +    /* Ignore emulated device or legacy VFIO backed device */
> +    if (!vtd_hiod) {
> +        return 0;
> +    }
> +
> +    if (pc_entry->valid) {
> +        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
return directly
> +    } else {
remove the else and return directly?
> +        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
> +    }
> +
> +    return ret;
> +}
> +#else
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    return 0;
> +}
> +#endif
> +
>  /* Do a context-cache device-selective invalidation.
>   * @func_mask: FM field after shifting
>   */
> @@ -3134,6 +3265,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>      VTDPASIDEntry pe;
>      IOMMUNotifier *n;
>      uint16_t did;
> +    const char *err_prefix;
> +    Error *local_err = NULL;
>  
>      if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>          if (!pc_entry->valid) {
> @@ -3154,7 +3287,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>              vtd_address_space_unmap(vtd_as, n);
>          }
>          vtd_switch_address_space(vtd_as);
> -        return;
> +
> +        err_prefix = "Detaching from HWPT failed: ";
> +        goto do_bind_unbind;
>      }
>  
>      /*
> @@ -3182,12 +3317,21 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>      if (!pc_entry->valid) {
>          pc_entry->pasid_entry = pe;
>          pc_entry->valid = true;
> -    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        err_prefix = "Attaching to HWPT failed: ";
> +    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        err_prefix = "Replacing HWPT attachment failed: ";
> +    } else {
>          return;
>      }
>  
>      vtd_switch_address_space(vtd_as);
>      vtd_address_space_sync(vtd_as);
> +
> +do_bind_unbind:
> +    /* TODO: Fault event injection into guest, report error to QEMU for now */
> +    if (vtd_bind_guest_pasid(vtd_as, &local_err)) {
> +        error_reportf_err(local_err, "%s", err_prefix);
> +    }
>  }
>  
>  static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index b704f4f90c..5a3ee1cf64 100644
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
Eric


