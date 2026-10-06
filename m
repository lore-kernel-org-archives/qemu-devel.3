Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DACCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENKb-0002eD-LB; Wed, 07 Oct 2026 04:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEJcD-0007FX-Ga
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEJc8-0003iO-P2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791348646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FRtW5cFSs4wjYESNRRhPuh47kYLeysd9Cxr3ZmEN9I0=;
 b=i6h6xEywy99sAlPEG5oOFFTWkgF6tYVygWTn3IwEyX4qZyUcjvbszVSOD758MJ80tZz/ux
 ABABC2uNYF97J23kaloaO7lq5dKXELDSAbozsNPLeuLQ/aQ6jeO/M21ia/l5hG4sPIjM/V
 yAYa/zopkmK2mvhd01UoN2QZkDqdqLU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-VDmzYP8qM2GE73W9JqWp8g-1; Tue,
 06 Oct 2026 08:12:15 -0400
X-MC-Unique: VDmzYP8qM2GE73W9JqWp8g-1
X-Mimecast-MFC-AGG-ID: VDmzYP8qM2GE73W9JqWp8g_1791288734
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E65091830908; Tue,  6 Oct 2026 12:12:13 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F28419560AB; Tue,  6 Oct 2026 12:12:11 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:12:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v4 3/5] block: let bdrv_reopen_commit_post() report a
 failure
Message-ID: <asTlmZ3i9tSCw4Ss@redhat.com>
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-4-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133729.1141990-4-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 24.08.2026 um 15:37 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> The callback runs after bdrv_reopen_multiple() has committed the
> transaction, so it cannot reject the reopen. It can still find that
> the node it has just made writable is unusable, and has no way to say
> so: bdrv_reopen() returns success and the caller carries on.
> 
> Give it a return value and an Error argument. The reopen stays
> committed, the error only reports that the node is gone. Every queued
> node still gets its callback, the first error is the one reported. A
> callback may leave its node without a driver, and so may the I/O of a
> later bdrv_reopen_prepare(), so do not assume that the nodes still
> ahead of it in the queue have one. qcow2 is the only implementation and
> does not fail yet.
> 
> An error therefore means one of two things now, either that the reopen
> was denied and nothing changed, or that it went through and left a tree
> which cannot be used. Nothing is undone in the second case: the node is
> beyond repair by another reopen, and a caller which reacts to the error
> by reopening anything is making it worse. bdrv_reopen_multiple() says
> so, nothing else changes.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org

What you write both in the commit messages of this and the following
patches and in this thread makes me think that you understand well that
this approach is fundamentally wrong if we're taking the transaction
model seriously, so I don't have to explain that.

If we were discussing which transaction phase should contain image
repairing completely out of the context of QEMU code, I think we would
be very quick to agree that it's the prepare phase.

The problem is just that it shows once again the old problem that the
reopen design is flawed and doesn't allow writing to the image in the
prepare phase for a ro -> rw transition. Even the already existing
qcow2_reopen_commit_post() is just a hack; in theory, the bitmaps should
be made writable in prepare and then commit should just be a switchover.
Reverting to read-only in abort is an operation that can tolerate
failure, it just gives up access.

I've been thinking for a long time that during reopen, parent nodes
should have access to both the old state and the new state of their
children to allow all necessary modifications. This feels like a very
big change, though.

I'm wondering if for ro/rw specifically (which is actually the one
setting that is always involved in these nasty cases), it might be
enough if we define the expected state after prepare to be that the
image is writable if either the old or the new state is writable. Then
commit and abort always just either leave it writable or drop write
permissions.

Do you think this would be a viable approach for your problem here or
are there additional problems why the image checking can't be done
during prepare?

Kevin


