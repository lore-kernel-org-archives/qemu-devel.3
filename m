Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E123CCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9AV-0001li-Qi; Mon, 15 Sep 2025 09:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AI-0001fb-8S; Mon, 15 Sep 2025 09:22:42 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9A5-0006xU-Pl; Mon, 15 Sep 2025 09:22:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id F0CCE807AB;
 Mon, 15 Sep 2025 16:22:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GMPC4o1FuGk0-32KhOPoQ; Mon, 15 Sep 2025 16:22:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757942537;
 bh=rZ/8anOCcz54GzE9PzIV9CBWgq17XZzQZp/aEQiurNw=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=E2dehFZXZMpwdr6QoQ11P++jZu/D90nhxClaVPfp5Og0rmacWd91DQyUL3/dDgAZ1
 rL0N8DvE4rL12XW2jWlnq6Ikv1Fb+93QhQ297S/n8y383H2lEb6wAmQxC69MxNwPg2
 dyRQ7JHbdncT8oD8rjKfureiQyROnPn2bp+bGoEY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com
Subject: [PATCH v3 00/13] io: deal with blocking/non-blocking fds
Date: Mon, 15 Sep 2025 16:21:57 +0300
Message-ID: <20250915132211.135095-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

v3:
01-03: add r-b by Daniel
04-06: new
07: rebased onto 04-05, drop r-b
08: add r-b by Daniel
09: rework to use g_clear_pointer
10: add r-b by Daniel
11: avoid errp=NULL in updated code
12,13: new

Series based on
"[PATCH v4 0/2] save qemu-file incoming non-blocking fds"
Based-on: <20250910193112.1220763-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (13):
  char-socket: tcp_chr_recv(): drop extra _set_(block,cloexec)
  char-socket: tcp_chr_recv(): add comment
  util: add qemu_set_blocking() function
  util/error: add &error_reporter
  handle result of qio_channel_set_blocking()
  migration: qemu_file_set_blocking(): add errp parameter
  util: drop qemu_socket_set_nonblock()
  util: drop qemu_socket_try_set_nonblock()
  io/channel-socket: rework qio_channel_socket_copy_fds()
  util: drop qemu_socket_set_block()
  use qemu_set_blocking instead of g_unix_set_fd_nonblocking
  chardev: qemu_chr_open_fd(): add errp
  chardev: close an fd on failure path

 block/nbd.c                             |  5 +-
 chardev/char-fd.c                       | 14 +++--
 chardev/char-file.c                     |  6 +-
 chardev/char-pipe.c                     |  9 ++-
 chardev/char-pty.c                      |  4 +-
 chardev/char-serial.c                   |  9 ++-
 chardev/char-socket.c                   | 35 ++++++------
 chardev/char-stdio.c                    | 10 ++--
 contrib/ivshmem-server/ivshmem-server.c |  7 ++-
 hw/hyperv/syndbg.c                      |  4 +-
 hw/input/virtio-input-host.c            |  3 +-
 hw/misc/ivshmem-flat.c                  |  3 +-
 hw/misc/ivshmem-pci.c                   |  7 ++-
 hw/remote/proxy.c                       |  6 +-
 hw/remote/remote-obj.c                  |  5 +-
 hw/vfio-user/proxy.c                    | 11 +++-
 hw/virtio/vhost-user.c                  |  5 +-
 hw/virtio/vhost-vsock.c                 |  8 +--
 include/chardev/char-fd.h               |  2 +-
 include/io/channel.h                    | 14 ++---
 include/qapi/error.h                    |  6 ++
 include/qemu/osdep.h                    |  1 +
 include/qemu/sockets.h                  |  3 -
 io/channel-command.c                    |  9 ++-
 io/channel-file.c                       |  3 +-
 io/channel-socket.c                     | 74 ++++++++++++++++++-------
 io/channel.c                            |  4 +-
 migration/colo.c                        |  4 +-
 migration/migration.c                   |  8 ++-
 migration/postcopy-ram.c                |  2 +-
 migration/qemu-file.c                   |  4 +-
 migration/qemu-file.h                   |  2 +-
 migration/savevm.c                      |  4 +-
 nbd/server.c                            |  4 +-
 net/dgram.c                             | 28 ++++++----
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
 scsi/qemu-pr-helper.c                   |  9 ++-
 tests/qtest/fuzz/virtio_net_fuzz.c      |  2 +-
 tests/qtest/vhost-user-test.c           |  3 +-
 tests/unit/io-channel-helpers.c         |  5 +-
 tests/unit/socket-helpers.c             |  4 +-
 tests/unit/test-crypto-tlssession.c     |  8 +--
 tests/unit/test-io-channel-tls.c        |  4 +-
 tests/unit/test-iov.c                   |  5 +-
 tools/i386/qemu-vmsr-helper.c           |  6 +-
 ui/input-linux.c                        |  3 +-
 ui/vnc.c                                |  2 +-
 util/error.c                            |  3 +
 util/event_notifier-posix.c             |  5 +-
 util/main-loop.c                        |  5 +-
 util/oslib-posix.c                      | 22 ++++----
 util/oslib-win32.c                      | 25 ++++-----
 util/vhost-user-server.c                |  9 ++-
 62 files changed, 337 insertions(+), 214 deletions(-)

-- 
2.48.1


