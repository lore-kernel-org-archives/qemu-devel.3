Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97798CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfU-0004gb-Um; Thu, 25 Jun 2026 18:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcseo-0004Xd-76
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsed-0002Jz-6N
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso226343b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426724; x=1783031524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYg6O/4r2F3F+UyW1bVMkx/41FMFXNdKQIUxxS0oZSo=;
 b=VrErpkAfqy3H4L+FFrY2UsVkJAaLOYn4oSTzgQidVulHtkZO2V408hxqPfM0EwgwkT
 nV0lop1g85s5eDk0EJYeeZP7E2cC32Q75tw9/BCjlkjedSCuXH9gcU5UqIB6Vzzg3quq
 mKIuWHKnGfkotT23pkw2dHVoAeEyF4BSZ2cM65KQO8lQ/M2er8raAmg1FaWFFaZmNZFV
 +GKn8/oJiNn8BJE6y6QQPuDfD/oEmS1LzmNYOa6dQcRnqUuBF20SGazEySFiwc5UXzUg
 cZt5iYUYXbaKPgfeHscmoUku1TjcfT7JxySsBvz3wuelCvaWw48BJqxlgy8wazkM/sIY
 Rl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426724; x=1783031524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HYg6O/4r2F3F+UyW1bVMkx/41FMFXNdKQIUxxS0oZSo=;
 b=lN5bNE/v8AlNd9T7pedK944FlGw9nhBLnYUYjCYNld3oBElPo3mihmRjUx1P99qfAM
 8li2gT3CNWnGJa1C61BFdX7l1i14eI71Cs6nfibT+/hWVh1Dhmz2Qc8kR/11g4GY7fWL
 +SVhuuYv1HSlqocNOmwGWPXTCge4Cld0MSxVzSGHYQZUJ2I3QTXdeXjzBfdUn6Czyf26
 Aw3ZD3P6t5LmZ3scghZeHjtoX2RGxPjOPXDMbuUQgfKhczoyE1+V86bnkWaDizHa5nfm
 Lq2BtdS666oxedxlIoY979vXoq19fmZqM1MjX/noemahATZ2EDtN7aOIiP21qDpol+QZ
 11UQ==
X-Gm-Message-State: AOJu0YyMN5Vm2BRXyTZFoamjAVL4xSuY9h5+lV+2ZInxg7hAnL7sInes
 IQidric0n2NBxyk+x05WhTYWvYCvHr9Y6mad7AIA92X9/Jfk/13XYeY8VI66bp3an9kmx32OpGk
 wt3iz
X-Gm-Gg: AfdE7cmTv50mmqyzUgH5LYJgqcxKtas4Ci8K3Q/OSf3M6XcEi2cuzsW1PwGnfEaC4As
 K8Zy5LSNE4TQO9b5w4F0/9bIVRtKPPL9QNiHpWnJZB/L/1OsfsL3yErSy0H/8/UNtHn8rGZrSIZ
 qJK7wVEOwx6EgawW6AIwV6jS7BzV/Uq0o90xUBcy5J+kCZOvBO+sGCI0BPdvxYCfqz5Kf2Wg6zU
 UV84VztsOl8tCtPrzsSiUFb3nznxJ+4bnJTAUjlksYE4ZIwr54lNbCQ07ELvFnYJS3CVEioPIzF
 fVI+QKg0+kAu9fQ0GWWAb0AgK8Dshgk6r7dT28tssbqBrx09lTdbG+OgpPCPj9fAYxuTKfCpBSX
 FrBgdDzya8Kj6M+yQEu0I8SjtWEDwdnwzb6SV//lF+t9mC4dIO+7sfGYQxKvleMUOXxjmauKxrP
 8ddK+oZP2AhCTkLG99iNLueTcc751tXppIkR3weRwoQH4p4tJxgg==
X-Received: by 2002:a05:6a00:2d88:b0:842:5da3:9b8c with SMTP id
 d2e1a72fcca58-845b3af923amr4453429b3a.36.1782426723836; 
 Thu, 25 Jun 2026 15:32:03 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/15] target/arm: Implement FMOP4 (non-widening) for float64
Date: Thu, 25 Jun 2026 15:31:48 -0700
Message-ID: <20260625223200.763198-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 target/arm/tcg/sme.decode        |  3 +++
 5 files changed, 62 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 822391aeb3..cfa97023a1 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1797,6 +1797,11 @@ static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f16f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f64f64(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f64f64(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index ec7389d2ae..8a2ff88d49 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -363,3 +363,7 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(sme_fmop4a_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c4d149f7f7..81ec7ccfa1 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2719,3 +2719,45 @@ void HELPER(sme_ah_fmop4s_ss)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float32), inner_ah_fmop4s_ss);
 }
+
+static void inner_fmop4a_dd(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float64 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float64_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4a_dd)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_fmop4a_dd);
+}
+
+static void inner_fmop4s_dd(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float64 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float64_muladd(float64_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4s_dd)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_fmop4s_dd);
+}
+
+static void inner_ah_fmop4s_dd(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float64 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float64_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_fmop4s_dd)(void *vza, void *vzn, void *vzm,
+                              float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_ah_fmop4s_dd);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d19cd274ac..b6c49b9993 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2039,3 +2039,11 @@ static gen_helper_gvec_3_ptr * const fmop4_ss[3] = {
     gen_helper_sme_ah_fmop4s_ss
 };
 TRANS_FEAT(FMOP4_ss, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ZA, fmop4_ss)
+
+static gen_helper_gvec_3_ptr * const fmop4_dd[3] = {
+    gen_helper_sme_fmop4a_dd,
+    gen_helper_sme_fmop4s_dd,
+    gen_helper_sme_ah_fmop4s_dd
+};
+TRANS_FEAT(FMOP4_dd, aa64_sme_mop4_f64f64,
+           do_mop4_fp, a, MO_64, FPST_ZA, fmop4_dd)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 227f3d7790..3b7d8e9430 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1098,6 +1098,9 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 @mop4_o2        .... .... ... m:1 .... .... .. n:1 ... . s:1 .. zad:2 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
+@mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn
 
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
+FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0


