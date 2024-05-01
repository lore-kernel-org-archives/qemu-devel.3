Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FBDC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Gra-0003vl-DR; Wed, 01 May 2024 16:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GrB-0003rT-Mr
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:47:15 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GrA-0001Ip-1H
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:47:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DC33B61904;
 Wed,  1 May 2024 20:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C082C072AA;
 Wed,  1 May 2024 20:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596430;
 bh=IVFlG7/OVVyRn1qxCbkB1eYEoi2tCROExBghLoORPn8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ZuKGz8T++r4J9yyT7gooAxbI6V4XYbjjj35r+Q65vhiG00BNIgnMIKVEEdbD00LiV
 WTmpfZyWtwkyc5OaDFEuAKlTtJwnw7WMMRmTjaVuUXbxUYOgkS5HXHXGTbxg/uRXEq
 pFuHoFqFlAEri3F2MrPGYRUcAtA/Ofj1g29kUMY4c0RS9j2p4AdQ6iONBQ1pJ684GX
 I9T1wTkhm4x1Ryd3EVUN4GEAI+t1H0Y1piD53f4jB10ri7ENpPOS179FFMSZP7WYFw
 YHjlz64D7KgBQVvcBR6xAvOB44IXdQrbhjAPG+PKOsq9pRiiIcux/PS0lk8nA4lZz8
 K1FaO9fKKT5QQ==
Date: Wed, 1 May 2024 13:47:06 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 08/17] xen: mapcache: Refactor
 xen_invalidate_map_cache_entry_unlocked
In-Reply-To: <20240430164939.925307-9-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011347000.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-9-edgar.iglesias@gmail.com>
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
> Add MapCache argument to xen_invalidate_map_cache_entry_unlocked.
> This is in preparation for supporting multiple map caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 6e758eff94..34454da2f6 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -420,7 +420,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>      return xen_ram_addr_from_mapcache_single(mapcache, ptr);
>  }
>  
> -static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
> +static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
> +                                                    uint8_t *buffer)
>  {
>      MapCacheEntry *entry = NULL, *pentry = NULL;
>      MapCacheRev *reventry;
> @@ -428,7 +429,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
>      hwaddr size;
>      int found = 0;
>  
> -    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
> +    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
>          if (reventry->vaddr_req == buffer) {
>              paddr_index = reventry->paddr_index;
>              size = reventry->size;
> @@ -438,7 +439,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
>      }
>      if (!found) {
>          trace_xen_invalidate_map_cache_entry_unlocked_not_found(buffer);
> -        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
> +        QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
>              trace_xen_invalidate_map_cache_entry_unlocked_found(
>                  reventry->paddr_index,
>                  reventry->vaddr_req
> @@ -446,15 +447,15 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
>          }
>          return;
>      }
> -    QTAILQ_REMOVE(&mapcache->locked_entries, reventry, next);
> +    QTAILQ_REMOVE(&mc->locked_entries, reventry, next);
>      g_free(reventry);
>  
> -    if (mapcache->last_entry != NULL &&
> -        mapcache->last_entry->paddr_index == paddr_index) {
> -        mapcache->last_entry = NULL;
> +    if (mc->last_entry != NULL &&
> +        mc->last_entry->paddr_index == paddr_index) {
> +        mc->last_entry = NULL;
>      }
>  
> -    entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
> +    entry = &mc->entry[paddr_index % mc->nr_buckets];
>      while (entry && (entry->paddr_index != paddr_index || entry->size != size)) {
>          pentry = entry;
>          entry = entry->next;
> @@ -488,7 +489,7 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
>      XenMapCacheData *data = opaque;
>  
>      mapcache_lock(mapcache);
> -    xen_invalidate_map_cache_entry_unlocked(data->buffer);
> +    xen_invalidate_map_cache_entry_unlocked(mapcache, data->buffer);
>      mapcache_unlock(mapcache);
>  
>      aio_co_wake(data->co);
> @@ -506,7 +507,7 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
>          qemu_coroutine_yield();
>      } else {
>          mapcache_lock(mapcache);
> -        xen_invalidate_map_cache_entry_unlocked(buffer);
> +        xen_invalidate_map_cache_entry_unlocked(mapcache, buffer);
>          mapcache_unlock(mapcache);
>      }
>  }
> -- 
> 2.40.1
> 

