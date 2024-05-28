Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399BBC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3Te-00033w-2A; Tue, 28 May 2024 16:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Ta-0002zu-1N
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TM-0003gE-Jg
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f8eba8dcfcso1028619b3a.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928262; x=1717533062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODn/W9Q3dOBbNGA6DETDFah62NRsjBjYaUKDzhwUZZ0=;
 b=rQLWYGmUTFxDT6u2mGUieQA0MYuArmiSy6MPpPmNPaOHm98e8AMKOFMMNBGXQ91iCN
 8wrpOaaHYNS+90sjV+NojDfwSIRv6o+Zy53kbNVQFGn1LNgxjbG9H79lYk1d5s4IxVOk
 Ds/ZZRqO4pscwg/zmSvFscRycccbiGGbo651Dzyw3RcNWXgnvFGgEwcZMdJGCv/k6lC8
 txL7yVMhRermhOFHzxuh3s30/EbFQPE4egjHl5yeVrLflOXpIl00KCN3zpbC54of2L1+
 JUy2OEPpqf2oJ65Ure4LofRtNRZLSs6jYwBkb5DGD+g+pzwHnK6LlK3h3BV1XpRsNPqi
 Ms6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928262; x=1717533062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODn/W9Q3dOBbNGA6DETDFah62NRsjBjYaUKDzhwUZZ0=;
 b=agT2TDmrWKmqcn4KP3YmvoxXSmP6ILzpxx28GLk5QzIeftI+e+LeI7SrmY+wh+JdVp
 rOhvZWeimXEOvSirx9A4ir7D+jyOhKGN0XPXJ9Kx5mj5S0uq+BQK0Os1fz1Pk1gEa1rz
 d4crSZRF3qc4gg6xsy1hb1gvOsUrV/MpPID3/FHFEj7moKI2MOMTozWuiGJp5k7JfCy8
 MAeyk/eLc7o6OoDzUPfjhmwXdg4M+Fem/IAYxqB53v7wueyNPDQjUcMIyRysz/WWNpsf
 8XiOJ7R0f+eJOTDk06/xYo3b2wk5dXK3otUvnzcTNIEyNFYmg+3KEjqzrYe0oCqYQqyV
 ovxQ==
X-Gm-Message-State: AOJu0YwSf1gGvFGMQrUGMiNs+YaTZemqw3OZgbifCnwRJhvm9FarcCz3
 lTr78uhSHWlUl7Aj96mgZiOTkt1zuWSShZuSn77O45UPcQWl6jyxwJczx9HX2EGZsXIFIQe4YFS
 +
X-Google-Smtp-Source: AGHT+IFumagAqBx/Cz2YNNavlLZO/xAu6CROCSw7GyEv9jPxfdrot5zp8gSpyRcFEg1YInGz+s74vw==
X-Received: by 2002:a05:6a00:8089:b0:6f3:f970:9f2a with SMTP id
 d2e1a72fcca58-6f8f2f754f4mr16843395b3a.10.1716928261843; 
 Tue, 28 May 2024 13:31:01 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 18/33] target/arm: Use TCG_COND_TSTNE in gen_cmtst_{i32,
 i64}
Date: Tue, 28 May 2024 13:30:29 -0700
Message-Id: <20240528203044.612851-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/gengvec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 6dc96269d5..e64ca02e0c 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -934,14 +934,12 @@ void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 /* CMTST : test is "if (X & Y != 0)". */
 static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_and_i32(d, a, b);
-    tcg_gen_negsetcond_i32(TCG_COND_NE, d, d, tcg_constant_i32(0));
+    tcg_gen_negsetcond_i32(TCG_COND_TSTNE, d, a, b);
 }
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_and_i64(d, a, b);
-    tcg_gen_negsetcond_i64(TCG_COND_NE, d, d, tcg_constant_i64(0));
+    tcg_gen_negsetcond_i64(TCG_COND_TSTNE, d, a, b);
 }
 
 static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-- 
2.34.1


