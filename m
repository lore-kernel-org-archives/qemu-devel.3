Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D5BC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MhM-0007ME-Nu; Thu, 17 Sep 2026 20:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MhK-0007HZ-GV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:26 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MhG-0001c2-C4
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:26 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc50bcf87b2so55457a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692201; x=1790297001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zN3y/mIpjt/bmBZNPB+r/pIktPtlMB/bFusxpzCBNfs=;
 b=mdtE+beUg3X+HxFsLLk/RBU/8iH/6Yo2iwRbQj/ifc9nwIH008pBz92Wo+PpjAiHdr
 FJ7BSFacLQ6PmcTp3vnbRIDViNuSBdxlsWb+h8Qp8KBAFbMk+/9EpRFLvFZyF+zih9mE
 DVeKn9otGkO0JNh/4lCUi6pD/se3n6TsdJO6XvS6QvttlGdNESPbGABGACPRMK0lXihy
 hBiOAvEnK+NhPQROLDsXzqYLsVmtN/E2ZHD2l2lJdbHWkNQfwZNfRqzgVgHxwqw67m6q
 VUbkH2MkLyC6Ujn6yPLjnWindLCoyXiqYTQIPDZAmhCfBFQpSP5n6TKp7tUdI1EWQzkB
 hYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692201; x=1790297001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zN3y/mIpjt/bmBZNPB+r/pIktPtlMB/bFusxpzCBNfs=;
 b=dsXQNgBIsamoaQA23EE6AqZAqiq/ets4t7CE820LiC3d2sd7c/VXPKC+2ai8GvF4lR
 1t5h1wMmtMTpwzB0w34jbEJkVN4y72Klq+DKdaOiVLZSYgpdTghPjGVs4WiKhVPIwQQG
 pwbNPDv3ZEPWhkmUWVkjMOq1h0Kxp3wgzzLYQgXuK9BQ17C7lgoYk4CoBEgvGUlObueZ
 3KhKz9BMAs5F/mGFyq40bOLtJceA2ag5901R9+RF/0BKfyJ1UgFM2gnMUee26dPiLrax
 15wClxUyxgocG0KLrtJ3BTUQVAaeZp5dGCrUgQDEOCLLNp2JsQ17A4RtezgVJaon4wLR
 kTYw==
X-Gm-Message-State: AFuF++nB8PquXqk6G9kYpZyV2/L4hNsHBL7dHZLxbwyG8e19KGPACYHr
 4/iqNVxFzlyF9QOiBlrDA8EsN8CFJH7AvGBVSufqhqPUFUt8bRzR45NxHE+gLEUv9Eo=
X-Gm-Gg: AYBFou30y34uxv3M+N98YIvANSnbvqHp5qUq3ME+mpaH9aM5SYLBzENDO7/HaSPlgGN
 CXKPwH0aJCu5N02I5CjFd2L0d5RVBvFlvlExySlzO4vfBVc7zCFyqOeH7/IDQW0hOAim0FtRyvb
 s0rdIhwTX+lYkIKD1aIVZbCTjboT3yxUSrVCppUZMrjYqH5T8h8Au2ChN695ZQerbQMlJx+JdCk
 z4x8qBI0r1kquE8G0wRuQzdZYF6r2FmBYkeD0sYWWqyaOjB/Pqi5MNd1Cf1VmrVMfSWqX646fkd
 2qt/NisqxZ5A8sQMuEDsQO3QvHjOD3Arq5Jd/owed3gnkJmYrDbR9TVRvoW6N50R7vPaP5YjKXK
 Ih1hKMfGlqEbNXJwVSIhJL62E3YqQA0b1U5R1zvspKisASLakbN7oCFYvJu6GcqO2/A+JTzRZbp
 A7kY8tpAUWfEbEq7ZUegJ5czzSFO9xnw941YV1OURrGEYVNSbldPScAJZ7zTftGu5HdDdpF0ZFY
 FiYONfahiDZ/Nbo1UO2+PYD5pbQUETG
X-Received: by 2002:a05:6a20:548d:b0:3dd:85a8:cac7 with SMTP id
 adf61e73a8af0-3dd8c44e2famr1245944637.30.1789692200945; 
 Thu, 17 Sep 2026 17:43:20 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:43:20 -0700 (PDT)
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
Subject: [PATCH 05/21] target/sh4: convert raises to raise_excp
Date: Fri, 18 Sep 2026 08:42:07 +0800
Message-ID: <20260918004225.827-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x0e.google.com
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

Name guest trap numbers SH4_EXCP_* in cpu.h. TCG loop codes such as
EXCP_INTERRUPT start at 0x10000. Translate illegal and FPU-disable
through gen_helper_raise_excp. Drop unused raise_* TCG helpers and
the one-line raise_exception wrapper. Keep leftover sleep, trapa,
and exclusive helpers. Exit unaligned and tlb_fill through
cpu_loop_exit_excp. Log reset, manual reset, TLB multiple, and
user break.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/sh4/cpu.h       | 24 +++++++++++++
 target/sh4/helper.c    | 82 +++++++++++++++++++++---------------------
 target/sh4/helper.h    |  4 ---
 target/sh4/op_helper.c | 43 +++-------------------
 target/sh4/translate.c | 17 ++++++---
 5 files changed, 84 insertions(+), 86 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 33027023763..d440aa6dbe7 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -137,6 +137,30 @@ typedef struct memory_content {
     struct memory_content *next;
 } memory_content;
 
+/*
+ * Guest trap numbers in cs->exception_index. TCG loop codes such as
+ * EXCP_INTERRUPT start at 0x10000 in cpu-common.h and do not overlap these.
+ */
+enum {
+    SH4_EXCP_RESET = 0x000,
+    SH4_EXCP_MANUAL_RESET = 0x020,
+    SH4_EXCP_TLB_MISS = 0x040,
+    SH4_EXCP_DTLB_MISS_WRITE = 0x060,
+    SH4_EXCP_INITIAL_PAGE_WRITE = 0x080,
+    SH4_EXCP_TLB_VIOLATION = 0x0a0,
+    SH4_EXCP_DTLB_VIOLATION_WRITE = 0x0c0,
+    SH4_EXCP_ADDR_ERROR = 0x0e0,
+    SH4_EXCP_DATA_WRITE = 0x100,
+    SH4_EXCP_FPU = 0x120,
+    SH4_EXCP_TLB_MULTIPLE = 0x140,
+    SH4_EXCP_TRAPA = 0x160,
+    SH4_EXCP_ILLEGAL_INSTRUCTION = 0x180,
+    SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION = 0x1a0,
+    SH4_EXCP_USER_BREAK = 0x1e0,
+    SH4_EXCP_FPU_DISABLE = 0x800,
+    SH4_EXCP_SLOT_FPU_DISABLE = 0x820,
+};
+
 typedef struct CPUArchState {
     uint32_t flags;             /* general execution flags */
     uint32_t gregs[24];         /* general registers */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b6b057f104b..e22f02a5647 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -70,7 +70,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     do_irq = do_irq && (cs->exception_index == -1);
 
     if (env->sr & (1u << SR_BL)) {
-        if (do_exp && cs->exception_index != 0x1e0) {
+        if (do_exp && cs->exception_index != SH4_EXCP_USER_BREAK) {
             /* In theory a masked exception generates a reset exception,
                which in turn jumps to the reset vector. However this only
                works when using a bootloader. When using a kernel and an
@@ -97,45 +97,57 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         const char *expname;
         switch (cs->exception_index) {
-        case 0x0e0:
+        case SH4_EXCP_RESET:
+            expname = "reset";
+            break;
+        case SH4_EXCP_MANUAL_RESET:
+            expname = "manual_reset";
+            break;
+        case SH4_EXCP_ADDR_ERROR:
             expname = "addr_error";
             break;
-        case 0x040:
+        case SH4_EXCP_TLB_MISS:
             expname = "tlb_miss";
             break;
-        case 0x0a0:
+        case SH4_EXCP_TLB_MULTIPLE:
+            expname = "tlb_multiple";
+            break;
+        case SH4_EXCP_TLB_VIOLATION:
             expname = "tlb_violation";
             break;
-        case 0x180:
+        case SH4_EXCP_ILLEGAL_INSTRUCTION:
             expname = "illegal_instruction";
             break;
-        case 0x1a0:
+        case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
             expname = "slot_illegal_instruction";
             break;
-        case 0x800:
+        case SH4_EXCP_FPU_DISABLE:
             expname = "fpu_disable";
             break;
-        case 0x820:
+        case SH4_EXCP_SLOT_FPU_DISABLE:
             expname = "slot_fpu";
             break;
-        case 0x100:
+        case SH4_EXCP_DATA_WRITE:
             expname = "data_write";
             break;
-        case 0x060:
+        case SH4_EXCP_DTLB_MISS_WRITE:
             expname = "dtlb_miss_write";
             break;
-        case 0x0c0:
+        case SH4_EXCP_DTLB_VIOLATION_WRITE:
             expname = "dtlb_violation_write";
             break;
-        case 0x120:
+        case SH4_EXCP_FPU:
             expname = "fpu_exception";
             break;
-        case 0x080:
+        case SH4_EXCP_INITIAL_PAGE_WRITE:
             expname = "initial_page_write";
             break;
-        case 0x160:
+        case SH4_EXCP_TRAPA:
             expname = "trapa";
             break;
+        case SH4_EXCP_USER_BREAK:
+            expname = "user_break";
+            break;
         default:
             expname = do_irq ? "interrupt" : "???";
             break;
@@ -161,18 +173,18 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (do_exp) {
         env->expevt = cs->exception_index;
         switch (cs->exception_index) {
-        case 0x000:
-        case 0x020:
-        case 0x140:
+        case SH4_EXCP_RESET:
+        case SH4_EXCP_MANUAL_RESET:
+        case SH4_EXCP_TLB_MULTIPLE:
             env->sr &= ~(1u << SR_FD);
             env->sr |= 0xf << 4; /* IMASK */
             env->pc = 0xa0000000;
             break;
-        case 0x040:
-        case 0x060:
+        case SH4_EXCP_TLB_MISS:
+        case SH4_EXCP_DTLB_MISS_WRITE:
             env->pc = env->vbr + 0x400;
             break;
-        case 0x160:
+        case SH4_EXCP_TRAPA:
             env->spc += 2; /* special case for TRAPA */
             /* fall through */
         default:
@@ -632,7 +644,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
                     CPUState *cs = env_cpu(s);
 
                     /* Multiple TLB Exception */
-                    cs->exception_index = 0x140;
+                    cs->exception_index = SH4_EXCP_TLB_MULTIPLE;
                     s->tea = addr;
                     break;
                 }
@@ -828,37 +840,27 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     switch (ret) {
     case MMU_ITLB_MISS:
     case MMU_DTLB_MISS_READ:
-        cs->exception_index = 0x040;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_TLB_MISS, retaddr);
     case MMU_DTLB_MULTIPLE:
     case MMU_ITLB_MULTIPLE:
-        cs->exception_index = 0x140;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_TLB_MULTIPLE, retaddr);
     case MMU_ITLB_VIOLATION:
-        cs->exception_index = 0x0a0;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_TLB_VIOLATION, retaddr);
     case MMU_DTLB_MISS_WRITE:
-        cs->exception_index = 0x060;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_DTLB_MISS_WRITE, retaddr);
     case MMU_DTLB_INITIAL_WRITE:
-        cs->exception_index = 0x080;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_INITIAL_PAGE_WRITE, retaddr);
     case MMU_DTLB_VIOLATION_READ:
-        cs->exception_index = 0x0a0;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_TLB_VIOLATION, retaddr);
     case MMU_DTLB_VIOLATION_WRITE:
-        cs->exception_index = 0x0c0;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_DTLB_VIOLATION_WRITE, retaddr);
     case MMU_IADDR_ERROR:
     case MMU_DADDR_ERROR_READ:
-        cs->exception_index = 0x0e0;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_ADDR_ERROR, retaddr);
     case MMU_DADDR_ERROR_WRITE:
-        cs->exception_index = 0x100;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_DATA_WRITE, retaddr);
     default:
         cpu_abort(cs, "Unhandled MMU fault");
     }
-    cpu_loop_exit_restore(cs, retaddr);
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 29011d3dbbb..593b20c0af2 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -1,8 +1,4 @@
 DEF_HELPER_1(ldtlb, void, env)
-DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
-DEF_HELPER_1(raise_slot_illegal_instruction, noreturn, env)
-DEF_HELPER_1(raise_fpu_disable, noreturn, env)
-DEF_HELPER_1(raise_slot_fpu_disable, noreturn, env)
 DEF_HELPER_1(sleep, noreturn, env)
 DEF_HELPER_2(trapa, noreturn, env, i32)
 DEF_HELPER_1(exclusive, noreturn, env)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 777380f8e40..535bffb08f1 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -33,15 +33,12 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     switch (access_type) {
     case MMU_INST_FETCH:
     case MMU_DATA_LOAD:
-        cs->exception_index = 0x0e0;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_ADDR_ERROR, retaddr);
     case MMU_DATA_STORE:
-        cs->exception_index = 0x100;
-        break;
+        cpu_loop_exit_excp(cs, SH4_EXCP_DATA_WRITE, retaddr);
     default:
         g_assert_not_reached();
     }
-    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #endif
@@ -55,49 +52,19 @@ void helper_ldtlb(CPUSH4State *env)
 #endif
 }
 
-static inline G_NORETURN
-void raise_exception(CPUSH4State *env, int index,
-                     uintptr_t retaddr)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = index;
-    cpu_loop_exit_restore(cs, retaddr);
-}
-
-void helper_raise_illegal_instruction(CPUSH4State *env)
-{
-    raise_exception(env, 0x180, 0);
-}
-
-void helper_raise_slot_illegal_instruction(CPUSH4State *env)
-{
-    raise_exception(env, 0x1a0, 0);
-}
-
-void helper_raise_fpu_disable(CPUSH4State *env)
-{
-    raise_exception(env, 0x800, 0);
-}
-
-void helper_raise_slot_fpu_disable(CPUSH4State *env)
-{
-    raise_exception(env, 0x820, 0);
-}
-
 void helper_sleep(CPUSH4State *env)
 {
     CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     env->in_sleep = 1;
-    raise_exception(env, EXCP_HLT, 0);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 }
 
 void helper_trapa(CPUSH4State *env, uint32_t tra)
 {
     env->tra = tra << 2;
-    raise_exception(env, 0x160, 0);
+    cpu_loop_exit_excp(env_cpu(env), SH4_EXCP_TRAPA, 0);
 }
 
 void helper_exclusive(CPUSH4State *env)
@@ -255,7 +222,7 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
         cause = (env->fpscr & FPSCR_CAUSE_MASK) >> FPSCR_CAUSE_SHIFT;
         enable = (env->fpscr & FPSCR_ENABLE_MASK) >> FPSCR_ENABLE_SHIFT;
         if (cause & enable) {
-            raise_exception(env, 0x120, retaddr);
+            cpu_loop_exit_excp(env_cpu(env), SH4_EXCP_FPU, retaddr);
         }
     }
 }
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 373950fd662..a439be4c74e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1765,10 +1765,15 @@ static void _decode_opc(DisasContext * ctx)
     if (ctx->envflags & TB_FLAG_DELAY_SLOT_MASK) {
  do_illegal_slot:
         gen_save_cpu_state(ctx, true);
-        gen_helper_raise_slot_illegal_instruction(tcg_env);
+        gen_helper_raise_excp(tcg_env,
+                              tcg_constant_i32(
+                                  SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION),
+                              tcg_constant_i32(0));
     } else {
         gen_save_cpu_state(ctx, true);
-        gen_helper_raise_illegal_instruction(tcg_env);
+        gen_helper_raise_excp(tcg_env,
+                              tcg_constant_i32(SH4_EXCP_ILLEGAL_INSTRUCTION),
+                              tcg_constant_i32(0));
     }
     ctx->base.is_jmp = DISAS_NORETURN;
     return;
@@ -1776,9 +1781,13 @@ static void _decode_opc(DisasContext * ctx)
  do_fpu_disabled:
     gen_save_cpu_state(ctx, true);
     if (ctx->envflags & TB_FLAG_DELAY_SLOT_MASK) {
-        gen_helper_raise_slot_fpu_disable(tcg_env);
+        gen_helper_raise_excp(tcg_env,
+                              tcg_constant_i32(SH4_EXCP_SLOT_FPU_DISABLE),
+                              tcg_constant_i32(0));
     } else {
-        gen_helper_raise_fpu_disable(tcg_env);
+        gen_helper_raise_excp(tcg_env,
+                              tcg_constant_i32(SH4_EXCP_FPU_DISABLE),
+                              tcg_constant_i32(0));
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 }
-- 
2.52.0.windows.1


