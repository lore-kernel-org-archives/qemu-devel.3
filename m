Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC32CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCSQ-0000JB-E3; Tue, 04 Nov 2025 03:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSM-0000Gz-Ss
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSL-0003Oo-BH
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTIgutNUjXiAKsujqsIDkgcCTQi3L2/Jgs5XBHJrSA4=;
 b=ZBNPoxsgyuVnSJ/FWdc+B0hBpebFs0BACjv2AtYpOYgswIfXXq2V6ammPu+PLzCCPjH9eI
 wzlRnlDnRpz4PelpMLISdxzIyf9ppCOpatGrhbtHDZN4kqYDQscxoiQ+rx4LV0XSNBAXNZ
 xZyvz8a9SIkkDCcyL+Dazb5QHXdppRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-WWk0crlYNbaX1u-O4bgjcg-1; Tue,
 04 Nov 2025 03:31:52 -0500
X-MC-Unique: WWk0crlYNbaX1u-O4bgjcg-1
X-Mimecast-MFC-AGG-ID: WWk0crlYNbaX1u-O4bgjcg_1762245112
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 970841800675; Tue,  4 Nov 2025 08:31:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9C7019560A2; Tue,  4 Nov 2025 08:31:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/30] hw/arm/aspeed: Move AspeedMachineState definition to
 common header for reuse
Date: Tue,  4 Nov 2025 09:31:15 +0100
Message-ID: <20251104083144.187806-2-clg@redhat.com>
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
References: <20251104083144.187806-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 12 ++++++++++++
 hw/arm/aspeed.c         | 14 --------------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 6c364556565a..9d34be68b2b3 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -11,6 +11,7 @@
 
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "hw/arm/aspeed_soc.h"
 
 typedef struct AspeedMachineState AspeedMachineState;
 
@@ -24,6 +25,17 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
 #define ASPEED_MAC2_ON   (1 << 2)
 #define ASPEED_MAC3_ON   (1 << 3)
 
+struct AspeedMachineState {
+    MachineState parent_obj;
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
index ecc7272e67c2..4c92f1e1d953 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -36,20 +36,6 @@ static struct arm_boot_info aspeed_board_binfo = {
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
2.51.1


