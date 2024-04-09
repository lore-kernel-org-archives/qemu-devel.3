Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA9FCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dd-00037r-QU; Tue, 09 Apr 2024 01:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dc-00037M-B5
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:16 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3da-0005EP-KG
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so3483635b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638993; x=1713243793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eh7OtO5x8MRpHpQMvxE89QnFoiPmlYi26LFAKoMr5Dg=;
 b=wzjEoodvMruifXDvp6NWS6chqrAXoBp0rCntuLQtEg2TAcjb2Rsk4j7ALS9yquPucR
 53oWQ00OZ4HF3nV7RCd6J+ZXN8hG+2RedrHvOZsqi8Tv2ajvkGLXEKPqAFuov/1kA1ND
 d2wbwgEOaKaY0wwk0B3JquWWtKpBUSgmy32RfQIOzz8hTYTFj+eFLcjE6k/R2rYCzYKO
 U0jUVqyqoAPFAGv9n8Jp/KtgHPerqk102fM4/1WhhggnNZiHCnZ2r9y0Mj81unKQN6qQ
 MwLdGp1E5Y1XS8bX+Z09Nt17N5l/f+tva/TaeYawv22+EOAiyQrTsSfrpXOGr64RX5L8
 RY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638993; x=1713243793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eh7OtO5x8MRpHpQMvxE89QnFoiPmlYi26LFAKoMr5Dg=;
 b=tMNZFjozwGhinS1edV/JySNWBDDNPDdnobIVPlntA0F8q1WJxrOUDo3mCk7ykOtBZN
 PvFrXP03K1p2ENtSq4u68hWDvVq9Vs4w04Ktn4UcPcnx0RLa22psosprEiiYITu0XJ+0
 uMNvNyIwUQDFuqY+YyLx4fast9tcNPqgykbpO+mVV+PVsitDnTtj69qovxoxq7elhK5Y
 /ORvqONkHMci3OH4KbyauztElEFw1r0n6FewDWjSH7MPTedMcXMYXCQsiyIX2f6Bbh88
 H7bsiEOs8cSHdTcFh7s1SzRSqU32ChmNkFeD7i2r0LFRoWNk19H1kJmtIH1LexAnoKcj
 YuDQ==
X-Gm-Message-State: AOJu0YxZA/gT1K193Z0B4DAlIhMb7R/WAd2UzFwLFS/YQtb9O4MZ365r
 wdp9uhsISGkWAmCEwG+I706zWrL4mTRZCoqcBV9BSw1nM1Xp63guGaOGSj8W1X/BJtA6YERmsLQ
 P
X-Google-Smtp-Source: AGHT+IEQ4HFBF6G5Va2IIh1PjIDjrKvS5rFiioM5979FI4udt065g4ehGllonCOpl5sLpslO5Yo/NQ==
X-Received: by 2002:a05:6a20:431c:b0:1a7:a6f3:1822 with SMTP id
 h28-20020a056a20431c00b001a7a6f31822mr1107931pzk.12.1712638992770; 
 Mon, 08 Apr 2024 22:03:12 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/28] target/i386: Convert do_fsave, do_frstor to X86Access
Date: Mon,  8 Apr 2024 19:02:40 -1000
Message-Id: <20240409050302.1523277-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 60 ++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 25074af0ce..e6fa161aa0 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2468,21 +2468,16 @@ void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
     do_fldenv(&ac, ptr, data32);
 }
 
-static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
-                     uintptr_t retaddr)
+static void do_fsave(X86Access *ac, target_ulong ptr, int data32)
 {
-    X86Access ac;
-    floatx80 tmp;
-    int i, envsize = 14 << data32;
+    CPUX86State *env = ac->env;
 
-    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_STORE, GETPC());
+    do_fstenv(ac, ptr, data32);
+    ptr += 14 << data32;
 
-    do_fstenv(&ac, ptr, data32);
-    ptr += envsize;
-
-    for (i = 0; i < 8; i++) {
-        tmp = ST(i);
-        do_fstt(&ac, ptr, tmp);
+    for (int i = 0; i < 8; i++) {
+        floatx80 tmp = ST(i);
+        do_fstt(ac, ptr, tmp);
         ptr += 10;
     }
 
@@ -2491,23 +2486,22 @@ static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
 
 void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fsave(env, ptr, data32, GETPC());
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, GETPC());
+    do_fsave(&ac, ptr, data32);
 }
 
-static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
-                      uintptr_t retaddr)
+static void do_frstor(X86Access *ac, target_ulong ptr, int data32)
 {
-    X86Access ac;
-    floatx80 tmp;
-    int i, envsize = 14 << data32;
+    CPUX86State *env = ac->env;
 
-    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_LOAD, retaddr);
+    do_fldenv(ac, ptr, data32);
+    ptr += 14 << data32;
 
-    do_fldenv(&ac, ptr, data32);
-    ptr += envsize;
-
-    for (i = 0; i < 8; i++) {
-        tmp = do_fldt(&ac, ptr);
+    for (int i = 0; i < 8; i++) {
+        floatx80 tmp = do_fldt(ac, ptr);
         ST(i) = tmp;
         ptr += 10;
     }
@@ -2515,7 +2509,11 @@ static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
 
 void helper_frstor(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_frstor(env, ptr, data32, GETPC());
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, GETPC());
+    do_frstor(&ac, ptr, data32);
 }
 
 #define XO(X)  offsetof(X86XSaveArea, X)
@@ -2971,12 +2969,20 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 #if defined(CONFIG_USER_ONLY)
 void cpu_x86_fsave(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fsave(env, ptr, data32, 0);
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, 0);
+    do_fsave(&ac, ptr, data32);
 }
 
 void cpu_x86_frstor(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_frstor(env, ptr, data32, 0);
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
+    do_frstor(&ac, ptr, data32);
 }
 
 void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
-- 
2.34.1


