Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8856FF886F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsC-0001nC-69; Mon, 27 Apr 2026 15:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrr-0001Od-9M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRro-0007tu-7J
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VqF0c2mTa8FvKXeY4elAFuahUQbbqA9YzOgLwlQqoY=;
 b=isqVzbNtiZ3DuP3CCjWi3HkPo9B48bHWjwQuiS7cPqaGJZP1qjsm9Xd9Umd0iocMXrUrLU
 wOwHZXHEp/OXMqQmf3flCo+m79JvxBAKGMarptWvP2wauTNlTD6P1Ioi5jwA0gb/ox2Bf5
 Dflm03FwvP1IdId2AxMbZev0KYmZaGc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-i_E1BIMSOvawB08oIqZ-Lg-1; Mon,
 27 Apr 2026 15:43:38 -0400
X-MC-Unique: i_E1BIMSOvawB08oIqZ-Lg-1
X-Mimecast-MFC-AGG-ID: i_E1BIMSOvawB08oIqZ-Lg_1777319017
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35DA0195608F; Mon, 27 Apr 2026 19:43:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 384F3180045E; Mon, 27 Apr 2026 19:43:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:11 +0400
Subject: [PATCH 12/41] RFC net/colo-compare: guard finalize against
 uninitialized state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-12-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 peterx@redhat.com, Zhang Chen <zhangckid@gmail.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2979;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kxmSjH+HqdSVTIPt3wYQYv2C7Vi1QsvEwdqKLo4jzD4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUjI9iWiFZPPEqnmLGNs8xkazFOZ8KyIhMQ
 wZxmU0YFzyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5QA4EACzV/hk+sozwkWT0flUZLm5udNENR8k0XbsMTDlqYn4O8VhAOAw54vV6tdQChhyl3W9Vtc
 IGGNKH/+yNk1eTKq0pM54avHNHCbnaxCjTCsbr3sfMtNnLZGMRMCS0VeqJtHE+0IS7RpvoxmrbW
 aJheLRu9vTAVzn4gZeehJ/65R9E3onxFQB70La3ekrc6+l6j/jO0DglxgimGcl9ozZsXPPNYPAN
 BZ1r/uxMsmNkyH45Tgb/KGGyxyJPU4bQqgT86ATxr7AOKBsUChBvRsdSKawjDsBNYB5Nd3Olj+K
 eaymbeFnuFiHFps2PBLvQzuY++zJhqmW1w6bdAXZS8USZdbkmJdVYRGq+6Tj/8q8k5OAOlLUn0i
 vuzckHxc8SzDMErJcwR00YXDaHMpfXKtbGVPh/xXYza+cIadhZHmtBUxWitaDwR4BXi5qJP0uM+
 wb3JStnTY5m1i/NwX0CZPoVjagjsViG5nhlLcM/tIEAIFC8aBc4pv8PmHMWOWAo7uTXa3S0t0Cq
 ZL4YZm+3RKTEMk7HMZdSix1a3/eqfSwW6Op1jt1YPOPAx887wM/kb0DCKymmVlT6DqnjrJCIv0E
 u0TO8DLTLJFS3FlhnKqF4mxcZ8OMmUnI8JVUPtGO14RfzXmEIRrzyYPBb8e/J5J1pSmmXNsS+tu
 bv7EkBC4Ml96FsA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is an alternative to patch "colo-compare: Fix QMP
qom-list-properties crashing", sent earlier, hence the RFC.

Fixes: 45942b79b9f8 ("net/colo-compare.c: Check that colo-compare is active")
Cc: peterx@redhat.com
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c356419d6a8..be819db06c9 100644
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
2.53.0


