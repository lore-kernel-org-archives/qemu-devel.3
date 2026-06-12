Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE54FCD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpgF-0001zg-FS; Thu, 11 Jun 2026 20:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wXpg8-0001zJ-0a; Thu, 11 Jun 2026 20:23:21 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wXpg6-00046t-HS; Thu, 11 Jun 2026 20:23:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A67660213;
 Fri, 12 Jun 2026 00:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D92A1F000E9;
 Fri, 12 Jun 2026 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781223796;
 bh=8TYK6kA6oWDeS0+holxo/I9eQcUxDQjC49dKzEVfUiU=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=npFpkTrs3Qfr5b/PjPWUFESt8QfuoOqTQuU9dZK4yasP+UUAydeLHoR2UBIIJ5NiI
 ftPuyRw+kHNBepp2RG0+aDko2x4PoLHfO51EFomnew/XVMrBPkJ8kU8oY7bSHK+26i
 PaVMAVOsp0eZ2dZzfyWHjrhAT3DUAXiGnA+GJHrKBiYOPRh+qvLKZb1qd1XcEet8la
 k2lXD1DG2J0QggRv+ERUnR12NVQJMGeIdUnu5teFX/hXBT8Fuoeb5m5wR03nd2llwn
 mTkWYosXTgS9kcdTWmJEhv0yxsiPwgt+Gj78OGXyuUHn0WJQAi9aU69ir7sntVI4qY
 /eu5M0h42bgOQ==
Date: Thu, 11 Jun 2026 17:23:15 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 7/8] 9pfs/xen: implement response_buffer_size callback
In-Reply-To: <95ab978f1919cf91ea1f2a5de6c870e30e420b32.1779916560.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.22.394.2606111710000.368315@ubuntu-linux-20-04-desktop>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
 <95ab978f1919cf91ea1f2a5de6c870e30e420b32.1779916560.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
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
> Add and implement the response_buffer_size callback for the Xen
> transport.
> 
> Returns the size of the response buffer from the rings in_sg, as limit
> for 9p server while generating a response for supplied PDU.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/xen-9p-backend.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 94654022fe..258a1f2ec7 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -256,6 +256,16 @@ static size_t xen_9p_msize_limit(V9fsState *s)
>      return XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
>  }
>  
> +static size_t xen_9pfs_response_buffer_size(V9fsPDU *pdu)
> +{
> +    Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
> +    Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
> +    int num;
> +
> +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, 0);
> +    return iov_size(ring->sg, num);
> +}

xen_9pfs_init_out_iov_from_pdu and xen_9pfs_init_in_iov_from_pdu
allocate ring->sg, but it would seem xen_9pfs_response_buffer_size could
be called before xen_9pfs_init_out_iov_from_pdu and
xen_9pfs_init_in_iov_from_pdu, therefore ring->sg could be NULL here.

If we do it this way, we avoid the NULL dereference.

   struct iovec in_sg[2];

   xen_9pfs_in_sg(ring, in_sg, &num, pdu->idx, 0);
   return iov_size(in_sg, num);



>  static const V9fsTransport xen_9p_transport = {
>      .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
>      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
> @@ -263,6 +273,7 @@ static const V9fsTransport xen_9p_transport = {
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

