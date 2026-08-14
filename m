Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E3C5DF6A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw1u-0004GY-C3; Fri, 14 Aug 2026 13:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1s-0004GN-ND
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:16 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1r-0007w7-89
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:16 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso1350263a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729754; x=1787334554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B8RUC1JCJT1IGRrGG9rSVZntTX017g3c7OdoveZ6uM8=;
 b=VkWSc5jvdBPxQtDZAAyJ3I4v+19BHH3R4JtZuTmZRAOQepG5m9q+5GghC52RrZ+JQX
 /nlL4HFsYnYhTPJ/1f4I6K7Qm6+vcYW8X8n8TtcIyKNWMReKlouKf/MTT2DyHuujscQS
 258FaBK+Ex0yvrVboIZgUGrhBx9nyRiSwDCuGBs/hBk49HeIbPr3EtK87endAdujAwjW
 9i7oO8VLY39XF4zcjdDam5I7sqh6Jzo1FX7XPfnKGK7dFz+xFRjgFs1eQDb/vTxkzmGQ
 OeF3EK70fdWj/i54RHXI1b0NZTdeZug1CYrQ8ckW3aIgg55VK6nGafoda+/xqqk3AtmE
 VEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729754; x=1787334554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B8RUC1JCJT1IGRrGG9rSVZntTX017g3c7OdoveZ6uM8=;
 b=iK97eEh4z/WjK955CIEpQ8Q4ExAgnkjgsCyfnR9mbfs1wDEZSV6V8jwZ0TgyXA9sJ8
 FhwcvSGrPKMRKFkq+9RqZixVe4skIB/2Mwg5iSdBN0nA7f0ngwlA0EeSqXWEDveRAIpu
 PyFrybddVIV1sCD+muK0w2Zz8xj0ULb0mYRD/XG5TIefu76Ukw0NDRcBZgAenTjSiIcm
 GbjbcWXGTVu2ySJF5O+O3QSGUFfRNmiwop6PvdS5CYQP1ZN5nd+8c6UclQ8KfWSufDce
 THmZFKZ3uLDGNqF/+n+KeRf9XSx/yAsOXbOxpW2nAq22+rxyY3DTz9+CXGNHAHebBfXH
 zpsw==
X-Gm-Message-State: AOJu0YyoRUQIzfVcIePkqJ77YUyIyeEZk3ACNsB/5K+PH2nInVTLsFAT
 y6hkaUjLt+oERh6fp5FjzJHrR/6lClSZJS/gB/QdbdndUq73IETz623KWnkbfw==
X-Gm-Gg: AR+sD13qZf7povaJ+so1NOz8jKnmy9C6TYjziSOFhWwftLl6McAdFF3v+n/AQqvfyp8
 UFYqHoIQ2oijl8yA7U8JClEGTn1C3CvKX/Ia1dagaQvzXuO+Be9MZOZXVTeIwacLoFfFupEVgX6
 hH8pVu+svmmB5PTChWzeqbGC7xL61QajKHLEOoq00NlCeqNgFjZIIyrWOFpjyTY9pz1rHUPd33q
 4EAFDeo5s53qqr21xBFh4DdTgs48TV23K8d5XFsFCSfmNEiEPiNZfyIFILh921cR1Sax5GLGNg6
 1AsNn8LoAfRwr4KzdJi1SMTVxRPa2Xe+Cthjkh54Fhs7qsAteLAfDiWPnw1xrV8u7V47s7zfK1h
 F43B7IBWs5H27uPbM7NK0xMtSXv4DZnIVTbAupLLD98m9Sssn1dT1oL70IXK2eEKuXegJSRU9/U
 DxLelItfL1Rp7e9UYQVkpUd+YV0vPi0Z+bR9w35disZAOnC4r1rlgK0ZGR4Mz9O8vVYCU/X2+U6
 uCv9iez
X-Received: by 2002:a17:90a:d407:b0:38e:4f42:d0d6 with SMTP id
 98e67ed59e1d1-3933b09f4f3mr6139427a91.12.1786729753702; 
 Fri, 14 Aug 2026 10:49:13 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:49:13 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 09/15] net/colo: track IOThread references using
 path-based holder
Date: Sat, 15 Aug 2026 01:48:23 +0800
Message-ID: <20260814174830.1691540-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Convert colo-compare to use the iothread_ref_and_get_aio_context() and
iothread_unref_and_put_aio_context() APIs. This ensures that
IOThread references are tracked using the COLO object's canonical
QOM path as the holder ID.

This refactoring improves IOThread lifecycle traceability and aligns
the code with modern QEMU iothread reference management patterns.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e88..361ee32729 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -130,6 +130,7 @@ struct CompareState {
     GHashTable *connection_track_table;
 
     IOThread *iothread;
+    AioContext *iothread_ctx;
     GMainContext *worker_context;
     QEMUTimer *packet_check_timer;
 
@@ -922,9 +923,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
 
 static void colo_compare_timer_init(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
+    s->packet_check_timer = aio_timer_new(s->iothread_ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
@@ -964,8 +963,15 @@ static void colo_compare_handle_event(void *opaque)
 
 static void colo_compare_iothread(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    object_ref(OBJECT(s->iothread));
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = path,
+    };
+
+    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, &io_holder);
+
+    s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
@@ -1404,6 +1410,7 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
     CompareState *tmp;
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
 
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
@@ -1430,18 +1437,20 @@ static void colo_compare_finalize(Object *obj)
     g_clear_pointer(&s->event_bh, qemu_bh_delete);
 
     if (s->iothread) {
-        AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-        AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+        AIO_WAIT_WHILE(s->iothread_ctx, !s->out_sendco.done);
         if (s->notify_dev) {
-            AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
+            AIO_WAIT_WHILE(s->iothread_ctx, !s->notify_sendco.done);
         }
 
         /* Release all unhandled packets after compare thread exited */
         g_queue_foreach(&s->conn_list, colo_flush_packets, s);
         AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
 
-        object_unref(OBJECT(s->iothread));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
     }
 
     g_queue_clear(&s->conn_list);
-- 
2.54.0


