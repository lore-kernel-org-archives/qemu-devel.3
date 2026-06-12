Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B545CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 23:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYAtP-0005D3-PS; Fri, 12 Jun 2026 19:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wYAtN-0005CB-Te; Fri, 12 Jun 2026 19:02:25 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wYAtL-000642-EP; Fri, 12 Jun 2026 19:02:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEF6E60008;
 Fri, 12 Jun 2026 23:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866D21F000E9;
 Fri, 12 Jun 2026 23:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781305341;
 bh=qUMFSb1rLXGHtKIj7QNgM2DmhBMDNN/0CriiqSdUbSk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=NUiIb3vjmLm2fiYnRH3D4NNPUm3E/ytxd5N5bee4zEeK0Q2acYiThUf//aPLN66V1
 U3DAqMcy+IM8i3fNp1fe8NSrZsUj3W2fnqUhDifT9Vg1ae4taihNi+UOLSSyUYS1ND
 OeK2gYc3vIMzbPmKLjvWXPTWzDS4R9LMXd8bIKcGbp7iK7uy3zP5jEUYc7ZvXhYSCE
 +nBF3VlagJYPoN6hadTWfUPSpL/jvZWTPZtqzbWdQjHc+3mj94CZQkqY1g16wiyyoZ
 oHBqlAt2fUgatoD/LbRdeUwfBOm5GfXMHPWMDp7277gmXk0nNy90iLfMPBnsi4KND7
 rqWLTHFMbgJUg==
Date: Fri, 12 Jun 2026 16:02:18 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 7/8] 9pfs/xen: implement response_buffer_size callback
In-Reply-To: <3b139769eb1d3f9d91ee5281228e6467f9a08b99.1781287774.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.22.394.2606121558270.368315@ubuntu-linux-20-04-desktop>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
 <3b139769eb1d3f9d91ee5281228e6467f9a08b99.1781287774.git.qemu_oss@crudebyte.com>
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
> Add and implement the response_buffer_size callback for the Xen
> transport.
> 
> Returns the size of the response buffer from the rings in_sg, as limit
> for 9p server while generating a response for supplied PDU.
> 
> We use a local iovec array variable in_sg[2] instead of ring->sg, as
> ring->sg is only allocated by init_in_iov_from_pdu() and
> init_out_iov_from_pdu() during request / response processing.
> response_buffer_size() however may be called before those allocators,
> which would dereference ring->sg as NULL pointer. The local array
> avoids this.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/9pfs/xen-9p-backend.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index e31124bcf5..24c90d97ec 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -268,6 +268,17 @@ static size_t xen_9p_msize_limit(V9fsState *s)
>      return limit;
>  }
>  
> +static size_t xen_9pfs_response_buffer_size(V9fsPDU *pdu)
> +{
> +    Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
> +    Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
> +    struct iovec in_sg[2];
> +    int num;
> +
> +    xen_9pfs_in_sg(ring, in_sg, &num, pdu->idx, 0);
> +    return iov_size(in_sg, num);
> +}
> +
>  static const V9fsTransport xen_9p_transport = {
>      .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
>      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
> @@ -275,6 +286,7 @@ static const V9fsTransport xen_9p_transport = {
>      .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
>      .push_and_notify = xen_9pfs_push_and_notify,
>      .msize_limit = xen_9p_msize_limit,
> +    .response_buffer_size = xen_9pfs_response_buffer_size,
>  };
>  
>  static int xen_9pfs_init(struct XenLegacyDevice *xendev)
> -- 
> 2.47.3
> 

