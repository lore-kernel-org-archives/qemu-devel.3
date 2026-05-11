Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F73CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8P-0001pP-Nm; Mon, 11 May 2026 16:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8O-0001p0-Kg
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8N-0001so-1f
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0f2D20iVt6N9YxgaBkpD02MX+ftT9HJHZr6qxmzRDNA=;
 b=iCdsqvkR9bLB/ccimb/lY+5N9PM1ORJaKlICdcfjb8DYZPQLw7I5LqUa9Dk/UJ5pevZ+/q
 UWUVxXUKNzkzm5iKbiAhrSFmCwzAkCoDdU/3qovl8kWtJcewL8I6VULDXngirPDD4ZZnbX
 c6Sc4QA85z2L6n5vthlOo4JVKVzz2a8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-7s_tsCe0N8--j4spPsIjHw-1; Mon,
 11 May 2026 16:21:44 -0400
X-MC-Unique: 7s_tsCe0N8--j4spPsIjHw-1
X-Mimecast-MFC-AGG-ID: 7s_tsCe0N8--j4spPsIjHw_1778530903
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04EBE1956094; Mon, 11 May 2026 20:21:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D08A218004A3; Mon, 11 May 2026 20:21:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/24] net/colo-compare: guard finalize against uninitialized
 state
Date: Tue, 12 May 2026 00:20:51 +0400
Message-ID: <20260511202111.3091440-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

colo_compare_finalize() assumes the object was fully set up by
colo_compare_complete(), but a bare object_new() followed by
object_unref() skips the complete callback entirely.

This causes two crashes:
- qemu_mutex_destroy on the static event_mtx which was never
  initialized (colo_compare_active is false)
- qemu_bh_delete(NULL) and iothread dereference when s->iothread
  is NULL

Guard the event_mtx teardown with colo_compare_active, and the
iothread-dependent cleanup with an s->iothread NULL check.

Fixes: 45942b79b9f8 ("net/colo-compare.c: Check that colo-compare is active")
Cc: peterx@redhat.com
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index abc1326b704..823b8aa323c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1416,7 +1416,7 @@ static void colo_compare_finalize(Object *obj)
             break;
         }
     }
-    if (QTAILQ_EMPTY(&net_compares)) {
+    if (colo_compare_active && QTAILQ_EMPTY(&net_compares)) {
         colo_compare_active = false;
         qemu_mutex_destroy(&event_mtx);
         qemu_cond_destroy(&event_complete_cond);
@@ -1431,30 +1431,29 @@ static void colo_compare_finalize(Object *obj)
     }
 
     colo_compare_timer_del(s);
+    g_clear_pointer(&s->event_bh, qemu_bh_delete);
 
-    qemu_bh_delete(s->event_bh);
+    if (s->iothread) {
+        AioContext *ctx = iothread_get_aio_context(s->iothread);
 
-    AioContext *ctx = iothread_get_aio_context(s->iothread);
-    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
-    if (s->notify_dev) {
-        AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
-    }
+        AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
+        if (s->notify_dev) {
+            AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
+        }
+
+        /* Release all unhandled packets after compare thread exited */
+        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+        AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
 
-    /* Release all unhandled packets after compare thead exited */
-    g_queue_foreach(&s->conn_list, colo_flush_packets, s);
-    AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
+        object_unref(OBJECT(s->iothread));
+    }
 
     g_queue_clear(&s->conn_list);
     g_queue_clear(&s->out_sendco.send_list);
     if (s->notify_dev) {
         g_queue_clear(&s->notify_sendco.send_list);
     }
-
-    if (s->connection_track_table) {
-        g_hash_table_destroy(s->connection_track_table);
-    }
-
-    object_unref(OBJECT(s->iothread));
+    g_clear_pointer(&s->connection_track_table, g_hash_table_destroy);
 
     g_free(s->pri_indev);
     g_free(s->sec_indev);
-- 
2.54.0


