Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KpWnGS8c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkOa-0004it-K6; Fri, 30 Oct 2026 07:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkOY-0004iN-H1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkOW-0000xC-RK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793358215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVOIMiJdoccg287evmbUpJBqA3OWnH4IYgGQ/o0allo=;
 b=KpWnGS8cBCw0SFSbyklDob9pID5KrZWCfl0rKTx56iGJ24fMZcZLYv7klhISavGfStMPli
 Wmo7CZUxLtFd9DW7hRsg0q9jzfdHP4PVlLtWzDgUJmGLcrPzrAU3esaE2OPa/NDKBlbece
 gwKT5QAw7DY2UEHf01gpsKnMaXgiB2w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-tCx6Y1egO8qlyUnSyVBX2A-1; Fri,
 30 Oct 2026 07:03:34 -0400
X-MC-Unique: tCx6Y1egO8qlyUnSyVBX2A-1
X-Mimecast-MFC-AGG-ID: tCx6Y1egO8qlyUnSyVBX2A_1793358213
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38A4C1955BD0; Fri, 30 Oct 2026 11:03:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.76])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EA126C; Fri, 30 Oct 2026 11:03:29 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:03:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, fengli@smartx.com,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block/mirror: inherit the source node discard flag in
 mirror_top
Message-ID: <auR5f-cvvNgsMqxF@redhat.com>
References: <20261013060549.3008438-1-haoqian.he@smartx.com>
 <801bb56f-c704-4649-9938-73e9370d7a08@yandex-team.ru>
 <as43zG5OHroMfIJZ@redhat.com>
 <0D7D0521-3629-4257-B92C-3EF31509E584@smartx.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D7D0521-3629-4257-B92C-3EF31509E584@smartx.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 14.10.2026 um 04:25 hat Haoqian He geschrieben:
> > 2026年10月13日 21:53，Kevin Wolf <kwolf@redhat.com> 写道：
> > Am 13.10.2026 um 10:15 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> On 13.10.26 09:05, Haoqian He wrote:
> >>> mirror_start_job() inserts a mirror_top filter above the source node
> >>> for both mirror and active commit jobs. Previously, the filter was
> >>> opened with BDRV_O_RDWR only, even when the source had BDRV_O_UNMAP
> >>> enabled.
> >>> 
> >>> The block layer checks BDRV_O_UNMAP before invoking a node's discard
> >>> callback. Without this flag on mirror_top, discard requests return
> >>> success without reaching bdrv_mirror_top_pdiscard(). Consequently,
> >>> starting a job can silently suppress guest UNMAP/TRIM requests that
> >>> would otherwise reach the discard-enabled source.
> >>> 
> >>> Initialize the filter's open flags with BDRV_O_RDWR and conditionally
> >>> add BDRV_O_UNMAP from bs->open_flags. Pass the resulting flags to
> >>> bdrv_new_open_driver() so that mirror_top follows the source node's
> >>> discard setting.
> >>> 
> >>> This allows discard requests to reach the existing filter callback,
> >>> which forwards them to the source and either tracks the affected
> >>> range in the dirty bitmap or synchronously propagates the discard
> >>> to the target, depending on the copy mode.
> >>> 
> >>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
> >>> ---
> >>>  block/mirror.c | 10 ++++++++--
> >>>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>> 
> >>> diff --git a/block/mirror.c b/block/mirror.c
> >>> index 089856f4a8..a551d392c6 100644
> >>> --- a/block/mirror.c
> >>> +++ b/block/mirror.c
> >>> @@ -1854,6 +1854,7 @@ static BlockJob *mirror_start_job(
> >>>      BlockDriverState *mirror_top_bs;
> >>>      bool target_is_backing;
> >>>      uint64_t target_perms, target_shared_perms;
> >>> +    int flags;
> >>>      int ret;
> >>>      GLOBAL_STATE_CODE();
> >>> @@ -1886,8 +1887,13 @@ static BlockJob *mirror_start_job(
> >>>      /* In the case of active commit, add dummy driver to provide consistent
> >>>       * reads on the top, while disabling it in the intermediate nodes, and make
> >>>       * the backing chain writable. */
> >>> -    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
> >>> -                                         BDRV_O_RDWR, errp);
> >>> +    flags = BDRV_O_RDWR;
> >>> +    if (bs->open_flags & BDRV_O_UNMAP) {
> >>> +        flags |= BDRV_O_UNMAP;
> >>> +    }
> >>> +    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top,
> >>> +                                         filter_node_name,
> >>> +                                         flags, errp);
> >>>      if (mirror_top_bs == NULL) {
> >>>          return NULL;
> >>>      }
> >> 
> >> Cool find!
> >> 
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >> 
> >> Thanks for fixing, applied to my block branch.
> > 
> > This bug is something that should be relatively easily testable in
> > qemu-iotests. Can we please add a test at the same time?
> > 
> > Kevin
> > 
> 
> Okay, i will add qemu-iotests in the subsequent patch ASAP.

Did you have time to work on this? Soft feature freeze for QEMU 11.2
will be on Monday, so it would be nice to get it merged by then.

Kevin


