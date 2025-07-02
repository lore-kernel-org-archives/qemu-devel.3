Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52212C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfd-0007UH-It; Wed, 02 Jul 2025 08:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfb-0007SB-WC
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:36 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfQ-0000wO-NB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:34 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so4758874fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459662; x=1752064462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5o41MPLL6siTUnGgQzMRLhBRZ8WRwHHp5dQcfQlvV4=;
 b=NPnJgAhDhrGUxGEA2LY2YR98Hdxf55fC9sVSoe9SL5e16bTTOswJjU2+Z0I1rUKIYu
 5ibXQsRtsL4UUSNrzCRnPSS+7QDFAFk4MlGe79RWEaXtqm6tyhY/vVKFaYxu54bXVlse
 Ja+96F/QHA0KyPWVIduKsEoSRKcKJc1NMbgae1rI0DMLYe7Lx8IYNib9XbuORdfrEfUk
 Xp0Paaex/ulsKMHBoPUlSXOXliYCt4XU6hXSQObm+zIfM6JI7PL1E6VlK5T5I69wvJJr
 +ffoeibODUeWFDuLxImk0TjSkIV6DIgn/onp8FQWlS60kmGLVc/bAXgEBOT2uzTVKaNW
 9AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459662; x=1752064462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5o41MPLL6siTUnGgQzMRLhBRZ8WRwHHp5dQcfQlvV4=;
 b=NuhqyxcJX2ZN6DIv3unXWQvJ51u6Ef6uTSXRbIsUsd+H8TP4uQJDiQRgpVew9N+0m/
 CVQWkTINaokM/EZZS35hZYU/DUXS0mI1hkTCTjk9+e00wlz4ZaPWee//jf0NJM7rzqE8
 SUc1eKB7vd1RFPg05dk34JYoBRXWRnE4jJH2hUx4LHNWV5IXR+ZYfoMoT1df7Wa1COxz
 c6+v0231NGyAvUVLPBB7pr/zL8OlHLPBCZZuINANGys24HjJ3BzYitn6jVHZ/PuP8vdg
 WVAfyj+vZMtQ0TWT1upjfUzUs8aaEVWRpHG0aUieDZCiAHLDAlMOHxwErUA87NnGX83q
 nhAg==
X-Gm-Message-State: AOJu0Yx3Srcsa7aoh/UkIEDL3iXAUj9WBDlym2m0uxoTWlmskYI2JpAH
 gu66tazMCMq0U1T7sSZqgTUQ0z0CNQce0wEjAGRm316M4az2hM3nIZewZokzOjuiEwpiMW2xvwa
 cc0HG6jU=
X-Gm-Gg: ASbGncs92B+zv74J4OOizTv16pohwcoBfL8p9cwgOkUtkvt2Pg2ZK2B3cDZsDD1BRwN
 qAsm+PQWaIf1Ge7B11dm1iltAIjH+bRpxqqIcQRFb2wuMsFlYlaQfn7tNN9VUqjm14nqO0ZO3pr
 qJ5JKoZIhyBJhnbeSyRwGglx3tsracNNl2lk0lPcYh602XrPgzNj8xOh/PCddBjQNsyc05Z01x9
 DV3lngTCTMH/Ngv2CNye/4VVBy6W7MLwUM7W1Mwo1lbxqeOd4Y6PQQ+P0msp5vySKc08dLmNMXW
 tkzkqq5B3xeMdzVyQH70a3PCAYP/e7K/QiD0Q5OnraLof8JP/ToJtqmsHJsmfbrWEEZk6A==
X-Google-Smtp-Source: AGHT+IEcHUd43mn19KV10s952Y+moo3wxGIKE2aJgg/ZEdzhr+ZaMu5oO4c5TmA9WDlGvrWVXN1tRg==
X-Received: by 2002:a05:6870:2b19:b0:2d5:2360:4e7d with SMTP id
 586e51a60fabf-2f6472b3431mr1988802fac.8.1751459661889; 
 Wed, 02 Jul 2025 05:34:21 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 07/97] target/arm: Implement SME2 ZERO ZT0
Date: Wed,  2 Jul 2025 06:32:40 -0600
Message-ID: <20250702123410.761208-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h          |  1 +
 target/arm/tcg/translate-sme.c | 26 ++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  1 +
 3 files changed, 28 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 3244e0740d..c48d3b8587 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -80,6 +80,7 @@ typedef enum {
     SME_ET_Streaming,
     SME_ET_NotStreaming,
     SME_ET_InactiveZA,
+    SME_ET_InaccessibleZT0,
 } SMEExceptionType;
 
 #define ARM_EL_EC_LENGTH 6
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e8b3578174..246f191eca 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -27,6 +27,19 @@
 
 #include "decode-sme.c.inc"
 
+static bool sme2_zt0_enabled_check(DisasContext *s)
+{
+    if (!sme_za_enabled_check(s)) {
+        return false;
+    }
+    if (s->zt0_excp_el) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_smetrap(SME_ET_InaccessibleZT0, false),
+                              s->zt0_excp_el);
+        return false;
+    }
+    return true;
+}
 
 /*
  * Resolve tile.size[index] to a host pointer, where tile and index
@@ -130,6 +143,19 @@ static bool trans_ZERO(DisasContext *s, arg_ZERO *a)
     return true;
 }
 
+static bool trans_ZERO_zt0(DisasContext *s, arg_ZERO_zt0 *a)
+{
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (sme_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        tcg_gen_gvec_dup_imm(MO_64, offsetof(CPUARMState, za_state.zt0),
+                             sizeof_field(CPUARMState, za_state.zt0),
+                             sizeof_field(CPUARMState, za_state.zt0), 0);
+    }
+    return true;
+}
+
 static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
 {
     static gen_helper_gvec_4 * const h_fns[5] = {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 628804e37a..dd1f983941 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -22,6 +22,7 @@
 ### SME Misc
 
 ZERO            11000000 00 001 00000000000 imm:8
+ZERO_zt0        11000000 01 001 00000000000 00000001
 
 ### SME Move into/from Array
 
-- 
2.43.0


