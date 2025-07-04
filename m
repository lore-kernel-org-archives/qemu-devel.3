Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14031C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhTn-00022V-Pp; Fri, 04 Jul 2025 10:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhMC-0004om-4T
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:45 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM8-0008D2-04
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:39 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-610db3f3f90so562092eaf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639134; x=1752243934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sorSqm7J6SLZ7V/7UMO5+5Rzi28tdsa7Du0nld/DrRI=;
 b=KN3aJTl4s0nZSXjMcuRVgEI2gG6nW6NGgDMEHcf/zLz65J0GiETA6KBZG8EBulE00g
 aIjGdCbPH58Y2mK8euEDZqwzx7citwF7ejAXyBTaSzyYmlOsIQWXT5jmUcnSl1oN4vjn
 8NPJFsNsiVPU1zaySl6aLxCZ1HkAEithheA1L72AxGYKT07Twy7tgDdE65vJKEbvKWM2
 0eWxVc6CJmLHeMr2BH2yk78D4Zo766sR3ZWj2itHnqH+lBZvGRWNotYSHP31I2mLuaeD
 WQIhT20agkHuiT3ySxiRZ+jpJ00DnGtung+Lo7VuOVEvcYHeMPpuAbPZ3mwCCSpoNSKZ
 GZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639134; x=1752243934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sorSqm7J6SLZ7V/7UMO5+5Rzi28tdsa7Du0nld/DrRI=;
 b=CtFNqwhWEvkSRhkOgpIxOoC3srZR9oQfcH+AbMiWfDVHqL74hcJ44bppaQKWIR4QWE
 sKZ6cHs/El4yUUFY3sNlrs/havUKvVvIIsDpmRWaViPCzZdaG5iJQdgFa/efZ1iSpexM
 mJzHeBIpLVEGKU5lsfWmg9g0V/fpFDFz4DfMMQwbuEuDugX+RifqXRrC2UK7lkXM2YMj
 F5IdDfBOB4br2Z4kV1ydr50CGNqTOGdgPCPCJnFXxarXYcAa4tqbQqy7Gsxc02kBFCLm
 T6RvUzjzDwKnyj9qHQUvNZhK0fkwA45Gyywmz2cNJtRyfw1XF516LN1VG5zcL1Zw5rfy
 G7tg==
X-Gm-Message-State: AOJu0YySML80UTav9LHQ+iUZhjoK7Ps9c1YHi4OmHI8p2qGwnSOt42gw
 gsYvgDyj+mN6Aw+38L2RNflWQsOG62SXULE1YQxzCkC9Q0ISGVaJbkpINtt4R4nHMZhpdlr5+5m
 FK67YSr4=
X-Gm-Gg: ASbGncvI+5qZ370n/5AMiLBX9g+15GS/nSMVLmyRj8A7S5Pjg9lgIz0d9bBMMpXHoKW
 b0hrVqsCc8XC39CaB0SwdkX25rCVIE+jQ8a0X0VHYgWWlcD9PpBn5DtAKG60RmXDuVgVyiJo788
 qj8ifZ7DjKnpjTfUDzC1XF/hjriteEcyL03hKg4rFo3TG00s/4oSCYHbfS9+xAmE4OuOpWk7hn+
 7Sjvd0fdTVlYZpCpaJ3toOFB/0Wi+hj0KZhe/wrqpBlHv++MphDXSCkW3aPCNnW9xU7mLI3H/oO
 +41rgzOsKYbrHLjs8FPY10w+zqvj/mSLCw9P+U89xqyLtCWxNAXMzpbgzvAq6gJK+L6VcLV4+Bg
 RwVnqa3Ygrr2wwFZlaugXIJkw5dLPKgPVD5+fWWy3m2R9AcXU
X-Google-Smtp-Source: AGHT+IFmyVqZVips0Frizfy9RziUG+Oalr5MK1MZeLYTM0wRR8N3Lg9bh60efQrof/ti/gKVcq9IdA==
X-Received: by 2002:a05:6820:907:b0:611:ffa0:3863 with SMTP id
 006d021491bc7-61390056a60mr2126308eaf.3.1751639134363; 
 Fri, 04 Jul 2025 07:25:34 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 077/108] target/arm: Enable PSEL for SVE2p1
Date: Fri,  4 Jul 2025 08:20:40 -0600
Message-ID: <20250704142112.1018902-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
This instruction is present in both SME(1) and SVE2.1 extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 62d3e2efd6..cb60b533e9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7273,7 +7273,7 @@ static bool trans_PSEL(DisasContext *s, arg_psel *a)
     TCGv_i64 tmp, didx, dbit;
     TCGv_ptr ptr;
 
-    if (!dc_isar_feature(aa64_sme, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve2p1, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
-- 
2.43.0


