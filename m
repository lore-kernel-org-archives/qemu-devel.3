Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55995CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY1Oc-0002xo-DI; Fri, 12 Jun 2026 08:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wY1OZ-0002xE-8F; Fri, 12 Jun 2026 08:53:59 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wY1OX-00088D-Q6; Fri, 12 Jun 2026 08:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=dLpcH3O/3vYaM1ueO0Vy/CQAIqSbwW8P5PnqTon6A9I=; b=DgP6IJNHPU08BW7O/vfBhVfxjE
 O+3LXtisiMa3khRIdOQgqIo16l2K8H8aG/IOUGxoxmRsogbDz3L1x72UAcXRmPIfDjvuc0YfOXH+c
 72BLOSgPrYFfKtlqxCXPrLp3PVbWkpp52ai1awcP5K/ja6cgTjAVL30Qop+Vnrsd1MW42l/lIb/Zj
 2sYxKs2D1+kf3jPsZUB6+zNDdYUD6XilTRW3Khuxmc8/oyXyDNQlxZgF+ecUMTV2oLn30rW6qBcwY
 BYx9Ry+Pe/zfjIK2UkYYPU0W+4Ovz2xPE624bCHcMbENTke9timv2mwxCOx41dYAvR5bF7PxMzz1M
 6Hp8xP5xH2r5/KQTh6/uwYxjg8DbbfkDISRLxDg+2Xs56tAD9pf/gA3u1C2jX1c6G7Qo3+wrcnFvF
 rrv+cIAOlqVsDjC2qix1WicljAGH2xNgzP8FARcFy74n6+wNWiEQrpD/7EUrMhV9LCeBiZsc8rrde
 wdgMyZ1/UvOhIakYAGIvjLm91rx36IFXl2LESR0RucW4/OZUj9cJMB6duvuTiFy1GXjqVGE/Zd4q5
 moLSX9kPRS6LMpnBnw1ekhziocwl6ZX+V/hreiEO0Kukx5q79oGRRF6/JaAuOthF0plOrEpu46Q+S
 rKkP43663aGCHeLfTunZMLSDs+Q2FplxAvIJ0NTsA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Feifan Qian <bea1e@proton.me>, Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 3/8] 9pfs/xen: implement msize_limit callback
Date: Fri, 12 Jun 2026 14:53:51 +0200
Message-ID: <6275293.lOV4Wx5bFT@weasel>
In-Reply-To: <alpine.DEB.2.22.394.2606111638240.368315@ubuntu-linux-20-04-desktop>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
 <7f592f8cdeeea8b91998363ad9599dfb1f2b3108.1779916560.git.qemu_oss@crudebyte.com>
 <alpine.DEB.2.22.394.2606111638240.368315@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, 12 June 2026 01:49:25 CEST Stefano Stabellini wrote:
> On Wed, 27 May 2026, Christian Schoenebeck wrote:
> > Add and implement the msize_limit callback for the Xen transport.
> > 
> > The limit is calculated using XEN_FLEX_RING_SIZE() based on the
> > negotiated ring_order. For the theoretical maximum ring_order of 9,
> > this results in a maximum 'msize' of 1048576 bytes (1 MiB).
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
[...]
> > +static size_t xen_9p_msize_limit(V9fsState *s)
> > +{
> > +    Xen9pfsDev *xen_9pfs = container_of(s, Xen9pfsDev, state);
> > +    return XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
> > +}
> 
> This is correct as a computation. But there are multiple rings with
> potentially different ring_orders (although I have never seen it in
> practice.)
> 
> So I think something like this would be better:
> 
> ---
> size_t limit = XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
> for (i = 1; i < xen_9pfs->num_rings; i++) {
>     limit = MIN(limit, XEN_FLEX_RING_SIZE(xen_9pfs->rings[i].ring_order));
> }
> return limit;

Agreed, I'll take your solution and just precede it with:

  if (!xen_9pfs->num_rings) {
      return 0;
  }

I understand it is not really needed as min. one Xen ring is guaranteed, but 
it's still a separate subsystem and it doesn't cost much.

/Christian 



