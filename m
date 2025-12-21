Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B4E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKJV-0003j8-S5; Sun, 21 Dec 2025 09:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKIk-00035E-7K
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:21:01 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKIi-0000au-3X
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=nTi4GpPHVXwHlFatLSgUmXvOzveNAWJZ5/pH3pOSRVE=; b=mkE7/3zofZumH66
 70K2NOiy/2kqmUVnOuJsNyMmxbMpJ4AQSY3Deod9RTyieee7N5Ngf6DE1fctSmAWcm3HTzhkHV3Ea
 3rLI+S9hfCiz07Fhr6ZlEZQcmP+1w5ZVHpjeY9/NMG69S/tjWm1TIAP4x1XetoNOTDlxIYrzbZ2W+
 RU=;
Date: Sun, 21 Dec 2025 15:23:09 +0100
Subject: [PATCH v2 05/14] configs/target: Implement per-binary TargetInfo
 structure for riscv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-hw-riscv-cpu-int-v2-5-eb49d72c5b2f@rev.ng>
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

Defines TargetInfo for 32- and 64-bit riscv binaries.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 configs/targets/riscv32-softmmu.c | 26 ++++++++++++++++++++++++++
 configs/targets/riscv64-softmmu.c | 26 ++++++++++++++++++++++++++
 configs/targets/meson.build       |  1 +
 3 files changed, 53 insertions(+)

diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
new file mode 100644
index 0000000000..897c93594b
--- /dev/null
+++ b/configs/targets/riscv32-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-riscv32)
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/riscv/machines-qom.h"
+#include "target/riscv/cpu-qom.h"
+
+static const TargetInfo target_info_riscv32_system = {
+    .target_name = "riscv32",
+    .target_arch = SYS_EMU_TARGET_RISCV32,
+    .long_bits = 32,
+    .cpu_type = TYPE_RISCV_CPU,
+    .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_riscv32_system;
+}
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
new file mode 100644
index 0000000000..d2e4520d76
--- /dev/null
+++ b/configs/targets/riscv64-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-riscv64)
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/riscv/machines-qom.h"
+#include "target/riscv/cpu-qom.h"
+
+static const TargetInfo target_info_riscv64_system = {
+    .target_name = "riscv64",
+    .target_arch = SYS_EMU_TARGET_RISCV64,
+    .long_bits = 64,
+    .cpu_type = TYPE_RISCV_CPU,
+    .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_riscv64_system;
+}
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
index cca2514eb5..2ab4d27eaf 100644
--- a/configs/targets/meson.build
+++ b/configs/targets/meson.build
@@ -1,5 +1,6 @@
 foreach target : [
       'arm-softmmu', 'aarch64-softmmu',
+      'riscv32-softmmu', 'riscv64-softmmu'
   ]
   config_target_info += {target : files(target + '.c')}
 endforeach

-- 
2.51.0


