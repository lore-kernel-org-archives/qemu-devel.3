Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2091C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbyM-0002zO-8z; Tue, 14 Jul 2026 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@varyab.net>) id 1wjUYE-0007n7-1a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:15:22 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@varyab.net>) id 1wjUXM-0001I7-R2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 00:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=varyab.net;
 s=protonmail; t=1784002462; x=1784261662;
 bh=idJ2XWQC3zsBBMyUNs9Xx47wL1VIIbPMwv2W5ObLLqs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=P5W23SYOZ7T6ept3OVvCo9fXi5/rC29xDi4Ln6HkWViXwUPmRhERDypUq42uU7CVW
 ourhoIatv1CEEFprCWTd/vcyaBv3tSbV8QMAZ0XDm9sn3UxJAVbEp5EtiFd771OWMx
 EdjbBvab3NWxSirre05W+S42jXQR/ufl84S71DXO1inY/puiCPgcgZZuIVh+rtlCAr
 MDvLhAazKUvyH4Kzr2RdEX8ZnthxOGLkO9l/l4IKBPEZx89Vtb0udzj9gK6VVl4Kaj
 q7NcNz8Vi0GJp4is8kaWc0jBHVKcIS0iRkbFdUYeMbMZHjK9TRi2Jc6+F6p2uYvBly
 SKMofYmk5ySBg==
Date: Tue, 14 Jul 2026 04:14:15 +0000
To: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
From: Damien Ferrere <damien@varyab.net>
Cc: qemu-devel@nongnu.org, Damien Ferrere <damien@varyab.net>
Subject: [PATCH] qga: don't busy-loop writing to virtio-serial when host
 disconnected
Message-ID: <20260714041405.75395-1-damien@varyab.net>
Feedback-ID: 198370753:user:proton
X-Pm-Message-ID: 46b0545d49653208e9daa7e399a8644d34bf8834
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=damien@varyab.net;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Jul 2026 08:10:46 -0400
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

ga_channel_write_all() retries g_io_channel_write_chars() (and later
g_io_channel_flush()) in a tight loop while the status is
G_IO_STATUS_AGAIN, without ever waiting for the fd to become writable
again.  For a virtio-serial channel this condition is reached whenever
nothing is draining the host-side chardev: the guest port buffer fills
up, every write() returns EAGAIN, and the loop spins, pinning a CPU at
100% for as long as the host stays disconnected.

This is easy to hit in practice: as soon as the host stops reading the
channel and the agent has a response to send (e.g. the reply to a
guest-ping), qemu-ga jumps to 100% CPU.  It shows up as a thread stuck
in state R with /proc/<pid>/io reporting billions of write syscalls for
only a few MB of wchar, and fd pointing at /dev/vportNpN.

Before commit f74df9bfce6d1 the loop simply broke out of the write on a
non-normal status, so G_IO_STATUS_AGAIN could not spin.  That commit
started retrying on AGAIN to handle short writes, but retries with no
backoff or wait, turning a transient AGAIN into an unbounded busy loop.

The read path (channel_event_cb) already mitigates the same virtio spin
with a sleep on G_IO_STATUS_AGAIN.  Do the analogous thing on the write
path, but instead of sleeping a fixed amount, block on POLLOUT so no CPU
is consumed while the channel is unwritable, and return on POLLHUP/
POLLERR so a genuine disconnect surfaces as a write error (which resets
the connection) rather than an infinite wait.

Behaviour is otherwise unchanged: a response that cannot yet be written
is still delivered once the host resumes draining the channel; it just
no longer burns a CPU in the meantime.

Fixes: f74df9bfce6d1 ("qga: handle G_IO_STATUS_AGAIN in ga_channel_write_al=
l()")
Signed-off-by: Damien Ferrere <damien@varyab.net>
---
 qga/channel-posix.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 9ccc8b7bd1..fa16c252f7 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -253,6 +253,25 @@ static gboolean ga_channel_open(GAChannel *c, const gc=
har *path,
     return true;
 }
=20
+/*
+ * Wait for the channel fd to become writable again after a short write
+ * returned G_IO_STATUS_AGAIN. For a virtio-serial channel this happens wh=
en
+ * nothing drains the host-side chardev: the port buffer fills up and ever=
y
+ * write() returns EAGAIN. Without this, the caller busy-loops on write() =
and
+ * pins a CPU at 100% for as long as the host stays disconnected. The read
+ * path (channel_event_cb) already mitigates the same virtio spin with a
+ * sleep; this blocks on POLLOUT so we consume no CPU while waiting, and
+ * returns on HUP/ERR so a real disconnect surfaces as an error instead.
+ */
+static void ga_channel_wait_writable(GAChannel *c)
+{
+    GPollFD pfd =3D {
+        .fd =3D g_io_channel_unix_get_fd(c->client_channel),
+        .events =3D G_IO_OUT | G_IO_ERR | G_IO_HUP,
+    };
+    g_poll(&pfd, 1, -1);
+}
+
 GIOStatus ga_channel_write_all(GAChannel *c, const gchar *buf, gsize size)
 {
     GError *err =3D NULL;
@@ -266,7 +285,9 @@ GIOStatus ga_channel_write_all(GAChannel *c, const gcha=
r *buf, gsize size)
         if (status =3D=3D G_IO_STATUS_NORMAL) {
             size -=3D written;
             buf +=3D written;
-        } else if (status !=3D G_IO_STATUS_AGAIN) {
+        } else if (status =3D=3D G_IO_STATUS_AGAIN) {
+            ga_channel_wait_writable(c);
+        } else {
             g_warning("error writing to channel: %s", err->message);
             return status;
         }
@@ -274,6 +295,9 @@ GIOStatus ga_channel_write_all(GAChannel *c, const gcha=
r *buf, gsize size)
=20
     do {
         status =3D g_io_channel_flush(c->client_channel, &err);
+        if (status =3D=3D G_IO_STATUS_AGAIN) {
+            ga_channel_wait_writable(c);
+        }
     } while (status =3D=3D G_IO_STATUS_AGAIN);
=20
     if (status !=3D G_IO_STATUS_NORMAL) {
--=20
2.47.3



