Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ACDC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85c-0005IV-JJ; Sat, 21 Jun 2025 19:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85W-0004bb-Vl
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:35 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85T-0006aQ-Pb
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:33 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so3130570b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550250; x=1751155050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H5dlmRO0h/Lxo1bEJgGrBamVoHdhdsUfTqFbFAugTxY=;
 b=hIfFLd6Vjh2D1MS/Mcm5OhsVSZMVr2WG6nqNOwPGRo/nWblf3q3wT8JaBp46fm73AW
 MsD5zptBmyeHReiiZyUDuek9k7CzPjTUYIHR9dqH0wV0rYihOGvy8+vg8wTD3lxee5Fn
 OIKnl37KZyUwMoPOX3PSrbVCU/aVYOmoIcJcyb7ovMiKlXpuSljlCZlHqhVet3uBWcZ8
 PGhuM0hZS/yhLH3A81iSITaMFW7P9dadSgy8DXtgqLDn94SThIXDJZavtohGDevMD/qk
 e8u97FyL6e0i3aAg/MfhyIOC2a0c/ZrWcv5MYPUlkliovT3gkU0etElpP8GOk1uMUZ+Q
 MrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550250; x=1751155050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5dlmRO0h/Lxo1bEJgGrBamVoHdhdsUfTqFbFAugTxY=;
 b=nIbb+BI8zXkc2JxK283LlZa1QNq4VZMHFR9oBT3+i1cWt82koyZeCwV58kBJyrWZ6X
 mkAyrYx9ppGvJTZkFfEDLFPtfDFF16o+hp/HFGwGIORf1ytsHISxZQIh8w3mqC9ul/Fj
 sk8G+uleTuzhI5ENJSwHbxYB4bhCk6U77Cs4ULiKAZXi5zd76juV1WPnJZfh7LX8jbT+
 zUWaTQ31U7cRyGS22QNr9UlztmwztjctcQiHox8fgq5ZN8vcf78ThJApP6sP7MMg5vz5
 X/uJRd0hVDRemPgoihArIssdlV8gsrtV1SIbryN57lgxAluFfWtcI8CGmfxF8MF8/rum
 Dbqg==
X-Gm-Message-State: AOJu0YwlfsU8g6JwZkC/ljkBTlwYrOGuDJBKgtZh0CQmmjVlsqjUFLuC
 raAiYdYfJ2A3two9ERT86YWgWKrnEKaLVq4jc3LWrIdfVbTo2P9vacytbOUdF6KzbZbdIuyWPLQ
 9OxH9ce0=
X-Gm-Gg: ASbGnctqVEIo/7N+3Ofbqnf2vXEdmgRq+ydGsYbkg3qo4ZIAL2/z6+AJqtLcef49PK0
 bafIhVtpQ+pjdL+XmBZsOZgVlyEvVfyEbdLzDAGcUU9PmFRyBgeirBjIP2QRpUYtQY8BDom2Mhy
 OiCTvXB7hILJNT1fWjkjBdg3qlpbLOJhjRjJFDXZxkaTXFQdpQo1rRQSXlZZmHj0Sny7rRYaPEp
 2pB/ez7q+Lz64VyJ8PNwKhp0P1lNKIcGahc0bzW2Y7gfumwnvB/uqd3wRrcmGU019wEg1ub9fNU
 Nrj8tghLAVbJ8SizWmK1jCD27TOC1uWLBbOrHcBjQ2nZfwvthHgPMn6yHV0N7dvWX/I785/CWlG
 KdCR+g/jCuPPZbUte90uR
X-Google-Smtp-Source: AGHT+IHCZbqlFAhN6OkbwXYXQkt3ujemRUlT7AiHN/1H4DKIHA+04h4AzBIZ1AOvQngszPtGqTQgEA==
X-Received: by 2002:aa7:88c3:0:b0:748:de24:1ad5 with SMTP id
 d2e1a72fcca58-7490d630822mr10277795b3a.11.1750550250432; 
 Sat, 21 Jun 2025 16:57:30 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 081/101] target/arm: Implement SVE2p1 PEXT
Date: Sat, 21 Jun 2025 16:50:17 -0700
Message-ID: <20250621235037.74091-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  2 +
 target/arm/tcg/sve_helper.c    | 82 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 36 +++++++++++++++
 target/arm/tcg/sve.decode      |  6 +++
 4 files changed, 126 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 5f5ecc2e0d..ec82d0a4e7 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2953,3 +2953,5 @@ DEF_HELPER_FLAGS_4(sve2p1_uminqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(pext, TCG_CALL_NO_RWG, void, ptr, i32, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 382c471aaa..eaf9363c0a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7839,3 +7839,85 @@ DO_FCVTLT(sve2_fcvtlt_sd, uint64_t, uint32_t, H1_8, H1_4, float32_to_float64)
 
 #undef DO_FCVTLT
 #undef DO_FCVTNT
+
+void HELPER(pext)(void *vd, uint32_t png, uint32_t desc)
+{
+    int pl = FIELD_EX32(desc, PREDDESC, OPRSZ);
+    int vl = pl * 8;
+    unsigned v_esz = FIELD_EX32(desc, PREDDESC, ESZ);
+    int part = FIELD_EX32(desc, PREDDESC, DATA);
+    unsigned p_esz;
+    uint64_t p_mask;
+    int p_count;
+    bool p_invert;
+
+    /* C.f. Arm pseudocode CounterToPredicate. */
+    if ((png & 0xf) == 0) {
+        /* Canonical false predicate. */
+        goto zeros;
+    }
+    p_esz = ctz32(png);
+
+    /*
+     * maxbit = log2(pl * 4)
+     *        = log2(vl / 8 * 4)
+     *        = log2(vl / 2)
+     *        = log2(vl) - 1
+     * maxbit_mask = ones<maxbit:0>
+     *             = (1 << (maxbit + 1)) - 1
+     *             = (1 << (log2(vl) - 1 + 1)) - 1
+     *             = (1 << log2(vl)) - 1
+     *             = pow2ceil(vl) - 1
+     * Note that we keep count in bytes, not elements.
+     */
+    p_count = (png & (pow2ceil(vl) - 1)) >> 1;
+    p_invert = (png >> 15) & 1;
+
+    /*
+     * If the esz encoded into the predicate is not larger than the
+     * vector operation esz, then the expanded predicate bit will
+     * be true for all vector elements.  If the predicate esz is
+     * larger than the vector esz, then only even multiples can be
+     * true, and the rest will be false.  This can be easily represented
+     * by taking the maximum esz for the pred_esz_mask.
+     */
+    p_mask = pred_esz_masks[MAX(v_esz, p_esz)];
+
+    if (p_count == 0) {
+        if (p_invert) {
+            /* Canonical true predicate: invert count zero. */
+            goto ones;
+        }
+        /* Non-canonical false predicate. */
+        goto zeros;
+    }
+
+    /* Adjust for the portion of the 4*VL counter to be extracted. */
+    p_count -= vl * part;
+
+    if (p_invert) {
+        if (p_count >= 0) {
+            goto ones;
+        }
+        if (p_count + vl <= 0) {
+            goto zeros;
+        }
+        do_whileg(vd, p_mask, p_count + vl, vl);
+    } else {
+        if (p_count <= 0) {
+            goto zeros;
+        }
+        if (p_count >= vl) {
+            goto ones;
+        }
+        do_whilel(vd, p_mask, p_count, vl);
+    }
+    return;
+
+ ones:
+    do_whilel(vd, p_mask, vl, vl);
+    return;
+ zeros:
+    memset(vd, 0, ROUND_UP(pl, 8));
+    return;
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ade4914aba..98799298ba 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3319,6 +3319,42 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     return true;
 }
 
+static bool do_pext(DisasContext *s, arg_pext *a, int n)
+{
+    TCGv_i32 t_png;
+    TCGv_ptr t_pd;
+    int pl;
+
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    t_png = tcg_temp_new_i32();
+    tcg_gen_ld16u_i32(t_png, tcg_env,
+                      pred_full_reg_offset(s, a->rn) ^
+                      (HOST_BIG_ENDIAN ? 6 : 0));
+
+    t_pd = tcg_temp_new_ptr();
+    pl = pred_full_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int rd = (a->rd + i) % 16;
+        int part = a->imm * n + i;
+        unsigned desc = 0;
+
+        desc = FIELD_DP32(desc, PREDDESC, OPRSZ, pl);
+        desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+        desc = FIELD_DP32(desc, PREDDESC, DATA, part);
+
+        tcg_gen_addi_ptr(t_pd, tcg_env, pred_full_reg_offset(s, rd));
+        gen_helper_pext(t_pd, t_png, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(PEXT_1, aa64_sme2_or_sve2p1, do_pext, a, 1)
+TRANS_FEAT(PEXT_2, aa64_sme2_or_sve2p1, do_pext, a, 2)
+
 /*
  *** SVE Integer Wide Immediate - Unpredicated Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f16764a947..39d7a29c06 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -60,6 +60,7 @@
 %rn_ax2         6:4 !function=times_2
 
 %pnd            0:3 !function=plus_8
+%pnn            5:3 !function=plus_8
 
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
@@ -823,6 +824,11 @@ WHILE_lt_cnt4   00100101 .. 1 ..... 0110 . 1 ..... 1 . ...  @while_cnt
 WHILE_gt_cnt2   00100101 .. 1 ..... 0100 . 0 ..... 1 . ...  @while_cnt
 WHILE_gt_cnt4   00100101 .. 1 ..... 0110 . 0 ..... 1 . ...  @while_cnt
 
+# SVE2.1 extract mask predicate from predicate-as-counter
+&pext           rd rn esz imm
+PEXT_1          00100101 esz:2 1 00000 0111 00 imm:2 ... 1 rd:4  &pext rn=%pnn
+PEXT_2          00100101 esz:2 1 00000 0111 010 imm:1 ... 1 rd:4 &pext rn=%pnn
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
-- 
2.43.0


