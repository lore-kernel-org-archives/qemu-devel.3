Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF737CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hyl-0006RM-Hw; Mon, 06 Oct 2025 05:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyc-0006Mr-KE
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:54 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyZ-0003pW-Tf
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:54 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 7CEDC60B7E
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:40 +0200 (CEST)
Received: (qmail 18762 invoked by uid 990); 6 Oct 2025 09:57:40 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:40 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v7 10/25] target/loongarch: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:57:05 +0200
Message-ID: <21a5bf2e810e2c1a3d278ba3ed98f4d4491763cb.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.996214) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.596214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=T8phxctkNXHnTgk9Nb6JHfuj2CnAEADFPzUwA2KJPGI=;
 b=YNKff1zv9VfVWwBRIcECEbxwxaqQoyErVYWQ0R96/rjStO8wgLvxiR5skQv5ucyYYSId+GbqM2
 f1PoFmZ/ETaMqOqO2UzKPV8Djf2x/vQtQCSPjkdpVvbWaRAgqy/IFVCIlYswfwhk7msni8mPBIBO
 aAITPgXleWaJQCrW6mRn+ByT8T2gSsuL4p6fMDc3z3zyH8q7e4zl1EuR26JEZzJp9iQwD3muKjig
 dEPJBOIYnxsJuTQWZMBoCjMnVs64EY3qls01U6C9mRhEo0z1xKPl6jivXHtwRjg0R/JLWEOCWC7p
 gNKm9YhTH0FR1SoMhMQQuuhsXOVHAFKrX+eszDULmvwUEkAIbnMy+dPJaF4YkitSz7jbDvuIpYGb
 LBk2P1YAFbN/4jWb+IhM38/UKG3HBWVO8BQNOHdKfH4JLepLAemJ2J23cjVay0stQrAoegOc2DIs
 FmUouPJmTUzFsN9pbYaKtC5r2/Ff8qbB9BUu1BWWYHbwqwh1O1CnzL/sPKtVmkRSYUQS0ZA5MLVX
 NqBRxBLGe0CA6LgPh6HYecU8rQoRTyUFhyv36wzhItWeLtmurPsBetJcWwvGrOxEUVROSytYwmFU
 Wem23pGgVew4ByyhS2g1CSs+mN0t4qDGO0xb2zQsLL7OgY4tiH7+wqPMQk8TSaVg+EBw203sPLeH
 M=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
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

This change places hooks for loongarch targets. This architecture
has one special "exception" for interrupts and no host calls.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/loongarch/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 993602fb8c..a8299dfee6 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -32,6 +32,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
+#include "qemu/plugin.h"
 #endif
 #include "tcg/tcg_loongarch.h"
 
@@ -172,6 +173,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     int cause = -1;
     bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
     uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
+    uint64_t last_pc = env->pc;
 
     if (cs->exception_index != EXCCODE_INT) {
         qemu_log_mask(CPU_LOG_INT,
@@ -282,6 +284,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       __func__, env->pc, env->CSR_ERA,
                       cause, env->CSR_BADV, env->CSR_DERA, vector,
                       env->CSR_ECFG, env->CSR_ESTAT);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     } else {
         if (tlbfill) {
             set_pc(env, env->CSR_TLBRENTRY);
@@ -300,6 +303,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
                       env->CSR_BADI, env->gpr[11], cs->cpu_index,
                       env->CSR_ASID);
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
     }
     cs->exception_index = -1;
 }
-- 
2.49.1


