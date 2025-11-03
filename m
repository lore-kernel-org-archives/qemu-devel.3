Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70D1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFxBI-0006sd-5z; Mon, 03 Nov 2025 11:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vFxB9-0006qm-Ps
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:13:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vFxAv-00023R-2N
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762186358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hWo1/nJPhIdRTn8IqlgddQrmQ8L4Lji2d5h86zfv6J0=;
 b=YoZXgHCqHwFoCRlmqCM/oocaU+6pxoVk9W2frE6ufO+hgqbi2t1c9QB0z3lHOTyZEATO3e
 zNXvzHJmT+CcB/QzmEd7S1uInHs7wHcEwkqvxlD0NtUrd1r4cbW697VqEggvrJpvAU26aA
 9OcjlbVJtdtZJxQ3O0POK7oQG2xuvNk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-iPFsLe-PO--u_TgvHjftbg-1; Mon, 03 Nov 2025 11:12:35 -0500
X-MC-Unique: iPFsLe-PO--u_TgvHjftbg-1
X-Mimecast-MFC-AGG-ID: iPFsLe-PO--u_TgvHjftbg_1762186351
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477212937eeso33004555e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762186351; x=1762791151; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hWo1/nJPhIdRTn8IqlgddQrmQ8L4Lji2d5h86zfv6J0=;
 b=oanh3uJaYWgjLB2h/XzULxdnjQwbzglUC5xA86oL9xOJpPg6r/wRkC2/V7nJAbRY62
 DYrmyJ4mgVyofYckoG68gSk/i1Dak1USvtCW1taXKesYwzEmG6ZX5q4Z+gM6Ap6sWMmS
 Qg7P9O8QiTSzGtm5JJuv3cGLE28CoLomcSQ6o3eDdoLnZZ4O3tKX6wj/qwYdaZyvrU1Q
 6HBMI80j9qbC+dvQ20qu+aJ5cIOeTqVbhlhX5YxvKs3Kj3rRYA4RorX4wqiJjBMaj/MK
 tP+kNhrHqyZdCyM13PKnjknpESNNfw/kqfZUrN/xge/lYjNnHc/2xlaPQvk/oPbqZT1F
 XNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762186351; x=1762791151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWo1/nJPhIdRTn8IqlgddQrmQ8L4Lji2d5h86zfv6J0=;
 b=hMoRyOAlKgJurqItw+Z10DMyIAY8mabj5xirergyUL3ezEtjPgxJIIefXSk21dOY1M
 tIBlwoa4ZNYtT3iiNopjIf3+A8jdXlPr99SO36Mm9sS2zsVSXusJIPkfbMTlOO0RqRWb
 2U43HYPm+Ttcqh/M3kMmzSJntdHZ1b7lvwqNkKjCLVWHBSHcc6D+jlwaU0qjWhz2vvEK
 qcdiVVhGio811J/EjcpU1mto2/eGaLzRGSoA7jXWKLGAsB3jui1eKcYh+SPlQ1yfoRQ0
 ywfgBAd2smzX01JkF0IYNvq5KaX01JNEbSlll6bsIzrm2mmtMnQRUr2hpBAv7HeWfWWO
 9NRQ==
X-Gm-Message-State: AOJu0YzCYfJkegmUlNwZPGbxmyCelfQrSimRWRgVI95/CR+qIwaudBnS
 JNEIVMtdWCrFn+4Rs4e8X/oK7d8O4YacDxM2WxowWX+1i6iW0+nJ9ezbDgg+5XKZy/Ek/EbcflJ
 2HiDRiB7mNstmsqCMpqovZmrd8X/DTd13wVhBeiuoXNiOBGp8Sh2jsRlr
X-Gm-Gg: ASbGnctoG+LYtX0gTZh+/eo+pxvCCWOZTdNcuEtffmiCFSLie9zP6HGLGn4yQ4jhOcC
 6cmp03pBRsv0hhPOaxUjolz44Rjql5L2TLBFEG3KFJW8+iwlC8K43hOBmZ+PurJekBBUD4v90kU
 Qzq7iUWsmhWfF42gmFjEG+ZZxKp7jWHV2amDWx9bpz/OsMoiOBqIN2rnr0VCATa/iFL/g0Rjdjg
 4o5VoKdGPDczOVS/yru4LRs3cRbPjb0g/E2lEu4PvK6hqve1QGLIA8UQnxT6N9AvzO7SJvgmjqU
 AiGZlSYvXNzkuGYqQ17z6a4JTXMKRdd7ehOD5+NERULCiUp/Oa8wq2wC1W+YzSE=
X-Received: by 2002:a05:600c:3b1f:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-477308aec7bmr122532845e9.36.1762186351083; 
 Mon, 03 Nov 2025 08:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0Qu8VK4/Hi5rlvTC4f8Q2WJc5LLD7wH5VXRwUlw9bILCUkyiuROLe/etXEkjR5KIyjc9nYg==
X-Received: by 2002:a05:600c:3b1f:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-477308aec7bmr122532485e9.36.1762186350486; 
 Mon, 03 Nov 2025 08:12:30 -0800 (PST)
Received: from redhat.com ([31.187.78.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48daa0sm167427025e9.3.2025.11.03.08.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:12:29 -0800 (PST)
Date: Mon, 3 Nov 2025 11:12:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, alejandro.j.jimenez@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, aik@amd.com
Subject: Re: [PATCH v3 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
Message-ID: <20251103111145-mutt-send-email-mst@kernel.org>
References: <20251017061322.1584-1-sarunkod@amd.com>
 <20251017061322.1584-3-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017061322.1584-3-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 17, 2025 at 11:43:22AM +0530, Sairaj Kodilkar wrote:
> Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
> to read or write from a given DMA address, IOMMU translates the address
> using page table assigned to that device. Since IOMMU uses per device page
> tables, the emulated IOMMU should use the cache tag of 68 bits
> (64 bit address - 12 bit page alignment + 16 bit device ID).
> 
> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
> to 60 bits. This causes failure while setting up the device when guest is
> booted with "iommu.forcedac=1".
> 
> To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
> entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
> the devid to construct the 64 bit hash key in order avoid the truncation

to avoid

> as much as possible (reducing hash collisions).
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
>  hw/i386/amd_iommu.h |  4 ++--
>  2 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index c2cd5213eb1b..5487894aba40 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -106,6 +106,11 @@ typedef struct AMDVIAsKey {
>      uint8_t devfn;
>  } AMDVIAsKey;
>  
> +typedef struct AMDVIIOTLBKey {
> +    uint64_t gfn;
> +    uint16_t devid;
> +} AMDVIIOTLBKey;
> +
>  uint64_t amdvi_extended_feature_register(AMDVIState *s)
>  {
>      uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
>               PCI_STATUS_SIG_TARGET_ABORT);
>  }
>  
> -static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
> -{
> -    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
> -}
> -
> -static guint amdvi_uint64_hash(gconstpointer v)
> -{
> -    return (guint)*(const uint64_t *)v;
> -}
> -
>  static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>  {
>      const AMDVIAsKey *key1 = v1;
> @@ -425,11 +420,30 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
>                               amdvi_find_as_by_devid, &devid);
>  }
>  
> +static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const AMDVIIOTLBKey *key1 = v1;
> +    const AMDVIIOTLBKey *key2 = v2;
> +
> +    return key1->devid == key2->devid && key1->gfn == key2->gfn;
> +}
> +
> +static guint amdvi_iotlb_hash(gconstpointer v)
> +{
> +    const AMDVIIOTLBKey *key = v;
> +    /* Use GPA and DEVID to find the bucket */
> +    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
> +                   (key->devid & ~AMDVI_PAGE_MASK_4K));
> +}
> +
> +
>  static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>                                             uint64_t devid)
>  {
> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +    AMDVIIOTLBKey key = {
> +        .gfn = AMDVI_GET_IOTLB_GFN(addr),
> +        .devid = devid,
> +    };
>      return g_hash_table_lookup(s->iotlb, &key);
>  }
>  
> @@ -451,8 +465,10 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
>  static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
>                                      uint64_t devid)
>  {
> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +    AMDVIIOTLBKey key = {
> +        .gfn = AMDVI_GET_IOTLB_GFN(addr),
> +        .devid = devid,
> +    };
>      g_hash_table_remove(s->iotlb, &key);
>  }
>  
> @@ -463,8 +479,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>      /* don't cache erroneous translations */
>      if (to_cache.perm != IOMMU_NONE) {
>          AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
> -        uint64_t *key = g_new(uint64_t, 1);
> -        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
> +        AMDVIIOTLBKey *key = g_new(AMDVIIOTLBKey, 1);
> +
> +        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
> +        key->devid = devid;
>  
>          trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>                  PCI_FUNC(devid), gpa, to_cache.translated_addr);
> @@ -477,7 +495,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>          entry->perms = to_cache.perm;
>          entry->translated_addr = to_cache.translated_addr;
>          entry->page_mask = to_cache.addr_mask;
> -        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +        entry->devid = devid;
> +
>          g_hash_table_replace(s->iotlb, key, entry);
>      }
>  }
> @@ -2526,8 +2545,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
> -                                     amdvi_uint64_equal, g_free, g_free);
> +    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
> +                                     amdvi_iotlb_equal, g_free, g_free);
>  
>      s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
>                                       amdvi_as_equal, g_free, g_free);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 38471b95d153..302ccca5121f 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -220,8 +220,8 @@
>  #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
>  
>  /* IOTLB */
> -#define AMDVI_IOTLB_MAX_SIZE 1024
> -#define AMDVI_DEVID_SHIFT    36
> +#define AMDVI_IOTLB_MAX_SIZE        1024
> +#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
>  
>  /* default extended feature */
>  #define AMDVI_DEFAULT_EXT_FEATURES \
> -- 
> 2.34.1


