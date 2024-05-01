Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC921C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 21:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2H5D-0003w1-BW; Wed, 01 May 2024 17:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2H4t-0003tA-U8
 for qemu-devel@nongnu.org; Wed, 01 May 2024 17:01:35 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2H4s-0003iX-Bp
 for qemu-devel@nongnu.org; Wed, 01 May 2024 17:01:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C679861904;
 Wed,  1 May 2024 21:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5CDC072AA;
 Wed,  1 May 2024 21:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714597280;
 bh=dtQxKmYbUUAzg4PTwI2TWD3iTTIdynxCbqah4NU3uMY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=VdMU18FGFqxEyNw0aTaOPXv3Ul/pct0Iux+iBqKTrtj4cklV45ZUfU02ttl+Kcou1
 v2UD5KcbOZPVKahSrDO4YFe+mv9tOe2afCiRtm+bw+Yf7rJPNwX0EgTJtwXMsTAhmz
 J0GwF1MF6Ob/tMTgNFRoALk6BfmfY0VI6D8GKxWecK7bOfKwBlFFQAhIQI/00ciHYf
 0eCkPb2QQpktbhCP4bXySCiz1vyREpiFg+NURL3RAN6m+s1+NnkdJvSxAf5rd3MO0e
 bJCG9DCYMa6q0xVYkZgJq8Ou206Tkke9AEmhioil3oASgMlz6f18c/lpkR/NEMUKRJ
 xAotpSCdUaKrQ==
Date: Wed, 1 May 2024 14:01:17 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 12/17] xen: mapcache: Unmap first entries in buckets
In-Reply-To: <20240430164939.925307-13-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011401110.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-13-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
> When invalidating memory ranges, if we happen to hit the first
> entry in a bucket we were never unmapping it. This was harmless
> for foreign mappings but now that we're looking to reuse the
> mapcache for transient grant mappings, we must unmap entries
> when invalidated.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 4f98d284dd..0365311788 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -486,18 +486,22 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>          return;
>      }
>      entry->lock--;
> -    if (entry->lock > 0 || pentry == NULL) {
> +    if (entry->lock > 0) {
>          return;
>      }
>  
> -    pentry->next = entry->next;
>      ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
>      if (munmap(entry->vaddr_base, entry->size) != 0) {
>          perror("unmap fails");
>          exit(-1);
>      }
> -    g_free(entry->valid_mapping);
> -    g_free(entry);
> +    if (pentry) {
> +        pentry->next = entry->next;
> +        g_free(entry->valid_mapping);
> +        g_free(entry);
> +    } else {
> +        memset(entry, 0, sizeof *entry);
> +    }
>  }
>  
>  typedef struct XenMapCacheData {
> -- 
> 2.40.1
> 

