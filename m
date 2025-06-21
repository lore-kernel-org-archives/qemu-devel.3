Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8228C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zD-0005BD-Di; Sat, 21 Jun 2025 19:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z9-00058g-1d
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z7-0004V4-08
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso1380787b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549856; x=1751154656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X4oC0yhLZQ56vKJgXRTT1p3bLDAVmjtbMIDOYdUjGo8=;
 b=Cbkonuk64En7y4sFf8t/mcZS4XIP6mx4eoHeOd4CmzoQAisPpgYASC1joJ89Gxn8Fu
 Hd/9NWmfxYV1nZ2wckSbeItEZ2FoVuc0L25piypXBn4bTkayTJ5Fm92glym8PTCe453x
 Fd3RqOtX1yC9Px82FoeNfTk3lZsHUipSQiKwm3TJNlDwznpnhyH5uq3QrhGeHS1yKRUK
 9AAzVCOFt87P51pDSjhjqrhwKc2ftebHMtc3EHMTkymJglVTd4r3FehP68R5wu4tKxEF
 Rgq4Ve+AATe0Q4DJGtwRMZwDER8min751gafw8euzrPf2fvxHaC4nH3AM9Hze9huytN0
 d2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549856; x=1751154656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4oC0yhLZQ56vKJgXRTT1p3bLDAVmjtbMIDOYdUjGo8=;
 b=C/+vO2TdNlNTOwLy/DrdoqdDHHZ5ile5LoD7g9cR8o6A0CCcQd1omRu/vkePE78kyT
 0HVrH6tVcsGYpTI10N0UFf+quPqqSd2Aq9qQsrkh5lEc6JNHoGa/YpeUWQ3vFvurlV/f
 iAiuTx3hvu4QX3ARbUC9/VPYGiGrixvpGVwreLtTMxqnLLkF1y3qg51+vW8H2xU8TDo/
 Z3lk4GkesxmJMBH5GBlRcybSJ46+oTvbwdL2rqOEFX+7CTDrqFMvnyYPPCDRzdUK1esH
 GJRm1nv4Bvuafa3Okxepj0JziOo7e+Elu6denz68Hc2FmAOoVH53jeLXfEQAVa8p50mN
 RfHw==
X-Gm-Message-State: AOJu0YzvBKe0/0dIhz8k53RCNHeghIhsXSs+4o2KQz5Kf2EmVDUzta0W
 JpDiqlRTJONi9qGZTskmf1oW+/T5y0fYdQzQhYx67aDtBugxWM2fHBOxrsopWXUoH0HyTMTeljK
 4uHzx
X-Gm-Gg: ASbGncsXf6qAYgnrPS57k5kchPJpsqHeMVEDih0qmce04RK4oLH7NgRwcZz/Go2KpOk
 SwEqOL9pFZGj2jQSmUX+rNRzKi4WMdrz8hSiuysnxCczgTIu4xTayVSgMzkqzHY7/vPUNitCzQv
 SXugroUENipLsbLGK5Qbp74ivB2KSx5UVtm8j7T/VoCMh0fbOV1PFy+Rz13tR6EL/BDY2hDg7As
 O+uX2GmZ/PUSGV/YKUlEmdhX1KbG9RXSUrNxStN9g7ZrIEr/gNvFHeJ+fkqkzWDT8lpCWthSG2/
 08lJd23zIvAAbVOkuL2hvQGzGunapRf7U3GRc1l2tY7IYBThZE5qSCCOsVznPWIZsTdejLYpK9a
 PTHjd6aQRYJ3V0YouO+yC
X-Google-Smtp-Source: AGHT+IGSGS0tDbKqqee/jHvFgktRoBcy22HNxh170Q/tHnsKMzJkHk883ImsKCUbUR8kt2TlMpZvEQ==
X-Received: by 2002:a05:6a00:3d4e:b0:748:fd94:e62a with SMTP id
 d2e1a72fcca58-7490d4e3677mr9597532b3a.1.1750549855694; 
 Sat, 21 Jun 2025 16:50:55 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 026/101] target/arm: Implement SME2 BMOPA
Date: Sat, 21 Jun 2025 16:49:22 -0700
Message-ID: <20250621235037.74091-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  3 +++
 target/arm/tcg/sme_helper.c    | 34 ++++++++++++++++++++++++----------
 target/arm/tcg/translate-sme.c |  2 ++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8246ce774c..17d1a7c102 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -153,3 +153,6 @@ DEF_HELPER_FLAGS_6(sme_sumopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_usmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sme2_bmopa_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index bae48aa7d6..20a3fafdb6 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1267,17 +1267,31 @@ DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
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
index 8a901f158c..25139cb7aa 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -507,3 +507,5 @@ TRANS_FEAT(SMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_smopa_
 TRANS_FEAT(UMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_umopa_d)
 TRANS_FEAT(SUMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_sumopa_d)
 TRANS_FEAT(USMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_usmopa_d)
+
+TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 37bd0c6198..de8d04cb87 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -165,3 +165,5 @@ SMOPA_d         1010000 0 11 0 ..... ... ... ..... . 0 ...      @op_64
 SUMOPA_d        1010000 0 11 1 ..... ... ... ..... . 0 ...      @op_64
 USMOPA_d        1010000 1 11 0 ..... ... ... ..... . 0 ...      @op_64
 UMOPA_d         1010000 1 11 1 ..... ... ... ..... . 0 ...      @op_64
+
+BMOPA           1000000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
-- 
2.43.0


