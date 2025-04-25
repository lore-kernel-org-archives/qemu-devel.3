Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A54C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ogs-0000uR-3B; Fri, 25 Apr 2025 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1u8Ogq-0000tu-Eh; Fri, 25 Apr 2025 15:26:24 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1u8Ogo-0004y6-BW; Fri, 25 Apr 2025 15:26:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C985E4AB4E;
 Fri, 25 Apr 2025 19:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA96C4CEE9;
 Fri, 25 Apr 2025 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745609176;
 bh=ljStjEoWpGm0WSufAWVVtJm5j+hefQcxjnFFyz8KcgY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=LT2WHXiS7x8kST+KvpcKjeiIby/zhVutCJErxMt2Nx3QNr/im8x+w5hNtSiFxOitR
 5nX08cmWlZByoviT0y0fLkCTX60zymkAZ8vwFjUGRTezuITKMquwyRqlArkhooIIGt
 tD3fgbdZReKcl/dhoFyc3jEIVUkzAjb2wifF4KCAO95k4HGCk7LixKfYp0kQ4oJ6++
 fGgSjcDM979WERKy6tMbyWii80uTCARx96GqnESgkwOe7AER9zg+5NIXIfkJ11Xd77
 eIiRvLYng5rLc5AutyprwjIGPUGsNYwtWohvrIWDAC1GkbRTkER57dIzhWmnOUnBVL
 wDGcJVSSHGoAQ==
Date: Fri, 25 Apr 2025 12:26:14 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, sstabellini@kernel.org, 
 anthony@xenproject.org, paul@xen.org, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 1/1] xen: mapcache: Split mapcache_grants by ro and rw
In-Reply-To: <20250425143156.204452-2-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2504251225270.785180@ubuntu-linux-20-04-desktop>
References: <20250425143156.204452-1-edgar.iglesias@gmail.com>
 <20250425143156.204452-2-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 25 Apr 2025, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Today, we don't track write-abiliy in the cache, if a user
> requests a readable mapping followed by a writeable mapping
> on the same page, the second lookup will incorrectly hit
> the readable entry.
> 
> Split mapcache_grants by ro and rw access. Grants will now
> have separate ways in the cache depending on writeability.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 2c8f861fdb..e31d379702 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -75,7 +75,8 @@ typedef struct MapCache {
>  } MapCache;
>  
>  static MapCache *mapcache;
> -static MapCache *mapcache_grants;
> +static MapCache *mapcache_grants_ro;
> +static MapCache *mapcache_grants_rw;
>  static xengnttab_handle *xen_region_gnttabdev;
>  
>  static inline void mapcache_lock(MapCache *mc)
> @@ -176,9 +177,12 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>       * Grant mappings must use XC_PAGE_SIZE granularity since we can't
>       * map anything beyond the number of pages granted to us.
>       */
> -    mapcache_grants = xen_map_cache_init_single(f, opaque,
> -                                                XC_PAGE_SHIFT,
> -                                                max_mcache_size);
> +    mapcache_grants_ro = xen_map_cache_init_single(f, opaque,
> +                                                   XC_PAGE_SHIFT,
> +                                                   max_mcache_size);
> +    mapcache_grants_rw = xen_map_cache_init_single(f, opaque,
> +                                                   XC_PAGE_SHIFT,
> +                                                   max_mcache_size);
>  
>      setrlimit(RLIMIT_AS, &rlimit_as);
>  }
> @@ -456,9 +460,13 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
>                         bool is_write)
>  {
>      bool grant = xen_mr_is_grants(mr);
> -    MapCache *mc = grant ? mapcache_grants : mapcache;
> +    MapCache *mc = mapcache;
>      uint8_t *p;
>  
> +    if (grant) {
> +        mc = is_write ? mapcache_grants_rw : mapcache_grants_ro;
> +    }
> +
>      if (grant && !lock) {
>          /*
>           * Grants are only supported via address_space_map(). Anything
> @@ -523,7 +531,10 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>  
>      addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
>      if (addr == RAM_ADDR_INVALID) {
> -        addr = xen_ram_addr_from_mapcache_single(mapcache_grants, ptr);
> +        addr = xen_ram_addr_from_mapcache_single(mapcache_grants_ro, ptr);
> +    }
> +    if (addr == RAM_ADDR_INVALID) {
> +        addr = xen_ram_addr_from_mapcache_single(mapcache_grants_rw, ptr);
>      }
>  
>      return addr;
> @@ -626,7 +637,8 @@ static void xen_invalidate_map_cache_entry_single(MapCache *mc, uint8_t *buffer)
>  static void xen_invalidate_map_cache_entry_all(uint8_t *buffer)
>  {
>      xen_invalidate_map_cache_entry_single(mapcache, buffer);
> -    xen_invalidate_map_cache_entry_single(mapcache_grants, buffer);
> +    xen_invalidate_map_cache_entry_single(mapcache_grants_ro, buffer);
> +    xen_invalidate_map_cache_entry_single(mapcache_grants_rw, buffer);
>  }
>  
>  static void xen_invalidate_map_cache_entry_bh(void *opaque)
> -- 
> 2.43.0
> 

