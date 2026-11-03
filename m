Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA709606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWhnsC4l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEtl-0006Ku-IQ; Tue, 03 Nov 2026 08:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOEtk-0006KN-1g
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOEti-0007nl-2p
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793713797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zr3y8HLy7C3EqTvO0g/b8DP2GhQD0FzKwimVznsei/0=;
 b=hWhnsC4lYObT0ZTXDoVllWHUfUYXysHVAoeJb/V5qLQuRda0B3mE8LtAreQeYpr1PAwR1A
 7gCtiNWqD25GQqZYtC22tCzSXFjEvC7lOTOXvcfkDfwpeSwVvuaMi0jl2vs7KohOR49IRE
 3k930yjUXdx8ASDIIVnclU//BIHxNGo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-O8_C7ksYOz6HhIyO0BCIjA-1; Tue,
 03 Nov 2026 08:49:54 -0500
X-MC-Unique: O8_C7ksYOz6HhIyO0BCIjA-1
X-Mimecast-MFC-AGG-ID: O8_C7ksYOz6HhIyO0BCIjA_1793713793
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0568D195DB98; Tue,  3 Nov 2026 13:49:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97F541955F03; Tue,  3 Nov 2026 13:49:48 +0000 (UTC)
Date: Tue, 3 Nov 2026 14:49:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 00/13] block: fix data loss in the preallocate filter
Message-ID: <aunmep-qvP2dYxSz@redhat.com>
References: <20260930165000.303236-1-den@openvz.org>
 <075b5093-afa5-4d4d-a8c5-8a1157fbeb62@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075b5093-afa5-4d4d-a8c5-8a1157fbeb62@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 30.10.2026 um 12:12 hat Denis V. Lunev geschrieben:
> On 9/30/26 18:49, Denis V. Lunev wrote:
> > This email originated from an IP that might not be authorized by the domain it was sent from.
> > Do not click links or open attachments unless it is an email you expected to receive.
> > A guest running a container workload came up with 164 files of an image
> > layer hollowed out, 45 MiB in all, reading back as zeroes where it had
> > written data and been told the writes were on disk. The damage was
> > scattered in guest offsets but contiguous in image file offsets: a
> > qcow2 over something that zeroed a range of the file.
> >
> > The storage underneath records every change to the file's length. Over
> > a tenth of a second the file grew thirteen times in unaligned steps,
> > one per guest write past its end, then once by 82 MiB. A preallocation
> > sets the length to the triggering write's end rounded up plus 128 MiB,
> > so 82 cannot come from the length the file then had; it can only come
> > from a zeroing that started where the burst began, 49 MiB lower, which
> > is exactly the range that came back as zeroes. The fallocate ran over
> > thirteen acknowledged writes.
> >
> > So the filter worked from a length the file no longer had. There are
> > two ways to get there. Neither is proven, the record cannot decide
> > between them, and both are fixed here.
> >
> > The first is that the filter meant to let those writes in. It raises
> > data_end before issuing the preallocation, so that writes below it
> > pass straight through into the range the fallocate is about to zero,
> > trusting the block layer to order them after it. That trust is
> > misplaced, and it needs no race to go wrong: two things meet. The
> > file-posix widening that patch 1 removes parks the preallocation
> > despite BDRV_REQ_NO_WAIT, and bdrv_find_conflicting_request() skips
> > any overlapping request whose waiting_for is set without looking at
> > what it points at, so a parked serialising request excludes nothing.
> >
> > The second is that the length was simply stale. The filter's lengths
> > are plain fields, read, decided on and written back with nothing in
> > between, and the guest that broke was a virtio-blk with its queues on
> > two iothreads. A lost update on the reserved length gives a start 49
> > MiB low with no ordering subtlety at all.
> >
> > For the first, the straight fix is in bdrv_find_conflicting_request(),
> > and it regresses iotests/077, whose "Overlapping multiple requests"
> > case then verifies wrong data. Patch 1 takes away the other half
> > instead: the XFS bug the workaround guards was fixed by 249bd9087a52
> > in v5.5, three days before the workaround went in, and predates every
> > stable series still maintained. Without the widening NO_WAIT works as
> > designed, so it is the one patch here I would not drop.
> >
> > For the second, the same state turns out to lose data three ways:
> >
> > - a write into the range the filter records as zero leaves the mark
> >   behind it, so a later write zeroes over that range is skipped and
> >   the guest reads the old data back;
> >
> > - two writers extending the file both pass the compare on data_end and
> >   the smaller end lands last, so closing the image truncates the file
> >   below acknowledged data;
> >
> > - two writers both preallocate over the same range, the older
> >   fallocate lands last, and the first writer's data is zeroed. Fixing
> >   this also stops the filter leaning on the ordering above.
> >
> > Two of the three have tests in iotests/298. The data_end race has
> > none: there is no hook between the compare and the store to hang one
> > on.
> >
> > Six patches are tooling, because none of this could be tested: every
> > qemu-io request ran in the main loop, blkdebug could neither wake nor
> > wait for a request on another AioContext, and nothing could hold a
> > request before the block layer tracks it, which is the window the
> > filter opens. None changes the output of an existing command.
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Kevin Wolf <kwolf@redhat.com>
> > CC: Hanna Reitz <hreitz@redhat.com>
> > CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >
> > Andrey Drobyshev (1):
> >   iotests/298: add testcase for async writes with preallocation filter
> >
> > Denis V. Lunev (12):
> >   block/file-posix: drop the XFS workaround for post-EOF fallocate
> >   block/preallocate: keep zero_start above written data
> >   block/preallocate: collect the state assignments in one place
> >   block/preallocate: serialise the filter state
> >   block/preallocate: hold back writes into a preallocation in flight
> >   tests/unit: prefix the iothread test helper
> >   qemu-io: accept --object iothread
> >   qemu-io: add -t to run an aio request in a named iothread
> >   qemu-io: add -g to write past the end of the image
> >   block/blkdebug: make a breakpoint work across AioContexts
> >   block: add blkdebug events for a write before it is tracked
> >   iotests/298: cover the preallocation races
> >
> >  block/blkdebug.c                  |   3 +-
> >  block/file-posix.c                |  34 --------
> >  block/io.c                        |   3 +
> >  block/preallocate.c               | 139 ++++++++++++++++++++++++------
> >  meson.build                       |   2 +-
> >  qapi/block-core.json              |  10 ++-
> >  qemu-io-cmds.c                    | 116 ++++++++++++++++++++++---
> >  qemu-io.c                         |  41 ++++++++-
> >  tests/qemu-iotests/298            | 113 ++++++++++++++++++++++++
> >  tests/qemu-iotests/298.out        |   4 +-
> >  tests/unit/iothread.c             |  28 +++---
> >  tests/unit/iothread.h             |   8 +-
> >  tests/unit/test-aio-multithread.c |   8 +-
> >  tests/unit/test-bdrv-drain.c      |  32 +++----
> >  tests/unit/test-block-iothread.c  |  28 +++---
> >  15 files changed, 435 insertions(+), 134 deletions(-)
> >
> ping

I went through the patches, but please don't forget Andrey's comments
which he had already made before this ping.

Kevin


