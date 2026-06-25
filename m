Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42E1CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfI-0004em-8P; Thu, 25 Jun 2026 18:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsel-0004X6-Nf
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:49 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsed-0002KI-4D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:42 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8453427d3f4so130407b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426727; x=1783031527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SI7NWbwqWk43zaaql4aRymXS+Bs+g1qkzrJnvfWhX+4=;
 b=RVOfczzD44/PwjcCtYpzk5w2Au0MdQDZVujyNsqMR2s/WP+Q0ipOiBiZPvlc2TwRKh
 K6u8b6kOqOLi6Ql2URFImi3MpJbljxxDnLoatjro3U1LOgeyr5O4xkwsv7G7ARLTDmgr
 rup9CAe/wqUndG6rqxz0KbRB8h3ONdfZDQLroiBmnREyvQuTPIQJifDfWyYrL/XaTUD+
 XsFUpUfqxx1PTfd6ebJiDBOjLj4nz0ZdkSSuNxv8zZydkQHvElhMHOMYOUx5JRMJ7Ppj
 SILRxkLlXtbftnOUgOl05cc49Uk1KiOQo5tbK9KdloGs+f+35lHcrbnjRm8owOvqZwCR
 cXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426727; x=1783031527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SI7NWbwqWk43zaaql4aRymXS+Bs+g1qkzrJnvfWhX+4=;
 b=gw8CXIv3aYUph6tmByDoAg3z4pun1ie9u0FEdDHTQoQ+N56E1o+50ymEhJS0iqQ6y/
 1ql18A/fLtniPXbYkfkbm/LWtxg31KEQlZx5XkGVBot+8xbgpqJmmAMmBceFBRGjDGo+
 XMpbXg8S86p/vTh9CBfZeJOewFiWsi0kMxQBOCAb7vjTBUntxFnYdpC7W9MA74+EWdcc
 2IyVPD9VIsN5blun/wCeFuq6JMCUYAZyfAVoFMQwE5I3sZO3kjExAxp2d4W54eLl7Apy
 5HlHriYg3GgTiaiNRH811h/SOFvmwmw4fq1vuCwCjgUchm+tWW3nki22gKqvTeywugHC
 0yNw==
X-Gm-Message-State: AOJu0YxYjZyuAzG+dRKGs/2E9+AYZ/F1E9S/PDt1oxuuPgU51pUC3B/U
 fsZQsDYBxkhWjEjLHB1E53kjh7qsCHniT2w3nRnClOseeGK+3pHsGEupBAmT9/ZCu7/Ex/KKFpP
 NlhPM
X-Gm-Gg: AfdE7cnx0FQ89/MWZ4Xh0QIEBbNzVeEtP/+hFmAQCq0CMOjz/XuXqTyU3/VdK8tnT38
 rhhC9h45nyzP8kOxRqwlBTcTYiaIrMef7jrTd2yxqu/1D5VlLYHK+01enIxDltBv6h365PqQcOW
 779oY07NyaWeNRsOCHas5RwqOnF+DLsGU/kf237rxAeRGsDfKbxBdkH4Q1LatCkedoFgdrIiv57
 7QDf4a9rzm2y0Qk2+qFqAjtKFuCWqKMxB0eiaAxJ9UXHSl6017k+D4nGm0AeYpjmeyZLTK8kuPZ
 1OGAVqE1mc2r6wUIEJXT/8hjCUCyRxX/PKU5dwOe6CDEqpShniivMzpzQ81xJgqUjabsDi+n3p1
 nyjKVtKyx78GKh6S+D68aWdpVeVDptYxHWxuKy/Lr8f9CGEYE6N4CUR84pU5DjIZnQei833Xloc
 DfY4x/OIaS57qqCeHRRwrnrVUUDetPAo7xVbTXGQQORAPA5N7OPg==
X-Received: by 2002:a05:6a00:1d14:b0:842:83d1:ee6d with SMTP id
 d2e1a72fcca58-845b3b09c68mr5104285b3a.45.1782426726546; 
 Thu, 25 Jun 2026 15:32:06 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/15] target/arm: Implement FMOP4 (widening,
 4-way fp8 to fp32)
Date: Thu, 25 Jun 2026 15:31:52 -0700
Message-ID: <20260625223200.763198-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sme.c   | 18 ++++++++++++++++++
 target/arm/tcg/sme.decode        |  5 +++++
 5 files changed, 46 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 06fb96d0af..4134dad994 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1807,6 +1807,11 @@ static inline bool isar_feature_aa64_sme_mop4_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f8f32(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f8f32(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 126dcadf77..47f35a82dc 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -44,3 +44,5 @@ DEF_HELPER_FLAGS_7(sme_fmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr,
 
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index e1dcc2b70f..46ef7758b3 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -973,3 +973,19 @@ void HELPER(sme_fvdot_idx_hb)(void *vd, void *vn, void *vm,
         } while (++i & 7);
     } while (i < elements);
 }
+
+static void inner_fmop4a_sb(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    FP8MulContext *ctx = vinfo;
+
+    *d = f8dotadd_s(*n, *m, 4, *d, ctx);
+}
+
+void HELPER(sme_fmop4a_sb)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    sme_mop4(vza, vzn, vzm, &ctx, desc, sizeof(float32), inner_fmop4a_sb);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 544a825595..386ded1b90 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2072,3 +2072,21 @@ static gen_helper_gvec_3_ptr * const fmop4_sh[3] = {
     gen_helper_sme_ah_fmop4s_sh
 };
 TRANS_FEAT(FMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, fmop4_sh)
+
+static bool do_mop4_fp8(DisasContext *s, arg_mop4 *a, MemOp esz,
+                        gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+
+        fn(za, zn, zm, tcg_env, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(FMOP4A_sb, aa64_sme_mop4_f8f32,
+           do_mop4_fp8, a, MO_32, gen_helper_sme_fmop4a_sb)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ea9f459e38..cbf6343822 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1101,6 +1101,9 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 @mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+@mop4_o2_s0     .... .... ... m:1 .... .... .. n:1 ... . ... zad:2 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn s=0
+
 BFMOP4_hh       1000 0001 001. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
@@ -1108,3 +1111,5 @@ FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
+
+FMOP4A_sb       1000 0000 011. ...0 0000 00.. ..00 00..         @mop4_o2_s0
-- 
2.43.0


