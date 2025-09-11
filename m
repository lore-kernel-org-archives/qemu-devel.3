Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8684ECAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwdUF-0004bJ-1a; Thu, 11 Sep 2025 05:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdU1-0004TO-Cn; Thu, 11 Sep 2025 05:20:50 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdTr-0008S1-58; Thu, 11 Sep 2025 05:20:45 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A0BC580717;
 Thu, 11 Sep 2025 12:20:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QKHlUI0GnCg0-yAH2xSWl; Thu, 11 Sep 2025 12:20:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757582427;
 bh=d1QIvCK0wlqqV0wEulvvLtHgkOCTk1WqmtOj8VCrb5k=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=mPiakxGumZf4NW3WfSMP7dfoIdob8G38O7N7yAOgH1IQAA4lJlVitkxIyrwlF9HJB
 oXYjkPNFg/t4ybqn2RxwskEgcDl8k3fPoQSw1BDaXiZlbVcFPV1c/r/OxKmBkPIL4+
 au6w4uE9IA0eAixbGF5O6PbEr6MozsUuL7/NBRIU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com
Subject: [PATCH v2 0/8] io: deal with blocking/non-blocking fds
Date: Thu, 11 Sep 2025 12:19:58 +0300
Message-ID: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi all!

The series aims to unify code which sets fds blocking/non-blocking
through the whole source.

01: reworked, only drop the for-loop
02: new
03: - improve commit-message, add a lot of motivation REREAD
    - convert GError to Error in a new function
04: - add notes about caller conversion in commit message REREAD
    - add r-b by Peter
    - save IVSHMEM_SERVER_DEBUG()
    - finally decided to keep g_warning() for now: conversion
      g_warning() -> g_printerr() should better be another series
      and cover the whole code-base (actually not too much, and
      mostly in qga)
05: add r-b by Peter
06: new
07: functional part moved to separate commit
08: - fix commit message
    - drop redundant qemu/sockets.h includes

v2 is also based on
[PATCH v4 0/2] save qemu-file incoming non-blocking fds
Based-on: <20250910193112.1220763-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (8):
  char-socket: tcp_chr_recv(): drop extra _set_(block,cloexec)
  char-socket: tcp_chr_recv(): add comment
  util: add qemu_set_blocking() function
  util: drop qemu_socket_set_nonblock()
  util: drop qemu_socket_try_set_nonblock()
  io/channel-socket: rework qio_channel_socket_copy_fds()
  util: drop qemu_socket_set_block()
  use qemu_set_blocking instead of g_unix_set_fd_nonblocking

 chardev/char-fd.c                       |  4 +-
 chardev/char-pty.c                      |  3 +-
 chardev/char-serial.c                   |  3 +-
 chardev/char-socket.c                   | 21 ++-----
 chardev/char-stdio.c                    |  3 +-
 contrib/ivshmem-server/ivshmem-server.c |  6 +-
 hw/hyperv/syndbg.c                      |  4 +-
 hw/input/virtio-input-host.c            |  3 +-
 hw/misc/ivshmem-flat.c                  |  3 +-
 hw/misc/ivshmem-pci.c                   |  7 ++-
 hw/virtio/vhost-user.c                  |  5 +-
 hw/virtio/vhost-vsock.c                 |  8 +--
 include/qemu/osdep.h                    |  1 +
 include/qemu/sockets.h                  |  3 -
 io/channel-command.c                    |  9 ++-
 io/channel-file.c                       |  3 +-
 io/channel-socket.c                     | 80 ++++++++++++++++++-------
 net/dgram.c                             | 28 +++++----
 net/l2tpv3.c                            |  5 +-
 net/socket.c                            | 27 ++++++---
 net/stream.c                            |  9 +--
 net/stream_data.c                       | 10 ++--
 net/tap-bsd.c                           | 12 +++-
 net/tap-linux.c                         |  7 ++-
 net/tap-solaris.c                       |  7 ++-
 net/tap.c                               | 21 ++-----
 qga/channel-posix.c                     |  7 ++-
 qga/commands-posix.c                    |  3 +-
 tests/qtest/fuzz/virtio_net_fuzz.c      |  2 +-
 tests/qtest/vhost-user-test.c           |  3 +-
 tests/unit/socket-helpers.c             |  5 +-
 tests/unit/test-crypto-tlssession.c     |  8 +--
 tests/unit/test-iov.c                   |  5 +-
 ui/input-linux.c                        |  3 +-
 util/event_notifier-posix.c             |  4 +-
 util/main-loop.c                        |  5 +-
 util/oslib-posix.c                      | 22 ++++---
 util/oslib-win32.c                      | 25 ++++----
 util/vhost-user-server.c                |  4 +-
 39 files changed, 224 insertions(+), 164 deletions(-)

-- 
2.48.1


