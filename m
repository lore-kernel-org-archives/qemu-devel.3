Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E373CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 12:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMm2Z-0005iv-VJ; Tue, 12 May 2026 08:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMm2L-0005d0-HI
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMm2G-0003Hk-LF
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778588187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jouFl0ktyIp1zPMNuXHPL52qpTt77BkTvjJUL36fWNw=;
 b=ONG8HOL5hnMhnn6/gVHSGCWRotL/leeS95cLXATuBngiHcwaqMKz3o6Ja6ycO4nTvP0e9f
 xeDFPRdAgQPZgkMfm8x9mWh1eCbgd00jmTLw0ssig9zFRxbpjmBX5z5ZujO2bX5+TqWvpo
 WjJXnFyMTYJBqs5CtF3F1eO5H1WGz6o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-Hj5sF-9sNZeKoVXMBX0R3Q-1; Tue,
 12 May 2026 08:16:24 -0400
X-MC-Unique: Hj5sF-9sNZeKoVXMBX0R3Q-1
X-Mimecast-MFC-AGG-ID: Hj5sF-9sNZeKoVXMBX0R3Q_1778588183
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A1C2180060F; Tue, 12 May 2026 12:16:23 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.152])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA27E19560A2; Tue, 12 May 2026 12:16:20 +0000 (UTC)
Date: Tue, 12 May 2026 14:16:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, den@openvz.org,
 stefanha@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] commit: Drain nodes across all of bdrv_commit()
Message-ID: <agMaEZFmV5WlU5Y6@redhat.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-2-kwolf@redhat.com>
 <c0e3fe09-6491-4a36-ae81-41c0de0befd2@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e3fe09-6491-4a36-ae81-41c0de0befd2@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 29.04.2026 um 17:06 hat Fiona Ebner geschrieben:
> Am 27.04.26 um 7:43 PM schrieb Kevin Wolf:
> > The whole implementation of bdrv_commit() is only correct if no new
> > writes come in while it's running: It has only a single loop checking
> > the allocation status for each block and finally calls bdrv_make_empty()
> > without checking if that throws away any new changes.
> > 
> > We already have to drain while taking the graph write lock. Just extend
> > the drained section to all of bdrv_commit() to make sure that we don't
> > get any inconsistencies.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/commit.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/commit.c b/block/commit.c
> > index 0d9e1a16d7a..c5e3ef03a21 100644
> > --- a/block/commit.c
> > +++ b/block/commit.c
> > @@ -518,6 +518,7 @@ int bdrv_commit(BlockDriverState *bs)
> >      if (!drv)
> >          return -ENOMEDIUM;
> >  
> > +    bdrv_drain_all_begin();
> 
> I suppose we could instead drain only the affected BDSs? Blocking all
> for the whole duration of the blk_pread+blk_pwrite loop seems a bit much.

Possible, but I'm not completely sure. Basically what I did here is just
moving the drain part of bdrv_graph_wrlock_drained() earlier, which also
drains all nodes.

I think when you introduced it, the idea was that just draining
everything is acceptable and easier to verify. Which means that it might
not be strictly necessary, but I don't want to prove that now either.

Ultimately this drain_all goes back to commit 91ba0e1, in which you
stated:

    More granular draining is not trivially possible, because
    bdrv_change_aio_context() can recursively call itself e.g. via
    bdrv_child_change_aio_context().

> Independently of that, I wonder if blk_commit_all() should drain all?
> I'm not familiar with it, but it seems that the intent is to have a
> point-in-time state which is consistent between different BDSs? That
> intent could be made explicit by draining all.

Hm, I suppose that would make sense, yes. Do you want to send a patch on
top of this? Bonus points for a test case that shows the inconsistency.

Kevin


