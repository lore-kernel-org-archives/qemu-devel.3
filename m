Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB8EC3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WL-0006kf-Vm; Sun, 11 May 2025 09:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WG-0006UD-Na
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:04 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WE-0006qg-8R
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:04 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 1CEB3180070
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:51 +0200 (CEST)
Received: (qmail 26131 invoked by uid 990); 11 May 2025 13:14:51 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:50 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v4 16/23] target/riscv: call plugin trap callbacks
Date: Sun, 11 May 2025 15:14:08 +0200
Message-ID: <40c7216b842b7d06a0b947a7eee7cc11b9305b15.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.987116) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.587116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=VQ+IG/WFqsioJzIjPbJB/PWrUssDhf/OuDz5jcwCvrA=;
 b=pO4wC1L0LVTOmGefFMPY1F5Aw/6ASZ+DzBsL5lj12DsTQdzjXhkzcfYoLiHq2tTq+r1oRYatTK
 WO727jwwxmy5f7ug0SUcuUx+ALqTxI7e4CvizNx7Q3NJns3slliR9xCWsT0Z13D5yBUnEH2F0kCi
 Ip+w9G5FN3BMGDrVhlT9e+3Ms/tJ6dhNrwWRUAJEVS2iPNgvnCD3x8YIXz3LXzYh9q+DxVhmt6hm
 mRvmmL409voYi213kU/Rdg/PRM0s6nEykoEI/z729bpCdWqXCtCMsnEA3v0uqdSCKMDhDJ8M0LBu
 1jcRutQhKB6rdbuekRVAZQ0Y3D9b0RjjFDFfLNeTnP36mDZgNYuKIprRBdgwouhhVXe4csoI9fma
 SgGTapg18Brg/ZA3zPwju3lPhX0LSWOHx6hx++PJozCKdq3APuOmhOYfZEe4vOQ7YIgvUGvFtaUW
 LkSOCSj16pEsw77KTrg/zLb6k7ATQnZq7/Fmw1uDZfCKd65D3bp+grNm8Fma3JRH8iM1S2faaA8X
 MQi9eFl1UwPWrXT1dVQbEI4S+mqlrxom6Cvz4nCu5XfefLz2bPz9H0Im1habnsB0/4fQoKuBvFxu
 mG/6vSRXAE4FZ70X8dayQ2upWcDrWf7vWGHFSAH+j8/C1kAUq87kjUi5Kpo2KjKhv//3P5imrVjx
 U=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/riscv/cpu_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d5039f69a9..dce7e34cba 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -36,6 +36,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "pmp.h"
+#include "qemu/plugin.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -2173,6 +2174,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     const bool prev_virt = env->virt_enabled;
     const target_ulong prev_priv = env->priv;
+    uint64_t last_pc = env->pc;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -2195,6 +2197,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
+            qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
             return;
 #endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
@@ -2464,6 +2467,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
2.49.0


