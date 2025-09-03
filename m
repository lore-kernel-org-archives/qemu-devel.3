Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CF6CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2X-00067u-JX; Wed, 03 Sep 2025 05:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2R-00063t-5F; Wed, 03 Sep 2025 05:44:23 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2N-0007uQ-PR; Wed, 03 Sep 2025 05:44:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 86F468046D;
 Wed, 03 Sep 2025 12:44:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-3Q8IaHK0; Wed, 03 Sep 2025 12:44:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892655;
 bh=J9QaB4FEW8qu/dRsedY2m/lgt6t5nP4BEvMJh/3eM4A=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=IsiImsTzS69cal9kQLflS7InU5UKXc/wiaaBxm72KEPZm1BIgxbYNusYl539O+RiN
 JyiMQ7qiiNpW2oIHYpS3mUa6NMmrkoGocqpMEh3cHqs7yy81SSzuN6nZ8JOqDklUAa
 NvqTbuumhBQAStRFIWSv1q3OmAQzXhdvaNbkYXlE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH 00/10] io: deal with blocking/non-blocking fds
Date: Wed,  3 Sep 2025 12:44:00 +0300
Message-ID: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
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

Hi all!

The series brings two things:

1. unify code which sets fds blocking/non-blocking through the whole
source

2. for fds, which comes from qio_channel_readv_full(), stop making
them blocking in generic code, and move this logic to the callers,
all except coming from migration qemu-file (see last patch)

Vladimir Sementsov-Ogievskiy (10):
  io/channel: document how qio_channel_readv_full() handles fds
  char-socket: rework tcp_chr_recv()
  util: add qemu_set_blocking() function
  util: drop qemu_socket_set_nonblock()
  util: drop qemu_socket_try_set_nonblock()
  util: drop qemu_socket_set_block()
  use qemu_set_blocking instead of g_unix_set_fd_nonblocking
  oslib-posix: add qemu_fds_set_blocking() helper
  qio_channel_readv_full(): move setting fd blocking to callers
  migration/qemu-file: don't make incoming fds blocking again

 chardev/char-fd.c                       |  4 +--
 chardev/char-pty.c                      |  3 +-
 chardev/char-serial.c                   |  3 +-
 chardev/char-socket.c                   | 45 ++++++++++++-------------
 chardev/char-stdio.c                    |  3 +-
 contrib/ivshmem-server/ivshmem-server.c |  5 ++-
 hw/hyperv/syndbg.c                      |  4 ++-
 hw/input/virtio-input-host.c            |  3 +-
 hw/misc/ivshmem-flat.c                  |  4 ++-
 hw/misc/ivshmem-pci.c                   |  8 ++++-
 hw/remote/mpqemu-link.c                 |  3 ++
 hw/vfio-user/proxy.c                    |  4 +++
 hw/virtio/vhost-user.c                  | 10 +++++-
 hw/virtio/vhost-vsock.c                 |  8 ++---
 include/io/channel.h                    | 12 +++++++
 include/qemu/osdep.h                    |  8 +++++
 include/qemu/sockets.h                  |  3 --
 io/channel-command.c                    |  9 +++--
 io/channel-file.c                       |  3 +-
 io/channel-socket.c                     | 26 +++++++-------
 net/dgram.c                             | 28 ++++++++-------
 net/l2tpv3.c                            |  5 +--
 net/socket.c                            | 27 ++++++++++-----
 net/stream.c                            |  9 ++---
 net/stream_data.c                       | 10 +++---
 net/tap-bsd.c                           | 12 +++++--
 net/tap-linux.c                         |  8 ++++-
 net/tap-solaris.c                       |  7 +++-
 net/tap.c                               | 21 ++++--------
 qga/channel-posix.c                     |  7 +++-
 qga/commands-posix.c                    |  3 +-
 scsi/qemu-pr-helper.c                   |  4 +++
 tests/qtest/fuzz/virtio_net_fuzz.c      |  2 +-
 tests/qtest/tpm-emu.c                   |  1 +
 tests/qtest/vhost-user-test.c           |  3 +-
 tests/unit/socket-helpers.c             |  5 ++-
 tests/unit/test-crypto-tlssession.c     |  8 ++---
 tests/unit/test-io-channel-socket.c     |  1 +
 tests/unit/test-iov.c                   |  5 +--
 ui/input-linux.c                        |  3 +-
 util/event_notifier-posix.c             |  5 +--
 util/main-loop.c                        |  6 +++-
 util/oslib-posix.c                      | 27 +++++++++------
 util/oslib-win32.c                      | 25 ++++++--------
 util/vhost-user-server.c                |  9 +++--
 45 files changed, 244 insertions(+), 165 deletions(-)

-- 
2.48.1


