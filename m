Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD0C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeqZ-0008WT-3b; Tue, 01 Jul 2025 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWeqN-00086I-At
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWeqJ-0007mq-Un
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751391146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoFn0RB4KSTG4vLlw/0Pdh/GkxQugPFiMH/x+lHcwFQ=;
 b=R9S4Sa7tXDB1Tm0RRamRY2q4tisP8068NUiLJ6PcrAEOAYMg/ESS9wpkWpoWemtWVBuJlU
 lM2P9LgWVDS8Rzv29KY+ph2ZZzgQuA+6DKdPdEuSVUTDgH+y5l071uPaDMIdfRVt5kE5nU
 QjcnDEJdz8+QBJ68dQiMvMN+XehqkP8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-WCG4TOuNNVWy_HRf4kNwTw-1; Tue,
 01 Jul 2025 13:32:23 -0400
X-MC-Unique: WCG4TOuNNVWy_HRf4kNwTw-1
X-Mimecast-MFC-AGG-ID: WCG4TOuNNVWy_HRf4kNwTw_1751391142
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E696195FCC2; Tue,  1 Jul 2025 17:32:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 468AE19560A7; Tue,  1 Jul 2025 17:32:19 +0000 (UTC)
Date: Tue, 1 Jul 2025 19:32:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, stefanha@redhat.com, fam@euphon.net
Subject: Re: [PATCH 3/4] block: implement 'resize' callback for child_of_bds
 class
Message-ID: <aGQboEwTVS5sYxa_@redhat.com>
References: <20250630113035.820557-1-f.ebner@proxmox.com>
 <20250630113035.820557-4-f.ebner@proxmox.com>
 <18f6275a-dee0-4df4-85e3-efaf81a7724d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18f6275a-dee0-4df4-85e3-efaf81a7724d@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 01.07.2025 um 16:46 hat Hanna Czenczek geschrieben:
> On 30.06.25 13:27, Fiona Ebner wrote:
> > If a node below a filter node is resized, the size of the filter node
> > is now also refreshed (recursively for filter parents).
> > 
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> > ---
> >   block.c                          | 12 ++++++++++++
> >   include/block/block_int-common.h |  2 +-
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> What does this do for block job filter nodes, like mirror?  If they changed
> their length, we might have to consider whether the job also needs to be
> amended somehow.

mirror doesn't share BLK_PERM_RESIZE in its block_job_create() call, so
can this even happen? (If yes, that sounds bad.)

> However, I assume it’s a safe (conservative) change for them because such
> drivers don’t implement bdrv_co_getlength(), so
> bdrv_co_refresh_total_sectors() will not change anything.  Is that right and
> intended?
> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> 
> (Babbling below.)
> 
> > diff --git a/block.c b/block.c
> > index bfd4340b24..449f814ebe 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1497,6 +1497,17 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
> >       }
> >   }
> > +static void coroutine_fn GRAPH_RDLOCK bdrv_child_cb_resize(BdrvChild *child)
> > +{
> > +    BlockDriverState *bs = child->opaque;
> > +
> > +    if (bs->drv && bs->drv->is_filter) {
> 
> Checking the role for BDRV_CHILD_FILTERED would be more generic; but it
> would cause 'raw' nodes to be updated, too.  But I don’t know whether we
> want that or not, and excluding raw (i.e. not changing behavior there) is
> certainly the safe option.

If the size is not explicitly overridden in the node configuration, I
would certainly expect that a raw node reflects the size of its file
node.

Seems this is exactly the condition that makes it use
BDRV_CHILD_FILTERED, so it would probably be a good change?

> > +        /* Best effort, ignore errors. */
> > +        bdrv_co_refresh_total_sectors(bs, bs->total_sectors);
> > +        bdrv_co_parent_cb_resize(bs);
> 
> This makes me wonder whether bdrv_co_refresh_total_sectors() should itself
> call bdrv_co_parent_cb_resize().  Still not quite sure; if the underlying
> image file is resized by an external party (and we notice this by accident,
> more or less), maybe the guest device should be informed.
> 
> (One thing to consider, maybe, are nodes that unshare the resize permission
> for a child.  It’s probably not clever to call the resize CB if that
> permission is unshared, so maybe just from that perspective, we should keep
> that CB strictly inside of that explicit truncate path that checks that
> permission (at least when growing images...).)
> 
> Anyway, again, this is the safe option.

The traditional solution for nodes that unshare resize, but get resized
in the background anyway would be bs->drv = NULL, and we probably still
aren't certain what happens after that. :-)

Kevin


