Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C41FC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEP-0000U7-2u; Fri, 04 Jul 2025 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEL-0000Ms-VJ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEK-0006Ey-7F
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453066fad06so7823675e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646339; x=1752251139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V+hXRHTFrXwNMQu9eu6KCepG3zpKCogYu04WvFEC36I=;
 b=Iot5uVfaf4FT2UMPvKx1klI0pAGY5sqCezMziNS0hACth+bLtQcR5/BHuaQ2gI9a17
 mkyuCkk5KFAJRbRxHGo+ODMUeccwlMBJDf9RobL0UBKkkbx8C3MheL+XRrQJ1kP0a2P3
 gx76VAQBGLieRXKh6FDW7HuP2en716Fi+bGNclUjUk2cjJmoWbCq4g8k5wbF0DWbmMJx
 BKz15x3gunRfbh2IHxSw1FG8JzaiF0n5F5xrj5s4HzYmtKeAoB5qrr61ZfllJTceyfDy
 hO+6ezkTX06cS18wqsuYCLwm7P1G60hEpS1mhb7VKxRsbc4agcMCQCRhHSRZynB3ig6R
 ewtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646339; x=1752251139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+hXRHTFrXwNMQu9eu6KCepG3zpKCogYu04WvFEC36I=;
 b=CyYTIzlhwqQItZDAGnVL7T9lBlSgomwOfX9prFj95ZPmRoEVxPwwNDL5mYccTaNrBw
 IYJ5aGGjzLh1Qeg/G2ODpl2Ff4VmBRtvybRTyqDMf8OrG+UIQD6fP7EDg2HZkYgtcWiD
 hJUwibjcBX0Kj2wjUKChaasgjvZCCIq2L2HOxj7q/S90l78PPPfPO+F+neihddl1M4O/
 /izgvn0uUDl1OBLOP5/qF4P0W1+GbXdi853E/XkEaXJaaWsaqS6An5RZDqj8usnB96C6
 HrQcO4x6ICfkz67iLz/CYbzweLKyTnVEElij2sG/dtF7fV8r3n49sqMxv649/2k+CAkn
 NFLw==
X-Gm-Message-State: AOJu0YwxithANv0gGQ/g9ZX+bpGeeTlapY+5hlWnpnDjsjFm+uvb5R1h
 HBsRZDYR83ggVR7VIR1CcT+XHSGbLXCP9iO3SWtbgdlf6fJKqA+/5FaFlxwLof4+jrHmaGEGTFA
 Nzeky
X-Gm-Gg: ASbGncszh5uXRJ++MW+VtsMFJlO3SemCMD/qka433ISeFVbScKOdahVfX6hIMJHZ2NV
 2gjI+4LROSdmRyDMUN+ayjCvgpXZOYTdmVmzib5cQExFK8tQEYxw8HHIbxkfuMMwEF4EiS2XFdE
 qgO4C8tQv/CQCVmNz6T2YYYLXn21rH3P3K4+2ltCvW0+FGxGDrr3iQqYU1nmpjdFq88KeQiMAZ9
 z1Ss5TdJlFks60Y1aCeTR1yrQE4OYPFsEJew4EA1fEaUtgoIuu57b4W4vd8rt7KI8vf/k6xXuwS
 NNRA+wVh6v2RALU1XyaAGDI+ob/eJ32wRA1JpUYC1OmwA/1+br8a8dDe1DbZYFhLewjj
X-Google-Smtp-Source: AGHT+IEChK82j95Xb6COKcq+aq3JDjJAsa440Hg7D+lXspzsJ9l5lHyv0S9eWDLeUXk/VY5OeoaumA==
X-Received: by 2002:a05:6000:4601:b0:3a5:8a68:b82d with SMTP id
 ffacd0b85a97d-3b4965ff5cbmr2489786f8f.43.1751646338713; 
 Fri, 04 Jul 2025 09:25:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 039/119] target/arm: Implement SME2 BMOPA
Date: Fri,  4 Jul 2025 17:23:39 +0100
Message-ID: <20250704162501.249138-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
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
List-Id: <qemu-devel.nongnu.org>
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
Message-id: 20250704142112.1018902-28-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  3 +++
 target/arm/tcg/sme.decode      |  2 ++
 target/arm/tcg/sme_helper.c    | 34 ++++++++++++++++++++++++----------
 target/arm/tcg/translate-sme.c |  2 ++
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8246ce774ca..17d1a7c1029 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -153,3 +153,6 @@ DEF_HELPER_FLAGS_6(sme_sumopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_usmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sme2_bmopa_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 37bd0c6198d..de8d04cb878 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -165,3 +165,5 @@ SMOPA_d         1010000 0 11 0 ..... ... ... ..... . 0 ...      @op_64
 SUMOPA_d        1010000 0 11 1 ..... ... ... ..... . 0 ...      @op_64
 USMOPA_d        1010000 1 11 0 ..... ... ... ..... . 0 ...      @op_64
 UMOPA_d         1010000 1 11 1 ..... ... ... ..... . 0 ...      @op_64
+
+BMOPA           1000000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index baeaa3e0690..6122a5b5d9e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1297,17 +1297,31 @@ DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
 DEF_IMOP_64(sumopa_d, int16_t, uint16_t)
 DEF_IMOP_64(usmopa_d, uint16_t, int16_t)
 
-#define DEF_IMOPH(NAME, S) \
-    void HELPER(sme_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
+#define DEF_IMOPH(P, NAME, S) \
+    void HELPER(P##_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
                                   void *vpn, void *vpm, uint32_t desc)      \
     { do_imopa_##S(vza, vzn, vzm, vpn, vpm, desc, NAME##_##S); }
 
-DEF_IMOPH(smopa, s)
-DEF_IMOPH(umopa, s)
-DEF_IMOPH(sumopa, s)
-DEF_IMOPH(usmopa, s)
+DEF_IMOPH(sme, smopa, s)
+DEF_IMOPH(sme, umopa, s)
+DEF_IMOPH(sme, sumopa, s)
+DEF_IMOPH(sme, usmopa, s)
 
-DEF_IMOPH(smopa, d)
-DEF_IMOPH(umopa, d)
-DEF_IMOPH(sumopa, d)
-DEF_IMOPH(usmopa, d)
+DEF_IMOPH(sme, smopa, d)
+DEF_IMOPH(sme, umopa, d)
+DEF_IMOPH(sme, sumopa, d)
+DEF_IMOPH(sme, usmopa, d)
+
+static uint32_t bmopa_s(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg)
+{
+    uint32_t sum = ctpop32(~(n ^ m));
+    if (neg) {
+        sum = -sum;
+    }
+    if (!(p & 1)) {
+        sum = 0;
+    }
+    return a + sum;
+}
+
+DEF_IMOPH(sme2, bmopa, s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7b275dd2b84..c2615f06aee 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -539,3 +539,5 @@ TRANS_FEAT(SMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_smopa_
 TRANS_FEAT(UMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_umopa_d)
 TRANS_FEAT(SUMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_sumopa_d)
 TRANS_FEAT(USMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_usmopa_d)
+
+TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
-- 
2.43.0


