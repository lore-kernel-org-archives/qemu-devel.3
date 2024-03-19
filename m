Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA643CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbcX-0005JM-8n; Tue, 19 Mar 2024 11:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcW-0005Gl-2T
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcS-0004nI-5S
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41409fd8b6bso22676985e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710862994; x=1711467794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=new3hB1/RFA2taMVx8452jvGfTxveGkjivBgpLY9vi4=;
 b=TM6rYJXk9kFlnej/e78jkrI0jr0BKGdurkGmgK+6tGA3NJmmu4Oh2E27qBt2VZ8tNN
 QH5gCJ65hGkFPCuDk0ROtDzJTqWV9fehAd/eAQ7JT74OmfmQ13lcaZ60xtQVunEq/uFo
 dB61nj2Rju089Fu5rkQvlilgk2dZqckhDTQKznORgkFUoeIeMJRtvufpdKfIt5Np8Rj6
 ys2CuY4JR4LFgS+owXpU9JZBXhZOL1e19AxoSIA58q7QwpLrn7zP1dfWwSJlbvJzJUEx
 BI5ngkotjKV4/70FZZjRYJ7IUMhfnwrKiErcfNfs/gE4TOmpZc0xf8uOZ1hRgNMr2tCo
 tbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710862994; x=1711467794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=new3hB1/RFA2taMVx8452jvGfTxveGkjivBgpLY9vi4=;
 b=BGFvlTcop0nokKFEqvue+SKOWO9IWDjepc0MRgKA6l07cF4bHMOBgRSza0XH4LcmNV
 iFF4kiCZwCUoVdILKBo1sFlT4mKyjwZG/Kh7EmX+aeMI7J+6uCFwFhAt26R8Zwbo6/8c
 NEggurP7ERrnYxYwdGosOLwwGH8A7fWYXf2jegJpK/5k3ur4ypr8lUTrfRLqs4Em6szq
 87rMmo3jz9UTc4p6lQ1HjmLsdiCLijGAX5wqg9ldT89Excvpkm1osPrnRC3nw9jnxlEX
 BT3JR+pgk79Yok1cbQL5RXF0HtEgIYxJb0gTOFBe4+Vq1N/OO1zRLAmrgnRnN6/qiz8z
 fO/g==
X-Gm-Message-State: AOJu0YwZ3bLcPsf4N8a592k3hugwiu7rBEM9XyKpvWQHqD9xtREC5fEi
 tEuqTzWh9QyTxAN2J1sn98wfkqbTjfMW4Pe68A4yuwTJJo0vOCp2q/yOd3DBJjCMwWmtQI9x1lN
 4
X-Google-Smtp-Source: AGHT+IHMtF7WZ1BalADq8pNpm7FyydhkB83f6ajwNnGajrOgQDlzhAvYjokNBBoUimbnE/8NJBnmjQ==
X-Received: by 2002:a05:600c:1992:b0:414:c48:a90 with SMTP id
 t18-20020a05600c199200b004140c480a90mr5817173wmq.24.1710862994286; 
 Tue, 19 Mar 2024 08:43:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c450600b004133365bbc6sm21728612wmo.19.2024.03.19.08.43.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH-for-9.1 02/27] accel/tcg: Introduce TCGCPUOps::get_cpu_state()
 handler
Date: Tue, 19 Mar 2024 16:42:31 +0100
Message-ID: <20240319154258.71206-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We want a single cpu_get_tb_cpu_state() for all targets,
but each of them already define it.

Introduce a generic target-agnostic cpu_get_tb_cpu_state()
method when per-target TARGET_HAS_CPU_GET_TB_CPU_STATE
is not defined. Currently all targets define it, but they
are going to be converted one by one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h   |  2 ++
 include/hw/core/tcg-cpu-ops.h |  3 +++
 target/alpha/cpu.h            |  2 ++
 target/arm/cpu.h              |  2 ++
 target/avr/cpu.h              |  2 ++
 target/cris/cpu.h             |  2 ++
 target/hexagon/cpu.h          |  2 ++
 target/hppa/cpu.h             |  2 ++
 target/i386/cpu.h             |  2 ++
 target/loongarch/cpu.h        |  2 ++
 target/m68k/cpu.h             |  2 ++
 target/microblaze/cpu.h       |  2 ++
 target/mips/cpu.h             |  2 ++
 target/nios2/cpu.h            |  2 ++
 target/openrisc/cpu.h         |  2 ++
 target/ppc/cpu.h              |  2 ++
 target/rx/cpu.h               |  2 ++
 target/s390x/cpu.h            |  2 ++
 target/sparc/cpu.h            |  2 ++
 target/xtensa/cpu.h           |  2 ++
 accel/tcg/translate-all.c     | 10 ++++++++++
 21 files changed, 51 insertions(+)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 4e36cf858e..10a45d3b9c 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -79,6 +79,8 @@ TranslationBlock *tb_link_page(TranslationBlock *tb);
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
+void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags);
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index bf8ff8e3ee..0ad9949950 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -49,6 +49,9 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
+    void (*get_cpu_state)(CPUArchState *cpu, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags);
+
 #ifdef NEED_CPU_H
 #ifdef CONFIG_USER_ONLY
     /**
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 7188a409a0..16b0f8a097 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -467,6 +467,8 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MemTxResult response, uintptr_t retaddr);
 #endif
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bc0c84873f..d20e2bd90e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3151,6 +3151,8 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
 }
 #endif
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
 
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index d185d20dcb..0c0aa580f5 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -193,6 +193,8 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 3904e5448c..dbd6fb05f0 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -273,6 +273,8 @@ enum {
 
 #include "exec/cpu-all.h"
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUCRISState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 3eef58fe8f..935a9c3276 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -134,6 +134,8 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a92dc352cb..cdb2904936 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -314,6 +314,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 952174bb6f..954495fff0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2354,6 +2354,8 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ec37579fd6..d814ba08dd 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -443,6 +443,8 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 346427e144..2790d61115 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -604,6 +604,8 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index c0c7574dbd..8058dcac7f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -415,6 +415,8 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7329226d39..caa12a2dd3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1362,6 +1362,8 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 4164a3432e..32002b819a 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -286,6 +286,8 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b1b7db5cbd..d42800242f 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -351,6 +351,8 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
     env->shadow_gpr[0][i] = val;
 }
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 67e6b2effd..ced4e53024 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2716,6 +2716,8 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer);
  */
 #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 #ifdef CONFIG_DEBUG_TCG
 void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index c53593d7aa..996f121bcd 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -149,6 +149,8 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 #define RX_CPU_IRQ 0
 #define RX_CPU_FIR 1
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 43a46a5a06..2e184aabf5 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -416,6 +416,8 @@ static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 
 #include "tcg/tcg_s390x.h"
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f3cdd17c62..ae55cd15a4 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -747,6 +747,8 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_HYPER        (1 << 7)
 #define TB_FLAG_ASI_SHIFT    24
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 6b8d0636d2..3826b779e4 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -734,6 +734,8 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 
 #include "exec/cpu-all.h"
 
+#define TARGET_HAS_CPU_GET_TB_CPU_STATE
+
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c1f57e894a..7b538d2b9c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -221,6 +221,16 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
 }
 
+#ifndef TARGET_HAS_CPU_GET_TB_CPU_STATE
+void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    CPUState *cpu = env_cpu(env);
+
+    cpu->cc->tcg_ops->get_cpu_state(env, pc, cs_base, flags);
+}
+#endif
+
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
 {
     /*
-- 
2.41.0


