Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0BCA1016
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGsA-0003Wi-Fl; Thu, 04 Sep 2025 16:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGs7-0003VG-Kr
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:55 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGru-0000jV-7B
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:54 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 43C6F60C18
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:22 +0200 (CEST)
Received: (qmail 32657 invoked by uid 990); 4 Sep 2025 20:47:22 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:22 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v6 10/25] target/loongarch: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:47 +0200
Message-ID: <4e0ce5ddc88260c9cd68b2db7e4fb8bf6ba32dda.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.998182) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.598182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=KeckTkY1RcWwX5r8maaZuE9pCKpR4aTRCsXtQinRs+U=;
 b=qcgJU1Ro9nGq5DVwSFDznmPOWtr0ijPpnqyW2KPDXFHbR9/sf0hlc03mz81I0fa3TV6dShKX9X
 Zc2mNmb0wtqL7pzwjUS3BL2QM2SAS249/GFFUBn9Dw5l0XU8fzB6tPc46h4BMe9rdOinh9WNujv8
 KJgFFgXuASECRGkzOQwB7AYyJlwzeEFxtsJZnEDqyQP0MDpk6YoSuS7Gg15RiEcKYCm4+hQJdkoM
 M71Sd9O5TGSYGFlKQbjOnJcPaPahJh7h1L9YPCZYp2GRu4l9FEP9HMy+Jmm+WFWsdtbAoDjKzTyh
 XuYpUveQ1vjkAl5IN2FRriLfVYOyYNT1k4ncWBybDVr7nPj62K3pfGugKmwJsN9X8VLqxdDu16DK
 pYRmbcr46P0ElHYtHZQgCB6PZ52faz3OxtI5nlLSwRWQyuZ7S5xObputneL0rtU6lcK1y0Zdbgfa
 J/HqP87Sqo/5LERnlA7x4RohEJMeTlbPx1UWWkd/+1bhuMMks4bxAg+8WN0Q14wUc6wi/DvL8juc
 k32Vp1jzg4ddawpDNOEeP083aHirohNvA3Fri+XB73Tmnyly88VlzP9G5L/l6rFERk7RH8SPM+MZ
 dEN7gVmKhxE8CAuSj7bpGvbS+/uhzGkOo5GTDDYovLrMr103td6MyOpSJcNMWWb+y85/1M5KEvfx
 Y=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 55ee317bf2..8a8b6d8eaf 100644
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


