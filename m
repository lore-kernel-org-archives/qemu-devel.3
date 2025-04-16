Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2995CC369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 21:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5AXH-00081J-TX; Wed, 16 Apr 2025 17:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5AXE-00080l-FN
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5AXC-0004Qu-7t
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744839784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xMqKuYy1bwXdTSCL9ERpOr4bcMjhTxN7hFM2Y3jw3bI=;
 b=Kyf65uxstgIHBJBc3kDMpKgzSO7IQVHwORjzq2TFBGpihuKilASmoMfJ7fzJ9MR4yJGCHc
 zDhwc3yD8Nu18IR6K039mr3hcDdpHb0Zzovj92aqlIVav5MgENMq5dhWpdKdkahKJCHRok
 5jQIw+4PaafZZnKQOiPGlluh19BtQ2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-RCs-VETjM1iQFkofktppvg-1; Wed,
 16 Apr 2025 17:43:03 -0400
X-MC-Unique: RCs-VETjM1iQFkofktppvg-1
X-Mimecast-MFC-AGG-ID: RCs-VETjM1iQFkofktppvg_1744839782
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B9B3180034A; Wed, 16 Apr 2025 21:43:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A8FD195608D; Wed, 16 Apr 2025 21:42:57 +0000 (UTC)
Date: Wed, 16 Apr 2025 16:42:55 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block Jobs" <qemu-block@nongnu.org>
Subject: Re: [PATCH 1/6] mirror: Skip pre-zeroing destination if it is
 already zero
Message-ID: <trcjkh44a34wdsfswsjfh7zx5d3lpx4uljrcbijrjkwxvtgqpf@znllhadzyyoo>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-9-eblake@redhat.com>
 <c72f0d7e-1408-49c7-b068-6a475ce336f1@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72f0d7e-1408-49c7-b068-6a475ce336f1@yandex-team.ru>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Apr 11, 2025 at 10:54:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 11.04.25 04:04, Eric Blake wrote:
> > When doing a sync=full mirroring, QMP drive-mirror requests full
> > zeroing if it did not just create the destination, and blockdev-mirror
> > requests full zeroing unconditionally.  This is because during a full
> > sync, we must ensure that the portions of the disk that are not
> > otherwise touched by the source still read as zero upon completion.
...

> > 
> > +++ b/block/mirror.c
> > @@ -841,14 +841,20 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >       int64_t offset;
> >       BlockDriverState *bs;
> >       BlockDriverState *target_bs = blk_bs(s->target);
> > -    int ret = -1;
> > +    int ret;
> 
> I think, it was to avoid Coverity false-positive around further code
> 
>         WITH_GRAPH_RDLOCK_GUARD() {
>             ret = bdrv_co_is_allocated_above(bs, s->base_overlay, true, offset,
>                                              bytes, &count);
>         }
>         if (ret < 0) {
>             return ret;
>         }
> 
> which you don't touch here. I think "= -1;" should be kept. Or I missed static analyzes revolution (if so, it should be mentioned in commit message).

Fair enough, for keeping something to avoid Coverity false positives.
HOWEVER, initializing to -1 is wrong, since, as you just showed,
elsewhere in the function we return -errno on failure, and -1 is not
always the right error.  If I'm going to keep an initializer, it will
be -EIO rather than -1.  Furthermore, if I understand
WITH_GRAPH_RDLOCK_GUARD() correctly, we could hoist the 'if (ret < 0)'
check inside the guarded region and still get the same behavior, but
with a different visibility to the analyzer.

> 
> >       int64_t count;
> > 
> >       bdrv_graph_co_rdlock();
> >       bs = s->mirror_top_bs->backing->bs;
> > +    if (s->zero_target) {
> > +        ret = bdrv_co_is_zero_fast(target_bs, 0, s->bdev_length);
> > +    }
> >       bdrv_graph_co_rdunlock();

The rdlock is important, but rewriting it into the
WITH_GRAPH_RDLOCK_GUARD() scope does make it look nicer.  Adjusting
that for v2.

> > 
> > -    if (s->zero_target) {
> > +    if (s->zero_target && ret <= 0) {
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> >           if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
> >               bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
> >               return 0;

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


