Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67314C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 23:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Njl-0000cV-2k; Wed, 15 May 2024 19:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7Njj-0000cL-4w
 for qemu-devel@nongnu.org; Wed, 15 May 2024 19:08:39 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7Njh-0004Mc-1D
 for qemu-devel@nongnu.org; Wed, 15 May 2024 19:08:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5D735CE17F2;
 Wed, 15 May 2024 23:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED724C116B1;
 Wed, 15 May 2024 23:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715814512;
 bh=XqjCuxiB2MnS1WYIMeDQH7gJ6WD9EqRTdV+F492/gLw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=VWypi5lBK2x7yQ0NI1MMlBECA0+HSqVfaNaMDHLNjucNrkXxCM8VrigYggHzitAIA
 N4O5OnwFrkHb265DvcSHDoSEePIJ2LSHn/9zH9ck+tQ7+JK8Q1fLW2X5UUanfaANLd
 KBcko0Eue4dM5TTYB+oW9Xvhb7X6czPsx52iBjV0FZy/hP5N5JMKxuKn/3FT/Rs756
 BWrq5QnpbWfD7C/64/udGSu2n2gwwpoza5/oPAxQX/W1X/ZVp7B08A/xGQ7XB/EUDn
 BWjYZeQuCtnK84i7M4UWGPsamo1o6oHthmo1Fx+/XQza4D55f18c4/xxPGV2nAAqdo
 BQJo+rNMlFynQ==
Date: Wed, 15 May 2024 16:08:29 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v5 6/8] xen: mapcache: Pass the ram_addr offset to
 xen_map_cache()
In-Reply-To: <20240503014449.1046238-7-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405151605550.2544314@ubuntu-linux-20-04-desktop>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
 <20240503014449.1046238-7-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Fri, 3 May 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Pass the ram_addr offset to xen_map_cache.
> This is in preparation for adding grant mappings that need
> to compute the address within the RAMBlock.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/xen/xen-mapcache.c         | 16 +++++++++++-----
>  include/sysemu/xen-mapcache.h |  2 ++
>  system/physmem.c              |  9 +++++----
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index ec95445696..26bc38a9e3 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -167,7 +167,8 @@ static void xen_remap_bucket(MapCache *mc,
>                               void *vaddr,
>                               hwaddr size,
>                               hwaddr address_index,
> -                             bool dummy)
> +                             bool dummy,
> +                             ram_addr_t ram_offset)
>  {
>      uint8_t *vaddr_base;
>      xen_pfn_t *pfns;
> @@ -266,6 +267,7 @@ static void xen_remap_bucket(MapCache *mc,
>  
>  static uint8_t *xen_map_cache_unlocked(MapCache *mc,
>                                         hwaddr phys_addr, hwaddr size,
> +                                       ram_addr_t ram_offset,
>                                         uint8_t lock, bool dma, bool is_write)
>  {
>      MapCacheEntry *entry, *pentry = NULL,
> @@ -337,14 +339,16 @@ tryagain:
>      if (!entry) {
>          entry = g_new0(MapCacheEntry, 1);
>          pentry->next = entry;
> -        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
> +        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
> +                         ram_offset);
>      } else if (!entry->lock) {
>          if (!entry->vaddr_base || entry->paddr_index != address_index ||
>                  entry->size != cache_size ||
>                  !test_bits(address_offset >> XC_PAGE_SHIFT,
>                      test_bit_size >> XC_PAGE_SHIFT,
>                      entry->valid_mapping)) {
> -            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
> +            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
> +                             ram_offset);
>          }
>      }
>  
> @@ -391,13 +395,15 @@ tryagain:
>  
>  uint8_t *xen_map_cache(MemoryRegion *mr,
>                         hwaddr phys_addr, hwaddr size,
> +                       ram_addr_t ram_addr_offset,
>                         uint8_t lock, bool dma,
>                         bool is_write)
>  {
>      uint8_t *p;
>  
>      mapcache_lock(mapcache);
> -    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma, is_write);
> +    p = xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_offset,
> +                               lock, dma, is_write);
>      mapcache_unlock(mapcache);
>      return p;
>  }
> @@ -632,7 +638,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>      trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
>  
>      xen_remap_bucket(mc, entry, entry->vaddr_base,
> -                     cache_size, address_index, false);
> +                     cache_size, address_index, false, new_phys_addr);

Everything else makes sense, but I don't understand how can it be that
new_phys_addr is the block->offset here?


>      if (!test_bits(address_offset >> XC_PAGE_SHIFT,
>                  test_bit_size >> XC_PAGE_SHIFT,
>                  entry->valid_mapping)) {
> diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
> index 1ec9e66752..b5e3ea1bc0 100644
> --- a/include/sysemu/xen-mapcache.h
> +++ b/include/sysemu/xen-mapcache.h
> @@ -19,6 +19,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
>  void xen_map_cache_init(phys_offset_to_gaddr_t f,
>                          void *opaque);
>  uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
> +                       ram_addr_t ram_addr_offset,
>                         uint8_t lock, bool dma,
>                         bool is_write);
>  ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
> @@ -37,6 +38,7 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
>  static inline uint8_t *xen_map_cache(MemoryRegion *mr,
>                                       hwaddr phys_addr,
>                                       hwaddr size,
> +                                     ram_addr_t ram_addr_offset,
>                                       uint8_t lock,
>                                       bool dma,
>                                       bool is_write)
> diff --git a/system/physmem.c b/system/physmem.c
> index b7847db1a2..33d09f7571 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2231,13 +2231,14 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>           */
>          if (xen_mr_is_memory(block->mr)) {
>              return xen_map_cache(block->mr, block->offset + addr,
> -                                 len, lock, lock,
> -                                 is_write);
> +                                 len, block->offset,
> +                                 lock, lock, is_write);
>          }
>  
>          block->host = xen_map_cache(block->mr, block->offset,
> -                                    block->max_length, 1,
> -                                    lock, is_write);
> +                                    block->max_length,
> +                                    block->offset,
> +                                    1, lock, is_write);
>      }

This is OK but it is really making it clear that there is a mistake in
the code. OK for now but it is something to fix in the future.


>      return ramblock_ptr(block, addr);
> -- 
> 2.40.1
> 

