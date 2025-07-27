Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69686C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwPf-000352-Ij; Sun, 27 Jul 2025 04:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPU-0002MC-Ud
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPS-0004mW-Si
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-234f17910d8so29669185ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603625; x=1754208425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDuc8fKh0LQOOl8DOh+JTBa/BAss0l82OPl5+x7xYC4=;
 b=eBTZKv+sqZzM5a31PQdKmDDLn0G6NPiY7BU1G/0LExkVG/8x9ZJvinrzoXZm3/GzUL
 row/gqHzc+BJqwxRQgn4kW6NKmhjq9DP4/txf2VwHpMow0j92GgiR5BPUPFBDqmiR8Vk
 ujnsoBoJbsmebsLrFrPM9ZobPVhPip3QE8Jj1VuyJYDmVSXVnzNSIOHdx/iyuF7HnUx4
 4R8YK2cgfAeRvYPolgxHTWGJ+R57B0OXq8u86co3LnCLn3PfrhabytC3IHn35+9vIHHS
 M+u+oRRQlhiP/hE+tFM5LKxxZU7a4l/fkHnydcralQzDmuybqrBkubf6phxIczXRYRdo
 MUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603625; x=1754208425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDuc8fKh0LQOOl8DOh+JTBa/BAss0l82OPl5+x7xYC4=;
 b=BznEi1VK1uRAW2Ru1TINCLSG+Vz6cveqhBm8pG6ZfDh7N00JF9i3oeIS0s9pTr778e
 hatVaoSeitCcoKb2DwBClf+MemRrCdop6OcqQKy4EJU1ftwHKaKGeSIp6ox/+8rRxGaK
 Nbs0bDhsu8Hpx/mwrZ+yLWgLJ3wCIkyDOH96Np7uuaFZaaYZ404k/qryEXxBlRJhpUjq
 iV8rT8k8PkeCzRveS8MQMWlFHBBS65+G2YeMplVkEOEEJXAF8GZruLiY/yFZSr4Wpwag
 pEl4PCDWTqYMqrCMQkCXRUBciIjomeRZmz3Rh6tB31/ovlAfFEt6pWmteFPJPnjOdRf3
 lrwQ==
X-Gm-Message-State: AOJu0YzQlX8kkqzHi3jhsc62Vnpjjpe/ubVyGeAtfUH862DAIVbSf9Bw
 IMjzs03MVKnt6e/QyTTwtaiuYZJGm+Wo6rwQ87VLoNe8iXOy1q1n/qo2g1OhVvBgOmZtUiBT78c
 lRLJ+
X-Gm-Gg: ASbGncuY245TvEPbrDiiinF/s/8qPSObhV3ljoQGDs8xlbrGCq+lJeobniq+zYwBd/1
 f8V3OPkwHNFlUTPIhP7RMP1EWvh0uK8Bls+gKmW4hz+EMbah87RcDHZMKCZUEtGccEygwOPlk5N
 UliB8wMLdwdqMCTy6GGESgquvKI7XFL8IXtzweRQTeBXAjqUIe1zv0rmFBdaXcBfkR2ALznc/IT
 ryXLfEte2DTn1PsjYhZ32CThvfUdFTDI6+LkHsInYvD4abQe8It6v4tRfoXve2zH3DFFL1t+DrF
 3GWIcTYAEIodC18fZPbf2TKWrvJz08SCTDC5R0vGcgius46GL2/3ooNFZIWVwbv9z7WdyTx21T8
 gBe+0BwaGxYoi487LGMMNgqg24pJFSbHn/aA7DEyj4oFlL203UnqYzPXZaRxPJbbEMQmNeXQ+zJ
 puQHVr5WBwQw==
X-Google-Smtp-Source: AGHT+IHEPehRsnkC9wrTMnTMmS/DiL/1EuKCOkIQH2VwEJ/Ybz9CBNEVkvqnwkHJ+0c3j2o9nLMQIQ==
X-Received: by 2002:a17:902:f688:b0:240:483:dc39 with SMTP id
 d9443c01a7336-2400483f97fmr21316945ad.47.1753603625438; 
 Sun, 27 Jul 2025 01:07:05 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 56/82] target/arm: Implement GCSPUSHM
Date: Sat, 26 Jul 2025 22:02:28 -1000
Message-ID: <20250727080254.83840-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/arm/cpregs-gcs.c        | 16 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 18 ++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 15894332b2..93358e6123 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -46,6 +46,8 @@ enum {
     ARM_CP_DC_ZVA                = 0x0005,
     ARM_CP_DC_GVA                = 0x0006,
     ARM_CP_DC_GZVA               = 0x0007,
+    /* Special: gcs instructions */
+    ARM_CP_GCSPUSHM              = 0x0008,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -861,6 +863,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
+    DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 9c06100d2b..38987372c9 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -33,6 +33,17 @@ static CPAccessResult access_gcs_el0(CPUARMState *env, const ARMCPRegInfo *ri,
     return access_gcs(env, ri, isread);
 }
 
+static CPAccessResult access_gcspushm(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (!(env->cp15.gcscr_el[el] & GCSCR_PUSHMEN)) {
+        return CP_ACCESS_TRAP_BIT | (el ? el : 1);
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
@@ -69,6 +80,11 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 1,
       .access = PL3_RW,
       .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+
+    { .name = "GCSPUSHM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
+      .access = PL0_W, .accessfn = access_gcspushm,
+      .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 45ff7bb0b2..a5810be2f7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -420,6 +420,19 @@ static MemOp check_ordered_align(DisasContext *s, int rn, int imm,
     return finalize_memop(s, mop);
 }
 
+static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+
+    tcg_gen_ld_i64(addr, tcg_env, sp_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(value, clean_data_tbi(s, addr), mmuidx, mop);
+    tcg_gen_st_i64(addr, tcg_env, sp_off);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2765,6 +2778,11 @@ static void handle_sys(DisasContext *s, bool isread,
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


