Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB7AC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 03:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMfci-0003iv-CS; Wed, 26 Jun 2024 23:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sMfch-0003bA-1q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 23:16:35 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sMfcf-00020v-1J
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 23:16:34 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 45R3G8LY097223;
 Thu, 27 Jun 2024 11:16:08 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from atctrx.andestech.com (10.0.15.190) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 11:16:08 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v6 2/3] target/riscv: Apply modularized matching conditions
 for watchpoint
Date: Thu, 27 Jun 2024 11:14:32 +0800
Message-ID: <20240627031433.2216509-3-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627031433.2216509-1-alvinga@andestech.com>
References: <20240627031433.2216509-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.190]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 45R3G8LY097223
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

We have implemented trigger_common_match(), which checks if the enabled
privilege levels of the trigger match CPU's current privilege level.
Remove the related code in riscv_cpu_debug_check_watchpoint() and invoke
trigger_common_match() to check the privilege levels of the type 2 and
type 6 triggers for the watchpoints.

This commit also changes the behavior of looping the triggers. In
previous implementation, if we have a type 2 trigger and
env->virt_enabled is true, we directly return false to stop the loop.
Now we keep looping all the triggers until we find a matched trigger.

Only load/store bits and loaded/stored address should be further checked
in riscv_cpu_debug_check_watchpoint().

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 11125f33..c290d600 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -901,13 +901,12 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     for (i = 0; i < RV_MAX_TRIGGERS; i++) {
         trigger_type = get_trigger_type(env, i);
 
+        if (!trigger_common_match(env, trigger_type, i)) {
+            continue;
+        }
+
         switch (trigger_type) {
         case TRIGGER_TYPE_AD_MATCH:
-            /* type 2 trigger cannot be fired in VU/VS mode */
-            if (env->virt_enabled) {
-                return false;
-            }
-
             ctrl = env->tdata1[i];
             addr = env->tdata2[i];
             flags = 0;
@@ -920,10 +919,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                /* check U/S/M bit against current privilege level */
-                if ((ctrl >> 3) & BIT(env->priv)) {
-                    return true;
-                }
+                return true;
             }
             break;
         case TRIGGER_TYPE_AD_MATCH6:
@@ -939,17 +935,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                if (env->virt_enabled) {
-                    /* check VU/VS bit against current privilege level */
-                    if ((ctrl >> 23) & BIT(env->priv)) {
-                        return true;
-                    }
-                } else {
-                    /* check U/S/M bit against current privilege level */
-                    if ((ctrl >> 3) & BIT(env->priv)) {
-                        return true;
-                    }
-                }
+                return true;
             }
             break;
         default:
-- 
2.34.1


