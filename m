Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1EDC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 19:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2bwh-0002Qg-Na; Thu, 02 May 2024 15:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2bwg-0002QL-Fb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:18:18 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2bwd-0007h5-K4
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:18:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 91139CE1791;
 Thu,  2 May 2024 19:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278C8C113CC;
 Thu,  2 May 2024 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714677490;
 bh=x9X9JAlQJrR7tb6OdOoyjzyrYN9440N5cC/SzcgJewQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=gms6kZdc2jftebu2v69jaOz0bCewYaSGpkhmKkztDo80a+HZaCyREJMX+nh9odIrI
 dynCuUuXMd+rZezP2zhEu5BtVtdH8ia0tqQY3Qbpw5abxS/VsM77Yy3OGj1poT1ZVO
 MzJbWYiQ5oBwkBvq0XZTxQfkLH6iHJ2NGfyYco/M1XfMLN9W3wlo1GJSKbkuLg4rcK
 Y1QMyb+dociJM4CEDoIVUHsi2H73P8i0Zkl564WZXVhwY0rQv9zfxcI5eMcjow65HN
 AeXcjELc1Zg9BXIRDAQWHOTWXsWe5yCBj4ekHXMVhWSLXSwT5j6bYFdETrxU+eugwd
 AIo2b2pMop5fA==
Date: Thu, 2 May 2024 12:18:07 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 16/17] xen: mapcache: Add support for grant mappings
In-Reply-To: <20240430164939.925307-17-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405021156440.624854@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-17-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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
> Add a second mapcache for grant mappings. The mapcache for
> grants needs to work with XC_PAGE_SIZE granularity since
> we can't map larger ranges than what has been granted to us.
> 
> Like with foreign mappings (xen_memory), machines using grants
> are expected to initialize the xen_grants MR and map it
> into their address-map accordingly.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/xen/xen-hvm-common.c         |  12 ++-
>  hw/xen/xen-mapcache.c           | 158 +++++++++++++++++++++++++-------
>  include/hw/xen/xen-hvm-common.h |   3 +
>  include/sysemu/xen.h            |   7 ++
>  4 files changed, 145 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 0267b88d26..fdec400491 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -10,12 +10,18 @@
>  #include "hw/boards.h"
>  #include "hw/xen/arch_hvm.h"
>  
> -MemoryRegion xen_memory;
> +MemoryRegion xen_memory, xen_grants;
>  
> -/* Check for xen memory.  */
> +/* Check for any kind of xen memory, foreign mappings or grants.  */
>  bool xen_mr_is_memory(MemoryRegion *mr)
>  {
> -    return mr == &xen_memory;
> +    return mr == &xen_memory || mr == &xen_grants;
> +}
> +
> +/* Check specifically for grants.  */
> +bool xen_mr_is_grants(MemoryRegion *mr)
> +{
> +    return mr == &xen_grants;
>  }
>  
>  void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 1b32d0c003..96cd68e28d 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -14,6 +14,7 @@
>  
>  #include <sys/resource.h>
>  
> +#include "hw/xen/xen-hvm-common.h"
>  #include "hw/xen/xen_native.h"
>  #include "qemu/bitmap.h"
>  
> @@ -21,6 +22,8 @@
>  #include "sysemu/xen-mapcache.h"
>  #include "trace.h"
>  
> +#include <xenevtchn.h>
> +#include <xengnttab.h>
>  
>  #if HOST_LONG_BITS == 32
>  #  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
> @@ -41,6 +44,7 @@ typedef struct MapCacheEntry {
>      unsigned long *valid_mapping;
>      uint32_t lock;
>  #define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
> +#define XEN_MAPCACHE_ENTRY_GRANT (1 << 1)
>      uint8_t flags;
>      hwaddr size;
>  
> @@ -74,6 +78,8 @@ typedef struct MapCache {
>  } MapCache;
>  
>  static MapCache *mapcache;
> +static MapCache *mapcache_grants;
> +static xengnttab_handle *xen_region_gnttabdev;
>  
>  static inline void mapcache_lock(MapCache *mc)
>  {
> @@ -132,6 +138,12 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>      unsigned long max_mcache_size;
>      unsigned int bucket_shift;
>  
> +    xen_region_gnttabdev = xengnttab_open(NULL, 0);
> +    if (xen_region_gnttabdev == NULL) {
> +        error_report("mapcache: Failed to open gnttab device");
> +        exit(EXIT_FAILURE);
> +    }
> +
>      if (HOST_LONG_BITS == 32) {
>          bucket_shift = 16;
>      } else {
> @@ -160,6 +172,15 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>      mapcache = xen_map_cache_init_single(f, opaque,
>                                           bucket_shift,
>                                           max_mcache_size);
> +
> +    /*
> +     * Grant mappings must use XC_PAGE_SIZE granularity since we can't
> +     * map anything beyond the number of pages granted to us.
> +     */
> +    mapcache_grants = xen_map_cache_init_single(f, opaque,
> +                                                XC_PAGE_SHIFT,
> +                                                max_mcache_size);
> +
>      setrlimit(RLIMIT_AS, &rlimit_as);
>  }
>  
> @@ -169,17 +190,25 @@ static void xen_remap_bucket(MapCache *mc,
>                               hwaddr size,
>                               hwaddr address_index,
>                               bool dummy,
> +                             bool grant,
> +                             bool grant_is_write,
> +                             hwaddr grant_ref,
>                               ram_addr_t ram_offset)

Any chance we could pass grant_ref as address_index ?

Also instead of grant_is_write we could have a generic is_write that
applies to both.

I am not sure about this, but instead of bool grant, we could check on
address_index using XEN_GRANT_ADDR_OFF? This one might not work.

I admit that there is no real advantage on these suggestions except to
consolidate the parameters and make them look a bit more similar in the
two cases.



>  {
>      uint8_t *vaddr_base;
> -    xen_pfn_t *pfns;
> +    uint32_t *refs = NULL;
> +    xen_pfn_t *pfns = NULL;
>      int *err;
>      unsigned int i;
>      hwaddr nb_pfn = size >> XC_PAGE_SHIFT;
>  
>      trace_xen_remap_bucket(address_index);
>  
> -    pfns = g_new0(xen_pfn_t, nb_pfn);
> +    if (grant) {
> +        refs = g_new0(uint32_t, nb_pfn);
> +    } else {
> +        pfns = g_new0(xen_pfn_t, nb_pfn);
> +    }
>      err = g_new0(int, nb_pfn);
>  
>      if (entry->vaddr_base != NULL) {
> @@ -208,21 +237,45 @@ static void xen_remap_bucket(MapCache *mc,
>      g_free(entry->valid_mapping);
>      entry->valid_mapping = NULL;
>  
> -    for (i = 0; i < nb_pfn; i++) {
> -        pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
> +    if (grant) {
> +        for (i = 0; i < nb_pfn; i++) {
> +            refs[i] = grant_ref + i;
> +        }
> +    } else {
> +        for (i = 0; i < nb_pfn; i++) {
> +            pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
> +        }
>      }
>  
> -    /*
> -     * If the caller has requested the mapping at a specific address use
> -     * MAP_FIXED to make sure it's honored.
> -     */
> +    entry->flags &= ~XEN_MAPCACHE_ENTRY_GRANT;
> +
>      if (!dummy) {
> -        vaddr_base = xenforeignmemory_map2(xen_fmem, xen_domid, vaddr,
> -                                           PROT_READ | PROT_WRITE,
> -                                           vaddr ? MAP_FIXED : 0,
> -                                           nb_pfn, pfns, err);
> +        if (grant) {
> +            int prot = PROT_READ;
> +
> +            if (grant_is_write) {
> +                prot |= PROT_WRITE;
> +            }
> +
> +            entry->flags |= XEN_MAPCACHE_ENTRY_GRANT;
> +            assert(vaddr == NULL);
> +            vaddr_base = xengnttab_map_domain_grant_refs(xen_region_gnttabdev,
> +                                                         nb_pfn,
> +                                                         xen_domid, refs,
> +                                                         prot);
> +        } else {
> +            /*
> +             * If the caller has requested the mapping at a specific address use
> +             * MAP_FIXED to make sure it's honored.
> +             */
> +            vaddr_base = xenforeignmemory_map2(xen_fmem, xen_domid, vaddr,
> +                                               PROT_READ | PROT_WRITE,
> +                                               vaddr ? MAP_FIXED : 0,
> +                                               nb_pfn, pfns, err);
> +        }
>          if (vaddr_base == NULL) {
> -            perror("xenforeignmemory_map2");
> +            perror(grant ? "xengnttab_map_domain_grant_refs"
> +                           : "xenforeignmemory_map2");
>              exit(-1);
>          }
>      } else {
> @@ -263,6 +316,7 @@ static void xen_remap_bucket(MapCache *mc,
>          }
>      }
>  
> +    g_free(refs);
>      g_free(pfns);
>      g_free(err);
>  }
> @@ -270,10 +324,12 @@ static void xen_remap_bucket(MapCache *mc,
>  static uint8_t *xen_map_cache_unlocked(MapCache *mc,
>                                         hwaddr phys_addr, hwaddr size,
>                                         ram_addr_t ram_offset,
> -                                       uint8_t lock, bool dma, bool is_write)
> +                                       uint8_t lock, bool dma,
> +                                       bool grant, bool is_write)
>  {
>      MapCacheEntry *entry, *pentry = NULL,
>                    *free_entry = NULL, *free_pentry = NULL;
> +    hwaddr grant_ref = phys_addr >> XC_PAGE_SHIFT;
>      hwaddr address_index;
>      hwaddr address_offset;
>      hwaddr cache_size = size;
> @@ -342,7 +398,7 @@ tryagain:
>          entry = g_new0(MapCacheEntry, 1);
>          pentry->next = entry;
>          xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
> -                         ram_offset);
> +                         grant, is_write, grant_ref, ram_offset);
>      } else if (!entry->lock) {
>          if (!entry->vaddr_base || entry->paddr_index != address_index ||
>                  entry->size != cache_size ||
> @@ -350,7 +406,7 @@ tryagain:
>                      test_bit_size >> XC_PAGE_SHIFT,
>                      entry->valid_mapping)) {
>              xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
> -                             ram_offset);
> +                             grant, is_write, grant_ref, ram_offset);
>          }
>      }
>  
> @@ -401,12 +457,28 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
>                         uint8_t lock, bool dma,
>                         bool is_write)
>  {
> +    bool grant = xen_mr_is_grants(mr);
> +    MapCache *mc = grant ? mapcache_grants : mapcache;
>      uint8_t *p;
>  
> -    mapcache_lock(mapcache);
> -    p = xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_offset,
> -                               lock, dma, is_write);
> -    mapcache_unlock(mapcache);
> +    if (grant) {
> +        /*
> +         * Grants are only supported via address_space_map(). Anything
> +         * else is considered a user/guest error.
> +         *
> +         * QEMU generally doesn't expect these mappings to ever fail, so
> +         * if this happens we report an error message and abort().
> +         */
> +        if (!lock) {
> +            error_report("Trying access a grant reference without mapping it.");
> +            abort();
> +        }
> +    }
> +
> +    mapcache_lock(mc);
> +    p = xen_map_cache_unlocked(mc, phys_addr, size, ram_addr_offset,
> +                               lock, dma, grant, is_write);
> +    mapcache_unlock(mc);
>      return p;
>  }
>  
> @@ -451,7 +523,14 @@ static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
>  
>  ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>  {
> -    return xen_ram_addr_from_mapcache_single(mapcache, ptr);
> +    ram_addr_t addr;
> +
> +    addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
> +    if (addr == RAM_ADDR_INVALID) {
> +        addr = xen_ram_addr_from_mapcache_single(mapcache_grants, ptr);
> +    }
> +
> +    return addr;
>  }
>  
>  static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
> @@ -504,9 +583,14 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>      }
>  
>      ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
> -    if (munmap(entry->vaddr_base, entry->size) != 0) {
> -        perror("unmap fails");
> -        exit(-1);
> +    if (entry->flags & XEN_MAPCACHE_ENTRY_GRANT) {
> +        xengnttab_unmap(xen_region_gnttabdev, entry->vaddr_base,
> +                    (entry->size + mc->bucket_size - 1) >> mc->bucket_shift);

Am I getting this right that the + mc->bucket_size - 1 is unnecessary
because the bucket size is PAGE_SIZE and we can only map at page
granularity?

Also can we check for return errors?


> +    } else {
> +        if (munmap(entry->vaddr_base, entry->size) != 0) {
> +            perror("unmap fails");
> +            exit(-1);
> +        }
>      }
>      if (pentry) {
>          pentry->next = entry->next;
> @@ -522,14 +606,24 @@ typedef struct XenMapCacheData {
>      uint8_t *buffer;
>  } XenMapCacheData;
>  
> +static void xen_invalidate_map_cache_entry_single(MapCache *mc, uint8_t *buffer)
> +{
> +    mapcache_lock(mc);
> +    xen_invalidate_map_cache_entry_unlocked(mc, buffer);
> +    mapcache_unlock(mc);
> +}
> +
> +static void xen_invalidate_map_cache_entry_all(uint8_t *buffer)
> +{
> +    xen_invalidate_map_cache_entry_single(mapcache, buffer);
> +    xen_invalidate_map_cache_entry_single(mapcache_grants, buffer);
> +}
> +
>  static void xen_invalidate_map_cache_entry_bh(void *opaque)
>  {
>      XenMapCacheData *data = opaque;
>  
> -    mapcache_lock(mapcache);
> -    xen_invalidate_map_cache_entry_unlocked(mapcache, data->buffer);
> -    mapcache_unlock(mapcache);
> -
> +    xen_invalidate_map_cache_entry_all(data->buffer);
>      aio_co_wake(data->co);
>  }
>  
> @@ -544,9 +638,7 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
>                                  xen_invalidate_map_cache_entry_bh, &data);
>          qemu_coroutine_yield();
>      } else {
> -        mapcache_lock(mapcache);
> -        xen_invalidate_map_cache_entry_unlocked(mapcache, buffer);
> -        mapcache_unlock(mapcache);
> +        xen_invalidate_map_cache_entry_all(buffer);
>      }
>  }
>  
> @@ -598,6 +690,7 @@ void xen_invalidate_map_cache(void)
>      bdrv_drain_all();
>  
>      xen_invalidate_map_cache_single(mapcache);
> +    xen_invalidate_map_cache_single(mapcache_grants);
>  }
>  
>  static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
> @@ -639,7 +732,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>      trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
>  
>      xen_remap_bucket(mc, entry, entry->vaddr_base,
> -                     cache_size, address_index, false, entry->ram_offset);
> +                     cache_size, address_index, false,
> +                     false, false, 0, entry->ram_offset);

If I understand correctly, xen_replace_cache_entry_unlocked cannot be
called on grants because xen_replace_cache_entry_unlocked is always
called on unlocked entries while grants are always locked. Should we
have an assert on !entry->lock and/or !(entry->flags & XEN_MAPCACHE_ENTRY_GRANT)?



>      if (!test_bits(address_offset >> XC_PAGE_SHIFT,
>                  test_bit_size >> XC_PAGE_SHIFT,
>                  entry->valid_mapping)) {
> diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
> index 65a51aac2e..3d796235dc 100644
> --- a/include/hw/xen/xen-hvm-common.h
> +++ b/include/hw/xen/xen-hvm-common.h
> @@ -16,6 +16,7 @@
>  #include <xen/hvm/ioreq.h>
>  
>  extern MemoryRegion xen_memory;
> +extern MemoryRegion xen_grants;
>  extern MemoryListener xen_io_listener;
>  extern DeviceListener xen_device_listener;
>  
> @@ -29,6 +30,8 @@ extern DeviceListener xen_device_listener;
>      do { } while (0)
>  #endif
>  
> +#define XEN_GRANT_ADDR_OFF (1ULL << 63)
> +
>  static inline uint32_t xen_vcpu_eport(shared_iopage_t *shared_page, int i)
>  {
>      return shared_page->vcpu_ioreq[i].vp_eport;
> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> index dc72f83bcb..19dccf4d71 100644
> --- a/include/sysemu/xen.h
> +++ b/include/sysemu/xen.h
> @@ -35,6 +35,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>                     struct MemoryRegion *mr, Error **errp);
>  
>  bool xen_mr_is_memory(MemoryRegion *mr);
> +bool xen_mr_is_grants(MemoryRegion *mr);
>  
>  #else /* !CONFIG_XEN_IS_POSSIBLE */
>  
> @@ -55,6 +56,12 @@ static inline bool xen_mr_is_memory(MemoryRegion *mr)
>      return false;
>  }
>  
> +static inline bool xen_mr_is_grants(MemoryRegion *mr)
> +{
> +    g_assert_not_reached();
> +    return false;
> +}
> +
>  #endif /* CONFIG_XEN_IS_POSSIBLE */
>  
>  #endif
> -- 
> 2.40.1
> 

