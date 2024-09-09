Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A5EECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBs-0004U9-Pn; Mon, 09 Sep 2024 13:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBm-00044L-2f
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBk-00060p-6R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7179802b91fso2826246b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902910; x=1726507710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PKG5YPQcXKyDHlspbxmEdeyLcXXv/kd5HUMAwRWwDA=;
 b=CyouL0zzfRpyKfcXmByisclRz+f10QcsTS9Oon1wE0OT9tZIQPKHMV7ddNHPmRRrKE
 RUF7CnX4ep2a9P0CzAU5gttE7Nu/mL74Uqsb4JncByo9ujo/AeT7d1g2iK++aayeMpM8
 C6qUKFWIqlX68IQW0AMJn21wG2TOAOclU05BTxWxwvelBw9rmhMBpWI7L5xpTTWAaDY+
 IlrtSJji8O3fnART0gpXEnA7Fo44IUluwjCmBNsBGG5UiYay8PaHSOB0paWn/6IKUpAQ
 Eur4Y7lIRXSz4DElGZcN0C2TtXeHuG8sKX0zqZnRGqRqM8ncuxWPQGsqE9vEe4vgd4ur
 bgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902910; x=1726507710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PKG5YPQcXKyDHlspbxmEdeyLcXXv/kd5HUMAwRWwDA=;
 b=D5tIsh4zGG1k43N3dsTOAXUw7YlEu/Jnl6p5nHVXbPHINzBZrHCfCQ9cZzWJ5UNp1W
 15+UaYyN9YepGgtV/TvdAf6XNA3XUgBktEhulFE8eT43nlO+9mHX+5Iep/e63h7A0ZkU
 tDoaGjHIYlSpXSD2aCK2gxLW95mFavJJobbQ8bG/ceI+v94n0ONaMiK22AZVs/eyKr6S
 op5/pHe8QSqWRKHzvQRUJZnrJGLG53m6tiJ6vpQWA0iT2gXSt0y3wT/pLaQBMQNTB9Ex
 aryd5aJko6gzNJFPt09IlsepNNehBvojWR6afttYRy7qSo2gpdOJFdPW+37hw4Hi5TJM
 m1Gw==
X-Gm-Message-State: AOJu0YwFRpzXBo71J/Izb/5R2J1tZwXjQwa/YvGyVBbCUWuD9D/eRIST
 uTKyDTqC9UI1T1rqdNVIlm1sf5saNb+iIh26n34AXikiwcE162iLaQBSEhje6RfV+wiN1PPcAhT
 E
X-Google-Smtp-Source: AGHT+IHutecmoihmbB3z3oZNyJKzDaDs70cg1mG2IGG9igYMnbvsijZx6h/66RlU2p50THw+quhEbg==
X-Received: by 2002:a05:6a21:39a:b0:1cf:3c60:b8dc with SMTP id
 adf61e73a8af0-1cf3c60ba63mr3525604637.34.1725902910095; 
 Mon, 09 Sep 2024 10:28:30 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 05/26] target/m68k: Update FPSR.EXC
Date: Mon,  9 Sep 2024 10:28:02 -0700
Message-ID: <20240909172823.649837-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

So far we've only been updating the AEXC byte.
Update the EXC byte as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/fpu_helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 56694418f2..0c8c14966d 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -170,7 +170,7 @@ void HELPER(update_fpsr)(CPUM68KState *env, FPReg *pval)
     floatx80 val = pval->d;
     int soft;
 
-    fpsr &= ~FPSR_CC_MASK;
+    fpsr &= ~(FPSR_CC_MASK | FPSR_EXC_MASK);
 
     if (floatx80_is_neg(val)) {
         fpsr |= FPSR_CC_N;
@@ -187,20 +187,22 @@ void HELPER(update_fpsr)(CPUM68KState *env, FPReg *pval)
     if (soft) {
         set_float_exception_flags(0, &env->fp_status);
 
-        if (soft & float_flag_invalid) {
-            fpsr |= FPSR_AEXP_IOP;
+        if (soft & float_flag_invalid_snan) {
+            fpsr |= FPSR_EXC_SNAN | FPSR_AEXP_IOP;
+        } else if (soft & float_flag_invalid) {
+            fpsr |= FPSR_EXC_OPERR | FPSR_AEXP_IOP;
         }
         if (soft & float_flag_overflow) {
-            fpsr |= FPSR_AEXP_OVFL;
+            fpsr |= FPSR_EXC_OVFL | FPSR_AEXP_OVFL;
         }
         if (soft & (float_flag_underflow | float_flag_output_denormal)) {
-            fpsr |= FPSR_AEXP_UNFL;
+            fpsr |= FPSR_EXC_UNFL | FPSR_AEXP_UNFL;
         }
         if (soft & float_flag_divbyzero) {
-            fpsr |= FPSR_AEXP_DZ;
+            fpsr |= FPSR_EXC_DZ | FPSR_AEXP_DZ;
         }
         if (soft & float_flag_inexact) {
-            fpsr |= FPSR_AEXC_INEX;
+            fpsr |= FPSR_EXC_INEX2 | FPSR_AEXC_INEX;
         }
     }
 
-- 
2.43.0


