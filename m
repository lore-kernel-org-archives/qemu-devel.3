Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89787C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9B8i-0004of-AH; Tue, 22 Sep 2026 20:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9B8g-0004oU-By
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9B8e-0007OI-5l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790124426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dRYxqR9srHWQKmGPM9tnApEXT2EsJb2fiunUUaceqc0=;
 b=UtLEZOjaX1k2ICoRYHWS8kYP87Ik7+R5YMmon1M7doMZ+uiYsQrjitjoYZkkwC8RdURnAZ
 7QgOJCwPixYLOQ3xiLVWJJCdyC0NAOuvnyhAASdoCoggYTdXZkmUAawFSqr0+LHxz7HZ3s
 ixoI3X31dZMJm2PKjFAth2nxXprW3kA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-yD1sQtF1NZiGHjkIs66V6g-1; Tue,
 22 Sep 2026 20:45:56 -0400
X-MC-Unique: yD1sQtF1NZiGHjkIs66V6g-1
X-Mimecast-MFC-AGG-ID: yD1sQtF1NZiGHjkIs66V6g_1790124356
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2D3D195419D; Wed, 23 Sep 2026 00:45:55 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4DBA1956041; Wed, 23 Sep 2026 00:45:54 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Jordy Zomer <jordyzomer@google.com>
Subject: [PATCH] system: fix buffer overflow in tdx_parse_panic_message
Date: Tue, 22 Sep 2026 20:45:53 -0400
Message-ID: <20260923004553.100732-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

tdx_parse_panic_message has code that detects if the guest supplied
message contains some unprintable characters and in this case prints a hex dump.

The code has a bug: it allocates 3 bytes for 'sprintf("%02x ")',
but sprintf in this case actually writes 4 bytes, because it adds the NULL
terminator.

To fix this, just use qemu_hexdump_line instead.
This patch was only compile tested.

Reported-by: Jordy Zomer <jordyzomer@google.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3905
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 system/runstate.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index d3e64d2b6258..ebf09b192b4e 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -50,6 +50,7 @@
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
 #include "qemu/thread.h"
+#include "qemu/cutils.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "system/cpu-timers.h"
@@ -760,10 +761,9 @@ static void qemu_system_wakeup(void)
     }
 }
 
-static char *tdx_parse_panic_message(char *message)
+static GString *tdx_parse_panic_message(char *message)
 {
     bool printable = false;
-    char *buf = NULL;
     int len = 0, i;
 
     /*
@@ -784,32 +784,11 @@ static char *tdx_parse_panic_message(char *message)
         }
     }
 
-    if (len == 0) {
-        buf = g_malloc(1);
-        buf[0] = '\0';
+    if (printable) {
+        return g_string_new(message);
     } else {
-        if (!printable) {
-            /* 3 = length of "%02x " */
-            buf = g_malloc(len * 3);
-            for (i = 0; i < len; i++) {
-                if (message[i] == '\0') {
-                    break;
-                } else {
-                    sprintf(buf + 3 * i, "%02x ", message[i]);
-                }
-            }
-            if (i > 0) {
-                /* replace the last ' '(space) to NULL */
-                buf[i * 3 - 1] = '\0';
-            } else {
-                buf[0] = '\0';
-            }
-        } else {
-            buf = g_strdup(message);
-        }
+        return qemu_hexdump_line(NULL, message, len, 1, 0);
     }
-
-    return buf;
 }
 
 void qemu_system_guest_panicked(GuestPanicInformation *info)
@@ -854,11 +833,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
         } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
-            char *message = tdx_parse_panic_message(info->u.tdx.message);
+            GString *message = tdx_parse_panic_message(info->u.tdx.message);
             qemu_log_mask(LOG_GUEST_ERROR,
                           "\nTDX guest reports fatal error."
                           " error code: 0x%" PRIx32 " error message:\"%s\"\n",
-                          info->u.tdx.error_code, message);
+                          info->u.tdx.error_code, message->str);
             g_free(message);
             if (info->u.tdx.has_gpa) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
-- 
2.54.0


