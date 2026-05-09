Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8658FCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlI6-0007u2-BR; Sat, 09 May 2026 13:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlI3-0007S9-I6
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlI2-0005JT-0Q
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Gmc791aL5c7XJeFqvLsA3fXbA9hTzJpJ+t7ss6+PVE=;
 b=RBhOC7RFSwKHvYjMfwwT2cyqVg7IDh2/HKOlytNOD5AyVEbncTz5Q8YXFK8oBzhpsRcGo7
 MGI8vKy2BerQJ5zi/by/qKEtu3dFttMYBWFUwBmiRvgTQITYUEz02a0iELQx78mFN9nwzC
 dnCBIdsTJUZiAvSfJCRc1adbiVDAi9s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-qL9xpFabM86brWZeFNFdmA-1; Sat,
 09 May 2026 13:16:29 -0400
X-MC-Unique: qL9xpFabM86brWZeFNFdmA-1
X-Mimecast-MFC-AGG-ID: qL9xpFabM86brWZeFNFdmA_1778346988
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76C0A19560B0; Sat,  9 May 2026 17:16:28 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6049319560A2; Sat,  9 May 2026 17:16:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 25/33] ui/vnc: add vnc-system unit,
 to allow different implementations
Date: Sat,  9 May 2026 21:13:46 +0400
Message-ID: <20260509171356.1157879-26-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The qemu-vnc server will want to signal the XVP requests, let it
have its own implementation.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h        |  4 ++++
 ui/vnc-system.c | 19 +++++++++++++++++++
 ui/vnc.c        |  4 ++--
 ui/meson.build  |  2 +-
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 ui/vnc-system.c

diff --git a/ui/vnc.h b/ui/vnc.h
index d2ebb0f7f45..0b345246c8e 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -648,4 +648,8 @@ void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
 
+/* XVP events */
+void vnc_action_shutdown(VncState *vs);
+void vnc_action_reset(VncState *vs);
+
 #endif /* QEMU_VNC_H */
diff --git a/ui/vnc-system.c b/ui/vnc-system.c
new file mode 100644
index 00000000000..0632885f655
--- /dev/null
+++ b/ui/vnc-system.c
@@ -0,0 +1,19 @@
+/*
+ * QEMU VNC display driver
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include "ui/vnc.h"
+#include "system/runstate.h"
+
+void vnc_action_shutdown(VncState *vs)
+{
+    qemu_system_powerdown_request();
+}
+
+void vnc_action_reset(VncState *vs)
+{
+    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
+}
diff --git a/ui/vnc.c b/ui/vnc.c
index ea1579135b8..154b07e2e4e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2522,13 +2522,13 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
 
             switch (action) {
             case VNC_XVP_ACTION_SHUTDOWN:
-                qemu_system_powerdown_request();
+                vnc_action_shutdown(vs);
                 break;
             case VNC_XVP_ACTION_REBOOT:
                 send_xvp_message(vs, VNC_XVP_CODE_FAIL);
                 break;
             case VNC_XVP_ACTION_RESET:
-                qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
+                vnc_action_reset(vs);
                 break;
             default:
                 send_xvp_message(vs, VNC_XVP_CODE_FAIL);
diff --git a/ui/meson.build b/ui/meson.build
index 7b6e867d3af..74151b05033 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -48,7 +48,7 @@ vnc_ss.add(files(
 vnc_ss.add(zlib, jpeg, png)
 vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
 system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
-system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
+system_ss.add(when: vnc, if_true: files('vnc-system.c'), if_false: files('vnc-stubs.c'))
 
 ui_modules = {}
 
-- 
2.54.0


