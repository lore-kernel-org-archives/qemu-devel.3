Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CCF606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrLB-00073H-SF; Thu, 05 Nov 2026 01:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrL7-00071z-Dm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:49 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xOrL5-0000oE-Ga
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:49 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxX9OzJ+xqao8cAA--.17071S3;
 Thu, 05 Nov 2026 14:52:35 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxKs6zJ+xq_IEyAA--.18062S2;
 Thu, 05 Nov 2026 14:52:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 12/13] target/loongarch: Support unaligned access for atomic
 instructions
Date: Thu,  5 Nov 2026 14:53:44 +0800
Message-ID: <20261105065345.966691-13-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
References: <20261105065345.966691-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxKs6zJ+xq_IEyAA--.18062S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4rGw4DJF1fJr4kXr13GFX_yoW5Ww17pr
 y7u3s8Kr48KrZrJ3sYq34YqFn8urn7Cw42qay3t34S9F4Yqr1xXF4kt3yqqFyUGa1kWw1j
 qFnYyw1UXFyUWagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
 CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84xRDUUUUU==
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

For atomic instructions and LL/SC instruction pairs, the accessed
address must be aligned to the access size. Otherwise, an EXCCODE_ALE
exception is raised.

Add support for unaligned address accesses for these instructions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
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
-- 
2.54.0


