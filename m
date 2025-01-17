Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF33C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1v-00040f-87; Fri, 17 Jan 2025 13:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1r-0003vn-24
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:11 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1o-0007qR-LF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:10 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166f1e589cso61668765ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138306; x=1737743106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnf+fSHWEdd4ca8fA4cnMkUUnEWFBlmFUk49aGQ3+K8=;
 b=IpmKkgKLR2vFAsKu/K6k/E2dhPhCNpeCYl7wbpdiMyAbAxCxkDlkjH1BAoETWYngol
 MF/PUBovCubPiF4vn+wKauGH3qNtzI3M6TBUrVxCZGLYLzNk4qUwB4GWtd7IPPvVMLyK
 703s88SZlr2I2jeaofhCRHdOniwMRpCC0IRgfIg49C3EQxRo5Zl7GJBa+WLs/EQ0KVZX
 aIfTwnWOh+PyrON6X1b9ZUQe0SuzaEszPmHW/3b6FnJfww8ip6dK5ZDPmHB7UGAFKIrs
 PdpBh+1Vqdlcqfjuj/+olEUIJhhpynsshLCgImd32ptzY1ECDElciXh07SmyHId1VPyW
 48dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138306; x=1737743106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnf+fSHWEdd4ca8fA4cnMkUUnEWFBlmFUk49aGQ3+K8=;
 b=m6omyI0eTh92vT5bvW51xM2n4r5TzEerxTeSQWRTpOXSyWr5EYmrp69Yc+nT2jlfPg
 rhyCfF24WWDkKw//VMhs95dAZhYMgDL1xRicFFKOCOq4O5Rd9i4Nnd8PkCv5POKYqfmZ
 x/BYatmsPOxKxJlWDd8w/PX3k7kvScm3B+3pxYcutSjjMj/pKV1Mqkt8mM4szcXzn/3+
 e2y+X4vRYumcoHCLb397SftqW+fQyn2lDe5qBgJJDJa6IbWW6VdT57K5MDLXtaRTrTHO
 z14GaKcXsnuYRw8w08cdsmii4qhQIPLTzyol8YpPAOsh9pZhR7j29HJkqdvxkehDXRYe
 xxGQ==
X-Gm-Message-State: AOJu0Yxa6EsPh9swiUzc58If3A580+jIWpa8m18/6OCwZO/DFqnkJKcO
 jRQipGKOb1TFTQqHSghzaIm9Wm64URlaUKyVCRWPADXFuctVKyAImFITEBDhpbQsx+UZUtOHa2G
 R
X-Gm-Gg: ASbGncvpdurIkI+blGWqe3ukQ19EP8DuammPCOhlc7gadIu/9J6M1f9FTQPqpqrKyv9
 C09nf2Ef8PKBFIWSCr8AVawSsdE3fr5ZcGK5gWYEMRRktWqPYqX3790VeIA4gyyBPL1yqR5Gq2m
 4uWFKRx1eeF9C3jL6cKFBcAzD6tTmHNF9iFd+UMsN/SDdfl4IyqVUi+2dQ9gRdAlTvCbfI1r6Cg
 OQsQbcKzHE3L6XhzPz8sudqJ4tzLZm5+0gy5hCzyeyMPQv1Gq225RPdPtc2gK2jjZXlZ/XCprWu
 wQrNMxBXugT4LeU=
X-Google-Smtp-Source: AGHT+IFXYHhBWQUXtsh9lWmYPnXAacdDlCjTPEuxROC/eLPx7m1P6jRnYsqfMf/nPkKVxRpYq23oOQ==
X-Received: by 2002:a17:902:e546:b0:216:281f:820d with SMTP id
 d9443c01a7336-21c3553b6famr64540975ad.11.1737138306206; 
 Fri, 17 Jan 2025 10:25:06 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/68] target/i386: Remove TCG_TARGET_extract_tl_valid
Date: Fri, 17 Jan 2025 10:24:00 -0800
Message-ID: <20250117182456.2077110-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

This macro is unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 785ff63f2a..ab416627b7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -26,11 +26,9 @@
 #ifdef TARGET_X86_64
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
 #define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i64_valid
 #else
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
 #define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i32_valid
 #endif
 
 #define MMX_OFFSET(reg)                        \
-- 
2.43.0


