Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC27FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 20:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Gma-0001Oj-CR; Wed, 01 May 2024 16:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GmV-0001OO-BJ
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:42:23 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2GmT-0000Pj-DY
 for qemu-devel@nongnu.org; Wed, 01 May 2024 16:42:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CD03CCE1397;
 Wed,  1 May 2024 20:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B17DC072AA;
 Wed,  1 May 2024 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714596137;
 bh=aPj5Km8vv8/JMkrkcHnSlAuBWQc5h+3YCn0oWQVhKgM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=pw9mN7wE5W0kBjURzYbZPaBpQgGclQKmXA5GVhbirwYjucLiZQSWH7SP3t5q0YiBM
 80nhotmvGLNq5tsd9pMDfz+KTrGgOouy+4lq1zwK/eTa2xvcecYAIlNOQ1I7iL8g6P
 /y5EoO/q/FuK8kScb+QtEGdus9bhzjjs0PqDzz0dOiPhXA0sTslGh/P77zDGgASjpt
 dyWbkanAWsVhV7+zIK8f3pb4LvCKdzNFoRIwIYAQGl+D5T/eeY8dAxf+ZNwK6Ml3Ju
 WV9eJ3D6Fu/Amw7iz5yMn2Ajf9Lniq6j3iJHgF3cynIsJiiHVpGTpGmN01+BqCBkH+
 +0BBo1A0RjUaQ==
Date: Wed, 1 May 2024 13:42:12 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 05/17] xen: mapcache: Refactor xen_remap_bucket for
 multi-instance
In-Reply-To: <20240430164939.925307-6-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011341590.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-6-edgar.iglesias@gmail.com>
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
> Add MapCache argument to xen_remap_bucket in preparation
> to support multiple map caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 896021d86f..326a9b61ca 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -139,7 +139,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>      mapcache->entry = g_malloc0(size);
>  }
>  
> -static void xen_remap_bucket(MapCacheEntry *entry,
> +static void xen_remap_bucket(MapCache *mc,
> +                             MapCacheEntry *entry,
>                               void *vaddr,
>                               hwaddr size,
>                               hwaddr address_index,
> @@ -313,14 +314,14 @@ tryagain:
>      if (!entry) {
>          entry = g_new0(MapCacheEntry, 1);
>          pentry->next = entry;
> -        xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
> +        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
>      } else if (!entry->lock) {
>          if (!entry->vaddr_base || entry->paddr_index != address_index ||
>                  entry->size != cache_size ||
>                  !test_bits(address_offset >> XC_PAGE_SHIFT,
>                      test_bit_size >> XC_PAGE_SHIFT,
>                      entry->valid_mapping)) {
> -            xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
> +            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
>          }
>      }
>  
> @@ -587,7 +588,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
>  
>      trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
>  
> -    xen_remap_bucket(entry, entry->vaddr_base,
> +    xen_remap_bucket(mapcache, entry, entry->vaddr_base,
>                       cache_size, address_index, false);
>      if (!test_bits(address_offset >> XC_PAGE_SHIFT,
>                  test_bit_size >> XC_PAGE_SHIFT,
> -- 
> 2.40.1
> 

