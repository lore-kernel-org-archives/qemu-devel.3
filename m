Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940F8C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z5-00056z-8H; Sat, 21 Jun 2025 19:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z3-00055z-FY
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:53 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z2-0004TV-08
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso1380773b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549851; x=1751154651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OABk97XTtm79Sq2NVhMIhHFnnM1fve3UTe1L1EwPjNk=;
 b=sVx6sCpis3HG/wQNszs10VcqEexs+AlmUqryMeyyoDZVlZtNS7CdPELorHxjcehinL
 BbAtOJT51Y45XakYRFjJQJbOuqM99cYuUS0EQbbaPOcAQfjSQOliL1Uz97Vb5q23Li3P
 j8IXWnzAbY6rI30lNJ+N2F3tri7iN5PINHcdzpNUXU0ZG7MmrPgAQNhqYO0HWbsC3V3Y
 jomknMx6+wqW9HjTuDxCvTRDUltNnxD5SKQLodAI2nOaleV/Vx1wuB2uSrKXd+IZpRDd
 GLoA9DT5lpya4YGqM31L4NbmCZEOoHZXyzCV4ujX9Hz3nCnkIGxb/XOhTdJKnQftjorz
 c7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549851; x=1751154651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OABk97XTtm79Sq2NVhMIhHFnnM1fve3UTe1L1EwPjNk=;
 b=pIb045/EPV4pvswnVAsQUJWRSvy09RbQomQa5E13ME+hrCGI14gh/2vDAJNXwq7HWL
 NzjJ7aDs/nAMjCL0dUhzi+sJv/iZSw03SGIQJPzDveBKl9Z0xdim9G3KpPdqvMVhyvxf
 VISoyD0e73gU7atP5DjMqQSzYOcJhwAv5gxafyT4IrBAt1G5nSpZCcCzjQOTpXG42m2O
 wXCfqrWAFGuRYECfbiiZfqgCThOXa38Tq4dovH/gyyeqRLN0ZAkwg9D1vPW4Xr0WPWyZ
 Ifoc7n2KKQ7BApvufJAhfd4UlU2Ef4UtNVtQ170iCT2ymXdR5lS70DUeuK860mrShdDN
 XFDw==
X-Gm-Message-State: AOJu0YyqgB1ZVvBdAZ/fdvTzFd+2O6KCH5IE6L3SJt7+Bf8iyQrfOiIv
 5q3PE6aOLAqqKcHRGUbsIgrdL9MgF41pyctgC0ZZ/Zfyvv3fkDRw5TqLYhJvlE+VlU8VZUNtkSV
 TBVu6
X-Gm-Gg: ASbGncsrmtxOX4TAyFjGRMUnLLpLpKnpIXY4UDWZ3gPcA2VW836bgX7y2bY7yvvKoYZ
 S9qdxRHvc9Nk4buW/N3K7nLEef90jAnBWoh6Y/TA5IDQq8nuphMsRFmdozPaKYCpiZFsdT+Ir20
 lyfdTBHyLaXYFPUHFuBKDH8lUR6vcCC6mrew+a+8OWhkwA5gBZgtJKUxHSHmmKUJwVxkU/IAc4W
 NC8D2kIOBVVoyST0G+vpd3Bb56tXlKh97RlZhfo7zEAt3HxRw2EY0TykPliwIIQHNpztCQ3GcH5
 RXgPo0epeG+7VU41Z2mitESpW/pZwrC+v2Ho5Qx7r2tOs4L5QIudhQUZ2bsLEFDsmCY+tiqRhKS
 9OfpZtnQTfxUn/Z5WUuImj/USh7kpdb4=
X-Google-Smtp-Source: AGHT+IEmiCLuYUMflGwA7f42AcBzmSxL+RLyJB/Yfql/q34qOjVhJZfXLT0JZ4EP9NZIwRwCFnR7uw==
X-Received: by 2002:a05:6a00:1250:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-7490d725a56mr12462938b3a.24.1750549850677; 
 Sat, 21 Jun 2025 16:50:50 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 018/101] target/arm: Implement SME2 ZERO ZT0
Date: Sat, 21 Jun 2025 16:49:14 -0700
Message-ID: <20250621235037.74091-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index e8b3578174..37f4d341f0 100644
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
+    if (sme2_zt0_enabled_check(s)) {
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


