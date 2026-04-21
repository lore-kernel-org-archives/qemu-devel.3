Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5233AF55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Sc-0000WQ-CD; Tue, 21 Apr 2026 01:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3S3-0008Ne-MN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3S1-0006uK-Qy
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b24fdac394so36281275ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748508; x=1777353308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW+LW+Nt1rhrQi5WxMDAPWgTbe7PVFsy6KMvcn0ZFDU=;
 b=EmSjA5haqH6rZein6PbDTFbgvLMb4zSkQdHsyvIcmC+A0cOvr8yzkO24Qi0dqry/LD
 BOYTyp8IHW58KdBxTbdB+r0eo2Xzu76Ks5q+1l1BiVXVf8XOsimURDgM32Ac7hKh0ssb
 /JkfcVNF8Kpydf6XUw74nnEruTp8LjqZ5kNRUaO7HM+fc8xfZWTYz6e6LMM/3v3dUJ0J
 ptfRaSMugLq0gkDyx/kgHvreA0M3Xe5/WimVm78x08z9P/865GL4G2SKxj+HT+XkLQuk
 dvvavgxpfAsjbpqsm5iSgAY2bgZ263dR0cJJNuCVx9RbTMV4uNPj1/qlkujQqSu8BYyv
 1lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748508; x=1777353308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wW+LW+Nt1rhrQi5WxMDAPWgTbe7PVFsy6KMvcn0ZFDU=;
 b=JRClgedP+1Syt/9esMDgKZA/RUqa+/4DRRaWAo+g6Np7lQhkEOROYRIJE7j1nLtyKt
 ApCGRtXxEGPKjlF8SL4AavqX91DoGgpGEfHVtTpJRKPEwyDvdduD4w3xLZWy9KgczUl+
 oCHAkHsHyuupAn+9X+iQy/QUjCuPaXfgaFi/VUxneX22hVesurRHMmAhreu1mYgYrzLV
 EhS6Sh1SxvnydkkBgIuP/bsSQIk6MyEmJ7VqaTawhin4FFHQkG7B5wU+1csAgheaGwXH
 5XrMIYlOqvhhIMPP+dyTQPjck33bNFovmILVWDSJ/51YpiZ/UpET1Z5wDzDv3/SfeTeG
 wVog==
X-Gm-Message-State: AOJu0YyMYLCvnC51hAGYLDht91U9N2GtWb5HRFAaz7c0zxSxPdj13zJI
 z1yoAfew0BksH+OOpLrgS7Q5urat9K8ok7ERJHpHXcbnZIdRejasU2rsZ7N3ASsbNDo0luOpWi8
 A0xznSfs=
X-Gm-Gg: AeBDieu0viuBf58hV3ssbrmO/yy0PFm8pn5yOLS76EgFnoon8tI9yf4h/X+LOaifiUz
 kEJEwDaommqzj9SpXfLPDeCW5NE60Gn45wK3tbwmpCzmoNN2J9XnaxlAU/epqHs7VnjScK7j6/J
 u92/8PLr+HchykKK0ZRFeOuhCy7SR4fe4pNk+vjfltT4SRMq23DP+tp3tfKUCgBkYOUJVUtL4cN
 rp4s9+MZlBaNpukZNtjTT/uR+N1/rZA/2ySKbse7B+iuyswPe4HqXnX+8xsGSNWrm8f0a8N03PZ
 l2aTYgP/Vrb1RZ8DZhHBYvtaY2eqBR/4h9C2EzjEh9hILpldb31dL2prMcxH3WdXm053EkPspDc
 a2z10IWImp9M2Jd1DWyk4bJZCaN/d55t+xgDCXzDsLGPBB7yzfQaz8oGmVQBKvRLaVK2u+71d4D
 V3/glhTsIAo3bHU+5gX7f1MvS6ZUwyEuQduPR3g5zb
X-Received: by 2002:a17:902:7207:b0:2ae:ced7:4650 with SMTP id
 d9443c01a7336-2b5f9f7d14emr113637475ad.24.1776748508012; 
 Mon, 20 Apr 2026 22:15:08 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:15:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 32/37] target/arm: Implement FCVTN,
 FCVTN2 (32- to 8-bit fp) for AdvSIMD
Date: Tue, 21 Apr 2026 15:13:41 +1000
Message-ID: <20260421051346.41106-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/fp8_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 16 ++++++++++++
 target/arm/tcg/a64.decode        |  1 +
 4 files changed, 61 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 6530d1a6da..023a49e12f 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,3 +16,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 6241297269..fecd9cca0b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -480,3 +480,45 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     fp8_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
+                             CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n = vn, *m = vm, scratch[4];
+    uint8_t *d = vd + 8 * ctx.high;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    if (vd == vm) {
+        m = memcpy(scratch, vm, 16);
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < 4; ++i) {
+            float32 e = n[H2(i)];
+            d[H1(i + 0)] = float32_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+        }
+        for (size_t i = 0; i < 4; ++i) {
+            float16 e = m[H2(i)];
+            d[H1(i + 4)] = float16_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < 4; ++i) {
+            float16 e = n[H2(i)];
+            d[H1(i + 0)] = float16_to_float8_e4m3(e, ctx.scale, osc, &ctx.stat);
+        }
+        for (size_t i = 0; i < 4; ++i) {
+            float16 e = m[H2(i)];
+            d[H1(i + 4)] = float16_to_float8_e4m3(e, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        float8_invalid_output(d, 8, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+    clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 93c883de88..6013226266 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6536,6 +6536,22 @@ static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
     return true;
 }
 
+static bool trans_FCVTN_bs(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, 16, vec_full_reg_size(s),
+                           (a->q << 1) | FPST_A64 << 2,
+                           gen_helper_advsimd_fcvt_bs);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 71456d44e1..a9cf259b9b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1202,6 +1202,7 @@ FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


