Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB3AC83F1D
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 09:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaskC-0003tM-VK; Sun, 13 Jul 2025 05:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uask1-0003ZM-3P; Sun, 13 Jul 2025 05:11:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uasjz-000739-9q; Sun, 13 Jul 2025 05:11:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 092C01362E6;
 Sun, 13 Jul 2025 12:10:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C455A245F51;
 Sun, 13 Jul 2025 12:10:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 5/6] hw/uefi: Create and use trace.h wrapper header
Date: Sun, 13 Jul 2025 12:10:47 +0300
Message-ID: <20250713091059.35165-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250713091059.35165-1-mjt@tls.msk.ru>
References: <20250713091059.35165-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Peter Maydell <peter.maydell@linaro.org>

The documentation of the trace subsystem (docs/devel/tracing.rst)
says that each subdirectory which uses trace events should create a
wrapper trace.h file which includes the trace/trace-foo.h generated
header, and that .c files then #include "trace.h".

We didn't follow this pattern in hw/uefi/.  Correct this by creating
and using the trace.h wrapper header.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/uefi/trace.h              | 2 ++
 hw/uefi/var-service-core.c   | 2 +-
 hw/uefi/var-service-policy.c | 2 +-
 hw/uefi/var-service-utils.c  | 2 +-
 hw/uefi/var-service-vars.c   | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 hw/uefi/trace.h

diff --git a/hw/uefi/trace.h b/hw/uefi/trace.h
new file mode 100644
index 0000000000..6aa1c93896
--- /dev/null
+++ b/hw/uefi/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-hw_uefi.h"
diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 4836a0cb81..feec5a5958 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -12,7 +12,7 @@
 #include "hw/uefi/var-service-api.h"
 #include "hw/uefi/var-service-edk2.h"
 
-#include "trace/trace-hw_uefi.h"
+#include "trace.h"
 
 static int uefi_vars_pre_load(void *opaque)
 {
diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 3b1155fe4e..58da4adbeb 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -14,7 +14,7 @@
 #include "hw/uefi/var-service-api.h"
 #include "hw/uefi/var-service-edk2.h"
 
-#include "trace/trace-hw_uefi.h"
+#include "trace.h"
 
 static void calc_policy(uefi_var_policy *pol);
 
diff --git a/hw/uefi/var-service-utils.c b/hw/uefi/var-service-utils.c
index c9ef46570f..258013f436 100644
--- a/hw/uefi/var-service-utils.c
+++ b/hw/uefi/var-service-utils.c
@@ -8,7 +8,7 @@
 
 #include "hw/uefi/var-service.h"
 
-#include "trace/trace-hw_uefi.h"
+#include "trace.h"
 
 /* ------------------------------------------------------------------ */
 
diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 7f98d77a38..37d05b71cf 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -12,7 +12,7 @@
 #include "hw/uefi/var-service-api.h"
 #include "hw/uefi/var-service-edk2.h"
 
-#include "trace/trace-hw_uefi.h"
+#include "trace.h"
 
 #define EFI_VARIABLE_ATTRIBUTE_SUPPORTED                                \
     (EFI_VARIABLE_NON_VOLATILE |                                        \
-- 
2.47.2


