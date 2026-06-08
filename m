Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C83BCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWa1P-0001qh-Jv; Mon, 08 Jun 2026 09:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wWYeP-0001xE-7Q; Mon, 08 Jun 2026 08:00:19 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wWYeL-0006ny-UR; Mon, 08 Jun 2026 08:00:16 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 560B2601E1;
 Mon,  8 Jun 2026 12:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DEB1F00898;
 Mon,  8 Jun 2026 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780920009;
 bh=jDFrbaV5KDbN+lL90DZ3dTDe9oQAnLF9CEdddYqP3Go=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BJUKXBkun11gMA/lc87X64gSknaEvDZ1En38+cvqiYUkUgF+ajbX2734dbTG2ogPZ
 bHMA+/Izohxm+/3KRGo90IKDeTho3iCKNQC80qGFqMSagWhaXd/gvStWVpxJYjhfN4
 MJKZgu1bT+KRzAntYJd7vt0XHj4or4frtqo6JDDLJPv5OCnZSj9MAG0zll9qztsmyb
 Kn+FsFKuCuVH6g/SRpfzEkLLiv/9MXwFe3CJz1hGAjktUBjKuZi69lC2yZN7WrgUJd
 ZQI+FNSqibfe+KquGvF/OWkYCikiLAGYZgy/wAl0g26zWu6FnHsy8EHalousCoTqD7
 /YxLBUQSL7ibg==
Date: Mon, 8 Jun 2026 14:00:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v11 3/5] virtio-blk: do not merge writes across a zone
 boundary
Message-ID: <aiauw3nKDRHXJESV@ryzen>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
 <20260601214405.252818-4-faithilikerun@gmail.com>
 <20260603204150.GD78072@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603204150.GD78072@fedora>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:27:52 -0400
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

Hello Stefan,

On Wed, Jun 03, 2026 at 04:41:50PM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 01, 2026 at 11:44:03PM +0200, Sam Li wrote:
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 9cb9f1fb2b..285db19ac7 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -303,17 +306,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s, MultiReqBuffer *mrb)
> >      for (i = 0; i < mrb->num_reqs; i++) {
> >          VirtIOBlockReq *req = mrb->reqs[i];
> >          if (num_reqs > 0) {
> > +            zone_cross = false;
> > +
> > +            /*
> > +             * On zoned backends, a single backend write must not span a zone
> 
> This code handles both reads and writes but the comment only mentions
> writes. I think reads are allowed to span zones, so should there be a
> check that mrb->is_write?

From the Virtual I/O Device (VIRTIO) Version 1.4 specification:

"If a VIRTIO_BLK_T_ZONE_APPEND request, a VIRTIO_BLK_T_IN request or a
VIRTIO_BLK_T_OUT request issued to a SWR zone has the range that has
sectors in more than one zone, then the request SHALL be completed with
VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field status."


Thus, while this is allowed to read past the zone boundary in many zoned
specifications, e.g. in both ZAC and ZBC, when the "Read Across Zone
Boundaries bit" is set, is seems like it is never allowed to do so in
VIRTIO.


Kind regards,
Niklas

