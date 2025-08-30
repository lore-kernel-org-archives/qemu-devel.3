Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B4CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNxq-0005bs-El; Sat, 30 Aug 2025 11:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usER1-0007LJ-5l
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:32 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQz-0004x5-9T
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:30 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso2419962a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532848; x=1757137648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlMDePceCGyIDKPJVA4FDsC5S2EUjyL2Wq20QLthmQU=;
 b=gXmWZuUcIHUQp5jj1zFRZprjeJxRLp9PnPN6oGbC+kvIwwzvUHDXthu1Ns4pZ7a8EU
 xR1jsHmVxRN9YA7V4E9fxmFbSpiJdSXfG3P6h/Yfs4lCOY7rad+o1xwzoCfrQnl76b1c
 wUXYmdr5kb5M1M/BqgaIUPt20486t9y52U7NSHgUSM90Pkvtj6BI4CYnpCxYCx5YBkB2
 nZrNRMVbGPKpXp4cvdEQ89enmyA8G2cA606E5EKm8bl+RWQ1+22YXUXuRCwIsIFLN7p8
 t9v47ujheJLT09G8MNHMfurJLBnetoxgcQdFUUXbHAj5ZCuK51aFHVQ3zC/5nBl9KvMh
 S7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532848; x=1757137648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlMDePceCGyIDKPJVA4FDsC5S2EUjyL2Wq20QLthmQU=;
 b=h3q5DnowVNeAS8khe/UDRfWFYhcrM3B/xmDKsSncwO3XYAKbkqbHRShEHeokn7Yhul
 TiRQ/mZijXjpc9zIkFjtt6U6YMiEaTASaXHCja/spRK5kEuoaYdJMj4nVoxDGmxtc6Rm
 d7/4Exoht36PC+XU6eF99q/wFFsbANWhhsoNR55XAOf/GAnTwqRZtwoFaGvPLNqMWoLl
 j1MRNE5f8l5shB0KYV/O/mCRE6RLMoV9t+EzvR4+q97q8d8xa20z5y9o6Mx8l+a//rBy
 YVTIX8PP54UqkdnOy+gu4dWoHhhve/bG87S7BhllA99iubPP7W3NSnhhs4Qc6y0dVzM2
 ZpOA==
X-Gm-Message-State: AOJu0Yx6FFTe5WKaCgSMcSwg3Qfahmd6+yIUP3RwOQkrTlBZ2hnMYi40
 njQ85tjhgsK27EXhQr8S8RkQIxDKvrw/45ZWl303j5Y/nal1OYpr2RMtACBMkuZ2opZfl+lBkOv
 sq9lbKiA=
X-Gm-Gg: ASbGnct8qgQLtPsYz85VF5vuCPAP7qKeQLBg9Ir9OY8f+LqQ51RZHByAIxJj659b9G8
 b8jyEna4T+dA55+Ql4X6Fw6KI8amICpqbOB2Ng7iDU77zPT8dZKGVfBL+4UuEOFOvzumaiUyHjc
 3RMgObwSBqJTa4NwS9PagPyL/o4twB2gozXV9IQm4ZdZ7OLeSPtj+oxc+9fyXpd7XN3iHB6Dz11
 ILzON137sNFZ2YmICTkOGC6sJ+SaQBra7u/yc34B365BfeE64zNJ09h8SSW6CSEjiHJG6c39Jzd
 4CL+T4fzonzj+d+aflZJ59M06/FrwQa//kXZdyZ5wgaJn2k8VCdkbqN+382UGl79BDSeF+JaG71
 Qw1ygtwOmf/cky0Hlv0GvLpB4udqE7g+p6AkdyqczDO/X4zliNmes4p6lQWdUXYo9fScDLRrxxg
 ==
X-Google-Smtp-Source: AGHT+IFKw/EXUIEpDBTlJuhWT5kNLq+Tw1YQuYA0rj1867Uco05R/Ogl8Njfalg4qUQO1SU9Qtlk3w==
X-Received: by 2002:a17:902:d4cb:b0:246:cfc4:9a52 with SMTP id
 d9443c01a7336-24944b64b33mr14862055ad.52.1756532847892; 
 Fri, 29 Aug 2025 22:47:27 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 61/84] target/arm: Implement GCSPUSHX
Date: Sat, 30 Aug 2025 15:41:05 +1000
Message-ID: <20250830054128.448363-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  2 ++
 target/arm/cpregs-gcs.c        | 17 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 9b19520346..3d76afd20b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -49,6 +49,7 @@ enum {
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
+    ARM_CP_GCSPUSHX              = 0x000a,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -865,6 +866,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
     DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
+    DO_REV_BIT(HFGITR, NGCSEPP),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index fdefb2e17a..c688d0c391 100644
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
@@ -99,6 +112,10 @@ static const ARMCPRegInfo gcs_reginfo[] = {
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
index badc24d2a5..e5d9a6e837 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2531,6 +2531,35 @@ static void gen_gcspopm(DisasContext *s, int rt)
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
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2818,6 +2847,14 @@ static void handle_sys(DisasContext *s, bool isread,
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


