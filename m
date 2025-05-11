Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1195C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP2-0003A3-Ab; Sun, 11 May 2025 16:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOw-0002eb-4W
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:58 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOu-0006Kz-Gi
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:57 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30a93117e1bso5100499a91.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995755; x=1747600555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UxEDBljyfqsOJ/6sF4OYF0K5MA05WdNFxTdb/zwknQ=;
 b=hqr8ohCm+cQIV3g+wUlHqT/xM+yjsf9PNFd8OVltyjOfdjdkdSUXVQsEIFWMRGIdiY
 EBM7Et2LAPz2i5D2DXK6Y03eNyBlPlEei9+zzTCHLnaF9mrIm2o3w2HlwO2jlbnKI/gy
 eaZobzoKg8qo7+UUF9njY2dSHrjXiHVBcEpMHS/49+kYcD10ncFmWDPqDcWpVzLqE5QJ
 3g6mT/N1GldX37ufSLE4Si/pGfeEluLyVBmkwNq4e6s7oAFNGGUu5o5ZsxVepZe6Ke0h
 AS6QTzbt35Tdo4kJLjdIiVZtG5fik1ehMPrTYoRTrMSq/ApwIXlwH+B+eTUB+UpDcL3G
 yRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995755; x=1747600555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UxEDBljyfqsOJ/6sF4OYF0K5MA05WdNFxTdb/zwknQ=;
 b=pqT7q+KSEtm37u+BkGlPjni10mIGrjTJ2HQLmbSJAHNvtd2nfx3+Y1fyAC7cFdqaUj
 K/tMCr2voOnI3VBpELdqbRXgWUQHFFNqLIO3PGh8LQZJi2wuDqV7oJVXZHkkj/Sc/n24
 n+6oP4unRMuwl8qgv9ygiI7+9EbJOlbQxnNv9vOukIIotAZMZyKo2DfW7MM8bAblqSj8
 taQl1rvgcZlGe5MQojl3/LMDLIWPTf0w+GJALWnQKvbM1OEgaW7/AGpjUhQ3pd4OlNoG
 59Ha4AbSNYqTCAqNgsCaOH5/fFtVFmoUJ7cIdCH9nhzESXQrsapD2jjWkvqF80NLzPRD
 K52A==
X-Gm-Message-State: AOJu0Yy0YFqnyCy3QN2VCgWTveaHEyQ2Hua6/+HezeN1u8oxMJt7Rz7v
 TAbgVwZzEC6GvXpkkDo7X+3/vsGiCUoptDwqFbg6uTGky7srHE8vEOzNe91hucKC5Yq+xcFhUvz
 +
X-Gm-Gg: ASbGnctSDnGrZtc6ku1yyHM+h++bIISbspv8SWRAzuPGFwstmMQO45bNFo/e+/UOWlR
 UYB5QKkkICqjvPl87ZvKYIqADesxfre7BmWgCvzEOVXbpC41yOVFiEd5RV4uUEwsK+zqqygcxEU
 0Q8ZyZvYQeiY/iAhEMSbcMAvEV9XsMQHd3FKZDqyZEXjbTsidwQNFLZUz+KYSBg+PqRX8hmiEhH
 M6uD5vZASvGldVwhOra/B+dYSzxCVYoLyOoLa6xxAl7B5xpS1Zcg3QazL7mw/wyR0Mrle2F5h7E
 HApWc1pw0fE5DAU00krb2CMVInJJyN+UKN2ayvKRmwZ5xw/wi+ncNNOaiBmhHw+Hb1McdmpUG9S
 V2SXj3U0uaw==
X-Google-Smtp-Source: AGHT+IGxcPMJgMcJye/f1uRQKFTkFGTdGL4Et1kt+5cCo1KgtvvFT0PzAYoeXLMwLp28E7poA4uk5w==
X-Received: by 2002:a17:902:ced0:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-22fc8b339a8mr183093355ad.22.1746995754861; 
 Sun, 11 May 2025 13:35:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	schwab@linux-m68k.org
Subject: [PATCH v6 09/24] target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
Date: Sun, 11 May 2025 13:35:31 -0700
Message-ID: <20250511203546.139788-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

For LEA and PEA, while the manual says "size = (long)", it also says
that the pre-decrement and post-increment addressing modes are illegal.
For JMP, the manual says "unsized".  OS_UNSIZED is the way to signal
gen_lea_mode to reject those addressing modes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f87eff3b10..b6d46c3bdb 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2561,7 +2561,7 @@ DISAS_INSN(lea)
     TCGv tmp;
 
     reg = AREG(insn, 9);
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2658,7 +2658,7 @@ DISAS_INSN(pea)
 {
     TCGv tmp;
 
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2909,7 +2909,7 @@ DISAS_INSN(jump)
      * Load the target address first to ensure correct exception
      * behavior.
      */
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
-- 
2.43.0


