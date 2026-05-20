Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36764CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZD-00054k-Aq; Wed, 20 May 2026 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZ6-0004m7-P8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZ3-0002fx-FQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso2269037f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305203; x=1779910003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FpulllsTUG6FzpTkprRKojqMKoB/gsAWNKKQzts57F0=;
 b=ljndaPnq8OMjnZ4jHy8usjvE7KLrP0xmMSkvFSQ/ENtOWU2QUd82gW+yop8sIrIDrc
 r9jJV29+4CSCoU50nVPi5Vi+yeiBKUQsxDrXrkJ03N6ea9uvAl+ccw0uiRegnRxCooYE
 EMxV7mTEsJOEnHUsgdmXo+zfRlDZgBLojOd2BKDKbe0VtIZzgXn5/uZ8x8UiLdYDtEiO
 l97dPYofvToFS1T2TQuxfRjT8jSbU6DyT7dRYdAN5Y9ILOpPodFONCKYYIDXE7CKgWKM
 iqrlFm9BGsF+PRStdPsalKv88qryB/MNQZWKiedXGQBxKVm0LwVOoiwmszWEbVuW/fYA
 GlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305203; x=1779910003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FpulllsTUG6FzpTkprRKojqMKoB/gsAWNKKQzts57F0=;
 b=OUGIqnyq3AvJNpLvDZbzTmldz+uQ/yvBuFtsutiFGm6IrX0+QFTpCi3NDKeP5bi2B5
 vjGTKxA97TkEBvjDfHLp8lQZt9HK2CPoqJaGGr8GQGApffnepcIZnIShndEiYHeG5wRw
 nk7ZQ/Kup+I8XHqFNIHsGMJKh8qhqdvUiSbE0s38LOXVabrkjCN8bDLMlsBW5TUSyVPs
 l5gl+I8FjG5ms+4ofL3Lab9yLxieMXBEzkKfaqiuolCxMwZXdj6x6/BHBP31DHS34cd5
 G4hRPRO/HDhexH6XjR8LPPZ8k7wCjnjrcD/fCf8BKKJ3XzTOhV3Xf4AmWZC9F6nCuy7m
 ygqg==
X-Gm-Message-State: AOJu0YzrWRdMZ4A103iviaBP4jOIVbpyqQ4ct4K5xzYqWE6+3ygyAtwO
 n1W/EBjqgzEtXPKsTSbqndqJp8x/3OKIIss46+ala/nEqVfuDimz5Wk4WNnXNI+OgmJrJCPWTed
 uzBcK+C4=
X-Gm-Gg: Acq92OFdfLXyaK16NoBt6LEt7CLlC3ogALRdtqQZ+qNnAinSzP45ePHX86zGQDegvVw
 soiII0laBt35H3phntHEbNZfICI9gtlZXbt2YQmXA1I5SUnTN542EucRTBT6O+eucPJwkWmbMfY
 bE2fH7GnRF/G3DOYWvyCDIuewpPOGymnjHKP45CyYEW/I0PcHYXPUM/q6o52dA5uAZIvBq16b6M
 r1C4oX+3uVnvDMAxxy4/VDc7D86TjhurcTXGTycAAY2omh8P2I/U9+wRtA/F8blUMkZBTT8cF2N
 zBi0/lDgKDUGSPLy31Gb6jbY+2kPl8A4d1rQoNvOyB0T98ttewMX5oaihXr7ehittIgjuxryS4x
 8roF41hJkZRtFl3aUjjAYgdzyWebgBRaJKk8wqyGdPYEgw/XRce5S4GMu1k2Yi8Fu0omcMhs8HX
 9qOz+oI10T3CuwJsC88uQcbKAKUOQYyX3uPq3/cs9sLStxv4nr2YKWZukBfCbZJ+RY3b6CF2KVg
 +fKtosfx5w=
X-Received: by 2002:a5d:64c6:0:b0:43d:71b:204b with SMTP id
 ffacd0b85a97d-45e5c5a518cmr40095565f8f.39.1779305203417; 
 Wed, 20 May 2026 12:26:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm55842762f8f.17.2026.05.20.12.26.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/33] target/mips: add Octeon multiplier state
Date: Wed, 20 May 2026 21:23:31 +0200
Message-ID: <20260520192338.40036-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Add per-thread Octeon multiplier state for the MPL and P limb banks used
by the VMULU/VMM0/V3MULU instruction family.

Octeon3 extends the older MPL0-MPL2/P0-P2 state with high lanes
MPL3-MPL5/P3-P5, programmed by the two-source MTM/MTP forms. Represent
both banks as uint64_t arrays so the TC state matches the architected
64-bit limb layout used by Octeon68XX user-mode code.

Expose MPL/P as global TCG variables so the multiplier translators can
expand inline without helper calls.

Migrate the multiplier registers in an Octeon-only subsection so
non-Octeon CPU models do not grow migration state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-18-philmd@linaro.org>
---
 target/mips/cpu.h            | 12 ++++++++++++
 target/mips/tcg/translate.h  |  2 ++
 target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c  | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b478f834c13..346713705a7 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -459,6 +459,14 @@ typedef struct mips_def_t mips_def_t;
 
 
 typedef struct TCState TCState;
+
+/*
+ * Octeon3 adds a second bank of multiplier/product limbs used by the
+ * two-source MTM/MTP forms: MPL0..2/P0..2 from rs and MPL3..5/P3..5 from rt.
+ */
+#define OCTEON_MULTIPLIER_LANES 3
+#define OCTEON_MULTIPLIER_REGS (2 * OCTEON_MULTIPLIER_LANES)
+
 struct TCState {
     target_ulong gpr[32];
 #if defined(TARGET_MIPS64)
@@ -497,6 +505,10 @@ struct TCState {
     target_ulong CP0_TCScheFBack;
     int32_t CP0_Debug_tcstatus;
     target_ulong CP0_UserLocal;
+    struct {
+        uint64_t MPL[OCTEON_MULTIPLIER_REGS];
+        uint64_t P[OCTEON_MULTIPLIER_REGS];
+    } octeon;
 
     int32_t msacsr;
 
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 89dde1e7124..ab2e2173674 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -189,6 +189,8 @@ void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz, int crc32c);
 extern TCGv cpu_gpr[32], cpu_PC;
 #if defined(TARGET_MIPS64)
 extern TCGv_i64 cpu_gpr_hi[32];
+extern TCGv_i64 oct_mpl[OCTEON_MULTIPLIER_REGS];
+extern TCGv_i64 oct_p[OCTEON_MULTIPLIER_REGS];
 #endif
 extern TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
 extern TCGv_i32 fpu_fcr0, fpu_fcr31;
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 5880b401b07..f988b3695bc 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -120,6 +120,17 @@ static const VMStateDescription vmstate_inactive_tc = {
     .fields = vmstate_tc_fields
 };
 
+static const VMStateDescription vmstate_octeon_multiplier_tc = {
+    .name = "cpu/tc/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(octeon.MPL, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_UINT64_ARRAY(octeon.P, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -247,6 +258,27 @@ static const VMStateDescription mips_vmstate_timer = {
     }
 };
 
+static bool mips_octeon_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+
+    return cpu->env.insn_flags & INSN_OCTEON;
+}
+
+static const VMStateDescription mips_vmstate_octeon_multiplier = {
+    .name = "cpu/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1,
+                       vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_STRUCT_ARRAY(env.tcs, MIPSCPU, MIPS_SHADOW_SET_MAX, 1,
+                             vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -363,6 +395,7 @@ const VMStateDescription vmstate_mips_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
+        &mips_vmstate_octeon_multiplier,
         NULL
     }
 };
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index dac30aff8d3..123d2c89c3d 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1179,6 +1179,8 @@ static TCGv cpu_lladdr, cpu_llval;
 static TCGv_i32 hflags;
 TCGv_i32 fpu_fcr0, fpu_fcr31;
 TCGv_i64 fpu_f64[32];
+TCGv_i64 oct_mpl[OCTEON_MULTIPLIER_REGS];
+TCGv_i64 oct_p[OCTEON_MULTIPLIER_REGS];
 
 static const char regnames_HI[][4] = {
     "HI0", "HI1", "HI2", "HI3",
@@ -15276,6 +15278,22 @@ void mips_tcg_init(void)
                                                         active_tc.gpr_hi[i]),
                                                rname);
     }
+
+    for (unsigned i = 0; i < OCTEON_MULTIPLIER_REGS; ++i) {
+        static const char mpl_names[OCTEON_MULTIPLIER_REGS][5] = {
+            "MPL0", "MPL1", "MPL2", "MPL3", "MPL4", "MPL5",
+        };
+        static const char p_names[OCTEON_MULTIPLIER_REGS][3] = {
+            "P0", "P1", "P2", "P3", "P4", "P5",
+        };
+
+        oct_mpl[i] = tcg_global_mem_new_i64(
+            tcg_env, offsetof(CPUMIPSState, active_tc.octeon.MPL[i]),
+            mpl_names[i]);
+        oct_p[i] = tcg_global_mem_new_i64(
+            tcg_env, offsetof(CPUMIPSState, active_tc.octeon.P[i]),
+            p_names[i]);
+    }
 #endif /* !TARGET_MIPS64 */
     for (unsigned i = 0; i < 32; i++) {
         int off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
-- 
2.53.0


