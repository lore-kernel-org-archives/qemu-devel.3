Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3548AF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHT5-0006sc-Cu; Fri, 10 Apr 2026 15:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHT1-0006sT-71
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSs-0002TJ-4S
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbWS1U6sGNFtZ0AKwcuYyB+KC1yy2Hf37j/hRn33Qzw=;
 b=RDKgXH8Zx5ncQSXKLu9OTPTNlK2oANy7cdijQZaHamL5XKcgMPCKszHtdlKE1JMzWez+UM
 fcG2GkZ+jU036Hhe7L1C6zq0P+XfuNbZfg6+Cc0oAAic9ZZsC5u7kY56T1sNkA640gfSqA
 boW+tr+69wcXhR+PNHOip04+ncb1I1M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-7wgy3TLkO4-KnhbUPmoWcg-1; Fri,
 10 Apr 2026 15:24:24 -0400
X-MC-Unique: 7wgy3TLkO4-KnhbUPmoWcg-1
X-Mimecast-MFC-AGG-ID: 7wgy3TLkO4-KnhbUPmoWcg_1775849063
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80D681956054
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:24:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FE7C195608E; Fri, 10 Apr 2026 19:24:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:17 +0400
Subject: [PATCH v2 55/67] ui/vnc: add vnc-system unit, to allow different
 implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-55-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lv2qIJXAuZ9UVUHeJZVKwIcM+k9S1qb2iody8sOCzmk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0WLIXZcC6sj0ZWvuB1ugWOMFJnhVEJU0lUE
 +MOjyM4BS2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5S6IEACOMjCLdYq3xK7edzhJeK6RR7MrATZC2d8gcKk/nVJRot4AEegVjV37wom2VlI7A0M6L7g
 oFYOhl9MoC58GMslrRJdDBMgBu2T9IiYD1x5rHTmHEVGM/9Pe/CI6Cp62Jj++nIJvzYCS1cUnGo
 1a+WnNCOKfzgAPnNfPZhiuOIQOVG9HKpwfSR5dkaGvI4jRa8ADWenWbu4o9uBaLwQPg1QSihih4
 XJyqAAAdHl2Uc2rtddUACzLIeXIfUkNUz4xOInPWHD60jE6BVAWRZm80F/Qn4lXFSB81oQB4RpQ
 8L61vQm6Ezi1FIluqZWoc42wSF+ZGznrEaaQEkXxHgXM4Xu/bOEcxiKC6GFhUIjqW2+yUe9kANb
 1UybYeT2b0KZaQXSyKuzdDU4XWGZUA8r5eU3trWkAJzhcC4hnJUZLruZ0Mb+lbwv09fvVs5E2X7
 2SgH85pY3///SPxhNfcmQffHUzwQ4WKWneqlze+kjMIleHAl8IMBbWH4/UKZi/GK52aWrF/VCJi
 VCQG7reehPZBc8Lt/X8AtPSFsN5xEgu80xHMb4xaoQAv05URYxEBQeNm2NFtIk7rk1HkhKDZnxX
 9C5WSjzf2PFqaAmNZCRC4s29vGH5zUv5nWI1LuTwrKgmnt4DlcYcKPag54h4OPda97LFFYKS+kT
 exbslvLGaedmrww==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 993ec022e52..7341fb0f25c 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -649,4 +649,8 @@ void vnc_server_cut_text_caps(VncState *vs);
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
index e7ec1fb7f68..5dd1eb399cc 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2521,13 +2521,13 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
 
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


