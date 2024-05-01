Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBE3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2GsX-0004iF-Lu; Wed, 01 May 2024 16:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GsQ-0004fR-5q
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:48:30 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GsO-0001Sd-IQ
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:48:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7214FCE139C;
 Wed,  1 May 2024 20:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA10C072AA;
 Wed,  1 May 2024 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596504;
 bh=uB6XjGflA6a/Z9KWVzsfz+aOYvxcUGxBLL/TwR9pkFs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=iwekIfW4ncfiIJmnmkdKgjvkep1Mtu/5PqdNUKPK4DjotSAhdrFGNF15yY5//N7/e
 K1VxqOgnLkfoPkk7xTCOf3hqRoMNcNOp7lygw2QHtsdXBJxT6I2yvkqJ2Wo3nyYrk7
 tPfeP5kbp9W0CJMn/JyMClbtqLB8fh0JTlQB+1ENg3lBinJIuSiqRZK8dxkT1IubrX
 G89QC/1Yvu1uwQOGTyG1nnNkHcRIFpYGCoknkppuwhJhH5Oem/i8Lf5XIX+flZ7aeM
 MIs9DuoSsHZ/Oejv41Dd4d6wxqPf4Pxldgze/ZZp1BayZUT/v86E5WlG5NS2gPUX8A
 vNR0wxzo+Fi2Q==
Date: Wed, 1 May 2024 13:48:20 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 09/17] xen: mapcache: Break out
 xen_invalidate_map_cache_single()
In-Reply-To: <20240430164939.925307-10-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011348130.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-10-edgar.iglesias@gmail.com>
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
> Break out xen_invalidate_map_cache_single().
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 34454da2f6..dd08cd296b 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -512,17 +512,14 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
>      }
>  }
>  
> -void xen_invalidate_map_cache(void)
> +static void xen_invalidate_map_cache_single(MapCache *mc)
>  {
>      unsigned long i;
>      MapCacheRev *reventry;
>  
> -    /* Flush pending AIO before destroying the mapcache */
> -    bdrv_drain_all();
> -
> -    mapcache_lock(mapcache);
> +    mapcache_lock(mc);
>  
> -    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
> +    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
>          if (!reventry->dma) {
>              continue;
>          }
> @@ -530,8 +527,8 @@ void xen_invalidate_map_cache(void)
>                                         reventry->vaddr_req);
>      }
>  
> -    for (i = 0; i < mapcache->nr_buckets; i++) {
> -        MapCacheEntry *entry = &mapcache->entry[i];
> +    for (i = 0; i < mc->nr_buckets; i++) {
> +        MapCacheEntry *entry = &mc->entry[i];
>  
>          if (entry->vaddr_base == NULL) {
>              continue;
> @@ -552,9 +549,17 @@ void xen_invalidate_map_cache(void)
>          entry->valid_mapping = NULL;
>      }
>  
> -    mapcache->last_entry = NULL;
> +    mc->last_entry = NULL;
>  
> -    mapcache_unlock(mapcache);
> +    mapcache_unlock(mc);
> +}
> +
> +void xen_invalidate_map_cache(void)
> +{
> +    /* Flush pending AIO before destroying the mapcache */
> +    bdrv_drain_all();
> +
> +    xen_invalidate_map_cache_single(mapcache);
>  }
>  
>  static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
> -- 
> 2.40.1
> 

