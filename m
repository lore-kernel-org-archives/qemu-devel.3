Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23573C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2GqC-0003Nf-9t; Wed, 01 May 2024 16:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GqA-0003N7-TH
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:46:10 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2Gq9-0001FS-2K
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:46:10 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CC645CE139B;
 Wed,  1 May 2024 20:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F93AC072AA;
 Wed,  1 May 2024 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596365;
 bh=NArfGwWOnY6xyqS3W5ubl410JY9KsJxvONK6riU3GOc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=HHwNvdY2yKMVzPmRX8GkA9qORm2TkcII9FkOlpbsMceq9wUHFpeUG6DwZbn/75m7S
 gSwRdvKsTLBYG0tW540NuLGw4WW32Sm2ojn5QCMbmQReQelL/s9u1cSsa6dOzCud+E
 1RDEjW/MvHQdXBM8oNZOl9uOC+TCcP2cpFuknsM+7kd9eI/d3fnyILqbc5iRvnRKox
 uCcTy3cCvjL7wn2P/DMFPzq81WK3qNmqY9Q3tcchT4N6juZoco/8ZoRhINDZXIHdCG
 4/Ny13TpMRNKoqa/WH4whayB+NiNSmP/C87BkFDTXqDkWZhupOslvWrD/MYY3nddtQ
 0+dEZAM3hh95Q==
Date: Wed, 1 May 2024 13:46:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 07/17] xen: mapcache: Refactor
 xen_replace_cache_entry_unlocked
In-Reply-To: <20240430164939.925307-8-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011345140.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-8-edgar.iglesias@gmail.com>
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
> Add MapCache argument to xen_replace_cache_entry_unlocked in
> preparation for supporting multiple map caches.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/xen/xen-mapcache.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index d2deff70c8..6e758eff94 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -556,7 +556,8 @@ void xen_invalidate_map_cache(void)
>      mapcache_unlock(mapcache);
>  }
>  
> -static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
> +static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
> +                                                 hwaddr old_phys_addr,
>                                                   hwaddr new_phys_addr,
>                                                   hwaddr size)
>  {
> @@ -578,7 +579,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
>          cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
>      }
>  
> -    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
> +    entry = &mc->entry[address_index % mc->nr_buckets];
>      while (entry && !(entry->paddr_index == address_index &&
>                        entry->size == cache_size)) {
>          entry = entry->next;

There is still a global mapcache pointer in use in this function:

  xen_remap_bucket(mapcache, entry, entry->vaddr_base,


> @@ -614,7 +615,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
>      uint8_t *p;
>  
>      mapcache_lock(mapcache);
> -    p = xen_replace_cache_entry_unlocked(old_phys_addr, new_phys_addr, size);
> +    p = xen_replace_cache_entry_unlocked(mapcache, old_phys_addr,
> +                                         new_phys_addr, size);
>      mapcache_unlock(mapcache);
>      return p;
>  }
> -- 
> 2.40.1
> 

