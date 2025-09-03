Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B813BCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2e-0006BR-Qc; Wed, 03 Sep 2025 05:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2V-00067E-QD; Wed, 03 Sep 2025 05:44:27 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2T-0007wr-LR; Wed, 03 Sep 2025 05:44:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0DEBF80798;
 Wed, 03 Sep 2025 12:44:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-KpIGMhKy; Wed, 03 Sep 2025 12:44:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892663;
 bh=mSgHIaR12/SBVJgL9Jw+GVpLjwNw4STFZ/H1sTGYY8U=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=e4Q6bPGO1FgzQWGbqzy0FzhzvFesapaiNUW9R2P44eryxw9/a5TFSc4kqT7mf3SAp
 S9atTzPi/BtNOyBdCHi2Exi+L6Vc+qe5d6Nee428vNE7gAcA8wtXYbi3kOu2ms/nMh
 fgJFKOzLaAhTtduP+WVNWDKTxjeqGoPYiq65zixU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Fam Zheng <fam@euphon.net>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>
Subject: [PATCH 09/10] qio_channel_readv_full(): move setting fd blocking to
 callers
Date: Wed,  3 Sep 2025 12:44:09 +0300
Message-ID: <20250903094411.1029449-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In future we'll need a way to pass non-blocking sockets
through migration channel (backed by unix-socket for local
migration). In this case setting fd blocking in
qio_channel_readv_full() and than setting it non-blocking
again in migration state loading code is not quit good:

1. For CPR scenario it's just wrong, because we pass fds when
source is still running. Making fd blocking when it is still
being used on source will break things. [Still, most probably
we don't no have CPR-supporting states which operates with
non-blocking sockets]

2. It's just ineffective to call the ioctl twice for nothing.

So, we'll need a way to avoid call to qemu_socket_set_block()
in qio_channel_readv_full().

Still let's go further, and simply keep in qio_channel_readv_full()
blocking status of fd as is, and let's the caller to care about it.
It's good at least for symmetry of the API: qemu_channel_writev_full()
doesn't modify the fd, let's qio_channel_readv_full() not doing so
too.

So, this commit moves qemu_socket_set_block() calls from
qio_channel_readv_full() to callers, mostly with help of
qemu_fds_set_blocking() function.

Let's look through all the users of qio_channel_readv_full():

1. Some callers just pass NULLs as fds / nfds, nothing to do here:

- qio_channel_readv()
- qio_channel_read()
- migration_channel_read_peek()

2. Some final users of the API, to be updated:

Add call to qemu_fds_set_blocking():
- qemu_fill_buffer() in migration/qemu-file.c
- test_io_channel_unix_fd_pass() in test-io-channel-socket.c
- vu_message_read() in vhost-user-server.c
- tcp_chr_recv() in chardev/char-socket.c
- vfio_user_recv_one() in vfio-user/proxy.c

Uses only one fd, so add call to qemu_socket_set_block():
- prh_read() in qemu-pr-helper.c
- tpm_emu_ctrl_thread() in qtest/tpm-emu.c

3. An API wrapper, which has own users:

qio_channel_readv_full_all_eof(), called from:
  - multifd_recv_thread() (migration/multifd.c)- with NULLs
  - qio_channel_readv_full_all() - wrapper, called from:
    - qio_channel_readv_all() - wrapper, with NULLs
    - backend_read() (virtio/vhost-user.c): use only one fd,
	  add call to qemu_socket_set_block()
  - qio_channel_readv_all_eof() - wrapper, with NULLs
  - mpqemu_read(), static (in hw/remote/mpqemu-link.c), called from:
    - mpqemu_msg_recv(): add call to qemu_fds_set_blocking()

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-socket.c               |  8 ++++++++
 hw/remote/mpqemu-link.c             |  3 +++
 hw/vfio-user/proxy.c                |  4 ++++
 hw/virtio/vhost-user.c              |  5 +++++
 include/io/channel.h                | 12 +++++++-----
 io/channel-socket.c                 |  4 ----
 migration/qemu-file.c               |  6 ++++++
 scsi/qemu-pr-helper.c               |  4 ++++
 tests/qtest/tpm-emu.c               |  1 +
 tests/unit/test-io-channel-socket.c |  1 +
 util/vhost-user-server.c            |  5 +++++
 11 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 5b9b19ba8b..89d199b426 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -305,6 +305,14 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 
     assert(ret >= 0);
 
+    if (!qemu_fds_set_blockinging(msgfds, msgfds_num, true, NULL)) {
+        for (i = 0; i < msgfds_num; i++) {
+            close(msgfds[i]);
+        }
+        errno = EINVAL;
+        return -1;
+    }
+
     if (msgfds_num) {
         /* close and clean read_msgfds */
         for (i = 0; i < s->read_msgfds_num; i++) {
diff --git a/hw/remote/mpqemu-link.c b/hw/remote/mpqemu-link.c
index 49885a1db6..d5716ff92f 100644
--- a/hw/remote/mpqemu-link.c
+++ b/hw/remote/mpqemu-link.c
@@ -162,6 +162,9 @@ copy_fds:
         goto fail;
     }
     if (nfds) {
+        if (!qemu_fds_set_blockinging(fds, nfds, true, errp)) {
+            goto fail;
+        }
         memcpy(msg->fds, fds, nfds * sizeof(int));
     }
 
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 2275d3fe39..55efa7fd77 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -300,6 +300,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
                              hdr.flags);
 
+    if (!qemu_fds_set_blockinging(fdp, numfds, true, errp)) {
+        goto err;
+    }
+
     /*
      * For replies, find the matching pending request.
      * For requests, reap incoming FDs.
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 36c9c2e04d..badd9d7851 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1801,6 +1801,11 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         goto err;
     }
 
+    if (fd && !qemu_set_blocking(fd[0], true, &local_err)) {
+        error_report_err(local_err);
+        goto err;
+    }
+
     if (hdr.size > VHOST_USER_PAYLOAD_SIZE) {
         error_report("Failed to read msg header."
                 " Size %d exceeds the maximum %zu.", hdr.size,
diff --git a/include/io/channel.h b/include/io/channel.h
index b848d50b99..40823c1728 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -119,9 +119,10 @@ struct QIOChannelClass {
                          Error **errp);
 
     /*
-     * The io_readv handler must guarantee that all
-     * incoming fds are set BLOCKING and CLOEXEC (if
-     * available).
+     * The io_readv handler must set all incoming fds
+     * CLOEXEC, and must NOT modify fds in any other
+     * way (for example, must not change its BLOCKING
+     * status)
      */
     ssize_t (*io_readv)(QIOChannel *ioc,
                         const struct iovec *iov,
@@ -242,8 +243,9 @@ void qio_channel_set_name(QIOChannel *ioc,
  * to call close() on each file descriptor and to
  * call g_free() on the array pointer in @fds.
  * qio_channel_readv_full() guarantees that all
- * incoming fds are set BLOCKING and CLOEXEC (if
- * available).
+ * incoming fds are set CLOEXEC (if available).
+ * qio_channel_readv_full() doesn't modify BLOCKING
+ * state of fds.
  *
  * It is an error to pass a non-NULL @fds parameter
  * unless qio_channel_has_feature() returns a true
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 96098b5bcc..b87a1f3e38 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -494,10 +494,6 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
         *fds = g_renew(int, *fds, *nfds + gotfds);
         memcpy(*fds + *nfds, CMSG_DATA(cmsg), fd_size);
 
-        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-        /* TODO: don't crash on error, just handle it! */
-        qemu_fds_set_blockinging(*fds + *nfds, gotfds, true, &error_abort);
-
 #ifndef MSG_CMSG_CLOEXEC
         for (i = 0; i < gotfds; i++) {
             int fd = (*fds)[*nfds + i];
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034..b1d042e298 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -361,6 +361,12 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
         qemu_file_set_error_obj(f, len, local_error);
     }
 
+    /*
+     * NOTE: don't worry about error_abort, it will be removed
+     * in the next commit
+     */
+    qemu_fds_set_blockinging(fds, nfd, true, &error_abort);
+
     for (int i = 0; i < nfd; i++) {
         FdEntry *fde = g_new0(FdEntry, 1);
         fde->fd = fds[i];
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index b69dd982d6..8ca817f187 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -620,6 +620,10 @@ static int coroutine_fn prh_read(PRHelperClient *client, void *buf, int sz,
             goto err;
         }
 
+        if (!qemu_fds_set_blockinging(fds, nfds, true, errp)) {
+            goto err;
+        }
+
         /* Stash one file descriptor per request.  */
         if (nfds) {
             bool too_many = false;
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index 9e4c2005d0..6ef30ac6b8 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -119,6 +119,7 @@ void *tpm_emu_ctrl_thread(void *data)
         cmd = be32_to_cpu(cmd);
         g_assert_cmpint(cmd, ==, CMD_SET_DATAFD);
         g_assert_cmpint(nfd, ==, 1);
+        qemu_set_blocking(*pfd, true, &error_abort);
         s->tpm_ioc = QIO_CHANNEL(qio_channel_socket_new_fd(*pfd, &error_abort));
         g_free(pfd);
 
diff --git a/tests/unit/test-io-channel-socket.c b/tests/unit/test-io-channel-socket.c
index dc7be96e9c..815ee1d812 100644
--- a/tests/unit/test-io-channel-socket.c
+++ b/tests/unit/test-io-channel-socket.c
@@ -464,6 +464,7 @@ static void test_io_channel_unix_fd_pass(void)
                            &error_abort);
 
     g_assert(nfdrecv == G_N_ELEMENTS(fdsend));
+    qemu_fds_set_blockinging(fdrecv, nfdrecv, true, &error_abort);
     /* Each recvd FD should be different from sent FD */
     for (i = 0; i < nfdrecv; i++) {
         g_assert_cmpint(fdrecv[i], !=, testfd);
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 8dcd32dc65..a2ae318ea3 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -161,6 +161,11 @@ vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
                 g_free(fds);
                 goto fail;
             }
+            if (!qemu_fds_set_blockinging(fds, nfds, true, &local_err)) {
+                error_report_err(local_err);
+                g_free(fds);
+                goto fail;
+            }
             memcpy(vmsg->fds + vmsg->fd_num, fds, nfds * sizeof(vmsg->fds[0]));
             vmsg->fd_num += nfds;
             g_free(fds);
-- 
2.48.1


