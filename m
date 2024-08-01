Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF33C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZRQt-0003DY-Vo; Thu, 01 Aug 2024 04:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZRQr-0003D4-Hs
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:45:09 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZRQp-0005n1-Hn
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:45:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a52d:0:640:f75d:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 41D3760AF8;
 Thu,  1 Aug 2024 11:45:04 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b657::1:21])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id giSnBU7GXSw0-XwVR4L84; Thu, 01 Aug 2024 11:45:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722501903;
 bh=z25aylodNUmaRECFBFJ0qpEZDzKdJk8uzwwNHcV1bMA=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=aXwP/D0fUkD0TBjIxPW/f86e4TfWSPTUmeHUlUUzZ4r5ls0uoJJNGW6hBBoGvGjiU
 gg4g3xt351biEhdB0kAyQi5j3AW4E88Dv/gAeAzWlVmMXD4UQZv/q5iF/ybMSixqlo
 zZWbA1abIDKH2XS27JqwKQP2/QpePAmnruxjBMdE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, raphael@enfabrica.net,
 mst@redhat.com, yc-core@yandex-team.ru, den-plotnikov@yandex-team.ru,
 vsementsov@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH] char-socket: grow timeout from smaller value
Date: Thu,  1 Aug 2024 11:44:39 +0300
Message-Id: <20240801084439.10515-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

The smallest possible timeout for reconnect to set in QAPI is 1 second.
But for system where reconnect is considered a regular situation and
backend is guaranteed to start in tens of milliseconds this timeout of
1 second becomes an extra throttling.

On the other hand, just allowing smaller timeout would be ineffective
when we consider unplanned disconnect for larger time.

Let's do a simple thing: without any change to API, start reconnecting
with some small constant timeout (5 ms), increasing it exponentially up
to user given value.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all! We faced too long (1 second) pauses in IO during reconnect to
vhost server, and this 1 second is exactly reconnect=1 parameter of
char-socket. Here is our solution for the problem.

 chardev/char-socket.c         | 21 ++++++++++++++++-----
 include/chardev/char-socket.h |  5 ++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ca9441b1b..4a35f75ebe 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -74,9 +74,10 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
     assert(!s->reconnect_timer);
     name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
     s->reconnect_timer = qemu_chr_timeout_add_ms(chr,
-                                                 s->reconnect_time * 1000,
+                                                 s->reconnect_ms,
                                                  socket_reconnect_timeout,
                                                  chr);
+    s->reconnect_ms = MIN(s->reconnect_ms * 2, s->reconnect_ms_max);
     g_source_set_name(s->reconnect_timer, name);
     g_free(name);
 }
@@ -481,7 +482,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     if (emit_close) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     }
-    if (s->reconnect_time && !s->reconnect_timer) {
+    if (s->reconnect_ms && !s->reconnect_timer) {
         qemu_chr_socket_restart_timer(chr);
     }
 }
@@ -1080,9 +1081,11 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
         } else {
             Error *err = NULL;
             if (tcp_chr_connect_client_sync(chr, &err) < 0) {
-                if (s->reconnect_time) {
+                if (s->reconnect_ms) {
                     error_free(err);
-                    g_usleep(s->reconnect_time * 1000ULL * 1000ULL);
+                    g_usleep(s->reconnect_ms * 1000ULL);
+                    s->reconnect_ms = MIN(s->reconnect_ms * 2,
+                                          s->reconnect_ms_max);
                 } else {
                     error_propagate(errp, err);
                     return -1;
@@ -1091,6 +1094,10 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
         }
     }
 
+    if (s->reconnect_ms) {
+        s->reconnect_ms = SOCKET_CHARDEV_RECONNECT_MS_MIN;
+    }
+
     return 0;
 }
 
@@ -1147,6 +1154,9 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
         goto cleanup;
     }
 
+    if (s->reconnect_ms) {
+        s->reconnect_ms = SOCKET_CHARDEV_RECONNECT_MS_MIN;
+    }
     s->connect_err_reported = false;
     tcp_chr_new_client(chr, sioc);
 
@@ -1273,7 +1283,8 @@ static int qmp_chardev_open_socket_client(Chardev *chr,
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (reconnect > 0) {
-        s->reconnect_time = reconnect;
+        s->reconnect_ms_max = reconnect * 1000;
+        s->reconnect_ms = SOCKET_CHARDEV_RECONNECT_MS_MIN;
         tcp_chr_connect_client_async(chr);
         return 0;
     } else {
diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
index 0708ca6fa9..f464c4c1c7 100644
--- a/include/chardev/char-socket.h
+++ b/include/chardev/char-socket.h
@@ -33,6 +33,8 @@
 
 #define TCP_MAX_FDS 16
 
+#define SOCKET_CHARDEV_RECONNECT_MS_MIN 5
+
 typedef struct {
     char buf[21];
     size_t buflen;
@@ -74,7 +76,8 @@ struct SocketChardev {
     bool is_websock;
 
     GSource *reconnect_timer;
-    int64_t reconnect_time;
+    int64_t reconnect_ms_max;
+    int64_t reconnect_ms;
     bool connect_err_reported;
 
     QIOTask *connect_task;
-- 
2.34.1


