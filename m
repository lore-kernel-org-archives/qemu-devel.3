Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B15CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 22:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYAp9-0004L4-Kj; Fri, 12 Jun 2026 18:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wYAp5-0004Ks-GE; Fri, 12 Jun 2026 18:57:59 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wYAp3-0003wb-BZ; Fri, 12 Jun 2026 18:57:58 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5624B60008;
 Fri, 12 Jun 2026 22:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE091F000E9;
 Fri, 12 Jun 2026 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781305068;
 bh=nHF7+r1PmMOMQa9vqhVm7/Ftq4mJCbCOAoxHu9C7nbE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=jvcNY2rU6C39PA/p4ZM65gtNlTzoeeYxVhNOKgzNYjUHJVehBPDF/kt9yBZ4vtCJy
 chkokb0xxnNnJL7MfC//39LKfkaINHEfMXDrOGrh7Toqc6FQ/FZKJ9ZeQDbaDpnYXP
 2TS33Fv+AW8WVJ+zzfxnDcMEETYB8+Cz8dFtofUkNMi7AX6g1SUa9jCRT4tGtoo/7v
 YnLcbwkmJTM1/fgJ4/te6+gOJIQSmHi0g3eTpfdU+OpzLodoRm9rkGnNEyk/jBTLvK
 qysjX2I6Fzy+DMuHEbEglGh2xMCrurXq56OJwgOEkdFQk1s9jaHWcBJnJKFDwVyi7v
 d44ZwsyDAFDng==
Date: Fri, 12 Jun 2026 15:57:44 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 3/8] 9pfs/xen: implement msize_limit callback
In-Reply-To: <9471786bc47b93e822f6c6233a83f2b9f61e6c82.1781287774.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.22.394.2606121557170.368315@ubuntu-linux-20-04-desktop>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
 <9471786bc47b93e822f6c6233a83f2b9f61e6c82.1781287774.git.qemu_oss@crudebyte.com>
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

On Fri, 12 Jun 2026, Christian Schoenebeck wrote:
> Add and implement the msize_limit callback for the Xen transport.
> 
> The limit is calculated using XEN_FLEX_RING_SIZE() based on the
> negotiated ring_order. For the theoretical maximum ring_order of 9,
> this results in a maximum 'msize' of 1048576 bytes (1 MiB).
> 
> The minimum limit of all rings is picked, because multiple rings
> could theoretically have different ring_orders.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  hw/9pfs/xen-9p-backend.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index ca0fff5fa9..e31124bcf5 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -250,12 +250,31 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
>      qemu_bh_schedule(ring->bh);
>  }
>  
> +static size_t xen_9p_msize_limit(V9fsState *s)
> +{
> +    Xen9pfsDev *xen_9pfs = container_of(s, Xen9pfsDev, state);
> +    size_t limit;
> +    int i;
> +
> +    if (!xen_9pfs->num_rings) {
> +        return 0;
> +    }
> +
> +    limit = XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
> +    for (i = 1; i < xen_9pfs->num_rings; i++) {
> +        limit = MIN(limit, XEN_FLEX_RING_SIZE(xen_9pfs->rings[i].ring_order));
> +    }
> +
> +    return limit;
> +}
> +
>  static const V9fsTransport xen_9p_transport = {
>      .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
>      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
>      .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
>      .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
>      .push_and_notify = xen_9pfs_push_and_notify,
> +    .msize_limit = xen_9p_msize_limit,
>  };
>  
>  static int xen_9pfs_init(struct XenLegacyDevice *xendev)
> -- 
> 2.47.3
> 

