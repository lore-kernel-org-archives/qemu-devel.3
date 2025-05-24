Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971B8C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmx-00008r-K2; Sat, 24 May 2025 13:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmh-0008Dr-6l
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmd-0000iR-3v
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMRYhi5W/AnDv1YeJ78SpK7glietdkKoLVRQ32Wiy6A=;
 b=VtMrHkF/DZklV9i2LZoHBmz/f6MlmIatqwY9Lm0hfYEBPTcuNF8G4chbkPXtO+oMeizqd/
 q3tK8Ms7qGeQRL2pMtuDQbet7HWa0O7NoKzgeDyxou4nr0BK5VoTBOB2wMQi+6cvPjOPSB
 oYIAzkhZgkUrhYZ2GKIi55+r/AtNPsU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-7ap47jsxORa_AX4TVhqZYA-1; Sat,
 24 May 2025 13:35:39 -0400
X-MC-Unique: 7ap47jsxORa_AX4TVhqZYA-1
X-Mimecast-MFC-AGG-ID: 7ap47jsxORa_AX4TVhqZYA_1748108138
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 862D9180045C
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA286195608D; Sat, 24 May 2025 17:35:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 06/19] ui/vdagent: replace Buffer with GByteArray
Date: Sat, 24 May 2025 19:34:59 +0200
Message-ID: <20250524173514.317886-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Buffer is slightly more advanced than GByteArray, since it has a
cursor/position. But vdagent code doesn't need it. This simplify a bit
the code, and migration state.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vdagent.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 04513ded29..4027126b7d 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -47,7 +47,7 @@ struct VDAgentChardev {
     uint32_t msgsize;
     uint8_t *xbuf;
     uint32_t xoff, xsize;
-    Buffer outbuf;
+    GByteArray *outbuf;
 
     /* mouse */
     DeviceState mouse_dev;
@@ -142,16 +142,16 @@ static void vdagent_send_buf(VDAgentChardev *vd)
 {
     uint32_t len;
 
-    while (!buffer_empty(&vd->outbuf)) {
+    while (vd->outbuf->len) {
         len = qemu_chr_be_can_write(CHARDEV(vd));
         if (len == 0) {
             return;
         }
-        if (len > vd->outbuf.offset) {
-            len = vd->outbuf.offset;
+        if (len > vd->outbuf->len) {
+            len = vd->outbuf->len;
         }
-        qemu_chr_be_write(CHARDEV(vd), vd->outbuf.buffer, len);
-        buffer_advance(&vd->outbuf, len);
+        qemu_chr_be_write(CHARDEV(vd), vd->outbuf->data, len);
+        g_byte_array_remove_range(vd->outbuf, 0, len);
     }
 }
 
@@ -166,7 +166,7 @@ static void vdagent_send_msg(VDAgentChardev *vd, VDAgentMessage *msg)
 
     msg->protocol = VD_AGENT_PROTOCOL;
 
-    if (vd->outbuf.offset + msgsize > VDAGENT_BUFFER_LIMIT) {
+    if (vd->outbuf->len + msgsize > VDAGENT_BUFFER_LIMIT) {
         error_report("buffer full, dropping message");
         return;
     }
@@ -177,9 +177,8 @@ static void vdagent_send_msg(VDAgentChardev *vd, VDAgentMessage *msg)
         if (chunk.size > 1024) {
             chunk.size = 1024;
         }
-        buffer_reserve(&vd->outbuf, sizeof(chunk) + chunk.size);
-        buffer_append(&vd->outbuf, &chunk, sizeof(chunk));
-        buffer_append(&vd->outbuf, msgbuf + msgoff, chunk.size);
+        g_byte_array_append(vd->outbuf, (void *)&chunk, sizeof(chunk));
+        g_byte_array_append(vd->outbuf, msgbuf + msgoff, chunk.size);
         msgoff += chunk.size;
     }
     vdagent_send_buf(vd);
@@ -859,7 +858,7 @@ static void vdagent_disconnect(VDAgentChardev *vd)
 {
     trace_vdagent_disconnect();
 
-    buffer_reset(&vd->outbuf);
+    g_byte_array_set_size(vd->outbuf, 0);
     vdagent_reset_bufs(vd);
     vd->caps = 0;
     if (vd->mouse_hs) {
@@ -920,7 +919,7 @@ static void vdagent_chr_init(Object *obj)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
-    buffer_init(&vd->outbuf, "vdagent-outbuf");
+    vd->outbuf = g_byte_array_new();
     error_setg(&vd->migration_blocker,
                "The vdagent chardev doesn't yet support migration");
 }
@@ -934,7 +933,7 @@ static void vdagent_chr_fini(Object *obj)
     if (vd->mouse_hs) {
         qemu_input_handler_unregister(vd->mouse_hs);
     }
-    buffer_free(&vd->outbuf);
+    g_clear_pointer(&vd->outbuf, g_byte_array_unref);
 }
 
 static const TypeInfo vdagent_chr_type_info = {
-- 
2.49.0


