Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB34C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD105-0004Xq-HO; Fri, 31 May 2024 08:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zj-0004Oh-A0
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zf-0003Sf-2J
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4212e341818so5207905e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157060; x=1717761860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jDABOe5K9JMadz4HvqWDgF6LXkViQGX+kBYs/4LXF1I=;
 b=CcFtLIobKhOi+jHXCvVsUG8GfRjVHv0aeYLDpW2KPAeQc+48v3NiW5tyEeUcnUcL7S
 HJDCsYEI0ztSF/HhyPluOItXtLI8tDCYA3H/LqJJpLRI5jWUU2+3ktxD7IRmOPzpDHE5
 JLMsR5qJaoN+nu+RlJ22ElnktyECWjdYwoj1hhLxxFhLNu6uJonndon+5kyNu2x3reIT
 Y4xmQSIo9XZw/ZlguhBl0kn1puNqQhNBL2eF5CgbK1FKGSKZ1r9V6SVkGQow5IKkhSTh
 DnL/iNZVLXBAhI9T78FDrMc48vXi6IQQJaRkxi1pJfEEL6Udu/95gCsdb4YrftvnCL7e
 14zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157060; x=1717761860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDABOe5K9JMadz4HvqWDgF6LXkViQGX+kBYs/4LXF1I=;
 b=si9roPWvFCGLF0CmG+DvcJs3oHwCJPKtLqBPfUQmhe745tBIsKDAcTeNoyo6VJTPM6
 4cN219l/L9CC0cjDFg+H7+ltNGJbM1WLWI6Osw/HG629Uh9WGErP8U3BwgijQTS9ZUuG
 LiEL33m8FsU+OL7cqRtY9fKRPLf3YmD1Zi6hlR1ly9IauhyTqd5WdTEdpeO/x6FkDABa
 Iosm0M0rRbK0IE7wW68QeF47xY0iXbeLHGTsWZVCC205yUbigPqrKU14qEez68YlIHeW
 GLzNCUAqc0XmVFKfAHsy5F3iLDpDBnlz6nvhfRErWMCfyKLJ81i+NK/Sc1SyP+ZHg6Ae
 0lMw==
X-Gm-Message-State: AOJu0Yz72OARCvDP16S1oFyggnesg8A5OJrW2jyWAhjY+cMBwwY7quqJ
 nLkzByNz3F6NkaDAzFb4p+1CK6BDstGbZ+dIe/oWerXnKHdIGVhN4vTdnG7R2+bxhvOaKtTSc9k
 D
X-Google-Smtp-Source: AGHT+IGHXX6gNTw2yAX1HlmHushHIHJBAfikraKOMnUFwJX84Ys4OhGftIR1eyrs7T+AiP6uanMQ0g==
X-Received: by 2002:a05:600c:46cb:b0:41a:a521:9699 with SMTP id
 5b1f17b1804b1-4212e045342mr15661065e9.4.1717157060522; 
 Fri, 31 May 2024 05:04:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/43] target/arm: Use TCG_COND_TSTNE in gen_cmtst_vec
Date: Fri, 31 May 2024 13:03:42 +0100
Message-Id: <20240531120401.394550-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gengvec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index e64ca02e0c1..2451d23823f 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -944,9 +944,7 @@ void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 {
-    tcg_gen_and_vec(vece, d, a, b);
-    tcg_gen_dupi_vec(vece, a, 0);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
+    tcg_gen_cmp_vec(TCG_COND_TSTNE, vece, d, a, b);
 }
 
 void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-- 
2.34.1


