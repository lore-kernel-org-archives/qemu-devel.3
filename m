Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCi-0000FL-10; Wed, 08 Oct 2025 18:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCY-00008L-Ab
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCK-0007N5-Ig
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:01 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-78af9ebe337so230328b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960786; x=1760565586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY5b7YnlUaayPZ3GFzUnZ3Dj3BjqHV9oZEHTEIpzUQs=;
 b=S/G5n9pH22uhje8vpopYKO+rMgXa1clbFDMkcP+Ixwx0QwYN3Ho/k2hkQYh7zaFK05
 BoI0kqq4x4rAAmUOLEWD7r9pbDnaG87m/0uEzBPgaAK1M+KCE/p5Uk50es9OTT4vb5g+
 SZ4Ei1LXqrr3RXW/vMecW6R3W11yYZ+1pOV8ltIa+nH9xGmrx2ShGeoNos/LPdjbVQPO
 RtrXZ48KF9E47DEPHDqwYCcYv4q+mKSN3JEzK4CwF4hk3qUh3EgdybQrpUHAOkfrthdc
 MTgC3qINSW8vs+hJbP0OhX2n1DSuvs1OlZ0+6ROrWPdJRx4KMjFKK/onA3vCUJU9IwCv
 7TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960786; x=1760565586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oY5b7YnlUaayPZ3GFzUnZ3Dj3BjqHV9oZEHTEIpzUQs=;
 b=gfSWi8xTX3QI6RtrhhkD8Mc9xtgToKv6O9u75DHzHlYMulNA8UARXoxnG0tpW6oLV4
 5qUcLie8phlciSTRkGa72ZaPzrMVNipekrEnEQnWKC7fGNN9RtcFYA2+QL3RArTECmEV
 NQ7GsG2v0YrTB3p1heUu9xK11JfYZ0Y9aBunet0pkO7NjhXdE5innO73LV9vmMMFH7KW
 rDixrpAi1aUwfhv5ONY6Zz379MkVbzpkIqZnKMkGIIWoHo0Hxu6v9Shj3pARprtvFIsj
 7rdTT6pi2gat6hqv/nbcpcq9D0bZ16lbR0VabI9ZG80+SO1l7PgT3nTGiphM5MunpcHM
 rVew==
X-Gm-Message-State: AOJu0YziQ1kFHKbj6HWFEttTwvDP39ljctxWj+gCIGSyPiMrxJX0jzh8
 JIY6qV08irQsr71GEIJAEzvPQB4wEk37XZinyUhu9ZK9Bt+hCO2dXkVAFqoTN6jiK0QDCgeClDg
 6R8YulSE=
X-Gm-Gg: ASbGncvWpXmZKFk/jaqV2+7W4osmfeJ9TDknODvjSxk2KvoDWOe+0/4UVHkvkh4Zxu1
 4G7E3hBOsDt8xtuVnIxksY1aee9NCaDQmkF+R8rQ+igKi3HHqb6x+rAzZUq6w3RU9ZWqzANq+I3
 X5R7nHGcBdhucOW+m9cToRcHi3QX1EZ1JCOtk5U8DWuJAU5hCLqWv9u5Lq8Ofgtr1EZh3/lZwOU
 qfQ61xBtwXYoILkLhuZdSttfognBtyBHamDdHS4IsDfCzP1r3/FpRreAJv0c9/MiAMb9lTdkY9c
 N4VAH+4rEcXJTXcLi0XqDbm3aO+NHOMXe8QY7PRBv/61fXPyNiKJYD9EPBEM2tJtvOqELDslwal
 NDsWNTfqXF0b2qz2Q8n05Wr/ZV7KactJ+5crKRguXg4d/BRoDbCEfoWzvhaahOj6Un0U=
X-Google-Smtp-Source: AGHT+IFSKz8DclnBsdm+1DhgQZCSRLFBad4XxRnwUSy3MV9WdM7hA9NeqCLVh59TiTUISWg8ija1HA==
X-Received: by 2002:a05:6a00:2e98:b0:780:f6db:b1af with SMTP id
 d2e1a72fcca58-79387440b0fmr6043120b3a.16.1759960786054; 
 Wed, 08 Oct 2025 14:59:46 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 48/73] target/arm: Implement GCSPUSHM
Date: Wed,  8 Oct 2025 14:55:48 -0700
Message-ID: <20251008215613.300150-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  3 +++
 target/arm/cpregs-gcs.c        | 15 +++++++++++++++
 target/arm/tcg/translate-a64.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index a79f00351c..d22ae383cd 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -47,6 +47,8 @@ enum {
     ARM_CP_DC_ZVA                = 0x0005,
     ARM_CP_DC_GVA                = 0x0006,
     ARM_CP_DC_GZVA               = 0x0007,
+    /* Special: gcs instructions */
+    ARM_CP_GCSPUSHM              = 0x0008,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -871,6 +873,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
+    DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 1ff041811d..cc5a0b86e4 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -43,6 +43,16 @@ static void gcspr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value & ~7);
 }
 
+static CPAccessResult access_gcspushm(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    int el = arm_current_el(env);
+    if (!(env->cp15.gcscr_el[el] & GCSCR_PUSHMEN)) {
+        return CP_ACCESS_TRAP_BIT | (el ? el : 1);
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
@@ -85,6 +95,11 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 1,
       .access = PL3_RW, .writefn = gcspr_write,
       .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+
+    { .name = "GCSPUSHM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
+      .access = PL0_W, .accessfn = access_gcspushm,
+      .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 38a1f51ed5..625563d95b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,7 @@
 #include "cpregs.h"
 
 static TCGv_i64 cpu_X[32];
+static TCGv_i64 cpu_gcspr[4];
 static TCGv_i64 cpu_pc;
 
 /* Load/store exclusive handling */
@@ -77,6 +78,10 @@ static int scale_by_log2_tag_granule(DisasContext *s, int x)
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
+    static const char gcspr_names[4][12] = {
+        "gcspr_el0", "gcspr_el1", "gcspr_el2", "gcspr_el3"
+    };
+
     int i;
 
     cpu_pc = tcg_global_mem_new_i64(tcg_env,
@@ -90,6 +95,13 @@ void a64_translate_init(void)
 
     cpu_exclusive_high = tcg_global_mem_new_i64(tcg_env,
         offsetof(CPUARMState, exclusive_high), "exclusive_high");
+
+    for (i = 0; i < 4; i++) {
+        cpu_gcspr[i] =
+            tcg_global_mem_new_i64(tcg_env,
+                                   offsetof(CPUARMState, cp15.gcspr_el[i]),
+                                   gcspr_names[i]);
+    }
 }
 
 /*
@@ -420,6 +432,18 @@ static MemOp check_ordered_align(DisasContext *s, int rn, int imm,
     return finalize_memop(s, mop);
 }
 
+static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+
+    tcg_gen_addi_i64(addr, gcspr, -8);
+    tcg_gen_qemu_st_i64(value, clean_data_tbi(s, addr), mmuidx, mop);
+    tcg_gen_mov_i64(gcspr, addr);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2803,6 +2827,11 @@ static void handle_sys(DisasContext *s, bool isread,
             }
         }
         return;
+    case ARM_CP_GCSPUSHM:
+        if (s->gcs_en) {
+            gen_add_gcs_record(s, cpu_reg(s, rt));
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


