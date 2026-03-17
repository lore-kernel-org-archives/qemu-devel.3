Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4173F3381D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QFQ-0001tA-6u; Tue, 17 Mar 2026 04:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QD9-0003XJ-64
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QD7-00075Y-F8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irDzdmZlKqZlZ/OSsviQSMNHKsUUa1AJoPXCVd7AfrY=;
 b=bWkKHVJNMJOYGeWlDmCVjjLC0QbNxLVoRb1zN/d9dCYta40kZCloJa5AJrZHJS3NXSDgm6
 3ch2gLoWyuTyRgqHUDjzZuyBPSN0vq4yyHJ6/CPbfcinL5oTV3xlmLZCyB5AvPTZNFYE4x
 84PiEuZI00yA+TYKKP7HUntTBewcwdE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-RcQloQdSNFGIItbklTZfRw-1; Tue,
 17 Mar 2026 04:55:29 -0400
X-MC-Unique: RcQloQdSNFGIItbklTZfRw-1
X-Mimecast-MFC-AGG-ID: RcQloQdSNFGIItbklTZfRw_1773737728
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC88B19560BB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEB3B3000223
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:04 +0400
Subject: [PATCH 50/60] ui/vnc: add vnc-system unit, to allow different
 implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-50-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=37JYZZ/P1/dRjhOzYk0C7VpU4vVI2PAO/cjaK3GzNI4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcRcGwJCKFRaEXEi7xmC01JZKBVfnhQ/KwZ
 edKCEIVEBmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5V98D/4564clLhp9TDRB0CILguG6DdmGwy2WbmUX2CBre0f7LcLI5KDPZ/nVFi64xzLd6llgzFI
 QtGi2VTbQ0GJW54uIDSHexYAERCkEGUOe4Kf6wb5wkb0bUl0h7uyOYpQr85ng1n4j5rTiz1PcYS
 yhcNK5AM9umlhotw4Y7+nelTaXvB6m45b+MvLMcV///FuRQb56Dz658KkbqMGsQEFWOMGIobNxw
 aE6+kQRKj5t/oQFYpt9fpAQdpcbzNY50Z8pM46kHnRVyY/39nNQhgkNmzMz28Pyxpmt+t9NBn7V
 RtxgVu9UGGC7+74v8Hw9wKsxwsCnAX87wfKdm9Tu37uI+pQbeLhXk0JRRDYTkS6KDHX01eQ+y8X
 9T44khEg6+vg8i4ExklY6hGv5rJz/sb39fi/kSN89D2lH08QtCm0UNjB88LKYNuMyWJQKH/rE8i
 rxWtYbUMW1tSPkM7gfKOkB01iDVAfKzRoKLD6cyhDS4xdTd/NO2hm0da1dFPp7A89Ikid01tVlB
 HtfU61KhJ4O5Vc6V4WVR4anM2wcJJvUvscJs6R9V5sbUTgFeN9dv/6+eL4hLXYBYgKmSNRDkoU5
 rUpuKVlQAyNcDDYUYAd9yUiJWjMSJ7ascvZe/rEOuwmqX+uNc2Y8rUJiBYIWyubF0b4pOKQ6sMn
 9ee2pFU4MuVl0HA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The qemu-vnc server will want to signal the XVP requests, let it
have its own implementation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h        |  4 ++++
 ui/vnc-system.c | 19 +++++++++++++++++++
 ui/vnc.c        |  4 ++--
 ui/meson.build  |  2 +-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 6afe0f16d12..1db9747599c 100644
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
index c38be7113f1..fe2659a39ca 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2520,13 +2520,13 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
 
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
index b31ddf96282..f959f8972b5 100644
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
2.53.0


