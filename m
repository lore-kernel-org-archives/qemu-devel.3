Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561D2F33A74
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9e3-00045m-Hh; Thu, 05 Mar 2026 09:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dv-00041a-Al
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:35 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dt-0001nZ-OA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:35 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ae505619baso26993005ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720732; x=1773325532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdigDcQJ2b/2bVVEI5tmJxidwZgL6jyJz4Z/AuSn8To=;
 b=kPmG159ec4BE51ey0rfRwcwh0ZVeXQJwFcAdW4M9LqQL+eui35RurhYkerThWNqzwv
 kwWOAyQuBicH0vRBve8WfnURzXnwKYvV4AMlkHobr+g0x02xlWWPkfwTA4FIHjEAxZKs
 2PGB/mCk+mg9OE3UNuMnu3kNXWjjjkP9gqpzMhhQQl4lZo7RNOGRHU/zVSQj8A7Ra1eq
 jMlq760/AB5vVLzbJjCFe7qkTriZRGj4yvlqIxEjr/7hw7XghMm8f0858Sl7Ofa/27Pq
 SnWf47yV/YXfYYUw61D5VL/fRf2JpwfDiVVavbw7rbkRElhXEgAQ8ANifNsABeLT76sH
 MMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720732; x=1773325532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IdigDcQJ2b/2bVVEI5tmJxidwZgL6jyJz4Z/AuSn8To=;
 b=ClLEVh5iaEiquVSpuVYI6I8uVnSX30J+NTTHKx2N4TE429EFTpjKVTCgedR43VSmC9
 Pbmfqsspuzv4SO3sD1I+soj0iGRaSqAyay+uuc2fvzaTZuoNhu1CCFRiYH4SYDKlXvPq
 fiEC1HQ7iC0jVQxoFmNU+f7Em3oso23NU8Ay3SDhUpzf8Cytnv0yDedCK1pijtCnzN03
 QAY3H87jKvlPLM0pUl7FvARwtCJ+yMD/y57H/THVMr7gdTt0SuUbNx0aAPnjTT1wPwLj
 CoO7HFTX7QgQY6Tyla6TD8wIJn04aBm6X+3EjXBl1raIXVabBC/JbFdI8tIlKzUKaAw9
 5dpg==
X-Gm-Message-State: AOJu0Yzetduh7UuzUOSNFvMa9H78Ru65zFoVvA0YqT4ACDCtfT6cCQNW
 /6F80HPTOHjAt0OR4f3vc+K5u/tA+ZZjoy9RusqzZ67mVpNs3o3sr7WDD+f7qQCLdbawEQ==
X-Gm-Gg: ATEYQzy8gU/potXfDNuaR5hqtfKsu3CEEjBxA6CyZqXJuw2IIweXV/D6eCRQGzyLXMY
 IfyzvqmtSFZoyQ+Z8b7cms5ufQMLr9wA09DpFx6HY50ItMAsXyDFAUuwEj0Bld01tsYa+7qGJ7I
 ILQy1pdg5VJYk5TGJXGubkUgsy/xwtPlesG0J/151YRq7rfnHwzTFstcJfTbCSu1b1hvyDnYZrK
 +tMYT9ee/TclzRVff1TNZw/gNWoPq+w7UcEJ58JbBAj00Hyk3SBUSl4FTGqMqo5wol1mW/rNuz3
 g/+MTxD6u4nIffOkIvv6KdArO6ag7FrfRuG8vqdq4rVCEZM1v+3ojqLUaZP1Yzv+1O0CJSzsJgR
 OTy3USHG54oY34iQI6xu66U5q2rk2vN5Z1I0ATUgBo6b5rKZmKeyBYYg89S2sZFrNIANGr+qqpc
 fiXKjGh/xYWYcux94O602jLiq+uaE01PLc12K2jF1lKADKhQ/vbtA4k3jh+CLjInHxoEAuE8RQ8
 OMmIw==
X-Received: by 2002:a17:903:1508:b0:2ae:51bb:97f4 with SMTP id
 d9443c01a7336-2ae6ab42f0amr55522725ad.49.1772720731860; 
 Thu, 05 Mar 2026 06:25:31 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:31 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 07/13] net/colo: track IOThread references using path-based
 holder
Date: Thu,  5 Mar 2026 22:24:53 +0800
Message-ID: <20260305142459.52559-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
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

Convert colo-compare to use the iothread_get_aio_context() and
iothread_put_aio_context() APIs. This ensures that IOThread
references are tracked using the COLO object's canonical QOM path
as the holder ID.

Changes:
- In colo_compare_iothread(), acquire the AioContext with the object
  path and pass the context to colo_compare_timer_init() to avoid
  redundant reference counting.
- In colo_compare_finalize(), use the object path to release the
  IOThread reference.
- Properly manage the lifecycle of the canonical path string with
  g_free() to avoid memory leaks.

This refactoring improves IOThread lifecycle traceability and aligns
the code with modern QEMU iothread reference management patterns.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/colo-compare.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c356419d6a..43addb5f00 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -924,10 +924,8 @@ void colo_notify_compares_event(void *opaque, int event, Error **errp)
     qemu_mutex_unlock(&colo_compare_mutex);
 }
 
-static void colo_compare_timer_init(CompareState *s)
+static void colo_compare_timer_init(CompareState *s, AioContext *ctx)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-
     s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
@@ -968,8 +966,9 @@ static void colo_compare_handle_event(void *opaque)
 
 static void colo_compare_iothread(CompareState *s)
 {
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    object_ref(OBJECT(s->iothread));
+    char *path = object_get_canonical_path(OBJECT(s));
+    AioContext *ctx = iothread_get_aio_context(s->iothread, path);
+
     s->worker_context = iothread_get_g_main_context(s->iothread);
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
@@ -984,8 +983,10 @@ static void colo_compare_iothread(CompareState *s)
                                  s, s->worker_context, true);
     }
 
-    colo_compare_timer_init(s);
+    colo_compare_timer_init(s, ctx);
     s->event_bh = aio_bh_new(ctx, colo_compare_handle_event, s);
+
+    g_free(path);
 }
 
 static char *compare_get_pri_indev(Object *obj, Error **errp)
@@ -1408,6 +1409,7 @@ static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
     CompareState *tmp = NULL;
+    char *path = object_get_canonical_path(OBJECT(s));
 
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
@@ -1434,11 +1436,17 @@ static void colo_compare_finalize(Object *obj)
 
     qemu_bh_delete(s->event_bh);
 
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
+    /*
+     * Use the device's canonical path as the holder ID to track IOThread
+     * usage and ensure the AioContext remains valid during the device's
+     * lifecycle.
+     */
+    AioContext *ctx = iothread_get_aio_context(s->iothread, NULL);
     AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
     if (s->notify_dev) {
         AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
     }
+    iothread_put_aio_context(s->iothread, path);
 
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
@@ -1456,6 +1464,7 @@ static void colo_compare_finalize(Object *obj)
 
     object_unref(OBJECT(s->iothread));
 
+    g_free(path);
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
-- 
2.49.0


