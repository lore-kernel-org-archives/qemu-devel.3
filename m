Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1579CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 19:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwQXO-0000ok-8l; Wed, 10 Sep 2025 15:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwQXL-0000oM-FH
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:31:23 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwQXJ-0003q5-8n
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:31:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D155F80638;
 Wed, 10 Sep 2025 22:31:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EVQIl30GrmI0-ybEIGVHr; Wed, 10 Sep 2025 22:31:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757532676;
 bh=uMyWlZz8GUek1kf53f51SjKsa9pyhTAqLEXmUSrq4J8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZF8PiWXYAhyW+imxRDVncIIdw92aYEiIp6D8KIwj7Gs3IPQ1sR9jAhMlZWoYTr5w0
 kjk3mVzqKcNjqT593oEiS5ZCnhNClqbElQI30KzYO+Z99QijxiCxWdZLLimrZkI+RF
 mUhTK0/oWWgvGAHakUPpt4LYh1rYMRFFquXn54os=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] io/channel: document how qio_channel_readv_full()
 handles fds
Date: Wed, 10 Sep 2025 22:31:12 +0300
Message-ID: <20250910193112.1220763-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
References: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

The only realization, which may have incoming fds is
qio_channel_socket_readv() (in io/channel-socket.c).
qio_channel_socket_readv() do call (through
qio_channel_socket_copy_fds()) qemu_socket_set_block() and
qemu_set_cloexec() for each fd.

Also, qio_channel_socket_copy_fds() is called at the end of
qio_channel_socket_readv(), on success path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/io/channel.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 12266256a8..c7f64506f7 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -118,6 +118,15 @@ struct QIOChannelClass {
                          size_t nfds,
                          int flags,
                          Error **errp);
+
+    /*
+     * The io_readv handler must guarantee that all
+     * incoming fds are set BLOCKING (unless
+     * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag is set) and
+     * CLOEXEC (if available).
+     * @fds and @nfds are set only on success path, and untouched
+     * in case of errors.
+     */
     ssize_t (*io_readv)(QIOChannel *ioc,
                         const struct iovec *iov,
                         size_t niov,
@@ -125,6 +134,7 @@ struct QIOChannelClass {
                         size_t *nfds,
                         int flags,
                         Error **errp);
+
     int (*io_close)(QIOChannel *ioc,
                     Error **errp);
     GSource * (*io_create_watch)(QIOChannel *ioc,
@@ -235,6 +245,13 @@ void qio_channel_set_name(QIOChannel *ioc,
  * was allocated. It is the callers responsibility
  * to call close() on each file descriptor and to
  * call g_free() on the array pointer in @fds.
+ * @fds allocated and set (and @nfds is set too)
+ * _only_ on success path. These parameters are
+ * untouched in case of errors.
+ * qio_channel_readv_full() guarantees that all
+ * incoming fds are set BLOCKING (unless
+ * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag
+ * is set) and CLOEXEC (if available).
  *
  * It is an error to pass a non-NULL @fds parameter
  * unless qio_channel_has_feature() returns a true
-- 
2.48.1


