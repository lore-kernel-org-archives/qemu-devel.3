Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103DEFB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Ck-0007yP-Ah; Fri, 24 Apr 2026 00:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CT-0007A2-To
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:37 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CR-0002rt-LN
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:33 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so5402683fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005090; x=1777609890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGh/j5N9mcyZy1AmwrVJTGg59tA16h2SHgyGHktIv1c=;
 b=ZuV9KSoB1uzPkoVKYuhBeioOAQcd+x0UOM5gJ0JOeKB9hohz9JSGwhobhiGp8MsQ0S
 o67Fn3iA0LcLOaS74N9NUf0XOZBG4p0w7qfOtm5e7w8asbBLmUPG1Ei2Bnme6UoH0IX9
 GZPqkocmn6ibIma/F6TcnZ4RtTld5pMRJep1MeQ5FElNFGa94wpZ/J5ARrYKwPi+sHNh
 TMSNTsy/5NVT1NeWQdn5R7xAOOHYgP8YqBa9ZSdp54NX2S/LuAWIZD3bt6Bwv6s87WvA
 gdul5xIuqIpBk1emN28lI5xj5ZzbEdiDinJMwKgexI3whKMk1C0aARPpByV9/Zx9qV4F
 M4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005090; x=1777609890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGh/j5N9mcyZy1AmwrVJTGg59tA16h2SHgyGHktIv1c=;
 b=iAP1ggCPsRJ2sgnZO57iMUSHB0wWtYJiFKaxlRIfdJCi499xGo0Pm8nRvR2OkV5THa
 yA92yr+m5OJlQ9/97AQEbjmp/kkcHG3fjp0wKi/F3t/cH2M9oxEqLErV9LrLZZ7gr4a3
 W5HArjawglGMbp8m6QZHUZB+GzAa3Q6wz3nFzN74iQjpY7hnEwRgZOaXc1jjvpmLYKSE
 9+/SsrefiVQBmaWHt+R7VSQ0cBKyjZNsoDg1ngt1yBbtq5mb5Wmsws6WsFHahes83gNO
 1Cp3b1DkyPecd6VmBdhDAxHhQOZudaGXnarr0SYIZ0uCIlR3JUFawrkf8ALj+t7aSXlE
 PrFg==
X-Gm-Message-State: AOJu0YzaNET1cCU+hlLb3GHZfDnxwJyKv6vmAxebKcb7kV3WmktkjMbm
 CJfAaknfFGWF9Ue/n6S7XgMtJoHl881SAxD7yuQikFHsoJEhUb/gF60osviVfvu3CVoA0mYwPt4
 yDnfe2CE=
X-Gm-Gg: AeBDiev39jTgmKrKuTrL6kfXbWN5xR5UiGdnyJNUBpCvrp6y8dgf9uxLi8aYZvFuE9V
 mzUP6I9TneWSTvjAR0BXWFX6JV1PhPZHIiRiOyCedvnQWyFbBVMzjWYRkCZ8si1jKgbpt4+XHtU
 8NEHHjc9LFN13t9eQn7YF48NUFjSSPxCf3aatwq5g493Knb7EEpmMq4YvvmqWVtgKdPPt2ApYTd
 NfHi80hWkfJqGKhIlKA3iN4AUA0sGKd4PtsEdmyMeAPws8zjzjd+nbryXu+PZgiOXJU2CcRuQkV
 xSZcsPTNgmGtr8yupGL4WGVogKsexZt/DJMNtbmgW/VWHPY7kcr5j+mFJjhJ0Y/B2UYE0XHADfx
 Fg4rz3qUzvIAbtcOI3630Ap0dsz+JdJ9mPwOMKnz0KOJ+chZ/35J66W0gfJv2w0GftrjBGDLB+r
 EuvtXbX4bX/KlBJrkbp4cs2XXFI/nRugkiBB5N7S5O4jqZ0CkEZ9mEeeRiYZJh0+hseq2Oy8nn
X-Received: by 2002:a05:6870:9a8c:b0:42c:36c:8bce with SMTP id
 586e51a60fabf-42c036c98b4mr15919452fac.12.1777005090046; 
 Thu, 23 Apr 2026 21:31:30 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 16/40] target/arm: Add isar_feature_aa64_f8cvt
Date: Fri, 24 Apr 2026 14:29:50 +1000
Message-ID: <20260424043014.46305-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index df070afdbf..87d16b57dd 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1550,6 +1550,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
-- 
2.43.0


