Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0438C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFCP-0004pP-0l; Wed, 14 May 2025 12:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFF0L-0001rS-TF
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFF0J-0002LB-I6
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747240246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADmLI46nf7hxkIM7gp4tYeOv1LXBJgYTVb4Ms4kLRlE=;
 b=ROm6WYqWTIL0ZrxDyvbmnlNNMMrRvlHPXg7c8fF5sjINmHjzLBVgkwVEojNDni+qsdE8F2
 VbptXYGopJdmX8itfu8v/tk9sAQz6Q60Y1n6pQ3cRezSBvHvLXT5oWz0FGbINZ+KyDiyB2
 PgABxtKnLAd494oT2T6hZ8PZk3CYDeM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-BMyqbC_gMaqmt46g8ReYgw-1; Wed,
 14 May 2025 12:30:42 -0400
X-MC-Unique: BMyqbC_gMaqmt46g8ReYgw-1
X-Mimecast-MFC-AGG-ID: BMyqbC_gMaqmt46g8ReYgw_1747240241
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2F76180034E; Wed, 14 May 2025 16:30:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB32619560AE; Wed, 14 May 2025 16:30:38 +0000 (UTC)
Date: Wed, 14 May 2025 11:30:36 -0500
From: Eric Blake <eblake@redhat.com>
To: Sunny Zhu <sunnyzhyy@qq.com>
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 11/13] mirror: Skip writing zeroes when target is
 already zero
Message-ID: <ppa5ptqxmk3vakmrogia7cvlhd5jxy7dhqiozhbyvcczo5mnjb@oqjcg6aeuv6z>
References: <20250509204341.3553601-26-eblake@redhat.com>
 <tencent_80394492ED0159599D33DE267BDA007A1C06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_80394492ED0159599D33DE267BDA007A1C06@qq.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 14, 2025 at 11:37:54PM +0800, Sunny Zhu wrote:
> On Fri, 9 May 2025 15:40:28 -0500, Eric Blake wrote:
> > @@ -847,8 +887,10 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >      bool punch_holes =
> >          target_bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
> >          bdrv_can_write_zeroes_with_unmap(target_bs);
> > +    int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> > 
> >      /* Determine if the image is already zero, regardless of sync mode.  */
> > +    s->zero_bitmap = bitmap_new(bitmap_length);
> >      bdrv_graph_co_rdlock();
> >      bs = s->mirror_top_bs->backing->bs;
> >      if (s->target_is_zero) {
> > @@ -862,7 +904,14 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >      if (ret < 0) {
> >          return ret;
> >      } else if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
> > -        /* In TOP mode, there is no benefit to a pre-zeroing pass.  */
> > +        /*
> > +         * In TOP mode, there is no benefit to a pre-zeroing pass, but
> > +         * the zero bitmap can be set if the destination already reads
> > +         * as zero and we are not punching holes.
> > +         */
> > +        if (ret > 0 && !punch_holes) {
> > +            bitmap_set(s->zero_bitmap, 0, bitmap_length);
> 
> It's ok when ret > 0 is obtained through bdrv_co_is_all_zeroes(target_bs). However,
> if ret = 1 originates by target-is-zero == true from qmp_blockdev_mirror, this means
> that target-is-zero also takes effect under sync=TOP. I am uncertain whether this
> aligns with our intended behavior.
> 
> Under sync=TOP, target-is-zero could carry two distinct meanings:
> [1] The top snapshot reads as fully zero.
> [2] The entire destination snapshot chain reads as fully zero.
> 
> Currently, target-is-zero is designed to represent scenario [2] on sync=TOP.

As written, we are telling the user they should not set target-is-zero
unless the entire destination (including through any snapshot chain)
reads as zero.  Offhand (but untested) I think you can get by with
passing target-is-zero:true even when the destination is not fully
zero, _IF_ all portions of the image that will be mirrored read as
zero (and by doing that, the portions that will not be mirrored are
not cleared as a result).  If my assumption is plausible, that would
be a slick way to do a sync=TOP mirror to copy just the dirty portions
of an image into a destination that already contains all contents from
the clean portions of the image prior to the point in time of the
dirty bitmap, in order to rehydrate a full image from an incremental
mirror.  But given that it is not tested, I wouldn't recommend trying
it in a production environment.

I doubt that sync=TOP users will ever want to manually set
target-is-zero:true, but don't see any reason to change the series as
reviewed, because the documentation for target-is-zero was clear that
that manually setting it when the image is not actually zero can
possibly cause corruption (even if it ends up working without
corruption in some corner cases).

Meanwhile, the only effect of having the zero bitmap set when
target-is-zero was passed to sync=TOP (even if that is not what most
users will do) is that _if_ the portion of the image that is dirty and
needs to be mirrored reads as zero on the source, it will not be
written to the destination.  It doesn't punch holes in the portions of
the destionation that correspond to unallocated bits of the source.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


