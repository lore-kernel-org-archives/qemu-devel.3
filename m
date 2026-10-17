Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70590CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB35-0002nY-PH; Sat, 17 Oct 2026 16:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2g-0001FQ-H9; Sat, 17 Oct 2026 16:30:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2e-0004LJ-IM; Sat, 17 Oct 2026 16:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268861; bh=w6xqnxLBSVo6lOldPIc/C34Vg/LntVbPmhyW420qdmo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qNf4XuT72f8MWI6y/FlYnzU8rttNh+JHEIpEkXisexkshgEdc9g/Krqeg8NuU+ySN
 r6asQ1Q0Tx+ifWiRm4KzYFua/14nCFEmlt34aSQARfBfw79PEAcr5TXM1ncvgxQ0Y7
 aAbvaHSVDlwKIjIruLRyYpM37GxNz6jkVa5RSu6Jfs0/Prj8Onh52U2GomLJUjWklM
 MccoR54a6sESauP1HJoJ4a+suDV/GTj8XQV58DKRtKnFU+oBATHMXxYN3yUl/u+GOf
 k0netgfh2ReasR0ZUtuxGCGe8yP+Z+KLr3sAwAtBODvQM1Vj7uQzBFgd4FQ7ODlhBP
 aqvGl+B6qlbSw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1249C1DE761;
 Sat, 17 Oct 2026 23:27:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3DCFC443435;
 Sat, 17 Oct 2026 23:27:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Jordy Zomer <jordyzomer@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 35/73] system: fix buffer overflow in
 tdx_parse_panic_message
Date: Sat, 17 Oct 2026 23:25:53 +0300
Message-ID: <20261017202638.728621-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Maxim Levitsky <mlevitsk@redhat.com>

tdx_parse_panic_message has code that detects if the guest supplied
message contains some unprintable characters and in this case prints a hex dump.

The code has a bug: it allocates 3 bytes for 'sprintf("%02x ")',
but sprintf in this case actually writes at least 4 bytes, because it adds the NULL
terminator, or even 9 bytes if the char type is signed and the MSB is set.

To fix this, just use qemu_hexdump_line instead.

Reported-by: Jordy Zomer <jordyzomer@google.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3905
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004553.100732-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b7f51182c08123eda612db553e2cded6e536ff49)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/runstate.c b/system/runstate.c
index 08acf801b0..3c8693ccf3 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -50,6 +50,7 @@
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
 #include "qemu/thread.h"
+#include "qemu/cutils.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "system/cpus.h"
@@ -606,10 +607,9 @@ static void qemu_system_wakeup(void)
     }
 }
 
-static char *tdx_parse_panic_message(char *message)
+static GString *tdx_parse_panic_message(char *message)
 {
     bool printable = false;
-    char *buf = NULL;
     int len = 0, i;
 
     /*
@@ -630,32 +630,11 @@ static char *tdx_parse_panic_message(char *message)
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
@@ -700,12 +679,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
         } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
-            char *message = tdx_parse_panic_message(info->u.tdx.message);
+            g_autoptr(GString) message = tdx_parse_panic_message(info->u.tdx.message);
             qemu_log_mask(LOG_GUEST_ERROR,
                           "\nTDX guest reports fatal error."
                           " error code: 0x%" PRIx32 " error message:\"%s\"\n",
-                          info->u.tdx.error_code, message);
-            g_free(message);
+                          info->u.tdx.error_code, message->str);
             if (info->u.tdx.has_gpa) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
                               "can be found at gpa page: 0x%" PRIx64 "\n",
-- 
2.47.3


