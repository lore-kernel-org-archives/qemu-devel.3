Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8709C7EE30
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83m-0007jZ-K4; Sat, 21 Jun 2025 19:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82a-00033d-Ay
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82Y-0005FG-Gy
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso1903304b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550069; x=1751154869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/7OhxwxTI+J3CoX3QJ26qMPrCZqWpt/X0hhzAA/4Uu4=;
 b=aYo/bg2f9sA0PkHQhz3zdrZAWE/YhT0N1oKsx/usyI/aRD57W/7x1gjNNtb2l9uExW
 Ve6ARsJqYu/Ov7mGJdEhq2ZSzJzMaiR6fUw83zFQtGiveyz3Z3krkqTUjGmTgc+lnJMx
 o2/ij0U2FWHypGKEy3e3ywPuhZQckJ41R0N++WZDO4gZt+EPMBUjrz66wpWYfAvAFL1Q
 cW+OCtGbzlAvsngQgpFMsnzVJfpMBmZMy/LFkIBcna/4yOcmI+SJLBk/cEUCbYFx1vo4
 tjJJTpiNYpQVoEdNBrcFjg5W5QlmYIZACEexnaJFySq+RN23PGVylBULtuMm8nyS9gq9
 2Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550069; x=1751154869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7OhxwxTI+J3CoX3QJ26qMPrCZqWpt/X0hhzAA/4Uu4=;
 b=FIP4+FiYpAMTSmtNbvwepY4nzCwjr/4NE7G3Jh7nZ0I6/WuXTEEuAc7Wqc66eF4DIF
 SgwoYy4jGhrk2UL6xegzzMJWkzAGSVopB8CDLEk1kwiw7xeba6Q3SIFssCDz+z5TB4Lk
 OB9rVN0To+vTA7SMVtIOo7VhBF9w+1hF7aOg6cFX0X0MzVOJ2GHVd/0HWmipcYrh/ebX
 3X/3VLZykixIty3Z9uUQXLNY9ViaUeqQEBFI5i8w5tq21E81PsEwTc0Qi84RxrqbhwFX
 UZjcSlbVjod2bXeV/pVlOYRAGqkBH/ye7+1nuqrcxaAaIEoO3Zc4sl91Ie0o10otKR85
 MxZQ==
X-Gm-Message-State: AOJu0Yy5EkpbTm8ugQngMAQOVY3YB88M+Ae22808DaDwyUMx+TlRstlq
 6R2vx5xHHpbR5DDKcbURpGLokyFA2xCi/YYrz0EjMpKNBkK53PqBu3R0H95jsND05GoNiVcfAqH
 mUV4hs1M=
X-Gm-Gg: ASbGnctrk789rcJFpRnwraaa1bdCWTR393seFAQ6hFy5/QvOaq2ZVY77soJD+QhqOpC
 gLbuP7Ey3hsIfBDoHtNnFlJr7XOWF4mcLgvrzwZRj2PYmLRreQenGfzdYiyeAikg/jGpV5CiAQ5
 3oFAB8tLFWw5SkMgYc2wwHfiXa7C/RpotXiIenZqFt1eGHX1F7cRTCnZBdMbG0P7EtLE5eadufe
 S2pDxVMtQNGMy8nfvh1h296RokxEyt312uQQsEE/kRHkEwaXz4IuDDJW+0JqmUd31NfjOFZavcO
 viY3jAgsIYAIQYkud9I5X2rwaVT3WjGm4yvToVAIzLR37dinwvnLwuwuanSZCRN8+OiY7eCfVY7
 CxoDXJQsi0QChtllbEuAidu2IQ6AlMTI=
X-Google-Smtp-Source: AGHT+IE823O5nv82BNQz2MMDXk1OStvWCd858j7KYWc7nKr6tynLBTrF7X6VMXHzc2wepNz9MtdbpA==
X-Received: by 2002:a05:6a00:140d:b0:73e:2d7a:8fc0 with SMTP id
 d2e1a72fcca58-7490d73f08emr9489403b3a.1.1750550069010; 
 Sat, 21 Jun 2025 16:54:29 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 079/101] target/arm: Enable PSEL for SVE2p1
Date: Sat, 21 Jun 2025 16:50:15 -0700
Message-ID: <20250621235037.74091-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

This instruction is present in both SME(1) and SVE2.1 extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 43993fd193..e6e2f342ab 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7261,7 +7261,7 @@ static bool trans_PSEL(DisasContext *s, arg_psel *a)
     TCGv_i64 tmp, didx, dbit;
     TCGv_ptr ptr;
 
-    if (!dc_isar_feature(aa64_sme, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve2p1, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
-- 
2.43.0


