Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C041098784
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYS-0002rZ-5F; Fri, 20 Mar 2026 09:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYN-0002n6-GX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:15 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYK-0005z6-5r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:15 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b936331786dso190830766b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011970; x=1774616770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACqQ25GaMsLx1AR6X4JG/cERT+D9ImfITj+Bq5qPC/8=;
 b=BuzXJwAxcMFYl4UAqA8VmRzDKfBY2Xr7tRyXUkiEpwynw8Llzki2YqOqTAWsSv6423
 OGUAtyWCDErCWbvY/G8m7w0Udn0UFwOBIEPFNC0jLvktQzgrjb3ziecdP5Q2pLVdC12S
 ZjdLZPFdkAWfKhIhVhiI12MDz1lc++zDSnED0Ezyq01HRnZO/xGpNGfHVI9iwny5SjNQ
 qsPfi51XKwBe10gjDKo62Aoi43K4nKcOPIHxkIAtxTRjjT8L9nRv9fGAeJtFU42OCc9o
 q+2qKTFXCLI+0wpOKTcFnmur4MUa+IqZwqYvuZzIUX/4YkwuZTKjLW1skPcjvH2UWqnR
 RfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011970; x=1774616770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ACqQ25GaMsLx1AR6X4JG/cERT+D9ImfITj+Bq5qPC/8=;
 b=roB2bOdnrIQtuTWIhpKiH/dg8+DauhoIAo55EKW1Gbs872pB41p7ONn89ECOoToehG
 9cMgojQ5AlbS6jDpntUjA9rM5CcnuweCJ0ejnlwuX2hExvEKsUR50NJLOPOrf8i4ubm4
 SNi7SEcRhgk5Ni3v0VX75ZxZYwUfgaJfTrL/jVxAYIdwdd/nmR7tWXsoeA1xO9UznBrh
 FSiucGVsiqnVcGYZXq/0BgI6xzqeU2xBLs39z/PlIDJRAVm6abxtQgN+5PMRw6uY4rrO
 /JiBRceh2hzu8+csADW6SoSsZx6PSoTSlqhAWghFR2d8qEX184QRyXpq6vB+6D4rxfiG
 m+Kg==
X-Gm-Message-State: AOJu0YyH4SGMALe1ZJbcWple252rauFrJihyifWqF/C7hyX4KqDt2VJK
 ELuV+iR1EsnDPOoYL7Z50sVEv17EAQOf7xIJU//TDmHMDJ1wbh3G1wqMqo6jsOru6Gw=
X-Gm-Gg: ATEYQzwhwvH/gpJkfRhAKe3rEPAcANPe69NJ39z8l8iB6YcHMSinffm8rg635ohvMlX
 vxAKytnqRMquHGf67rQUHpBHH02681q3H1d6duQCL9ZgNcz+l2ap7fIClEO6EqdqDdHfBuQIG1c
 4F5FH19qEZ9FMJ1aVj1m5puGEdK78tmDv0WPv9uOblRaCG/OvJVNFFhe5zXnX+hQI7MJnNorSZv
 VgdDVu9xlzEOuFc+p34z5mHkqi1fBik7oBVr6vc0OryKsIn6xNCirufODG6QrwVhgTEsecq+eAR
 Pq4r08hbNczudECCYq5/i1CztwWZsrgrgSVygC2E4tRgdCtIByRMR3mOlqxytn06o3sPtGwRF7J
 Ck8M0hyXLonYLMBt/4cDqR8zKcicZKc8kvdNKR26W6ey5zOx1A74FAOwfejqJv3b4FlNrB+shTg
 padu8maO7UYX62kTjAWWPUYNlZD76wJtIHRw==
X-Received: by 2002:a17:907:8d85:b0:b97:4e42:23f4 with SMTP id
 a640c23a62f3a-b982f0ab4a0mr200254066b.11.1774011970086; 
 Fri, 20 Mar 2026 06:06:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983365f607sm154749466b.50.2026.03.20.06.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1D9E5F911;
 Fri, 20 Mar 2026 13:06:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 03/35] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
Date: Fri, 20 Mar 2026 13:05:34 +0000
Message-ID: <20260320130607.2071996-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

The syn_simd_access trap was never used so remove it. We should only
see the COPROC encoding on v7 architectures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 3d2660614c6..5b5a5cb182e 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -337,21 +337,26 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an access to a register of
+ * instruction resulting from the FPEN or TFP traps.
+ */
+FIELD(FP_ISS, COPROC, 0, 4) /* ARMv7 only */
+FIELD(FP_ISS, COND, 20, 4)
+FIELD(FP_ISS, CV, 24, 1)
+
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
                                           int coproc)
 {
     /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | coproc;
-}
+    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
 
-static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
-{
-    /* AArch32 SIMD trap: TA == 1 coproc == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (1 << 5);
+    res = FIELD_DP32(res, FP_ISS, CV, cv);
+    res = FIELD_DP32(res, FP_ISS, COND, cond);
+    res = FIELD_DP32(res, FP_ISS, COPROC, coproc);
+
+    return res;
 }
 
 static inline uint32_t syn_sve_access_trap(void)
-- 
2.47.3


