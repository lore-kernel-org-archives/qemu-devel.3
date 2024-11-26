Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581FFD3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvSB-00022Z-T6; Tue, 26 Nov 2024 08:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvRK-0000NW-4k
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:17:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvRF-0003m6-0e
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:17:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38241435528so3669551f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732627026; x=1733231826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4o3elrIgsKejK7gl+opoqyQLP4kR/40fNsCOdLbzlE=;
 b=sV+UCBp/FjgLkUg0GXrdNRAC+wP9EKEGSCUoCMVHevAYs0aigwFh7r+/E39rsj3a0G
 LB7qAU81zz/EpaDvSPV11j6EnIvlfTpaTtlEw2gSM5KUPMLQ4EUM4UryBslNIKCJ6enm
 J37YzrUQO9JrTYiO2nIGa8GJLyVDmcVqR8rjt9isvTAJ2nCCv2aPGRuGGm9lZj9Mx+Dn
 aP9sINfomS1c+CkXYpGgDJYoZXFRIQly9pFQNACohUfhgVmPiZjEl4o/rlZbUuQJsyRd
 lRwto1c+gJMu1/5RUzWoJmqQvHANJpJbk4D77AVqxBN6cRjVHlEfdpqwwn8sPEw7YeHa
 9uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627026; x=1733231826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4o3elrIgsKejK7gl+opoqyQLP4kR/40fNsCOdLbzlE=;
 b=OXv3rSFFjFGz2wx3hkl0ZuqlcKirD2xFyrbBaQq4/GfU6p6MSPBp9pVSOTWvR0qOTg
 OlNIh9BHoDUSrtDBVWykGftMYFjsjy35MN66vq8OnBlhcvZq+O8Ct9kWWDLIlGxJUZy3
 OsZlsonMWYd5FIXKyzR1oixMuhTUVSxJ+k4mf9X+CtSOAhPbbAwXWFlbMpEJW8TEDayQ
 kPFvLmpIRmfxlh0ifFa/jF2AMhJhuhB543MvwumYabsc3AXLKSPsjtvZVItHdkyop/8t
 w2hYXE+pZquq2sB+0wFu01PrrzDeoqe67m3AQS5pxup4ei/ROFqM1CgZ5yNKA3cwfIql
 hRkw==
X-Gm-Message-State: AOJu0YwfDPbBV/ZgxjQOxAVdcy3HvhTFnUGCPe6dgGLBvPKZkfGvWPmz
 MqhK+lrbCt43WD2Q2EtEhsG88tSALR5eJAjjsLHw3FJ9LU89dfoZTxbcNRzD2Cr4GNnPMkQ5CeB
 n
X-Gm-Gg: ASbGncsuBBOo0McWuKoZTRktkTkyIXSm+TVLkcHxU3h8SMVPzoLiCgLsyxrOfxghmQx
 tEzo1W8e6OveNxP4SK4LhngX8LoNPEScnJdPqXhtBs5+mM8PjsahBeIP2AjZd5/8U4HNdVoAc5e
 ASnpdE10x/1qV7m+h7aOjcyxjwhKB94mP/97ks3lgak/DQ6rupDxhcIbgjj0oE/DU1cRrbT9ay2
 taXFFogjuqSNH1qdj6McKCfOywcP7t3JTNxcrfnm3H0Ku8iBQIMO5tNslTJaEGJssvDUCQ6
X-Google-Smtp-Source: AGHT+IEe8oj6j0fKdcpbgYOMYcy2iTno57TC3a9RlFuamtG12GPCOrfnyoKSKlEfXFe4UGhel4ZqOw==
X-Received: by 2002:a05:6000:1543:b0:382:4b9a:f500 with SMTP id
 ffacd0b85a97d-38260b5bb7amr14369799f8f.18.1732627025888; 
 Tue, 26 Nov 2024 05:17:05 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6436sm13307851f8f.13.2024.11.26.05.17.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:17:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 13/13] target/mips: Make DSPControl register 32-bit wide
Date: Tue, 26 Nov 2024 14:15:45 +0100
Message-ID: <20241126131546.66145-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Per 'MIPS® DSP Module for MIPS64™ Architecture, Revision 3.02',
 * 3.10 Additional Register State for the DSP Module
 ~Figure 3.5 MIPS® DSP Module Control Register (DSPControl) Format~

the DSPControl register is 32-bit wide.

Convert it from 'target_ulong' to 'uint32_t'.

Update TCG calls to truncate/extend from i32 to target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h                        |  2 +-
 target/mips/tcg/sysemu_helper.h.inc      |  4 +--
 target/mips/sysemu/machine.c             |  5 ++-
 target/mips/tcg/dsp_helper.c             | 10 +++---
 target/mips/tcg/sysemu/cp0_helper.c      |  4 +--
 target/mips/tcg/translate.c              | 40 +++++++++++++++++-------
 target/mips/tcg/nanomips_translate.c.inc | 16 +++++++---
 7 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f80b05885b1..bc636510132 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -472,7 +472,7 @@ struct TCState {
     target_ulong HI[MIPS_DSP_ACC];
     target_ulong LO[MIPS_DSP_ACC];
     target_ulong ACX[MIPS_DSP_ACC];
-    target_ulong DSPControl;
+    uint32_t DSPControl;
     int32_t CP0_TCStatus;
 #define CP0TCSt_TCU3    31
 #define CP0TCSt_TCU2    30
diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
index 1861d538de1..36ce21f863b 100644
--- a/target/mips/tcg/sysemu_helper.h.inc
+++ b/target/mips/tcg/sysemu_helper.h.inc
@@ -144,12 +144,12 @@ DEF_HELPER_2(mftgpr, tl, env, i32)
 DEF_HELPER_2(mftlo, tl, env, i32)
 DEF_HELPER_2(mfthi, tl, env, i32)
 DEF_HELPER_2(mftacx, tl, env, i32)
-DEF_HELPER_1(mftdsp, tl, env)
+DEF_HELPER_1(mftdsp, i32, env)
 DEF_HELPER_3(mttgpr, void, env, tl, i32)
 DEF_HELPER_3(mttlo, void, env, tl, i32)
 DEF_HELPER_3(mtthi, void, env, tl, i32)
 DEF_HELPER_3(mttacx, void, env, tl, i32)
-DEF_HELPER_2(mttdsp, void, env, tl)
+DEF_HELPER_2(mttdsp, void, env, i32)
 DEF_HELPER_0(dmt, tl)
 DEF_HELPER_0(emt, tl)
 DEF_HELPER_1(dvpe, tl, env)
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 823a49e2ca1..c1fb72864f6 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -88,7 +88,10 @@ static const VMStateField vmstate_tc_fields[] = {
     VMSTATE_UINTTL_ARRAY(HI, TCState, MIPS_DSP_ACC),
     VMSTATE_UINTTL_ARRAY(LO, TCState, MIPS_DSP_ACC),
     VMSTATE_UINTTL_ARRAY(ACX, TCState, MIPS_DSP_ACC),
-    VMSTATE_UINTTL(DSPControl, TCState),
+    VMSTATE_UINT32(DSPControl, TCState),
+#if defined(TARGET_MIPS64)
+    VMSTATE_UNUSED(4),
+#endif /* TARGET_MIPS64 */
     VMSTATE_INT32(CP0_TCStatus, TCState),
     VMSTATE_INT32(CP0_TCBind, TCState),
     VMSTATE_UINTTL(CP0_TCHalt, TCState),
diff --git a/target/mips/tcg/dsp_helper.c b/target/mips/tcg/dsp_helper.c
index 7a4362c8ef4..e58d6b9ef84 100644
--- a/target/mips/tcg/dsp_helper.c
+++ b/target/mips/tcg/dsp_helper.c
@@ -54,7 +54,7 @@ typedef union {
 static inline void set_DSPControl_overflow_flag(uint32_t flag, int position,
                                                 CPUMIPSState *env)
 {
-    env->active_tc.DSPControl |= (target_ulong)flag << position;
+    env->active_tc.DSPControl |= flag << position;
 }
 
 static inline void set_DSPControl_carryflag(bool flag, CPUMIPSState *env)
@@ -76,7 +76,7 @@ static inline void set_DSPControl_24(uint32_t flag, int len, CPUMIPSState *env)
   filter = ~filter;
 
   env->active_tc.DSPControl &= filter;
-  env->active_tc.DSPControl |= (target_ulong)flag << 24;
+  env->active_tc.DSPControl |= flag << 24;
 }
 
 static inline void set_DSPControl_pos(uint32_t pos, CPUMIPSState *env)
@@ -113,7 +113,7 @@ static inline uint32_t get_DSPControl_pos(CPUMIPSState *env)
 static inline void set_DSPControl_efi(uint32_t flag, CPUMIPSState *env)
 {
     env->active_tc.DSPControl &= 0xFFFFBFFF;
-    env->active_tc.DSPControl |= (target_ulong)flag << 14;
+    env->active_tc.DSPControl |= flag << 14;
 }
 
 #define DO_MIPS_SAT_ABS(size)                                          \
@@ -2923,7 +2923,7 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong rs,  \
     uint32_t pos, size, msb, lsb;                               \
     uint32_t const sizefilter = 0x3F;                           \
     target_ulong temp;                                          \
-    target_ulong dspc;                                          \
+    uint32_t dspc;                                              \
                                                                 \
     dspc = env->active_tc.DSPControl;                           \
                                                                 \
@@ -3063,7 +3063,7 @@ target_ulong helper_##name(target_ulong rs, target_ulong rt,   \
 {                                                              \
     uint32_t rs_t, rt_t;                                       \
     uint32_t cc;                                               \
-    target_ulong dsp;                                          \
+    uint32_t dsp;                                              \
     int i;                                                     \
     target_ulong result = 0;                                   \
                                                                \
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index 79a5c833cee..61b7644f3a4 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -1483,7 +1483,7 @@ target_ulong helper_mftacx(CPUMIPSState *env, uint32_t sel)
     }
 }
 
-target_ulong helper_mftdsp(CPUMIPSState *env)
+uint32_t helper_mftdsp(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1543,7 +1543,7 @@ void helper_mttacx(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     }
 }
 
-void helper_mttdsp(CPUMIPSState *env, target_ulong arg1)
+void helper_mttdsp(CPUMIPSState *env, uint32_t arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index d6be37d56d3..6f2eacbba97 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1172,7 +1172,8 @@ TCGv cpu_gpr[32], cpu_PC;
  */
 TCGv_i64 cpu_gpr_hi[32];
 TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
-static TCGv cpu_dspctrl, btarget;
+static TCGv_i32 cpu_dspctrl;
+static TCGv btarget;
 TCGv bcond;
 static TCGv cpu_lladdr, cpu_llval;
 static TCGv_i32 hflags;
@@ -4438,9 +4439,11 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
     case OPC_BPOSGE32:
 #if defined(TARGET_MIPS64)
     case OPC_BPOSGE64:
-        tcg_gen_andi_tl(t0, cpu_dspctrl, 0x7F);
+        tcg_gen_extu_i32_tl(t1, cpu_dspctrl);
+        tcg_gen_andi_tl(t0, t1, 0x7F);
 #else
-        tcg_gen_andi_tl(t0, cpu_dspctrl, 0x3F);
+        tcg_gen_extu_i32_tl(t1, cpu_dspctrl);
+        tcg_gen_andi_tl(t0, t1, 0x3F);
 #endif
         bcond_compute = 1;
         btgt = ctx->base.pc_next + insn_bytes + offset;
@@ -8225,6 +8228,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
             gen_mfc0(ctx, t0, rt, sel);
         }
     } else {
+        TCGv_i32 t32;
         switch (sel) {
         /* GPR registers. */
         case 0:
@@ -8270,7 +8274,9 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
                 gen_helper_1e0i(mftacx, t0, 3);
                 break;
             case 16:
-                gen_helper_mftdsp(t0, tcg_env);
+                t32 = tcg_temp_new_i32();
+                gen_helper_mftdsp(t32, tcg_env);
+                tcg_gen_extu_i32_tl(t0, t32);
                 break;
             default:
                 goto die;
@@ -8425,6 +8431,7 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
             gen_mtc0(ctx, t0, rd, sel);
         }
     } else {
+        TCGv_i32 t32;
         switch (sel) {
         /* GPR registers. */
         case 0:
@@ -8470,7 +8477,9 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
                 gen_helper_0e1i(mttacx, t0, 3);
                 break;
             case 16:
-                gen_helper_mttdsp(tcg_env, t0);
+                t32 = tcg_temp_new_i32();
+                gen_load_gpr_i32(t32, rt);
+                gen_helper_mttdsp(tcg_env, t32);
                 break;
             default:
                 goto die;
@@ -12516,6 +12525,7 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext *ctx,
     TCGv t1;
     TCGv v1_t;
     TCGv v2_t;
+    TCGv_i32 t32;
 
     if ((ret == 0) && (check_ret == 1)) {
         /* Treat as NOP. */
@@ -12560,25 +12570,31 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext *ctx,
             check_dsp_r2(ctx);
             gen_helper_cmpgu_eq_qb(t1, v1_t, v2_t);
             tcg_gen_mov_tl(cpu_gpr[ret], t1);
-            tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
+            tcg_gen_andi_i32(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
             tcg_gen_shli_tl(t1, t1, 24);
-            tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
+            t32 = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t32, t1);
+            tcg_gen_or_i32(cpu_dspctrl, cpu_dspctrl, t32);
             break;
         case OPC_CMPGDU_LT_QB:
             check_dsp_r2(ctx);
             gen_helper_cmpgu_lt_qb(t1, v1_t, v2_t);
             tcg_gen_mov_tl(cpu_gpr[ret], t1);
-            tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
+            tcg_gen_andi_i32(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
             tcg_gen_shli_tl(t1, t1, 24);
-            tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
+            t32 = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t32, t1);
+            tcg_gen_or_i32(cpu_dspctrl, cpu_dspctrl, t32);
             break;
         case OPC_CMPGDU_LE_QB:
             check_dsp_r2(ctx);
             gen_helper_cmpgu_le_qb(t1, v1_t, v2_t);
             tcg_gen_mov_tl(cpu_gpr[ret], t1);
-            tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
+            tcg_gen_andi_i32(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
             tcg_gen_shli_tl(t1, t1, 24);
-            tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
+            t32 = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t32, t1);
+            tcg_gen_or_i32(cpu_dspctrl, cpu_dspctrl, t32);
             break;
         case OPC_CMP_EQ_PH:
             check_dsp(ctx);
@@ -15303,7 +15319,7 @@ void mips_tcg_init(void)
                                        offsetof(CPUMIPSState, active_tc.LO[i]),
                                        regnames_LO[i]);
     }
-    cpu_dspctrl = tcg_global_mem_new(tcg_env,
+    cpu_dspctrl = tcg_global_mem_new_i32(tcg_env,
                                      offsetof(CPUMIPSState,
                                               active_tc.DSPControl),
                                      "DSPControl");
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 2ad936c66d4..1d6b70083b0 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1136,7 +1136,8 @@ static void gen_compute_branch_nm(DisasContext *ctx, uint32_t opc,
         btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
     case OPC_BPOSGE32:
-        tcg_gen_andi_tl(t0, cpu_dspctrl, 0x3F);
+        tcg_gen_extu_i32_tl(t1, cpu_dspctrl);
+        tcg_gen_andi_tl(t0, t1, 0x3F);
         bcond_compute = 1;
         btgt = ctx->base.pc_next + insn_bytes + offset;
         break;
@@ -3009,6 +3010,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     TCGv t0 = tcg_temp_new();
     TCGv v1_t = tcg_temp_new();
     TCGv v2_t = tcg_temp_new();
+    TCGv_i32 v1_t32;
 
     gen_load_gpr_tl(v1_t, rs);
     gen_load_gpr_tl(v2_t, rt);
@@ -3056,19 +3058,25 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_CMPGDU_EQ_QB:
         check_dsp_r2(ctx);
         gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
-        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        v1_t32 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(v1_t32, v1_t);
+        tcg_gen_deposit_i32(cpu_dspctrl, cpu_dspctrl, v1_t32, 24, 4);
         gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_CMPGDU_LT_QB:
         check_dsp_r2(ctx);
         gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
-        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        v1_t32 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(v1_t32, v1_t);
+        tcg_gen_deposit_i32(cpu_dspctrl, cpu_dspctrl, v1_t32, 24, 4);
         gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_CMPGDU_LE_QB:
         check_dsp_r2(ctx);
         gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
-        tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
+        v1_t32 = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(v1_t32, v1_t);
+        tcg_gen_deposit_i32(cpu_dspctrl, cpu_dspctrl, v1_t32, 24, 4);
         gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PACKRL_PH:
-- 
2.45.2


