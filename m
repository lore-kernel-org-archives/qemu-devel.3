Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9B3CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXlC-000834-AV; Fri, 22 May 2026 17:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkN-0006lG-Pu; Fri, 22 May 2026 17:49:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkL-0002Sj-Ng; Fri, 22 May 2026 17:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486559; bh=/18hG5HPoAxJTkndAlIldyOwxO4KKwlIeNPw3UW0GrU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hFebCMamVq7vPmX2lhk5mIHGmeu08iQd8alzcDo31u+EliWJlgS770XMuijssZXrp
 wgx6GIlCq0b9zLZL/ACOkOhgnCgtL7Dfoqxq7jJxE26O6ANv46IS+E8bY4olP/MBcS
 MUsIkT99nJtFNjGsifUGCDyoKFfUT78zfaYJSPfM9njwvmmL6Es/ml2e3rZA+q/RiK
 jfBDHjOW+8gr7T5UxYj7+IuXgWV/0hIOhuDWFY4TfOJqner2+NHsbD8bqb7DqWuPcY
 Q5btWKKExevUPO7p7dmhQVii8CA2vUqfeBLILnxRl2K2W5bPepQXGOlAcVqr1+fYAp
 /0MiPZYoP3qOw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 361D91AFB5D;
 Sat, 23 May 2026 00:49:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 585D53B71AC;
 Sat, 23 May 2026 00:49:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, kiki <Chan9Yan9@gmail.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 103/149] hw/intc/xics: Add a check for an invalid
 server id
Date: Sat, 23 May 2026 00:48:35 +0300
Message-ID: <20260522214923.807017-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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
index 200710eb6c..c7312d166f 100644
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


