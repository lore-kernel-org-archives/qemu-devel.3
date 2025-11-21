Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D744CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdfR-0001C9-Ct; Fri, 21 Nov 2025 21:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdbW-0006ON-Bl; Fri, 21 Nov 2025 21:44:02 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdaJ-0003WP-EM; Fri, 21 Nov 2025 21:43:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 941A316C6E4;
 Fri, 21 Nov 2025 16:51:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id ED3F6321981;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 12/76] io: move websock resource release to close
 method
Date: Fri, 21 Nov 2025 16:50:50 +0300
Message-ID: <20251121135201.1114964-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The QIOChannelWebsock object releases all its resources in the
finalize callback. This is later than desired, as callers expect
to be able to call qio_channel_close() to fully close a channel
and release resources related to I/O.

The logic in the finalize method is at most a failsafe to handle
cases where a consumer forgets to call qio_channel_close.

This adds equivalent logic to the close method to release the
resources, using g_clear_handle_id/g_clear_pointer to be robust
against repeated invocations. The finalize method is tweaked
so that the GSource is removed before releasing the underlying
channel.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 322c3c4f3abee616a18b3bfe563ec29dd67eae63)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 08ddb274f0..a19b902ff9 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -922,13 +922,13 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encinput);
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
-    object_unref(OBJECT(ioc->master));
     if (ioc->io_tag) {
         g_source_remove(ioc->io_tag);
     }
     if (ioc->io_err) {
         error_free(ioc->io_err);
     }
+    object_unref(OBJECT(ioc->master));
 }
 
 
@@ -1219,6 +1219,15 @@ static int qio_channel_websock_close(QIOChannel *ioc,
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(ioc);
 
     trace_qio_channel_websock_close(ioc);
+    buffer_free(&wioc->encinput);
+    buffer_free(&wioc->encoutput);
+    buffer_free(&wioc->rawinput);
+    if (wioc->io_tag) {
+        g_clear_handle_id(&wioc->io_tag, g_source_remove);
+    }
+    if (wioc->io_err) {
+        g_clear_pointer(&wioc->io_err, error_free);
+    }
     return qio_channel_close(wioc->master, errp);
 }
 
-- 
2.47.3


