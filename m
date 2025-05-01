Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47515C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXms-0005Bi-17; Thu, 01 May 2025 13:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uAXmq-0005AI-Cm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uAXmo-0004z7-Ic
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746120805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xt8ToVu5X4DE2pvr6+jXx4u3GB25x2oj60FdoWCghFM=;
 b=IuuqwNqxuB1Vl4h2V6X4LxlalYFH0DquJfzJsy61WVyioMxPpZ082cLXXqTmbajMj6LYTc
 TtdLM4QjiI+1i/ZCO6FZwXwnGL18XL8I27VldILv2vIcaCzkTzh5t0cg7LDGfBAXw63GmB
 g1tx9fxP0aKz+RdoYlFsaP0mkavsv7c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-aWh2nuekM0K-HsSSiw-DBQ-1; Thu,
 01 May 2025 13:33:22 -0400
X-MC-Unique: aWh2nuekM0K-HsSSiw-DBQ-1
X-Mimecast-MFC-AGG-ID: aWh2nuekM0K-HsSSiw-DBQ_1746120801
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B57011956094; Thu,  1 May 2025 17:33:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.84])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96C0919560A3; Thu,  1 May 2025 17:33:17 +0000 (UTC)
Date: Thu, 1 May 2025 12:33:14 -0500
From: Eric Blake <eblake@redhat.com>
To: Sunny Zhu <sunnyzhyy@qq.com>
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 07/11] mirror: Skip pre-zeroing destination if it is
 already zero
Message-ID: <62z5r3pt24o3ng2iumeoz4hmzavveucs3o56yj5mlg3quinkv6@keliqtsk3c54>
References: <20250425005439.2252467-20-eblake@redhat.com>
 <tencent_5A9BAC6959E81AE41E493B07736535CE7608@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5A9BAC6959E81AE41E493B07736535CE7608@qq.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 01, 2025 at 12:09:26AM +0800, Sunny Zhu wrote:
> > When doing a sync=full mirroring, QMP drive-mirror requests full
> > zeroing if it did not just create the destination, and blockdev-mirror
> > requests full zeroing unconditionally.  This is because during a full
> > sync, we must ensure that the portions of the disk that are not
> > otherwise touched by the source still read as zero upon completion.
> > 
> > However, in mirror_dirty_init(), we were blindly assuming that if the
> > destination allows punching holes, we should pre-zero the entire
> > image; and if it does not allow punching holes, then treat the entire
> > source as dirty rather than mirroring just the allocated portions of
> > the source.  Without the ability to punch holes, this results in the
> > destination file being fully allocated; and even when punching holes
> > is supported, it causes duplicate I/O to the portions of the
> > destination corresponding to chunks of the source that are allocated
> > but read as zero.
> > 
> > Smarter is to avoid the pre-zeroing pass over the destination if it
> > can be proved the destination already reads as zero.  Note that a
> > later patch will then further improve things to skip writing to the
> > destination for parts of the image where the source is zero; but even
> > with just this patch, it is possible to see a difference for any BDS
> > that can quickly report that it already reads as zero.
> > 
> > Note, however, that if the destination was opened with
> > "detect-zeroes": "unmap", then the user wants us to punch holes where
> > possible for any zeroes in the source; in that case, we are better off
> > doing unmap up front in bulk.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > 
> > ---
> > 
> > v3: add exemption for "detect-zeroes":"unmap" on destination
> > ---
> >  block/mirror.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/mirror.c b/block/mirror.c
> > index 34c6c5252e1..4059bf96854 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
> > @@ -849,13 +849,30 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >      bdrv_graph_co_rdunlock();
> > 
> >      if (s->zero_target) {
> > +        offset = 0;
> > +        bdrv_graph_co_rdlock();
> > +        ret = bdrv_co_is_all_zeroes(target_bs);
> > +        bdrv_graph_co_rdunlock();
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +        /*
> > +         * If the destination already reads as zero, and we are not
> > +         * requested to punch holes into existing zeroes, then we can
> > +         * skip pre-zeroing the destination.
> > +         */
> > +        if (ret > 0 &&
> > +            (target_bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP ||
> > +             !bdrv_can_write_zeroes_with_unmap(target_bs))) {
> > +            offset = s->bdev_length;
> 
> If when bdrv_can_write_zeroes_with_unmap(target_bs) == true, we prefer to
> punch holes regardless of whether target_bs already reads as zero, then
> execute bdrv_co_is_all_zeroes() in advance might be wasteful.

Hmm.  bdrv_co_is_all_zeroes() is supposed to be fast, but you're right
that even faster than a syscall or two is no syscalls at all.

> 
>     if (bdrv_can_write_zeroes_with_unmap(target_bs)) {
>         initial_zeroing();
>     } else {
>         ret = bdrv_co_is_all_zeroes(target_bs);
>         ...
>     }

That's a bigger refactoring; probably worth doing in a separate patch.
It looks like I should probably do a v4 along those lines, to see how
it compares.

> 
> > +        }
> >          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
> >              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
> >              return 0;
> 
> When ret > 0, We should not return directly here.

That's pre-existing, but correct.  If we can't write zeroes with
unmap, then we mark the entire image dirty (every zero in the source
will result in zeroes in the dest - as it was before this series); and
we have also marked the zero bitmap (writing zeroes will be a no-op if
the zero bitmap says that is safe).  The rest of this function has two
purposes: finish pre-zeroing (well, there's nothing to pre-zero if we
can't punch holes, and especially nothing to pre-zero if we already
know the image reads as all zero), and populate the dirty bitmap (we
just populated the entire map here, so it's not worth trying to
populate the map with finer granularity later), so returning here is
the right thing to do.

> 
> >          }
> > 
> >          s->initial_zeroing_ongoing = true;
> > -        for (offset = 0; offset < s->bdev_length; ) {
> > +        while (offset < s->bdev_length) {
> >              int bytes = MIN(s->bdev_length - offset,
> >                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


