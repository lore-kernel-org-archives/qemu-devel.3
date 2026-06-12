Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BCCCD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 23:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYAvC-0005o0-Iy; Fri, 12 Jun 2026 19:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wYAvA-0005nl-Tb; Fri, 12 Jun 2026 19:04:17 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wYAv9-0006rJ-4Z; Fri, 12 Jun 2026 19:04:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 655CE43D9B;
 Fri, 12 Jun 2026 23:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3F51F000E9;
 Fri, 12 Jun 2026 23:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781305452;
 bh=QWV8ZzYKJf4ZvcssleFuSWdQJicCUKyF0vtOl+hVNLA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=X9UIxM5UBmT8mrJBaqHleGJQvKefthMOm1YrDqlH8EkVkdzPin7b6+sRam843Ls5r
 VK6yInHY76JG9Q53ZsYzcX1/AF9bJF3g3pmxCHbof7yWEMamg9vK5DgEzV4F8VqITE
 ctDMePWIuxj8ufSUf1D//gB6tK3hKQY9p1O186+54reQg0tkmbg2NS48jtMe9N/FOI
 jSLINXJKPtNaGpl9DKnWeJNQYkNwLqlsheTpAtZVlLZ+vFS0uk75/tH4k+lnz5iC9a
 IhDcBycJvHNPS0/25ygUc3IazlxMp7tdlx+GtTm25YOadYkGIXHk8fpca6VIU+6i2N
 U2LgpzOOav9Bw==
Date: Fri, 12 Jun 2026 16:04:08 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 8/8] hw/9pfs: cap Treaddir allocation
 (CVE-2026-9238)
In-Reply-To: <f81a387a2de4f2172fd5830c5654f49d78102254.1781287774.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.22.394.2606121603590.368315@ubuntu-linux-20-04-desktop>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
 <f81a387a2de4f2172fd5830c5654f49d78102254.1781287774.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 12 Jun 2026, Christian Schoenebeck wrote:
> Constrain max_count in v9fs_readdir() to transport's current, real
> response buffer size before calling v9fs_do_readdir() to prevent
> excessive host memory allocation for specific, crafted, huge
> directories (large amount of entries) by bad clients.
> 
> Client may send a Treaddir request with a large 'count' parameter, and
> while the negotiated 'msize' provides some limit, it accounts for guest
> being somewhat faithful on the negotiated 'msize' value throughout the
> session.
> 
> A bad guest client could have negotiated a large 'msize' but provide a
> small reply buffer for Treaddir request, causing QEMU to allocate host
> memory proportional to 'msize' before discovering the reply cannot fit.
> 
> Possible consequence was a potential DoS by a priviliged guest, causing
> a disconnection of guest communication due to transport device being
> marked as "broken", however QEMU process would have continued to run with
> potentially giant host memory allocation, which might have negative
> impact on other services running on host.
> 
> Fixes: CVE-2026-9238
> Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/9pfs/9p.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 2bb42dfc2e..c3e78779b7 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2652,6 +2652,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
>      uint32_t max_count;
>      V9fsPDU *pdu = opaque;
>      V9fsState *s = pdu->s;
> +    size_t max_resp_sz;
>  
>      retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
>                             &initial_offset, &max_count);
> @@ -2660,9 +2661,28 @@ static void coroutine_fn v9fs_readdir(void *opaque)
>      }
>      trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
>  
> +    max_resp_sz = s->msize;
> +
> +    /*
> +     * Constrain max_count to transport's current, actual response buffer size.
> +     * A bad client might provide a response buffer < msize.
> +     */
> +    if (s->transport->response_buffer_size) {
> +        size_t buf_size = s->transport->response_buffer_size(pdu);
> +        if (max_resp_sz > buf_size) {
> +            max_resp_sz = buf_size;
> +        }
> +    }
> +
>      /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4] */
> -    if (max_count > s->msize - 11) {
> -        max_count = s->msize - 11;
> +    if (max_resp_sz > 11) {
> +        max_resp_sz -= 11;
> +    } else {
> +        max_resp_sz = 0;
> +    }
> +
> +    if (max_count > max_resp_sz) {
> +        max_count = max_resp_sz;
>          warn_report_once(
>              "9p: bad client: T_readdir with count > msize - 11"
>          );
> -- 
> 2.47.3
> 

