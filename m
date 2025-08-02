Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C2CC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLrd-0004Hs-Af; Sat, 02 Aug 2025 19:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLni-00054B-DF
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:06 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLng-000685-7s
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:06 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2676116fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177883; x=1754782683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyjvE7tLoNvvOOPaDRanKy/MG4hCXN6uGYfK1f3CD2s=;
 b=Wg7iVRtNprMX/1N5QnXTD3tuXzqdWaZd725NHL0wnGJDGheMF5QXCeYlBmX/UQsSdl
 At5mkDCpIVEVPBKl6/hW24fblJD/rYduNhF78LC5ci1tqPL2lHuH8r8A3F2tRvsCQtoS
 kX1zh5H2588bS86Mb3BLTmAjoWIQ50F8EmNtiLM7a7WGKgRvplQ00y1pHhhXTeZXWUAt
 j56Cn4sE9iezCNp9+0lELoKKAUvbtQslx/lRgcOB9qtJB3Kj/dx0cq9A476L/JezcZNa
 zAJ088xpjViDSm3n96/nxBKfpguyr+wL4mZWrRWpe0kqAC2oZIxz/gxgLuA39Me569GV
 IRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177883; x=1754782683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyjvE7tLoNvvOOPaDRanKy/MG4hCXN6uGYfK1f3CD2s=;
 b=cKxIU6wiNSE5Xz1lH+8uzmNuUdFhBxAEC1Ahggwt3FGw3stIilhVpSffmqGhBg/Sj6
 1OVG0rV0b89hYFk6fW0PpNZCAKiij7ZkJq51ZPk3KB25IeiJR/VK+qtq6FvKXsFFppKV
 cnpYpq8CfkUcuQzYwSi1wLP0yRfk6BQJuyy7gM1cZTaoJGYnV5TlaVcTr2IsUhHYJMbM
 R11Pf0BfF5Km7g258crtwE07BEt46MHdZpySp5j+inJywuLbpOwuKNhiNYeEkvgwHLAr
 AnjsBxYfa6vkVjUrixP24BF1Qk9xSp6KAh1qvnF6+MUiM9vSahypURsNBhKIT5tPPbrV
 ri9g==
X-Gm-Message-State: AOJu0Yxdmnz470aNvHMxoMKqBWSdRNK3Nl6hIscFbmmPFaeJ6CmoSRx6
 pUMRHfm/rNUmgU2khJlkKA1WCF8aWWzpfHWdwS+axc46ei3mzolj+naXRzu9M3lypOfF++9/GFd
 vGbHXYd8=
X-Gm-Gg: ASbGnctGcLRRzOE3APB9mYMB4740PDDSJX3J7bcGVK8TFI9OB/ZBnTJZZREZ9exCsGY
 H/7eCgmP/as380IMWbQPZy00vSiPobp9RO9eEePPh6mCbvqXAinpYVQbCAspcNhXjFXgGsPI/2V
 /vTQOo/EZvayMIL5dqU/sc7ZAcaEfTFnD7yQHGRw26e/mQFC59XTU3nwgm6vIhD3U1TdDy35wkX
 bkAK914dSuxlXQKPCH6NffdClis9kWZEiI4bq0v6to579sV56u1ymS66Irs7llWJuq4EbSk6OLq
 YV0jejQ/y/bxzBwsB4E7vpeqjzGW1VyjE3gu9y83xIOS19qV+5ilLg07wIP+a3UoylwEQw4INBg
 QsSnzaQeUCyP/Vxg10hvuVP2dRDhMN6/GlRzk+f2PD/XpMIXdF15m
X-Google-Smtp-Source: AGHT+IGQTKEiQuPwZkmJFElGWsiEZ7SaKWPLGf3LS/p1YtViZ0Q8a0+2WSXNtXXeolQTafvKVSFTdA==
X-Received: by 2002:a05:6870:3750:b0:29d:c764:f873 with SMTP id
 586e51a60fabf-30b67ab1096mr2769470fac.31.1754177883036; 
 Sat, 02 Aug 2025 16:38:03 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 63/85] target/arm: Implement GCSPOPCX
Date: Sun,  3 Aug 2025 09:29:31 +1000
Message-ID: <20250802232953.413294-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        | 17 ++++++++++
 target/arm/tcg/translate-a64.c | 58 ++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 084ea00e51..392a0a264f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -51,6 +51,7 @@ enum {
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
     ARM_CP_GCSPOPX               = 0x000b,
+    ARM_CP_GCSPOPCX              = 0x000c,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 2bdd41c796..ab53a4314f 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -57,6 +57,19 @@ static CPAccessResult access_gcspushx(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_gcspopcx(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    /* Trap if lock not taken, and enabled. */
+    if (env->pstate & PSTATE_EXLOCK) {
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
@@ -105,6 +118,10 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPCX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_gcspopcx, .fgt = FGT_NGCSEPP,
+      .type = ARM_CP_GCSPOPCX },
     { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
       .access = PL1_W, .type = ARM_CP_GCSPOPX },
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 773ed3044d..af91b7f95f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2555,6 +2555,56 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopcx(DisasContext *s)
+{
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int spsr_idx = aarch64_banked_spsr_index(s->current_el);
+    int spsr_off = offsetof(CPUARMState, banked_spsr[spsr_idx]);
+    int elr_off = offsetof(CPUARMState, elr_el[s->current_el]);
+    int gcscr_off = offsetof(CPUARMState, cp15.gcscr_el[s->current_el]);
+    int pstate_off = offsetof(CPUARMState, pstate);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp1 = tcg_temp_new_i64();
+    TCGv_i64 tmp2 = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPCX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_ld_i64(addr, tcg_env, sp_off);
+    tcg_gen_qemu_ld_i64(tmp1, addr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp1, 0b1001, fail_label);
+
+    /* Validate in turn, ELR ... */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp1, addr, mmuidx, mop);
+    tcg_gen_ld_i64(tmp2, tcg_env, elr_off);
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp1, tmp2, fail_label);
+
+    /* ... SPSR ... */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp1, addr, mmuidx, mop);
+    tcg_gen_ld_i64(tmp2, tcg_env, spsr_off);
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp1, tmp2, fail_label);
+
+    /* ... and LR. */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp1, addr, mmuidx, mop);
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp1, cpu_reg(s, 30), fail_label);
+
+    /* Writeback stack pointer after pop. */
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_st_i64(addr, tcg_env, sp_off);
+
+    /* PSTATE.EXLOCK = GetCurrentEXLOCKEN(). */
+    tcg_gen_ld_i64(tmp1, tcg_env, gcscr_off);
+    tcg_gen_ld_i64(tmp2, tcg_env, pstate_off);
+    tcg_gen_shri_i64(tmp1, tmp1, ctz64(GCSCR_EXLOCKEN));
+    tcg_gen_deposit_i64(tmp2, tmp2, tmp1, ctz64(PSTATE_EXLOCK), 1);
+    tcg_gen_st_i64(tmp2, tcg_env, pstate_off);
+}
+
 static void gen_gcspopx(DisasContext *s)
 {
     int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
@@ -2879,6 +2929,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspushx(s);
         }
         return;
+    case ARM_CP_GCSPOPCX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspopcx(s);
+        }
+        return;
     case ARM_CP_GCSPOPX:
         /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
         if (rt != 31) {
-- 
2.43.0


