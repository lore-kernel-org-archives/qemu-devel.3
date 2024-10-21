Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1FBD15DAC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2trn-0007Ez-67; Mon, 21 Oct 2024 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2trk-0007EV-T5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:58:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2trj-0002Mc-1c
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:58:40 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so42306275ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729522717; x=1730127517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iW29TeTq/AjPOVEcaOm5keLiR0QJnnwi9KEssRPP2pY=;
 b=k/TnPSlbR6I2kZ09u43/8cIepZPUtmMqkBhft1gYiYRKtkf/V/IIiCaDTSEp5/xB3P
 mKxDb5bljKdh5OrLd2EN0EvMrGpSo9aNvklK66r9oEI7au5tzmAoTErc4StPPAZ6Hy7N
 AkcezzzfoD8527HElNd/vaOA5+PzAMmFo4/oWGSGdC0Xs6QH6k0anhuxxgDrqUah3hSi
 izMLK217ikeUlU9NZEAmn/cw5Jf013HCF0EfWakvTOrKIKXkONZCoqgVg5HimvcLky5c
 7Uqt+jHcVGdOZfW1cZ39d08U4SglPoeXwy0vPBDEKx/JkmRXYenogYWAg3d/v4YgAcNB
 w3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729522717; x=1730127517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iW29TeTq/AjPOVEcaOm5keLiR0QJnnwi9KEssRPP2pY=;
 b=mzILqhObOQJwGO8piY3cCJhbpKqvecIkNTN1vXOQZ9NSh4Z9AMR/0DN7+zrMCMw7Y3
 cLBAMDZU0R42b38Ky627UGzxqZyAAmJCNMTWry85h5U6smexqOGbEs3UwDD0aib5Pg9S
 qTxnU6tetYAlS387clKI3A1xTe0p7owfdGC6p5wLVhCtBpGIEEmKUOekb4ywYNep6NFx
 1f8uDTSngjTlAI+Mi903lnIv5bU460ilVASI04B6lfy1a2qK6Bc2HShK2QAya1UZTa1n
 hNwfB7ZANGyyrT/rc3pIid/bEFEynZLd8BzQom1vytJ4WVv/xssCm8WO11pTPXifga74
 o7yA==
X-Gm-Message-State: AOJu0Yx502aOnjsswFaV0ntqfWgc2f+ipzbmBYRS3p/TQpijLaxRzzx+
 n06UBGHGliFXuLy5LbODdNBR1Ck5ReiNcHzPOn/ORxqakDcha0g0Kvtxx7iBNzbibjjrvrBnMb8
 H
X-Google-Smtp-Source: AGHT+IE4z/In6WTEMu5+CBur0E/c7/MV0TGHDTWIIPvVh1A/psZ3xlhKsEzZ4N1WZT1Z9T0gW+jEbA==
X-Received: by 2002:a17:902:e9c1:b0:20c:ee32:7597 with SMTP id
 d9443c01a7336-20e9487e189mr3294295ad.8.1729522717248; 
 Mon, 21 Oct 2024 07:58:37 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd63fsm27007195ad.173.2024.10.21.07.58.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Oct 2024 07:58:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/mips: Introduce ase_3d_available() helper
Date: Mon, 21 Oct 2024 11:58:32 -0300
Message-ID: <20241021145832.34920-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
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

Determine if the MIPS-3D ASE is implemented by checking
the state of the 3D bit in the FIR CP1 control register.
Remove the then unused ASE_MIPS3D definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h                         | 6 ++++++
 target/mips/mips-defs.h                   | 1 -
 target/mips/tcg/translate.c               | 8 ++++++--
 target/mips/cpu-defs.c.inc                | 4 ++--
 target/mips/tcg/micromips_translate.c.inc | 5 ++++-
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a4a46ebbe98..6a4c4ea683a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1319,6 +1319,12 @@ bool cpu_type_supports_cps_smp(const char *cpu_type);
 bool cpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask);
 bool cpu_type_supports_isa(const char *cpu_type, uint64_t isa);
 
+/* Check presence of MIPS-3D ASE */
+static inline bool ase_3d_available(CPUMIPSState *env)
+{
+    return env->active_fpu.fcr0 & (1 << FCR0_3D);
+}
+
 /* Check presence of MSA implementation */
 static inline bool ase_msa_available(CPUMIPSState *env)
 {
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index a6cebe0265c..6b5cd0d8f53 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -26,7 +26,6 @@
  *   bits 24-39: MIPS ASEs
  */
 #define ASE_MIPS16        0x0000000001000000ULL
-#define ASE_MIPS3D        0x0000000002000000ULL
 #define ASE_MDMX          0x0000000004000000ULL
 #define ASE_DSP           0x0000000008000000ULL
 #define ASE_DSP_R2        0x0000000010000000ULL
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index d92fc418edd..9e0c319bb23 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -14952,7 +14952,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             } else {
                 /* OPC_BC1ANY2 */
                 check_cop1x(ctx);
-                check_insn(ctx, ASE_MIPS3D);
+                if (!ase_3d_available(env)) {
+                    return false;
+                }
                 gen_compute_branch1(ctx, MASK_BC1(ctx->opcode),
                                     (rt >> 2) & 0x7, imm << 2);
             }
@@ -14967,7 +14969,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_cp1_enabled(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             check_cop1x(ctx);
-            check_insn(ctx, ASE_MIPS3D);
+            if (!ase_3d_available(env)) {
+                return false;
+            }
             /* fall through */
         case OPC_BC1:
             check_cp1_enabled(ctx);
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 19e2abac829..2728f4dba67 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -663,7 +663,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 40,
         .PABITS = 36,
-        .insn_flags = CPU_MIPS64R1 | ASE_MIPS3D,
+        .insn_flags = CPU_MIPS64R1,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
@@ -692,7 +692,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 36,
-        .insn_flags = CPU_MIPS64R2 | ASE_MIPS3D,
+        .insn_flags = CPU_MIPS64R2,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 3cbf53bf2b3..c479bec1081 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -2484,7 +2484,10 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             mips32_op = OPC_BC1TANY4;
         do_cp1mips3d:
             check_cop1x(ctx);
-            check_insn(ctx, ASE_MIPS3D);
+            if (!ase_3d_available(env)) {
+                gen_reserved_instruction(ctx);
+                break;
+            }
             /* Fall through */
         do_cp1branch:
             if (env->CP0_Config1 & (1 << CP0C1_FP)) {
-- 
2.45.2


