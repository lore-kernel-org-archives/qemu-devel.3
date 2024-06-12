Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2BBC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 10:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLeZ-00064y-KR; Wed, 12 Jun 2024 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeY-000648-7h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:30 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeW-0001BM-Lr
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:29 -0400
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 087F84078500;
 Wed, 12 Jun 2024 10:56:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 087F84078500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718189771;
 bh=6017pkE0nWD/CVliCw8GvEnKrz8x4MV+liKB3iJh2Mc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KRtrfzW8w+lZX9srk6xejQMO5R6J7Ls8PPF4fyRZLbJDcMuKB64P1I2ksyQ9J/N6x
 GpDdeyw8DtJujUopcQbyySjgKgvX6IGUe1jxcAbUuMEsHNmfJsQH6Q5iJu1L0B4LNi
 OZ6TTIW22YDnS+8Nt4zQP5J5K+nQ2uX/trSrboKE=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 4/5] Revert "host/i386: assume presence of CMOV"
Date: Wed, 12 Jun 2024 13:55:24 +0300
Message-Id: <20240612105525.8795-5-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240612105525.8795-1-amonakov@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This reverts commit e68e97ce55b3d17af22dd62c3b3dc72f761b0862.

Revert in preparation to rolling back x86_64-v2 ISA requirement.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 host/include/i386/host/cpuinfo.h |  1 +
 tcg/i386/tcg-target.c.inc        | 15 ++++++++++++++-
 util/cpuinfo-i386.c              |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 81771733..9386c749 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -9,6 +9,7 @@
 /* Digested version of <cpuid.h> */
 
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_CMOV            (1u << 1)
 #define CPUINFO_MOVBE           (1u << 2)
 #define CPUINFO_LZCNT           (1u << 3)
 #define CPUINFO_POPCNT          (1u << 4)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9a54ef7f..59235b4f 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -157,6 +157,12 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define SOFTMMU_RESERVE_REGS \
     (tcg_use_softmmu ? (1 << TCG_REG_L0) | (1 << TCG_REG_L1) : 0)
 
+/* For 64-bit, we always know that CMOV is available.  */
+#if TCG_TARGET_REG_BITS == 64
+# define have_cmov      true
+#else
+# define have_cmov      (cpuinfo & CPUINFO_CMOV)
+#endif
 #define have_bmi2       (cpuinfo & CPUINFO_BMI2)
 #define have_lzcnt      (cpuinfo & CPUINFO_LZCNT)
 
@@ -1809,7 +1815,14 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
-    tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
+    if (have_cmov) {
+        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
+    } else {
+        TCGLabel *over = gen_new_label();
+        tcg_out_jxx(s, jcc ^ 1, over, 1);
+        tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
+        tcg_out_label(s, over);
+    }
 }
 
 static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 90f92a42..18ab747a 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,6 +34,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
+        info |= (d & bit_CMOV ? CPUINFO_CMOV : 0);
         info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
-- 
2.32.0


