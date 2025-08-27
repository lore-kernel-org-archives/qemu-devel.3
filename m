Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B59CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJ1K-0000nc-I2; Wed, 27 Aug 2025 12:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urJ1F-0000mm-L4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urJ1B-0002x2-QU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756312138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJ31tsxD6I7JX3ywPBhd83+DOp3d8ReEDszxelaubyc=;
 b=HcULxOZD/8vykdXozeD06tl2083n2jmDAVX191H8ILqcKxC5PalmRHexqZv+y2gc/jMhH1
 DtOYPFGzZtLPxkBvJccJBgb5fj3FQEtB3KzoWhefik1HgoPS1gejV5nbKx7tYDeWWK8p6E
 HNNBc00E6MOhWRhD+BK7vwxEx/GTs6w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-lbN2gbmHMn6tJ73kHjvKiw-1; Wed, 27 Aug 2025 12:28:56 -0400
X-MC-Unique: lbN2gbmHMn6tJ73kHjvKiw-1
X-Mimecast-MFC-AGG-ID: lbN2gbmHMn6tJ73kHjvKiw_1756312136
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b6490ea91so11721815e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 09:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756312135; x=1756916935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJ31tsxD6I7JX3ywPBhd83+DOp3d8ReEDszxelaubyc=;
 b=U9uDAu02yyW/xdNyv3ASgiFwWzhSbhyP/a3vyLsQ6IsmFbC7wnyW2FLO+Pm3JS/TAk
 mTiVybjV2HfwIvi/Fgz6sBSxlEe1/RDeqgGeb97don0RpkAh60R/z/kZAPAOTo6SqF2Q
 MAZIYqmOa14EfGJ+fUXLMEbGIonTWbIxv4oRAHaACqqOUxLSG4uNW5mwVc5cFa+9YVNZ
 VlhqQ+Zxdm6lIV0swUi4XrTnciAeB+ekftIUjis1x1tb3GAF5yBEva9k6TNmCqUeFos6
 Lk85T7P3Y+mcDjJ53tGl+UYSIWZ0/KHxlec/ib1oeeit2qtrAkEPGUbRag9msZ3FsaeP
 6O1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8bmyZPzGq6vhLdL/l7pqbis7G2ZCiVIW6hIfeK+4zCwKldhs+N1JuyXr1paIH+WfW3BWThx6HZzmi@nongnu.org
X-Gm-Message-State: AOJu0Yw+iWKmEEXmwhsvNVmajsvcxury0yefUaWuZyFn4QuT/qN0OgFW
 nxfMiUMR1g5MkJgx/9jafKh381n1/1D+Eaa5l0OXLJNyD7lwNz1MjZnxEkCryIeBbR568aZa85B
 jDpGZGzmj0V15gKmRck1kgBkA6/aOypOvo2N0DGRsU/yXG9G+EvfDC/HKRghk6Hgc8hI=
X-Gm-Gg: ASbGncvh34tY4kiw3zHISZKDCoR//Vk+s5MuyuM36J1dfF75GemhWUeWlCQMUEZBNUA
 fe/dQJOfvVI5rQwYvjrjKhZzts/yl0PzEX4zGipiIBgb6ot6M2rEJ4jnvxA/zazp6+H54Umljpc
 f7ye5sFblulro+b22xKwm43HWwnaLZTPcVZ4O40xqNyQlubbpSzL5VPTguw5ZpHvnZ1f0YSEqld
 ODlw5eELnsIOD+uLjGYcRaZAsaVp2imVIlalLDie7uBnzaYQEPqwSFHWRVjBo1sZz08qMKhRUZC
 s+Ed2C/xTiK+tHqSPsQI2HEPZq8JVWPuJy0v2en41ipfpqGc0DyFhMTBGPpJH3sYhmXfqOvMA3P
 1qaS05keJhVo=
X-Received: by 2002:a05:600c:1c9d:b0:45b:6684:9e07 with SMTP id
 5b1f17b1804b1-45b685d740emr48773365e9.32.1756312135367; 
 Wed, 27 Aug 2025 09:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgBl9ESmuxKxJv70CYDawsDLCsmsgnXtKA+W9mPs1jGAgG9vxT/jR3XrNUYpr6twI7OcEkVg==
X-Received: by 2002:a05:600c:1c9d:b0:45b:6684:9e07 with SMTP id
 5b1f17b1804b1-45b685d740emr48773185e9.32.1756312134963; 
 Wed, 27 Aug 2025 09:28:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd935931ebsm631684f8f.55.2025.08.27.09.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 09:28:54 -0700 (PDT)
Message-ID: <c53b7bc6-fe76-4357-9eba-56f4c3111fa9@redhat.com>
Date: Wed, 27 Aug 2025 18:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/21] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-14-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
> FORCE_RESET is different from GLOBAL_INV which updates pasid cache if
> underlying pasid entry is still valid, it drops all the pasid caches.
>
> FORCE_RESET isn't a VTD spec defined invalidation type for pasid cache,
> only used internally in system level reset.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  9 +++++++++
>  hw/i386/intel_iommu.c          | 25 +++++++++++++++++++++++++
>  hw/i386/trace-events           |  1 +
>  3 files changed, 35 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index fb2a919e87..c510b09d1a 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -569,6 +569,15 @@ typedef enum VTDPCInvType {
>      VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
>      VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
>      VTD_PASID_CACHE_GLOBAL_INV = VTD_INV_DESC_PASIDC_G_GLOBAL,
> +
> +    /*
> +     * Internally used PASID cache invalidation type starts here,
> +     * 0x10 is large enough as invalidation type in pc_inv_desc
> +     * is 2bits in size.
> +     */
> +
> +    /* Reset all PASID cache entries, used in system level reset */
> +    VTD_PASID_CACHE_FORCE_RESET = 0x10,
I am not very keen on adding such an artifical enum value that does not
exist in the spec.

Why not simply introduce another function (instead of
vtd_flush_pasid_locked) that does the cleanup. To me it would be
cleaner. Thanks Eric
>  } VTDPCInvType;
>  
>  typedef struct VTDPASIDCacheInfo {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 7d2c9feae7..af384ce7f0 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -87,6 +87,8 @@ struct vtd_iotlb_key {
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  
> +static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
> +
>  static void vtd_panic_require_caching_mode(void)
>  {
>      error_report("We need to set caching-mode=on for intel-iommu to enable "
> @@ -391,6 +393,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>      vtd_iommu_lock(s);
>      vtd_reset_iotlb_locked(s);
>      vtd_reset_context_cache_locked(s);
> +    vtd_pasid_cache_reset_locked(s);
>      vtd_iommu_unlock(s);
>  }
>  
> @@ -3183,6 +3186,8 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
>          /* fall through */
>      case VTD_PASID_CACHE_GLOBAL_INV:
>          break;
> +    case VTD_PASID_CACHE_FORCE_RESET:
> +        goto remove;
>      default:
>          error_setg(&error_fatal, "invalid pc_info->type for flush");
>      }
> @@ -3225,6 +3230,23 @@ remove:
>      return true;
>  }
>  
> +static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
> +{
> +    VTDPASIDCacheInfo pc_info;
> +
> +    trace_vtd_pasid_cache_reset();
> +
> +    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
> +
> +    /*
> +     * Reset pasid cache is a big hammer, so use g_hash_table_foreach_remove
> +     * which will free all vtd_as instances except those created for PCI
> +     * sub-system.
> +     */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces,
> +                                vtd_flush_pasid_locked, &pc_info);
> +}
> +
>  /*
>   * This function walks over PASID range within [start, end) in a single
>   * PASID table for entries matching @info type/did, then retrieve/create
> @@ -3363,6 +3385,9 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>      case VTD_PASID_CACHE_GLOBAL_INV:
>          /* loop all assigned devices */
>          break;
> +    case VTD_PASID_CACHE_FORCE_RESET:
> +        /* For force reset, no need to go further replay */
> +        return;
>      default:
>          error_setg(&error_fatal, "invalid pc_info->type for replay");
>      }
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index ae5bbfcdc0..c8a936eb46 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>  vtd_inv_qi_tail(uint16_t head) "write tail %d"
>  vtd_inv_qi_fetch(void) ""
>  vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_reset(void) ""
>  vtd_pasid_cache_gsi(void) ""
>  vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
>  vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32


