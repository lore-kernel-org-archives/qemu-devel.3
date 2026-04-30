Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27421FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAI-00078J-Dx; Wed, 29 Apr 2026 20:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFA8-0006sh-MN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFA6-0006Q5-KD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso197148b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508509; x=1778113309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+v0OenRaeZRU5sqopMR+9IMg3L8wsZpGoK3Peg+SMo=;
 b=t0lkkA+X4qES9DwlwcrvEg4xg1J/OrZv51cCjbaohM5bclyR+ez7uyi8aifOfaiDpi
 tPhtYEqjk/K3a9bUH+xzrg6rNC+XhJI/lfe5t8j4QVw1rihBzfXTMj6/n/z3kEg2/izY
 Vi5Jt0EICHBQRDFoSdtPLdaAmE9IDCTt9uzBBz7r+PKtGFmBEl21+u21r1iR9oZsibVV
 GR256pVZYsdlWuS/Bmn2DeKgpvRzXD+oC1LzHNNA7BpJNjjePwQdNJ1OSw/5YKZREdih
 owVg72RpXgBapL+2DI/KEm3m+j49A/aByCeinWTRTtUOTkdN3i/W7e7OjQq1hAMCuCuh
 tzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508509; x=1778113309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+v0OenRaeZRU5sqopMR+9IMg3L8wsZpGoK3Peg+SMo=;
 b=sgerSyHC0fAuPUFUbzKtD89jgh/iScrlJWq23j5pTh2agV3+oiCd9Xj0YhMtpC4kN6
 7PtDf60hV68eRTqM62xxNxg0RevPydwLRulAmsPbFs6NeB3z4l2SksogNbKIY7aSi1V2
 Y42ubig5bs27HQ+Ffzad2akBSLvXjT2S4e6PZdkpzXNPZzXBpXcUXdH57PKRrP+0t6Mp
 ZTmFOocgsjeU2ftfBGsUDUVDElH2FOuJjWYgHyskgQ1XxrHt9Y8rlNdHozJDLypKp0pE
 QIfTX2982pfH2a7fHHenBwkssWXv2qKAmwGrhaeKc40Io1vP/1XtvDf5o1Rlzf6KLz7j
 Vc5A==
X-Gm-Message-State: AOJu0Yz81NfJlU0TR4H7rcmpTgVFOhloqR/iuOU0fMOeQ8JAVF41TGdJ
 VBiVWtxV72BHJivWYRAD/aFr63baPw20UzQhYygywIA4eyA/NALO4iJ+rAXFtqc6uWT6sdfiAEV
 l25Wu910=
X-Gm-Gg: AeBDiettPOaoLK9XFKtw9pLQvxO9Lm3+ubsq48zpXbdlVOSXFOBQnYB32OaSB/EGtm/
 291SYjpH+jWuymQC6GeK9Ewd7lfoTbzVjXlCWKCzY1B73BCuvRkN1pI0qcCxjbYzkqnkRVswkKX
 TqoenhG9rPw1JasOsFuEqqa9u7y+rVYW/ZDTB/9gfbEzgdJjcsazIasb+A4Fy5ae4TBRP8wDheS
 MHXb87zpM9VWCyMXGF+HOfvhGnYblaMZvcTxcXrkXDdBQ6u7NEHbauPuN2N0AUxiKwnRuRXRRNA
 k1R37JIQqMtyoVvJOdL6WJUsz2gIeq7QRLvBu2hl/M1rouCn2i07gvNuot8ShxiCDCHYzzYZZAm
 hne5cBCkGmv5ephMGKiW1S7QDIbK2I/E54SD4sd4iQyuwJlq8aAmgfAk20pTagjaJhm3PH6DrrR
 VUe6Z4z/4EIHvw852170jIMPBw76ff8L9aCiHI39Lx
X-Received: by 2002:a05:6a00:90a7:b0:82d:29f:d003 with SMTP id
 d2e1a72fcca58-834fdb44ed0mr903822b3a.12.1777508509164; 
 Wed, 29 Apr 2026 17:21:49 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 26/47] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
Date: Thu, 30 Apr 2026 10:20:25 +1000
Message-ID: <20260430002046.59739-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  9 +++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 43 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 718463422b..3021dafd44 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -9,3 +9,4 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 2739cdb343..2d5fd688cc 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -221,6 +221,34 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
 }
 
+void HELPER(sve2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = fcvt_fp8e5m2_to_f16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = fcvt_fp8e4m3_to_f16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d, nelem, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9bab5feb93..5200f3d034 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4081,6 +4081,15 @@ static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
+TRANS_FEAT(F1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, false, false)
+TRANS_FEAT(F2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, true, false)
+TRANS_FEAT(F1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, false, true)
+TRANS_FEAT(F2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_fcvt_hb, true, true)
+
 TRANS_FEAT(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
            gen_helper_sve2_bfcvt, false, false)
 TRANS_FEAT(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e7984fa8e0..ca110f4bc1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1091,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+F1CVT           01100101 00 001 000 001100 ..... .....          @rd_rn_e0
+F2CVT           01100101 00 001 000 001101 ..... .....          @rd_rn_e0
+F1CVTLT         01100101 00 001 001 001100 ..... .....          @rd_rn_e0
+F2CVTLT         01100101 00 001 001 001101 ..... .....          @rd_rn_e0
+
 BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
 BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
-- 
2.43.0


