Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF882CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChTP-0006pj-Mv; Fri, 02 Oct 2026 13:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQ8-00046E-P2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:45 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQ3-0007Ms-Hn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:44 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-142dd04be84so9319237c88.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963497; x=1791568297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PgJUSeNzfpTZJWKv8Z1tYcQOVnoJ00PGHXu3FD5a7b8=;
 b=dXE3gDjwglvbxZojROo4YO5XvTL+xG9kpwiReBCG9umaibigFGmI0vmgjCdMFg5NTw
 zBAyTaVkAEnzgszigIjchjsSKRCRLxCQsbQo8NNNPD7KWXDIKQZkgbBCpwxBwaNKxuI2
 i0PjQgF6ytyb9Ppe8+Sx7I7fyjTjFMpl9xDj3Vb2sAWcEnH6JN5cpgGsjT+VW23w1Ufz
 xkQYQ/h5jbTe81aEtkPQv0bmiQAnwCO8HV1/qfdHGAKYBLwfFJ9HpBXNblIPMEGD2bNA
 HKxHWFHqFSe2rMCN6Jox/NLv3TY0MeQTio2I5cfY+8v5VNQLVmhMKHAcG0wpt9h9+Wdj
 dX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963497; x=1791568297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PgJUSeNzfpTZJWKv8Z1tYcQOVnoJ00PGHXu3FD5a7b8=;
 b=pfR3vQNQe2AzcrRhGgXIfII//4VWdGW0fAdV/twXUkcxqkv5n0bBXhpWHKayVjUzwg
 PO7D2IwMvR0QkOQ4ykFBadxLkKObsOyNLkU5yfBkBeDI4UYnuGAY7ecWPKoTJzjofQ8o
 +HtyvVCs6BmsgFJl1QIhMMm3GO23qhVTXc9KW1xS0dr1Mv5G+vDCxZBVE56+Xdw0qf32
 EZDLRJ8wWmxYudO6yzUqkcQxLh3g+xI5DX2dd1D/eIoJb2teAVSILJT8NFdYU3Teuyrj
 CbZXgSXliVKAVR0xHhzaDY3PQJQgsyuy47Tg2SmlySbbrsA5EjKGtaKfg1I3nDQuJyIk
 /5xg==
X-Gm-Message-State: AFuF++mZ/2iSPGUY5yCdyIXzU+RDF1HiUuwMvzcHdZ3loZB2tUlJbsJ3
 GdupC0cqt4tCAan9lNz+8SDqAw1xzHaNZt/TV+sGCGWTDB8Lekw/z3kdTkjVE6Vv/+I=
X-Gm-Gg: AYBFou10of7+NUTufZodlPCI6+YL+X+ZpMYBWCcn+0WAU37d+nNWQsCHM15yzOrKjF8
 jFPu8JJh0AKLiwIOeLfef+DhPruteDNR6qdmwze/eIOSrFghMJpgzA02pHCTEm7AAj3j0mJnGsU
 sqpZghIEzwFEz/OKT5wf7PZf7ezixKPUibA+g8/O+jo+VaR/YGPyTeoOgXFqNb/kx1mzeftc4MH
 GGWiZqMpN2RZtp8DKOie20cYkpMQo472Hok08kEZfUdTQxvxE9g+16ZseLWqihHpUqL1JVew7hT
 9VWsqyhs0zBK/nOYgWmppcoqf4Siwbllc/fjelHL9u+vZ0HI7Mq8masiSs9rGe+EChQoG7Sp2NE
 Oqs71YmXOBFc3td+9H/9Iqd41ijTPbByVaAlYuhlWr59e3XsVqftn45i7YglrVCTfO3rWZEYga0
 DLvkBOHrccKYBFzd8/5M6njsgbTREdQ49bRoDqyIsMdrOGhE3UOPebhDa3zL7I5vQtTah+dQbhZ
 ng6MFKCZlxJCw7I/dnv2/OUgZyNkjNLC1WgqAo0eA==
X-Received: by 2002:a05:7022:f90b:b0:14c:be8e:69f2 with SMTP id
 a92af1059eb24-14f5c2ee7bfmr4546424c88.21.1790963497059; 
 Fri, 02 Oct 2026 10:51:37 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:51:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 06/27] target/sh4: Define exception vector constants
Date: Sat,  3 Oct 2026 01:50:14 +0800
Message-ID: <20261002175037.1747-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Name SH4 exception vectors and use the definitions throughout exception
handling and exception raising.

Signed-off-by: Yonggang Luo <yonggang@gmail.com>
---
 target/sh4/cpu.h       | 21 +++++++++++++++
 target/sh4/helper.c    | 60 +++++++++++++++++++++---------------------
 target/sh4/op_helper.c | 16 +++++------
 3 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 6984bb462fb..a1e9049b7be 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -135,6 +135,27 @@ typedef struct memory_content {
     struct memory_content *next;
 } memory_content;
 
+/* Guest trap numbers. */
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
index b6b057f104b..0fbd613f333 100644
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
@@ -97,43 +97,43 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         const char *expname;
         switch (cs->exception_index) {
-        case 0x0e0:
+        case SH4_EXCP_ADDR_ERROR:
             expname = "addr_error";
             break;
-        case 0x040:
+        case SH4_EXCP_TLB_MISS:
             expname = "tlb_miss";
             break;
-        case 0x0a0:
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
         default:
@@ -161,18 +161,18 @@ void superh_cpu_do_interrupt(CPUState *cs)
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
@@ -632,7 +632,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
                     CPUState *cs = env_cpu(s);
 
                     /* Multiple TLB Exception */
-                    cs->exception_index = 0x140;
+                    cs->exception_index = SH4_EXCP_TLB_MULTIPLE;
                     s->tea = addr;
                     break;
                 }
@@ -828,33 +828,33 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     switch (ret) {
     case MMU_ITLB_MISS:
     case MMU_DTLB_MISS_READ:
-        cs->exception_index = 0x040;
+        cs->exception_index = SH4_EXCP_TLB_MISS;
         break;
     case MMU_DTLB_MULTIPLE:
     case MMU_ITLB_MULTIPLE:
-        cs->exception_index = 0x140;
+        cs->exception_index = SH4_EXCP_TLB_MULTIPLE;
         break;
     case MMU_ITLB_VIOLATION:
-        cs->exception_index = 0x0a0;
+        cs->exception_index = SH4_EXCP_TLB_VIOLATION;
         break;
     case MMU_DTLB_MISS_WRITE:
-        cs->exception_index = 0x060;
+        cs->exception_index = SH4_EXCP_DTLB_MISS_WRITE;
         break;
     case MMU_DTLB_INITIAL_WRITE:
-        cs->exception_index = 0x080;
+        cs->exception_index = SH4_EXCP_INITIAL_PAGE_WRITE;
         break;
     case MMU_DTLB_VIOLATION_READ:
-        cs->exception_index = 0x0a0;
+        cs->exception_index = SH4_EXCP_TLB_VIOLATION;
         break;
     case MMU_DTLB_VIOLATION_WRITE:
-        cs->exception_index = 0x0c0;
+        cs->exception_index = SH4_EXCP_DTLB_VIOLATION_WRITE;
         break;
     case MMU_IADDR_ERROR:
     case MMU_DADDR_ERROR_READ:
-        cs->exception_index = 0x0e0;
+        cs->exception_index = SH4_EXCP_ADDR_ERROR;
         break;
     case MMU_DADDR_ERROR_WRITE:
-        cs->exception_index = 0x100;
+        cs->exception_index = SH4_EXCP_DATA_WRITE;
         break;
     default:
         cpu_abort(cs, "Unhandled MMU fault");
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 777380f8e40..8beac9ca034 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -33,10 +33,10 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     switch (access_type) {
     case MMU_INST_FETCH:
     case MMU_DATA_LOAD:
-        cs->exception_index = 0x0e0;
+        cs->exception_index = SH4_EXCP_ADDR_ERROR;
         break;
     case MMU_DATA_STORE:
-        cs->exception_index = 0x100;
+        cs->exception_index = SH4_EXCP_DATA_WRITE;
         break;
     default:
         g_assert_not_reached();
@@ -67,22 +67,22 @@ void raise_exception(CPUSH4State *env, int index,
 
 void helper_raise_illegal_instruction(CPUSH4State *env)
 {
-    raise_exception(env, 0x180, 0);
+    raise_exception(env, SH4_EXCP_ILLEGAL_INSTRUCTION, 0);
 }
 
 void helper_raise_slot_illegal_instruction(CPUSH4State *env)
 {
-    raise_exception(env, 0x1a0, 0);
+    raise_exception(env, SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION, 0);
 }
 
 void helper_raise_fpu_disable(CPUSH4State *env)
 {
-    raise_exception(env, 0x800, 0);
+    raise_exception(env, SH4_EXCP_FPU_DISABLE, 0);
 }
 
 void helper_raise_slot_fpu_disable(CPUSH4State *env)
 {
-    raise_exception(env, 0x820, 0);
+    raise_exception(env, SH4_EXCP_SLOT_FPU_DISABLE, 0);
 }
 
 void helper_sleep(CPUSH4State *env)
@@ -97,7 +97,7 @@ void helper_sleep(CPUSH4State *env)
 void helper_trapa(CPUSH4State *env, uint32_t tra)
 {
     env->tra = tra << 2;
-    raise_exception(env, 0x160, 0);
+    raise_exception(env, SH4_EXCP_TRAPA, 0);
 }
 
 void helper_exclusive(CPUSH4State *env)
@@ -255,7 +255,7 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
         cause = (env->fpscr & FPSCR_CAUSE_MASK) >> FPSCR_CAUSE_SHIFT;
         enable = (env->fpscr & FPSCR_ENABLE_MASK) >> FPSCR_ENABLE_SHIFT;
         if (cause & enable) {
-            raise_exception(env, 0x120, retaddr);
+            raise_exception(env, SH4_EXCP_FPU, retaddr);
         }
     }
 }
-- 
2.52.0.windows.1


