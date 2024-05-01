Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FB0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2GlI-0000HS-IU; Wed, 01 May 2024 16:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GlA-0000CO-D6
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:41:00 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Gl6-0000GH-Vt
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:40:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ADA1D61794;
 Wed,  1 May 2024 20:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A961C072AA;
 Wed,  1 May 2024 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596055;
 bh=j96WBr+ckAnpUbK5HVQ29fNPUdvYgDjm1+efAxcME4o=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=AyQCOV9bZWw7X5lI/JknkOTUGFJ2UwMM84H3RXHkjTrS9gkV7qZhRp4Om0qse5P4Z
 5Ir0k/Q5EKxOSLKvN/W3mKyD5YhzelyVKlJ+lYtJBG76ypj2WDHVC3EwdTslruBGma
 YZfBjjX9fb++VU2fCnZgpdE9UScdwLps7Q9gHNtbXTYP+eRBVlV8nS/NDXiiN7NleU
 CBqY4PSmIj/x7reYitY4Kde/3rn9mO4DBIzaFDwKtSC2XduleO/eUbMfBZlP/WEAm+
 eIy+WXIJCtobo+GdLvMCDQmPgMioCLzz8kFvRX/cQ6dQv9DzY7CwxsryecaYlAaL9J
 vmo/oeRRN6O6w==
Date: Wed, 1 May 2024 13:40:52 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 04/17] xen: mapcache: Refactor xen_map_cache for
 multi-instance
In-Reply-To: <20240430164939.925307-5-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011340460.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-5-edgar.iglesias@gmail.com>
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
> Make xen_map_cache take a MapCache as argument. This is in
> prepaparation to support multiple map caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 3f11562075..896021d86f 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -240,7 +240,8 @@ static void xen_remap_bucket(MapCacheEntry *entry,
>      g_free(err);
>  }
>  
> -static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
> +static uint8_t *xen_map_cache_unlocked(MapCache *mc,
> +                                       hwaddr phys_addr, hwaddr size,
>                                         uint8_t lock, bool dma)
>  {
>      MapCacheEntry *entry, *pentry = NULL,
> @@ -269,16 +270,16 @@ tryagain:
>          test_bit_size = XC_PAGE_SIZE;
>      }
>  
> -    if (mapcache->last_entry != NULL &&
> -        mapcache->last_entry->paddr_index == address_index &&
> +    if (mc->last_entry != NULL &&
> +        mc->last_entry->paddr_index == address_index &&
>          !lock && !size &&
>          test_bits(address_offset >> XC_PAGE_SHIFT,
>                    test_bit_size >> XC_PAGE_SHIFT,
> -                  mapcache->last_entry->valid_mapping)) {
> +                  mc->last_entry->valid_mapping)) {
>          trace_xen_map_cache_return(
> -            mapcache->last_entry->vaddr_base + address_offset
> +            mc->last_entry->vaddr_base + address_offset
>          );
> -        return mapcache->last_entry->vaddr_base + address_offset;
> +        return mc->last_entry->vaddr_base + address_offset;
>      }
>  
>      /* size is always a multiple of MCACHE_BUCKET_SIZE */
> @@ -291,7 +292,7 @@ tryagain:
>          cache_size = MCACHE_BUCKET_SIZE;
>      }
>  
> -    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
> +    entry = &mc->entry[address_index % mc->nr_buckets];
>  
>      while (entry && (lock || entry->lock) && entry->vaddr_base &&
>              (entry->paddr_index != address_index || entry->size != cache_size ||
> @@ -326,10 +327,10 @@ tryagain:
>      if(!test_bits(address_offset >> XC_PAGE_SHIFT,
>                  test_bit_size >> XC_PAGE_SHIFT,
>                  entry->valid_mapping)) {
> -        mapcache->last_entry = NULL;
> +        mc->last_entry = NULL;
>  #ifdef XEN_COMPAT_PHYSMAP
> -        if (!translated && mapcache->phys_offset_to_gaddr) {
> -            phys_addr = mapcache->phys_offset_to_gaddr(phys_addr, size);
> +        if (!translated && mc->phys_offset_to_gaddr) {
> +            phys_addr = mc->phys_offset_to_gaddr(phys_addr, size);
>              translated = true;
>              goto tryagain;
>          }
> @@ -342,7 +343,7 @@ tryagain:
>          return NULL;
>      }
>  
> -    mapcache->last_entry = entry;
> +    mc->last_entry = entry;
>      if (lock) {
>          MapCacheRev *reventry = g_new0(MapCacheRev, 1);
>          entry->lock++;
> @@ -352,16 +353,16 @@ tryagain:
>              abort();
>          }
>          reventry->dma = dma;
> -        reventry->vaddr_req = mapcache->last_entry->vaddr_base + address_offset;
> -        reventry->paddr_index = mapcache->last_entry->paddr_index;
> +        reventry->vaddr_req = mc->last_entry->vaddr_base + address_offset;
> +        reventry->paddr_index = mc->last_entry->paddr_index;
>          reventry->size = entry->size;
> -        QTAILQ_INSERT_HEAD(&mapcache->locked_entries, reventry, next);
> +        QTAILQ_INSERT_HEAD(&mc->locked_entries, reventry, next);
>      }
>  
>      trace_xen_map_cache_return(
> -        mapcache->last_entry->vaddr_base + address_offset
> +        mc->last_entry->vaddr_base + address_offset
>      );
> -    return mapcache->last_entry->vaddr_base + address_offset;
> +    return mc->last_entry->vaddr_base + address_offset;
>  }
>  
>  uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
> @@ -370,7 +371,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>      uint8_t *p;
>  
>      mapcache_lock(mapcache);
> -    p = xen_map_cache_unlocked(phys_addr, size, lock, dma);
> +    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma);
>      mapcache_unlock(mapcache);
>      return p;
>  }
> -- 
> 2.40.1
> 

