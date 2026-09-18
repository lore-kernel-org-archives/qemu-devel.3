Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A91C982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mid-0000Wp-HQ; Thu, 17 Sep 2026 20:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MiB-00085a-HU
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:22 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mi7-0001mX-Ny
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:19 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso189827a91.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692253; x=1790297053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1gnL1JyC3NjkayeZ4obve1TRdpMg5uqR4VfKbNdZA00=;
 b=BYsiRIJltqBhOc9w/VKe4aej12c+M9T0CEBP55yKua71gVi/F+D4g8U4M3w0LKGtCx
 CCxPKDP9Rm2n4zTagD7F0sosSRzPH7pznJO2xaDGUrncj+9UBUV+kH5tSt/yfev8uK4U
 KYvjtFGi8EtJxVwMZDwhu7mq6hsEdMKcweX5nAatWkMM2xivt4Kr32fBMMAOY0jWP+UK
 0n2GPGJjOsclXjXWvClE8bxTSZ/cxYXRfEjruCDtnU4csy0fWK/clbsgUfmmAIIVr7Zs
 X6QggROAQEQAij8269A20y0GR8Q8A4TfIpwRBtVly1KLWE0oZoMqdhceAb2X9RUh1ugO
 3rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692253; x=1790297053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1gnL1JyC3NjkayeZ4obve1TRdpMg5uqR4VfKbNdZA00=;
 b=tnd/uDtaazMIzS1w5x9CBgysoegSJsp0bk9u+tpMFIPrhsT1HoVN0fJ39ku3kUXWeX
 kfHERZ9oQRU17uxMLqNQOK8ffnb5UpKc3r9mnToZungFheaZlaj1Yhj2HVIUtLHwBVCO
 kGxMnTyKN4pJb0Y7Ok0liogtVMdy+nva8MyqZmMlMnfPCAmpDm3F0hE3/sOfjstc6/es
 CNvl3x+/hPOZnbtEHU3g2HcyNmKZrLwIz4/fV3enizzlkCneeBZQERfU6SDC5ZdIfpUV
 dRcRFC0PQPa7sh7nsPEGJXsxW+IkoIF24GtbdSOnWilRBOKwHlTxtHn5cbTWx1Ejy6Iy
 0sTA==
X-Gm-Message-State: AFuF++mi4vFq69gzTcgiHDsCdCtqnyhAYQaiuw7IyLZNNLXPXIbQbOXR
 9729ZgrW8iB7+Gu5vTM21rQBcgGVKYMXGr23HrgEPYc+mr90/4mI5TzgnYPlGm/D
X-Gm-Gg: AYBFou1wJXWItBlSGJ9Scx73hCCnYbl1UeVxWQ/9OBUrdVkKEQ1fjeYtHTOM/Vu4YCl
 NtWDbEp2y8ukm+gJKboaaNjaBWdqy635z5lwbFnOtTAcWOOmpzkhT/iFYW/VdY1wQiNuQU98syU
 UTqJ/Dksxqj/21s1wQYTLkoHZE41qvVvhc15GHuUtINQkU2duhqG6eR9qJod4J0+QK6C81EUXPO
 ZtsF/vL5tA3b3nnQAwl/0TYWVzoyTnAjeAmwqWMjubTp/Dl5AU8HQGGk2pNuEG5S0ai6fteOnLb
 XYUg6o4Mw56fU0b5a2ASIxFUW3n+5ja4WA4+BtyGMQK6NqXir8TPCyOxaxKh4Owxv+j40Q4sCC6
 iNh+eMO5oEW416J8htjaAA8hEWTuNct89zcAmpWcTZmiudEGzfEmfnsAjgk7ErHPk3Kgv7YspBo
 O+lPogrWy1e3tXqt400c3jyzs+bcrD7xjLRZc3qO3JR/U0tfxcw/sSZo4ZNDfPoT1u1OI51MQjX
 hlQk7spDgkZxhxVGR5+bwWSmRnGqdJ5
X-Received: by 2002:a17:90b:3c05:b0:39e:218c:d47c with SMTP id
 98e67ed59e1d1-39e54f42eddmr2733876a91.9.1789692252589; 
 Thu, 17 Sep 2026 17:44:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:44:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 11/21] target/hexagon: convert raise_exception to
 hexagon_raise_exception
Date: Fri, 18 Sep 2026 08:42:13 +0800
Message-ID: <20260918004225.827-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fold C do_raise_exception into hexagon_raise_exception_err with
vaddr pc and a retaddr parameter, and exit via cpu_loop_exit_excp.
Prefix leftover TCG raise_exception to hexagon_raise_exception so
translate keeps the CPU_LOG_INT log and ASSERT_DIRECT_TO_GUEST_UNSET.
Prefix leftover TCG wait to hexagon_wait with vaddr pc.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/hexagon/cpu.c         | 13 +++++++------
 target/hexagon/cpu.h         |  2 +-
 target/hexagon/gen_tcg_sys.h |  2 +-
 target/hexagon/helper.h      |  5 +++--
 target/hexagon/internal.h    |  5 -----
 target/hexagon/macros.h      |  2 +-
 target/hexagon/op_helper.c   | 37 +++++++++++++++---------------------
 target/hexagon/translate.c   | 11 ++++++-----
 8 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index fad526ccfb5..0d2441b1671 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -333,7 +333,7 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
     }
     if (pc & PCALIGN_MASK) {
         env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
-        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc);
+        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc, 0);
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -711,14 +711,15 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
             return false;
         }
         raise_perm_exception(cs, address, slot, access_type, excp);
-        do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
-                           retaddr);
+        hexagon_raise_exception_err(env, cs->exception_index,
+                                    env->gpr[HEX_REG_PC], retaddr);
     }
     if (probe) {
         return false;
     }
     raise_tlbmiss_exception(cs, address, slot, access_type);
-    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC], retaddr);
+    hexagon_raise_exception_err(env, cs->exception_index,
+                                env->gpr[HEX_REG_PC], retaddr);
 }
 
 #include "hw/core/sysemu-cpu-ops.h"
@@ -761,8 +762,8 @@ void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     CPUHexagonState *env = cpu_env(cs);
 
     raise_misaligned_exception(cs, addr, 0, access_type);
-    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
-                       retaddr);
+    hexagon_raise_exception_err(env, cs->exception_index,
+                                env->gpr[HEX_REG_PC], retaddr);
 }
 
 #endif
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index b1533680bd7..e79d8000304 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -210,7 +210,7 @@ FIELD(TB_FLAGS, PCYCLE_ENABLED, 4, 1)
 
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
-                                            uintptr_t pc);
+                                            vaddr pc, uintptr_t retaddr);
 
 #ifndef CONFIG_USER_ONLY
 /*
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index af5032214c4..489d2780470 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
+        gen_helper_hexagon_wait(tcg_env, tcg_constant_vaddr(ctx->pkt.pc)); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 71c8da4c46d..cf1b977f33c 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,8 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
+DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn,
+                   env, i32, vaddr)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
@@ -136,7 +137,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_2(wait, void, env, i32)
+DEF_HELPER_2(hexagon_wait, void, env, vaddr)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 05d1129916e..4b7a784fbc7 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -36,11 +36,6 @@ extern const char * const hexagon_sregnames[];
 extern const char * const hexagon_gregnames[];
 #endif
 
-void G_NORETURN do_raise_exception(CPUHexagonState *env,
-        uint32_t exception,
-        uint32_t PC,
-        uintptr_t retaddr);
-
 #define hexagon_cpu_mmu_enabled(env) ({ \
     HexagonCPU *cpu = env_archcpu(env); \
     cpu->globalregs ? \
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index a5b9c24c6bb..4a87f6d72f1 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -637,7 +637,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #ifdef CONFIG_USER_ONLY
 #define fTRAP(TRAPTYPE, IMM) \
     do { \
-        hexagon_raise_exception_err(env, HEX_EVENT_TRAP0, PC); \
+        hexagon_raise_exception_err(env, HEX_EVENT_TRAP0, PC, 0); \
     } while (0)
 #endif
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 0d08ac77361..715dfd3ce13 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -72,31 +72,24 @@ uint64_t HELPER(utimer)(void)
 #define SF_MANTBITS    23
 
 /* Exceptions processing helpers */
-G_NORETURN
-void do_raise_exception(CPUHexagonState *env, uint32_t exception,
-                        uint32_t PC, uintptr_t retaddr)
+G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
+                                            uint32_t exception,
+                                            vaddr pc, uintptr_t retaddr)
 {
     CPUState *cs = env_cpu(env);
-    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08" PRIx32 ", @ %08" PRIx32 "\n",
-                  __func__, exception, PC);
+    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08" PRIx32 ", @ %08" VADDR_PRIx "\n",
+                  __func__, exception, pc);
     ASSERT_DIRECT_TO_GUEST_UNSET(env, exception);
 
-    env->gpr[HEX_REG_PC] = PC;
-    cs->exception_index = exception;
-    cpu_loop_exit_restore(cs, retaddr);
-}
-
-G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
-                                            uint32_t exception,
-                                            uintptr_t pc)
-{
-    do_raise_exception(env, exception, pc, 0);
+    env->gpr[HEX_REG_PC] = pc;
+    cpu_loop_exit_excp(cs, exception, retaddr);
 }
 
-G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
-                                        uint32_t PC)
+G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env,
+                                                uint32_t exception,
+                                                vaddr pc)
 {
-    hexagon_raise_exception_err(env, excp, PC);
+    hexagon_raise_exception_err(env, exception, pc, 0);
 }
 
 void log_store32(CPUHexagonState *env, target_ulong addr,
@@ -1733,7 +1726,7 @@ static void set_wait_mode(CPUHexagonState *env)
     SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
 }
 
-static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
+static void hexagon_wait_thread(CPUHexagonState *env, vaddr pc)
 {
     CPUState *cs;
 
@@ -1760,7 +1753,7 @@ static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
         return;
     }
     set_wait_mode(env);
-    env->wait_next_pc = PC + 4;
+    env->wait_next_pc = pc + 4;
 
     cpu_interrupt(cs, CPU_INTERRUPT_HALT);
 }
@@ -1828,12 +1821,12 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
+void HELPER(hexagon_wait)(CPUHexagonState *env, vaddr pc)
 {
     BQL_LOCK_GUARD();
 
     if (!fIN_DEBUG_MODE(env->threadId)) {
-        hexagon_wait_thread(env, PC);
+        hexagon_wait_thread(env, pc);
     }
 }
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index fd1de87405c..2774a01a47c 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -129,11 +129,12 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
     return offset;
 }
 
-static void gen_precise_exception(int cause, uint32_t PC)
+static void gen_precise_exception(int cause, vaddr pc)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
-                               tcg_constant_i32(PC));
+    gen_helper_hexagon_raise_exception(tcg_env,
+                                       tcg_constant_i32(HEX_EVENT_PRECISE),
+                                       tcg_constant_vaddr(pc));
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1071,11 +1072,11 @@ static void update_exec_counters(DisasContext *ctx)
  */
 static void check_imprecise_exception(DisasContext *ctx)
 {
-    TCGv PC = tcg_constant_tl(ctx->pkt.pc);
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception,
+                                       tcg_constant_vaddr(ctx->pkt.pc));
     gen_set_label(label);
 }
 #endif
-- 
2.52.0.windows.1


