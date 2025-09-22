Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD31ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lhd-0007Yv-Or; Mon, 22 Sep 2025 14:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfi-0004lB-HS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfI-0004zL-B4
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-267facf9b58so34909385ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567207; x=1759172007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7rwZf/Zg8OwtOGVMlND2TzYNF4uLWoBORNdt1IjSzU=;
 b=hlgjKfbCrNay4V3tRwhV7GXcQBMILrSatr5Pq1IGMy7UfF0wcIP6MOywW35uVM5xql
 CVwd7bVLZ18TODOl6s8K4pnhVKYJMZ6wPr/9gmXgq+C9OhhUheDRFrR81aj8SE2uyXc9
 cZB5qC6yUo5y37ihffSve9jOKkvYC1LZ0qadGrGucixeM09EgRIy+JK5b9vFy1SrqLES
 WR9PD9cUr6qOeKdX+Ud7UwHsgkGhGA3XRponNYXgTnLV+BGKvQXUmLtSAe6N0Ib4ZdW7
 Hoy309K85nYw0Mr6h3n79EkJFLKx0WYyD0aVK29Cevusth7GnhaT6PDDFi+BWzFRuVnE
 HGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567207; x=1759172007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7rwZf/Zg8OwtOGVMlND2TzYNF4uLWoBORNdt1IjSzU=;
 b=STw5jAYlbeNjChHeQKF1t4A3qBx7wb3vnKQRzyQYqgEysUSTfzeZc8LMqwzurFZRBK
 2MPO8fIYA6Doye9dkfK0l5zPbpuswHwpbSVybGKSk7fcqnWFqOEvG6K9vtUWMvG2kwag
 YKXnhD8n4vP4hhs55NGmWxoIyq4Po+ahs+HFXVaqaDSC8JzN1IMp3qDY1BeMDrnEUrxk
 /xFEB0/2SwUdCT0zP/yqo4bUkw/uye/oz2DzsMaqI6YJXV5ouAFzuz32oUv8MF7TR18M
 Da5YKQ2VuyvFIsT4/v952BCV8K5Oc1pFCXn+kfFwFh4643CnVqFYodV2AX60iF5+VjDl
 EzvA==
X-Gm-Message-State: AOJu0YwXkjkZaIxGQYmWimq4Wx8yclhPYv9kblzG1GYUpr5jgDJYlNQp
 2kDE3O/ZKqsR01AcoZMczgjS7dYAMxAnFOQ5yvoJcetBHta8ZWBToUz2lmBzJVGBGk7cbKMJrcW
 kfLZJ
X-Gm-Gg: ASbGncsFLFKw4zh3qOyYuOWFYfOhftoJSFuRx5RYhFRlQ/3me6BYE0YE9EnVZoZ5a0X
 a5T9sASM0I/B5sBv8MsyIgBYolitFRYJOL0QE3fPkdhfiWwvuyx4arTZRMdiyfeqPDNoeEBSKuX
 RKe6uCc9V27BgeBhYPfrNAEWJ0xwNPbiSkNPWHPZ7iPjqaxJhxeM5frvVVYwCJaYpx7Moj+xQDr
 XRGuDdlzccf5Y7tHItBK8/emie1FGAmDNveyuIL3Isk0yU20lZ0h4WBVO6KVu7g8P/7PgZKjsH7
 4UJYoGM5lP4Q4g7cqnmBX+Zi8yD9RzxUUFFqAuw7puxPv0E1Jem+dWYoo4cprTmzuVxTosDC/cB
 6Qi5+HbXVXLOpS++SnN/vcO9vDGLw
X-Google-Smtp-Source: AGHT+IEryQJJ+eu0PUcIkyUpHHV/Fam3/7YGkXLcFmXer0719BQV6USHUIkrbnJyHt2dURNoGJ7GNQ==
X-Received: by 2002:a17:903:40c5:b0:262:663c:8d25 with SMTP id
 d9443c01a7336-269ba5596e8mr210255145ad.57.1758567207461; 
 Mon, 22 Sep 2025 11:53:27 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 56/76] target/arm: Implement GCSSS1
Date: Mon, 22 Sep 2025 11:49:04 -0700
Message-ID: <20250922184924.2754205-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/arm/tcg/translate-a64.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 6d9145109f..e7e7050880 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -53,6 +53,7 @@ enum {
     ARM_CP_GCSPUSHX              = 0x000a,
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
+    ARM_CP_GCSSS1                = 0x000d,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 3795bf7f36..eda5c498d7 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -129,6 +129,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
       .access = PL0_R, .type = ARM_CP_GCSPOPM },
+    { .name = "GCSSS1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 2,
+      .access = PL0_W, .type = ARM_CP_GCSSS1 },
     { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c601ff790b..54e7546c8f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2643,6 +2643,31 @@ static void gen_gcspopx(DisasContext *s)
     tcg_gen_addi_i64(gcspr, addr, 8);
 }
 
+static void gen_gcsss1(DisasContext *s, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 inptr = cpu_reg(s, rt);
+    TCGv_i64 cmp = tcg_temp_new_i64();
+    TCGv_i64 new = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSSS1, rt));
+
+    /* Compute the valid cap entry that the new stack must have. */
+    tcg_gen_deposit_i64(cmp, inptr, tcg_constant_i64(1), 0, 12);
+    /* Compute the in-progress cap entry for the old stack. */
+    tcg_gen_deposit_i64(new, gcspr, tcg_constant_i64(5), 0, 3);
+
+    /* Swap the valid cap the with the in-progress cap. */
+    tcg_gen_atomic_cmpxchg_i64(old, inptr, cmp, new, mmuidx, mop);
+    tcg_gen_brcond_i64(TCG_COND_NE, old, cmp, fail_label);
+
+    /* The new stack had a valid cap: change gcspr. */
+    tcg_gen_andi_i64(gcspr, inptr, ~7);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2984,6 +3009,11 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspopx(s);
         }
         return;
+    case ARM_CP_GCSSS1:
+        if (s->gcs_en) {
+            gen_gcsss1(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


