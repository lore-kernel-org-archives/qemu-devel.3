Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A55CED242
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvQx-00089G-Vw; Mon, 07 Oct 2024 17:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sxvQw-000892-BT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:38:26 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sxvQt-0003Sm-Pc
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:38:25 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CB92D5C5DC1;
 Mon,  7 Oct 2024 21:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5EBC4CEC6;
 Mon,  7 Oct 2024 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728337100;
 bh=sEdm/Squhg0RayXaMiMYS8WlURo2VsJiTcHepsTlbOw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=OfQMnxzS4bmH0pWAKZUSygxAlGllc7trAVGMqekjMME2xfZiWhzE5d71Zf/7/Qu6/
 P+Spgssnwj6FQbW1seYFxBfGB6iv5NGZKy+mOTD3BxYiqzaebsoOnq2je21ra0q9oy
 qrkRdcUrljMKGo8Tu8qhCTQ5/hf7u3+3JrEzNg7Y4TShpkSsTpuodEg8ZibudQq5KK
 YsQtvo8VbLuaR8I8TDtnA+9M/ew6lkO9tEeIKGxA7gluhxJzigl78n9GCzkKd1ksil
 IUKVga62b580GgKAgl496YPD6aWncR8d7YpaCPV0dEzGLbwYW3flCoE9lo1A38+GqL
 ockWvt1U0b53A==
Date: Mon, 7 Oct 2024 14:38:18 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 1/1] hw/xen: Avoid use of uninitialized bufioreq_evtchn
In-Reply-To: <20241007211643.1572271-2-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2410071438110.3512606@ubuntu-linux-20-04-desktop>
References: <20241007211643.1572271-1-edgar.iglesias@gmail.com>
 <20241007211643.1572271-2-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Mon, 7 Oct 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Avoid use of uninitialized bufioreq_evtchn. It should only
> be used if buffered IOREQs are enabled.
> 
> Resolves: Coverity CID 1563383
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-hvm-common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 7d2b72853b..7ffbbfea23 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -752,9 +752,10 @@ static int xen_map_ioreq_server(XenIOState *state)
>          return -1;
>      }
>  
> -    trace_xen_map_ioreq_server_buffered_io_evtchn(bufioreq_evtchn);
> -
> -    state->bufioreq_remote_port = bufioreq_evtchn;
> +    if (state->has_bufioreq) {
> +        trace_xen_map_ioreq_server_buffered_io_evtchn(bufioreq_evtchn);
> +        state->bufioreq_remote_port = bufioreq_evtchn;
> +    }
>  
>      return 0;
>  }
> -- 
> 2.43.0
> 

