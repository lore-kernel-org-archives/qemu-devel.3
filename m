Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2905ECD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpg2-0001yr-Kx; Thu, 11 Jun 2026 20:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wXpg1-0001yR-9J; Thu, 11 Jun 2026 20:23:13 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wXpfz-00045t-Ky; Thu, 11 Jun 2026 20:23:12 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14C0D6020C;
 Fri, 12 Jun 2026 00:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E051F00A3A;
 Fri, 12 Jun 2026 00:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781223789;
 bh=Eh31pr64KwoQ5BTPPJkXJm8lIdJz15yknbTRzZMoRRg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=G3+aiK0KBYMEmMC7e50mRtxpMdmo2d5pJUwRIo9iKCkep+izCjZe+Xpk3cIaeBLPA
 dI9Gu7mYiI2H51N89dITk9fTyyHp0k7tZa7h6JsZGuqcdDLH6cYsrPFymZzenL7iq7
 hbdYZi/j6ZHKdO4CYHvxjiCKsIEDY0xDwry1P/xCODb9r9oAdu2Begkv2fj+Ry+77o
 qTG64F91KpsFm8ullSyNLIgEfLdBRiS8kQI3x+IbVmgRycYTeBgGs0FKJU4eFzbNjV
 xOvV+15eGMVpzbhZ6ISy/1MiYz+TbzhMpxWPE+oYCdcfqaBp95HSM8akQmJ47HcRoR
 yBMtrrT3MtElQ==
Date: Thu, 11 Jun 2026 17:23:08 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 8/8] hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
In-Reply-To: <6c22c43668b995a71b0880bd146f09ae5f8956cc.1779916560.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.22.394.2606111720190.368315@ubuntu-linux-20-04-desktop>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
 <6c22c43668b995a71b0880bd146f09ae5f8956cc.1779916560.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=sstabellini@kernel.org; helo=tor.source.kernel.org
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

On Wed, 27 May 2026, Christian Schoenebeck wrote:
> Constrain max_count in v9fs_readdir() to transport's current, real
> response buffer size before calling v9fs_do_readdir() to prevent
> excessive host memory allocation by bad clients.
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
> ---
>  hw/9pfs/9p.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 2bb42dfc2e..fa8c7243a7 100644
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
> @@ -2660,9 +2661,22 @@ static void coroutine_fn v9fs_readdir(void *opaque)
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

response_buffer_size() can return less than 11 here...


> +        if (max_resp_sz > buf_size) {
> +            max_resp_sz = buf_size;

max_resp_sz becomes less than 11


> +        }
> +    }
> +
>      /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4] */
> -    if (max_count > s->msize - 11) {
> -        max_count = s->msize - 11;
> +    if (max_count > max_resp_sz - 11) {

max_resp_sz - 11 causes an underflow


> +        max_count = max_resp_sz - 11;
>          warn_report_once(
>              "9p: bad client: T_readdir with count > msize - 11"
>          );
> -- 
> 2.47.3
> 

