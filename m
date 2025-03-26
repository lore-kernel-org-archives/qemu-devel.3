Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD0FC3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVZi-0001yh-UV; Wed, 26 Mar 2025 14:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txVZf-0001x7-Pu
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txVZc-0003Ug-OD
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743014032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Hwt58hQ4/dHD04z2j7ug41b3bXdD1qq24jSurf/kXo=;
 b=B2H9uW9wOnhnrSU9sQIvQ40LQKdQCICOk20TQ9tezlNjJM52qRvcT7UPU09ZC6l/COFhqk
 Nv+ZNajnnBmyakyDCNeahdAlDq7RWDWlc6TUpx4fBG6ZyViHtmgnsSAN7vlJYX3uYe4qxJ
 PziiTGpIAPELwDvaVhCfE0dsX0rYhWY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-oFlWzYiEPPCKKT15ZxdL6A-1; Wed,
 26 Mar 2025 14:33:47 -0400
X-MC-Unique: oFlWzYiEPPCKKT15ZxdL6A-1
X-Mimecast-MFC-AGG-ID: oFlWzYiEPPCKKT15ZxdL6A_1743014024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4246418004A9; Wed, 26 Mar 2025 18:33:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.113])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16526180A803; Wed, 26 Mar 2025 18:33:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/4] aio-posix: integrate fdmon into glib event loop
Date: Wed, 26 Mar 2025 14:33:36 -0400
Message-ID: <20250326183340.1010531-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This series hooks the epoll and io_uring file descriptor monitoring
implementations up to the glib event loop so that even the main loop thread can
use them. Until now the main loop thread was stuck using ppoll(2) because the
glib event loop semantics weren't supported by fdmon-epoll.c and
fdmon-io_uring.c.

The motivation for doing this is to make io_uring available in every QEMU
thread on Linux hosts. This will make it easier to add features that use
io_uring in the future. I am preparing a follow-up series that unifies
block/io_uring.c and util/fdmon-io_uring.c so that AioContext has only one
io_uring context instead of two.

Expect performance results in the coming days comparing as ppoll(2) vs epoll(7)
vs io_uring(7).

Stefan Hajnoczi (4):
  aio-posix: fix polling mode with fdmon-io_uring
  tests/unit: skip test-nested-aio-poll with io_uring
  aio-posix: integrate fdmon into glib event loop
  aio: remove aio_context_use_g_source()

 meson.build                       |  2 +-
 include/block/aio.h               | 39 ++++++++++++--
 util/aio-posix.h                  |  5 ++
 tests/unit/test-aio.c             |  7 ++-
 tests/unit/test-nested-aio-poll.c | 13 ++---
 util/aio-posix.c                  | 81 ++++++----------------------
 util/aio-win32.c                  |  4 --
 util/async.c                      |  1 -
 util/fdmon-epoll.c                | 52 ++++++++++++++++--
 util/fdmon-io_uring.c             | 78 ++++++++++++++++++++++-----
 util/fdmon-poll.c                 | 88 ++++++++++++++++++++++++++++++-
 11 files changed, 268 insertions(+), 102 deletions(-)

-- 
2.49.0


