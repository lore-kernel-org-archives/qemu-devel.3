Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A50C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Gvk-0006vA-8Z; Wed, 01 May 2024 16:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Gvi-0006ud-O0
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:51:54 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Gvg-00021x-3g
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:51:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D12F2CE138D;
 Wed,  1 May 2024 20:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42476C4AF14;
 Wed,  1 May 2024 20:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596707;
 bh=HR+a7o2ZkxIM6jzJQZXWaVSl9k5NgRnHGAuDGSr6slg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ALDUNZnM70fk4wzKcV3eCENzn3/uRATGRYE9br0E6W/ZkmBon8cgKpqJAmU9vbObQ
 WlS/uOTMmhm1sKXutTcz4jFYzdWB+MgZzttC9peCq3XBbJ3/NDy+rYmH5YDqrvC+M2
 AO8nSPOOA7xV9fbNpjAxhNiNxhjaEHkGD7xVT+tJnTWAhGEZysQEGOlIpHg2hBLl3d
 5OSFAGdVu+ZqvWwC8XYYX/qBrXeYHYq2sII0WXKkIzG+IuGxK4/ZfLcfdZIbQtBGYs
 b1lin2VhOMhQVDLPERnDqnzZsZslla+hsEZCFgvqDKhta23jaqJrc9HEQ46K9xZqtm
 iE74nsTNQYaNg==
Date: Wed, 1 May 2024 13:51:44 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 10/17] xen: mapcache: Break out
 xen_map_cache_init_single()
In-Reply-To: <20240430164939.925307-11-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011351380.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-11-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
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
> Break out xen_map_cache_init_single() in preparation for
> adding multiple map caches.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 53 ++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index dd08cd296b..72a7e25e3e 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -93,23 +93,44 @@ static inline int test_bits(int nr, int size, const unsigned long *addr)
>          return 0;
>  }
>  
> -void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
> +static MapCache *xen_map_cache_init_single(phys_offset_to_gaddr_t f,
> +                                           void *opaque,
> +                                           unsigned long max_size)
>  {
>      unsigned long size;
> -    struct rlimit rlimit_as;
> +    MapCache *mc;
> +
> +    mc = g_new0(MapCache, 1);
> +
> +    mc->phys_offset_to_gaddr = f;
> +    mc->opaque = opaque;
> +    qemu_mutex_init(&mc->lock);
> +
> +    QTAILQ_INIT(&mc->locked_entries);
>  
> -    mapcache = g_new0(MapCache, 1);
> +    mc->max_mcache_size = max_size;
>  
> -    mapcache->phys_offset_to_gaddr = f;
> -    mapcache->opaque = opaque;
> -    qemu_mutex_init(&mapcache->lock);
> +    mc->nr_buckets =
> +        (((mc->max_mcache_size >> XC_PAGE_SHIFT) +
> +          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
> +         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
>  
> -    QTAILQ_INIT(&mapcache->locked_entries);
> +    size = mc->nr_buckets * sizeof(MapCacheEntry);
> +    size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
> +    trace_xen_map_cache_init(mc->nr_buckets, size);
> +    mc->entry = g_malloc0(size);
> +    return mc;
> +}
> +
> +void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
> +{
> +    struct rlimit rlimit_as;
> +    unsigned long max_mcache_size;
>  
>      if (geteuid() == 0) {
>          rlimit_as.rlim_cur = RLIM_INFINITY;
>          rlimit_as.rlim_max = RLIM_INFINITY;
> -        mapcache->max_mcache_size = MCACHE_MAX_SIZE;
> +        max_mcache_size = MCACHE_MAX_SIZE;
>      } else {
>          getrlimit(RLIMIT_AS, &rlimit_as);
>          rlimit_as.rlim_cur = rlimit_as.rlim_max;
> @@ -119,24 +140,14 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>                          " memory is not infinity");
>          }
>          if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE) {
> -            mapcache->max_mcache_size = rlimit_as.rlim_max -
> -                NON_MCACHE_MEMORY_SIZE;
> +            max_mcache_size = rlimit_as.rlim_max - NON_MCACHE_MEMORY_SIZE;
>          } else {
> -            mapcache->max_mcache_size = MCACHE_MAX_SIZE;
> +            max_mcache_size = MCACHE_MAX_SIZE;
>          }
>      }
>  
> +    mapcache = xen_map_cache_init_single(f, opaque, max_mcache_size);
>      setrlimit(RLIMIT_AS, &rlimit_as);
> -
> -    mapcache->nr_buckets =
> -        (((mapcache->max_mcache_size >> XC_PAGE_SHIFT) +
> -          (1UL << (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT)) - 1) >>
> -         (MCACHE_BUCKET_SHIFT - XC_PAGE_SHIFT));
> -
> -    size = mapcache->nr_buckets * sizeof (MapCacheEntry);
> -    size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
> -    trace_xen_map_cache_init(mapcache->nr_buckets, size);
> -    mapcache->entry = g_malloc0(size);
>  }
>  
>  static void xen_remap_bucket(MapCache *mc,
> -- 
> 2.40.1
> 

