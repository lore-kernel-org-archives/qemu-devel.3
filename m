Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309F5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPRR-00077q-FC; Mon, 29 Jul 2024 08:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYPRP-000761-TS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYPRN-0000PF-Va
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722255923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ulc4gShvq9GldyQk5SPFKLy+2yeUtVNABksivOLBeKA=;
 b=JxjFDbPGro07n2VKjS9wZ5xfrmgR4yU+fpT/eEBGiJ3QzN7DGGHkgzvTOJbZLGBkdVg6tV
 7/iCfLFD3KNULgyMIkxsjIKx2xf3P0FaW3qzYdQ09PCgJ4v53VpquWX7AUXTEPeDVoHV7H
 IrD3cULAp9m5wsIkuEsSBEw2YG4bSDE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-yDR0bCRKPimTCTvLIJAvgQ-1; Mon,
 29 Jul 2024 08:25:19 -0400
X-MC-Unique: yDR0bCRKPimTCTvLIJAvgQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EF8F1955D53; Mon, 29 Jul 2024 12:25:18 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.89])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95815195605F; Mon, 29 Jul 2024 12:25:15 +0000 (UTC)
Date: Mon, 29 Jul 2024 14:25:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org, f.ebner@proxmox.com
Subject: Re: [PATCH v2 1/3] block/commit: implement final flush
Message-ID: <ZqeKKCWxhoVnGKWV@redhat.com>
References: <20240626145038.458709-1-vsementsov@yandex-team.ru>
 <20240626145038.458709-2-vsementsov@yandex-team.ru>
 <ZplrhoVskeiK0R4c@redhat.com>
 <c4ae737c-853d-4a0d-8f7c-e5502c824bd7@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ae737c-853d-4a0d-8f7c-e5502c824bd7@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 19.07.2024 um 12:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 18.07.24 22:22, Kevin Wolf wrote:
> > Am 26.06.2024 um 16:50 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Actually block job is not completed without the final flush. It's
> > > rather unexpected to have broken target when job was successfully
> > > completed long ago and now we fail to flush or process just
> > > crashed/killed.
> > > 
> > > Mirror job already has mirror_flush() for this. So, it's OK.
> > > 
> > > Do this for commit job too.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > >   block/commit.c | 41 +++++++++++++++++++++++++++--------------
> > >   1 file changed, 27 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/block/commit.c b/block/commit.c
> > > index 7c3fdcb0ca..81971692a2 100644
> > > --- a/block/commit.c
> > > +++ b/block/commit.c
> > > @@ -134,6 +134,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
> > >       int64_t n = 0; /* bytes */
> > >       QEMU_AUTO_VFREE void *buf = NULL;
> > >       int64_t len, base_len;
> > > +    bool need_final_flush = true;
> > >       len = blk_co_getlength(s->top);
> > >       if (len < 0) {
> > > @@ -155,8 +156,8 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
> > >       buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
> > > -    for (offset = 0; offset < len; offset += n) {
> > > -        bool copy;
> > > +    for (offset = 0; offset < len || need_final_flush; offset += n) {
> > 
> > In general, the control flow would be nicer to read if the final flush
> > weren't integrated into the loop, but just added after it.
> > 
> > But I assume this is pretty much required for pausing the job during
> > error handling in the final flush if you don't want to duplicate a lot
> > of the logic into a second loop?
> 
> Right, that's the reason.

This would probably be the right solution if it affected only commit.
But I've thought a bit more about this and given that the same thing
happens in all of the block jobs, I'm really wondering if introducing a
block job helper function wouldn't be better, so that each block job
could just add something like this after its main loop:

    do {
        ret = blk_co_flush();
    } while (block_job_handle_error(job, ret));

And the helper would call block_job_error_action(), stop the job if
necessary, check if it's cancelled, include a pause point etc.

Kevin


