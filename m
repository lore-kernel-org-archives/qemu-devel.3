Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C878CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4db-0007Ob-Im; Tue, 26 Aug 2025 21:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4ch-0004si-4d
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:47 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cT-0007MT-EB
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:46 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-32326793a85so4198344a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256772; x=1756861572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOyy+/rPG+fuvpUOdt5IfmJ1qSymu2F0o3Ur99A84f4=;
 b=nZZ7IcPOwKQ2rOuw+Vie01BbgkH+UFFXZDd+KrKjya3vF53jcrZwrjy3z2/jYzyUVw
 HvAD57HbDH35f3Y56lR9zLBDhRACj8T5qkOJFF0tzXpi8SpegMe1ZJqo3d9KaLJOFbhQ
 Jh2AznMZsHs4Xn5c8IaWMT29U5qm3vCaYvCJXWtRsWXDkP6Ki2xjr5LqbSg86HlZ6P3q
 Gf6zAtWP53QkoKvC8oQLYRK0sQdh/O9BoyCkPpKpyV5K6j5hDLHKqCVQQ5zRM5ggTYGt
 r5SFFBmTznzboWAxo8e/xZtNB3EuizzKNjma+DeQM5hTDKi9zDX/BKt8uWkq9jdbEyHF
 ibFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256772; x=1756861572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOyy+/rPG+fuvpUOdt5IfmJ1qSymu2F0o3Ur99A84f4=;
 b=HuY56i7VSZ5IvRbtxOd4SpBDhOST4BcOuxzByL3Q9hUmYjlyzDRA1KNZYLKdxs67vy
 Da7J4Og0q/V98Is3NXRpjE5GX4pf+xV8/T9fhsz95dGcopEFhQ7mSWs9jvgHnKKE+cgp
 Btg9AVKmMIjX1PfIxMr6tzPhTNyS/Xap97NbOK5Y7xu9LPTlfl4MxoGDQvwXBBnfks8O
 BfeicUoW8igAZXkrMfRo51tepr/NWbHdrSRWvB67v7UdQmJscOlMlnpVyUslvuUENyc4
 OTfSkVrobXyevTFCWD/NKj7cVUJ1hi/JYvg69rLUoRT2QjVdJ85wsEqrrFPBmG9y8X+B
 n8iQ==
X-Gm-Message-State: AOJu0YzfKS/jkwORKlUkI+hkGeuK+FeTXBKxPniuCSr60isRpO8GSImz
 PcXZKz7XEcupeYFrGX7KC1f1bIIn9rR0CAd4p7V+Ys07NFt2qquWFhfEr3aoCzRewRvI2CB5E/4
 ivXzqKKM=
X-Gm-Gg: ASbGncujafRGPjZLkn1059AoD2eHKgAqssiWUUSgOomvgShh99xhxIP4HQg4qPOgxNC
 EaGtUUBFRzgGueTdkv/UtRmi9sYkU4ZvtE2UNDHHu0kthmch0+sZlVcv+v0QJ6XfaOjp22vtMFD
 arV3YHN28HIDNzuoZnbQe2dBIqB/hfRETy5FKXpbJ+3yVEM4fHLgE2wVUaKWQzn7y+UX8U+hdOD
 K6MJiiRetIw9oOrh9uEdcD3lskcpKAXoW/YSHHDVuYEWQxMeX1PAvPg2RJ99qfOf+SsQc1DEX/5
 EovsweVOwnNQDwYmmZyJB5ei9lLiH0diNQJiXjTZFZkg+/8TT0oFH6nxVZBqYpL+hz9wVB3c882
 xbcy36ChP4iuyhgcs1va3hL2ZXWCkhLcyhZtgdAcln0tZS3I=
X-Google-Smtp-Source: AGHT+IHkGztZKRN7sqDjwFiiJ3/zp5g+iC3ZJTdvvq+SxoZOvBSEawJkrbsP7bmtf3c2kfJCvJSGDA==
X-Received: by 2002:a17:90b:580f:b0:327:7220:f579 with SMTP id
 98e67ed59e1d1-3277220fafdmr368254a91.1.1756256772322; 
 Tue, 26 Aug 2025 18:06:12 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/61] target/arm: Drop define_one_arm_cp_reg_with_opaque
Date: Wed, 27 Aug 2025 11:04:03 +1000
Message-ID: <20250827010453.4059782-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The last use of this interface was removed in 603bc048a27f
("hw/arm: Remove pxa2xx_pic").  As the comment in gicv3
stated, keeping pointer references to cpregs has SMP issues,
so avoid future temptation by removing the interface.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h       | 32 ++++++++------------------------
 hw/intc/arm_gicv3_cpuif.c | 10 +---------
 target/arm/helper.c       | 29 +++++++++++------------------
 3 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3344a02bd3..b610716c24 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -906,11 +906,7 @@ struct ARMCPRegInfo {
      */
     uint32_t nv2_redirect_offset;
 
-    /*
-     * The opaque pointer passed to define_arm_cp_regs_with_opaque() when
-     * this register was defined: can be used to hand data through to the
-     * register read/write functions, since they are passed the ARMCPRegInfo*.
-     */
+    /* This is used only by VHE. */
     void *opaque;
     /*
      * Value of this register, if it is ARM_CP_CONST. Otherwise, if
@@ -1004,27 +1000,15 @@ struct ARMCPRegInfo {
 #define CPREG_FIELD64(env, ri) \
     (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
 
-void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu, const ARMCPRegInfo *reg,
-                                       void *opaque);
+void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
+void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len);
 
-static inline void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs)
-{
-    define_one_arm_cp_reg_with_opaque(cpu, regs, NULL);
-}
-
-void define_arm_cp_regs_with_opaque_len(ARMCPU *cpu, const ARMCPRegInfo *regs,
-                                        void *opaque, size_t len);
-
-#define define_arm_cp_regs_with_opaque(CPU, REGS, OPAQUE)               \
-    do {                                                                \
-        QEMU_BUILD_BUG_ON(ARRAY_SIZE(REGS) == 0);                       \
-        define_arm_cp_regs_with_opaque_len(CPU, REGS, OPAQUE,           \
-                                           ARRAY_SIZE(REGS));           \
+#define define_arm_cp_regs(CPU, REGS)                           \
+    do {                                                        \
+        QEMU_BUILD_BUG_ON(ARRAY_SIZE(REGS) == 0);               \
+        define_arm_cp_regs_len(CPU, REGS, ARRAY_SIZE(REGS));    \
     } while (0)
 
-#define define_arm_cp_regs(CPU, REGS) \
-    define_arm_cp_regs_with_opaque(CPU, REGS, NULL)
-
 const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t encoded_cp);
 
 /*
@@ -1143,7 +1127,7 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
      * means that the right set of registers is exactly those where
      * the opc1 field is 4 or 5. (You can see this also in the assert
      * we do that the opc1 field and the permissions mask line up in
-     * define_one_arm_cp_reg_with_opaque().)
+     * define_one_arm_cp_reg().)
      * Checking the opc1 field is easier for us and avoids the problem
      * that we do not consistently use the right architectural names
      * for all sysregs, since we treat the name field as largely for debug.
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf09157..72e91f971a 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -3037,15 +3037,7 @@ void gicv3_init_cpuif(GICv3State *s)
          *  cpu->gic_pribits
          */
 
-        /* Note that we can't just use the GICv3CPUState as an opaque pointer
-         * in define_arm_cp_regs_with_opaque(), because when we're called back
-         * it might be with code translated by CPU 0 but run by CPU 1, in
-         * which case we'd get the wrong value.
-         * So instead we define the regs with no ri->opaque info, and
-         * get back to the GICv3CPUState from the CPUARMState.
-         *
-         * These CP regs callbacks can be called from either TCG or HVF code.
-         */
+        /* These CP regs callbacks can be called from either TCG or HVF. */
         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
 
         /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e03cbc0394..35a176ea3b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7256,12 +7256,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 }
 
 /*
- * Private utility function for define_one_arm_cp_reg_with_opaque():
+ * Private utility function for define_one_arm_cp_reg():
  * add a single reginfo struct to the hash table.
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
-                                   void *opaque, CPState state,
-                                   CPSecureState secstate,
+                                   CPState state, CPSecureState secstate,
                                    int crm, int opc1, int opc2,
                                    const char *name)
 {
@@ -7349,9 +7348,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     r2->opc2 = opc2;
     r2->state = state;
     r2->secure = secstate;
-    if (opaque) {
-        r2->opaque = opaque;
-    }
 
     if (make_const) {
         /* This should not have been a very special register to begin. */
@@ -7456,8 +7452,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
 }
 
 
-void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
-                                       const ARMCPRegInfo *r, void *opaque)
+void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
 {
     /*
      * Define implementations of coprocessor registers.
@@ -7616,7 +7611,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                         if (nxs_ri.fgt) {
                             nxs_ri.fgt |= R_FGT_NXS_MASK;
                         }
-                        add_cpreg_to_hashtable(cpu, &nxs_ri, opaque, state,
+                        add_cpreg_to_hashtable(cpu, &nxs_ri, state,
                                                ARM_CP_SECSTATE_NS,
                                                crm, opc1, opc2, name);
                     }
@@ -7630,17 +7625,17 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                         switch (r->secure) {
                         case ARM_CP_SECSTATE_S:
                         case ARM_CP_SECSTATE_NS:
-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
+                            add_cpreg_to_hashtable(cpu, r, state,
                                                    r->secure, crm, opc1, opc2,
                                                    r->name);
                             break;
                         case ARM_CP_SECSTATE_BOTH:
                             name = g_strdup_printf("%s_S", r->name);
-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
+                            add_cpreg_to_hashtable(cpu, r, state,
                                                    ARM_CP_SECSTATE_S,
                                                    crm, opc1, opc2, name);
                             g_free(name);
-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
+                            add_cpreg_to_hashtable(cpu, r, state,
                                                    ARM_CP_SECSTATE_NS,
                                                    crm, opc1, opc2, r->name);
                             break;
@@ -7652,7 +7647,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                          * AArch64 registers get mapped to non-secure instance
                          * of AArch32
                          */
-                        add_cpreg_to_hashtable(cpu, r, opaque, state,
+                        add_cpreg_to_hashtable(cpu, r, state,
                                                ARM_CP_SECSTATE_NS,
                                                crm, opc1, opc2, r->name);
                     }
@@ -7663,12 +7658,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
 }
 
 /* Define a whole list of registers */
-void define_arm_cp_regs_with_opaque_len(ARMCPU *cpu, const ARMCPRegInfo *regs,
-                                        void *opaque, size_t len)
+void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len)
 {
-    size_t i;
-    for (i = 0; i < len; ++i) {
-        define_one_arm_cp_reg_with_opaque(cpu, regs + i, opaque);
+    for (size_t i = 0; i < len; ++i) {
+        define_one_arm_cp_reg(cpu, regs + i);
     }
 }
 
-- 
2.43.0


