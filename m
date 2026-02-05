Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241A3EC1E81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvg2-0000tP-Dl; Thu, 05 Feb 2026 04:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vnvg1-0000tF-FR
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:29:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vnvfy-0000jW-QL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770283764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fw7ITaaehPKwcJ8Vsr+UU/JzGj3KQjS6QKQPHJrOwL4=;
 b=NJwu4M/ZNkbYgbSms9WcLaYdS37GGhOos6UHyvMENmeWzPElj9tIXsa74I40w7Qx7ZoyY9
 Kna7yos3u+rM3mZNazNzIZQoC3CKjg83hJ4NVm33E6UyzZEFi639LKHCQyqtFFk6DbW7K9
 LB/ZVqc72cZdij7gJxVCre1EXr5ElM4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-4oFxLkZIPBG5jHvNpOR7QQ-1; Thu,
 05 Feb 2026 04:29:21 -0500
X-MC-Unique: 4oFxLkZIPBG5jHvNpOR7QQ-1
X-Mimecast-MFC-AGG-ID: 4oFxLkZIPBG5jHvNpOR7QQ_1770283760
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ECFF1800282; Thu,  5 Feb 2026 09:29:19 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.198])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E58F118003F6; Thu,  5 Feb 2026 09:29:17 +0000 (UTC)
Date: Thu, 5 Feb 2026 10:29:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 dionbosschieter@gmail.com
Subject: Re: (in guest) disk corruption during snapshots
Message-ID: <aYRi660MmeMtobZG@redhat.com>
References: <4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be>
 <aef520c2-3296-4eb4-999c-faa757c9b2a3@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef520c2-3296-4eb4-999c-faa757c9b2a3@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 05.02.2026 um 09:59 hat Fiona Ebner geschrieben:
> Hi,
> 
> Am 03.02.26 um 3:24 PM schrieb Jean-Louis Dupond:
> > Hi,
> > 
> > Since some months we were observing disk corruption within the VM when
> > enabling backups (which triggers snapshots).
> > After a lot of troubleshooting, we were able to track down the commit
> > that caused it:
> > https://gitlab.com/qemu-project/qemu/-/
> > commit/058cfca5645a9ed7cb2bdb77d15f2eacaf343694
> > 
> > More info in the issue:
> > https://gitlab.com/qemu-project/qemu/-/issues/3273
> > 
> > Now this seems to be caused by a race between disabling the
> > dirty_bitmaps and the tracking implemented in the mirror top layer.
> > Kevin shared me a possible solution:
> > 
> > diff --git a/block/mirror.c b/block/mirror.c
> > index b344182c747..f76e43f22c1 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
> > @@ -1122,6 +1122,9 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
> >       * accessing it.
> >       */
> >      mirror_top_opaque->job = s;
> > +    if (s->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
> > +        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> > +    }
> >  
> >      assert(!s->dbi);
> >      s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
> > @@ -2018,7 +2021,9 @@ static BlockJob *mirror_start_job(
> >       * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
> >       * mode.
> >       */
> > -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> > +    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
> > +        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> > +    }
> >  
> >      bdrv_graph_wrlock_drained();
> >      ret = block_job_add_bdrv(&s->common, "source", bs, 0,
> > 
> > 
> > Running this for some hours already, and it seems to fix the issue.
> > 
> > Let's open up the discussion if this is the proper way to fix it, or if
> > there are better alternatives :)
> 
> Yes, I do think this is the proper solution. I ended up with essentially
> the same yesterday (see the Gitlab issue). I moved the disabling
> unconditionally, but there should be no need to delay the disabling if
> using write-blocking mode. I would suggest moving the comment on top of
> the changed hunk in mirror_start_job() along to the new hunk in
> mirror_run().

I didn't actually write this as a proper patch, but just as a quick
thing Jean-Louis could test, so yes, all of the details are up for
discussion.

You're right that there is no need to delay disabling the bitmap in
active mode, but it probably also doesn't hurt to keep it enabled for a
little while? Maybe we should do it like you did just to keep the code a
little simpler.

There is another approach I had in mind, but wasn't as sure about, so I
didn't suggest it for the testing to see if this race is even the
problem we're seeing in practice: Is there a reason why populating the
initial dirty bitmap (i.e. the second part of mirror_dirty_init()) can't
just come after setting 'mirror_top_opaque->job'? Then we could simply
leave the bitmap disabled all the time and rely solely on the mirror
job's own tracking. That would feel a little more consistent than using
the block layer just to plug a small race window during startup.

Kevin


