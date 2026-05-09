Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75F4CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlHt-0005wN-8b; Sat, 09 May 2026 13:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlHg-0005Zs-7x
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlHe-0005EU-IN
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfYs1LjQpDYe54tsVrqJvVf2U2NzuLWTpllOslebg8A=;
 b=iXzTj1bFuh2mtWNDKyv8UCSdjSUIqsezOLKh1wCsYMHMC4k6pHQspZrntTmAm5ElBsIQNI
 9777iJJafFPGeR5unnKtI7zz1cEtRh5VkTUOT0Q/zjVC0hq3A+sOdGWeRMLhzHa5PH4cx6
 fNVEdkvHdvn/CUx4TG22W1dGB3FbKYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-SaZKL8O1PnKv18Y3w1ZYdA-1; Sat,
 09 May 2026 13:16:07 -0400
X-MC-Unique: SaZKL8O1PnKv18Y3w1ZYdA-1
X-Mimecast-MFC-AGG-ID: SaZKL8O1PnKv18Y3w1ZYdA_1778346967
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00781956080; Sat,  9 May 2026 17:16:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A849F18004A3; Sat,  9 May 2026 17:16:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 21/33] ui/vnc: vnc_display_init() and vnc_display_open()
 return bool
Date: Sat,  9 May 2026 21:13:42 +0400
Message-ID: <20260509171356.1157879-22-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use the QEMU-style error pattern returning "true" on success.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  4 ++--
 ui/vnc.c             | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 2bf768ed482..7224b8142f3 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -438,8 +438,8 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_help(void);
 
 /* vnc.c */
-void vnc_display_init(const char *id, Error **errp);
-void vnc_display_open(const char *id, Error **errp);
+bool vnc_display_init(const char *id, Error **errp);
+bool vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password, Error **errp);
 int vnc_display_pw_expire(const char *id, time_t expires);
diff --git a/ui/vnc.c b/ui/vnc.c
index 3a908670ab9..067f534cf08 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3425,12 +3425,12 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
 
 static void vnc_display_free(VncDisplay *vd);
 
-void vnc_display_init(const char *id, Error **errp)
+bool vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
 
     if (vnc_display_find(id) != NULL) {
-        return;
+        return true;
     }
     vd = g_malloc0(sizeof(*vd));
 
@@ -3451,7 +3451,7 @@ void vnc_display_init(const char *id, Error **errp)
 
     if (!vd->kbd_layout) {
         vnc_display_free(vd);
-        return;
+        return false;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -3465,6 +3465,7 @@ void vnc_display_init(const char *id, Error **errp)
         &vmstate_change_handler, vd);
 
     QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+    return true;
 }
 
 static void vnc_display_close(VncDisplay *vd)
@@ -4070,7 +4071,7 @@ bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp)
     return true;
 }
 
-void vnc_display_open(const char *id, Error **errp)
+bool vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
@@ -4273,7 +4274,7 @@ void vnc_display_open(const char *id, Error **errp)
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
     if (saddr_list == NULL) {
-        return;
+        return true;
     }
 
     if (reverse) {
@@ -4291,10 +4292,11 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     /* Success */
-    return;
+    return true;
 
 fail:
     vnc_display_close(vd);
+    return false;
 }
 
 void vnc_display_add_client(const char *id, int csock, bool skipauth)
@@ -4350,12 +4352,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
         id = vnc_auto_assign_id(opts);
     }
 
-    vnc_display_init(id, errp);
-    if (*errp) {
+    if (!vnc_display_init(id, errp)) {
         return -1;
     }
-    vnc_display_open(id, errp);
-    if (*errp) {
+    if (!vnc_display_open(id, errp)) {
         return -1;
     }
     return 0;
-- 
2.54.0


