Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC4BC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFU-0003tw-3i; Wed, 15 May 2024 11:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFR-0003sm-1L
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFO-0002r6-NR
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4200ee78f35so32760365e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785729; x=1716390529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VUA0H1FqSwLKp/HJjCgFsX8ntjk+Qvs0JjKKwjJR0Q=;
 b=L8Ilm2h49TQ6ZdSlbGTEWjoeBaJR32Ny+tQ+M2jpgbzXU5XLCSJtincGC2NdFRoCFk
 HRD7Vnx3BNoveIlRQP94sktI/JRV5hxCLHYWd185nYNfqmbRjbJlmuOfnkSkIZSfPUc4
 MH9l+oz4UcLyhSAo7iIVjdUoLxJq+4vELbuS4gDXL3H5Il+X+TLOHH/D6N4gM65dIyzQ
 2B87PxgSE1EoOLjUSgeldlrjVIvJQwkUiRHcp9qNIzfCbiQb66U7f7BxIxl88TkFxalt
 rTDEQn6VZLTkqHHgk8wgd2OiqCZld45LIhWKvgIt0oScmNfI78MIaa7Ahr3MV1WJFzdx
 v3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785729; x=1716390529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VUA0H1FqSwLKp/HJjCgFsX8ntjk+Qvs0JjKKwjJR0Q=;
 b=DwaHWK8SR0cA3n5bWUT1Ng7S1HRA/gcZe1Kk1uQTFu0BGur5arXMMgDCfRm7wnPJLE
 LxUsmdwz5UznVoLAlFe/XlxgTf4ZQLHihpKdHuciPl8tU754K+sjQ2XHY+7BWpzqO5Pq
 iYasEmzppUGd/tj3Rd43BCnyUkq7x6QB5ErM4jL78AWbgXYD1Bnzgb5Xc6OSZpZxA3xQ
 m164TKbzkA9FFcWs3hmRmgMWGDrjQkTnk0aHn277Dq6SKXD21xZL/uj4tBTQT3iWivLT
 3aqypYu/oMwAVzP8Rkw4OVIAMbEJh9TC/5TjP/OLxqKx38QVVdIoAIOypx+MRvSR+bPJ
 zVpg==
X-Gm-Message-State: AOJu0YxWZzhFOhXAs3UPalvTKDk1u2uqGGteRu6Iy5/yMrWwJE4oeioP
 aFbCwOQeqNhXk0+maCZDmECyL6c0U5HWiEdTr848jnDGDSiOiWZ5JmN8dl4GZcOvhiWsqWNwWd7
 NC50=
X-Google-Smtp-Source: AGHT+IF9H8UyJNMafQ5TkDJbT8ZAG8j/6I6+egukiNyanao0Sp2ZAX0ym31ihnymhC2jnAuFehCBvw==
X-Received: by 2002:a05:600c:4f93:b0:416:7b2c:df0f with SMTP id
 5b1f17b1804b1-41fea931f13mr153183665e9.7.1715785729255; 
 Wed, 15 May 2024 08:08:49 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 12/28] target/i386: Split out do_xsave_chk
Date: Wed, 15 May 2024 17:08:21 +0200
Message-Id: <20240515150837.259747-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

This path is not required by user-only, and can in fact
be shared between xsave and xrstor.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 51 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 7796688514..6a319dadf2 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2675,16 +2675,6 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     X86Access ac;
     unsigned size;
 
-    /* The OS must have enabled XSAVE.  */
-    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
-        raise_exception_ra(env, EXCP06_ILLOP, ra);
-    }
-
-    /* The operand must be 64 byte aligned.  */
-    if (ptr & 63) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
     /* Never save anything not enabled by XCR0.  */
     rfbm &= env->xcr0;
     opt &= rfbm;
@@ -2721,15 +2711,35 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     access_stq(&ac, ptr + XO(header.xstate_bv), new_bv);
 }
 
+static void do_xsave_chk(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+{
+    /* The OS must have enabled XSAVE.  */
+    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
+        raise_exception_ra(env, EXCP06_ILLOP, ra);
+    }
+
+    /* The operand must be 64 byte aligned.  */
+    if (ptr & 63) {
+        raise_exception_ra(env, EXCP0D_GPF, ra);
+    }
+}
+
 void helper_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, GETPC());
+    uintptr_t ra = GETPC();
+
+    do_xsave_chk(env, ptr, ra);
+    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, ra);
 }
 
 void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    uint64_t inuse = get_xinuse(env);
-    do_xsave(env, ptr, rfbm, inuse, inuse, GETPC());
+    uintptr_t ra = GETPC();
+    uint64_t inuse;
+
+    do_xsave_chk(env, ptr, ra);
+    inuse = get_xinuse(env);
+    do_xsave(env, ptr, rfbm, inuse, inuse, ra);
 }
 
 static void do_xrstor_fpu(X86Access *ac, target_ulong ptr)
@@ -2900,16 +2910,6 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 
     rfbm &= env->xcr0;
 
-    /* The OS must have enabled XSAVE.  */
-    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
-        raise_exception_ra(env, EXCP06_ILLOP, ra);
-    }
-
-    /* The operand must be 64 byte aligned.  */
-    if (ptr & 63) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
     size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
     access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
 
@@ -3004,7 +3004,10 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 
 void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xrstor(env, ptr, rfbm, GETPC());
+    uintptr_t ra = GETPC();
+
+    do_xsave_chk(env, ptr, ra);
+    do_xrstor(env, ptr, rfbm, ra);
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.34.1


