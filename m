Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1C4CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lgn-0006S7-K0; Mon, 22 Sep 2025 14:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfr-0004yw-Sp
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfL-0004zZ-EW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2570bf6058aso63815255ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567209; x=1759172009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9D+fehUgbWL+gWO3WeerFLaijU6kYDwf2dSp0estdI=;
 b=pio1LLdoWM8OqG3hxvjPpGD1z3ej9Rj7T+2KThH2I90FXHnWlhf/VhBghtuSH8vnq8
 W+YGvoZOjmMtRbhQEfHlM0pAzCW//t33l+5zNnxllQQTxqJ9e/jk6Cj4jQ8PWOFoa+4j
 KJxNJzPwq783YRhPmJ4intfSDc4WlKJuEszdHOoJy5o5lFoK/t+exvGZ3c/olP1bonzX
 4/C4T/18vXNl2kgkgwqxMmAXYSqltXi/v3Sf4zpQvikguuoAmfZkUFUSK6CYwSApzpeY
 fbxW0cdwZUu7XMutFU5Od2pX1u/bQNWOunSBiJjl/GM63TWPwh/a0XiNAvUjb0xRIXNi
 Xhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567209; x=1759172009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9D+fehUgbWL+gWO3WeerFLaijU6kYDwf2dSp0estdI=;
 b=NcdqDVbzA9PG6LX2mfsegxN85mncYIfZcp3n9ij0J7N6Sa4HppOA1uH3G6NI5HzZe1
 AL82pcNyBsKFGlWY5BArkMHd9xOuX4t14RIWA0R6O+aaQkLgy5PHtQewWGCNhQEbrUcB
 He6wfgr3JYa1PKr+rkl6le0EORhBcmBbAQtfAjM/sPM+ewupTu6Kc9Td8Nhzb0zMyj74
 10R3aaJ5skXN5v1OPaEATiKBTxVTAqnp3LCMv8ekxym3wUG9KiO/oUCQURWnlGJDxnAi
 Sb/fjgsNyXUHhrEWJnRolNPzNj7p+qGfSpehqploxZGptxEUsQEiUInU6WwWKHEGyqe8
 KUgw==
X-Gm-Message-State: AOJu0Yx5FE4bU7lvDLQLFbtDotZyl0SIzXhQGu3JUiji39tj//V0qbvl
 DQAO45lWt+CJe6A+pUIH+SCnKpTKsYjRxbS3bV/35yIkC99FNSBPSLU+qz947O7zmnpiyX4rriF
 mGeeN
X-Gm-Gg: ASbGncvlkbPuMRIejKCxc4pzBXuFyD1rgT3L1QSzmeNic0J7H1C+4IWMi4ZejDLtPJ3
 MutVAej9nu+rjFTDB0KLo2/d0zVAD4c8bN1R7LjXzN2vh04W0Y/XZr77d1L3IY+H9ki4nXx+E9D
 1p9LeExy6kr4o4aH1q5g1BsRL6YztPQhzJpAKinnNHKJ1lTtGbQYxAt7CGi4TtzwMiGkQiyo7LO
 Al9Vj7ZQWNmfuxfIlKgGC28Jzqlg7vYiTkxyfasUNuuRP3lJhTCua5kAYW3FPLiv7a4E3z4zugX
 P7MQA1y4aRYmD8B9WBsvCB9ItUHgEAsHxIblEytgvcItvRpDdfDh6V1KFk1O3sRUEWXv740ZOqz
 hJbCQ1FjBLiezv5XWJ7lmzlF9ZbnS
X-Google-Smtp-Source: AGHT+IHBhJq9LgTMKfvvEOZuuS+eirzR9Xj8AOaDe7roxLo/US/Sm70MW/WO5CJHenG5Bk6RfC2pUQ==
X-Received: by 2002:a17:903:19f0:b0:26b:3aab:f6b8 with SMTP id
 d9443c01a7336-26b3aabf9c6mr171634265ad.58.1758567208812; 
 Mon, 22 Sep 2025 11:53:28 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 57/76] target/arm: Implement GCSSS2
Date: Mon, 22 Sep 2025 11:49:05 -0700
Message-ID: <20250922184924.2754205-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index e7e7050880..732c07506d 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -54,6 +54,7 @@ enum {
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
     ARM_CP_GCSSS1                = 0x000d,
+    ARM_CP_GCSSS2                = 0x000e,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index eda5c498d7..1ed52a211a 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -132,6 +132,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSSS1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 2,
       .access = PL0_W, .type = ARM_CP_GCSSS1 },
+    { .name = "GCSSS2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 3,
+      .access = PL0_R, .type = ARM_CP_GCSSS2 },
     { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 54e7546c8f..dfa2a6d64c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2668,6 +2668,35 @@ static void gen_gcsss1(DisasContext *s, int rt)
     tcg_gen_andi_i64(gcspr, inptr, ~7);
 }
 
+static void gen_gcsss2(DisasContext *s, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 outptr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSSS2, rt));
+
+    /* Validate that the new stack has an in-progress cap. */
+    tcg_gen_qemu_ld_i64(outptr, gcspr, mmuidx, mop);
+    tcg_gen_andi_i64(tmp, outptr, 7);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 5, fail_label);
+
+    /* Push a valid cap to the old stack. */
+    tcg_gen_andi_i64(outptr, outptr, ~7);
+    tcg_gen_addi_i64(outptr, outptr, -8);
+    tcg_gen_deposit_i64(tmp, outptr, tcg_constant_i64(1), 0, 12);
+    tcg_gen_qemu_st_i64(tmp, outptr, mmuidx, mop);
+    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+
+    /* Pop the in-progress cap from the new stack. */
+    tcg_gen_addi_i64(gcspr, gcspr, 8);
+
+    /* Return a pointer to the old stack cap. */
+    tcg_gen_mov_i64(cpu_reg(s, rt), outptr);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -3014,6 +3043,11 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcsss1(s, rt);
         }
         return;
+    case ARM_CP_GCSSS2:
+        if (s->gcs_en) {
+            gen_gcsss2(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


