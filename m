Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC88DF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQL-000148-K8; Fri, 10 Apr 2026 15:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQK-0000wj-GU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQI-0001f3-RH
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlKFwmWjmC8Lncf18Tdazfm1QoSVzgcnfKazbHyaKp4=;
 b=YHVxxAhF1y0atuY/OByx+3OCcbEWUoULNxKthr2xDAKDSsK6efjOIfmV+azh5yWpM3cA/e
 gKTQyhVhfR0nG5rUniHqC1KNgtHseRX9iq3HqGptuHbapRYQXrqU82d2q8EceC+EH8VnmJ
 xkNM4waIPDyZLTPsxHwPzNmJMKXQJZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-tDXGYv-7ORGlXlUSR0ftFQ-1; Fri,
 10 Apr 2026 15:21:43 -0400
X-MC-Unique: tDXGYv-7ORGlXlUSR0ftFQ-1
X-Mimecast-MFC-AGG-ID: tDXGYv-7ORGlXlUSR0ftFQ_1775848902
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79FB8180034F; Fri, 10 Apr 2026 19:21:42 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AC5A3000C16; Fri, 10 Apr 2026 19:21:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:50 +0400
Subject: [PATCH v2 28/67] ui/console-vc: extract vt100_init() and vt100_fini()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-28-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3601;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Zhp6CmSbOUhHIMaEnP1CemI0/3Yw4E1NhjHME/nu10Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VpE3etBJUMcNi+ptl4BrW55cT9JMcpDHCr
 BOQnQqsii+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5Y9QEAC11lsjNwwM37vnUAH+upQxOaUp62dJNnAiIh0z2IozourdPhmj5j7sSkDpIdTpS14yzUl
 IWncyp75mfwUDLn+mx+8/smy5WkYbIC241ZVt7FmsnaeKEGo/MuIFtaehbMLZe6K011tzcPCjcC
 tJEm/VUu19finhGWPbTnhiyMgExa2RoDMVlB4ZNMvBEhvPF4pet3CLAKcIn2ktDwtNyeevCDnAP
 /KtTrUIH8BAl4xcq04ri5Qf6vU9kf7GLFjH8kmrWYh8PapGRIGAuiqnxNwkdU4NdLpK0bSHvO0e
 +tdLo4Nu2uDZRgontHBV2CUtR6w/6XgKREgLT2/l96ZWUfh5q9SdY5q7gQ8WsRU/UdLHmFfnfVi
 1MPf3Py6c2PS8L6rOi3ThIeaU0t3fbR0eqRz1PmTtktgLe2/KoN7OE4F3bJmkfvKzKqM2NeCJb6
 18c1P0mKC4o3BuPVlM4p+HiGF/R8fd/rmrcASDbXZ+7tmIQfTqqJuZ5DOb1m1wDCuALtnm7Piiz
 9KHIaOBeqOuyTXAtHx/3uyVlmwB2QrlYVXPidErPPoAobH+tNt17erK2/fPVzF4nS9d+nsX/Lxf
 WPMqAjL5M5kVejnoufpBgFa1b5IipjNLa1EHJKejseoFj0DioKoL/7TOdkC2FrZRNQPrlVFlDFz
 sCshkIRZKWSg/wQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Consolidate VT100 initialization and finalization into dedicated
functions, continuing the extraction of the VT100 layer from the
console/chardev code.

vt100_init() gathers the scattered setup (cursor timer, list insertion,
FIFO creation, default attributes, and image) that was previously spread
across vc_chr_open() and qemu_text_console_class_init().

vt100_fini() pairs with it by handling list removal, FIFO destruction,
and cells cleanup, replacing the open-coded QTAILQ_REMOVE in
qemu_text_console_finalize().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 194233f41df..84944f845e1 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1127,12 +1127,19 @@ static void text_console_invalidate(void *opaque)
     vt100_refresh(&s->vt);
 }
 
+static void vt100_fini(QemuVT100 *vt)
+{
+    QTAILQ_REMOVE(&vt100s, vt, list);
+    fifo8_destroy(&vt->out_fifo);
+    g_free(vt->cells);
+}
+
 static void
 qemu_text_console_finalize(Object *obj)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(obj);
 
-    QTAILQ_REMOVE(&vt100s, &s->vt, list);
+    vt100_fini(&s->vt);
 }
 
 static void
@@ -1140,10 +1147,6 @@ qemu_text_console_class_init(ObjectClass *oc, const void *data)
 {
     QemuConsoleClass *cc = QEMU_CONSOLE_CLASS(oc);
 
-    if (!cursor_timer) {
-        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
-    }
-
     cc->get_label = qemu_text_console_get_label;
 }
 
@@ -1209,6 +1212,25 @@ static void text_console_out_flush(QemuVT100 *vt)
     qemu_text_console_out_flush(console);
 }
 
+static void vt100_init(QemuVT100 *vt,
+                       pixman_image_t *image,
+                       void (*image_update)(QemuVT100 *vt, int x, int y, int w, int h),
+                       void (*out_flush)(QemuVT100 *vt))
+{
+    if (!cursor_timer) {
+        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
+    }
+
+    QTAILQ_INSERT_HEAD(&vt100s, vt, list);
+    fifo8_create(&vt->out_fifo, 16);
+    vt->total_height = DEFAULT_BACKSCROLL;
+    vt->image_update = image_update;
+    vt->out_flush = out_flush;
+    /* set current text attributes to default */
+    vt->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    vt100_set_image(vt, image);
+}
+
 static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
@@ -1238,20 +1260,14 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
     }
 
-    QTAILQ_INSERT_HEAD(&vt100s, &s->vt, list);
-    fifo8_create(&s->vt.out_fifo, 16);
-    s->vt.total_height = DEFAULT_BACKSCROLL;
     dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
-    s->vt.image_update = text_console_image_update;
-    s->vt.out_flush = text_console_out_flush;
+    vt100_init(&s->vt, QEMU_CONSOLE(s)->surface->image,
+               text_console_image_update,
+               text_console_out_flush);
 
     s->chr = chr;
     drv->console = s;
 
-    /* set current text attributes to default */
-    s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
-
     if (chr->label) {
         char *msg;
 

-- 
2.53.0


