Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1D5C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgdx-0005w0-Uk; Mon, 12 Aug 2024 21:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgdw-0005in-F3
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:48:12 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sdgdu-0000S9-UK
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:48:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E3D6261522;
 Tue, 13 Aug 2024 01:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A4DC4AF0D;
 Tue, 13 Aug 2024 01:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723513689;
 bh=LynzrHYz8D0kw2B04lBsBEFfNJwdRhtojW0Yvbjp3qQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=XbvMesIUTszXI/eTME4zydA6roCrVH5Fapt4+25OQsRQ219lE794BCMnotWSbFhOK
 5cKSJXzO0+g2gdHeBImOFjuvw7YSYyVtAUY/yvQ7+/CpdBCF1Xh94kXaTkpVIQXd/L
 iUqvp27U17axV7oY2jir3sHaRbIRBNLkTdiC3APYuY3CcvInex14A/tNkQOf0s+JXb
 euhC0w0OGzQ13OenNlNURydVn8W7vDouK5q3UEvRqimvhxKnUQwRI5EoQc8ZuFew5m
 OYQ4j173cIZiyd8I9bNU23aKetIiDls47NgFs7bBipAdmto/SG7f4lVxX+JN5OswtR
 jKB1CC7LfiqaA==
Date: Mon, 12 Aug 2024 18:48:07 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 07/10] hw/arm: xenpvh: Reverse virtio-mmio creation
 order
In-Reply-To: <20240812130606.90410-8-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408121813200.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-8-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> We've been creating the virtio-mmio devices in forwards order
> but since the qbus lists prepend (rather than append) entries,
> the virtio busses end up with decreasing base address order.
> 
> Xen enables virtio-mmio nodes in forwards order so there's been
> a missmatch. So far, we've been working around this with an
> out-of-tree patch to Xen.
> 
> This reverses the order making sure the virtio busses end up
> ordered with increasing base addresses avoiding the need to
> patch Xen.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-pvh-common.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> index 0d368398d0..69a2dbdb6d 100644
> --- a/hw/xen/xen-pvh-common.c
> +++ b/hw/xen/xen-pvh-common.c
> @@ -73,7 +73,18 @@ static void xen_create_virtio_mmio_devices(XenPVHCommonState *s)
>  {
>      int i;
>  
> -    for (i = 0; i < s->cfg.virtio_mmio_num; i++) {
> +    /*
> +     * We create the transports in reverse order. Since qbus_realize()
> +     * prepends (not appends) new child buses, the decrementing loop below will
> +     * create a list of virtio-mmio buses with increasing base addresses.
> +     *
> +     * When a -device option is processed from the command line,
> +     * qbus_find_recursive() picks the next free virtio-mmio bus in forwards
> +     * order.
> +     *
> +     * This is what the Xen tools expect.
> +     */
> +    for (i = s->cfg.virtio_mmio_num - 1; i >= 0; i--) {
>          hwaddr base = s->cfg.virtio_mmio.base + i * s->cfg.virtio_mmio.size;
>          qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
>                                           s->cfg.virtio_mmio_irq_base + i);
> -- 
> 2.43.0
> 

