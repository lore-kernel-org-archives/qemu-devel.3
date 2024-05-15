Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C84C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFd-0003xx-Ml; Wed, 15 May 2024 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFY-0003vg-9d
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFM-0002qU-OZ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4200ee78f34so31969215e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785727; x=1716390527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6MuOwzw42ZKpRW8ddJXISHZONVvscEtylHvzBQmNeY=;
 b=Rxd81C5PmnDnu/YTU3S89svF6GWAHRUfyrp2n1ijvLJUn8XAg1ydr9aqegSL3mqMXw
 nQyP/rcyimqLbP2fl6a67U3Pzi8r1TLI4VK6PLNd30mInfxdbymDBbVMIePgcpJc8fPV
 9Nnnqxi9kQIhtIdZC83omWS8IrIeW+yE2jEhhjKzOxEx45NECsJ/nCZEfL1bVMcudrH7
 CJQ+0W4gaqXEvjBqF71IV79ZVzvzm7M+m4oKdodVONXAv016yHF0pDq5yyIkl3t8e3QV
 xl+DwmZ+fW0r7s9pcaBFK9OfrgwhFB55842qCDDyo2/DSONMGdlXPA/VZyEYXhv8CqYI
 NWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785727; x=1716390527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6MuOwzw42ZKpRW8ddJXISHZONVvscEtylHvzBQmNeY=;
 b=saQSuTM7sYlFkjyH/3083nG+Yk/NVmsz4JBwD7zUg65LSwDUS5+dm1c5ZwWVpnrdQr
 8PV6tUUMjc7qtcceujAIfhLSscFbSzqh44QP4NOYTtzZWAjeoyW4fMJ0yIpLElx267WO
 kaMraBXMjbd+oBnouFUQlCueq8uqUgEkmA31PHKtBeT0pikHasVu8QtOjSf1NbwysgOt
 s2bvZ9QDcOS8U3ms+rM1OnPcPWOQi5NWY5Et0dUJupnFSsN5yMjb6b79Kj1Rp8gArSkv
 QtH1XxSmH+W5HhJGUwRwEF6G8T8O59kxOQi4nIcpnAOlMwTG8Aptg/Y9EGaeG3nScR6v
 gNQw==
X-Gm-Message-State: AOJu0Yzaoq9uqvBo+I8L7nCllW4zkd02M8WlVoeOPmD0nV68ejsPWVKf
 DJtG+OqOKeG2e/mJvurLG/KJXcfttkQbTF3jjmiffzUzMCXN+VTFhKxSh4/fN3MwQrbYckh4zB3
 ayk0=
X-Google-Smtp-Source: AGHT+IEp3G1tXqOSXeJVGG+W95HW28Kc2rqX7WtzaXffoi1a8hwFThnMtzJkCJGAeMnvcxziFftyJg==
X-Received: by 2002:a05:600c:3ca0:b0:41e:ae29:c807 with SMTP id
 5b1f17b1804b1-41feac59cbfmr105771755e9.29.1715785727184; 
 Wed, 15 May 2024 08:08:47 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 09/28] tagret/i386: Convert do_fxsave,
 do_fxrstor to X86Access
Date: Wed, 15 May 2024 17:08:18 +0200
Message-Id: <20240515150837.259747-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Move the alignment fault from do_* to helper_*, as it need
not apply to usage from within user-only signal handling.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 84 ++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f21cdb45ea..4dcb0b92ff 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2619,8 +2619,25 @@ static void do_xsave_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     cpu_stq_data_ra(env, ptr, env->pkru, ra);
 }
 
-static void do_fxsave(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_fxsave(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
+
+    do_xsave_fpu(ac, ptr);
+    if (env->cr[4] & CR4_OSFXSR_MASK) {
+        do_xsave_mxcsr(ac, ptr);
+        /* Fast FXSAVE leaves out the XMM registers */
+        if (!(env->efer & MSR_EFER_FFXSR)
+            || (env->hflags & HF_CPL_MASK)
+            || !(env->hflags & HF_LMA_MASK)) {
+            do_xsave_sse(ac, ptr);
+        }
+    }
+}
+
+void helper_fxsave(CPUX86State *env, target_ulong ptr)
+{
+    uintptr_t ra = GETPC();
     X86Access ac;
 
     /* The operand must be 16 byte aligned */
@@ -2630,22 +2647,7 @@ static void do_fxsave(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
                    MMU_DATA_STORE, ra);
-    do_xsave_fpu(&ac, ptr);
-
-    if (env->cr[4] & CR4_OSFXSR_MASK) {
-        do_xsave_mxcsr(&ac, ptr);
-        /* Fast FXSAVE leaves out the XMM registers */
-        if (!(env->efer & MSR_EFER_FFXSR)
-            || (env->hflags & HF_CPL_MASK)
-            || !(env->hflags & HF_LMA_MASK)) {
-            do_xsave_sse(&ac, ptr);
-        }
-    }
-}
-
-void helper_fxsave(CPUX86State *env, target_ulong ptr)
-{
-    do_fxsave(env, ptr, GETPC());
+    do_fxsave(&ac, ptr);
 }
 
 static uint64_t get_xinuse(CPUX86State *env)
@@ -2850,8 +2852,25 @@ static void do_xrstor_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     env->pkru = cpu_ldq_data_ra(env, ptr, ra);
 }
 
-static void do_fxrstor(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_fxrstor(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
+
+    do_xrstor_fpu(ac, ptr);
+    if (env->cr[4] & CR4_OSFXSR_MASK) {
+        do_xrstor_mxcsr(ac, ptr);
+        /* Fast FXRSTOR leaves out the XMM registers */
+        if (!(env->efer & MSR_EFER_FFXSR)
+            || (env->hflags & HF_CPL_MASK)
+            || !(env->hflags & HF_LMA_MASK)) {
+            do_xrstor_sse(ac, ptr);
+        }
+    }
+}
+
+void helper_fxrstor(CPUX86State *env, target_ulong ptr)
+{
+    uintptr_t ra = GETPC();
     X86Access ac;
 
     /* The operand must be 16 byte aligned */
@@ -2861,22 +2880,7 @@ static void do_fxrstor(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
                    MMU_DATA_LOAD, ra);
-    do_xrstor_fpu(&ac, ptr);
-
-    if (env->cr[4] & CR4_OSFXSR_MASK) {
-        do_xrstor_mxcsr(&ac, ptr);
-        /* Fast FXRSTOR leaves out the XMM registers */
-        if (!(env->efer & MSR_EFER_FFXSR)
-            || (env->hflags & HF_CPL_MASK)
-            || !(env->hflags & HF_LMA_MASK)) {
-            do_xrstor_sse(&ac, ptr);
-        }
-    }
-}
-
-void helper_fxrstor(CPUX86State *env, target_ulong ptr)
-{
-    do_fxrstor(env, ptr, GETPC());
+    do_fxrstor(&ac, ptr);
 }
 
 static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
@@ -3008,12 +3012,20 @@ void cpu_x86_frstor(CPUX86State *env, target_ulong ptr, int data32)
 
 void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
 {
-    do_fxsave(env, ptr, 0);
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_STORE, 0);
+    do_fxsave(&ac, ptr);
 }
 
 void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
 {
-    do_fxrstor(env, ptr, 0);
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_LOAD, 0);
+    do_fxrstor(&ac, ptr);
 }
 
 void cpu_x86_xsave(CPUX86State *env, target_ulong ptr)
-- 
2.34.1


