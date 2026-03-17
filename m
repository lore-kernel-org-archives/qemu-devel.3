Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B6F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QE7-0005Mt-UC; Tue, 17 Mar 2026 04:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBE-0008LN-Br
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBC-0003cX-P5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHs/HBxbOx8cNaTTIgZTyocDDR6sCef4ZHGJ0N76QVE=;
 b=SyBdua/nKss59LLk4qIoknOoddKh9iN26HkN5b731NXlN+3TCYjMvLwhFowaGMiRLQFSrS
 lmkQhnT62lma3b0wbjD961Ia4O+zePkskbgjh22u5z9KgxQ061Gy9X7EfltKFDZgLROEsG
 d8hIUbvjtI3uVMxrWyiHHfXD3AwhNgQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-K6Il0sAHPlaHcrvjCSb-WA-1; Tue,
 17 Mar 2026 04:53:32 -0400
X-MC-Unique: K6Il0sAHPlaHcrvjCSb-WA-1
X-Mimecast-MFC-AGG-ID: K6Il0sAHPlaHcrvjCSb-WA_1773737611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A33721944F0D
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AF75180075B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:44 +0400
Subject: [PATCH 30/60] ui/console-vc: extract vt100_init() and vt100_fini()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-30-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3543;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=00Xoza8JQeEUd9LzojSZBy3M+SiLz9lRDLo7CP78xWI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXb1axGWWa2Ae+PbW5mx6r6fkZmYKsFbAVuA
 +TbeP/zsT6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5Z+0D/9O+cifrHLpR+brvJn7ZFu5bmQrLi8ANo0QtrWYL6Dki1tvVw3YnaXGb0ZvpIL0FC8B/a5
 XX07D8pgdTfE4jjZB7IQLQCwDGsgnNsPbgHaddHDvRCYTZcFebbg0YXWkQJace1ncedrDm9FOTn
 6jUwzZknJqYu91ojD0LsNDkIoQE5V0v58d6DlZzfeV9cTAiw7u7AGYhdyRNvPBnFA3vGpZNqDWw
 vjNLEEA2svVZqASJLLFGB4q6YA7Jnn3mF0jCZ3V/TyFHdwLIGSN/AFPgiTceN7vRCI90xoOMSIa
 2cnwBGMqtivmD1ZSRBikjfJ4JN0A+T1pdUDSZPpbWeRVUzaKkmf/gWTkBSpJkr3oZqiX7KiFq4i
 en+1JiMHesmXpoMOzGZ/tmDmdpx0/+ZDQTxLZuQYgxLoiodyGZsS9VuUWRt78qYqDq+L5c3C8i1
 1CwlGJcAoTncJDQBajMfczKfrGytdrQkWyVh3joSziwoxXdVeuDiou5TEScgEQ9Bis1Dsss4Zs7
 TR6TLjwp8qN4tLUP5IUjLtxGqX3vQygEaFhdtIv26Cfix5uSLQN/UZ2bbdGQK+P2ZQH1ZPV5j/b
 khTv586hbgdd0zj5Oxs5goRyAK4d4wJIgVpU1H3QyBxK4lyuHi5QuJ5mtgPjaXjDnlio8p0Yqjm
 4DCT4axCtwz3TYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Consolidate VT100 initialization and finalization into dedicated
functions, continuing the extraction of the VT100 layer from the
console/chardev code.

vt100_init() gathers the scattered setup (cursor timer, list insertion,
FIFO creation, default attributes, and image) that was previously spread
across vc_chr_open() and qemu_text_console_class_init().

vt100_fini() pairs with it by handling list removal, FIFO destruction,
and cells cleanup, replacing the open-coded QTAILQ_REMOVE in
qemu_text_console_finalize().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index dcd6445a1c3..b30adac83ac 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1128,12 +1128,19 @@ static void text_console_invalidate(void *opaque)
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
@@ -1141,10 +1148,6 @@ qemu_text_console_class_init(ObjectClass *oc, const void *data)
 {
     QemuConsoleClass *cc = QEMU_CONSOLE_CLASS(oc);
 
-    if (!cursor_timer) {
-        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
-    }
-
     cc->get_label = qemu_text_console_get_label;
 }
 
@@ -1210,6 +1213,25 @@ static void text_console_out_flush(QemuVT100 *vt)
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
@@ -1239,20 +1261,14 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
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


