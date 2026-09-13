Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AAAC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hfr-0005cy-CJ; Sun, 13 Sep 2026 06:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfq-0005cq-MV
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfp-0008B9-2c
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z93E6IXBNGFUNnjsorYP5n1hNGuSXYTnO5wPKuWfQeQ=;
 b=XksNKpFuhSAlfBnXYrWKQldzpnrSsnaKpCFkT1Fv4F/gvQ4TF1rOTlUG7j6FahNO6Yc3i3
 mN98a4WLG/D73blc2j6lgYw+lRDRIbVuvLFWAJcJMwNSlJkSXE07Eqp1NjBQPP7EVb8xGv
 IdWYI/Yt2sMWbdjX7LI4/1GaG0pFgrQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-_THofeDjP9OTKN9Aqod12A-1; Sun,
 13 Sep 2026 06:42:58 -0400
X-MC-Unique: _THofeDjP9OTKN9Aqod12A-1
X-Mimecast-MFC-AGG-ID: _THofeDjP9OTKN9Aqod12A_1789296177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 813521944DD2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:42:57 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 800221956088; Sun, 13 Sep 2026 10:42:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:21 +0400
Subject: [GIT PULL 03/14] ui/cursor: make the cursor refcount atomic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-3-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3607;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SyVY5i1CXa5BvoxxYtEGH1+tIIfPubg1hJOzybxXK5Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4iVV8DB/1dvXrKNbDFtx0aaPU286QGZsvUI
 H3E6NoLqkOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5fR6D/sEhbIlTZTMAWOXxTNYd+UIoJ4qBh1uas0lXvYI2yKwtvIvcBI9bU0tU3Mntp6LAMUIGya
 BREGuX19Tx4ApaAyWCYyuJrvXs3B+O6Fl8TLX6vWJAPp2kCFNt1K13Ph3QtxP+RMP21Zm77OsWe
 Gxgv5RUMQVEyGC3i4mpKvVhvf7OkFhnEjNSPjdbxXag3hAUB/1fP++bD4dOHR4hNOoWT3IXOlLw
 NeEmyi/KepoDxZb+98LOPpJkGswSizM3WRa1CxDCDTWcDRQ8AfZWdRwNeQe5neYrtFUHcqBA4Ek
 XScAlgaUN5w9r48AdfSVo3bkTvVkFEyDhNQ1NAFVtE0z5nXr6JL084EdzEqkfbVYvhNQ7HS1xX9
 lYY+kjmIBiM1HxCLBmBqHqeDqWcCUoEw96gHyI+mTFd6DjSlSNQdpyjf/KcrWFkFDNCQD2H5Ezn
 8krSs6T/FntW1cywLAe77CKq+oBwB1FUcwDdVwOkJRud9kiTdAKB3eLj/blgSkUYwo2kp9XhqLD
 UR8Dva5pc3GNeigkiSIQCPFNuJByTDir4k4tjBOwSe7jLAsaFYr9S1Hd2INCshl7MRYQVWbRVAq
 rm0pOVIyHgq8L2NnwYE6KErCTrHgtFgbjKw/lBisxGZPNSjIOBNmGmhzcd8FU7HOtHgFJMLvJOP
 YVa7QPyQDHgWrKw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 include/ui/console.h |  9 +++++++++
 ui/cursor.c          | 17 +++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 29bf72288833..3634956949ac 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -126,6 +126,15 @@ typedef struct QEMUCursor {
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
index 6e23244fbe6b..69d27d49a135 100644
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
2.55.0.543.g5ebe2ebe4ea8


