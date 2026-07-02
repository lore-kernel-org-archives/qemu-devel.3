Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D37C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOFx-0006hO-Is; Thu, 02 Jul 2026 16:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFq-0006dL-Nw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFk-0000SP-UO
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-847917c3678so635815b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783024999; x=1783629799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AujiVGcbp/G+pRjXzmwSc+VsgdlJiWMuOy1S4K77tn0=;
 b=VeP+dMsyvlEVgWKHaiOmyqIKwPn9In2Vd1L6JdFKmWQVm92iaer9+RWTF8EQS/75S4
 tCh5ME+blKZaX4ZaO+4zRC/BDLKU6CXb49X5wFYq96fObGjd7T3nxo+Nslo/sFWUGXed
 ur6fRzqAyJe/9D+YBWfaeGq0gzeeEZHHpidlZd1Ex93E5qqcVHEdQCAAqaDHtFbPnIIT
 zGo1QJ541j6h3uNSEkW2YLGvwG0zYnEBVl71N1k64FH92V+HZhiux9ubfZ60STOdIU5D
 fUVOXp8XYTqLjSBi2FDxd3Rjm8BZZMWYu7j+WOqp6ztBUe5OL9wtAnw0XO6gficH8kFj
 39kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783024999; x=1783629799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AujiVGcbp/G+pRjXzmwSc+VsgdlJiWMuOy1S4K77tn0=;
 b=adQSy1aNEpsjSh4b8DMXlVHakMtIl2sXjqfmKEzcYfsVVCUSYlS8jFxBzQjWYOazQi
 vPWcrT2ZkVWlN9nZoc+QIFZH0mOfRbfl3gqFzKwTg+HUxbhpPhKscjV+ajw+n6boD8ar
 ddLdrkoSjUWMwV7KJY3yHpOdRxtKLv32aCGXQh5GckO53BxMy8wrYxanKRupEHtbzLdd
 D+V4RlaKo6LXfhAzQQENgw69vJPNr4SM/FOhfZcB+GpJNla06brwErriXu+9Znbnw4X4
 wzeVqtHCn62ARFOyy742t6rvQhp0+6OITxQ0m2s+aq36XShXjYdhfBGIBl1WaxgFJ07b
 Y32Q==
X-Gm-Message-State: AOJu0Yx8aBdIPMktI1WnKYXhbjCfOc0jXOpE8/k3EUSVR5rVwvNgx1YO
 jzevzl/RKDRqaL/iNSQRqmoBnQ5lvY+c/LOsou3cs4qugzfcDSiqPDGOixhpU/JxyYSHHoAYGcr
 PLlno
X-Gm-Gg: AfdE7ck4aoem3HCL6HNSUTJFjPDalGW8YIzdNxV9oc+wIIckzFXKd04T+lIXw7+m+2d
 x7eeAlo9pFD6Aw6ilvZN6XDTwQdyiVumDQF+mMz1kqIbiVKXc6vuAkHnyM6F16ffrGOcGpSBTrK
 rEGUKArrZiUiU6g3H5sWnoyZlunGixKmTEqA9UyIHLUlnj3U7hQ+XaSdgRNyGGd8XbjNRbpcBU7
 XXqZzlJDKFQZyGPDjjhr1rOFkVbNF2vUyCoSc8vjX6wVMV5RHHaAsSYNO9GkZmNMbVabxlYdbgC
 fpKUkWz7j+i9BvShlXdYvEEMzbXJYFu1lwPhmo3I7sXfSyjb1s/0h5B/hqy0wTyFbIYwaHVrtyp
 LnNbB+Hk4lbZNQxjYGIblIX/1Cs3X6pmGAcSg0aKdD5EBVuMHyu7ptTYFXRd+6npenQQ1MpTju1
 LJUDoSmntELiB0b7gNoaoG7bVrTDDZxOtlnGv/YotHhUeSUseKlg==
X-Received: by 2002:a05:6a00:1708:b0:845:cf86:947e with SMTP id
 d2e1a72fcca58-847e18f5069mr1349046b3a.27.1783024998665; 
 Thu, 02 Jul 2026 13:43:18 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 03/15] target/arm: Implement FMOP4 (non-widening) for
 float64
Date: Thu,  2 Jul 2026 13:43:02 -0700
Message-ID: <20260702204314.79224-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 target/arm/tcg/sme.decode        |  3 +++
 5 files changed, 62 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index eb5c574e59..579a99122b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1802,6 +1802,11 @@ static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
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


