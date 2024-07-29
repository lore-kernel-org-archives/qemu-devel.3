Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72704C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcbv-0001a2-5K; Mon, 29 Jul 2024 22:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYcbs-0001QC-SH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYcbq-0007y9-0e
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722306544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kzu3jftm2LvzNhKHXxpCyA3X+7QL4Y9sGKZ7e7tVbIo=;
 b=D75qooCXsmc6IAWESvXZeRMnzN3SWxd+uItdn8TKl7xHRg8o7/EgwIFmQhym3XLd/DFgIY
 O2Uj7VzXrnJfc+bKfvvm8AZsVHX196UPhUksNMHm/vFMSufEJo+ljHJtuudeHMGfVo1pGk
 4jA2DHlP6eI46+5Vs+dtmxSrYZM26yA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-z08Ir-jINBCb9FQGPYtMbA-1; Mon,
 29 Jul 2024 16:02:58 -0400
X-MC-Unique: z08Ir-jINBCb9FQGPYtMbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC0041955D45; Mon, 29 Jul 2024 20:02:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 461341955F40; Mon, 29 Jul 2024 20:02:54 +0000 (UTC)
Date: Mon, 29 Jul 2024 15:02:51 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>
Subject: Re: query dirty areas according to bitmap via QMP or qemu-nbd
Message-ID: <czfbsqz5qaq6zrubmgrffgoedkqz3cw3x3hkfx6hvafxmreuql@nzoyrc5bp3qn>
References: <a8ceec92-4b4a-4ee6-b7f7-b6b9d804a5e9@proxmox.com>
 <spi5wsadgvijq6venwx74c5exat6635h4xf5v6aaf2t3bzvijq@dkfqlhzhcvl3>
 <777b4151-116b-4d3d-8b60-4b17ede51dea@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777b4151-116b-4d3d-8b60-4b17ede51dea@proxmox.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 29, 2024 at 03:51:17PM GMT, Fiona Ebner wrote:
> > In particular, tests/qemu-img-bitmaps gives the magic decoder ring:
> > 
> > | # x-dirty-bitmap is a hack for reading bitmaps; it abuses block status to
> > | # report "data":false for portions of the bitmap which are set
> > | IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
> > | nbd_server_start_unix_socket -r -f qcow2 \
> > |     -B b0 -B b1 -B b2 -B b3 "$TEST_IMG"
> > | $QEMU_IMG map --output=json --image-opts \
> > |     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b0" | _filter_qemu_img_map
> > 
> > meaning the map output includes "data":false for the dirty portions
> > and "data":true for the unchanged portions recorded in bitmap b0 as
> > read from the JSON map output.
> > 
> 
> Oh, I didn't think about checking the NBD block driver for such an
> option :) And thank you for all the explanations!

Glad it helped.  The 'x-' in the name is a giveaway that the command
is not intended for public use, but for development, it makes iotests
easier to write, so I see no reason to drop it.

> 
> >>
> >> If it is not currently possible, would upstream be interested too in the
> >> feature, either for QMP or qemu-nbd?
> > 
> > Improving qemu-img to get at the information without quite the hacky
> > post-processing deciphering would indeed be a useful patch, but it has
> > never risen to the level of enough of an itch for me to write it
> > myself (especially since 'nbdinfo --map's output works just as well).
> > 
> 
> I might just go with the above for now, but who knows if I'll get around
> to this some day. Three approaches that come to mind are:
> 
> 1. qemu-img bitmap --dump
> 
> Other bitmap actions won't be supported in combination with NBD.

This seems like an independently useful option (for any image with
embedded bitmaps, get at the contents of that bitmap).  I'm not sure
how much code you could reuse from the 'qemu-img map', or if it is
better to just write the iteration loops from scratch.  More
interesting is the observation that since NBD metacontexts are NOT
visible as a local bitmap (but rather as block status information), it
may still not do what you want for NBD connections.

> 
> 2. qemu-img map --bitmap NAME
> 
> Should it use a dedicated output format compared to the usual "map"
> output (both human and json) with just "start/offset + length + dirty
> bit" triples?

Again, this would work well with local qcow2 images, but I'm not sure
if it would translate nicely into NBD client images without more code
in block/nbd.c to expose a metacontext as a bitmap rather than its
current use of feeding block status.

> 
> 3. qemu-nbd --map CONTEXT
> 
> With only supporting one context at a time? Would be limited to NBD of
> course which the other two won't be.

The other two would be hard to implement for NBD, while this one is
hard to implement for qcow2.  It might be less hacky than
x-dirty-bitmap, but also starts duplicating efforts with what nbdinfo
can already do.

> 
> 
> All would require connecting to the NBD export with the correct meta
> context, which currently means using x_dirty_bitmap internally. So would
> that even be okay as part of a non-experimental command, or would it
> require to teach the NBD client code to deal with multiple meta contexts
> first?

If you want qemu-img to treat both qcow2 bitmaps and NBD metacontexts
transparently from the same command line, we'll definitely need some
work on how to make block/nbd.c expose an NBD metacontext as a bitmap
(separately from how the existing x-dirty-bitmap just repurposes what
is plugged into the block_status callbacks).  But handling only one
metacontext at a time, rather than having to do multiple in parallel,
is probably okay.  When you start reading more than one context at
once, you have to worry about things like the two contexts returning
different lengths of information ("base:allocation" might tell you
about a 64k hole while qemu:dirty-bitmap:XXX tells you about a 1M
dirty region - but consolidating that into contiguous extents of
combined output information is tricky, especially if you don't want to
re-query status you already know about one context but not the other).

> 
> Best Regards,
> Fiona
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


