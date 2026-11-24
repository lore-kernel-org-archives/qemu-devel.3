Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973D606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl0Y-0005Ip-VK; Tue, 24 Nov 2026 02:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVl0V-0005Hc-VH
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:03 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVl0T-00007z-Md
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:03 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bxd7VsPQVr3XwiAA--.4682S3;
 Tue, 24 Nov 2026 15:31:56 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front2 (Coremail) with SMTP id qciowJAxjn9oPQVrMaYNAA--.317S3;
 Tue, 24 Nov 2026 15:31:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 5/6] target/loongarch: Use raise_exception_full() in
 raise_mmu_exception()
Date: Tue, 24 Nov 2026 15:33:20 +0800
Message-ID: <20261124073321.3015041-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124073321.3015041-1-maobibo@loongson.cn>
References: <20261124073321.3015041-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowJAxjn9oPQVrMaYNAA--.317S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGry7WrW3Jw1kWr1kCryxCrX_yoWrury7pF
 yakFWUGa4rKr9rArZxJ390yF15Zw4xGayIqwnrGryS9ryFqr1Fgr4kZ39rKFy8A34rAw48
 ZFn3ZrW2gF4UCacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Parse the exception flags and badv fields in loongarch_cpu_do_interrupt(),
and use raise_exception_full() from raise_mmu_exception() so that both
flags and badv are passed.

With this change, the relevant CSR registers are set in the common
loongarch_cpu_do_interrupt() path rather than in raise_mmu_exception().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tcg_cpu.c    | 27 +++++++++++++++++++++++++--
 target/loongarch/tcg/tlb_helper.c | 20 ++++----------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index ac56f4ccf4..3d0d6a5a2a 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -44,10 +44,16 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     CPUSysState *sys = env_sys(env);
     bool update_badinstr = 1;
     int cause = -1;
-    bool tlbfill = FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
-    uint32_t vec_size = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS);
+    bool tlbfill;
+    uint32_t vec_size = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS), flags;
     uint64_t last_pc = env->pc;
+    vaddr address;
 
+    flags = env->exception.flags;
+    address = env->exception.badv;
+    env->exception.flags = 0;
+    env->exception.badv = 0;
+    tlbfill = !!(flags & LOONGARCH_EXCEPTION_REFILL);
     if (cs->exception_index != EXCCODE_INT) {
         qemu_log_mask(CPU_LOG_INT,
                      "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
@@ -113,6 +119,15 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
 
     /* Save PLV and IE */
     if (tlbfill) {
+        sys->CSR_TLBRBADV = address;
+        if (is_la64(env)) {
+            sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_64,
+                                        VPPN, extract64(address, 13, 35));
+        } else {
+            sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_32,
+                                        VPPN, extract64(address, 13, 19));
+        }
+
         sys->CSR_TLBRPRMD = FIELD_DP64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
                                        FIELD_EX64(sys->CSR_CRMD,
                                        CSR_CRMD, PLV));
@@ -121,9 +136,17 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         /* set the DA mode */
         sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
         sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
+        sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
         sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA,
                                       PC, (env->pc >> 2));
     } else {
+        if (flags & LOONGARCH_EXCEPTION_TLB) {
+            if (!FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
+                sys->CSR_BADV = address;
+            }
+            sys->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
+        }
+
         sys->CSR_ESTAT = FIELD_DP64(sys->CSR_ESTAT, CSR_ESTAT, ECODE,
                                     EXCODE_MCODE(cause));
         sys->CSR_ESTAT = FIELD_DP64(sys->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 238e9353f4..52ac326df0 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -50,8 +50,7 @@ static G_NORETURN void raise_mmu_exception(CPULoongArchState *env,
                                            TLBRet tlb_error,
                                            uintptr_t retaddr)
 {
-    int32_t excp = 0;
-    CPUSysState *sys = env_sys(env);
+    int32_t excp = 0, flags;
 
     switch (tlb_error) {
     default:
@@ -59,7 +58,6 @@ static G_NORETURN void raise_mmu_exception(CPULoongArchState *env,
         excp = (access_type == MMU_INST_FETCH) ? EXCCODE_ADEF : EXCCODE_ADEM;
         break;
     case TLBRET_NOMATCH:
-        sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
         /* fallthrough */
     case TLBRET_INVALID:
         /* TLB match with no valid bit */
@@ -90,22 +88,12 @@ static G_NORETURN void raise_mmu_exception(CPULoongArchState *env,
     }
 
     if (tlb_error == TLBRET_NOMATCH) {
-        sys->CSR_TLBRBADV = address;
-        if (is_la64(env)) {
-            sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_64,
-                                        VPPN, extract64(address, 13, 35));
-        } else {
-            sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_32,
-                                        VPPN, extract64(address, 13, 19));
-        }
+        flags = LOONGARCH_EXCEPTION_REFILL;
     } else {
-        if (!FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
-            sys->CSR_BADV = address;
-        }
-        sys->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
+        flags = LOONGARCH_EXCEPTION_TLB;
     }
 
-    do_raise_exception(env, excp, retaddr);
+    raise_exception_full(env, excp, retaddr, flags, address);
 }
 
 static void invalidate_tlb_entry(CPULoongArchState *env, int index)
-- 
2.54.0


