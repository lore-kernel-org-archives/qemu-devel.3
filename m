Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80E1D3C934
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 17:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTOD8-0001p6-FI; Wed, 10 Dec 2025 12:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTOD6-0001oQ-9Y
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTOD3-0004o8-6s
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765388559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tl1HG/c8K32eezyeVlzzx6PQAgovlU0uRSaH0iww2Sg=;
 b=USQFAsNkF8cCj4dGnwq8ob/jiWVRAPFWyxuHZ3BFRSPJiSnnBI7DcIIombKU9dqWoj9NVU
 xX/W0xJybPEfrTH8hrJC6G9NJgcq59BKf+AdD5fhDD4t+q4dFbWSaB3kWkKn27WIvs8o5D
 78KX/cevG3VsnMPA2Yz0Hq+xnyIY5KQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694--IYNgqajNxiykA4-fDVVxA-1; Wed, 10 Dec 2025 12:42:38 -0500
X-MC-Unique: -IYNgqajNxiykA4-fDVVxA-1
X-Mimecast-MFC-AGG-ID: -IYNgqajNxiykA4-fDVVxA_1765388557
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-295592eb5dbso2395705ad.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 09:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765388557; x=1765993357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tl1HG/c8K32eezyeVlzzx6PQAgovlU0uRSaH0iww2Sg=;
 b=I80wgOaYkQ2NdBF+i5IAny+owKRk/NaI3UpVaigoAtshT9qcHpz92yCfGI0F1W/7n+
 BClRqou8Ug6aA5qyIpuWMsXPp4TPDOJUpy5NLQo2FHzVHBLoHWUxwoEZGnC4GKiLOQ5o
 eJatOMHvhhCtcx+jf3+en/2u3pNIRFzRXl7D3N8z+rxtf+2by+n4CoevrWXYMjB5iR02
 /aNIQYo3B931fg3CLjS6hx4Gld07cvf+vKpD6gVBkVdX3mXdVNwgFrxCPLldNLjwAz5S
 kOlt107ohl+C7ArFX2KDdDeUWo4uPLKYHhvYuQ+lS994kAY2S8L3P3NtJv2opFdEPP/1
 gQTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz7d/R8kDYAOw+BaJ4m4TIa5eRo0U85r6NgrsO80o3bqlJ+urVC3wRi2oO7Kx3RONKS40AkD1Lh5Bp@nongnu.org
X-Gm-Message-State: AOJu0YwIZiaDBxriSlnoUPHv2TRkf8Ds+sakSLpxVxUjyqOL4q4vhqbf
 24sGhH6UmPaHOwc5DuS1R9VdKUVt5FuOTAhE9Du/IVNt2Otqs1XtHq+AHmzQveSuTkrfczQDlvQ
 FwomeCxQ7ZHncPHySYQM1y30p7l4fEFx3Te27wsoQzeEI12bfJD47gnJF
X-Gm-Gg: AY/fxX4X1gsu+JvcdL7HUx6LfAs06q24TdLcPvRHzHJnd4dUOnuoJeIpKTupOPysNbI
 20FV7pvADL4iqSI3wZxFymTACGcDnaukOYpMnCpaz/EyCFd+z6upfzAkedtcA1W8wsqdn2hCU3u
 K3lDH3nEt4Cd9uJsoKS1uSSlU2sr8iEDVr4jDPJ2ozLzPod3oFTY5Tfv3PSuwBJSD0agWSyXYU9
 gwHsD0xrxjWedHph5Q4jR6zlQaUp+ttasROg1d4moo3tM0CXgJlvelcRZvJIYoWWu1JXXWnns6J
 U25+RJVO4zLS/TmlaY2w62gBupUsssBhqTaPASLLEbkwthJjiVWpZWNf3dJeM3x54dIrXXGu99L
 TrWJOzdCYrIGJSmsfAaQ17Rr1qmXNX2NQ/A/RKioVtSRDupF+i/NSlXtXUw==
X-Received: by 2002:a17:902:f54e:b0:297:c638:d7c9 with SMTP id
 d9443c01a7336-29ec22c981fmr29845195ad.13.1765388557234; 
 Wed, 10 Dec 2025 09:42:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC2nzONtJG1YICMOs8x2LrQ9UNCYB+M1ADlfHD4WAWuRZinhxTFlExD/ENsJ1dzJb4ABdfhQ==
X-Received: by 2002:a17:902:f54e:b0:297:c638:d7c9 with SMTP id
 d9443c01a7336-29ec22c981fmr29844925ad.13.1765388556592; 
 Wed, 10 Dec 2025 09:42:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29daeaabf7csm189130715ad.79.2025.12.10.09.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 09:42:36 -0800 (PST)
Message-ID: <52703428-96c5-4b18-b7e8-ccc3c38e2cd2@redhat.com>
Date: Wed, 10 Dec 2025 18:42:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/23] intel_iommu_accel: Bind/unbind guest page table
 to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-14-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251117093729.1121324-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
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
>  hw/i386/intel_iommu_accel.h   |   6 ++
>  include/hw/i386/intel_iommu.h |   1 +
>  hw/i386/intel_iommu.c         |  22 ++++++-
>  hw/i386/intel_iommu_accel.c   | 114 ++++++++++++++++++++++++++++++++++
>  hw/i386/trace-events          |   3 +
>  5 files changed, 143 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index dbe6ee6982..1a396c50a0 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -16,6 +16,7 @@
>  bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                            Error **errp);
>  VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
> +bool vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>  #else
>  static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>                                          VTDHostIOMMUDevice *vtd_hiod,
> @@ -30,5 +31,10 @@ static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>  {
>      return NULL;
>  }
> +
> +static inline bool vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    return true;
> +}
>  #endif
>  #endif
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 401322665a..8ce8fe1b75 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -104,6 +104,7 @@ struct VTDAddressSpace {
>      PCIBus *bus;
>      uint8_t devfn;
>      uint32_t pasid;
> +    uint32_t fs_hwpt;
nit use fs_hwpt_id
>      AddressSpace as;
>      IOMMUMemoryRegion iommu;
>      MemoryRegion root;          /* The root container of the device */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 513b2c85d4..36449bf161 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -88,7 +88,11 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>      g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
>      while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
>          VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> -        pc_entry->valid = false;
> +        if (pc_entry->valid) {
> +            pc_entry->valid = false;
> +            /* It's fatal to get failure during reset */
could you elaborate on this. Why is it more fatal on reset that on other
circumstances which do not abort?
> +            vtd_bind_guest_pasid(vtd_as, &error_fatal);
> +        }
>      }
>  }
>  
> @@ -3074,6 +3078,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>      VTDPASIDEntry pe;
>      IOMMUNotifier *n;
>      uint16_t did;
> +    const char *err_prefix = "Attaching to HWPT failed: ";
> +    Error *local_err = NULL;
>  
>      if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>          if (!pc_entry->valid) {
> @@ -3094,7 +3100,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
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
> @@ -3122,12 +3130,20 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>      if (!pc_entry->valid) {
>          pc_entry->pasid_entry = pe;
>          pc_entry->valid = true;
> -    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
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
> +    if (!vtd_bind_guest_pasid(vtd_as, &local_err)) {
> +        error_reportf_err(local_err, "%s", err_prefix);
> +    }
>  }
>  
>  static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index ebfc503d64..66570ea919 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -13,6 +13,7 @@
>  #include "intel_iommu_internal.h"
>  #include "intel_iommu_accel.h"
>  #include "hw/pci/pci_bus.h"
> +#include "trace.h"
>  
>  bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                            Error **errp)
> @@ -68,3 +69,116 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>      }
>      return NULL;
>  }
> +
> +static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                               VTDPASIDEntry *pe, uint32_t *fs_hwpt,
> +                               Error **errp)
> +{
> +    struct iommu_hwpt_vtd_s1 vtd = {};
> +
> +    vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
> +                (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
> +                (VTD_SM_PASID_ENTRY_EAFE(pe) ? IOMMU_VTD_S1_EAFE : 0);
> +    vtd.addr_width = vtd_pe_get_fs_aw(pe);
> +    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
> +
> +    return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
> +                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
> +                                      &vtd, fs_hwpt, errp);
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
is it a valid assumption a valid ID cannot be null? Is it documented
somewhere?
> +}
> +
> +static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                      VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> +    uint32_t hwpt_id;
nit init to idev->hwpt_id
> +    bool ret;
> +
> +    /*
> +     * We can get here only if flts=on, the supported PGTT is FST or PT.
> +     * Catch invalid PGTT when processing invalidation request to avoid
> +     * attaching to wrong hwpt.
> +     */
> +    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
> +        error_setg(errp, "Invalid PGTT type %d",
> +                   (uint8_t)VTD_SM_PASID_ENTRY_PGTT(pe));
> +        return false;
> +    }
> +
> +    if (vtd_pe_pgtt_is_pt(pe)) {
> +        hwpt_id = idev->hwpt_id;
> +    } else if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
> +        return false;
> +    }
and 

if (vtd_pe_pgtt_is_fst(pe)) {
    if ((!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp) {
        return false;
    }

}
this will match free block below
> +
> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
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
> +    return ret;
> +}
> +
> +static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                      VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint32_t pasid = vtd_as->pasid;
> +    bool ret;
> +
> +    if (s->dmar_enabled && s->root_scalable) {
> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
> +    } else {
> +        /*
> +         * If DMAR remapping is disabled or guest switches to legacy mode,
> +         * we fallback to the default HWPT which contains shadow page table.
> +         * So guest DMA could still work.
> +         */
> +        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +                                           ret);
> +    }
> +
> +    if (ret) {
> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +    }
> +
> +    return ret;
> +}
> +
> +bool vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
I find it a little bit confusing to have bind doing the unbind too.
at least I would rename into vtd_propagate_guest_pasid or something alike.
> +{
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +
> +    /* Ignore emulated device or legacy VFIO backed device */
> +    if (!vtd_as->iommu_state->fsts || !vtd_hiod) {
> +        return true;
> +    }
> +
> +    if (pc_entry->valid) {
> +        return vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
> +    }
> +
> +    return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
> +}
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
Thanks

Eric


