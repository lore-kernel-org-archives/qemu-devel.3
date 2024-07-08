Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522F5C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 23:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQxai-0007TW-79; Mon, 08 Jul 2024 19:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sQxac-0007C9-HF
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:16:11 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sQxab-0002Fe-3c
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:16:10 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BCC3B60B21;
 Mon,  8 Jul 2024 23:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B49BC116B1;
 Mon,  8 Jul 2024 23:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720480567;
 bh=7GbhKYDsPcu4phzCxhMkluoCv88SVKjt2IIeSl0eL1k=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=fuhRzxhtTlYg6/uMZ0zBVf8q2tH+55oFRpsD4wePGRGAwDbqRAIKrNKElayxuVPIg
 trGxzlKBdczBoiiHzGduvNlsjuyBIRF+OxfLxKEhDOQI1yt4enBJcMHIXWdczlseJj
 Q2I7/SmEBxzMXeUxtRV7xulu/IuCoGDF5mJwhNI3drTL7E711tON5swKQ7iKXck1el
 im4YQaOwcwav3Wl6Vp15p3HO7Psl1zdXLST8+NiEyEOFoToaXAtvpjdogGQJEaxTvA
 Q7TUKpb239tEzFQGYswTu1UQhCKR6gPlL/oIL+CjTUPbS1YsXIXLJXgpGqCAECGE/3
 jA46/mW3IiKBA==
Date: Mon, 8 Jul 2024 16:16:05 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 Anthony PERARD <anthony.perard@vates.tech>
Subject: Re: [PATCH v1 2/2] xen: mapcache: Fix unmapping of first entries in
 buckets
In-Reply-To: <20240701224421.1432654-3-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2407081615590.3635@ubuntu-linux-20-04-desktop>
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-3-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Tue, 2 Jul 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> This fixes the clobbering of the entry->next pointer when
> unmapping the first entry in a bucket of a mapcache.
> 
> Fixes: 123acd816d ("xen: mapcache: Unmap first entries in buckets")
> Reported-by: Anthony PERARD <anthony.perard@vates.tech>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-mapcache.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 5f23b0adbe..18ba7b1d8f 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -597,7 +597,17 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>          pentry->next = entry->next;
>          g_free(entry);
>      } else {
> -        memset(entry, 0, sizeof *entry);
> +        /*
> +         * Invalidate mapping but keep entry->next pointing to the rest
> +         * of the list.
> +         *
> +         * Note that lock is already zero here, otherwise we don't unmap.
> +         */
> +        entry->paddr_index = 0;
> +        entry->vaddr_base = NULL;
> +        entry->valid_mapping = NULL;
> +        entry->flags = 0;
> +        entry->size = 0;
>      }
>  }
>  
> -- 
> 2.43.0
> 

