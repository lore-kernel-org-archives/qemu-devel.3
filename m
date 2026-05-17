Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65281CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPk-0008Bg-N1; Sat, 16 May 2026 20:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOt-0007Fl-0s
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOo-00055G-Iq
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so834524b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977828; x=1779582628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLHwlECbQMkESLKjuBWpmuIGU/R9SWCYKPtvsblUdZ0=;
 b=T1WPV/GmVcT2W/U10xswNfRG0eAJA6s6IOVnbsH4rdv2f1qN5HhUTJOxGreC288T3Y
 BHdnXmrRcm/GIiDdDl3+RI2MuwccA9MMiBtruk9/zH+wHsnwDH8rD6BVHYxH1kJg3+ri
 fesR/lmqQdncBXkgABpLMGQENaP3Zjuf+ZeYShxqm6wMcp7xUdF34O32xhMIOORF55im
 HAPdBaMOLPfIcpifAOzQBC6zjZRt+loAVTAWJE6Ix5hkyEDUzM8M0A7KHqnxZCk8hXLt
 lVA5AQvwRZfiirMwqaDhS/0G1BeCI3ItSfIxrglM/ZlrO3VHvuBTBHAxEAgcy/dMK+iB
 pThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977828; x=1779582628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLHwlECbQMkESLKjuBWpmuIGU/R9SWCYKPtvsblUdZ0=;
 b=iSdPaT/hj4x7avt9pMsq7OWcqcXSQt0nOppuW61Yk4bvMGEQcrfhZauJNDZ+a4MJTe
 GzdK9zGNlggWYs59YocDV5fUQpYNKjrjK/GwQV5yUclAZ0pRe+weocf0Pn57X9+fGAUy
 83mzZPjVXMayH2Fyz5+0yD+XUb7dcjkXOBDSEw3VsRrJib8C5GLiWcgJj5yurnAtCi0D
 Bfoud+SRDRllP21yp7Xv7g9rIG+VL0mHukgIJEN/8HK84hJGzOuP2af1f45EwO4cjEYV
 Oov6F/hf8QIQCGrSkXzbsKp8pg5Ze9ZF2hcmdKBWpAEZYJnAG5y/Kx4NoDOLYeVGwrj9
 WPlA==
X-Gm-Message-State: AOJu0Yx4aOp5//34rJGk/E9/4vCFIT8lSBMkyVSMxpZuWrDIErkIwpAB
 7kecZJN7LmOra5asbFzJgJ+ze1beMuIZ6WLA0zW0vBL0nwN8i7NOjUGlNFFR3Z9kvdGiBNSJ6gM
 w3+t3
X-Gm-Gg: Acq92OHlvJIQKM4HbcofuBVlxJHxc2rPgetvGDDJpkqU3cWZGDmz7Ax+Edzr7i1ROTH
 pvKzEUzOIoF0denZFf26vTPodNeYo+q+1ZBqj10n8vwT2r6ogYaFcSUu58LKKaRjSgvz1vyTvel
 4ENeRnUnXQhgBeiuQO3b/6BkFxUg9oRb1IyynxHB8whxZkqdf3ReHVe5N/WKkqtciv5Rp5HegCi
 j8KbYk8hUngizNMWN/5J3WJs0sWLVtA+rq+2xKh7OF3YXVkXNZvojkxDgkLOg20QU3xmNdSaVfq
 99ayfmjZczNV72BJNCNMV1sEdbc0xWon91KFGAX9H2ogDVQjfDj+grzb1UNO/zTbxPK5p7C9KRd
 2AkF4bF8ni4nlu1b1/ONt5Df537F1Id8VU4RdaEsB4vKCKBkGuSLOWYeh0ke+V2Bz/nxEzj0EUK
 PkA0hXjKNP6Cg/LGFNtLJtptgc+TKJ
X-Received: by 2002:a05:6a00:2349:b0:835:4776:7d7b with SMTP id
 d2e1a72fcca58-83f33c9e9damr9818892b3a.42.1778977827467; 
 Sat, 16 May 2026 17:30:27 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 28/63] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
Date: Sat, 16 May 2026 17:29:27 -0700
Message-ID: <20260517003002.321430-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
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
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c   |  9 +++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 718463422b..3021dafd44 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -9,3 +9,4 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 66411bf275..b5ce5554b1 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -176,6 +176,22 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
 }
 
+void HELPER(sve2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_f16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
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


