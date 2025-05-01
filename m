Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425CBC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYBy-0001LI-06; Thu, 01 May 2025 13:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uAYBW-0001AI-GL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uAYBT-0001L9-VH
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746122333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9IBaZ5uNNv+zAigNXl/MQ9CKLfyChNxEz1i0sWg2LM=;
 b=RzZYkcOkDZ8OMtkaZZTmFtm4GHg0e2p91p4DidmvY2HmvOs25uno7pUrDW5BgPUwBmg5S1
 64korjsBDVpXsn1kPBi2qz5omeaLP1OxxQ2c1uR8ZQeTqrIPqWiloahC9fdRo/So7LiFe6
 07xGQeWthsgPtVOS9xN8V+TCs27muq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-EChZBkoEPyCROK4bOL_RsA-1; Thu,
 01 May 2025 13:58:50 -0400
X-MC-Unique: EChZBkoEPyCROK4bOL_RsA-1
X-Mimecast-MFC-AGG-ID: EChZBkoEPyCROK4bOL_RsA_1746122329
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECD8C180036D; Thu,  1 May 2025 17:58:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.84])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7FD630001A2; Thu,  1 May 2025 17:58:45 +0000 (UTC)
Date: Thu, 1 May 2025 12:58:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Sunny Zhu <sunnyzhyy@qq.com>
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 vsementsov@yandex-team.ru
Subject: Re: Re [PATCH v3 08/11] mirror: Skip writing zeroes when target is
 already zero
Message-ID: <5juocucf4fkmromqgt7czkkg7sbnb5tlmwup2aajaaaewdrfgn@skc7mm52ch63>
References: <20250425005439.2252467-21-eblake@redhat.com>
 <tencent_896794CDF9345EF41DF2DCA4B08380B22D07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_896794CDF9345EF41DF2DCA4B08380B22D07@qq.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Thu, May 01, 2025 at 12:38:30AM +0800, Sunny Zhu wrote:
> on Thu 24 Apr 2025 19:52:08 -0500, Eric wrote:
> >      if (s->zero_target) {
> > +        int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> > +
> >          offset = 0;
> >          bdrv_graph_co_rdlock();
> >          ret = bdrv_co_is_all_zeroes(target_bs);
> > @@ -856,6 +898,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >          if (ret < 0) {
> >              return ret;
> >          }
> > +        s->zero_bitmap = bitmap_new(bitmap_length);
> >          /*
> >           * If the destination already reads as zero, and we are not
> >           * requested to punch holes into existing zeroes, then we can
> > @@ -864,6 +907,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >          if (ret > 0 &&
> >              (target_bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP ||
> >               !bdrv_can_write_zeroes_with_unmap(target_bs))) {
> > +            bitmap_set(s->zero_bitmap, 0, bitmap_length);
> 
> when arg->mode != NEW_IMAGE_MODE_EXISTING && bdrv_has_zero_init(target_bs) is true
> in drive_mirror (This means the target image is newly created), in which case
> s->zero_target == false, we still need to execute bitmap_set(s->zero_bitmap, 0, bitmap_length)

Good catch.  I will fix that in v4.

Now that I'm thinking a bit more about it, I wonder if s->zero_target
is the right name.  We have several pieces of information feeding the
potential optimizations: are we mirroring the full image or just a
portion of it (if just a portion, pre-zeroing is wrong because we
shouldn't touch the part of the image not being mirrored), did we just
create the image (in which case it reads as zero and we can skip
pre-zeroing), did the user pass target-is-zero (later in this series,
same effect as if we just created the image), is punching zeroes
allowed (not all setups allow it; and even when it is allowed, there
are tradeoffs on whether to punch one big hole and then fill back up
or to only punch small holes as zeroes are encountered).

It's a big mess of conditionals, so I'm still trying to figure out if
there is a more sensible way to arrange the various logic bits.  With
the addition of target-is-zero, maybe it makes more sense to rename
s->zero_target to s->full_image, and to set s->full_image=true
s->target_is_zero in the arg->mode != NEW_IMAGE_MODE_EXISTING &&
bdrv_has_zero_init(target) case.

> 
> >              offset = s->bdev_length;
> >          }
> >          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
> > @@ -875,6 +919,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
> >          while (offset < s->bdev_length) {
> >              int bytes = MIN(s->bdev_length - offset,
> >                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


