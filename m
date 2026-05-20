Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085D1CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYb-000253-EV; Wed, 20 May 2026 15:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXs-0001Gw-4S
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXq-0002H7-Gj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d75312379so4352327f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305128; x=1779909928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lonuu/jFbxnJeN8rOKckLrLcyfPzV1Uide91cS0SLpU=;
 b=ziMBPP8P5k2IYrN8VP+cqrHB3hWBhIHfceNhuH3StDUu0FrhEYXGYzzXmhX3b1QKKw
 Af/61ygQtrx74812/tgoVecuQiZauFX4ood2CRsmOm2073DEh0W+L49onVptLSnp6VFY
 15HQwlcUmnuGrUNY+IG42i5ybflHZSOf1DeF4FS58p51LQ0LDPbBFDQ4C0cA+GXkFG+0
 gGGnz4I6vYRDQgh+O/zwt1Jl7JWHnh3PTqSoa4iT4dQUAbFjSalmDBBj3uKMCDRngwIK
 D0fQtRBTSWJO+9enrRUOh2hL+rAOna+J5ttc/VGacsnjfCQ+hsNiddqyPKxkXCEWo4LT
 R9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305128; x=1779909928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lonuu/jFbxnJeN8rOKckLrLcyfPzV1Uide91cS0SLpU=;
 b=GMzMqed+LOfXvqrDW2HaVNyyyf8hnuWokBbFiAiZoXoylFSpM+8Ed9kuFdIWjCHF+B
 tx+curn3JynXce/T++Vu53ryrs4MV/izTOLuMSGK5zLuR76QAdYP76PDUgaY5BQHMIrT
 akJTh3JlhoeOHKpwXAhcvxc4+Q5UTuf6Oj+QYby7EJLIQ2B5DD7ari3nHJgJqRW0z0+I
 UlssAutwzwG2lknYqihqO9ROz4j1eYvD6NlLLIwk7QH36z2UN/KzpvGYXWAGvigKxBtT
 HkFdc5WjggpJyU7nZcNmv9g7ecy+5w1BO9sadxFX6SdD1pmZONN34K56uJt4cAwhc3U4
 Cv2Q==
X-Gm-Message-State: AOJu0Yw5uNQ7FLM7JXXFyvvZzranFQHj+6X0GWaGKYG9Rip8hW1IL6kf
 OUji2PhZfLead5bla6UiPf7aIY1Yc9TPU/riruWSIu99tA4KlzybcE6wkUaW0sFKHRK5kJmPVA/
 zqgSnJoA=
X-Gm-Gg: Acq92OFrH2UylOCmwkr5HIJRdR29nEgEXJeNb/kFeizSsOIMRifNtGKJakbDjMrbgKK
 Lxtw/UvKAED7deGOm8eNmGCKSsgprm70E0xNPGVXbBoZGXQjQCilqXiMG802a6sRR9l14s2UVKJ
 KFCrgyw9JK0DNpjw6HKOv1PB7VKAZEJRuDmPdu9cncIqPRGQZNSkbC0YAtekirtChk1DGssiPdD
 +KpeU3iHuzOBsWVRHkEqtZRP9EhRa4Z3q0yYdIrm/DO5aJnwlWc5BY9CGRFEHisysJdUdcRF4o1
 CgpTUNcFr/+H7f4JxMSK7S2e1+q03JQ/Zi6lJGXtTKC+HCQJUOgx7hj7bqV7i1Gtehh4HCzm+V1
 j8LXk8XuN/w99qSjE/8fpXq0c+yMIsspGYP+45X+BtcMnYQzqhSeIIACmJcqu83VzDOPk9b0Piw
 54/kOca5Ze5XNmt1XPq9auZDX242PWoaMN108RxBKHoP+A2f/l1YAGODh6OaLDkYnFJ+8oB1t19
 gh7z6wBUVY=
X-Received: by 2002:a5d:5f55:0:b0:452:bc74:b129 with SMTP id
 ffacd0b85a97d-45ea0d6c14emr1289402f8f.16.1779305128301; 
 Wed, 20 May 2026 12:25:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm56785631f8f.22.2026.05.20.12.25.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/33] target/mips: drop Octeon zero-register fast paths
Date: Wed, 20 May 2026 21:23:20 +0200
Message-ID: <20260520192338.40036-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon population count instruction paths.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-8-philmd@linaro.org>
---
 target/mips/tcg/octeon_translate.c            | 15 ---------------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4dd76268350..b7531653e58 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index b7610db812e..f406726fc11 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -39,10 +39,26 @@ static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_dpop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502d\n\t" /* dpop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
     assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
 
     return 0;
 }
-- 
2.53.0


