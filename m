Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF4DD64060
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVenH-0001Gd-NF; Tue, 16 Dec 2025 18:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen0-0001BK-UK
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:13 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVemw-0006lM-Q9
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Lh6q/PRs+COIODpbn3Lbfbr1eCux7qx9JaD+WFn/UEc=; b=pEIiO57eE1ywOIw
 pFImcnDlO3pk9M6PDmUx8u1Fl8pb72WTSztTRMA8Q11FKOjDGz4xDrzjuShg7CP+cYxisOuvr3bD2
 1XnaKGX04s9X+doBqszDgPWh4O/CdxMuwUMmZ8rtkWGEx9kcglQnvcptIioq7wwd6/wpT4bF0ANwn
 UQ=;
Date: Wed, 17 Dec 2025 00:51:07 +0100
Subject: [PATCH 02/14] hw/riscv: Add macros and globals for simplifying
 machine definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-hw-riscv-cpu-int-v1-2-d24a4048d3aa@rev.ng>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
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

Adds macros and global interfaces for defining machines available only
in qemu-system-riscv32, qemu-system-riscv64, or both.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/riscv/machines-qom.h | 26 ++++++++++++++++++++++++++
 target/riscv/machine.c          | 17 +++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index 6e2c542c87..2254b2dbcc 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -17,4 +17,30 @@
 #define TYPE_TARGET_RISCV64_MACHINE \
         "target-info-riscv64-machine"
 
+/*
+ * Interfaces specifiying wether a given QOM object is available in
+ * qemu-system-riscv32, qemu-riscv-riscv64, or both.
+ */
+
+extern InterfaceInfo riscv32_machine_interfaces[];
+extern InterfaceInfo riscv64_machine_interfaces[];
+extern InterfaceInfo riscv32_64_machine_interfaces[];
+
+/*
+ * Helper macros for defining machines available in qemu-system-riscv32,
+ * qemu-system-riscv64, or both.
+ */
+
+#define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            riscv32_machine_interfaces)
+
+#define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            riscv64_machine_interfaces)
+
+#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            riscv32_64_machine_interfaces)
+
 #endif
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 13eb292c4a..3d2e3968fd 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -23,6 +23,7 @@
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/debug.h"
+#include "hw/riscv/machines-qom.h"
 
 static bool pmp_needed(void *opaque)
 {
@@ -503,3 +504,19 @@ const VMStateDescription vmstate_riscv_cpu = {
         NULL
     }
 };
+
+InterfaceInfo riscv32_machine_interfaces[] = {
+    { TYPE_TARGET_RISCV32_MACHINE },
+    { }
+};
+
+InterfaceInfo riscv64_machine_interfaces[] = {
+    { TYPE_TARGET_RISCV64_MACHINE },
+    { }
+};
+
+InterfaceInfo riscv32_64_machine_interfaces[] = {
+    { TYPE_TARGET_RISCV32_MACHINE },
+    { TYPE_TARGET_RISCV64_MACHINE },
+    { }
+};

-- 
2.51.0


