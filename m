Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C8EC369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 21:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Afp-0001QD-Nq; Wed, 16 Apr 2025 17:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5Afm-0001PL-0F
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5Afh-0006Ux-OD
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744840312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9Lm48SefjCfEzgzR1oo9Up3A2s1OIs91JXcv7iSl1M=;
 b=AVxyu4mjppCNB2k2JouWQjoZKX/l5vLTD989SMibsV0NZq/xKZbes23ZWOP1NfzMeu1kEz
 vH4vss+SwL8OY56+cMCmYUBLv7Gbh7IIWfrSJ5721lbrean7zvIteBO8BVbQMAksUO2TXI
 6UmgMWmowy8EXb5O1muEjdkP5fPp764=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-jI_QmtDePDixYJCbkHKFfA-1; Wed,
 16 Apr 2025 17:51:46 -0400
X-MC-Unique: jI_QmtDePDixYJCbkHKFfA-1
X-Mimecast-MFC-AGG-ID: jI_QmtDePDixYJCbkHKFfA_1744840306
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F075B195608C; Wed, 16 Apr 2025 21:51:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E99231800965; Wed, 16 Apr 2025 21:51:42 +0000 (UTC)
Date: Wed, 16 Apr 2025 16:51:40 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block Jobs" <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/6] mirror: Skip writing zeroes when target is already
 zero
Message-ID: <k2owyvfkfsj6kkbd2bkgk5jjepxf2gexllc7pfednxrzezlgc6@lh4ebgd7kl3a>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-11-eblake@redhat.com>
 <c3044546-b921-4cbc-959d-4f23e0e3c49e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3044546-b921-4cbc-959d-4f23e0e3c49e@yandex-team.ru>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Apr 15, 2025 at 06:59:15PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 11.04.25 04:04, Eric Blake wrote:
> > When mirroring, the goal is to ensure that the destination reads the
> > same as the source; this goal is met whether the destination is sparse
> > or fully-allocated.  However, if the destination cannot efficiently
> > write zeroes, then any time the mirror operation wants to copy zeroes
> > from the source to the destination (either during the background over
> > sparse regions when doing a full mirror, or in the foreground when the
> > guest actively writes zeroes), we were causing the destination to
> > fully allocate that portion of the disk, even if it already read as
> > zeroes.
> > 
> > -    ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
> > -                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
> > +    if (op->s->zero_bitmap) {
> > +        unsigned long last = (op->offset + op->bytes) / op->s->granularity;
> 
> Maybe, call it "end", not "last, as it's not last element of the range, but first after the range.

Works for me.

> 
> Also, seems we need still do DIV_ROUND_UP, for ..
> 
> > +        assert(QEMU_IS_ALIGNED(op->offset, op->s->granularity));
> > +        assert(QEMU_IS_ALIGNED(op->bytes, op->s->granularity) ||
> > +               op->offset + op->bytes == op->s->bdev_length);
> 
> .. ^ this case, when bytes is unaligned to granularity but aligned to bdev_length.

Hmm, good point.  I'll have to revisit the logic and make sure it
still works in the case of a final partial region.

> 
> > +        if (find_next_zero_bit(op->s->zero_bitmap, last,
> > +                               op->offset / op->s->granularity) == last) {
> > +            write_needed = false;
> > +        }
> > +    }
> > +    if (write_needed) {
> > +        ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
> > +                                   op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
> > +    }
> > +    if (ret >= 0 && op->s->zero_bitmap) {
> > +        bitmap_set(op->s->zero_bitmap, op->offset / op->s->granularity,
> > +                   op->bytes / op->s->granularity);
> 
> and here we want to align up bytes, for the corner case
> 
> > +    }
> 
> Also, I'm not sure, what guarantees we have in case of write-zeroes failure. Should we clear the bitmap in this case, like we do MIRROR_METHOD_COPY and MIRROR_METHOD_DISCARD below

My goal was to clear the bitmap before any action that (potentially)
destroys zero regions (writes and discards), even if that action
fails; but only set the bitmap after success on any action that
creates zero regions (write-zero).  If the write-zero fails, and the
bitmap was already set, it doesn't matter that we left the bitmap set
(a write zeroes that fails AND causes the disk to no longer read as
zero should not happen); otherwise, we are correct in leaving the
bitmap unset on failure (even if the write-zeros partially succeeded,
the pessimistic answer of assuming a region is non-zero is always
correct even if sometimes slower).

> 
> >       mirror_write_complete(op, ret);
> >   }
> > 
> > @@ -441,6 +459,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
> >       Coroutine *co;
> >       int64_t bytes_handled = -1;
> > 
> > +    assert(QEMU_IS_ALIGNED(offset, s->granularity));
> > +    assert(QEMU_IS_ALIGNED(bytes, s->granularity) ||
> > +           offset + bytes == s->bdev_length);
> >       op = g_new(MirrorOp, 1);
> >       *op = (MirrorOp){
> >           .s              = s,
> > @@ -452,12 +473,21 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
> > 
> >       switch (mirror_method) {
> >       case MIRROR_METHOD_COPY:
> > +        if (s->zero_bitmap) {
> > +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> > +                         bytes / s->granularity);
> 
> again, align up for corner case
> 
> > +        }
> >           co = qemu_coroutine_create(mirror_co_read, op);
> >           break;
> >       case MIRROR_METHOD_ZERO:
> > +        /* s->zero_bitmap handled in mirror_co_zero */
> >           co = qemu_coroutine_create(mirror_co_zero, op);
> >           break;
> >       case MIRROR_METHOD_DISCARD:
> > +        if (s->zero_bitmap) {
> > +            bitmap_clear(s->zero_bitmap, offset / s->granularity,
> > +                         bytes / s->granularity);
> > +        }
> >           co = qemu_coroutine_create(mirror_co_discard, op);
> >           break;
> >       default:
> > @@ -851,10 +881,17 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >       }
> >       bdrv_graph_co_rdunlock();
> > 
> > -    if (s->zero_target && ret <= 0) {
> > +    if (s->zero_target) {
> > +        int64_t length;
> > +
> >           if (ret < 0) {
> >               return ret;
> >           }
> > +        length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> > +        s->zero_bitmap = bitmap_new(length);
> > +        if (ret > 0) {
> > +            bitmap_set(s->zero_bitmap, 0, length);
> 
> hmm, we should not continue zeroing target in case of ret > 0.

Correct. If ret > 0, we set zero_bitmap to record that starting state,
and then want to proceed on with the rest of the code that populates
only the non-zero portions of the dirty bitmap.

> 
> I didn't like that we set ret in one if-block, and handle in another, but now it gets even more confusing.
> 
> Maybe, just move bdrv_co_is_zero_fast() call into big "if (s->zero_target) {" ?

That would require grabbing another RDLOCK - but I'll try and see if
that makes things easier to read.

...
> > +        if (job->zero_bitmap && ret >= 0) {
> > +            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granularity,
> > +                       (dirty_bitmap_end - dirty_bitmap_offset) /
> > +                       job->granularity);
> > +        }
> 
> Same thing, probably we should clear the bitmap in case of write failure.

Why? Either the bitmap was already clear, or we had a write failure on
writing zeroes on top of zeroes but the region should still read as
zeroes.

> 
> >           break;
> > 
> >       case MIRROR_METHOD_DISCARD:
> > +        if (job->zero_bitmap) {
> > +            bitmap_clear(job->zero_bitmap, zero_bitmap_offset,
> > +                         zero_bitmap_end - zero_bitmap_offset);
> > +        }
> >           assert(!qiov);
> >           ret = blk_co_pdiscard(job->target, offset, bytes);
> >           break;
> > @@ -1436,10 +1498,10 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
> >            * at function start, and they must be still dirty, as we've locked
> >            * the region for in-flight op.
> >            */
> > -        bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
> > -        bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
> > -        bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
> > -                              bitmap_end - bitmap_offset);
> > +        dirty_bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
> > +        dirty_bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
> > +        bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
> > +                              dirty_bitmap_end - dirty_bitmap_offset);
> 
> Not really matter, but still, renaming in a separate patch would make this one a bit simpler.

Okay, I'll split the variable rename.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


