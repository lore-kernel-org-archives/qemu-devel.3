Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DA8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Gk4-0008GR-Oj; Wed, 01 May 2024 16:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Gk2-0008G1-VM
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:39:51 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Gk0-0008JV-OR
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:39:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 27D46CE11C4;
 Wed,  1 May 2024 20:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CD8C4AF48;
 Wed,  1 May 2024 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714595976;
 bh=5YO3GsemN4rW6B3DAytQmffj94Xk9tr4gbh/SLOBsHg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=GLA4JLQv/NLSloJATnzmE7UGLXbdc+YRL7PWuDpmsuVStnK6/wFWikcw+hH3IhoH2
 mSFcU6w3+iUJZb8D2/FvYZLsCsBYVuROXk5gcAjyGZIAGSNjGrzDFS5lfCYxUZwN0x
 jBLeOZhzYk6hI1jnu5BbYv3n7xaO07oWZvl74q/0nya1xjti+7jAKNSOZ+Jyi06pqt
 Hes89G5+2+MuwyyV/0kDftApgbKnRDwGi8XB3rY/BBKxy/SawSfrwifptapw/QT2q8
 fXpYV9jhPSFqaSj2ThOCFW9J3pIt2j6HTbPIyeglcfKe3wykBzY5QWEKH+u1r5qNde
 XxYsyNTJbiXPg==
Date: Wed, 1 May 2024 13:39:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 03/17] xen: mapcache: Refactor lock functions for
 multi-instance
In-Reply-To: <20240430164939.925307-4-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011339230.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-4-edgar.iglesias@gmail.com>
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
> Make the lock functions take MapCache * as argument. This is
> in preparation for supporting multiple caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index b7cefb78f7..3f11562075 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -74,14 +74,14 @@ typedef struct MapCache {
>  
>  static MapCache *mapcache;
>  
> -static inline void mapcache_lock(void)
> +static inline void mapcache_lock(MapCache *mc)
>  {
> -    qemu_mutex_lock(&mapcache->lock);
> +    qemu_mutex_lock(&mc->lock);
>  }
>  
> -static inline void mapcache_unlock(void)
> +static inline void mapcache_unlock(MapCache *mc)
>  {
> -    qemu_mutex_unlock(&mapcache->lock);
> +    qemu_mutex_unlock(&mc->lock);
>  }
>  
>  static inline int test_bits(int nr, int size, const unsigned long *addr)
> @@ -369,9 +369,9 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>  {
>      uint8_t *p;
>  
> -    mapcache_lock();
> +    mapcache_lock(mapcache);
>      p = xen_map_cache_unlocked(phys_addr, size, lock, dma);
> -    mapcache_unlock();
> +    mapcache_unlock(mapcache);
>      return p;
>  }
>  
> @@ -384,7 +384,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>      ram_addr_t raddr;
>      int found = 0;
>  
> -    mapcache_lock();
> +    mapcache_lock(mapcache);
>      QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
>          if (reventry->vaddr_req == ptr) {
>              paddr_index = reventry->paddr_index;
> @@ -394,7 +394,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          }
>      }
>      if (!found) {
> -        mapcache_unlock();
> +        mapcache_unlock(mapcache);
>          return RAM_ADDR_INVALID;
>      }
>  
> @@ -409,7 +409,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
>               ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
>      }
> -    mapcache_unlock();
> +    mapcache_unlock(mapcache);
>      return raddr;
>  }
>  
> @@ -480,9 +480,9 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
>  {
>      XenMapCacheData *data = opaque;
>  
> -    mapcache_lock();
> +    mapcache_lock(mapcache);
>      xen_invalidate_map_cache_entry_unlocked(data->buffer);
> -    mapcache_unlock();
> +    mapcache_unlock(mapcache);
>  
>      aio_co_wake(data->co);
>  }
> @@ -498,9 +498,9 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
>                                  xen_invalidate_map_cache_entry_bh, &data);
>          qemu_coroutine_yield();
>      } else {
> -        mapcache_lock();
> +        mapcache_lock(mapcache);
>          xen_invalidate_map_cache_entry_unlocked(buffer);
> -        mapcache_unlock();
> +        mapcache_unlock(mapcache);
>      }
>  }
>  
> @@ -512,7 +512,7 @@ void xen_invalidate_map_cache(void)
>      /* Flush pending AIO before destroying the mapcache */
>      bdrv_drain_all();
>  
> -    mapcache_lock();
> +    mapcache_lock(mapcache);
>  
>      QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
>          if (!reventry->dma) {
> @@ -546,7 +546,7 @@ void xen_invalidate_map_cache(void)
>  
>      mapcache->last_entry = NULL;
>  
> -    mapcache_unlock();
> +    mapcache_unlock(mapcache);
>  }
>  
>  static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
> @@ -606,8 +606,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
>  {
>      uint8_t *p;
>  
> -    mapcache_lock();
> +    mapcache_lock(mapcache);
>      p = xen_replace_cache_entry_unlocked(old_phys_addr, new_phys_addr, size);
> -    mapcache_unlock();
> +    mapcache_unlock(mapcache);
>      return p;
>  }
> -- 
> 2.40.1
> 

