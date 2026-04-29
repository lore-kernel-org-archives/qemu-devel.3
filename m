Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4A6FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC7m-0001av-UU; Wed, 29 Apr 2026 17:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5u-0006dU-Nf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5l-0003WE-M6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvceuUgF9UWGi+mkdSUd1zm6+VCfNMZH/pssttX4eis=;
 b=MuwkfuafIeuw5+HmhGMpphc1Z7quDAC4mJ8kxfJu1urhsuDsuGHf/l1njI3pbQrBJeJtG6
 OyQvZVhvKx/IY6H0GyK30DysbXNzDHT5Mc0GfZpkLjiqFaugfctqoFAHu+4pDKYP+8/SrU
 m8MyK+fuCXtNWBahDWkCya192574ClA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-XL3B-7QIMU62J1AERxpPRg-1; Wed,
 29 Apr 2026 17:05:05 -0400
X-MC-Unique: XL3B-7QIMU62J1AERxpPRg-1
X-Mimecast-MFC-AGG-ID: XL3B-7QIMU62J1AERxpPRg_1777496704
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A2311800378
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:05:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21C3E19560AB; Wed, 29 Apr 2026 21:05:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:52 +0400
Subject: [PATCH v3 19/26] ui/vnc: add vnc-system unit, to allow different
 implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-19-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YzwkPRuZT+t1WALPng4UgvXGw1hhuhKzK7Bl0fT7wlw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIMOuk2e2TxtoDw8xrAjkZKxNSLglT/Onj66
 +hVV1c4SEeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyDAAKCRDa6OEJdZac
 5VHTD/4xqfK1+CNU92p/u2YiAs3EJOS6i7S3eeuGYamZDgUmowIo1z2r9aqJ/CD3mUyCJbKLmMY
 R0aX+ybX4ker7LFRwCH2DaS+G4cY1NuDvmz6peAdi9sPuhKlibDlqBbxTwK5xWl8VMPzdwM/J7c
 UEgZSTX4GRgNuQqZcaRJzW2nfNWIdCMtJI2yZRei93yKbrJVfH+FtX4SKBt4cWVeXOjFYloQgMD
 GgLFWOLiOEdwBafqWmvE9nJUayn01UMhBRMFdSfGaRJYwl7qg4xLl3SW63ff2KyGL6D+Qy2t8s+
 Sl8Dr3XTujJYjAYWXSeMaJUehHeaFTl4lJB2t1BBh5j8TCTEMLtS5LypnmSg7OK8JI5ZRfTMS8B
 an1iJsfuI5bJNGT8L6UGSJfjm7dJlpHsBKwt1TuQLYTGntFMCC/TmNGApzmmG6KJK8ImYgJeoN7
 BaDiX1b2KU8uzOyZwee5qU5NQ3ocbuXm7VqIrZa8GtEnn10JX1ZBDygQo7TC1S8cNrWwV7WBgQN
 jzGgbH6Kcn7T9+Qvri0lehvJqZQsq24rLUWAPe9dyYWC6W5Jh7j8oBLYUrffe/IGy+VAFO7Ppmd
 sgHyIf2V6KAcsL+BYyizBkaA367HC3iSE5UdsptnqCUjIG3pIuWoA13ubzCzqMSxb1v7JX+yp18
 eTispZ9UwxD7EiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


