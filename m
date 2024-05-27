Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA7EC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZX-0007Qy-P7; Sun, 26 May 2024 20:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZA-00077j-QC
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:21 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ2-0003ak-V8
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:19 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-24cbb704135so926231fac.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771009; x=1717375809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6MuOwzw42ZKpRW8ddJXISHZONVvscEtylHvzBQmNeY=;
 b=MBFbXftdxlFqiIOHi5lW0QNjaa6GAGXU1+cMDvPWe+3hh7Z4CgENsvdMF90Mr+x+5q
 gpFt1movnF/cBZeXOLRUP+p3Nj8qNss3Hq0pmVsZFhqJTTprHZs683/gezTuWQr9WJh3
 QZ19E/ISP9v6Q1w79OVKbchOgjDxhaXB4Y5MrLdNH+iugB3FjDtNsV9TiY/iZsa+J98V
 S6ONzobbU4SAxweRKWQpDrIGHc1UalUBBL/o7scu3YMoeBjlIR31e+S254UXV99rXRGp
 C/Ux2cRvRYtDDNrWX0oCZ2byrbCJkQR2Bd4TjUhIE+Azd3eEim0gvoYbSAxm3Zhasdmo
 Fb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771009; x=1717375809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6MuOwzw42ZKpRW8ddJXISHZONVvscEtylHvzBQmNeY=;
 b=FnWywxZ9tkR7YrA0IodLE8EFBFdj4ST8O/1bkJy6klCyiWHUILqLhaazw372RGznhd
 2BEz82+PNrpHxbVwggVhDpg4HgMoU+CKHnLe2pVqf/bjr2bZgr2w6xHrG+xAgWEQ0jyj
 GEKwV0351g6HliOo9xkbw24/D629uG1C6N857yBoqsYwG508lPMEJeg/4POhyFOsDIJ7
 /na/M5sHbQ97+4EbGWNg8FT6J6YVpQFlJm7h9waeKn+LfTUezg4jKtGSyZz9qXFhXVB0
 Ajudm24kvL+pZuUrt/xF9NzBlVgH9JNZcWUYrNkW9b9g09L6gkXrQxg+3iUCBhNtbaVT
 xBxA==
X-Gm-Message-State: AOJu0YwuOIx2W8Ee2UiDe7JQhfodIAkLPt6gMc76/x80AwQG/Ji3expN
 D8WnsrUGGlNEGRkPNCtPKUO+jDCk5VNhEoSl/5/szfgiZK4f1XqZSUXowfHB5OXKJQxAox8/4fl
 D
X-Google-Smtp-Source: AGHT+IEVGgcz332xBGzplpAiAp+7II2zdoG7/iSHYml26Q/KHZzNvIIjgLpRrT2c/oCudOPS8jX9tg==
X-Received: by 2002:a05:6870:168f:b0:24c:adc0:ffa1 with SMTP id
 586e51a60fabf-24cadc101a0mr8631134fac.0.1716771009396; 
 Sun, 26 May 2024 17:50:09 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/28] tagret/i386: Convert do_fxsave, do_fxrstor to X86Access
Date: Sun, 26 May 2024 17:49:42 -0700
Message-Id: <20240527005001.642825-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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


