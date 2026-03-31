Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8613FF60F9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Vn8-0000ua-1c; Tue, 31 Mar 2026 05:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vn6-0000kI-33
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vn4-0008EU-HM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774950821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBM9nkW+r4Seb1KGGXoI8JFaAWn2nmtP93T+sV0Bs4Y=;
 b=flBsSUvW9FLU75ciN6Dyc3wdeCAw+wK1srybd5CXKz1GISQJR35wSq5sGCzUAH/vTH+4f4
 M6BBew0pN3vMGaTFw8O93VFNpwXcagGshX7UNhYVwXqLfYv1bgWj+pwDdDuJZdT/IfvEh1
 xnXXNLjdDh0AjjDimNHsEPWpYpaCO68=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-QeGswUESNDOTKdD5OT7dHQ-1; Tue,
 31 Mar 2026 05:53:39 -0400
X-MC-Unique: QeGswUESNDOTKdD5OT7dHQ-1
X-Mimecast-MFC-AGG-ID: QeGswUESNDOTKdD5OT7dHQ_1774950818
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B459C1956094; Tue, 31 Mar 2026 09:53:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6E8A180058B; Tue, 31 Mar 2026 09:53:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 5/6] ui/vnc-jobs: clear source tag
Date: Tue, 31 Mar 2026 13:53:01 +0400
Message-ID: <20260331095302.644608-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260331095302.644608-1-marcandre.lureau@redhat.com>
References: <20260331095302.644608-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Avoid potentially removing a dangling source & simplify code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c |  4 +---
 ui/vnc.c      | 31 +++++++------------------------
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index ca625da6d05..ec90ae6d5fc 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -162,9 +162,7 @@ void vnc_jobs_consume_buffer(VncState *vs)
     vnc_lock_output(vs);
     if (vs->jobs_buffer.offset) {
         if (vs->ioc != NULL && buffer_empty(&vs->output)) {
-            if (vs->ioc_tag) {
-                g_source_remove(vs->ioc_tag);
-            }
+            g_clear_handle_id(&vs->ioc_tag, g_source_remove);
             if (vs->disconnecting == FALSE) {
                 vs->ioc_tag = qio_channel_add_watch(
                     vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_OUT,
diff --git a/ui/vnc.c b/ui/vnc.c
index 952976e9649..ccc73bd7aa4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1301,10 +1301,7 @@ static void vnc_disconnect_start(VncState *vs)
     }
     trace_vnc_client_disconnect_start(vs, vs->ioc);
     vnc_set_share_mode(vs, VNC_SHARE_MODE_DISCONNECTED);
-    if (vs->ioc_tag) {
-        g_source_remove(vs->ioc_tag);
-        vs->ioc_tag = 0;
-    }
+    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
     qio_channel_close(vs->ioc, NULL);
     vs->disconnecting = TRUE;
 }
@@ -1462,9 +1459,7 @@ static size_t vnc_client_write_plain(VncState *vs)
     }
 
     if (vs->output.offset == 0) {
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
         vs->ioc_tag = qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
             vnc_client_io, vs, NULL);
@@ -1500,9 +1495,7 @@ static void vnc_client_write(VncState *vs)
     if (vs->output.offset) {
         vnc_client_write_locked(vs);
     } else if (vs->ioc != NULL) {
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
         vs->ioc_tag = qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
             vnc_client_io, vs, NULL);
@@ -1638,10 +1631,7 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
     }
 
     if (vs->disconnecting) {
-        if (vs->ioc_tag != 0) {
-            g_source_remove(vs->ioc_tag);
-        }
-        vs->ioc_tag = 0;
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
     }
     return TRUE;
 }
@@ -1684,9 +1674,7 @@ void vnc_write(VncState *vs, const void *data, size_t len)
     buffer_reserve(&vs->output, len);
 
     if (vs->ioc != NULL && buffer_empty(&vs->output)) {
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
         vs->ioc_tag = qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_OUT,
             vnc_client_io, vs, NULL);
@@ -1734,10 +1722,7 @@ void vnc_flush(VncState *vs)
         vnc_client_write_locked(vs);
     }
     if (vs->disconnecting) {
-        if (vs->ioc_tag != 0) {
-            g_source_remove(vs->ioc_tag);
-        }
-        vs->ioc_tag = 0;
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
     }
     vnc_unlock_output(vs);
 }
@@ -3342,9 +3327,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     VNC_DEBUG("New client on socket %p\n", vs->sioc);
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
     qio_channel_set_blocking(vs->ioc, false, &error_abort);
-    if (vs->ioc_tag) {
-        g_source_remove(vs->ioc_tag);
-    }
+    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
     if (websocket) {
         vs->websocket = 1;
         if (vd->tlscreds) {
-- 
2.53.0


