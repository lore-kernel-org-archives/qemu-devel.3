Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17542CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcwg-0000I0-JC; Tue, 13 Oct 2026 09:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xGcwe-0000Hm-LP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xGcwd-0008BQ-6V
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791899610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=604O/D8YGXnZ0SNJV4npeNnAllF2JXyn4p4kzU7fP88=;
 b=dPuAXt4UNTIpl7/X3FF0cf1TGlhKklV//sMPmT0Pv3LpX7GFNdxWXQeJY3aKnWfRkbvLwn
 T3g/LpSbo+tJ0YPwN4UxderlUsnkwtk6JyyXrMZgeqEFcV0c+YUfgB36oApjgmYFs6oe20
 X4l1CqPSZagwpQbO58U5ikz0SWu+kk4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-iBhwtbUwOmilUg2qESOw-w-1; Tue,
 13 Oct 2026 13:53:23 +0000
X-MC-Unique: iBhwtbUwOmilUg2qESOw-w-1
X-Mimecast-MFC-AGG-ID: iBhwtbUwOmilUg2qESOw-w_1791899602
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 829071977003; Tue, 13 Oct 2026 13:53:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.105])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EFE930001B9; Tue, 13 Oct 2026 13:53:18 +0000 (UTC)
Date: Tue, 13 Oct 2026 15:53:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Haoqian He <haoqian.he@smartx.com>, qemu-devel@nongnu.org,
 fengli@smartx.com, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] block/mirror: inherit the source node discard flag in
 mirror_top
Message-ID: <as43zG5OHroMfIJZ@redhat.com>
References: <20261013060549.3008438-1-haoqian.he@smartx.com>
 <801bb56f-c704-4649-9938-73e9370d7a08@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801bb56f-c704-4649-9938-73e9370d7a08@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 13.10.2026 um 10:15 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 13.10.26 09:05, Haoqian He wrote:
> > mirror_start_job() inserts a mirror_top filter above the source node
> > for both mirror and active commit jobs. Previously, the filter was
> > opened with BDRV_O_RDWR only, even when the source had BDRV_O_UNMAP
> > enabled.
> > 
> > The block layer checks BDRV_O_UNMAP before invoking a node's discard
> > callback. Without this flag on mirror_top, discard requests return
> > success without reaching bdrv_mirror_top_pdiscard(). Consequently,
> > starting a job can silently suppress guest UNMAP/TRIM requests that
> > would otherwise reach the discard-enabled source.
> > 
> > Initialize the filter's open flags with BDRV_O_RDWR and conditionally
> > add BDRV_O_UNMAP from bs->open_flags. Pass the resulting flags to
> > bdrv_new_open_driver() so that mirror_top follows the source node's
> > discard setting.
> > 
> > This allows discard requests to reach the existing filter callback,
> > which forwards them to the source and either tracks the affected
> > range in the dirty bitmap or synchronously propagates the discard
> > to the target, depending on the copy mode.
> > 
> > Signed-off-by: Haoqian He <haoqian.he@smartx.com>
> > ---
> >   block/mirror.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/mirror.c b/block/mirror.c
> > index 089856f4a8..a551d392c6 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
> > @@ -1854,6 +1854,7 @@ static BlockJob *mirror_start_job(
> >       BlockDriverState *mirror_top_bs;
> >       bool target_is_backing;
> >       uint64_t target_perms, target_shared_perms;
> > +    int flags;
> >       int ret;
> >       GLOBAL_STATE_CODE();
> > @@ -1886,8 +1887,13 @@ static BlockJob *mirror_start_job(
> >       /* In the case of active commit, add dummy driver to provide consistent
> >        * reads on the top, while disabling it in the intermediate nodes, and make
> >        * the backing chain writable. */
> > -    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
> > -                                         BDRV_O_RDWR, errp);
> > +    flags = BDRV_O_RDWR;
> > +    if (bs->open_flags & BDRV_O_UNMAP) {
> > +        flags |= BDRV_O_UNMAP;
> > +    }
> > +    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top,
> > +                                         filter_node_name,
> > +                                         flags, errp);
> >       if (mirror_top_bs == NULL) {
> >           return NULL;
> >       }
> 
> Cool find!
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Thanks for fixing, applied to my block branch.

This bug is something that should be relatively easily testable in
qemu-iotests. Can we please add a test at the same time?

Kevin


