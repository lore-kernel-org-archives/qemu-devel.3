Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B37F9B614
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4R-00026l-Lp; Wed, 22 Apr 2026 06:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4P-0001p1-7T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4N-0003L4-7F
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoeOj7zf2VibhBKz1qVEpK6tjqVm1MUo6M6TiTkMnHU=;
 b=NmGBmRDU/axpOHVQ3NTpCIrEnSF/A9zHogjKrGypEX8AIeIBQ1fR5KuKSN9wqYViEvKlwL
 EWAHVhpco6m2fnIatPMoOCKiWKEj0anZ/0tU9xsHdm5vQ/2vIhIphRiWNVhTeEal5SyU0t
 bOVTid6okGF4A2gNP68sq4NSTMiaVpo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-UBTcyrbxMbiUtEQ_Bz0GFg-1; Wed,
 22 Apr 2026 06:44:31 -0400
X-MC-Unique: UBTcyrbxMbiUtEQ_Bz0GFg-1
X-Mimecast-MFC-AGG-ID: UBTcyrbxMbiUtEQ_Bz0GFg_1776854670
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F5C31800579; Wed, 22 Apr 2026 10:44:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 529301800660; Wed, 22 Apr 2026 10:44:28 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 36/40] ui/vnc: fix vnc_display_init() leak on failure
Date: Wed, 22 Apr 2026 14:40:37 +0400
Message-ID: <20260422104042.3936506-37-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do not add the display state to the vnc list, if the initialization
failed. Add vnc_display_free(), to free the display state and associated
data in such case. The function is meant to be public and reused in the
following changes.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index d5d92c0d99b..37ebd1a534a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3424,6 +3424,8 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
 }
 
+static void vnc_display_free(VncDisplay *vd);
+
 void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
@@ -3433,8 +3435,9 @@ void vnc_display_init(const char *id, Error **errp)
     }
     vd = g_malloc0(sizeof(*vd));
 
+    qemu_mutex_init(&vd->mutex);
     vd->id = g_strdup(id);
-    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+    vd->dcl.ops = &dcl_ops;
 
     QTAILQ_INIT(&vd->clients);
     vd->expires = TIME_MAX;
@@ -3448,22 +3451,22 @@ void vnc_display_init(const char *id, Error **errp)
     }
 
     if (!vd->kbd_layout) {
+        vnc_display_free(vd);
         return;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
     vd->connections_limit = 32;
 
-    qemu_mutex_init(&vd->mutex);
     vnc_start_worker_thread();
 
-    vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
     vd->kbd = qkbd_state_init(vd->dcl.con);
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
-}
 
+    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+}
 
 static void vnc_display_close(VncDisplay *vd)
 {
@@ -3507,6 +3510,28 @@ static void vnc_display_close(VncDisplay *vd)
 #endif
 }
 
+static void vnc_display_free(VncDisplay *vd)
+{
+    if (!vd) {
+        return;
+    }
+
+    assert(QTAILQ_EMPTY(&vd->clients));
+
+    vnc_display_close(vd);
+    unregister_displaychangelistener(&vd->dcl);
+    qkbd_state_free(vd->kbd);
+    qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
+    kbd_layout_free(vd->kbd_layout);
+    qemu_mutex_destroy(&vd->mutex);
+    if (QTAILQ_IN_USE(vd, next)) {
+        QTAILQ_REMOVE(&vnc_displays, vd, next);
+    }
+    g_free(vd->id);
+    g_free(vd);
+}
+
+
 int vnc_display_password(const char *id, const char *password, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
-- 
2.53.0


