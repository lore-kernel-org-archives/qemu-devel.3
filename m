Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14F5CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsf8-0004a9-L8; Thu, 25 Jun 2026 18:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsel-0004X7-Ni
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:49 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsed-0002K2-6N
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8424b00710aso190665b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426724; x=1783031524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMMaiSxuvvK/MMllu8ARtJOHHm1Tfb2hW3iiR5BWhXI=;
 b=krVhDUCWoZAHv5SzLA+d0y8yGX4sujWpPkwKeT0apfXKo78AOgP3W/wYo0332R82mM
 gJq1qB2Y+4w/LgUkas9D+MAM9zxT32aqEBksEvrGptjCJXWsWvYQJcnHyHHngl5J4HEM
 RRTH9ASInxKPQDoq/AVtA7VcpoAc/n6jKIl5mbkCe1zmTu3//5paJJ4pIiVUbflsLxtY
 M1tHhIs2S65hfAYuDXLSTv1C3bcye5h7pXNa1sN4WoShQXKRyHyg9NKq7/x4oii5w58j
 ZoTDg3WMbf6xzT1tlnsIAZPKtbaDK38acZDF2eytFt46B+GHKxgoALnroYaaJlcPBtlw
 qoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426724; x=1783031524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMMaiSxuvvK/MMllu8ARtJOHHm1Tfb2hW3iiR5BWhXI=;
 b=hdautZHG3PoM0v2NPOF+GVaIdB5mOMwSEWpuJmMRPvLiJvEwEmOAgr2jjkuNTg8KuC
 gLVyRwlHQanr2y1FLQK21t/WKHvF4gvwWMuJtAOYvQAoqwbHhui0yZX1k4Jv9Nvqu28A
 tWRzl0XX8R6bDh2pc+2xfCezuB6nNycRGvRr7zj1J3HWZ1oAv8fuY7i2+n2AAgGmr5/u
 Ryj3uLmT88N9TPyBdwvj9nUWUPf26cv7g4V4o2musbEyeI1n+GR6s3hvXQT5Ra+hdmKs
 CZgB6nNiTHKcAUdOvAwcxijRpyGRXHZl15I60a6MmAFxtr0CjBAUQfkh0SmpiVxDPW2x
 AqOA==
X-Gm-Message-State: AOJu0YyHi9y6cpmQ4O7kZxJBw78wPznUkhEi+593FE7TAR6ZiHGmuOGv
 NPCw619Tg4iytNlyuJ0zYYUO8qM/8EZm8ou/Fqiq6ZATZpx1F23RnO/8eBiN3njAkpIrWg5kwMC
 nrdeF
X-Gm-Gg: AfdE7cmDdiGJQnvSyvxpbjsaDoCSRAUXI9RDrKeRnOWDxZpH451XVOFTil3VeHNx1NF
 gZ5wyRLEOWNBg2jWnVrh56/glmW7KL/52skn83LEq/a04dQO6dD40h+WwZwhJFPVlz/2wV9KMOp
 ffb0XHIDdehE7l8oTYMbzk0+sx2CrKtsCqCJ5uSRY/ggrKVxhyp3rHWN1RBUwKK1AnFRz+qAmaw
 BpveqWqPP3+xuGlJIrnyZmF8AMQtszCmR+wVAmDcnCJgOz+iWj/y9XHLSMRWoWOKz7rnhR7VTuN
 AJIym4TTlWV44IUWvdCiIzIGqD6iLxvRV0VQKizGFwRDjHMVfBQaRLBTT3CmLttmXW/hJITFDZS
 oz726JZdSVFgROXyf61w3gtmL55H8ffsaSb7PdPH1M9IxkuZUJ2D+Z4bTjdHCzD9yD5P6yevqBV
 GRRqJQj7hBbhXlZfKHa0jtom4BC4vUjaHI9UJf1wE47CwWfZnWgQ==
X-Received: by 2002:a05:6a00:988:b0:845:4d71:8d15 with SMTP id
 d2e1a72fcca58-845b3b88d14mr5410271b3a.37.1782426724459; 
 Thu, 25 Jun 2026 15:32:04 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/15] target/arm: Implement BFMOP4 (non-widening)
Date: Thu, 25 Jun 2026 15:31:49 -0700
Message-ID: <20260625223200.763198-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 target/arm/tcg/sme.decode        |  1 +
 5 files changed, 60 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index cfa97023a1..06fb96d0af 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1792,6 +1792,11 @@ isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_f16f16(id) && isar_feature_aa64_sme_f8f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_b16b16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_b16b16(id);
+}
+
 static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f16f16(id);
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 8a2ff88d49..05ccb0d1e2 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -367,3 +367,7 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(sme_fmop4a_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme_bfmop4a_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 81ec7ccfa1..0de7dd84e5 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2761,3 +2761,45 @@ void HELPER(sme_ah_fmop4s_dd)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_ah_fmop4s_dd);
 }
+
+static void inner_bfmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    bfloat16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfloat16_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_bfmop4a_hh)(void *vza, void *vzn, void *vzm,
+                            float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_bfmop4a_hh);
+}
+
+static void inner_bfmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    bfloat16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfloat16_muladd(bfloat16_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_bfmop4s_hh)(void *vza, void *vzn, void *vzm,
+                            float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_bfmop4s_hh);
+}
+
+static void inner_ah_bfmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    bfloat16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = bfloat16_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_bfmop4s_hh)(void *vza, void *vzn, void *vzm,
+                               float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_ah_bfmop4s_hh);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b6c49b9993..f833975875 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2025,6 +2025,14 @@ static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const bfmop4_hh[3] = {
+    gen_helper_sme_bfmop4a_hh,
+    gen_helper_sme_bfmop4s_hh,
+    gen_helper_sme_ah_bfmop4s_hh
+};
+TRANS_FEAT(BFMOP4_hh, aa64_sme_mop4_b16b16,
+           do_mop4_fp, a, MO_16, FPST_ZA, bfmop4_hh)
+
 static gen_helper_gvec_3_ptr * const fmop4_hh[3] = {
     gen_helper_sme_fmop4a_hh,
     gen_helper_sme_fmop4s_hh,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 3b7d8e9430..6021803ca0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1101,6 +1101,7 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 @mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+BFMOP4_hh       1000 0001 001. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0


