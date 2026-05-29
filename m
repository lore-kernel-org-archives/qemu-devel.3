Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D693CCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4rT-0003v9-MH; Fri, 29 May 2026 17:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4r2-0003cV-4y
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:35:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qw-00030h-1i
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-837b39eb078so9905497b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090460; x=1780695260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3JgrbyUDIxuz3YPnS0kJVMN3cW2e7N1UfUsJRso3As=;
 b=q4ps73xYhbEHbYU+WbMji7y6gLVDPDht+aezMH9MtECE4rcFaL/5uAyEtVmFHq26p4
 U+ebhIg4N9zF67DT0RWTIkV7fAlEjBJ9do527o2AILzhxRey8aW2aaDXoth8guxulVzU
 vMmJrCPHn5b7mge3zijnB6FM07azqftMtCdAY7No0K3juQNJ+yjht4wiL235pfl+8SRQ
 aXPgFfooieX2lRJ85pIG4yX7pXDuj4TrpY7DYu50pgrdYU6QjMNcX85Apbcjwl7gS9no
 dJgV72pAWvhXIwAEjjye7y+zy9b71ZRrZyZ8Z2bM1lw6KnwQv/X6zXZe8SfO/5pGQAhG
 XUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090460; x=1780695260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3JgrbyUDIxuz3YPnS0kJVMN3cW2e7N1UfUsJRso3As=;
 b=Ys7knNKk1Q9JPTPtvRwsTd/54zHEjorePYxkzONB+blsDuuNfRfFPqTcmVgknqYj2U
 Oo2j7C2eVFdoBVJbNu5hV6fU3HlOLymc8vnrxY7f6+qpmHQcpDrDi3tvl0/46j/ut9Td
 TT4wVIGay4Tg9U+voub83hjQCuqNLTKPdaFMW739zam2gmmqAXMayAkh7LzwPULf+SP8
 a2mkDSBr57fzPI4BMmoGAMMu7XYEJuItA3cSWCY3OAYbyKTw3eDr36gvowq/QZ/LAWGp
 F2zAX2cq7IMwA7FwEi5symlSo71MG8b4LGqgxl0UcaOFwEw5Te2Q2K/nnhb9zkCAIKlL
 x+dA==
X-Gm-Message-State: AOJu0YzNMZJLC4cjuikWkfSQxf0QW2UKhooE2C+T3YFgBlMoXyCWE1Wi
 kCvCHbkXT48Hwpcss22tZ++kvtF6CbOrXoOYpW97dPBSyC34X5bcvn8LaU71//lSoZE=
X-Gm-Gg: Acq92OHTjyGKjbTuwRvrdsdJ+BLbzoZBBhkDAd4SEKTjP105QvaRFrXg/sKDHiZwV5q
 HxnAELi9zNvkgnd+SqjTXmsn3GjsFoVdmadJGz0HFU3B9H7SWQedY9i+TXPJ3efru32cJAoaMWp
 MsIB5k4EywYFiagaQW/wNcsVoOn4UwSGGC5fKmz+ZiNaqywfniNl1eEsaznWQcw7sC+nMSra1C9
 WpnxH6ytj5HbCdN7N1g8oDeXZlbhihSNiHiQAG6HZD0Uro/pUSJn/255WP9tQ4sfkuVcHupcF1/
 VVnSRvjZWFVp+OKAULs5GJS1OGz5Qz3Tskm+96rvu8fxkDv14O29TaoilYIqDCKFpl1Py4nP4se
 fzk4wviS24ECl8tNEiB/ZmwFseLP/bIPw0+VsLWyqlMB0Xhl0dYxOGCKaAUrtAub7XmcMfG3Djg
 /Y/9iR0nPYtS/dc0IS/+YApzJ1y47Ocyus+10Ixvw+jMSIRQKHVxPvlPIpuc3NXvg=
X-Received: by 2002:a05:6a00:9087:b0:835:424f:6a83 with SMTP id
 d2e1a72fcca58-842255c37damr1162338b3a.41.1780090460207; 
 Fri, 29 May 2026 14:34:20 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:19 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 10/15] net/colo: track IOThread references using path-based
 holder
Date: Sat, 30 May 2026 05:33:16 +0800
Message-ID: <20260529213321.96271-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Convert colo-compare to use the iothread_ref_and_get_aio_context()
and iothread_put_aio_context() APIs. This ensures that IOThread
references are tracked using the COLO object's canonical QOM path
as the holder ID.

This refactoring improves IOThread lifecycle traceability and aligns
the code with modern QEMU iothread reference management patterns.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 823b8aa323..4f180936e3 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -130,6 +130,7 @@ struct CompareState {
     GHashTable *connection_track_table;
 
     IOThread *iothread;
+    AioContext *iothread_ctx;
     GMainContext *worker_context;
     QEMUTimer *packet_check_timer;
 
@@ -926,9 +927,7 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
 
 static void colo_compare_timer_init(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-
-    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
+    s->packet_check_timer = aio_timer_new(s->iothread_ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
@@ -968,8 +967,15 @@ static void colo_compare_handle_event(void *opaque)
 
 static void colo_compare_iothread(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    object_ref(OBJECT(s->iothread));
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
+    IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)path,
+    };
+
+    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, &io_holder);
+
+    s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
@@ -1408,6 +1414,7 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
     CompareState *tmp;
+    g_autofree char *path = object_get_canonical_path(OBJECT(s));
 
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
@@ -1434,18 +1441,20 @@ static void colo_compare_finalize(Object *obj)
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+        iothread_put_aio_context(s->iothread, &io_holder);
     }
 
     g_queue_clear(&s->conn_list);
-- 
2.49.0


