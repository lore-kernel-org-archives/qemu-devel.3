Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F04CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrbi-0000gO-U8; Mon, 04 May 2026 07:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbN-0008VB-Ax
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbL-0000xB-HC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+iCE38jqlJCBLLcHpTqZ9+JVULDCpuuOY0DmjcBZNX0=;
 b=BOEcFusAkH/VBPCTZyTn6XyY+uQ2jn5h9RFpbR63kbdCQqL6l1N7LXy/7jVyntL597skzM
 /7Mv3L9KZuf1luHA0bAAxk6fgW7FHADHPr7a/evWSKvSPf9RtD79WBj/QZCVqkwWg+eEJq
 XMsxxE8/CuGoL2Q3TG8b891hw7C1ccU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-LlMReqR3NvK4PTAI2A0i8A-1; Mon,
 04 May 2026 07:36:35 -0400
X-MC-Unique: LlMReqR3NvK4PTAI2A0i8A-1
X-Mimecast-MFC-AGG-ID: LlMReqR3NvK4PTAI2A0i8A_1777894594
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5E3C18002CA
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58A7419560A6; Mon,  4 May 2026 11:36:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:02 +0400
Subject: [PATCH v2 14/46] net/colo-compare: guard finalize against
 uninitialized state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-14-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 peterx@redhat.com, Peter Xu <peterx@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3019;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZF3TTPjvQzahlqd48t2i0EXIpqN0l7MjdPJ+auYGt8Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsZoHtXsl7/p/bMftfDtmG6o5dxrTlnuorF
 9Nn6p+gRZ+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5WhRD/9Io3z5CxnKgzdQzwLchLrExLXrbExVDg5J1QxcusG04SiVp3fdkomxEQqj78G8xIFzUXV
 zOogkSONWpW//0HsAgV/i+VbslwhJ6npnQYgkHKt9Dy/ayTMbNjhJyI1lUFiMBq88kONbj6m0vB
 qkBwfuyc0UCGQyyqhW0VCeUiYvgLXPuT3YH4rFDUkpP/QXuuM3BxZaMBzVkU9mySfxqesLgwj8k
 scJGFg3VoKT6T+CybUJ0Q3aUsimnx2y4d6mK831AJAcnpcrvh87HXejELRYguQqjDQL7VSBWYHf
 vb2zoRxUAxlwckF6AyyQT0zL5r6OFcQwYtqzOK5qhRfwQuRLcpRrK0QqA54R0ILvrc8InRg3SJz
 btDivouHrXiMYVawVDgyOpVu4sbauT52YC7XxsFUr1mPaqf/5BbJqL8wCSv92vJErw/47o7LYf/
 XnF5gLz4olifXRyDHZuzhzPpBEanI/Aqo3b1LiGwcBKIWUBQsRO8HYxQinj7yeyB5QRlx8nGsJH
 WKa3PvICT98X5c7VSfcZQlEvhzQfE8SW7AVnaEJCAZJlO61g67njaSxze81SCLVTcmtA+EvTkQZ
 do4BdXcPoVk+iX1Q8Q6oWYK037wrnhjnjVfAhd9zatCRtU+70TFmEumYZWLxdvL8Wcd2l3SM7Lb
 yOIsCS1DGEZOZjw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
Acked-by: Peter Xu <peterx@redhat.com>
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
2.54.0


