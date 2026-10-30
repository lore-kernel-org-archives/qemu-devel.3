Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMd5j-0003CM-GC; Thu, 29 Oct 2026 23:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xMd5f-0003C8-VQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 23:15:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xMd5Y-0000k2-6w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 23:15:36 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxrtLNC+RqB7QaAA--.12214S3;
 Fri, 30 Oct 2026 11:15:26 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxf8_MC+Rqx1sxAA--.39031S2;
 Fri, 30 Oct 2026 11:15:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Support unaligned access for atomic
 instructions
Date: Fri, 30 Oct 2026 11:16:55 +0800
Message-ID: <20261030031655.226617-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxf8_MC+Rqx1sxAA--.39031S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4rCr1xKr4UXFW7Kw1rAFc_yoW5Ww4Upr
 y7u3s8KrW8KrZrA3sYq34YqFn8urn7Cw42qay3t34SkF4Yqr1xXF4kt3yqqFyUGa1kWw1j
 qFnYyw1UXFyUWagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For atomic instructions and LL/SC instruction pairs, the accessed
address must be aligned to the access size. Otherwise, an EXCCODE_ALE
exception is raised.

Add support for unaligned address accesses for these instructions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tcg_cpu.c       |  2 ++
 target/loongarch/tcg/tcg_loongarch.h |  4 ++++
 target/loongarch/tcg/tlb_helper.c    | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index cbf0e12c81..0549506035 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -92,6 +92,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_PME:
     case EXCCODE_PNR:
     case EXCCODE_PPI:
+    case EXCCODE_ALE:
         cause = cs->exception_index;
         break;
     default:
@@ -289,5 +290,6 @@ const TCGCPUOps loongarch_tcg_ops = {
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
+    .do_unaligned_access = loongarch_cpu_do_unaligned_access,
 #endif
 };
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 7fb627f2d6..9c8627972f 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -15,6 +15,10 @@ void loongarch_csr_translate_init(void);
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
+G_NORETURN void loongarch_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                                  MMUAccessType access_type,
+                                                  int mmu_idx,
+                                                  uintptr_t retaddr);
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUContext *context,
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a707de9876..5662b2c49a 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -706,6 +706,22 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
+G_NORETURN void loongarch_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                                  MMUAccessType access_type,
+                                                  int mmu_idx,
+                                                  uintptr_t retaddr)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
+
+    /*
+     * Unaligned accesses are currently triggered by atomic instructions
+     * that impose alignment requirements on memory operands.
+     */
+    sys->CSR_BADV = vaddr;
+    do_raise_exception(env, EXCCODE_ALE, retaddr);
+}
+
 static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
                                                  uint64_t pte)
 {

base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
-- 
2.54.0


