Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF6CCCD183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9S-00022O-Br; Sun, 19 Oct 2025 11:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9R-000227-1m
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:53 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9P-0003Dw-Ka
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:52 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 84C7960A75
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:50 +0200 (CEST)
Received: (qmail 23451 invoked by uid 990); 19 Oct 2025 15:16:50 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:46 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v8 16/25] target/riscv: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:05 +0200
Message-ID: <f34d6b43caf46a8fbae929304becb328557259f6.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999754) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=6jnG3wDchPvR9iC7OeKM71ZvHzTjOj/B4aMwSwCZlYo=;
 b=szwEy84c3FUEIJkSNjqg9PDfgXn7Vh/sKNgXYx6w63CqTgyEoGIiBKGAKWmF56iY9L/Sxg9yCv
 iDQhye0kBizrq0rugog+Rb3ks+K8PPijsYCRGNmuG21uuLdD3erPT+OqQllcHRAw+Rr55XLF57T4
 UlpohLXenk3w9fUkCbgJiN6Wgp8oF8fjJ8rwYfDyOU9hD1nCCzi/2rqRf9qxtlGd9XpP3VZB9IBS
 QWfwr9/5JuPl2LD7WQxo4U1HVDNYCPKJMQ2ajKYVEKlHva6bAgJQ6wsfqrZ0VSe4hiqarVNaf65d
 Qb1tQDj7ptEDGDUUXtK8ygCmqeLKb6w9kvz4PLf3pEjc19xSrUk/OiTvCGABsjwCBRsE6o4DhaGq
 lls4DirGBWVe2ClHFdKZ4S0PWPTJpDTyIQNhZXoaoS6q/g7Blnpt6VWYkN6DCH1PelFdLzCqLSqm
 Usulzl+dl6XPq87uvS0yohWQWO2ToEWEALWSpJesLoKnhHtly5khDr8yLvc5ypuirRRVdOtKbww2
 tBObHxOfSRCZkVfb69xHT7RyCeH2MLSVwzASvEKsGFRhqMQN/R9SybffL2y76LWwxe/8Q7io61qk
 Rjnb0tYovQBi95RfZmI/RvaToVgQvbpzX1eXe9EMGwIWuYAHxwbKZYqQf6BsyL1ML8i8D+U5XuT6
 M=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for RISC-V targets.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/riscv/cpu_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3479a62cc7..10a10dcd90 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -36,6 +36,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "pmp.h"
+#include "qemu/plugin.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -2176,6 +2177,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     const bool prev_virt = env->virt_enabled;
     const target_ulong prev_priv = env->priv;
+    uint64_t last_pc = env->pc;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -2198,6 +2200,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
+            qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
             return;
 #endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
@@ -2467,6 +2470,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                         prev_priv, prev_virt);
     }
 
+    if (async) {
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
+
     /*
      * Interrupt/exception/trap delivery is asynchronous event and as per
      * zicfilp spec CPU should clear up the ELP state. No harm in clearing
-- 
2.49.1


