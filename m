Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA9CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeJ-0003yh-Fc; Thu, 14 Aug 2025 09:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdT-0002zv-1r
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdK-0005HL-0Z
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e2e614b83so720210b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176677; x=1755781477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i64S7qZsCHHdPDpq8ksGAk8kRM2Uh0PJ6yALnXosnoY=;
 b=ux8zKGCdC7botG/+LPEPlBMU1lOaW4bMGOmlB8QmT5E2LOEc+1S3tiK9oixQsZQBWo
 9/hK1WLCl9gVk4jQ1xv2cRRcjbeMWqKipjbhyeDEcdY6axAYF91xME+Y8/kQp2JbZBc2
 gcaVfrmr63PUojYI83Lnt4or3Wx0JdvVvpvfZnsIj8Xlo6u2nT5BGferHSV64w+G3DsE
 OzUCnAyxT3RQEfb1GJD1VEXzUxruoo0WTjBXdcS8V4BzkaZE2IwhE3TqkKSz46xi+XCR
 76Bne//mkRxNDuzotWcsugojM0diT/qObWeo+/yEIgwLpUsJVLHKVbdID5yOp63COVDQ
 GJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176677; x=1755781477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i64S7qZsCHHdPDpq8ksGAk8kRM2Uh0PJ6yALnXosnoY=;
 b=E+GUIXh4oIEqsO1laKk6BCjOLzozvUlK7XSlyW1on6GFh19j0kVem/j/k/yXnVuo+7
 LZVA59IAf5zYhOn3Mf8rr8YHWeqdGZOKgdG9mKEg0HaU3acmceoBg3gEMIKXs009ePvD
 75Ug365OaobhwdW0LsgO2vVpBaG+9p0pSG9c1OUBPEieXs0EVzH99LQVIw9cxjY7yAr7
 nuDmNifSkThb0F+4m8yjwbqKiH/RlA1BcO1C/+TgwHDdUUD4z7cuRUlPj2Pg2vbtL149
 wLGPr1nmqUCOrc0oUolJhln7crcnJogEsLw5PF087lDv0do72KSYLhd3eHE6ottlP7Gv
 bnbw==
X-Gm-Message-State: AOJu0Yz9+oaycd4LiAsgdXEBHxBhXihKEklqftLKLjZlKM6/peQzORl6
 NbIRKjne+r4Bn6ulr4MHybGx+yHZQ7lkEQN+G2mgxjRVnH/DcF7vhqkzhvZdpA0XWpISI4PH6uB
 moahMy0k=
X-Gm-Gg: ASbGncuLvRdSh+W4Hb4BSYBK5of92QGc13AU3S+g2YSuZsjQf9PnlHwOWcnxkQ7dnTh
 JasAWtq5ILWWiUsau6/I5qVJrUWP8REInQgkVmqVE/OHZevHU2Wan7Oon4geLq4oNlW4QFwAQ1Q
 gVsWSDBQUwBhjKNyHKu78lNwMxdXMYLUrQZ2j4+OXaNTQyZCjFvOwka933L3i9ZDjnehARKHTet
 Y4Ne32dGpkwkNK+XeCu7KvuZcQofpNiXZEvOOaA+3l9qlnUpUBCXBhoq8d17lui/QNcUredhaCk
 DP7DTJmT53oTAsuZJWQZuO5ds4MUDgSuMgdmOl2io4g528cj6BsbxjWFonlfT/57qQoOXVBvgJZ
 IatToNR04lcl0f9vDj6VU2kAESVhLZ7ZCHP0y+QS99HL5ESE=
X-Google-Smtp-Source: AGHT+IEplvwIcDhEOnC2JwWRLbhEbcTy1X4Jl+h1EEjLQEiv0+y/akf33iQks9+DV0FTlr0krhXgew==
X-Received: by 2002:a05:6a00:1746:b0:76b:fe65:71d2 with SMTP id
 d2e1a72fcca58-76e2f90907emr4062466b3a.10.1755176677389; 
 Thu, 14 Aug 2025 06:04:37 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 65/85] target/arm: Implement GCSSS2
Date: Thu, 14 Aug 2025 22:57:32 +1000
Message-ID: <20250814125752.164107-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index ee8b870e17..1ee0bfd132 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -53,6 +53,7 @@ enum {
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
     ARM_CP_GCSSS1                = 0x000d,
+    ARM_CP_GCSSS2                = 0x000e,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 51fc8298af..b70bf47fc6 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -128,6 +128,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
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
index d97d9bfcb7..70dec7d505 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2660,6 +2660,35 @@ static void gen_gcsss1(DisasContext *s, int rt)
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
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2976,6 +3005,11 @@ static void handle_sys(DisasContext *s, bool isread,
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


