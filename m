Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B5C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeIW-0000e7-Je; Fri, 24 May 2024 19:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHt-0007Oh-V5
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHh-0006tH-B2
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8e9870e72so1353994b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593109; x=1717197909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opsbeM2raunxCajavxAMAhO8CHOlNCLI/4hm0OSSpr8=;
 b=ERbOpDzHVVffVzQAfQJFFsjhUtlhzeGICqF76qHY12mLZ/NFode4tcy7ugC3Odcix+
 0mCBIQvVbdSP9/hGU84w4mysHK/7o67t7IibdGY6qm+NEa7I/GO3FPrCmumlPCap0PZv
 P4ODzdXrAyUqjaE2Xza92+qxQd+QIbLuW8Tiay6tAODKuP5cKAaVpzvwWq8y29eAx+6U
 CODjX+2yXS/u0M9BgJ5BrLjeohtqYh+T6pq76eQVonbasOm8EHOl+eniYDf4nqOXk76y
 BZrWwABCnA5dYjGu9C9cTl1FjQmh4i02YSsfwPiozKpJskO+abE9sHPJrwJv4NPx6Oxk
 +QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593109; x=1717197909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opsbeM2raunxCajavxAMAhO8CHOlNCLI/4hm0OSSpr8=;
 b=wWygkwZZCo5qB1TKEmyKs5YkUNWL3v982Bgh2MoO2kZalMtxmGlBc0LMNIxKcL00ey
 P+zvozGPI0PWKdBQ0SIDfc7uCWxALuLKxVHcaFhXxiECMOvMItqXJH+Wd2OVZJn3a0Jk
 vcwrNGmvCt5x3ZPS4/IeKK2iAEUWZ3uDzObNBMkTUTtHH7U6+39acJScc2DUmnQx7MiY
 HKt5hvFVglwedMPBvd1iKlm6Icl9N6bm/lHdTXEQwHEpPCrf4rdQ1LDeUgQ5b5QnXkkm
 9/9wJ/Ei2qbK6e0IY09p+46uEmlBLneQGxuXz6xI/jGpeAvhfnyQc71e9uUvn8O/M1zd
 PsQA==
X-Gm-Message-State: AOJu0YydsL3KGKv0qjpOv1GBzDFtNNJJfFJvC1PW4CQ/WoYPF2xZqdyJ
 4IWcs1gfiClIqyKETgdjSUa+/ke73yBleVKljM1x62vlD72xDP9ElVhGhI+VCxGSvmK6HsrU541
 y
X-Google-Smtp-Source: AGHT+IGPstgBCLZLFeLgoBVj5Odr5/p9nlkhTCTS0Ht30kHB5mN6XL/XDdBx3RD6jZZyKGF3tA+4TA==
X-Received: by 2002:a05:6a00:4c0b:b0:6f8:beb9:c0ba with SMTP id
 d2e1a72fcca58-6f8f45e47bamr5232863b3a.31.1716593108928; 
 Fri, 24 May 2024 16:25:08 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 52/67] target/arm: Use TCG_COND_TSTNE in gen_cmtst_{i32,
 i64}
Date: Fri, 24 May 2024 16:21:06 -0700
Message-Id: <20240524232121.284515-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/arm/tcg/gengvec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 51e66ccf5f..1d6bc6021d 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -933,14 +933,12 @@ void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
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


