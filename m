Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C59E67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKIK-0002qv-4y; Sun, 21 Dec 2025 09:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKID-0002jf-3Z
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:20:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKIB-0000X9-OX
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=FuTwyO7LpL4N7aVC0QhERrGffYKhjy9Ll3iBxAHD1to=; b=wkQd6ydpegdvnRp
 u9Ud4uiH/kRRKdB3OjU56lteOyUHd+LCtlwBANWswQezyxuwPCFxUKn44YD7LzQ+j5WzyGDuOQcc6
 gh50HVk1J88xI2FSvqoMSgHDv0broiPeFdbWzhcMq2xW/tDyLzHbtcRWt4FiqsPX7r6EmScWHliVh
 zg=;
Date: Sun, 21 Dec 2025 15:23:05 +0100
Subject: [PATCH v2 01/14] hw/riscv: Register generic riscv[32|64] QOM
 interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-hw-riscv-cpu-int-v2-1-eb49d72c5b2f@rev.ng>
References: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
In-Reply-To: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Defines generic 32- and 64-bit riscv machine interfaces for machines to
implement.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/machines-qom.h | 20 ++++++++++++++++++++
 target-info-qom.c               |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
new file mode 100644
index 0000000000..6e2c542c87
--- /dev/null
+++ b/include/hw/riscv/machines-qom.h
@@ -0,0 +1,20 @@
+/*
+ * QOM type definitions for riscv32 / riscv64 machines
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_MACHINES_QOM_H
+#define HW_RISCV_MACHINES_QOM_H
+
+#include "hw/boards.h"
+
+#define TYPE_TARGET_RISCV32_MACHINE \
+        "target-info-riscv32-machine"
+
+#define TYPE_TARGET_RISCV64_MACHINE \
+        "target-info-riscv64-machine"
+
+#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index 7fd58d2481..aaaebd55c7 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qom/object.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
     {
@@ -19,6 +20,14 @@ static const TypeInfo target_info_types[] = {
         .name           = TYPE_TARGET_AARCH64_MACHINE,
         .parent         = TYPE_INTERFACE,
     },
+    {
+        .name           = TYPE_TARGET_RISCV32_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+    {
+        .name           = TYPE_TARGET_RISCV64_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
 };
 
 DEFINE_TYPES(target_info_types)

-- 
2.51.0


