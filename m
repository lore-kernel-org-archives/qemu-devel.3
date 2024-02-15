Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE2BC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeJ-0007y3-8y; Thu, 15 Feb 2024 12:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeE-0007vF-Be
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:47 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeB-0003uF-Sq
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33d01faf711so672934f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018541; x=1708623341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FZGLvP2QBbpRory229x05hfDcg6lUvjCEqGRpf1etZI=;
 b=NkqOHMxcUaIEEc7xSxQWD8WbQaI2ucsnkmwDOFefkSWx2Sm8nKX4xnlFAED7g1YPiF
 UcgHEvEd4xkIUZg+RNhUwRsW4SVlfg9Nyj844PtR5AOPrayMCLAiGziv1X2rBuqNOj3k
 lRxgH20SSb8/HEFlEKmUTSADGO+hS/UfyiN4sf96t+34fatFx9OG8L3+IZqvXOVA3qVJ
 mOaYFN3dJpWFzN8HzLsPlV4xj62iqzVjcQQQxnpmsLrhLEGZofnm1e7KPV3CKMVaoCr3
 FWX315O1C04TU6zxHthvx79Ouv31sD1s2NBfa4kHuVjmx/aVIxyQ61MAkEkrWdAdyUxE
 H39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018541; x=1708623341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZGLvP2QBbpRory229x05hfDcg6lUvjCEqGRpf1etZI=;
 b=G1ZloWcj6vmSnbDCIOgtzJA0PX12AXDha5GCpm3fFf4WZpcwJrCdu4cHwCM95Hime2
 l36UiMfbOUSF41Aq3DEsxJxAwx9F2JhukPwF7PkUJlc7mw8gJFXECFwNdYF/QxUbq1ea
 +sO3y9gZ/Md4AUgn0mVMrNBm4Y1nRuaX1N2enxYYQT7SahvoU1mKwvo91EYecpimaj+R
 3CN4ejTOTt98DFc8oEo08IDw2MY2Nl1yKBAmd4uMbhJ+ycYNgNONAAlMzhsEo2bHJWpt
 JxvvdT30tiVv8AF6J2iEroQBvN/lupcGj2UIt6jZ88KavOtwJmNDbAMgO3KRRSGA6wKI
 XHsg==
X-Gm-Message-State: AOJu0Yz3DcWGlnjgzyc9hrI9RHsXkoMRsZtWdKShH1vCRuWK/tjI5ho4
 h3GsPiOp7Q8d9r6NEglkEkXjrWZ8J4o0BHAEjV4VgZzVQly7Ig7HBP9dKINmOq96RUCCHkNumlF
 N
X-Google-Smtp-Source: AGHT+IGc8T78wp5vwzsBwrYYWapQ6hTO4jF8zWwg45jcIuAustKpf11/RE1wzZkhleAq+qP0rEJiLw==
X-Received: by 2002:a05:6000:1b01:b0:33b:879d:d1c7 with SMTP id
 f1-20020a0560001b0100b0033b879dd1c7mr1828120wrz.69.1708018541516; 
 Thu, 15 Feb 2024 09:35:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/35] target/arm: Adjust and validate mtedesc sizem1
Date: Thu, 15 Feb 2024 17:35:07 +0000
Message-Id: <20240215173538.2430599-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When we added SVE_MTEDESC_SHIFT, we effectively limited the
maximum size of MTEDESC.  Adjust SIZEM1 to consume the remaining
bits (32 - 10 - 5 - 12 == 5).  Assert that the data to be stored
fits within the field (expecting 8 * 4 - 1 == 31, exact fit).

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h         | 2 +-
 target/arm/tcg/translate-sve.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc337fe40e5..50bff445494 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1278,7 +1278,7 @@ FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
+FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - SVE_MTEDESC_SHIFT - 12)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7108938251e..a88e523cbab 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4443,17 +4443,18 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 {
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
+    uint32_t sizem1;
     int desc = 0;
 
     assert(mte_n >= 1 && mte_n <= 4);
+    sizem1 = (mte_n << dtype_msz(dtype)) - 1;
+    assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
     if (s->mte_active[0]) {
-        int msz = dtype_msz(dtype);
-
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (mte_n << msz) - 1);
+        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
         desc <<= SVE_MTEDESC_SHIFT;
     } else {
         addr = clean_data_tbi(s, addr);
-- 
2.34.1


