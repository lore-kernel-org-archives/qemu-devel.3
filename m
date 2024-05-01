Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C638C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Go7-0002Dn-0s; Wed, 01 May 2024 16:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Go6-0002DP-2f
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:44:02 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Go4-0000XH-0D
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:44:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 30EFACE13A1;
 Wed,  1 May 2024 20:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C9AC072AA;
 Wed,  1 May 2024 20:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596236;
 bh=dMPFSioNpeKX2paci1uyX5JomVV7+chkLPnWnqSos4g=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=kaD1Ev+gEHDi1RM3cxVcWSCs1dGKiF7D6a4EEPW01+V2qzesATeYhJtscbgpusFWj
 WZ0b84Wlrnw+W+nPG/R8jiLTiRUihlQaFtdPpwJh7hq0MkXQpdmFaI4IERTa3c5xX0
 +zoAUdmoHAA4Fz18zF82DnmDI6V6vs8ATDbtDaOoodBL9OmlYBkfKLY9psFSo6Rlbl
 Qzpi5NoRJvRrf/7rq/0dithiLHVzGz7EtIgwPm2EeQWB0BuxWoTbj21x3oW3Eexp14
 8V/Kxs7WITjcqm2EdaiwDRGwUsLhce7VVyBnSdkxaW0p9tP7a7632d/UZ0Y2WFv6Ok
 lXiUWh9A3P23g==
Date: Wed, 1 May 2024 13:43:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 06/17] xen: mapcache: Break out
 xen_ram_addr_from_mapcache_single
In-Reply-To: <20240430164939.925307-7-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011343460.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-7-edgar.iglesias@gmail.com>
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
> Break out xen_ram_addr_from_mapcache_single(), a multi-cache
> aware version of xen_ram_addr_from_mapcache.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 326a9b61ca..d2deff70c8 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -377,7 +377,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>      return p;
>  }
>  
> -ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
>  {
>      MapCacheEntry *entry = NULL;
>      MapCacheRev *reventry;
> @@ -386,8 +386,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>      ram_addr_t raddr;
>      int found = 0;
>  
> -    mapcache_lock(mapcache);
> -    QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
> +    mapcache_lock(mc);
> +    QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
>          if (reventry->vaddr_req == ptr) {
>              paddr_index = reventry->paddr_index;
>              size = reventry->size;
> @@ -396,11 +396,11 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          }
>      }
>      if (!found) {
> -        mapcache_unlock(mapcache);
> +        mapcache_unlock(mc);
>          return RAM_ADDR_INVALID;
>      }
>  
> -    entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
> +    entry = &mc->entry[paddr_index % mc->nr_buckets];
>      while (entry && (entry->paddr_index != paddr_index || entry->size != size)) {
>          entry = entry->next;
>      }
> @@ -411,10 +411,15 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
>               ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
>      }
> -    mapcache_unlock(mapcache);
> +    mapcache_unlock(mc);
>      return raddr;
>  }
>  
> +ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +{
> +    return xen_ram_addr_from_mapcache_single(mapcache, ptr);
> +}
> +
>  static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
>  {
>      MapCacheEntry *entry = NULL, *pentry = NULL;
> -- 
> 2.40.1
> 

