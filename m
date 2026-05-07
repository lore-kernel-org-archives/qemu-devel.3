Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624F9CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Ok-0000jR-Rc; Thu, 07 May 2026 19:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Oh-0000hK-W5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:52 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Og-0001Cu-0O
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:51 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso833372a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197489; x=1778802289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvdBCPwdPebINf2u9OS/OLdVPs9YETKPSmVjqHkDdBE=;
 b=TbGH1QRCiy5xFW/hnS/vm/l1spuIgRokXLP5QsGT6Z2XBVjsLidJgoxfvMSGSlLCMh
 NxXgubNnB1Kb3bcTwq+SJmAV5F2SFEaYqN3nfm2hLCOALVeCJZQ2PzuTEqjRmiRFjrPA
 S2a8ycByrN/Uhx9851Jb6cnDHUFKK3gOwE4a0NCGpKtFHJ2ubCmwE3jWgNxdFrTDn9Zu
 ftKmRBGIs+K/CAi2PmMK0rnluUgu41oc5oPHZjVNx9UQN/IKggrx83J3W3QgZX1XOQIi
 ZFjzQC+NH9bHZ+BJXFAtPRnAUq0Uv8LCs70jqj49lv4sgafA3loV1PjfhksxQkLbxOOh
 QptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197489; x=1778802289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IvdBCPwdPebINf2u9OS/OLdVPs9YETKPSmVjqHkDdBE=;
 b=aTP1P66czon5VjpwduUpk5PyeqQqLORe0gj1JWrY/4bSyI/m6LIhyy2s8hQnizSp+T
 Z4X2XCPOOtnV719pz7EhcL4QAaWE+j2z7HWKWG7nhQuk3j1HBAvtGpunMZYTGbzLkTAi
 6lUVO8X4V1bMI8caDIJKK4A+MhCXY3PhFMIdPGjMiXp4ZM70T00u9QyxzY2hvb6rruJ6
 T9iHqBz2QorpDfpDyMy00hkev+HwtEApownDWZTNtJZPecse7IDO1NHHjcUBw3yf5u55
 Os4RBWji2BJKVjfV0jN+TfAdZPFZcHrJNExVnCrhy4J1+fZUJK3yNcZw1h4Qa7Dm4KUM
 w1Ng==
X-Gm-Message-State: AOJu0YzeyBSdat4PKDMdo5X0CSxJ2tSUGXUz35jIHuLu3ty88TPRtOWf
 6r5tXnQ/eIsA2oCM6FnLxLy50qeoXEMxP+ImlMz0q3xPnnIJ3RPCnsqmSgiiFXsBRb7N4wj97jj
 szgp4
X-Gm-Gg: AeBDiesC9ak0ced7ii6VaB27Qkpz9Zbs8wNSGwagtrTahXyDHtGwqhG9Po39LU2Dep6
 yj24xYgAt0a6zR8yrgx5W3gH9E8Rb8uzrLa5DPWGuLqdtALEIKLPVJaQafepIDga+SnnPw6+UNR
 eDrlhDgEEPODUc+pl4v0JtipGuUDwY94cf+IE3jwMHfR5kPJEgIuAKju1recfGqLFKrkPOVtxXN
 gyNVdWODpML6P74P26DVKYPfNX2ZVKGjHPlUspRCPVvirSlG3NryTnGtuqkxWAXZuV/HoYaOpB/
 fp9Gr6EPxSec4BOf3DYx++tO+qEA5ly6bcfZ67wK7U3PoqZtqxwEiRe5mH+Zi0uBREvucAcD3bK
 5YjSfZjZNbeuYdsL+vuLg+grstQkpIOz6UDlwzYGop6WNZbjgmsseE0mpaPehn4y3V/bWVZK7/F
 zNypcJQi5lF7tkENirDKVxtaxKagMZUp/HXoHBF3xr+5EQfnu/SzQ3svPc
X-Received: by 2002:a05:6830:67ca:b0:7dc:e422:ce6b with SMTP id
 46e09a7af769-7e1df11bd8cmr6060961a34.27.1778197488642; 
 Thu, 07 May 2026 16:44:48 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 35/60] target/arm: Implement FCVT,
 FCVTN (FP32 to FP8) for SME
Date: Thu,  7 May 2026 18:43:48 -0500
Message-ID: <20260507234413.643512-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 59 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  3 ++
 target/arm/tcg/sme.decode        |  3 ++
 4 files changed, 67 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5863a6dbb8..36ae977431 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -21,3 +21,5 @@ DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 55b09c689c..d7c1ff97b7 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -504,3 +504,62 @@ void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    ARMVectorReg scratch[4];
+    FP8Context ctx = fp8_dst_start(env, desc);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n = vn;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    size_t stride = sizeof(ARMVectorReg) / 4;
+
+    if (vectors_overlap(vd, 1, vn, 4)) {
+        n = memcpy(scratch, vn, sizeof(scratch));
+    }
+
+    for (size_t i = 0; i < nelem; i++) {
+        for (size_t j = 0; j < 4; j++) {
+            d[H1(i + nelem * j)] = fcvt_f32_to_fp8(n[H4(i) + stride * j],
+                                                   output_fmt, ctx.scale,
+                                                   osc, &ctx.stat);
+        }
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *n2 = vn + sizeof(ARMVectorReg) * 2;
+    uint32_t *n3 = vn + sizeof(ARMVectorReg) * 3;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        float32 e2 = n2[H4(i)];
+        float32 e3 = n3[H4(i)];
+
+        d[H1(4 * i + 0)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 1)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 2)] = fcvt_f32_to_fp8(e2, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 3)] = fcvt_f32_to_fp8(e3, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 050c3cfefe..2f79c458e1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1572,6 +1572,9 @@ static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
     return true;
 }
 
+TRANS_FEAT(FCVT_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_bs, 0)
+TRANS_FEAT(FCVTN_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtn_bs, 0)
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a02bcc0e22..2b9e41a75a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -865,6 +865,9 @@ BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
 FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
 
+FCVT_bs         11000001 001 10100 111000 ...00 .....       @zz_1x4
+FCVTN_bs        11000001 001 10100 111000 ...01 .....       @zz_1x4
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


