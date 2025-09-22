Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D3ACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lgi-0006Me-7S; Mon, 22 Sep 2025 14:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfV-000401-13
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:46 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfC-0004yG-Vt
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:44 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b551350adfaso3678681a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567203; x=1759172003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0CTHCHuiAatusdRHQp8yXTYIa1OlsScLvAXyNFVs1Y=;
 b=WqfN9J84b3Ejglxc/eOiiVNZRn2ZH7XR34/CnVq47689nQd/C+EOK6zbcEf75OINTO
 ARnlSNMgiFMrzW8hKkGQN+OwlFWTsLMy9iOBIalGeqD4n1v/+F6FUytGaAU+3qzJo7xJ
 SySMOwSRpfBFMwLqXe243Ffi27EQWEryyltz21sPuZpTS0M5nbycDeMsESAH8eY1kRg6
 A1Ru3TIt7pSXjNa4LdekIW7WFa6N6sLsGGK38WukULSKFD8CxSG8yhciL5hBkQR5FtV9
 tO8wsGE6IQ/y4Qbya7gBi88oAC6KzGOSpCQGDxJxjxNXXJIrLxrNe5osVnFoJaIyVSX9
 8OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567203; x=1759172003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0CTHCHuiAatusdRHQp8yXTYIa1OlsScLvAXyNFVs1Y=;
 b=HkNoyzO5LBfmrQHaQ7uXj1joEzAUX+zqIpnw5u6h5HSfJZ5q89jVRha+HitpMV8CoH
 2AGdmTE/69nfX0JtWm0Zc98GjRnNWxUzzvcL1Q5ylvSSvjZ8jTYyw4LNU7GJEwLwcDW1
 tQEFtJJlymzPhtaqWuEzYBtm86+J2Es6JBPqykVtUrOpS+HrtCSzqeBH8E9pfTP/V1J2
 sNlfKENsTFAjgNMx3vkhEwgxdDypEJzWk3vgh5QjEnuEQoZAFIpRMHVx1pzuEiC9K00b
 5Jnnq3STOiuZK2Y+o0/zagGDoZ0b2hBXWrTDqEealxhnMR+cS3kdS8HWXQQPieuS4XfQ
 paCw==
X-Gm-Message-State: AOJu0Ywe9t3+mbF/0EYm/ylgwaQFpjQE8c8jgCWnJRozmO/nuz+w/ckC
 H5Ep8rHubO2WId0SDQ+N4LIgx4hjZNgaVctfqonzA0v15h5P/o9XJBvCwCPB3Cw63zhA6z0kN07
 B+ook
X-Gm-Gg: ASbGncsFoIpOwPDcrlGLDuK8TpeErHFVvyK4G/6k7+4qOyX4MaX0z9R6Le/d3hMNeUx
 laVG/FOHZNMymR3114Ybhe23opUB1W6gb7VR+pmgNDTW/2UrSTUpspkQC4tyKd2APZCc3ynZU/0
 NJb/bn4+GKuxEKRccR45QgF91YceKmFMDIYwQ+W/uSxfx3zRHWd0cXmLYIFEvstKdAkI/QWcl+/
 0PK7/yKyDv37DQMHrrU7E9ZIdHhI3LnxF3EnC8dGCtDrxcsqbfYLM53W8ZII+CEFxO5wkE9txVu
 5BMk86GwXA0JUa2TrqL80mepbpKfbGeBj1fCaud6nAYX59xbcD4ncmQLo4JhXbeHGOOprdaafeq
 h/2yvlgiVNoO2X8muPerBgP8BtVXd
X-Google-Smtp-Source: AGHT+IH/yOmd3njL5lk9yBqpACCUQYga68P914PkIhdkCoAbb1eyVFUy+ejyCqnVofIIGZbptjsRQQ==
X-Received: by 2002:a17:903:2285:b0:268:f83a:835a with SMTP id
 d9443c01a7336-269ba575f3emr162514145ad.60.1758567202804; 
 Mon, 22 Sep 2025 11:53:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 51/76] target/arm: Implement GCSPUSHM
Date: Mon, 22 Sep 2025 11:48:59 -0700
Message-ID: <20250922184924.2754205-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
index 7e45197d8a..e2af10c075 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,7 @@
 #include "cpregs.h"
 
 static TCGv_i64 cpu_X[32];
+static TCGv_i64 cpu_gcspr[32];
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


