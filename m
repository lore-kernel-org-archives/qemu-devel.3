Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CB6CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIkG-0006RU-Dh; Tue, 04 Nov 2025 10:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGIkE-0006RI-Dh
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:14:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGIkC-0001OV-EK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762269287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jS5/L7l6+M/sX+n2Ee2nQXmOif1GM9ugVVbUHIAplU=;
 b=Rrkm3muAQnR2lWLUfxkhpM20SngU3IfqkexYFVQHV2jLbth59FuyYt0mZt7jG+GxoQCv4U
 igQK3xEw8Tug1sJBfBXHJJies1uOHrStNic6r5yuCqr2TTws01IED8O9VecPuSoLWXajwA
 1vFrLtkBPh4kYQWI+5xX9nRvRzPXcbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-e7RbG82COs-dAow1314KLw-1; Tue,
 04 Nov 2025 10:14:44 -0500
X-MC-Unique: e7RbG82COs-dAow1314KLw-1
X-Mimecast-MFC-AGG-ID: e7RbG82COs-dAow1314KLw_1762269283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0343C1869BB5; Tue,  4 Nov 2025 15:14:39 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 342501956056; Tue,  4 Nov 2025 15:14:36 +0000 (UTC)
Date: Tue, 4 Nov 2025 16:14:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 7/8] qio: Use AioContext for default-context QIONetListener
Message-ID: <aQoYWusx1Wruhk_A@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103202849.3687643-17-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> The user "John Doe" reported a deadlock when attempting to use
> qemu-storage-daemon to serve both a base file over NBD, and a qcow2
> file with that NBD export as its backing file, from the same process,
> even though it worked just fine when there were two q-s-d processes.
> The bulk of the NBD server code properly uses coroutines to make
> progress in an event-driven manner, but the code for spawning a new
> coroutine at the point when listen(2) detects a new client was
> hard-coded to use the global GMainContext; in other words, the
> callback that triggers nbd_client_new to let the server start the
> negotiation sequence with the client requires the main loop to be
> making progress.  However, the code for bdrv_open of a qcow2 image
> with an NBD backing file uses an AIO_WAIT_WHILE nested event loop to
> ensure that the entire qcow2 backing chain is either fully loaded or
> rejected, without any side effects from the main loop causing unwanted
> changes to the disk being loaded (in short, an AioContext represents
> the set of actions that are known to be safe while handling block
> layer I/O, while excluding any other pending actions in the global
> main loop with potentially larger risk of unwanted side effects).
> 
> This creates a classic case of deadlock: the server can't progress to
> the point of accept(2)ing the client to write to the NBD socket
> because the main loop is being starved until the AIO_WAIT_WHILE
> completes the bdrv_open, but the AIO_WAIT_WHILE can't progress because
> it is blocked on the client coroutine stuck in a read() of the
> expected magic number from the server side of the socket.
> 
> Fortunately, the way that AioContext is set up, any callback that is
> registered to the global AioContext will also be serviced by the main
> loop.  So the fix for the deadlock is to alter QIONetListener so that
> if it is not being used in an explicit alternative GMainContext, then
> it should perform its polling via the global AioContext (which
> indirectly still progresses in the default GMainContext) rather than
> directly in the default GMainContext.  This has no change in behavior
> to any prior use that did not starve the main loop, but has the
> additional benefit that in the bdrv_open case of a nested AioContext
> loop, the server's listen/accept handler is no longer starved because
> it is now part of the same AioContext loop.  From there, since NBD
> already uses coroutines for both server and client code, the nested
> AioContext loop finishes quickly and opening the qcow2 backing chain
> no longer deadlocks.
> 
> The next patch will add a unit test (kept separate to make it easier
> to rearrange the series to demonstrate the deadlock without this
> patch).
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
> Signed-off-by: Eric Blake <eblake@redhat.com>

This assumes that you'll only ever want to listen on a socket in the
main thread. I understand this is what the NBD server does today even if
you specify an iothread, so despite the limitation the patch is useful.
We just might need to change the interfaces again later.

Kevin


