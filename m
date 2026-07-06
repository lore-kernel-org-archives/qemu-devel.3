Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F4C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggii-0007Hh-SY; Mon, 06 Jul 2026 06:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggig-0007EN-HQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggie-0003Ui-Mj
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b7612475so26287905e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334311; x=1783939111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pgsqydvu9sqRLWAJKvWtPpQxGrfm9SnVqtdBC2x5d1s=;
 b=yBKurZ5cdlcxC0HC8lCWJuN2GRamZoWzZWbqXGRl4113Qy7/IWFW+X36lbUQoWitbi
 mSpDIXJ+eu1zqjt92AB09rmQMO/WEwvnjy1XCvMy5OwGdG8TQC6YSn8VXgebfxxrvVtN
 4g1eji61dI0bpGg94ny2KlnNXqk/rSv9dXzK7x/Fi8NSSbLTCAe5G5vV7Ui/GUIkDqA+
 BUnX4KFvAI0ay5hkSxRpcga7kgiSPHYZQg5ngVn634MjX9PGKU/Ecj85z0kckLoZj8Mv
 QyCf7P6GwIq2d4W1qNSSUgFSkLkg9l6BV3zHUMPqM3a/WNSNcmFBV2S/KEoMElomv/s4
 rG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334311; x=1783939111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pgsqydvu9sqRLWAJKvWtPpQxGrfm9SnVqtdBC2x5d1s=;
 b=cduuxgUE9z+eUXZGgKm389PbCm/WW2PZlAMUUIiCmmOTx9xz5pAgtrJfZdGMlzxGmS
 0LC9gh25ue0+8kB+bFHKRhYmeproaBTytMohNrDNn1nBIcfWzdxHPm6myrbWuMBU5VJy
 BBMZYMVl6Ql0b4YT0ToRZX8G60NXO4gN5bqGp+KIagBlP1wvTo19VfTO2dZ2c3cwCXCv
 Ba61ZET6Uf8r2eXyz3TLfuNu/VeLwkKIgri7aWNJjlRKAhmUM5Q9JSh/YwZCQ0jmHA6i
 45x4YvWFzcCkO8YAsIDGuJBdiAF4XByfkZR3hO/DljjS9w3wnWZaCTzNiNJ/ejpQugw3
 Zeww==
X-Gm-Message-State: AOJu0YyV1WxVceZp5QX5QmfZDef4dPZkfOPLFVKtM45oyDUB+xzwCB2V
 ARwFQPHKnFj7tjZuA7c/voE8EgmVYaDBH1AohtHWubCbXFijESFem85lQh03ZM/z3Ox7mggYu91
 Bns767JaDCw==
X-Gm-Gg: AfdE7cl++Ce4MDoevLAJsSkCQ0JSjY7LOn3r2h9liifevTJreBEX56SbqnpF/Ei4IYW
 AbHZ4/5IwmyZAdre/tmBNXVK74hGKVSdSilIUa7FhLNVd07WWt9dMUAAObqBWmLpgtaMCaJPLM4
 MFU9XxH9yYR4q33FJCq4/4AVWf36YxMitvRY+FdMXzYw+awL9drigZZW7WLoOlNKXzuqcFjkwYq
 bxxIAY9WsIoXscU3R+Q5zaMQLKWr3mxS9ExZmgm3KXeJKoZBYUSOeCmInUZBg8a9gg76IZzEZpz
 k3EksWO6FVEPpwI6tYGice7qRz9uaA8+CRyn/J+hxOaZsvmq4filGaRYuOd5UCPQxAuP7i7HdIa
 aFp4f1Dzfy32wooO1jH/Am4y7qPd731rZhAFgRsU87OHDJ9ZPAbYl6rOcT06mhNxLNv+OrMTKuL
 ZBouWQ621njL9ISSTZIJ6tIGQQEWjQ25vyZmsAAMyKQfgKqDdVxw+bP3FGeXc8YVtM0QhHVHBWF
 0+Dq5T4Ot+NcIIfp5zz4IBitL5jXbPg
X-Received: by 2002:a05:600c:c0d1:20b0:493:cfc8:12e7 with SMTP id
 5b1f17b1804b1-493d11f38e9mr84141875e9.25.1783334311323; 
 Mon, 06 Jul 2026 03:38:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/49] target/arm: Implement BFMOP4 (non-widening)
Date: Mon,  6 Jul 2026 11:37:37 +0100
Message-ID: <20260706103752.320511-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702204314.79224-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme.decode        |  1 +
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 5 files changed, 60 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a07151e634..b4138e976b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1807,6 +1807,11 @@ isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_f16f16(id) || isar_feature_aa64_sme_f8f16(id);
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
-- 
2.43.0


