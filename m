Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467A2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 21:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2H6u-0004mh-CI; Wed, 01 May 2024 17:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2H6r-0004mK-Nq
 for qemu-devel@nongnu.org; Wed, 01 May 2024 17:03:26 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2H6p-0003xj-LC
 for qemu-devel@nongnu.org; Wed, 01 May 2024 17:03:25 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9B783619BA;
 Wed,  1 May 2024 21:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7EC072AA;
 Wed,  1 May 2024 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714597402;
 bh=2WZWdYOx2khYwwOaLHZ6CakoHF0il4iSJg/sGKO5QtE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=nx5Np+7/aKvpOiUcx2oJgi2mzU3PYHgVuYzyb3Iqwl7JARmd9X4N7n8oxT2O6+2w3
 VDq+EMHWrRdxOuIqoVli5GZiP8e+zDFrlXHXQs1ZnI6EskAjIfJVTU3TBil4ztZt0i
 YNaCjcBaXqo3aHAPONO6oo740BP5/YfL1OZNFYHJn207gWtwv3lmk8Fp1uYTd2WoMG
 6TpUB1Mec9Zkw9Iumm93EzqamFpn4E//rHZAyimCB0UFClAUaCqjIaqmBP8me18+LC
 IBqKEWfr9NsHlyC5kFciUNsNnx+cqe8mNVK+JKT4PA/WXc5o314hzu47qyUebU0abg
 ceO+Y9SdheO8Q==
Date: Wed, 1 May 2024 14:03:18 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 13/17] softmmu: Pass RAM MemoryRegion and is_write
 xen_map_cache()
In-Reply-To: <20240430164939.925307-14-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011403120.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-14-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
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
> Propagate MR and is_write to xen_map_cache().
> This is in preparation for adding support for grant mappings.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c         | 10 ++++++----
>  include/sysemu/xen-mapcache.h | 11 +++++++----
>  system/physmem.c              | 31 +++++++++++++++++++++++--------
>  3 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 0365311788..09b5f36d9c 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -264,7 +264,7 @@ static void xen_remap_bucket(MapCache *mc,
>  
>  static uint8_t *xen_map_cache_unlocked(MapCache *mc,
>                                         hwaddr phys_addr, hwaddr size,
> -                                       uint8_t lock, bool dma)
> +                                       uint8_t lock, bool dma, bool is_write)
>  {
>      MapCacheEntry *entry, *pentry = NULL,
>                    *free_entry = NULL, *free_pentry = NULL;
> @@ -387,13 +387,15 @@ tryagain:
>      return mc->last_entry->vaddr_base + address_offset;
>  }
>  
> -uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
> -                       uint8_t lock, bool dma)
> +uint8_t *xen_map_cache(MemoryRegion *mr,
> +                       hwaddr phys_addr, hwaddr size,
> +                       uint8_t lock, bool dma,
> +                       bool is_write)
>  {
>      uint8_t *p;
>  
>      mapcache_lock(mapcache);
> -    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma);
> +    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma, is_write);
>      mapcache_unlock(mapcache);
>      return p;
>  }
> diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
> index 10c2e3082a..1ec9e66752 100644
> --- a/include/sysemu/xen-mapcache.h
> +++ b/include/sysemu/xen-mapcache.h
> @@ -18,8 +18,9 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
>  
>  void xen_map_cache_init(phys_offset_to_gaddr_t f,
>                          void *opaque);
> -uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
> -                       uint8_t lock, bool dma);
> +uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
> +                       uint8_t lock, bool dma,
> +                       bool is_write);
>  ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
>  void xen_invalidate_map_cache_entry(uint8_t *buffer);
>  void xen_invalidate_map_cache(void);
> @@ -33,10 +34,12 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
>  {
>  }
>  
> -static inline uint8_t *xen_map_cache(hwaddr phys_addr,
> +static inline uint8_t *xen_map_cache(MemoryRegion *mr,
> +                                     hwaddr phys_addr,
>                                       hwaddr size,
>                                       uint8_t lock,
> -                                     bool dma)
> +                                     bool dma,
> +                                     bool is_write)
>  {
>      abort();
>  }
> diff --git a/system/physmem.c b/system/physmem.c
> index f114b972a5..ad7a8c7d95 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2190,11 +2190,22 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
>  
>  /*
>   * Return a host pointer to guest's ram.
> + * For Xen, foreign mappings get created if they don't already exist.
> + *
> + * @block: block for the RAM to lookup (optional and may be NULL).
> + * @addr: address within the memory region.
> + * @size: pointer to requested size (optional and may be NULL).
> + *        size may get modified and return a value smaller than
> + *        what was requested.
> + * @lock: wether to lock the mapping in xen-mapcache until invalidated.
> + * @is_write: hint wether to map RW or RO in the xen-mapcache.
> + *            (optional and may always be set to true).
>   *
>   * Called within RCU critical section.
>   */
>  static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
> -                                 hwaddr *size, bool lock)
> +                                 hwaddr *size, bool lock,
> +                                 bool is_write)
>  {
>      hwaddr len = 0;
>  
> @@ -2217,10 +2228,13 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>           * In that case just map the requested area.
>           */
>          if (block->offset == 0) {
> -            return xen_map_cache(addr, len, lock, lock);
> +            return xen_map_cache(block->mr, addr, len, lock, lock,
> +                                 is_write);
>          }
>  
> -        block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
> +        block->host = xen_map_cache(block->mr, block->offset,
> +                                    block->max_length, 1,
> +                                    lock, is_write);
>      }
>  
>      return ramblock_ptr(block, addr);
> @@ -2236,7 +2250,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>   */
>  void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
>  {
> -    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
> +    return qemu_ram_ptr_length(ram_block, addr, NULL, false, true);
>  }
>  
>  /* Return the offset of a hostpointer within a ramblock */
> @@ -2746,7 +2760,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>      } else {
>          /* RAM case */
>          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
> -                                               false);
> +                                               false, true);
>  
>          memmove(ram_ptr, buf, *l);
>          invalidate_and_set_dirty(mr, mr_addr, *l);
> @@ -2839,7 +2853,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>      } else {
>          /* RAM case */
>          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
> -                                               false);
> +                                               false, false);
>  
>          memcpy(buf, ram_ptr, *l);
>  
> @@ -3233,7 +3247,7 @@ void *address_space_map(AddressSpace *as,
>      *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
>      fuzz_dma_read_cb(addr, *plen, mr);
> -    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> +    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true, is_write);
>  }
>  
>  /* Unmaps a memory region previously mapped by address_space_map().
> @@ -3329,7 +3343,8 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
>          l = flatview_extend_translation(cache->fv, addr, len, mr,
>                                          cache->xlat, l, is_write,
>                                          MEMTXATTRS_UNSPECIFIED);
> -        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
> +        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true,
> +                                         is_write);
>      } else {
>          cache->ptr = NULL;
>      }
> -- 
> 2.40.1
> 

