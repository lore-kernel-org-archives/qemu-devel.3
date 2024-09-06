Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC41CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWwC-0001Pq-Nd; Fri, 06 Sep 2024 07:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvj-0008RX-Qe; Fri, 06 Sep 2024 07:15:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvg-0007lF-Du; Fri, 06 Sep 2024 07:15:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C6FC38C484;
 Fri,  6 Sep 2024 14:12:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C86AF1336EE;
 Fri,  6 Sep 2024 14:13:25 +0300 (MSK)
Received: (nullmailer pid 353604 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sergey Dyasli <sergey.dyasli@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 20/69] Revert "qemu-char: do not operate on sources
 from finalize callbacks"
Date: Fri,  6 Sep 2024 14:12:29 +0300
Message-Id: <20240906111324.353230-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sergey Dyasli <sergey.dyasli@nutanix.com>

This reverts commit 2b316774f60291f57ca9ecb6a9f0712c532cae34.

After 038b4217884c ("Revert "chardev: use a child source for qio input
source"") we've been observing the "iwp->src == NULL" assertion
triggering periodically during the initial capabilities querying by
libvirtd. One of possible backtraces:

Thread 1 (Thread 0x7f16cd4f0700 (LWP 43858)):
0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
1  0x00007f16c6c21e65 in __GI_abort () at abort.c:79
2  0x00007f16c6c21d39 in __assert_fail_base  at assert.c:92
3  0x00007f16c6c46e86 in __GI___assert_fail (assertion=assertion@entry=0x562e9bcdaadd "iwp->src == NULL", file=file@entry=0x562e9bcdaac8 "../chardev/char-io.c", line=line@entry=99, function=function@entry=0x562e9bcdab10 <__PRETTY_FUNCTION__.20549> "io_watch_poll_finalize") at assert.c:101
4  0x0000562e9ba20c2c in io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:99
5  io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:88
6  0x00007f16c904aae0 in g_source_unref_internal () from /lib64/libglib-2.0.so.0
7  0x00007f16c904baf9 in g_source_destroy_internal () from /lib64/libglib-2.0.so.0
8  0x0000562e9ba20db0 in io_remove_watch_poll (source=0x562e9d6720b0) at ../chardev/char-io.c:147
9  remove_fd_in_watch (chr=chr@entry=0x562e9d5f3800) at ../chardev/char-io.c:153
10 0x0000562e9ba23ffb in update_ioc_handlers (s=0x562e9d5f3800) at ../chardev/char-socket.c:592
11 0x0000562e9ba2072f in qemu_chr_fe_set_handlers_full at ../chardev/char-fe.c:279
12 0x0000562e9ba207a9 in qemu_chr_fe_set_handlers at ../chardev/char-fe.c:304
13 0x0000562e9ba2ca75 in monitor_qmp_setup_handlers_bh (opaque=0x562e9d4c2c60) at ../monitor/qmp.c:509
14 0x0000562e9bb6222e in aio_bh_poll (ctx=ctx@entry=0x562e9d4c2f20) at ../util/async.c:216
15 0x0000562e9bb4de0a in aio_poll (ctx=0x562e9d4c2f20, blocking=blocking@entry=true) at ../util/aio-posix.c:722
16 0x0000562e9b99dfaa in iothread_run (opaque=0x562e9d4c26f0) at ../iothread.c:63
17 0x0000562e9bb505a4 in qemu_thread_start (args=0x562e9d4c7ea0) at ../util/qemu-thread-posix.c:543
18 0x00007f16c70081ca in start_thread (arg=<optimized out>) at pthread_create.c:479
19 0x00007f16c6c398d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

io_remove_watch_poll(), which makes sure that iwp->src is NULL, calls
g_source_destroy() which finds that iwp->src is not NULL in the finalize
callback. This can only happen if another thread has managed to trigger
io_watch_poll_prepare() callback in the meantime.

Move iwp->src destruction back to the finalize callback to prevent the
described race, and also remove the stale comment. The deadlock glib bug
was fixed back in 2010 by b35820285668 ("gmain: move finalization of
GSource outside of context lock").

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sergey Dyasli <sergey.dyasli@nutanix.com>
Link: https://lore.kernel.org/r/20240712092659.216206-1-sergey.dyasli@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e0bf95443ee9326d44031373420cf9f3513ee255)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/chardev/char-io.c b/chardev/char-io.c
index dab77b112e..3be17b51ca 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -87,16 +87,12 @@ static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc callback,
 
 static void io_watch_poll_finalize(GSource *source)
 {
-    /*
-     * Due to a glib bug, removing the last reference to a source
-     * inside a finalize callback causes recursive locking (and a
-     * deadlock).  This is not a problem inside other callbacks,
-     * including dispatch callbacks, so we call io_remove_watch_poll
-     * to remove this source.  At this point, iwp->src must
-     * be NULL, or we would leak it.
-     */
     IOWatchPoll *iwp = io_watch_poll_from_source(source);
-    assert(iwp->src == NULL);
+    if (iwp->src) {
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
+        iwp->src = NULL;
+    }
 }
 
 static GSourceFuncs io_watch_poll_funcs = {
@@ -139,11 +135,6 @@ static void io_remove_watch_poll(GSource *source)
     IOWatchPoll *iwp;
 
     iwp = io_watch_poll_from_source(source);
-    if (iwp->src) {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src = NULL;
-    }
     g_source_destroy(&iwp->parent);
 }
 
-- 
2.39.2


