Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2GzU-0008WU-6o; Wed, 01 May 2024 16:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GzG-0008Qc-Ra
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:55:38 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GzD-0002YY-0l
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:55:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2E86ACE139C;
 Wed,  1 May 2024 20:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C551AC072AA;
 Wed,  1 May 2024 20:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596924;
 bh=rRM5UhhS3g5g91tWUVSmHsobPuVReB0n8SEWKW0JLmw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=UOWmAIlwD1ZizziNao5SYkynMT4BK4AhFsid3YYv5lEObtar0/K+d6G/k5KPHuXr5
 W6Kyw9ojRmZdPPea64jVFbMlgCH/Af/ZmKVcmks+YFDWNX4o2NRbkphtlgzF9yVGip
 MqakMAGMYpYmFO0c9JCZLeeBjtX4XNG4+W/sOeaP6uojE/wp2EM6EDhNlcK2mDNEun
 qrkGRu+sQbO/hXaSQlUQGki9OD09QD9wbaI1+i46ZoO+c6TVolEXU/Pt1xsVwjOwUS
 hLOurVZUunTL6LcXWL6mW1JB1USL+FWr+AES73mkitYKYmCwqBuCoYXCmW4y7m6GvY
 GbFyjKMNT3NDw==
Date: Wed, 1 May 2024 13:55:21 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 11/17] xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime
 configurable
In-Reply-To: <20240430164939.925307-12-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011355140.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-12-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 30 Apr 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Make MCACHE_BUCKET_SHIFT runtime configurable per cache instance.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 52 ++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 72a7e25e3e..4f98d284dd 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -23,13 +23,10 @@
>  
>  
>  #if HOST_LONG_BITS == 32
> -#  define MCACHE_BUCKET_SHIFT 16
>  #  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
>  #else
> -#  define MCACHE_BUCKET_SHIFT 20
>  #  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
>  #endif
> -#define MCACHE_BUCKET_SIZE (1UL << MCACHE_BUCKET_SHIFT)
>  
>  /* This is the size of the virtual address space reserve to QEMU that will not
>   * be use by MapCache.
> @@ -65,7 +62,8 @@ typedef struct MapCache {
>      /* For most cases (>99.9%), the page address is the same. */
>      MapCacheEntry *last_entry;
>      unsigned long max_mcache_size;
> -    unsigned int mcache_bucket_shift;
> +    unsigned int bucket_shift;
> +    unsigned long bucket_size;
>  
>      phys_offset_to_gaddr_t phys_offset_to_gaddr;
>      QemuMutex lock;
> @@ -95,6 +93,7 @@ static inline int test_bits(int nr, int size, const unsigned long *addr)
>  
>  static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
>                                             void *opaque,
> +                                           unsigned int bucket_shift,
>                                             unsigned long max_size)
>  {
>      unsigned long size;
> @@ -108,12 +107,14 @@ static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
>  
>      QTAILQ_INIT(&mc->locked_entries);
>  
> +    mc->bucket_shift = bucket_shift;
> +    mc->bucket_size = 1UL << bucket_shift;
>      mc->max_mcache_size = max_size;
>  
>      mc->nr_buckets =
>          (((mc->max_mcache_size >> XC_PAGE_SHIFT) +
> -          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
> -         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
> +          (1UL << (bucket_shift - XC_PAGE_SHIFT)) - 1) >>
> +         (bucket_shift - XC_PAGE_SHIFT));
>  
>      size = mc->nr_buckets * sizeof(MapCacheEntry);
>      size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
> @@ -126,6 +127,13 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>  {
>      struct rlimit rlimit_as;
>      unsigned long max_mcache_size;
> +    unsigned int bucket_shift;
> +
> +    if (HOST_LONG_BITS == 32) {
> +        bucket_shift = 16;
> +    } else {
> +        bucket_shift = 20;
> +    }
>  
>      if (geteuid() == 0) {
>          rlimit_as.rlim_cur = RLIM_INFINITY;
> @@ -146,7 +154,9 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>          }
>      }
>  
> -    mapcache = xen_map_cache_init_single(f, opaque, max_mcache_size);
> +    mapcache = xen_map_cache_init_single(f, opaque,
> +                                         bucket_shift,
> +                                         max_mcache_size);
>      setrlimit(RLIMIT_AS, &rlimit_as);
>  }
>  
> @@ -195,7 +205,7 @@ static void xen_remap_bucket(MapCache *mc,
>      entry->valid_mapping = NULL;
>  
>      for (i = 0; i < nb_pfn; i++) {
> -        pfns[i] = (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT)) + i;
> +        pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
>      }
>  
>      /*
> @@ -266,8 +276,8 @@ static uint8_t *xen_map_cache_unlocked(MapCache *mc,
>      bool dummy = false;
>  
>  tryagain:
> -    address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
> -    address_offset = phys_addr & (MCACHE_BUCKET_SIZE - 1);
> +    address_index  = phys_addr >> mc->bucket_shift;
> +    address_offset = phys_addr & (mc->bucket_size - 1);
>  
>      trace_xen_map_cache(phys_addr);
>  
> @@ -294,14 +304,14 @@ tryagain:
>          return mc->last_entry->vaddr_base + address_offset;
>      }
>  
> -    /* size is always a multiple of MCACHE_BUCKET_SIZE */
> +    /* size is always a multiple of mc->bucket_size */
>      if (size) {
>          cache_size = size + address_offset;
> -        if (cache_size % MCACHE_BUCKET_SIZE) {
> -            cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
> +        if (cache_size % mc->bucket_size) {
> +            cache_size += mc->bucket_size - (cache_size % mc->bucket_size);
>          }
>      } else {
> -        cache_size = MCACHE_BUCKET_SIZE;
> +        cache_size = mc->bucket_size;
>      }
>  
>      entry = &mc->entry[address_index % mc->nr_buckets];
> @@ -419,7 +429,7 @@ static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
>          trace_xen_ram_addr_from_mapcache_not_in_cache(ptr);
>          raddr = RAM_ADDR_INVALID;
>      } else {
> -        raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
> +        raddr = (reventry->paddr_index << mc->bucket_shift) +
>               ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
>      }
>      mapcache_unlock(mc);
> @@ -582,8 +592,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>      hwaddr address_index, address_offset;
>      hwaddr test_bit_size, cache_size = size;
>  
> -    address_index  = old_phys_addr >> MCACHE_BUCKET_SHIFT;
> -    address_offset = old_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> +    address_index  = old_phys_addr >> mc->bucket_shift;
> +    address_offset = old_phys_addr & (mc->bucket_size - 1);
>  
>      assert(size);
>      /* test_bit_size is always a multiple of XC_PAGE_SIZE */
> @@ -592,8 +602,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>          test_bit_size += XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE);
>      }
>      cache_size = size + address_offset;
> -    if (cache_size % MCACHE_BUCKET_SIZE) {
> -        cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
> +    if (cache_size % mc->bucket_size) {
> +        cache_size += mc->bucket_size - (cache_size % mc->bucket_size);
>      }
>  
>      entry = &mc->entry[address_index % mc->nr_buckets];
> @@ -606,8 +616,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>          return NULL;
>      }
>  
> -    address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
> -    address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> +    address_index  = new_phys_addr >> mc->bucket_shift;
> +    address_offset = new_phys_addr & (mc->bucket_size - 1);
>  
>      trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
>  
> -- 
> 2.40.1
> 

