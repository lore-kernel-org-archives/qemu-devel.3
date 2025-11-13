Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F58DCD6E55
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 13:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXVx-0005Fo-VL; Thu, 13 Nov 2025 08:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJXRg-0002sZ-FY
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJXRe-0002pX-NK
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763040780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jNDggFfp5p8KVMMjOi+58aNgFm/GxPJYTs70b5/XX3E=;
 b=QLPsukKCt3tRTf+6lnBDG4lxU2Q4mrFqouYvBp48PwzNstlS3boYD491vEBBp8MyYjMGiY
 4PnY2b/jXZJXOV4zXQbLf1859JYRiUjpj4FxXUuz+w9DLXRV72BKSCJzUsnaGjO02X3FBh
 xbILKNZiTkFDQXFnAKXw2IaIgdWtdZk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-fRK3WjV9POO1vjXSSL5new-1; Thu,
 13 Nov 2025 08:32:58 -0500
X-MC-Unique: fRK3WjV9POO1vjXSSL5new-1
X-Mimecast-MFC-AGG-ID: fRK3WjV9POO1vjXSSL5new_1763040777
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B16B1800359; Thu, 13 Nov 2025 13:32:55 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.162])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29C3718004A3; Thu, 13 Nov 2025 13:32:50 +0000 (UTC)
Date: Thu, 13 Nov 2025 14:32:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: Re: [PATCH v6 00/15] aio: add the aio_add_sqe() io_uring API
Message-ID: <aRXeAENqCj1sN7_2@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
 <8ce36148-47a0-463f-9af6-669c69c8b575@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce36148-47a0-463f-9af6-669c69c8b575@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 13.11.2025 um 09:27 hat Michael Tokarev geschrieben:
> On 11/4/25 05:29, Stefan Hajnoczi wrote:
> ..
> > This patch series contains io_uring improvements:
> > 
> > 1. Support the glib event loop in fdmon-io_uring.
> >     - aio-posix: fix race between io_uring CQE and AioHandler deletion
> >     - aio-posix: keep polling enabled with fdmon-io_uring.c
> >     - tests/unit: skip test-nested-aio-poll with io_uring
> >     - aio-posix: integrate fdmon into glib event loop
> > 
> > 2. Enable fdmon-io_uring on hosts where io_uring is available at runtime.
> >     Otherwise continue using ppoll(2) or epoll(7).
> >     - aio: remove aio_context_use_g_source()
> > 
> > 3. Add the new aio_add_sqe() API for submitting io_uring requests in the QEMU
> >     event loop.
> >     - aio: free AioContext when aio_context_new() fails
> >     - aio: add errp argument to aio_context_setup()
> >     - aio-posix: gracefully handle io_uring_queue_init() failure
> >     - aio-posix: add aio_add_sqe() API for user-defined io_uring requests
> >     - aio-posix: avoid EventNotifier for cqe_handler_bh
> > 
> > 4. Use aio_add_sqe() in block/io_uring.c instead of creating a dedicated
> >     io_uring context for --blockdev aio=io_uring. This simplifies the code,
> >     reduces the number of file descriptors, and demonstrates the aio_add_sqe()
> >     API.
> >     - block/io_uring: use aio_add_sqe()
> >     - block/io_uring: use non-vectored read/write when possible
> > 
> > The highlight is aio_add_sqe(), which is needed for the FUSE-over-io_uring
> > Google Summer of Code project and other future QEMU features that natively use
> > Linux io_uring functionality.
> ..> Stefan Hajnoczi (15):
> >    aio-posix: fix race between io_uring CQE and AioHandler deletion
> >    aio-posix: fix fdmon-io_uring.c timeout stack variable lifetime
> >    aio-posix: fix spurious return from ->wait() due to signals
> >    aio-posix: keep polling enabled with fdmon-io_uring.c
> >    tests/unit: skip test-nested-aio-poll with io_uring
> >    aio-posix: integrate fdmon into glib event loop
> >    aio: remove aio_context_use_g_source()
> >    aio: free AioContext when aio_context_new() fails
> >    aio: add errp argument to aio_context_setup()
> >    aio-posix: gracefully handle io_uring_queue_init() failure
> >    aio-posix: unindent fdmon_io_uring_destroy()
> >    aio-posix: add fdmon_ops->dispatch()
> >    aio-posix: add aio_add_sqe() API for user-defined io_uring requests
> >    block/io_uring: use aio_add_sqe()
> >    block/io_uring: use non-vectored read/write when possible
> 
> Is there anything in there which should go to qemu-stable?
> 
> From the descriptions of a few changes it feels like something should.

fdmon-io_uring has effectively been dead code since commit ba607ca (and
until patch 7 in this series). The commit message of that commit makes
it sounds like there are cases where GSource is not enabled, but there
really aren't.

You may want to pick patch 2 anyway because it's a use after free and
may effectively hang QEMU (by using far too large timeouts), but from
what I can tell, without downstream code changes, you won't ever run
this code in relevant stable releases. QEMU 5.0 was the only release
that had it enabled before.

Kevin


