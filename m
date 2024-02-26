Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC78C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reV6u-0004Rh-Po; Mon, 26 Feb 2024 02:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1reV6n-0004Q2-Fe
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:09:07 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1reV6l-0004rH-GK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:09:05 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 41Q78emK018076;
 Mon, 26 Feb 2024 15:08:40 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from alvinga-VirtualBox.andestech.com (10.0.13.68) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Mon, 26 Feb 2024 15:08:38 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v3 1/4] target/riscv: Add functions for common matching
 conditions of trigger
Date: Mon, 26 Feb 2024 15:08:22 +0800
Message-ID: <20240226070825.51120-2-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226070825.51120-1-alvinga@andestech.com>
References: <20240226070825.51120-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.13.68]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41Q78emK018076
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to RISC-V Debug specification version 1.0 [1], there are
several common matching conditions before firing a trigger, including
the enabled privilege levels of the trigger.

This commit adds trigger_common_match() to prepare the common matching
conditions for the type 2/3/6 triggers. For now, we just implement
trigger_priv_match() to check if the enabled privilege levels of the
trigger match CPU's current privilege level.

[1]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asciidoc

Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
 target/riscv/debug.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e30d99cc2f..3891236b82 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -241,6 +241,76 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
     }
 }
 
+/*
+ * Check the privilege level of specific trigger matches CPU's current privilege
+ * level.
+ */
+static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
+                               int trigger_index)
+{
+    target_ulong ctrl = env->tdata1[trigger_index];
+
+    switch (type) {
+    case TRIGGER_TYPE_AD_MATCH:
+        /* type 2 trigger cannot be fired in VU/VS mode */
+        if (env->virt_enabled) {
+            return false;
+        }
+        /* check U/S/M bit against current privilege level */
+        if ((ctrl >> 3) & BIT(env->priv)) {
+            return true;
+        }
+        break;
+    case TRIGGER_TYPE_AD_MATCH6:
+        if (env->virt_enabled) {
+            /* check VU/VS bit against current privilege level */
+            if ((ctrl >> 23) & BIT(env->priv)) {
+                return true;
+            }
+        } else {
+            /* check U/S/M bit against current privilege level */
+            if ((ctrl >> 3) & BIT(env->priv)) {
+                return true;
+            }
+        }
+        break;
+    case TRIGGER_TYPE_INST_CNT:
+        if (env->virt_enabled) {
+            /* check VU/VS bit against current privilege level */
+            if ((ctrl >> 25) & BIT(env->priv)) {
+                return true;
+            }
+        } else {
+            /* check U/S/M bit against current privilege level */
+            if ((ctrl >> 6) & BIT(env->priv)) {
+                return true;
+            }
+        }
+        break;
+    case TRIGGER_TYPE_INT:
+    case TRIGGER_TYPE_EXCP:
+    case TRIGGER_TYPE_EXT_SRC:
+        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n", type);
+        break;
+    case TRIGGER_TYPE_NO_EXIST:
+    case TRIGGER_TYPE_UNAVAIL:
+        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\n",
+                      type);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return false;
+}
+
+/* Common matching conditions for all types of the triggers. */
+static bool trigger_common_match(CPURISCVState *env, trigger_type_t type,
+                                 int trigger_index)
+{
+    return trigger_priv_match(env, type, trigger_index);
+}
+
 /* type 2 trigger */
 
 static uint32_t type2_breakpoint_size(CPURISCVState *env, target_ulong ctrl)
-- 
2.34.1


