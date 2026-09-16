Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8D0C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kMc-0002oG-Mg; Wed, 16 Sep 2026 03:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMa-0002eq-QP; Wed, 16 Sep 2026 03:47:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMY-0005Pq-UH; Wed, 16 Sep 2026 03:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544619; bh=fGIfOHo4G3xiBmArlwd/EnZidqgBSF17YDxjakE2cNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=d2F7z5zFbjFV0AvB93nOjC9KveMPKYvvF2D7GAlttzgeQQI6QIzLD0+oklTzfkRDF
 k2IUdRxmutIxzU82G74v2LDK5mitIHPLl4CneWfXDl5yESfJp7m/HgCCVxooTlJNch
 l4H9I40K723SqLd115hTv8uEI43ZG895B1IqHlLUK2QtrzjFW9zO/z8wOMvlzsQCgA
 /AI4PUScMTo86IzxRPfov6uXPlBEYh6csMVSVeBX+6/M/a0VwfKv5XOdUAJlc+tWpF
 Fni1MTC7OV9KzgxTvQv7YLPRPP42akDG6/NCvXTbrpFfyMJgRZEqTzZ6O4B5lpPqw0
 l467cHFn0QCtg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2EF351D55BC;
 Wed, 16 Sep 2026 10:43:39 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B2974429B75;
 Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5BF595A71D; Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 46/49] ui/cursor: make the cursor refcount atomic
Date: Wed, 16 Sep 2026 10:43:04 +0300
Message-ID: <20260916074346.671467-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: "Denis V. Lunev" <den@openvz.org>

A QEMUCursor outlives the call that publishes it and is shared between
threads, but its refcount was a plain int with no single lock covering
every user. qemu_console_set_cursor() takes and drops references from
the main loop under the BQL alone, hw/display/qxl-render.c does so from
the SPICE display worker thread, and ui/spice-display.c does so under
SimpleSpiceDisplay::lock. ui/cocoa.m and ui/dbus-listener.c add two more
threads.

The pair that collides is qemu_spice_cursor_refresh_bh(), which drops
ssd->lock before calling qemu_console_set_cursor(), and the worker
refcounting the same cursor under that lock. A lost increment frees the
cursor while the console still points at it, so the console's next unref
decrements memory the allocator has already handed out again. Locking
ssd.cursor is not enough on its own: with that done, this is the race
that remains.

Assert on the value the decrement observed while here. Dropping a
reference that was never taken used to be silent, because the decrement
lands in the allocator metadata of the freed chunk: nothing is logged,
the object is not freed twice, and the process runs on until some later
allocation walks the damaged free list and faults, arbitrarily far from
the code that caused it.

Fixes: 0b2824e5e48a ("spice: use bottom half instead of refresh timer for cursor updates")
Cc: qemu-stable@nongnu.org
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260903192647.2677279-3-den@openvz.org>
(cherry picked from commit 1063bbb711856353625d78a9c498988470e91b22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/ui/console.h b/include/ui/console.h
index 46b31281850..4ebd28f6af1 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -164,6 +164,15 @@ typedef struct QEMUCursor {
 } QEMUCursor;
 
 QEMUCursor *cursor_alloc(uint16_t width, uint16_t height);
+
+/*
+ * A cursor may be shared between the main loop, a vCPU thread and a
+ * display backend's own thread, so the refcount is atomic and these two
+ * may be called from any of them.  The object itself is not otherwise
+ * thread-safe: take a reference before publishing the pointer anywhere
+ * another thread can reach it, and never dereference a cursor you do
+ * not hold a reference to.
+ */
 QEMUCursor *cursor_ref(QEMUCursor *c);
 void cursor_unref(QEMUCursor *c);
 QEMUCursor *cursor_builtin_hidden(void);
diff --git a/ui/cursor.c b/ui/cursor.c
index 6e23244fbe6..69d27d49a13 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "ui/console.h"
 
 #include "cursor_hidden.xpm"
@@ -103,24 +104,28 @@ QEMUCursor *cursor_alloc(uint16_t width, uint16_t height)
     c = g_malloc0(sizeof(QEMUCursor) + datasize);
     c->width  = width;
     c->height = height;
-    c->refcount = 1;
+    qatomic_set(&c->refcount, 1);
     return c;
 }
 
 QEMUCursor *cursor_ref(QEMUCursor *c)
 {
-    c->refcount++;
+    qatomic_inc(&c->refcount);
     return c;
 }
 
 void cursor_unref(QEMUCursor *c)
 {
+    int refcount;
+
     if (c == NULL)
         return;
-    c->refcount--;
-    if (c->refcount)
-        return;
-    g_free(c);
+
+    refcount = qatomic_fetch_dec(&c->refcount);
+    assert(refcount > 0);
+    if (refcount == 1) {
+        g_free(c);
+    }
 }
 
 int cursor_get_mono_bpl(QEMUCursor *c)
-- 
2.47.3


