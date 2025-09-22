Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A175CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lhF-0006uR-6x; Mon, 22 Sep 2025 14:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfe-0004hD-Vt
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfD-0004yb-Eh
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-27a6c3f482dso8198785ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567205; x=1759172005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJnBJjRiP4y1OwdJ2Ay72udjkm2SYCj+86pxIAQKNCE=;
 b=EJ5acCxYA4rwYJsEzbyfi8TxxKNHYZim8wa4Lx0qmeYUBDgLRvJ55eeOTwKQRFR22I
 p/OTYa8FV8Z5e/z6Q5AGD44xAWWIT5OL2F2MfZWLWDj25KuKU6RhrhoekIrm7gwXMsNa
 j/OhBSC/tr7IYF91tcPvemLtVR/jEjVrpf/j2r7ykoyWsDhXmG1x4CX9ef+aCRmYhEVz
 zevH0GhppNWIFyhJ4Cy4UbssYtlTtXXFv8cwvocx5EUHN+7M8GOiiqaBwwKqbemKLR5S
 499xIwKyGQwN7TVk6rNeU7zNpewjihEe5SBQ8QENijonZca3iJ/XLSvbXNR0fEgwSTlD
 +mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567205; x=1759172005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJnBJjRiP4y1OwdJ2Ay72udjkm2SYCj+86pxIAQKNCE=;
 b=XMSgjhWS+9ARrfNlbMBTgNif+lLfmKLcP1Ist+v6XYP2YoSfQZgfWgiFJVbYxB5mjG
 3CFsfP0eh9Mhme/arhOx1el96hP9BkP1qx7BT8O48Wloo1lizW2gOF6yzVSFXE3hcRaM
 aZlfaTgIhnooKL+/XDFC0S3ZRFsCtG0zq1l0EPn2zhfE7hKZezn/WolfCSEPNpcrQMP/
 EPGB57HDKw3Qjn+q2nkCbuJVxUkMoMRqRI+ACORD5d6yJJgBJXD2OIChK8mohKwSkj5n
 6J3D19hoY6BsPuOD3b+2I1NiNwYNblvUpaGCMXpcd6zvL8gGomcvmaoxLXcdHROpQU0F
 EP+Q==
X-Gm-Message-State: AOJu0Yx2nXK9bZLskzZgm+UKODtPaP42ZaGn64m94G5wvm2qfyTefmRQ
 trCPW3tnCN2yblzQ/GnXbrBJZ7xZlIFmVFqaOkSu0DTKpKq6HaI+LhHSL8c9uS2tblP9fkyzTtl
 Y3Dsb
X-Gm-Gg: ASbGncv9sb997pYYBFNWFeyOzYTnnqP/wlZLl1xUwnEakPUjcsuG8lGcgQgPYeO1QiX
 s+hrG8DV5z9d1qbuZd99cyOxwOHF5xIbUehfhs5Q6IxxYA/9kQhDpkuu9+RD0wRO0ovKTz2AjR9
 2d9VWH+1M/NzNkl/WM2byC4WA0S7T4UUGP9FSV0cp9qCbDoqsabRRFVNcmb0oCbC0rP8XLIoKXu
 2ljBuftsmtg1W2JHsv1RQCil9zNQAfvDRYj+V3ylbZYchZpVFk2RSGbhpTDFg8mgX97nTDjDxec
 yiABbRZwkVOL15g9UW4XNK4+wWKMMWM2TjHGEceB3OvPzrSB9QmXfvJlnBka06yc8DJoaHpjVWF
 9uCqWRdue5HY/MxM6/OPOD3q9fLUnVzY158f4K1M=
X-Google-Smtp-Source: AGHT+IHgLgesiMCFf2XrkmVacjLeG/kS2zjrYQJcMylxE2oiEUg2pp0Tl5i22vTBZhGfwFpR3mJFAA==
X-Received: by 2002:a17:903:4b04:b0:235:ed02:288b with SMTP id
 d9443c01a7336-269ba5167bemr156647975ad.30.1758567204641; 
 Mon, 22 Sep 2025 11:53:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 53/76] target/arm: Implement GCSPUSHX
Date: Mon, 22 Sep 2025 11:49:01 -0700
Message-ID: <20250922184924.2754205-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  2 ++
 target/arm/cpregs-gcs.c        | 17 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 81d8f0e32b..909916b7fd 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -50,6 +50,7 @@ enum {
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
+    ARM_CP_GCSPUSHX              = 0x000a,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -875,6 +876,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
     DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
+    DO_REV_BIT(HFGITR, NGCSEPP),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 15d383b2a4..e6c7025d02 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -53,6 +53,19 @@ static CPAccessResult access_gcspushm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_gcspushx(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /* Trap if lock taken, and enabled. */
+    if (!(env->pstate & PSTATE_EXLOCK)) {
+        int el = arm_current_el(env);
+        if (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN) {
+            return CP_ACCESS_EXLOCK;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
@@ -103,6 +116,10 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
       .access = PL0_R, .type = ARM_CP_GCSPOPM },
+    { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
+      .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
+      .type = ARM_CP_GCSPUSHX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c52b02b003..6fe6a77b34 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2539,6 +2539,35 @@ static void gen_gcspopm(DisasContext *s, int rt)
     tcg_gen_mov_i64(cpu_reg(s, rt), value);
 }
 
+static void gen_gcspushx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int spsr_idx = aarch64_banked_spsr_index(s->current_el);
+    int spsr_off = offsetof(CPUARMState, banked_spsr[spsr_idx]);
+    int elr_off = offsetof(CPUARMState, elr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_addi_i64(addr, gcspr, -8);
+    tcg_gen_qemu_st_i64(cpu_reg(s, 30), addr, mmuidx, mop);
+
+    tcg_gen_ld_i64(tmp, tcg_env, spsr_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tmp, addr, mmuidx, mop);
+
+    tcg_gen_ld_i64(tmp, tcg_env, elr_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tmp, addr, mmuidx, mop);
+
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(tcg_constant_i64(0b1001), addr, mmuidx, mop);
+
+    tcg_gen_mov_i64(gcspr, addr);
+    clear_pstate_bits(PSTATE_EXLOCK);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2856,6 +2885,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspopm(s, rt);
         }
         return;
+    case ARM_CP_GCSPUSHX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspushx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


