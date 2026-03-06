Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0859BF01818
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRZk-0006Ix-TW; Fri, 06 Mar 2026 04:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyRZj-0006Ia-Qt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyRZi-0002Hk-2e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772789665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/BNLapENNaprDFIGP4KuFqzdjFtXvPNLmh6qyGwT1Y=;
 b=RMuEc8W8iY8nlVxpLQNx0XfO22sL3kVFMsaVdFL0Kxz+C6mBQqcXb+/TrSaolS/ojNXBmD
 tdrWku0AJZ/+Ex0ee7RlCks+NqChS0HQobwLXACgDWeUeRgtd6CTVojrtQv8imPzFRaF9p
 pW1fVGVd95w9F2RR7SFRn/2FlJWUT+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-IBjw6t6_PbaXKOi50By6tA-1; Fri,
 06 Mar 2026 04:34:22 -0500
X-MC-Unique: IBjw6t6_PbaXKOi50By6tA-1
X-Mimecast-MFC-AGG-ID: IBjw6t6_PbaXKOi50By6tA_1772789661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A3A918005B9; Fri,  6 Mar 2026 09:34:20 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.210])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D074C3003E9F; Fri,  6 Mar 2026 09:34:16 +0000 (UTC)
Date: Fri, 6 Mar 2026 10:34:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, f.ebner@proxmox.com,
 jsnow@redhat.com, jean-louis@dupond.be, dionbosschieter@gmail.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
Message-ID: <aaqflohdSVTFpkRZ@redhat.com>
References: <20260219202446.312493-1-kwolf@redhat.com>
 <d7c3d44a-d42f-4232-b5e5-a7504fb62a73@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c3d44a-d42f-4232-b5e5-a7504fb62a73@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 05.03.2026 um 19:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 19.02.26 23:24, Kevin Wolf wrote:
> > Currently, mirror disables the block layer's dirty bitmap before its own
> > replacement is working. This means that during startup, there is a
> > window in which the allocation status of blocks in the source has
> > already been checked, but new writes coming in aren't tracked yet,
> > resulting in a corrupted copy:
> > 
> > 1. Dirty bitmap is disabled in mirror_start_job()
> > 2. Some request are started in mirror_top_bs while s->job == NULL
> > 3. mirror_dirty_init() -> bdrv_co_is_allocated_above() runs and because
> >     the request hasn't completed yet, the block isn't allocated
> > 4. The request completes, still sees s->job == NULL and skips the
> >     bitmap, and nothing else will mark it dirty either
> > 
> > One ingredient is that mirror_top_opaque->job is only set after the
> > job is fully initialized. For the rationale, see commit 32125b1460
> > ("mirror: Fix access of uninitialised fields during start").
> > 
> > Fix this by giving mirror_top_bs access to dirty_bitmap and enabling it
> > to track writes from the beginning. Disabling the block layer's tracking
> > and enabling the mirror_top_bs one happens in a drained section, so
> > there is no danger of races with in-flight requests any more. All of
> > this happens well before the block allocation status is checked, so we
> > can be sure that no writes will be missed.
> > 
> > Cc: qemu-stable@nongnu.org
> > Closes: https://gitlab.com/qemu-project/qemu/-/issues/3273
> > Fixes: 32125b14606a ('mirror: Fix access of uninitialised fields during start')
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> > Supersedes: <20260212120411.369498-1-f.ebner@proxmox.com>
> > ---
> >   block/mirror.c | 48 +++++++++++++++++++++++++++++-------------------
> >   1 file changed, 29 insertions(+), 19 deletions(-)
> > 
> > diff --git a/block/mirror.c b/block/mirror.c
> > index b344182c747..f38636e7457 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
> > @@ -99,6 +99,7 @@ typedef struct MirrorBlockJob {
> >   typedef struct MirrorBDSOpaque {
> >       MirrorBlockJob *job;
> > +    BdrvDirtyBitmap *dirty_bitmap;
> >       bool stop;
> >       bool is_commit;
> >   } MirrorBDSOpaque;
> > @@ -1672,9 +1673,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
> >           abort();
> >       }
> > -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
> > +    if (!copy_to_target) {
> >           qatomic_set(&s->job->actively_synced, false);
> > -        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
> > +        bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
> >       }
> >       if (ret < 0) {
> > @@ -1901,13 +1902,35 @@ static BlockJob *mirror_start_job(
> >       bdrv_drained_begin(bs);
> >       ret = bdrv_append(mirror_top_bs, bs, errp);
> > -    bdrv_drained_end(bs);
> > -
> >       if (ret < 0) {
> > +        bdrv_drained_end(bs);
> > +        bdrv_unref(mirror_top_bs);
> > +        return NULL;
> > +    }
> > +
> > +    bs_opaque->dirty_bitmap = bdrv_create_dirty_bitmap(mirror_top_bs,
> > +                                                       granularity,
> > +                                                       NULL, errp);
> > +    if (!bs_opaque->dirty_bitmap) {
> > +        bdrv_drained_end(bs);
> >           bdrv_unref(mirror_top_bs);
> >           return NULL;
> >       }
> > +    /*
> > +     * The mirror job doesn't use the block layer's dirty tracking because it
> > +     * needs to be able to switch seemlessly between background copy mode (which
> > +     * does need dirty tracking) and write blocking mode (which doesn't) and
> > +     * doing that would require draining the node. Instead, mirror_top_bs takes
> > +     * care of updating the dirty bitmap as appropriate.
> > +     *
> > +     * Note that write blocking mode only becomes effective after mirror_run()
> > +     * sets mirror_top_opaque->job (see should_copy_to_target()). Until then,
> > +     * we're still in background copy mode irrespective of @copy_mode.
> > +     */
> > +    bdrv_disable_dirty_bitmap(bs_opaque->dirty_bitmap);
> > +    bdrv_drained_end(bs);
> > +
> >       /* Make sure that the source is not resized while the job is running */
> >       s = block_job_create(job_id, driver, NULL, mirror_top_bs,
> >                            BLK_PERM_CONSISTENT_READ,
> > @@ -2002,24 +2025,13 @@ static BlockJob *mirror_start_job(
> >       s->base_overlay = bdrv_find_overlay(bs, base);
> >       s->granularity = granularity;
> >       s->buf_size = ROUND_UP(buf_size, granularity);
> > +    s->dirty_bitmap = bs_opaque->dirty_bitmap;
> >       s->unmap = unmap;
> >       if (auto_complete) {
> >           s->should_complete = true;
> >       }
> >       bdrv_graph_rdunlock_main_loop();
> > -    s->dirty_bitmap = bdrv_create_dirty_bitmap(s->mirror_top_bs, granularity,
> > -                                               NULL, errp);
> > -    if (!s->dirty_bitmap) {
> > -        goto fail;
> > -    }
> > -
> > -    /*
> > -     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
> > -     * mode.
> > -     */
> > -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> > -
> >       bdrv_graph_wrlock_drained();
> >       ret = block_job_add_bdrv(&s->common, "source", bs, 0,
> >                                BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
> > @@ -2099,9 +2111,6 @@ fail:
> >           g_free(s->replaces);
> >           blk_unref(s->target);
> >           bs_opaque->job = NULL;
> > -        if (s->dirty_bitmap) {
> > -            bdrv_release_dirty_bitmap(s->dirty_bitmap);
> > -        }
> >           job_early_fail(&s->common.job);
> >       }
> > @@ -2115,6 +2124,7 @@ fail:
> >       bdrv_graph_wrunlock();
> >       bdrv_drained_end(bs);
> > +    bdrv_release_dirty_bitmap(bs_opaque->dirty_bitmap);
> 
> 
> Hmm. Shouldn't we change position of _release_ in mirror_exit_common() too?
> 
> Now the sequence is:
> 
> bdrv_release_dirty_bitmap(s->dirty_bitmap);
> 
> 
> < could mirror_top_bs access dirty_bitmap here, before drained begin? >
> 
> ...
> 
> drained begin
> 
> .. a lot of logic, including actual removing of the mirror_top_bs from the chain ..
> 
> drained end
> 
> bdrv_unref(mirror_top_bs)

I think you're right, but isn't this already a preexisting bug in
master? After releasing, we don't set s->dirty_bitmap = NULL, which
could have prevented the access in the code before this patch. So this
should probably be a separate patch.

mirror_exit_common() runs in the main loop, so I assume you can
hit this when using an iothread.

It seems that initially the release was later, but commit 2119882 moved
it earlier, without saying why it did that. Paolo, do you remember?

Kevin


