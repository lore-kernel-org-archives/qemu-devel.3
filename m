Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67360FCE077
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbD9-00088i-CN; Thu, 26 Feb 2026 08:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvbD6-000886-7A
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvbD4-0006JT-8j
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772111716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7b54WMDHvzc46ebHCSA0AaQthrR4jVhyxVkGRZt3xCk=;
 b=LadeRTvsFW0nnwkmxnqJLoDvD/a0JXz+mYAX0CRjTMbsUbgNjNExAVOxJactBg4FvReGK3
 NN87BiJ+cs1XNxGyu2tBA4LRe3//hCecd2mNVR9kWgMud3utsVWMXCFGUtkJySkWe4+GW9
 6gmvf+sXrnkRRWsdWcoOzijlhTdRdJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-aeJgh-fHPb-SN84S3I-BXg-1; Thu,
 26 Feb 2026 08:15:12 -0500
X-MC-Unique: aeJgh-fHPb-SN84S3I-BXg-1
X-Mimecast-MFC-AGG-ID: aeJgh-fHPb-SN84S3I-BXg_1772111711
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D36E195609F; Thu, 26 Feb 2026 13:15:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 126DC1800348; Thu, 26 Feb 2026 13:15:08 +0000 (UTC)
Date: Thu, 26 Feb 2026 14:15:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org
Subject: Re: [PATCH v3] [for-10.1] block-jobs: add final flush
Message-ID: <aaBHWpS78HWizzmv@redhat.com>
References: <20250402083715.391059-1-vsementsov@yandex-team.ru>
 <aZ8leLFRoF4J7s6a@redhat.com>
 <2a294c9c-fd5d-4c57-a43d-4ba08e24fe48@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a294c9c-fd5d-4c57-a43d-4ba08e24fe48@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

Am 25.02.2026 um 21:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 25.02.26 19:38, Kevin Wolf wrote:
> > Am 02.04.2025 um 10:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Actually block job is not completed without the final flush. It's
> > > rather unexpected to have broken target when job was successfully
> > > completed long ago and now we fail to flush or process just
> > > crashed/killed.
> > > 
> > > Mirror job already has mirror_flush() for this. So, it's OK.
> > > 
> > > Do this for stream, commit and backup jobs too.
> > > 
> > > Note that jobs behave a bit different around IGNORE action:
> > > backup and commit just retry the operation, when stream skip
> > > failed operation and store the error to report later. Keep
> > > these different behaviors for final flush too.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > > 
> > > v2 was old "[PATCH v2 0/3] block-jobs: add final flush"[1]
> > > v3: follow Kevin's suggestion to introduce block_job_handle_error()
> > >     (still, it's not obvious how to rewrite commit and stream operation
> > >     loops reusing this helper, not making things more complicated..
> > >     I decided too keep them as is, using new helper only for final flush.)
> > > 
> > > [1] https://patchew.org/QEMU/20240626145038.458709-1-vsementsov@yandex-team.ru/
> > > Supersedes: <20240626145038.458709-1-vsementsov@yandex-team.ru>
> > > 
> > >   block/backup.c           |  8 ++++++++
> > >   block/commit.c           |  6 +++++-
> > >   block/stream.c           |  8 ++++++--
> > >   blockjob.c               | 34 ++++++++++++++++++++++++++++++++++
> > >   include/block/blockjob.h |  9 +++++++++
> > >   5 files changed, 62 insertions(+), 3 deletions(-)

> > > diff --git a/block/commit.c b/block/commit.c
> > > index 5df3d05346..711093504f 100644
> > > --- a/block/commit.c
> > > +++ b/block/commit.c
> > > @@ -201,7 +201,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
> > >           }
> > >       }
> > > -    return 0;
> > > +    do {
> > > +        ret = blk_co_flush(s->base);
> > > +    } while (block_job_handle_error(&s->common, ret, s->on_error, true, true));
> > 
> > Why does commit still flush even if we return an error?
> 
> Hmm. We are on success path here, we do flush where "return 0;" was.

True, disregard it here. I saw it on stream and didn't read commit
carefully enough assuming it was the same.

> > > @@ -235,8 +235,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
> > >           }
> > >       }
> > > +    do {
> > > +        ret = blk_co_flush(s->blk);
> > > +    } while (block_job_handle_error(&s->common, ret, s->on_error, true, false));
> > 
> > Same here about flushing even on error.
> 
> Here I keep the behavior of stream: for "ignore" action, it continues streaming,
> but in the end return failure. It's documented in QAPI, and I note it in commit
> message.
> 
> If we continue writes after failure, I assume we still need these writes, so,
> why not flush them?

It probably doesn't hurt much, but since we already know that the
streaming won't complete successfully, it's probably also not incorrect
not to flush - nobody can rely on everything being present in the active
layer. The only thing that can happen is that you get another failure,
which could be nasty if the failure comes only after a long timeout. But
I guess either way is fine.

> As far as I understand semantics of "ignore", it means "ignore errors, but still
> try to do as much progress as possible". And it seems strange that other jobs do
> endless retry in case of "ignore" action..

Yes, I wonder if anyone is using this mode in practice.

> > 
> > > +
> > >       /* Do not remove the backing file if an error was there but ignored. */
> > > -    return error;
> > > +    return error ?: ret;
> > >   }
> > >   static const BlockJobDriver stream_job_driver = {
> > > diff --git a/blockjob.c b/blockjob.c
> > > index 32007f31a9..70a7af2077 100644
> > > --- a/blockjob.c
> > > +++ b/blockjob.c
> > > @@ -626,3 +626,37 @@ AioContext *block_job_get_aio_context(BlockJob *job)
> > >       GLOBAL_STATE_CODE();
> > >       return job->job.aio_context;
> > >   }
> > > +
> > > +bool coroutine_fn
> > > +block_job_handle_error(BlockJob *job, int ret, BlockdevOnError on_err,
> > > +                       bool is_read, bool retry_on_ignore)
> > > +{
> > > +    assert(ret >= 0);
> > > +
> > > +    if (ret == 0) {
> > > +        return false;
> > > +    }
> > > +
> > > +    if (job_is_cancelled(&job->job)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    BlockErrorAction action =
> > > +        block_job_error_action(job, on_err, is_read, -ret);
> > > +    switch (action) {
> > > +    case BLOCK_ERROR_ACTION_REPORT:
> > > +        return false;
> > > +    case BLOCK_ERROR_ACTION_IGNORE:
> > > +        if (!retry_on_ignore) {
> > > +            return false;
> > > +        }
> > > +        /* fallthrough */
> > 
> > What is the idea behind having a pause point for "ignore"? Is it to at
> > least avoid QEMU hanging completely if it goes into an infinite loop
> > with retry_on_ignore?
> 
> Yes, just to have a pause point on every iteration of retrying loop,
> like we do it in data-copying iterations of block jobs.

Ok, that's fair. If you want, we could add a comment to this effect.

Kevin


