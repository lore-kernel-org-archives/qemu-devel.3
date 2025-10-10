Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81B7CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqV-0007Q5-S3; Fri, 10 Oct 2025 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqP-0007Ja-Lc
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpR-000403-VB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so1246522f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101590; x=1760706390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v6b0g3Y7qkwKaQxbdCJVfhB74L8M3sIgfs6PKpxGSO4=;
 b=XotlK5Wfloi7ueHFEQ9/ZGs63qDJ10c/1ZwSyrTdIVzQMb4SvX5kYcF/qJZTI5yMMo
 QbY9Gf86sKe08Q3+J4SOcmTqO5QKW/TAJBg81k5/02y7y1nZ9y6SfYnzsIY/evAaPPEM
 ylh1F0hJReLbcKCoUzOXz4vvWQqV3AZlbnO5p1mD1N8m+T0hJGszOgZYcTDrePWHU7OS
 ChVWuvKVPMekByZHVsI563IWOwc8S9HvtXlnM6pUp3bsMSvsrlMN3cJxIgf/qn9lq+61
 s9PsbVqj2oIDhXQ9SkXefzxIckAD4NblGulrgrvj4Ifqqrt6CA5510ykJKXIhL7JDcq7
 5V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101590; x=1760706390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6b0g3Y7qkwKaQxbdCJVfhB74L8M3sIgfs6PKpxGSO4=;
 b=mdXrZ6l5YFWFo0QMOoFwRr2KPKX4IH11+uXCL/kU5355Y8NcWJpciuhvcFamIJKVmO
 PnrNjb54ahD6UmjxCasSJUnhNKeIkgcznxDR6UC+5YALNAq+4nUGbTGbj/ldWeWLmwHl
 fZA+2iEAAQgHaCwDSL8oUIkN0QUmIonr5vTUJ6k+Uvn8loeGz+FyekLaDYWl1nw4mO0y
 1N6rHRHwyqE0GXYmW+ZOElgFNnjUDEeKsYfnnopxvsuKHiVoBqQEKSM6GOkZ7pJhQ31t
 fsA5ygiqLDXWMF+nTPkVFKyViddjN7/z0OhXfQqks47UQVNhiaXQ8WRlSmGhgQq9bY2v
 3+6g==
X-Gm-Message-State: AOJu0YzgPtbXYYjBdQp8tGwq2Zuq28H/GSdqiGrjAinqZrP5d4Brd437
 f11PP3MjimeUwWNKtMCKV8RHcUt0m0TYYrBTh3jpsuShW8NC201eZtumXXyaq+6tB1CTFB6Xcy/
 0Ftwy
X-Gm-Gg: ASbGnctIDxM/TbqGQgNCZYMP5O49rizGFumS0t5be4FKbqec8eiZJ9CMgaA85OfUAY7
 lpVAn1mEoACXUuNQpaYMe0ybeO73W9QEt6Q2zNOFNCyjT/qqfOayZzQz0V4rLmtPKGrzOJ+cIEc
 /y1aLzm5Zy9uqkwwh7GSw/njwgmC8VCjvRdGwSQ2kdwchnzCUignM539ir47MExSoLy+LRZtKVR
 l9GlxaWa9JsUVDWpk20yQv0i/gilPiZQv5ddxr6V5Ozi16+p/ha2dT5gAvEYfQnJbaKozjFg8E7
 MdWhrPVevQ2/WO6KZEYGqQqQaAm7GQTUZojm6nMnl5A++Ip/OZXr0ZA0GzWE/Rs65oZTLZw6l5Q
 1LhqXfgA5vJhmM8WS4Hn5jR3u1tEzIZAR2iK7GlpvIX4GN+rn+g2cH1Nx68/B3g==
X-Google-Smtp-Source: AGHT+IE/GKgiO+n+8qubgs6uZCuxRK3QYdZhklvololdWX2neV4WX85U9pvnZ/ihPwoGw0H0yYdPKA==
X-Received: by 2002:a05:6000:4203:b0:3e4:957d:d00 with SMTP id
 ffacd0b85a97d-4266e8e68b0mr7877656f8f.58.1760101590467; 
 Fri, 10 Oct 2025 06:06:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/76] target/arm: Implement GCSSS2
Date: Fri, 10 Oct 2025 14:05:05 +0100
Message-ID: <20251010130527.3921602-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-55-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index e7e7050880c..732c07506d9 100644
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
index eda5c498d73..1ed52a211a6 100644
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
index 82ddf4e1dc5..d58257be40e 100644
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


