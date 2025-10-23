Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D594CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs9L-0001LM-NA; Thu, 23 Oct 2025 06:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs8z-0001Go-Gh; Thu, 23 Oct 2025 06:02:07 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs8x-00039r-Vb; Thu, 23 Oct 2025 06:02:05 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Oct
 2025 18:01:51 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Oct 2025 18:01:51 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 01/13] hw/arm/aspeed: Move AspeedMachineState definition to
 common header for reuse
Date: Thu, 23 Oct 2025 18:01:34 +0800
Message-ID: <20251023100150.295370-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Aspeed machines will be moved into split C files for better
modularization and future maintenance.

To allow all machine implementations to reuse the same
AspeedMachineState structure, the struct definition is moved
from aspeed.c to the shared header aspeed.h.

This change centralizes the common state structure used across
all Aspeed machine models, reduces redundancy, and simplifies
future refactoring work for new machines.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed.h | 14 ++++++++++++++
 hw/arm/aspeed.c         | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 6c36455656..383ebb9759 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -11,6 +11,7 @@
 
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "hw/arm/aspeed_soc.h"
 
 typedef struct AspeedMachineState AspeedMachineState;
 
@@ -24,6 +25,19 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
 #define ASPEED_MAC2_ON   (1 << 2)
 #define ASPEED_MAC3_ON   (1 << 3)
 
+struct AspeedMachineState {
+    /* Private */
+    MachineState parent_obj;
+    /* Public */
+
+    AspeedSoCState *soc;
+    MemoryRegion boot_rom;
+    bool mmio_exec;
+    uint32_t uart_chosen;
+    char *fmc_model;
+    char *spi_model;
+    uint32_t hw_strap1;
+};
 
 struct AspeedMachineClass {
     MachineClass parent_obj;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1bc9e534ba..761b526994 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -35,20 +35,6 @@ static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
 };
 
-struct AspeedMachineState {
-    /* Private */
-    MachineState parent_obj;
-    /* Public */
-
-    AspeedSoCState *soc;
-    MemoryRegion boot_rom;
-    bool mmio_exec;
-    uint32_t uart_chosen;
-    char *fmc_model;
-    char *spi_model;
-    uint32_t hw_strap1;
-};
-
 /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
 #if HOST_LONG_BITS == 32
 #define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
-- 
2.43.0


