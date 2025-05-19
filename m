Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E51C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2IM-0006yb-IA; Mon, 19 May 2025 11:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2ID-0006u1-1T
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:41 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I9-0005Tr-8I
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:40 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 4D89F180E9A
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:25 +0200 (CEST)
Received: (qmail 1482 invoked by uid 990); 19 May 2025 15:20:25 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:25 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Song Gao <gaosong@loongson.cn>
Subject: [PATCH v5 10/25] target/loongarch: call plugin trap callbacks
Date: Mon, 19 May 2025 17:19:50 +0200
Message-ID: <3f021f55b98787ad5aac1532b18bb3fa05ea2741.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.996607) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.596607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=yldsQFmqI/dBr3jxFE+4gAW3CyvhrG6GnBZ0Wg++zfk=;
 b=IjXh9jsPVpT1czpYqD/+CsZx0aj/4wGyQZZFwpuvjAYhhJ0tS7fNWG1w5vNAgbDl7Ez5CpOmV/
 VLAD8mZ0Q3BRRiYowHq2pNlmBxMVKn08j48H+ckt/SzGyYK06N8gRSE1f3Gry8nsw7BfiGWMeYF1
 NnGjQ8LoZLqj/nOWsrHp2EcW342NXxVFOiRJPJBAqaqlRw+qWqhVR7TxmB7HF1YogfpFIjyaI4iV
 KYyP3GcmA5OIN/VSrnFOgNhJKgJuBSwtBmvr+gyQTGplcXfdszYrUGUMNbdEE4uXtdd9gFSzji1i
 6RtLo3O1b99tAweWcqbA+9ymIt6tn8nST70axrSdfE+/cI4CbYBLEWsL3YQATcc/gimn8EKoQYz3
 GmetegTaR3I5xyIxAXFia/5PqO7ECr+WZwxyGHKJJu3T4EeBbdWSkheMdIdmsRYNUO0ZKviZeBMs
 DKINdM5TnF38/vI8Kn+rMUTJKvQEOy/gbQ6wl1epE3XWE2jE31AwGcr9PkzRuXGytJNwX8MUJbjp
 sRkjiCijwdotTSgEMTe4h1dFUquYqVxOo50pK9Y9CzZoePUagvtq5aNpC5ArZFWmaMa8oSpz1tnF
 8E2LY9hE2RR2LBapQ0vGVaUjoiiCPtlYbx0SYCy0UfTUvBtQk2ayApXtXowfiPmlCcvtkeDkqtAG
 w=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/loongarch/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f7535d1be7..d1ed56d15e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -31,6 +31,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
+#include "qemu/plugin.h"
 #endif
 #include "tcg/tcg_loongarch.h"
 
@@ -171,6 +172,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     int cause = -1;
     bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
     uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
+    uint64_t last_pc = env->pc;
 
     if (cs->exception_index != EXCCODE_INT) {
         qemu_log_mask(CPU_LOG_INT,
@@ -281,6 +283,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       __func__, env->pc, env->CSR_ERA,
                       cause, env->CSR_BADV, env->CSR_DERA, vector,
                       env->CSR_ECFG, env->CSR_ESTAT);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     } else {
         if (tlbfill) {
             set_pc(env, env->CSR_TLBRENTRY);
@@ -299,6 +302,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
                       env->CSR_BADI, env->gpr[11], cs->cpu_index,
                       env->CSR_ASID);
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
     }
     cs->exception_index = -1;
 }
-- 
2.49.0


