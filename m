Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D167ECDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHlC-0005oY-6V; Wed, 24 Jun 2026 03:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHk4-0005CX-CP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:51 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHk2-00036J-Pr
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:48 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-37c64d34032so906609a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284985; x=1782889785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3JgrbyUDIxuz3YPnS0kJVMN3cW2e7N1UfUsJRso3As=;
 b=jDJfEHHJnZDzj1aj37hhWZdSQq2+2btowVVNuaoYYrzxHeSbEHDeoqzGlKdWjeipjV
 xsqxekpbpD5AYLqqOwAKQ87jhjSAwORTI2zEj3Ad4RwzMitJ2m8kQwy/HT07YC5AQQs7
 Zzm2fB4xvGfM4aErggG3Gfh1+klla+xhL9bqRa3XqdGJSKW7Qh7IfLUEP++MEBJp/GAM
 jA6+SxUSxvHO/sHzRHtMFq/52F+GcMBPcnolbHscGaULUzd7gpHO6JVvNZalNGgzoVfb
 CjkTgpiVwAsejg0revKIlP//8nE3p3BfmAbmXZyUPFC7XmaYUsyCvS7d+gK1yeKwdgrf
 8Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284985; x=1782889785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3JgrbyUDIxuz3YPnS0kJVMN3cW2e7N1UfUsJRso3As=;
 b=dOgd+mT4omOFkjvFhrSRAWmwg/OVyNCY7Ua+Cj2nDpo9AoPqJ6Aa69RGhqIu8so53E
 2SU3v6AkPdpUiiHXgBTt+PZ+dRelO6Sif3Qkt5bxhQ/R90VJ7S0F4sk0U4xU6/fpYkjV
 odLRBOiTSnNnV5xTUu7YEd3AnnDogARolI6tf4rlvaIwoV24RvaInQZDmJVu0QJHNbsf
 hlt9KoTh0WusfVQd8jbE8/g3e06MQ43zKm3Z5ivdz2ud57Juvbl5MarrZxkE9x+IO9f5
 1mK5RfOOYluXf1OniuhkuoCG6XARY7oC456I2HdnpRVTssqZG5HM+RP/7e/JaQFM6Ber
 oqvQ==
X-Gm-Message-State: AOJu0Yxh2Irf+tUvI/iAqUKRcdgo2wKFzCWRaqzf5qFw3blywimz0zEn
 jqEqAHrDjwdawXPm7dmmSHjZzOsfQvd/T5xb6nJW+ymm9N/3/iYrO8LY8ST1AS7vMsM=
X-Gm-Gg: AfdE7cnULkMc7wppmVmEAYtwo0WME7Blqdf/NPgyfbr7km0WqujHHSxDZI6cWzGH4UI
 oo3DlbJcxyoruFrbcUT6akHCN1noIdWqr2cB7c4yd1mjufI7cSQN3UZOXFJ4HZK6+QwyC6MDeo9
 UCevD9vHFthdpvP31e/0FMPnyWtjqjSI722UmJpz67FYuL+b91AZTUrhujmBVuEqTfSSCW4JuXX
 5qXD7rqksnaKd/xehqYot/76XJYJGHrsfnStxm7NFMk/yPXEd30XBLcCYJsA6ou4DUvCl/C+f9s
 4Hk3VH0D35lBMtrJYhDZqKbDs9klMl/c1akMLpJiFAwl24BWJDxKTbBAFbnj8GPDUM3Yawjtc3+
 Rb6CxU9npegQvwzL1BdDfsaDh4DLexG00t4dM/SHryGiy9tpfKvjWS1VHqWe7B/fyseGoHYWYNE
 pzsyzymrB5B86PiGYIQE2dn5sGHcmwLMykSEmKXjnOb5wYqOl/sXj+
X-Received: by 2002:a17:90b:2692:b0:35a:10b6:1208 with SMTP id
 98e67ed59e1d1-37dcd754648mr5862672a91.14.1782284985325; 
 Wed, 24 Jun 2026 00:09:45 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:44 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 11/17] net/colo: track IOThread references using path-based
 holder
Date: Wed, 24 Jun 2026 15:08:45 +0800
Message-ID: <20260624070851.13342-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102f.google.com
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


