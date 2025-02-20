Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A194EC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Iq-0006fy-Gi; Thu, 20 Feb 2025 11:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Io-0006f6-Q4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Im-00089s-QB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439a2780b44so7529685e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068487; x=1740673287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jB2UFgD3gahxB9+AXRMer3XyJKB38VfWjr05bKCnF+Q=;
 b=ElTP32d+KKkqdEMd3LvYYwOGb6W4GlataZCLt4ZsGeAmuQEagw0+MtWqe8WO57hQxO
 I5Oki1wjK5p6KJwvKtKoCrGJCPY6BUlIdbFcgl70S4xscw4wOo3jaXmgtLc53j9msXgK
 JPhHvWr8V7be2ESTm1dryboI2xwi8CXOIXZSvf3rtiuuISC05fyW4Hy8xrnzaIafZmVZ
 qG6FSJtQiFFhrn1wt0h72+nV0TzvrNsmWf2Qh+6iQZcHGAGSaXn5Acnq3bYKR6m30a3N
 BmOn9Xf3t/QmUShHYsoJHMKeccrgX8QfnaIGS6Tr/Pn+MUBqSq4Ah9J2fFGREtWwEjsz
 SZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068487; x=1740673287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jB2UFgD3gahxB9+AXRMer3XyJKB38VfWjr05bKCnF+Q=;
 b=vRLScmo0H7T9+p/fcOKszUvRR/MhBxoVFLG+xge3N6HhhFasuwQ/TNhThen+Q/K6SE
 HLKKpizn72hhExypUzngpSBUT7ENcobN3Gh33C9GzXhfvoRVcSvnqEgkG9Fszz8wOKdN
 2IS0kqmWAz38vPVfhhboGl+/Oz2GcbW0bMjkDdzf8p9MX5+s63ygKA4S/fGRHEy3KCPt
 ZR65unIiJJPxB6I+KNNye0pt7cbjcN1BlIfQOssL+dNbk+kkHKugt8qL5QZIlJc2RozR
 pstFUExlBbec90OMLmPNWk5cSZEkgvMn3nMiNfL1yZZJOip5bXYEPKrk2yNrGLOkCEPN
 ZeWg==
X-Gm-Message-State: AOJu0YwIREWWtwdt3k7Vt5DnLKSMbwUuU4Jl++Xby3XsTjaDU1udtl5N
 YyfPJPSLiRQ0j0dGUp7cZ/mnBprcKs9G+leEM+kGCC8s7jJo5g3N+DjaMv+YZG5PixINtneOTc2
 v
X-Gm-Gg: ASbGnctI/b5Ky+6jPjv7tbEpr+GZFZa03//kGgfmhrh2V00fkpswykhSOIeVZysRhN4
 n7Eq3B0CMZ6h4pAf5K32AQOVa0Ai11da763520Wym+j/dSqw4ahVLYcLur47MVuyLSbQVkklrIg
 kNvqRLuEdPiqMJqyxqBYDZ1NerxussNyT3mMP6YgCZ53eRDccwA0KCQQSQ5M50FwlgolD4/u+fy
 2N70SzRFXXYLQjtzGkV3ngSTbIPYU5cFDuT5vC/OsZ5Wl37egsNp5MVwiE44Y3U2aZGftKN9D8j
 he8KrINlfxSy6YS8cnvoJw==
X-Google-Smtp-Source: AGHT+IEXK7GNikoePYVeAOwjVjx3LllgWRmUTEihB9l9YozHlyCE4QF11Xnb1q8Qy0lJ/MbWs062ow==
X-Received: by 2002:a05:600c:45ca:b0:439:967b:46f4 with SMTP id
 5b1f17b1804b1-43999ddb0c7mr67140615e9.26.1740068487379; 
 Thu, 20 Feb 2025 08:21:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] target/arm: Report correct syndrome for UNDEFINED AT ops
 with wrong NSE, NS
Date: Thu, 20 Feb 2025 16:20:43 +0000
Message-ID: <20250220162123.626941-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

R_NYXTL says that these AT insns should be UNDEFINED if they
would operate on an EL lower than EL3 and SCR_EL3.{NSE,NS} is
set to the Reserved {1, 0}. We were incorrectly reporting
them with the wrong syndrome; use CP_ACCESS_TRAP_UNCATEGORIZED
so they are reported as UNDEFINED.

Cc: qemu-stable@nongnu.org
Fixes: 1acd00ef1410 ("target/arm/helper: Check SCR_EL3.{NSE, NS} encoding for AT instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b7d6afe0a1a..9ed1a67b767 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3601,7 +3601,7 @@ static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
      * scr_write() ensures that the NSE bit is not set otherwise.
      */
     if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return CP_ACCESS_OK;
 }
-- 
2.43.0


