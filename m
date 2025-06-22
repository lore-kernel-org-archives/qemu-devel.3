Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C56C77B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 21:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTSLQ-0007SP-UC; Sun, 22 Jun 2025 17:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLN-0007Rm-U2
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:18 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLL-000594-Nb
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:17 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2937848b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750628112; x=1751232912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17xvLC+f5hSIzSCO1us1OyV/XIgcsWpXj5v+pXI85Z8=;
 b=ICDHXmS5tNmBKFeMe2XvHuaADMwjW4+EroNvCKqA1YF7yJS0aul/v6nWWoYAn5L8e5
 BsmZAsJ+UsMAYvM/F2Y9uo2TpV79iLjxnxhMryYjG/hJDQDycdJ7LoJbZHDWSCY8f4aT
 MkbEnR2a+72fiOY0DX7fuMi1XP7mGPgkCMohBDXZf8BUBh5CBfGFigacEcQPqLHRXYnK
 CRchC0iaUHzVBDSnCCxeeXkDr2b5EjhRpu4ZNrbhPVYbjbx+z0MMrMD3FC7oUCTj6rD1
 Yyw3X3K5IFwmkouRaaRa3JqADlB+qxHiAvw0ptbv96PQD3YvhTziGMVJdwhvLmoQQ+ls
 kFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750628112; x=1751232912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17xvLC+f5hSIzSCO1us1OyV/XIgcsWpXj5v+pXI85Z8=;
 b=dypC1pczSa+QRiBmR9CPJdSFi5ZUglhDxNFD5OfTBnITzTyQR0K7w8Xf93FdMknjFg
 IKZh4DjQFccQ7HG/k20qissEnq1uy+bLe0/2I67qfefNb6pTn1snwIp4NT4/IQ+EnR31
 bkXJ1GCGSb0KIGwcoz8FRycNGf8GOxagSbn+gBC7HpUtIjvcPMFet0MhJvddUYyz5cu2
 pMQM61VrqwursweN+tk98ZOecCoPYXBRrPw+xp6ZXPnM7vOLzuLlj7iBDHXL+J5+jFRC
 znJuCBGL457Ifto309h4OdSAPnF7/18BNhQso6d+fsoa2Y02Ya/7Z85u17FCwVaOCBuH
 N2gA==
X-Gm-Message-State: AOJu0Yy1L69jGPYrHvv9g8t0AEgJo/BpMe5+Ay7fGlVgysdPJ8yD+fcx
 1yRPJM3RtM11+ZhxTT83D/SlxGQq/mfxquoUaZ0aDYazYveVbAElOm1diVMrFZ/Yr2xVD3NCvQZ
 XkJ5k63s=
X-Gm-Gg: ASbGncvHNZUqKDrCzabnLXRpZ0LY/9540WBs144/pLjO9IzS8E4DiTGYssTsDZ2r25s
 GgbzFzF1DTNLxRsKd6OdVpSsKjctg7GyPZXTRjbXfNHmcwBcaJTJHkVnqFRz5+v0dxN7nQT2krp
 4AKOTqmpt+/Ct8xExVBc/TMKPhDvLTNmOY7hwIGK9SSaQ8RKWavtnWkLqzwuntpQH816a9ll7uL
 hHAONR0X0ayzpIW5ntXt/ulqyNlzjVc3syKZKCP09knxcig/zBvWtL8eHDDCQepy5jD1ATXWS/p
 aLliAqNTM0TtIN/dlRXfHewrlJZpNc93TDaO5vAeSYCxD+FgmHltUOLWN+3ie4jXKlFP9TrmxO9
 nFUqxWm7s7nOvGGVzCVDY
X-Google-Smtp-Source: AGHT+IFwXaPGFo5khC1rNYPAfW+vPMgMVkgCjovQwA/KSUNuG5ki25mY/AmAZIOAZ0mLdIsTZiwj3Q==
X-Received: by 2002:a05:6300:4ce:10b0:220:2741:cb1f with SMTP id
 adf61e73a8af0-2202741cd68mr10228934637.41.1750628111707; 
 Sun, 22 Jun 2025 14:35:11 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a69f3e2sm6479842b3a.159.2025.06.22.14.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 14:35:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH v2 2/3] target/arm: Fix sve_access_check for SME
Date: Sun, 22 Jun 2025 14:35:08 -0700
Message-ID: <20250622213509.277798-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250622213509.277798-1-richard.henderson@linaro.org>
References: <20250622213509.277798-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Do not assume SME implies SVE.  Ensure that the
non-streaming check is present along the SME path,
since it is not implied by sme_*_enabled_check.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bb49a2ce90..d7b0c81773 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1387,11 +1387,8 @@ static bool fp_access_check_only(DisasContext *s)
     return true;
 }
 
-static bool fp_access_check(DisasContext *s)
+static bool nonstreaming_check(DisasContext *s)
 {
-    if (!fp_access_check_only(s)) {
-        return false;
-    }
     if (s->sme_trap_nonstreaming && s->is_nonstreaming) {
         gen_exception_insn(s, 0, EXCP_UDEF,
                            syn_smetrap(SME_ET_Streaming, false));
@@ -1400,6 +1397,11 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+static bool fp_access_check(DisasContext *s)
+{
+    return fp_access_check_only(s) && nonstreaming_check(s);
+}
+
 /*
  * Return <0 for non-supported element sizes, with MO_16 controlled by
  * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
@@ -1450,11 +1452,20 @@ static int fp_access_check_vector_hsd(DisasContext *s, bool is_q, MemOp esz)
  */
 bool sve_access_check(DisasContext *s)
 {
-    if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
-        bool ret;
+    bool ret;
 
-        assert(dc_isar_feature(aa64_sme, s));
-        ret = sme_sm_enabled_check(s);
+    switch (dc_isar_feature(aa64_sme, s)) {
+    case true:
+        if (s->pstate_sm) {
+            ret = sme_enabled_check(s);
+        } else if (!dc_isar_feature(aa64_sve, s)) {
+            ret = sme_sm_enabled_check(s);
+        } else {
+            break;
+        }
+        if (ret) {
+            ret = nonstreaming_check(s);
+        }
         s->sve_access_checked = (ret ? 1 : -1);
         return ret;
     }
-- 
2.43.0


