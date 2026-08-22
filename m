Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D88BC5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMV-0003qk-5Y; Sat, 22 Aug 2026 17:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMP-0003jb-Gh
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMN-0000je-6L
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so2407728b3a.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434477; x=1788039277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lKz22n5M1p9e+lq2eACw61LK9eCTpfpP/G3iYA7eH9E=;
 b=glU/gbJRKxHaruv+rFDFqLLPNO3rS7RM7rQoBT3LuuKEiem8+MU8aBRaXHkyEyaOvp
 YeY4RCkfU/sYnyPmWrdkt0ZXYZzrIpZedL0Ov3yx748abqZ0pqBgzRU59biDkTzSNsa8
 GwzG9q5rHMsqNIprbcaual2ebNlUkaCzlxMH6EbX3rFXr2s6aAGBEPI52SoDakEzdILe
 ji1Mz+CRVJs09rnnt3TVLpNJLQ0Wwx3Rp3dunc8XDZCO25pSwuP9OqxZCJzf53H/uM+n
 Axr5b56ZbwQjKIaDidE7CzCciuhHEGUU+km+LdO/OYiSUlWHnEYKJZgkmQ8kCqJ8njKI
 tlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434477; x=1788039277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lKz22n5M1p9e+lq2eACw61LK9eCTpfpP/G3iYA7eH9E=;
 b=r1pYb/DTpKpGDf8Y7gXiUaeSc41gVWKfR+1BQoQ8WUCuLVNAIY08ZWi1ob04i87uwe
 0aUN8lsdmuzF6/ODhIVoIS+pvLiSbneIiTEQUP+gCmL6upUOPCYZAcfN7AMYeMs1cLmJ
 92o3xQQX1TSdNqJJ321rFWxf0m7ftAUu8zcaL2DxpBtFiC/Xl2POxDUz3UVURspsnGnL
 HYEj/c9xJViuPHpcZPcdYkM4jKWMhabo0zflY8y/qcNJvs9UEe7sBuXE0uXXsPVfzjqf
 2+5Gwj04a743pcGkL7MA4P0QshIWTLmGYfik/7md4i58k8cjEtFu8UKwAM0ApRz7uOAv
 Y4gQ==
X-Gm-Message-State: AFuF++ldVDJu42GAgFIftPHyfmG1TWq9qRqdMCR5/EMzJYDeNyGricU3
 oslW4PoU35SLvqU7A2etqPxLv6z9Wz7Q8sApK/8kEwbyXt0Zbg3mZHJ4SIVMrWX5+gOAHcrw
X-Gm-Gg: AR+sD107eVkOBYWdaOfrMgXl2TIdDq65k/FYYGaUOW5SM7FYjdDFp5h2uv3xMYk6gnt
 /RMc8S9g4xwB4Eizwaug/DJLTQUNhsSZopn91ZpccqCg7gQiQ2hvMn0jSDE4QgYgW0YeqiW89ZZ
 PT0+2cU+e68RFzZNjyOPuHx0YFhU2NsB7EDpzciNsVM7Kuh8c7S/kx0OjHJ7oRxXmxepqq4OLAy
 WDzuT2+IvaFXIN3QEwDJN0g9kBazumIMU8/UDJ8nL17+KApw2pcg31htUuQRURTkpjUms6cR1ww
 WzPTWlLsFF4EiTV5RHRCtqgbOlrGIrwvvIukYh0seD8WSKrJNh/mH13MJnIXK5W0tB9HWMt2mqw
 ZPO2F38L1vDfwiWE0Ommm/1eO6E7Xelkf/hJewuUQI8RlLjHtM9hnUxwr7q+b0cozFFrjMzMtI/
 deyJc6x55PZAjmalEg4LIZTGTgXZeLkwzcf9Bcqx2z5mG7iNkwhAx34i7m4VErW2DWUHWJ3VTUE
 xQUkjnJNFqy1UlGhaY=
X-Received: by 2002:a05:6a21:482:b0:3bf:9bd9:cf60 with SMTP id
 adf61e73a8af0-3cd14d30051mr27930190637.6.1787434476675; 
 Sat, 22 Aug 2026 14:34:36 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:36 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 09/15] net/colo: track IOThread references using
 path-based holder
Date: Sun, 23 Aug 2026 05:33:32 +0800
Message-ID: <20260822213343.661939-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x429.google.com
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
2.55.0


