Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E7CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZdi-0001eB-In; Fri, 19 Sep 2025 07:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZdf-0001dp-RW
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZdX-0000ik-Ev
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Es+MZiB3d4JgzWv3pjKXL8mqdv6/px2f5QITt9khZEM=;
 b=Df2NLFIBfXfihnXyg1izW58ecGipS0H5p3caspW8otp68FWYhg0fU23DYLKAzwIo3jU8w+
 rIBlz5d7zp5ujXWO8KnSUh8YwPg2rZSMI5hASvmlXECCYamE5tRVhMpjArZoVT1R/j9f+1
 W9sc3BxBEduNffU6CXrGCgstTMwL8to=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-KThQWn8MPKeLXx4MaTZR1w-1; Fri,
 19 Sep 2025 07:50:33 -0400
X-MC-Unique: KThQWn8MPKeLXx4MaTZR1w-1
X-Mimecast-MFC-AGG-ID: KThQWn8MPKeLXx4MaTZR1w_1758282631
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A5DB19560B2; Fri, 19 Sep 2025 11:50:30 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6205C1955F2D; Fri, 19 Sep 2025 11:50:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 00/16] Treewide I/O handle cleanup
Date: Fri, 19 Sep 2025 12:50:01 +0100
Message-ID: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6:

  Merge tag 'pull-loongarch-20250918' of https://github.com/gaosong715/qemu into staging (2025-09-18 07:08:08 -0700)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to 34523df31962401871ff091a9d0993ac87a9848a:

  util/vhost-user-server: vu_message_read(): improve error handling (2025-09-19 12:46:07 +0100)

----------------------------------------------------------------
 * Update security triage contact address
 * Switch to common helper for changing blocking flag
   across socket and non-socket FDs
 * Check and honour failures to the blocking flag on FDs
 * Don't touch blocking flags on FDs received during migration
 * Remove redundant O_NONBLOCK/O_CLOEXEC handling in chardev

----------------------------------------------------------------

Daniel P. Berrangé (1):
  MAINTAINERS: list qemu-security@nongnu.org as security contact

Vladimir Sementsov-Ogievskiy (15):
  migration/qemu-file: don't make incoming fds blocking again
  io/channel: document how qio_channel_readv_full() handles fds
  char-socket: tcp_chr_recv(): drop extra _set_(block,cloexec)
  char-socket: tcp_chr_recv(): add comment
  util: add qemu_set_blocking() function
  treewide: handle result of qio_channel_set_blocking()
  migration: qemu_file_set_blocking(): add errp parameter
  util: drop qemu_socket_set_nonblock()
  util: drop qemu_socket_try_set_nonblock()
  io/channel-socket: rework qio_channel_socket_copy_fds()
  util: drop qemu_socket_set_block()
  treewide: use qemu_set_blocking instead of g_unix_set_fd_nonblocking
  chardev: qemu_chr_open_fd(): add errp
  chardev: close an fd on failure path
  util/vhost-user-server: vu_message_read(): improve error handling

 MAINTAINERS                             |  2 +-
 block/nbd.c                             |  4 +-
 chardev/char-fd.c                       | 14 ++++--
 chardev/char-file.c                     |  6 ++-
 chardev/char-pipe.c                     |  9 +++-
 chardev/char-pty.c                      |  4 +-
 chardev/char-serial.c                   |  9 ++--
 chardev/char-socket.c                   | 41 ++++++++--------
 chardev/char-stdio.c                    | 10 ++--
 contrib/ivshmem-server/ivshmem-server.c |  9 +++-
 hw/hyperv/syndbg.c                      |  4 +-
 hw/input/virtio-input-host.c            |  3 +-
 hw/misc/ivshmem-flat.c                  |  3 +-
 hw/misc/ivshmem-pci.c                   |  7 ++-
 hw/remote/proxy.c                       |  6 ++-
 hw/remote/remote-obj.c                  |  6 ++-
 hw/vfio-user/proxy.c                    | 11 +++--
 hw/virtio/vhost-user.c                  |  5 +-
 hw/virtio/vhost-vsock.c                 |  8 +--
 include/chardev/char-fd.h               |  2 +-
 include/io/channel.h                    | 24 +++++++--
 include/qemu/osdep.h                    |  1 +
 include/qemu/sockets.h                  |  3 --
 io/channel-command.c                    |  9 ++--
 io/channel-file.c                       |  3 +-
 io/channel-socket.c                     | 65 ++++++++++++++++++++-----
 io/channel-tls.c                        |  2 +-
 io/channel-websock.c                    |  3 +-
 io/channel.c                            |  4 +-
 migration/colo.c                        |  5 +-
 migration/migration.c                   |  8 +--
 migration/postcopy-ram.c                |  2 +-
 migration/qemu-file.c                   |  7 +--
 migration/qemu-file.h                   |  2 +-
 migration/savevm.c                      |  4 +-
 nbd/server.c                            |  4 +-
 net/dgram.c                             | 28 ++++++-----
 net/l2tpv3.c                            |  5 +-
 net/socket.c                            | 27 ++++++----
 net/stream.c                            |  9 ++--
 net/stream_data.c                       | 10 ++--
 net/tap-bsd.c                           | 12 ++++-
 net/tap-linux.c                         |  7 ++-
 net/tap-solaris.c                       |  7 ++-
 net/tap.c                               | 21 +++-----
 qga/channel-posix.c                     |  7 ++-
 qga/commands-posix.c                    |  3 +-
 scsi/qemu-pr-helper.c                   |  9 ++--
 tests/qtest/fuzz/virtio_net_fuzz.c      |  2 +-
 tests/qtest/vhost-user-test.c           |  4 +-
 tests/unit/io-channel-helpers.c         |  5 +-
 tests/unit/socket-helpers.c             |  4 +-
 tests/unit/test-crypto-tlssession.c     |  8 +--
 tests/unit/test-io-channel-tls.c        |  4 +-
 tests/unit/test-iov.c                   |  5 +-
 tools/i386/qemu-vmsr-helper.c           |  6 ++-
 ui/input-linux.c                        |  3 +-
 ui/vnc.c                                |  2 +-
 util/event_notifier-posix.c             |  7 ++-
 util/main-loop.c                        |  5 +-
 util/oslib-posix.c                      | 22 ++++-----
 util/oslib-win32.c                      | 25 +++++-----
 util/vhost-user-server.c                | 26 +++++++---
 63 files changed, 369 insertions(+), 213 deletions(-)

-- 
2.50.1


