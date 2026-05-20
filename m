Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCCECD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgf3-0004oB-S5; Wed, 20 May 2026 09:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgez-0004jL-W9; Wed, 20 May 2026 09:08:30 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgey-00013b-CQ; Wed, 20 May 2026 09:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=tTFqSlsc848J218/Yx+Iadsv+fdY1crVFnW2i8y2H0U=; b=ZAhtxR190sPSesn
 f7Q9ixy3j20cZm0OisR2jhHtNkcCHlp0pxf9oXe8BvlZ69JXPjNhiu8v5Y+xcroRT3IWWI1GiBOqy
 jAO+Y87/2nFdDgkdFBrhW8w+mIp+4g4NPqy3yynSur8sSY3/rP5PcDMypK0wdjV+VwPNp46bl5+2q
 Mc=;
Date: Wed, 20 May 2026 15:12:57 +0200
Subject: [PATCH v3 05/14] configs/target: Implement per-binary TargetInfo
 structure for riscv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-5-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=2712;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=+2x91c/ot0C95ECpKcincB2R1tj+hcOjCJaTZEr9mQ8=;
 b=+gB9xGHErQjW3nT4kXi7FUDdrluQNd93+RMc5J4DEjJhQ8WDIMsN7IISwoTxw0v8AkNGvx3UF
 wWQM+wrp/uPCvN3Vw8RWoweWAnkLko6bUxXpWjOkreyDmmlQl+NQW2v
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
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
index 0000000000..752c813077
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
+#include "qemu/target-info-init.h"
+#include "hw/riscv/machines-qom.h"
+#include "target/riscv/cpu-qom.h"
+#include "target/riscv/cpu-param.h"
+
+static const TargetInfo target_info_riscv32_system = {
+    .target_name = "riscv32",
+    .target_arch = SYS_EMU_TARGET_RISCV32,
+    .long_bits = 32,
+    .cpu_type = TYPE_RISCV_CPU,
+    .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_init = TARGET_PAGE_BITS,
+};
+
+target_info_init(target_info_riscv32_system)
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
new file mode 100644
index 0000000000..5150f0fe9d
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
+#include "qemu/target-info-init.h"
+#include "hw/riscv/machines-qom.h"
+#include "target/riscv/cpu-qom.h"
+#include "target/riscv/cpu-param.h"
+
+static const TargetInfo target_info_riscv64_system = {
+    .target_name = "riscv64",
+    .target_arch = SYS_EMU_TARGET_RISCV64,
+    .long_bits = 64,
+    .cpu_type = TYPE_RISCV_CPU,
+    .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_init = TARGET_PAGE_BITS,
+};
+
+target_info_init(target_info_riscv64_system)
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
2.52.0


