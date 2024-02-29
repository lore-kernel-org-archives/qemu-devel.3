Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384F6C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfpYM-0000bS-4j; Thu, 29 Feb 2024 18:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rfpY8-0000WQ-7T
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:10:49 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rfpY5-00086J-82
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:10:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A2BD0CE23BC;
 Thu, 29 Feb 2024 23:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7D2C433C7;
 Thu, 29 Feb 2024 23:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709248241;
 bh=oEoZAeisqotVjQPUL65EOifVNk5hxGWTeNvAdCGLWTM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=m94epvHYZP8E3+3h4kqGg3IhC7/u1asLXXLtf34IVAMKXUnbrSIARvy1jkNMKUNdw
 amkPTRK5b67sjGwTEEDHMqeP4bx4cBWgdnpO4lQfzy3/fFiMJldvnU2kPq6uVDFVeR
 ZBiVjUa5LRXQyUHDS7deVRrAhKh2VM1QeTjkhQE/Zk4npdUZlODm8TCt72/X7g1MlM
 oSoe3hAlUt7VsXn4nQhbmKJrmqSENbjDcpfVq5DLNV6xZhTJdfmGzjuMvw5J89wb91
 wCEeS0j+c11UkxaoF665MoM0IWbT0Ww4iRXMUHYAJE0AD9JzUrMyz1x8dOdctKl3be
 DSzvncnDcUqKw==
Date: Thu, 29 Feb 2024 15:10:39 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
In-Reply-To: <20240227223501.28475-6-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2402291510270.853156@ubuntu-linux-20-04-desktop>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Feb 2024, Vikram Garhwal wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> In order to support mapping and unmapping guest memory dynamically to
> and from qemu during address_space_[un]map() operations add the map()
> and unmap() callbacks to MemoryRegionOps.
> 
> Those will be used e.g. for Xen grant mappings when performing guest
> I/Os.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  include/exec/memory.h | 21 ++++++++++++++++++
>  system/physmem.c      | 50 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 8626a355b3..9f7dfe59c7 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -282,6 +282,27 @@ struct MemoryRegionOps {
>                                      unsigned size,
>                                      MemTxAttrs attrs);
>  
> +    /*
> +     * Dynamically create mapping. @addr is the guest address to map; @plen
> +     * is the pointer to the usable length of the buffer.
> +     * @mr contents can be changed in case a new memory region is created for
> +     * the mapping.
> +     * Returns the buffer address for accessing the data.
> +     */
> +    void *(*map)(MemoryRegion **mr,
> +                 hwaddr addr,
> +                 hwaddr *plen,
> +                 bool is_write,
> +                 MemTxAttrs attrs);
> +
> +    /* Unmap an area obtained via map() before. */
> +    void (*unmap)(MemoryRegion *mr,
> +                  void *buffer,
> +                  ram_addr_t addr,
> +                  hwaddr len,
> +                  bool is_write,
> +                  hwaddr access_len);
> +
>      enum device_endian endianness;
>      /* Guest-visible constraints: */
>      struct {
> diff --git a/system/physmem.c b/system/physmem.c
> index 949dcb20ba..d989e9fc1f 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3141,6 +3141,7 @@ void *address_space_map(AddressSpace *as,
>      hwaddr len = *plen;
>      hwaddr l, xlat;
>      MemoryRegion *mr;
> +    void *ptr = NULL;
>      FlatView *fv;
>  
>      if (len == 0) {
> @@ -3174,12 +3175,20 @@ void *address_space_map(AddressSpace *as,
>          return bounce.buffer;
>      }
>  
> -
>      memory_region_ref(mr);
> +
> +    if (mr->ops && mr->ops->map) {
> +        ptr = mr->ops->map(&mr, addr, plen, is_write, attrs);
> +    }
> +
>      *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
>      fuzz_dma_read_cb(addr, *plen, mr);
> -    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> +    if (ptr == NULL) {
> +        ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> +    }
> +
> +    return ptr;
>  }
>  
>  /* Unmaps a memory region previously mapped by address_space_map().
> @@ -3195,11 +3204,16 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>  
>          mr = memory_region_from_host(buffer, &addr1);
>          assert(mr != NULL);
> -        if (is_write) {
> -            invalidate_and_set_dirty(mr, addr1, access_len);
> -        }
> -        if (xen_enabled()) {
> -            xen_invalidate_map_cache_entry(buffer);
> +
> +        if (mr->ops && mr->ops->unmap) {
> +            mr->ops->unmap(mr, buffer, addr1, len, is_write, access_len);
> +        } else {
> +            if (is_write) {
> +                invalidate_and_set_dirty(mr, addr1, access_len);
> +            }
> +            if (xen_enabled()) {
> +                xen_invalidate_map_cache_entry(buffer);
> +            }
>          }
>          memory_region_unref(mr);
>          return;
> @@ -3272,10 +3286,18 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
>           * doing this if we found actual RAM, which behaves the same
>           * regardless of attributes; so UNSPECIFIED is fine.
>           */
> +        if (mr->ops && mr->ops->map) {
> +            cache->ptr = mr->ops->map(&mr, addr, &l, is_write,
> +                                      MEMTXATTRS_UNSPECIFIED);
> +        }
> +
>          l = flatview_extend_translation(cache->fv, addr, len, mr,
>                                          cache->xlat, l, is_write,
>                                          MEMTXATTRS_UNSPECIFIED);
> -        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
> +        if (!cache->ptr) {
> +            cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l,
> +                                             true);
> +        }
>      } else {
>          cache->ptr = NULL;
>      }
> @@ -3297,14 +3319,20 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
>  
>  void address_space_cache_destroy(MemoryRegionCache *cache)
>  {
> -    if (!cache->mrs.mr) {
> +    MemoryRegion *mr = cache->mrs.mr;
> +
> +    if (!mr) {
>          return;
>      }
>  
> -    if (xen_enabled()) {
> +    if (mr->ops && mr->ops->unmap) {
> +            mr->ops->unmap(mr, cache->ptr, cache->xlat, cache->len,
> +                           cache->is_write, cache->len);
> +    } else if (xen_enabled()) {
>          xen_invalidate_map_cache_entry(cache->ptr);
>      }
> -    memory_region_unref(cache->mrs.mr);
> +
> +    memory_region_unref(mr);
>      flatview_unref(cache->fv);
>      cache->mrs.mr = NULL;
>      cache->fv = NULL;
> -- 
> 2.17.1
> 

