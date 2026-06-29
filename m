Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D1DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgC-0007Bs-Ge; Mon, 29 Jun 2026 08:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfi-0006vx-2g
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:07 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0007OE-Ft
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so1874564f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734454; x=1783339254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Id3/AFDlzaybCgeguqwFAd4nbZDWfuK8P4b6Zh+6gqQ=;
 b=B2bHpdDTkMf5w3idLY3M2a8APHk7voqf2I3db4nRx+9tdU+XwDyq9gcr0E5cnfG/3Z
 ChnzKVgi9uFOGXitnV2JlGAJp1f9UD92tvIuu9FSDFraTExg92saQy4+hAeYhVEj8svo
 N3WgoBIaPZXL4KEnd6L1HOEYXy8vCBsAtVhBCrLnirfXXbFdKiHNUiTf7RUaS725DK7P
 UHAlThg8PGZBchF8sKJroZfG6iicqnLI/iENokosWFiWxWSdXSsgeXEVnVvgGY1HMLis
 9Av4VODO7clpDDFzPV5DNxCTf4zLfiFyi9f1DEpeWecNX7C9SZ2Q+3rfqC5ty56HxTBb
 nQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734454; x=1783339254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Id3/AFDlzaybCgeguqwFAd4nbZDWfuK8P4b6Zh+6gqQ=;
 b=Gz31zAkAMn8jV+FlP6dmpBFprglHxn4nnyKnYSZlcn9PRg/l1VHLHXTWhaKYvN3miA
 SXbzj8CV+0lED22O1yVMfwEonouBPatfLC/spnfFTRaCdFNw+24WxSyzMQuBc+ANU26x
 bb8n/e8cdJYaX4PMyttIYpbxZJ6ir5sb9XMutdUttN13zg+w7zi3cuXGvhuf6eIycjzB
 53XYvP+IVomlZvlUAhHaSWcEbOBLPfoi14lssQbIlEtRiXXhO/5DqaxmZaeoJfcVH5xJ
 kipwXSfKnR0P/Vg8VokAyIHiSlRQAi6kgXrX7LZJYSty5etAv7642kFAHBSBPxH0oB0B
 v8Bg==
X-Gm-Message-State: AOJu0YxKdV9eVbCtxDhmPQWqV7OaKxxez8abamLGoEYpil9Gzl1g2bgW
 hDKicYZM2IgJJydi26PBwlsPTTc9AincUu3gwNpYLWmUdekaZmG2rd5NCA6VuE/m8td4NWtQ6fa
 UPEKi
X-Gm-Gg: AfdE7cm7wwmMX8USRkTjwnHf7jLl0HbKxCMFv2nbgI747nYgmjX6A6Mm9IZ43yGK35x
 DpsWqagXYNyK0yN6/r1GoXS2+ARuM4GFeoqri7Jja0GmTdUK3XhqPlRvzk1z1OjsbN1yPazIn9d
 FJwNKSph6RJGoWr5p6omedTQlvggkxy2CTkT4zL5guG5DE9q1fJaxjs1aUoLteYZnacKAqgVVgI
 AlFehFMlMoadfs9UtHdofFzYmf+bNaqawmnhdzk2tYmbv2/xN2pnFG8SZFeihFFn61vewOtLf1I
 tP8A+cou7NaV0ziVtT1igtNHSNtO7r4fowiOHJaKfrrCzSltVcEBMKe6vRLQ4L/dx3iIyFXgkNi
 TtWjGa8PmoYVjCQvDYwjtGM03dn4vGQFFd3SLgKbLBTKgQxzk6TnbUKgxsTOwcATT87/aTG08xN
 EliTCUa/XjGKiAtaAoK9pmZoVuc8H0vPONNIk49Ot4Sxp0S7rtw/NFuJ6lAlKF7KhS4UAjNMODZ
 Lp75zbKdkI00cA1S7BAxooVGzBa7nOY
X-Received: by 2002:a05:6000:4692:b0:472:76ad:b329 with SMTP id
 ffacd0b85a97d-474feeb1b3emr216491f8f.6.1782734453318; 
 Mon, 29 Jun 2026 05:00:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/54] target/arm: Implement FVDOTB, FVDOTT
Date: Mon, 29 Jun 2026 12:59:56 +0100
Message-ID: <20260629120032.1645265-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618041517.573469-10-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/sme.decode        |  7 +++++++
 target/arm/tcg/translate-sme.c   | 10 ++++++++++
 4 files changed, 42 insertions(+)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 08e04364fa..3c2d959099 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -892,3 +892,26 @@ void HELPER(sme_fmopa_sb)(void *vza, void *vzn, void *vzm, void *vpn,
         } while (row & 15);
     }
 }
+
+void HELPER(sme_fvdot_idx_sb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t elements = oprsz / sizeof(float32);
+    int idx_n = extract32(desc, SIMD_DATA_SHIFT, 2);
+    int idx_m = extract32(desc, SIMD_DATA_SHIFT + 2, 3);
+    float32 *d = vd;
+    uint8_t *n0 = vn;
+    uint8_t *n1 = vn + sizeof(ARMVectorReg);
+    uint16_t *m = vm;
+    intptr_t i = 0;
+
+    do {
+        uint16_t mm = m[H2(2 * i + idx_m)];
+        do {
+            uint16_t nn = n0[H1(4 * i + idx_n)] | (n1[H1(4 * i + idx_n)] << 8);
+            d[H4(i)] = f8dotadd_s(nn, mm, 2, d[H4(i)], &ctx);
+        } while (++i & 3);
+    } while (i < elements);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 7c090ccad6..ef1375fea7 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -40,3 +40,5 @@ DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32
 DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 7324ccddac..1de5f341ef 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -784,6 +784,13 @@ FMLALL_nx_b     11000001 0001 .... 1 .. 0.. ...10 00.. .    @azx_4x1_i4_o1
 FDOT_nx_b       11000001 0101 .... 0 .. 0.. ....1 11 ...    @azx_2x1_i2_o3
 FDOT_nx_b       11000001 0101 .... 1 .. 0.. ...00 01 ...    @azx_4x1_i2_o3
 
+%idx2_10_3      10:1 3:1
+@azx_4x2_i2_o3  ........ .... zm:4 . .. ... .... ... off:3 \
+                &azx_n n=4 rv=%mova_rv zn=%zn_ax2 idx=%idx2_10_3
+
+FVDOTB_sb       11000001 1101 .... 0 .. 01. ....0 0. ...    @azx_4x2_i2_o3
+FVDOTT_sb       11000001 1101 .... 0 .. 01. ....0 1. ...    @azx_4x2_i2_o3
+
 ### SME2 Add / Sub array accumulators
 
 ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a9adaa02bd..a79b0a9b80 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1233,6 +1233,16 @@ static bool do_vdot(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4_ptr *fn)
 TRANS_FEAT(FVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
 TRANS_FEAT(BFVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_bfvdot_idx)
 
+static bool do_fvdot_sb(DisasContext *s, arg_azx_n *a, bool top)
+{
+    return do_azz_acc_fp8(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                          (2 * a->idx + top) << 2, 0, false,
+                          gen_helper_sme_fvdot_idx_sb);
+}
+
+TRANS_FEAT(FVDOTB_sb, aa64_sme_f8f32, do_fvdot_sb, a, false)
+TRANS_FEAT(FVDOTT_sb, aa64_sme_f8f32, do_fvdot_sb, a, true)
+
 static bool do_fmla(DisasContext *s, arg_azz_n *a, bool multi,
                     ARMFPStatusFlavour fpst, gen_helper_gvec_3_ptr *fn)
 {
-- 
2.43.0


