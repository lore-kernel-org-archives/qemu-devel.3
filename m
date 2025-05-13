Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D573C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 21:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uExJz-0006R4-DL; Tue, 13 May 2025 17:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uExJw-0006P7-U6
 for qemu-devel@nongnu.org; Tue, 13 May 2025 17:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uExJv-0002sT-9Q
 for qemu-devel@nongnu.org; Tue, 13 May 2025 17:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747172269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqICWRWkyWo9RPtxXCgnCJSEDIpvlmgcE6nh4v9lzZc=;
 b=XUGZXIPtGb2ounpQgPu/XxvfnqR+53GcN2kCoUkD0MijXuTEB+kZ+x3A7AC3VhW8dlD3In
 oBouNLdpojeI4InPKvLvxtNKfA63m9UfI1Zq7wRWQO6Xs+8ykTBx3cxeLkjRgeAIPqvLBX
 I4kQLgEWYIpiqBN3UoS0rX2fBnAQbWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-FRY9MrZnO824nDu6Rk5lag-1; Tue,
 13 May 2025 17:37:46 -0400
X-MC-Unique: FRY9MrZnO824nDu6Rk5lag-1
X-Mimecast-MFC-AGG-ID: FRY9MrZnO824nDu6Rk5lag_1747172265
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D37E1955BF2; Tue, 13 May 2025 21:37:44 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.81])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6795D1944B1A; Tue, 13 May 2025 21:37:41 +0000 (UTC)
Date: Tue, 13 May 2025 16:37:38 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com, 
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 11/13] mirror: Skip writing zeroes when target is
 already zero
Message-ID: <joq2ygjqnztow4scffmlha45zudqnamv5vpz6t7fpoyeys6t64@cjunrcvogkk3>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-26-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-26-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On Fri, May 09, 2025 at 03:40:28PM -0500, Eric Blake wrote:
> When mirroring, the goal is to ensure that the destination reads the
> same as the source; this goal is met whether the destination is sparse
> or fully-allocated (except when explicitly punching holes, then merely
> reading zero is not enough to know if it is sparse, so we still want
> to punch the hole).  Avoiding a redundant write to zero (whether in
> the background because the zero cluster was marked in the dirty
> bitmap, or in the foreground because the guest is writing zeroes) when
> the destination already reads as zero makes mirroring faster, and
> avoids allocating the destination merely because the source reports as
> allocated.

I just realized: when we are trying to punch holes, a pre-zeroing pass
still does double I/O on portions of the source that are allocated
(once to punch the hole, another to write it back to non-zero).  That
was the best earlier patches could do, without fine-grained zero
tracking.  But with this patch, we can do better:

> @@ -847,8 +887,10 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>      bool punch_holes =
>          target_bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
>          bdrv_can_write_zeroes_with_unmap(target_bs);
> +    int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
> 
>      /* Determine if the image is already zero, regardless of sync mode.  */
> +    s->zero_bitmap = bitmap_new(bitmap_length);
>      bdrv_graph_co_rdlock();
>      bs = s->mirror_top_bs->backing->bs;
>      if (s->target_is_zero) {
> @@ -862,7 +904,14 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>      if (ret < 0) {
>          return ret;
>      } else if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
> -        /* In TOP mode, there is no benefit to a pre-zeroing pass.  */
> +        /*
> +         * In TOP mode, there is no benefit to a pre-zeroing pass, but
> +         * the zero bitmap can be set if the destination already reads
> +         * as zero and we are not punching holes.
> +         */
> +        if (ret > 0 && !punch_holes) {
> +            bitmap_set(s->zero_bitmap, 0, bitmap_length);
> +        }
>      } else if (ret == 0 || punch_holes) {
>          /*
>           * Here, we are in FULL mode; our goal is to avoid writing
> @@ -871,8 +920,9 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>           * zeroing happened externally (ret > 0) or if we have a fast
>           * way to pre-zero the image (the dirty bitmap will be
>           * populated later by the non-zero portions, the same as for
> -         * TOP mode).  If pre-zeroing is not fast, or we need to punch
> -         * holes, then our only recourse is to write the entire image.
> +         * TOP mode).  If pre-zeroing is not fast, then our only
> +         * recourse is to mark the entire image dirty.  The act of
> +         * pre-zeroing will populate the zero bitmap.
>           */
>          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);

If we are punching holes, leaving the zero bitmap clear (at this
stage) and setting the entire dirty bitmap will cause the entire image
to be visited, and punch holes only where they are needed, without a
pre-zeroing pass.

I will add that as a followup patch (no need to invalidate the reviews
on this one).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


