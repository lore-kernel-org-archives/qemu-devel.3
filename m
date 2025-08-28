Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC0C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZAV-0004hH-Mi; Thu, 28 Aug 2025 05:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urZAS-0004fA-3g
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urZAO-0000Ge-SC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756374214;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iYg1EHSM0ZmSmZx5fmHShD7AG8YvHPbOOPnmvAiSdY=;
 b=KwM8kA2DScOFOkmXFHK4w1uJuv3pvcgCObBRBmTiGCaPvQM8khqz5RsCVE1p4wlDp6HFcO
 2juu4XXNC1PoB5iUmuEirs8CmnAxLrHUspqeR8Rlrf53eZDViInezaL+WYw3Q0Pm1G+EPz
 uemsV6HnJHW430xUaCQmOFpaOfdQLWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ThHFcLEwP8mZ6e2DuQYQvQ-1; Thu, 28 Aug 2025 05:43:31 -0400
X-MC-Unique: ThHFcLEwP8mZ6e2DuQYQvQ-1
X-Mimecast-MFC-AGG-ID: ThHFcLEwP8mZ6e2DuQYQvQ_1756374210
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b51411839so3994515e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 02:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756374210; x=1756979010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0iYg1EHSM0ZmSmZx5fmHShD7AG8YvHPbOOPnmvAiSdY=;
 b=HqkoYnloIU86ge75vnS2eVeocHkUBDthaWZfGmD3Ge/HeK0K9M+at6oX2B4gm/ENGB
 4113FGhiAs2bXL8Wxm5nKO3zQiPfPMJIxqC8yvlE8Yk16uYZkWroDjOKnQtXyDpTuI0C
 rozmW1r0R+ltLIoXDQ+c025Mz4bw9Ir4Lt0F+1zTP9eQvaafUXxCmXGZIfUPrHWhAwR3
 RxBjGjpsdSBdz/iTPVBeQCcD+tGBiu7rUZYWSAfI+V8SxvpjFX1zJkN2bn8fckiB8wX6
 6T2T/ul2Plr00glSomcQgwmGbJ0JLN8ryJIZxP9+WpZ7wAfwb+/Y7DE3PQd9HhMA6bQI
 KNqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6kGGWqdQyR1++0vqQ3ZfrSHQSrVzM7jN5PYqZZPIVK2JyeemNUdYBQ6mPWn9s3u0dRwxOVxr6oUqS@nongnu.org
X-Gm-Message-State: AOJu0Yw87MH7MorbMDBJl3E2Si/MLcWH1AC/+r8Omivk9nR/jppCQFEq
 C/Nmq7KsZ7ZkQENaQu5yqiQ5uT0tZs1k3Xr6zdK90gpsBLC83ou4LIPLCY4uuYOJEfYU3rQpdgo
 vR8D7rFaL7sE4o3wO6aV93ci6YmSnad+OUP9raIRVhzY4tcwKVWjGWmip
X-Gm-Gg: ASbGncvapUEp4YR4TLcv7s4FZt5BMs2qfefykybh1ulaot8DTP34KCDBRIVBZ2NbWPV
 2XbpG8C5ndtmSpNn1GOLfiDefJ+pJBxBsJ4oXGGTzydv0m4qevXWHEu3dZhqBo2gAR7L98kTDyt
 EnDiCvQQjxcTNaXM8zqHrZEbve0he6QlZcNvwHcYtAhJYlnHPw0aMvi8jHW06UaGHYyiOKu88pS
 1GIRKuw8hBD0A4q3tPWtB+eEKSxwcMsNNqvwEI5Eq20EuCHzHKC1UIJVwdDMuIW7Sn0sB8TAUg8
 BJJLiHbi08XDVpWMXwgmAbPYDt1nKBAulCu9rHCmxstg2Z2EnexXrmIWlaQf893XGAUYM1X7tRz
 rMX0dNHTEcLs=
X-Received: by 2002:a05:600c:4348:b0:459:d616:25c5 with SMTP id
 5b1f17b1804b1-45b5213bb88mr134703665e9.12.1756374209634; 
 Thu, 28 Aug 2025 02:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTucv3HVh8BpooibAbBNDjCAIGKm445BWn/fKkpk9GsGYXbLQMvdDvVetWd1DPcSGliYa7EQ==
X-Received: by 2002:a05:600c:4348:b0:459:d616:25c5 with SMTP id
 5b1f17b1804b1-45b5213bb88mr134703455e9.12.1756374209150; 
 Thu, 28 Aug 2025 02:43:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm66180055e9.16.2025.08.28.02.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 02:43:28 -0700 (PDT)
Message-ID: <ed8f5d83-0bcf-4685-a362-cbb948b01baa@redhat.com>
Date: Thu, 28 Aug 2025 11:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after context
 cache invalidation
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-17-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
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



On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This replays guest pasid bindings after context cache invalidation.
> This is a behavior to ensure safety. Actually, programmer should issue
> pasid cache invalidation with proper granularity after issuing a context
> cache invalidation.
So is this mandated? If the spec mandates specific invalidations and the
guest does not comply with the expected invalidation sequence shall we
do that behind the curtain?
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  2 ++
>  hw/i386/intel_iommu.c          | 42 ++++++++++++++++++++++++++++++++++
>  hw/i386/trace-events           |  1 +
>  3 files changed, 45 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 61e35dbdc0..8af1004888 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -584,6 +584,8 @@ typedef enum VTDPCInvType {
>  
>      /* Reset all PASID cache entries, used in system level reset */
>      VTD_PASID_CACHE_FORCE_RESET = 0x10,
> +    /* Invalidate all PASID entries in a device */
> +    VTD_PASID_CACHE_DEVSI,
invalidation type that is not defined in the spec. I would avoid and
find another solution if you really need to do such kind of invalidation.
>  } VTDPCInvType;
>  
>  typedef struct VTDPASIDCacheInfo {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a10ee8eb4f..6c0e502d1c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -91,6 +91,10 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  
>  static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> +                                 VTDPASIDCacheInfo *pc_info);
> +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> +                                  PCIBus *bus, uint16_t devfn);
>  
>  static void vtd_panic_require_caching_mode(void)
>  {
> @@ -2442,6 +2446,8 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
>  
>  static void vtd_context_global_invalidate(IntelIOMMUState *s)
>  {
> +    VTDPASIDCacheInfo pc_info;
> +
>      trace_vtd_inv_desc_cc_global();
>      /* Protects context cache */
>      vtd_iommu_lock(s);
> @@ -2459,6 +2465,9 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>       * VT-d emulation codes.
>       */
>      vtd_iommu_replay_all(s);
> +
> +    pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
> +    vtd_pasid_cache_sync(s, &pc_info);
I would put this addition in a separate patch because it does not need
the new

VTD_PASID_CACHE_DEVSI stuff

>  }
>  
>  #ifdef CONFIG_IOMMUFD
> @@ -2691,6 +2700,15 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
>               * happened.
>               */
>              vtd_address_space_sync(vtd_as);
> +            /*
> +             * Per spec, context flush should also be followed with PASID
> +             * cache and iotlb flush. In order to work with a guest which
> +             * doesn't follow spec and missed PASID cache flush, we have
> +             * vtd_pasid_cache_devsi() to invalidate PASID caches of the
> +             * passthrough device. Host iommu driver would flush piotlb
> +             * when a pasid unbind is pass down to it.
> +             */
> +             vtd_pasid_cache_devsi(s, vtd_as->bus, devfn);
>          }
>      }
>  }
> @@ -3422,6 +3440,11 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
>          break;
>      case VTD_PASID_CACHE_FORCE_RESET:
>          goto remove;
> +    case VTD_PASID_CACHE_DEVSI:
> +        if (pc_info->bus != vtd_as->bus || pc_info->devfn != vtd_as->devfn) {
> +            return false;
> +        }
> +        break;
>      default:
>          error_setg(&error_fatal, "invalid pc_info->type for flush");
>      }
> @@ -3635,6 +3658,11 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>      case VTD_PASID_CACHE_FORCE_RESET:
>          /* For force reset, no need to go further replay */
>          return;
> +    case VTD_PASID_CACHE_DEVSI:
> +        walk_info.bus = pc_info->bus;
> +        walk_info.devfn = pc_info->devfn;
> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
> +        return;
>      default:
>          error_setg(&error_fatal, "invalid pc_info->type for replay");
>      }
> @@ -3683,6 +3711,20 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>      vtd_replay_guest_pasid_bindings(s, pc_info);
>  }
>  
> +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> +                                  PCIBus *bus, uint16_t devfn)
> +{
> +    VTDPASIDCacheInfo pc_info;
> +
> +    trace_vtd_pasid_cache_devsi(devfn);
> +
> +    pc_info.type = VTD_PASID_CACHE_DEVSI;
> +    pc_info.bus = bus;
> +    pc_info.devfn = devfn;
> +
> +    vtd_pasid_cache_sync(s, &pc_info);
> +}
> +
>  static bool vtd_process_pasid_desc(IntelIOMMUState *s,
>                                     VTDInvDesc *inv_desc)
>  {
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 1c31b9a873..830b11f68b 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -28,6 +28,7 @@ vtd_pasid_cache_reset(void) ""
>  vtd_pasid_cache_gsi(void) ""
>  vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
>  vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
> +vtd_pasid_cache_devsi(uint16_t devfn) "Dev selective PC invalidation dev: 0x%"PRIx16
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
Eric


