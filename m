Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A76C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4w-0006CN-Lf; Wed, 07 May 2025 17:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4k-00068X-EG
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4h-0006C3-OT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso441768b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652386; x=1747257186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIvXrHcg71Zxao4OnBZBdLddOM/XHAwRxf7Qh2NnRSQ=;
 b=x6UTs173Zsg+PyAW7Gq+KApfI5/CoV8rgHHOhkxh186zlX+j1JqOE4MluSfriSqUSX
 R8LImXYlx2ba6NvwvL2VD3GoXuqcS1+sgyWVWJAjimSvENQd8OGWM4QcFyIMqJNX+5km
 0TmkP332+pjgC2JzHmjKkBOt+JIHRXPA5DvXpqeY4BU7euvYQoJ34iBiK+uqUplIQcCm
 ANbX7tc5Dkpm4AhRcYb9p725/bOApvea/NbecWl6Tb7oqLzoAWWhwyHkjdCOQ3ZiPxw1
 4C54mHVzrKa61ba8Y4/1vTUifsWatKUZeBG49beNAMmTthSXyLgEh6z+ELoTKkSSTT8e
 603w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652386; x=1747257186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIvXrHcg71Zxao4OnBZBdLddOM/XHAwRxf7Qh2NnRSQ=;
 b=tqs5FhnFLqhIrcgZd7C0Wttio9V9EHQPA4CnlhtHqTDxxIkM16ZpRevq7Mw/bntnRB
 34GW6cvc7xHY2nHvGq5IqY/fI6V4/n+HhtyYWrkCmQHNUzFBsDZsv8PDfiQnAfpj1Xcm
 vE1uZUrCr/wyZ+xog2I96wGX7UiBUfeCQBXVoCY1z/4yoEx4yliDe4PDfVt9GIaXKJu0
 wQlZKEL7gV7My83sSiaXCaJ+gBaLAslY+oh0k6FM2l+c/8LwRNgSpwyLWRqREJvfrjmE
 A50U32i0B5l0fQCvUHOIVTmoLajw7Sfe9Opb73ISq9OnKZk/tsgXMEtbxUIpRuD0uMY7
 8F+A==
X-Gm-Message-State: AOJu0YxzTDki1AXlv4MQYCfS39Wyd2D7Fm6ltm9wkWk8FhY9qNbi7FwU
 264GaDN2jwHr26+pOgkeDO4ftlBACGTJuQIGq5zqClSPWyzAfcJd7OHdVCxPNp0exAtlcJ2Aa8W
 4
X-Gm-Gg: ASbGnctICzxlvUCziaNF+MtNMcy3ltKdEABCwFTieefCLmpQ/KxnjCyeL24bMJF/5if
 diNuG8HGs6EqA2bqzs0xCTw8NmyBD0WKSH29kazEmtZ7Y1pG5MaYQGyV75avLavMRq8tQVEIQcy
 7cqx1aPUSa2vbkUUgVHxBat+UpPg1QNfY1FIteALszx1SoEl3H4TliVBR6DXZH38qTs3C/kzO96
 jF/O0IH77xTme47O8oJCbR2YUjV/YGH4jaagrLd8wreUzNUrGYTUsEyMN4umQgkYx/bZLQ54BfD
 olG3By9br1YjdYx1wTFvzz/+sGnFscXpmSlZCCPgo7Ooeyk4+UQARF1/jY9F+zk0W1iHQeWu7Au
 I+rV+ZlWftg==
X-Google-Smtp-Source: AGHT+IGK9ZZNU2vHyKqGTp/0VgQf0BUI3E/xlBtqr+1LNFKjnAxmzfSatpSpj5QunAs5HGlN6ujNlQ==
X-Received: by 2002:a05:6a21:3946:b0:1f0:e42e:fb1d with SMTP id
 adf61e73a8af0-2148d312247mr7721982637.36.1746652386230; 
 Wed, 07 May 2025 14:13:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v5 05/24] target/m68k: Update FPSR for FMOVECR
Date: Wed,  7 May 2025 14:12:40 -0700
Message-ID: <20250507211300.9735-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

This instruction sets CC and EXC bits just like any other.
So far we do not properly emulate inexact for the various
rom entries, but we can certainly update CC correctly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index deae94b0ee..e63fd3ec11 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -425,6 +425,7 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
 void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
 {
     val->d = fpu_rom[offset];
+    HELPER(ftst)(env, val);
 }
 
 typedef int (*float_access)(CPUM68KState *env, uint32_t addr, FPReg *fp,
-- 
2.43.0


