Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2871CFC51E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 09:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcwg-0001vk-DN; Fri, 21 Nov 2025 21:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbyy-0000Q5-ST; Fri, 21 Nov 2025 20:00:08 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbyn-00028R-Dg; Fri, 21 Nov 2025 20:00:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB5FC16CA49;
 Fri, 21 Nov 2025 21:44:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A6BE9321C85;
 Fri, 21 Nov 2025 21:44:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Grant Millar | Cylo <rid@cylo.io>, Eric Blake <eblake@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 14/81] io: fix use after free in websocket handshake
 code
Date: Fri, 21 Nov 2025 21:43:13 +0300
Message-ID: <20251121184424.1137669-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

If the QIOChannelWebsock object is freed while it is waiting to
complete a handshake, a GSource is leaked. This can lead to the
callback firing later on and triggering a use-after-free in the
use of the channel. This was observed in the VNC server with the
following trace from valgrind:

==2523108== Invalid read of size 4
==2523108==    at 0x4054A24: vnc_disconnect_start (vnc.c:1296)
==2523108==    by 0x4054A24: vnc_client_error (vnc.c:1392)
==2523108==    by 0x4068A09: vncws_handshake_done (vnc-ws.c:105)
==2523108==    by 0x44863B4: qio_task_complete (task.c:197)
==2523108==    by 0x448343D: qio_channel_websock_handshake_io (channel-websock.c:588)
==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==  Address 0x57a6e0dc is 28 bytes inside a block of size 103,608 free'd
==2523108==    at 0x5F2FE43: free (vg_replace_malloc.c:989)
==2523108==    by 0x6EDC444: g_free (gmem.c:208)
==2523108==    by 0x4053F23: vnc_update_client (vnc.c:1153)
==2523108==    by 0x4053F23: vnc_refresh (vnc.c:3225)
==2523108==    by 0x4042881: dpy_refresh (console.c:880)
==2523108==    by 0x4042881: gui_update (console.c:90)
==2523108==    by 0x45EFA1B: timerlist_run_timers.part.0 (qemu-timer.c:562)
==2523108==    by 0x45EFC8F: timerlist_run_timers (qemu-timer.c:495)
==2523108==    by 0x45EFC8F: qemu_clock_run_timers (qemu-timer.c:576)
==2523108==    by 0x45EFC8F: qemu_clock_run_all_timers (qemu-timer.c:663)
==2523108==    by 0x45EC765: main_loop_wait (main-loop.c:600)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==  Block was alloc'd at
==2523108==    at 0x5F343F3: calloc (vg_replace_malloc.c:1675)
==2523108==    by 0x6EE2F81: g_malloc0 (gmem.c:133)
==2523108==    by 0x4057DA3: vnc_connect (vnc.c:3245)
==2523108==    by 0x448591B: qio_net_listener_channel_func (net-listener.c:54)
==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==

The above can be reproduced by launching QEMU with

  $ qemu-system-x86_64 -vnc localhost:0,websocket=5700

and then repeatedly running:

  for i in {1..100}; do
     (echo -n "GET / HTTP/1.1" && sleep 0.05) | nc -w 1 localhost 5700 &
  done

CVE-2025-11234
Reported-by: Grant Millar | Cylo <rid@cylo.io>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit b7a1f2ca45c7865b9e98e02ae605a65fc9458ae9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index e180827c57..6700cf8946 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -61,7 +61,8 @@ struct QIOChannelWebsock {
     size_t payload_remain;
     size_t pong_remain;
     QIOChannelWebsockMask mask;
-    guint io_tag;
+    guint hs_io_tag; /* tracking handshake task */
+    guint io_tag; /* tracking watch task */
     Error *io_err;
     gboolean io_eof;
     uint8_t opcode;
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 5c0df9d6af..7f8eded4ff 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -545,6 +545,7 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
+        wioc->hs_io_tag = 0;
         return FALSE;
     }
 
@@ -560,6 +561,7 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
             trace_qio_channel_websock_handshake_complete(ioc);
             qio_task_complete(task);
         }
+        wioc->hs_io_tag = 0;
         return FALSE;
     }
     trace_qio_channel_websock_handshake_pending(ioc, G_IO_OUT);
@@ -586,6 +588,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
+        wioc->hs_io_tag = 0;
         return FALSE;
     }
     if (ret == 0) {
@@ -597,7 +600,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
     error_propagate(&wioc->io_err, err);
 
     trace_qio_channel_websock_handshake_reply(ioc);
-    qio_channel_add_watch(
+    wioc->hs_io_tag = qio_channel_add_watch(
         wioc->master,
         G_IO_OUT,
         qio_channel_websock_handshake_send,
@@ -907,11 +910,12 @@ void qio_channel_websock_handshake(QIOChannelWebsock *ioc,
 
     trace_qio_channel_websock_handshake_start(ioc);
     trace_qio_channel_websock_handshake_pending(ioc, G_IO_IN);
-    qio_channel_add_watch(ioc->master,
-                          G_IO_IN,
-                          qio_channel_websock_handshake_io,
-                          task,
-                          NULL);
+    ioc->hs_io_tag = qio_channel_add_watch(
+        ioc->master,
+        G_IO_IN,
+        qio_channel_websock_handshake_io,
+        task,
+        NULL);
 }
 
 
@@ -922,6 +926,9 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encinput);
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
+    if (ioc->hs_io_tag) {
+        g_source_remove(ioc->hs_io_tag);
+    }
     if (ioc->io_tag) {
         g_source_remove(ioc->io_tag);
     }
@@ -1222,6 +1229,9 @@ static int qio_channel_websock_close(QIOChannel *ioc,
     buffer_free(&wioc->encinput);
     buffer_free(&wioc->encoutput);
     buffer_free(&wioc->rawinput);
+    if (wioc->hs_io_tag) {
+        g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
+    }
     if (wioc->io_tag) {
         g_clear_handle_id(&wioc->io_tag, g_source_remove);
     }
-- 
2.47.3


