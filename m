Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D325CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYM-0002Oc-Nt; Wed, 10 Jun 2026 12:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYK-0002Gq-HI
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYI-00061b-KM
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso32605325e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107993; x=1781712793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FRF391YCQ0UAguZPavBxOGhsGfFlsAqW1hPgkjHxr10=;
 b=PKRfy+YuG4VhSYly/9Oett65Pr8+AujtZb8+Okn9/jZptKACCZFO9V6j0dY0EArRLy
 IwZWU8epCPWURTWapyTGPWICmY9tKkc/eyFPTAf2+BydBq5ZddYtdzSlgsaHwpXsRhjN
 Hqc/Ok6gVrD+ZQf8HjXitjAbV1c14GbrGXg2ZAAgPHNRLIUg1qwkejpuZlk6qVtVaH8/
 ydckBw6a232Oq+7U3iyX4rptM60YBAgkfpfU/uEozJp701gqiuF2IhmgHh/J4gb1HIXJ
 p5AQVar40hqxjS2/xYZOfws0OU5kS0L8JeKKrIOk6+pJgBi0zTUTUpiFieYS60pcWOAL
 aqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107993; x=1781712793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FRF391YCQ0UAguZPavBxOGhsGfFlsAqW1hPgkjHxr10=;
 b=qZoSWE/oFzmIgjnKAu37gSprUzLpt8pX9rgPaq4oe0/aZ1ne7RMx45oz2LzHBvsHtm
 /QkcDGo8lTyckOLvPN9JOcLdZCnyLKHzOMrcaot0GAIyfAXXOns3HoANqmE/FPh4EnPQ
 Jwxof+pzvKNiTC6GpOJL4hN5oUvyo6qnqVW5yc5AnUu73xu85YuEOnsD83YK+h/jd3fx
 u49X2D8y7VavrH0SooqNloLyPED8HzYy+nhwzGesbz8a968CsN4u3UB6B9wj8g8FKqbt
 LHoHEHTqljp1NAcXMLuKokPb7NjlGzMsuVjym+fV6i/jw3E66v9WLNxV5Q1OwC83hAbI
 +83g==
X-Gm-Message-State: AOJu0YyNDGCM4MrbmNfWYcEQaVGDmQgZufLYDtpfqhVkpXn0vuIDtO+I
 T1WInqxCedAPuQLau8w5jlpwte3OwWDV12sveHyhCYtSe4bDZ/egsNd0maeAvavdTA6wLzxMP/r
 as1PY
X-Gm-Gg: Acq92OFNW7a+qgAVQC3ngeyZWxTbRR7V5ArT8iDBkIQNn8TbTcYNnN4W+7ch5fDN3Pm
 X91dsxHIbt/cI9mGlV3OyboDYOOWmQYZpbsOURB/xHeWUYmUvyas97ymkLRraD6BTWYJkg3ySX2
 KV8qRqDIiu7AbWoaFEPYSN2DrjfVCultOHG7JkiU4rGsj9sT5t3k+iaXotpQc4VaCjaG9Pt5waX
 Teo+yLJHI4YWTKShaJ9IGVN6sEprLIkcj9N4gQeERcSXCdvgAffw3m5R8k6wrLj4GlYMl4v1VSZ
 K7PoL98bt/bcFI00sI45PjJsh+w9WttLYRVT1N8hSNu2KRMLual2uKI5xChT8uJpe56wJhlNUkO
 y8aelIgWCWBCkb8721EjmTdDfv1vPz1oOdyLCdeeVO0RyEBf32RV9DFvcURx4nUYI3ZqjDjQ6Ku
 +Rtz8XseDf7xHnkts0DQpiM6RTCufsiMDOnV2lBPopNCsxGg7VxeLeqv7dy1xMCJtBpapiwkJ4+
 75xKcozVBjQda621H+Vlimr+ULoukvQ5gg1ZEtxPdQ=
X-Received: by 2002:a05:600c:468c:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490c257c3c8mr429928625e9.12.1781107993119; 
 Wed, 10 Jun 2026 09:13:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/71] target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
Date: Wed, 10 Jun 2026 17:11:42 +0100
Message-ID: <20260610161202.2235298-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-id: 20260609192110.752384-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8770fce2fa..f85368a002 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -397,17 +397,28 @@ FIELD(ID_AA64ZFR0, F16MM, 48, 4)
 FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
+FIELD(ID_AA64SMFR0, SMOP4, 0, 1)
+FIELD(ID_AA64SMFR0, STMOP, 16, 1)
+FIELD(ID_AA64SMFR0, SFEXPA, 23, 1)
+FIELD(ID_AA64SMFR0, AES, 24, 1)
+FIELD(ID_AA64SMFR0, SBITPERM, 25, 1)
+FIELD(ID_AA64SMFR0, SF8DP2, 28, 1)
+FIELD(ID_AA64SMFR0, SF8DP4, 29, 1)
+FIELD(ID_AA64SMFR0, SF8FMA, 30, 1)
 FIELD(ID_AA64SMFR0, F32F32, 32, 1)
 FIELD(ID_AA64SMFR0, BI32I32, 33, 1)
 FIELD(ID_AA64SMFR0, B16F32, 34, 1)
 FIELD(ID_AA64SMFR0, F16F32, 35, 1)
 FIELD(ID_AA64SMFR0, I8I32, 36, 4)
+FIELD(ID_AA64SMFR0, F8F32, 40, 1)
+FIELD(ID_AA64SMFR0, F8F16, 41, 1)
 FIELD(ID_AA64SMFR0, F16F16, 42, 1)
 FIELD(ID_AA64SMFR0, B16B16, 43, 1)
 FIELD(ID_AA64SMFR0, I16I32, 44, 4)
 FIELD(ID_AA64SMFR0, F64F64, 48, 1)
 FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
+FIELD(ID_AA64SMFR0, LUTv2, 60, 1)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
 FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
-- 
2.43.0


