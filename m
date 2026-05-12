Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15163CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuj5-0005FB-Vj; Tue, 12 May 2026 17:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuia-0004NT-Ej; Tue, 12 May 2026 17:32:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuiQ-0002a7-9N; Tue, 12 May 2026 17:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619499; bh=BnyGBCl2tDmEhHgXBXYxgINhnh2BQvH3VrIdaBHXsMg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sjMktoFQHDIAS++H60JdTJ3Ul+OH7su1wi4j9sMhLUxjpgk3WFdq7ShFAxeQbATyB
 Sns4+vXNrg8mW2WPBNwz6+x+eUTIw6N9dtZ9pXiWVw5K27LtwhdqiQflvkHGrKXDYe
 8Ah3cibwgPtmcOeDUmJnTbFf8x9JC8mCKLRwMSHt8GKWAx3EYS5Y7W5Qqm5WgtVyZ0
 ZjSR/7UlTmbeWJkJfie/KUfiQayijIZN7RgEaV4FEMtBb3jAvn/p0UBQwhyaa9BkF6
 duPLqS5BNoG/Ccw76gCjkMamkjZ1hrV+KnOX6ASlTaA+6azZtnwLG0ytCMHpAnmazn
 jE3pa5qajK4xg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E124E1AA3F6;
 Tue, 12 May 2026 23:58:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA9DD3ABD4E;
 Tue, 12 May 2026 23:58:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, kiki <Chan9Yan9@gmail.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 43/58] hw/intc/xics: Add a check for an invalid server
 id
Date: Tue, 12 May 2026 23:58:04 +0300
Message-ID: <20260512205820.361821-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: kiki <Chan9Yan9@gmail.com>

A malformed IVE value can result in an invalid server field being
passed to icp_irq(). The function assumes the server id is valid and
may access invalid state otherwise, potentially leading to a crash.

Fix this by validating the server id before using it and ignoring
invalid values.

Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3324
Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260428103645.50617-1-Gautam.Menghani@ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit 1aee8067fce95d15061eca8fbb6772d8a90ea699)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 1d40c4386d..2e68ac8b96 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "qemu/timer.h"
@@ -222,6 +223,13 @@ void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 
     trace_xics_icp_irq(server, nr, priority);
 
+    if (!icp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ 0x%x\n",
+                      server, nr);
+        ics_reject(ics, nr);
+        return;
+    }
+
     if ((priority >= CPPR(icp))
         || (XISR(icp) && (icp->pending_priority <= priority))) {
         ics_reject(ics, nr);
-- 
2.47.3


