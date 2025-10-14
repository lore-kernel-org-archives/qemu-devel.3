Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A100DCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJq-0002VL-Cc; Tue, 14 Oct 2025 16:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJb-0002JJ-9C
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:15 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ2-0005Mx-TY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b550eff972eso3874275a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472453; x=1761077253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4ZA5d5/lIwohpPGdIEr8HPomZYv1KX6aQnbN5YCFBA=;
 b=f5+ZErS6n6/6q7PEWoo+7ApjNjsXYHp4uqqPU+EbT1E+c8id2RJqVUnnjvnEM3WWW8
 OwWP6QN6Ej4tHVHoFniZVLe+FkTCHO8Kv1Pnicp1mCxLx8jPMyqmog1yhoOmNdHR4DmN
 TVyitPP3DQ81paokJvik3b1N+YqOlNCOLeZ3a25Lkr/XCPcvi1w6Jwsfmu4dSJwHJxKH
 RdbWnHXXdaGa/exxscHzVIbx5WZodAh76WQ1Dq8CrgjFsjvTxDajErsaQLOb6qk3BfWx
 hi63CI8YTp4SVVyE4t/gLMH58yBNrzXEF7rESbABlnxW9ojdAd4DxhHlEr+IsDLAau1S
 t5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472453; x=1761077253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4ZA5d5/lIwohpPGdIEr8HPomZYv1KX6aQnbN5YCFBA=;
 b=KtsKy9hAQqQqEBhxNHHGazhrfidzTgJRMdLbtrATSb2A1yLQWqf5rcVNU1GYZHwmCR
 we5UZ8Ugs916yRctTch7uR3nqd74squ5EkGmVGWID6E78qJiw81Vx6YwfDm7o4sxLd5N
 znqqaxEFiK0fGafpzPk+iO1AMoNOKmHkkkG2EaB2o1xSyDJG+Dd62pUHeQ0GZPOmuDFp
 7gxVvM4LwYrJtD4wf3CVo6sPnyhgJFesuzVasBzI9jxRaZePhQ8b1CzHYXRyBFUw7msH
 X443xZwUNk95VO5u6mr+j9Qp9S4Kw6agp7OvWomtXmVxq1McE4OqVvnzBhy/M0FPqZFA
 gX/A==
X-Gm-Message-State: AOJu0YxMf05WZUY6nBMf9WnValLU6paaiqVWFIeh9Hxf4hN4ZNFzw5Qc
 dxx9Em+VHGBjtelaf5fU+4RQJmxGj5TETbTROxMBP4J2PjFqb7DJJ3wA15xbJhZuOaFXe+FEAGa
 SJ5HhwHY=
X-Gm-Gg: ASbGnctV8XLVIBzODknRSVvNhKj7fnPLw+ybTCo8MrfYwJ6f69tvrANdWF4DDR70oaV
 YXA/z4gxavwFg1qlT5zS5Gk6JomPatISIV+hjUoMELLylIQ2YIE3vtxautfWOvlu+Ml0pRj/VOQ
 WHIyi+2o5+4hcQxYObJiF7x4MzqX2MwL1ZkLBX/1iqYVkiI31HU9dtAvvRG4SDVv2MXZp7MvdMZ
 vyd58R+Es8WVt1bdcsU2jdtaXCChFzf80ZPgJ/uZHss+JKHN76PMa02kYfdK5TSUunPv1rfJv7S
 ZzqArZ7ZXbL3uVzp86FKwxpGpphtEB1juF3rZUhPgCY2GTi+cNg0jOSFWIGuDGQcxQFMGKCEqk1
 Jrz3tk/zCjZa8n0CAfNc3ZgyLFlQ3U6NLQ9FqEn8SJflzdB8lKAc=
X-Google-Smtp-Source: AGHT+IE7iCQzqsBb9Divqn/CkCnH6B0Jm+Elirzzaim4LQLCfrcqSv4pNMoQBi5enL9tqbv/B/q20w==
X-Received: by 2002:a17:902:f609:b0:282:2c52:5094 with SMTP id
 d9443c01a7336-290272c31d0mr332861725ad.37.1760472452826; 
 Tue, 14 Oct 2025 13:07:32 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 19/37] target/arm: Implement MRRS, MSRR, SYSP
Date: Tue, 14 Oct 2025 13:07:00 -0700
Message-ID: <20251014200718.422022-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 169 +++++++++++++++++++++++++--------
 target/arm/tcg/a64.decode      |  12 ++-
 2 files changed, 139 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 918d5ed112..c3b717b408 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2752,17 +2752,23 @@ redirect_cpreg(DisasContext *s, uint32_t key, bool isread)
 
 /* MRS - move from system register
  * MSR (register) - move to system register
+ * MRRS
+ * MSRR
  * SYS
  * SYSL
+ * SYSP
  * These are all essentially the same insn in 'read' and 'write'
  * versions, with varying op0 fields.
+ *
+ * RT2 is non-zero if and only if this is a 128-bit access.
  */
 static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
-                       unsigned int crn, unsigned int crm, unsigned int rt)
+                       unsigned int crn, unsigned int crm, unsigned int rt,
+                       unsigned int rt2)
 {
     uint32_t key = ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2);
-    const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
+    const ARMCPRegInfo *ri;
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
     bool nv_redirect_reg = false;
@@ -2770,7 +2776,16 @@ static void handle_sys(DisasContext *s, bool isread,
     bool nv2_mem_redirect = false;
     TCGv_ptr tcg_ri = NULL;
     TCGv_i64 tcg_rt;
-    uint32_t syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
+    uint32_t syndrome;
+    bool is128 = rt2 != 0;
+
+    if (is128) {
+        key |= CP_REG_AA64_128BIT_MASK;
+        syndrome = syn_aa64_sysreg128trap(op0, op1, op2, crn, crm, rt, isread);
+    } else {
+        syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
+    }
+    ri = get_arm_cp_reginfo(s->cp_regs, key);
 
     if (crn == 11 || crn == 15) {
         /*
@@ -2790,12 +2805,14 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!ri) {
-        /* Unknown register; this might be a guest error or a QEMU
-         * unimplemented feature.
+        /*
+         * Unknown register, or 128-bit access to a 64-bit register.
+         * This might be a guest error or a QEMU unimplemented feature.
          */
-        qemu_log_mask(LOG_UNIMP, "%s access to unsupported AArch64 "
+        qemu_log_mask(LOG_UNIMP, "%s%s access to unsupported AArch64 "
                       "system register op0:%d op1:%d crn:%d crm:%d op2:%d\n",
-                      isread ? "read" : "write", op0, op1, crn, crm, op2);
+                      isread ? "read" : "write", is128 ? "128" : "",
+                      op0, op1, crn, crm, op2);
         gen_sysreg_undef(s, isread, op0, op1, op2, crn, crm, rt);
         return;
     }
@@ -2918,7 +2935,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * We don't use the EL1 register's access function, and
          * fine-grained-traps on EL1 also do not apply here.
          */
-        key = ENCODE_AA64_CP_REG(op0, 0, crn, crm, op2);
+        key &= ~CP_REG_ARM64_SYSREG_OP1_MASK;
         ri = redirect_cpreg(s, key, isread);
         /*
          * We might not have done an update_pc earlier, so check we don't
@@ -2933,32 +2950,44 @@ static void handle_sys(DisasContext *s, bool isread,
          * This means it is not an IO operation, doesn't change hflags,
          * and need not end the TB, because it has no side effects.
          *
-         * The access is 64-bit single copy atomic, guaranteed aligned because
-         * of the definition of VCNR_EL2. Its endianness depends on
-         * SCTLR_EL2.EE, not on the data endianness of EL1.
-         * It is done under either the EL2 translation regime or the EL2&0
-         * translation regime, depending on HCR_EL2.E2H. It behaves as if
-         * PSTATE.PAN is 0.
+         * The access is 64-bit (R_VFMQB) or 128-bit (R_BSBZP) single copy
+         * atomic, guaranteed aligned because of the definition of VCNR_EL2.
+         * Its endianness depends on SCTLR_EL2.EE, not on the data endianness
+         * of EL1. It is done under either the EL2 translation regime or
+         * the EL2&0 translation regime, depending on HCR_EL2.E2H.
+         * It behaves as if PSTATE.PAN is 0.
          */
         TCGv_i64 ptr = tcg_temp_new_i64();
-        MemOp mop = MO_64 | MO_ALIGN | MO_ATOM_IFALIGN;
+        MemOp mop = MO_ALIGN | MO_ATOM_IFALIGN;
         ARMMMUIdx armmemidx = s->nv2_mem_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
         int memidx = arm_to_core_mmu_idx(armmemidx);
-        uint32_t syn;
 
         mop |= (s->nv2_mem_be ? MO_BE : MO_LE);
+        disas_set_insn_syndrome(s, syn_data_abort_vncr(0, !isread, 0));
 
         tcg_gen_ld_i64(ptr, tcg_env, offsetof(CPUARMState, cp15.vncr_el2));
         tcg_gen_addi_i64(ptr, ptr,
                          (ri->nv2_redirect_offset & ~NV2_REDIR_FLAG_MASK));
-        tcg_rt = cpu_reg(s, rt);
 
-        syn = syn_data_abort_vncr(0, !isread, 0);
-        disas_set_insn_syndrome(s, syn);
-        if (isread) {
-            tcg_gen_qemu_ld_i64(tcg_rt, ptr, memidx, mop);
+        if (is128) {
+            TCGv_i128 t128 = tcg_temp_new_i128();
+
+            mop |= MO_128;
+            if (isread) {
+                tcg_gen_qemu_ld_i128(t128, ptr, memidx, mop);
+                tcg_gen_extr_i128_i64(cpu_reg(s, rt), cpu_reg(s, rt2), t128);
+            } else {
+                tcg_gen_concat_i64_i128(t128, cpu_reg(s, rt), cpu_reg(s, rt2));
+                tcg_gen_qemu_st_i128(t128, ptr, memidx, mop);
+            }
         } else {
-            tcg_gen_qemu_st_i64(tcg_rt, ptr, memidx, mop);
+            mop |= MO_64;
+            tcg_rt = cpu_reg(s, rt);
+            if (isread) {
+                tcg_gen_qemu_ld_i64(tcg_rt, ptr, memidx, mop);
+            } else {
+                tcg_gen_qemu_st_i64(tcg_rt, ptr, memidx, mop);
+            }
         }
         return;
     }
@@ -3099,28 +3128,63 @@ static void handle_sys(DisasContext *s, bool isread,
 
     tcg_rt = cpu_reg(s, rt);
 
-    if (isread) {
-        if (ri->type & ARM_CP_CONST) {
-            tcg_gen_movi_i64(tcg_rt, ri->resetvalue);
-        } else if (ri->readfn) {
-            if (!tcg_ri) {
-                tcg_ri = gen_lookup_cp_reg(key);
+    if (is128) {
+        TCGv_i64 tcg_rt2 = cpu_reg(s, rt2);
+
+        if (isread) {
+            if (ri->type & ARM_CP_CONST) {
+                /* E.g. TTBR0_EL2 is RES0 from EL3 when !FEAT_EL2. */
+                tcg_gen_movi_i64(tcg_rt, ri->resetvalue);
+                tcg_gen_movi_i64(tcg_rt2, 0);
+            } else if (ri->read128fn) {
+                TCGv_i128 t128 = tcg_temp_new_i128();
+                if (!tcg_ri) {
+                    tcg_ri = gen_lookup_cp_reg(key);
+                }
+                gen_helper_get_cp_reg128(t128, tcg_env, tcg_ri);
+                tcg_gen_extr_i128_i64(tcg_rt, tcg_rt2, t128);
+            } else {
+                tcg_gen_ld_i64(tcg_rt, tcg_env, ri->fieldoffset);
+                tcg_gen_ld_i64(tcg_rt2, tcg_env, ri->fieldoffsethi);
             }
-            gen_helper_get_cp_reg64(tcg_rt, tcg_env, tcg_ri);
         } else {
-            tcg_gen_ld_i64(tcg_rt, tcg_env, ri->fieldoffset);
+            if (ri->type & ARM_CP_CONST) {
+                /* If not forbidden by access permissions, treat as WI */
+                return;
+            } else if (ri->write128fn) {
+                if (!tcg_ri) {
+                    tcg_ri = gen_lookup_cp_reg(key);
+                }
+                gen_helper_set_cp_reg128(tcg_env, tcg_ri, tcg_rt, tcg_rt2);
+            } else {
+                tcg_gen_st_i64(tcg_rt, tcg_env, ri->fieldoffset);
+                tcg_gen_st_i64(tcg_rt2, tcg_env, ri->fieldoffsethi);
+            }
         }
     } else {
-        if (ri->type & ARM_CP_CONST) {
-            /* If not forbidden by access permissions, treat as WI */
-            return;
-        } else if (ri->writefn) {
-            if (!tcg_ri) {
-                tcg_ri = gen_lookup_cp_reg(key);
+        if (isread) {
+            if (ri->type & ARM_CP_CONST) {
+                tcg_gen_movi_i64(tcg_rt, ri->resetvalue);
+            } else if (ri->readfn) {
+                if (!tcg_ri) {
+                    tcg_ri = gen_lookup_cp_reg(key);
+                }
+                gen_helper_get_cp_reg64(tcg_rt, tcg_env, tcg_ri);
+            } else {
+                tcg_gen_ld_i64(tcg_rt, tcg_env, ri->fieldoffset);
             }
-            gen_helper_set_cp_reg64(tcg_env, tcg_ri, tcg_rt);
         } else {
-            tcg_gen_st_i64(tcg_rt, tcg_env, ri->fieldoffset);
+            if (ri->type & ARM_CP_CONST) {
+                /* If not forbidden by access permissions, treat as WI */
+                return;
+            } else if (ri->writefn) {
+                if (!tcg_ri) {
+                    tcg_ri = gen_lookup_cp_reg(key);
+                }
+                gen_helper_set_cp_reg64(tcg_env, tcg_ri, tcg_rt);
+            } else {
+                tcg_gen_st_i64(tcg_rt, tcg_env, ri->fieldoffset);
+            }
         }
     }
 
@@ -3144,7 +3208,34 @@ static void handle_sys(DisasContext *s, bool isread,
 
 static bool trans_SYS(DisasContext *s, arg_SYS *a)
 {
-    handle_sys(s, a->l, a->op0, a->op1, a->op2, a->crn, a->crm, a->rt);
+    handle_sys(s, a->l, a->op0, a->op1, a->op2, a->crn, a->crm, a->rt, 0);
+    return true;
+}
+
+static bool trans_SYS128(DisasContext *s, arg_sys *a)
+{
+    if (!dc_isar_feature(aa64_sysreg128, s) || (a->rt & 1)) {
+        return false;
+    }
+    handle_sys(s, a->l, a->op0, a->op1, a->op2, a->crn, a->crm,
+               a->rt, a->rt + 1);
+    return true;
+}
+
+static bool trans_SYSP(DisasContext *s, arg_sys *a)
+{
+    int rt2;
+    if (!dc_isar_feature(aa64_sysinstr128, s)) {
+        return false;
+    }
+    if (a->rt == 31) {
+        rt2 = 31;
+    } else if (a->rt & 1) {
+        return false;
+    } else {
+        rt2 = a->rt + 1;
+    }
+    handle_sys(s, a->l, a->op0, a->op1, a->op2, a->crn, a->crm, a->rt, rt2);
     return true;
 }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 01b1b3e38b..c76757ed01 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -302,9 +302,15 @@ MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
 # same instruction as far as QEMU is concerned.
 # NB: op0 is bits [20:19], but op0=0b00 is other insns, so we have
 # to hand-decode it.
-SYS             1101 0101 00 l:1 01 op1:3 crn:4 crm:4 op2:3 rt:5 op0=1
-SYS             1101 0101 00 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 op0=2
-SYS             1101 0101 00 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 op0=3
+&sys            l op0 op1 op2 crn crm rt
+SYS             1101 0101 00 l:1 01 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=1
+SYS             1101 0101 00 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=2
+SYS             1101 0101 00 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=3
+
+# MRRS, MSRR
+SYS128          1101 0101 01 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=2
+SYS128          1101 0101 01 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=3
+SYSP            1101 0101 01 0   01 op1:3 crn:4 crm:4 op2:3 rt:5 &sys op0=1 l=0
 
 # Exception generation
 
-- 
2.43.0


