Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A430C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 22:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Naq-0007DJ-5p; Wed, 15 May 2024 18:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7Nao-0007D9-GJ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 18:59:26 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7Nam-0000Fa-Qh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 18:59:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1948DCE17F6;
 Wed, 15 May 2024 22:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3147DC116B1;
 Wed, 15 May 2024 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715813959;
 bh=PuBmX/ivAL1E5OY/yAsh7Z0SAl45lNmEAHpdkIGYzxE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=e3QOvWUOIgnmEXQs3JkhVxWDYnh8aOpTMiWPsosWMfv9AUd4TbZemDbjJMQ+IR8dT
 zahxNbSOWgrRD0DVXZ0lWjeDTPjQPmzg9TTx5bFvRcD2PqOwqYG04G96NLP1SVWwxb
 dGXSKpg5C2JgnTkDWiGRP+Yqd9X6GSFGuwb43A580MGT4EjztQf155ReqC+8Txm8Nn
 18wZIPxUqA3LfZymYfIN6g3fRUL7hfLiAdM8QTA8yS295NNz2296Im1ann02pTaY2A
 HbUQNYPhrNsDUsxpX+zPu9WqWRz/B/SgcXoD6HSQ9Wl5XSiBDJ60miyCWR62mDF154
 fdo84PhNAirtQ==
Date: Wed, 15 May 2024 15:59:16 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 5/8] softmmu: Replace check for RAMBlock offset 0 with
 xen_mr_is_memory
In-Reply-To: <20240503014449.1046238-6-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405151559070.2544314@ubuntu-linux-20-04-desktop>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
 <20240503014449.1046238-6-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Fri, 3 May 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> For xen, when checking for the first RAM (xen_memory), use
> xen_mr_is_memory() rather than checking for a RAMBlock with
> offset 0.
> 
> All Xen machines create xen_memory first so this has no
> functional change for existing machines.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  system/physmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 5e6257ef65..b7847db1a2 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2229,7 +2229,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>           * because we don't want to map the entire memory in QEMU.
>           * In that case just map the requested area.
>           */
> -        if (block->offset == 0) {
> +        if (xen_mr_is_memory(block->mr)) {
>              return xen_map_cache(block->mr, block->offset + addr,
>                                   len, lock, lock,
>                                   is_write);
> -- 
> 2.40.1
> 

