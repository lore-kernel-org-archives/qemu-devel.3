Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FD0E69E88
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC55-0005l1-U3; Mon, 02 Dec 2024 14:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4u-0005jT-QL
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:29 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4s-0001xv-8Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:27 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id EE6681813AA
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:14 +0100 (CET)
Received: (qmail 7256 invoked by uid 990); 2 Dec 2024 19:27:14 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:14 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH v3 09/11] target/riscv: call plugin trap callbacks
Date: Mon,  2 Dec 2024 20:26:50 +0100
Message-ID: <1f9b7a8c8bca228529957a5ca62ad778870215ff.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.901804) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.001804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=4ZMPM+8dJ9Y3dLwFuA+XfDA4K4aLDiwK7sDI2OBteRM=;
 b=Cu0qkyvh+znyNjz3jL4sRpu57oKBQ5Tj1UzPtNuZMAXr1utoRcgK05xEl/SorY7xkCLVleP8VD
 pfd1/eMAd4H8PwFzR3udEZi9I1/imj2Go7SqZmtYGbaxYMa2e/xiR/rQpzMSZi4hou36YlegAIzS
 +EqdrmGS/xKZOd9Ye6+Ji0u51n+MCr3aXVpvMa3oxlayj3SL4gLuTVKFfTVM/AfuZzy/10UTsYWq
 IM8CUzfgOwCG/ZZIYmyKoUSa/eyc/YdoWNRi9VOWUV8C28NczuIv/SCfrJ2YytY10uo1LP0uRejp
 sr9/pSAKl0ilcV83WNntwz4Z1rlgYNFRPrHvPnzNUWPg4f+YYuKG5H6hMD/lb7da90hGr2ZYSCnr
 HgWvmTyg9I/k/uOMUEQZWM6rBsjO+qxZjK4Q15dQup2MqAN91g413HzbEEKdXpoZAQt2oCDfxCH5
 OHQuU75dgxE4Y7M5nVw5jBIyUkQLVohl8fXPx87BtV3pQ5dxXM4OtvbWIQ41xkSe1yC6kAuq+tqb
 DNtYfh9Wb2q66+dlw2dOz8IutwymwTAciCdvVA67RHY4HYoZBbH61JGPJ5Qiov6G3se+OhWsnN+Q
 iR4PNFqCMciZttTAG0I0858PrPbimuIVglKGVfO5S9/CLvobbe+9ox8BNLB+NosMgA/5/3NNUlLd
 Y=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 target/riscv/cpu_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69ea..6da9bd4629 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -34,6 +34,7 @@
 #include "debug.h"
 #include "tcg/oversized-guest.h"
 #include "pmp.h"
+#include "qemu/plugin.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -1806,6 +1807,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1 << cause));
     bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
         !(env->mip & (1 << cause));
+    uint64_t last_pc = env-> pc;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -1820,6 +1822,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
+            qemu_plugin_vcpu_hostcall_cb(cs, last_pc, env->pc);
             return;
 #endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
@@ -1999,6 +2002,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_M, virt);
     }
 
+    if (async) {
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc, env->pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, last_pc, env->pc);
+    }
+
     /*
      * Interrupt/exception/trap delivery is asynchronous event and as per
      * zicfilp spec CPU should clear up the ELP state. No harm in clearing
-- 
2.45.2


