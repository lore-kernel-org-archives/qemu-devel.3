Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ADBD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdidJ-0008W2-6y; Thu, 08 Jan 2026 00:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicI-0007oB-Cy
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:28 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicG-0005UF-OP
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:26 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so1832577b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850283; x=1768455083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RwZcEsWtXtRWsZkoGnAqaNmx6Eebey0NHBlG9Sj16ps=;
 b=yGSVw0wLrsFfaFiByNlO1HurxoNwxg8BgDuNAV6nJAbElH/Y89w0IN0VRJ7k2nU8Nh
 Er+0kFUBuyckg6KA4g8RzhmY7Y9jNOcs9LoTIpS0ettH9BrV4jRVFLLnaVlTr+McKqI2
 m8Sd/BfTPfeJPso+2hXDgzVX6GbF7ZnoZqoqc+Tvwg4oX81GHHWxs86LlJCBgniDnxtb
 srThC5A1MNfU6hFs0GbWzRtWqxFFxChU5js3Fyyri+ivBoOYLs5MeNEVpfeFPlWhHYl3
 103WKCU3WAYmwXc09Dmr4dNVMU1UfFiyFAGeNVi55zaL5lo61WScy81qmrlwelZKwt/s
 0ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850283; x=1768455083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RwZcEsWtXtRWsZkoGnAqaNmx6Eebey0NHBlG9Sj16ps=;
 b=stXHjALN/cmhbfE6sDwvszi6qe/ML4/mlz51w52iKyKydjTO4jJ2Dt6MgvI+qmFvNk
 89VyBXIkGieaIbLDei4C8EGPgd0VTEuq4qFtbU+Bss8qNCh8bXpkuPpxD6LXxmg9B7BV
 BZ5aWTn4TymNjdkOKkGxp2StWvAij7T2MS6Av+MZ86ygqF591bQF6RqX/YK5iDT9Bzrp
 Mbr3lDjw8VzkwUjYpZpaA7ehaXZQNec0Erc0hMsa87KX9PWKKGdyWROXU9kxf4hsua1a
 hISjp+9TFgKtFMaqF11dBcI8XTCns8mnOQmBauF9qJodAHUBhbYaIfQtBlUpZDhcZJcX
 NeFQ==
X-Gm-Message-State: AOJu0YwPntaMG4jfbAZtZbiuA+mY7dvq5PCAjWYx7qnOoV6ha0zpYpC/
 rmpnu2Is75LbiclUbA0jYvBoU2XcMj2KgNOrKmhV6rV7absDUHRRaT70qA6tUR/et/xX9vEfc4f
 rxM72qkE=
X-Gm-Gg: AY/fxX5TOK8QQkVzGES5/368AkhBUCL2Uwr+t7+85u2FOYeCgH1rWTRqk/DcmavdVKu
 v+mRNntGjQnnf5Kh6TRkAtGCyTX5uLUdU/3lb3QV35Q1hyCWQpTerbYbafYhymoncbXBpJZoQ0r
 NkGLd4Rc6eMi9aDN1JOOU+uz0OzQzcQyVJUX1y55hkcn+2vAuURtSTRahYnSlMTtP2AFA3mqdk6
 i077yoWysZHdSD4UOOnlLrFcobNwWuz3Lw1iE09R/oJz4omUGorD3t+VpxQJrI7q0mvAgOVJO4M
 cvhdqynb/V7CTLeaupzjBaFDFl1nHENX3oAqsr5SIhVhmEXUFA4mb89Peqf/FYeM3U9tR64RNhd
 g89jA4Iozg6aw1nvyFRgEGg1fH54+nTyo5wVXk5OMerxJ4npPcY+bqk03T0wNLEonpB5EfLTGem
 bNBoMOMCMQbfbRaDzIUA==
X-Google-Smtp-Source: AGHT+IHS8Elyu7Lvgccc2vdUcEb41nOw47Ppsn3Ct6yiBiWWkQpfGR/OqxbaEeXS89jcEVZA2Fz7Rg==
X-Received: by 2002:a05:6a20:9185:b0:366:14b2:310 with SMTP id
 adf61e73a8af0-3898f9db7cfmr4471318637.67.1767850283201; 
 Wed, 07 Jan 2026 21:31:23 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/50] tcg: Drop TCG_TARGET_REG_BITS test in tcg-has.h
Date: Thu,  8 Jan 2026 16:29:58 +1100
Message-ID: <20260108053018.626690-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 tcg/tcg-has.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 2fc0e50d20..27771dc7f0 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -9,11 +9,6 @@
 
 #include "tcg-target-has.h"
 
-#if TCG_TARGET_REG_BITS == 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#endif
-
 #if !defined(TCG_TARGET_HAS_v64) \
     && !defined(TCG_TARGET_HAS_v128) \
     && !defined(TCG_TARGET_HAS_v256)
-- 
2.43.0


