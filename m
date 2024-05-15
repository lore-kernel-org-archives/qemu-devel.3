Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1B3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFj-00040t-Br; Wed, 15 May 2024 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003wB-Lu
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFT-00030R-78
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42016c8daa7so22484795e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785734; x=1716390534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+kCzCPFmRVWagKLDLCR1Cq5shqRDzyNhJ9IIrqSVUo=;
 b=yWTHJrvR4XCgjkZkGcBWNWV9OrlG309DhNPNtWAQu9dpZlnBYnUbt+oVf8CX6ygsSj
 d6mIcY8fSzhDbVDMfrnFfKJtZ0s9uoWFZqV7Oa/bAcSEZSI7v/LOiXhauAldZPQHj0r9
 gVa7Mmak0cwA371FRbUtSO4suHzxygRC8hizZR0PzLV5C/Q5ud00xoKLg9XVoGxHfbzX
 nHSOPJHUYNpln44OUJ0CWCkcWQbSil0fp3RlY/mvxHnypUBUBOPlayYaGVWsdS9OV6iN
 /AUv+iCbWggGoG++JsiNTmWsPzijyCdCi20rjsEPOkPxkYkFU9nvwSaDtYux82es9zOx
 4UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785734; x=1716390534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+kCzCPFmRVWagKLDLCR1Cq5shqRDzyNhJ9IIrqSVUo=;
 b=wBVaENg5iKj31cEFm1yKmU7JjeKK1aTmZG9m/rWAaAvFuGWQAAuF96X7KLoJvtGjEK
 XnGgkLcyHKnXVettUvoYpWBlSJslKszpwkgC5UVj2pA9xR3kvDAZo73QWPaPmScBYn+0
 //VeRI7XIeImO+7z3QG9C/f80NsskZLNiagOoIXrGBT4Li0Ddz9y/4sMnAR2rssHeKNs
 VkTQS4g6KVfdZrvBSS+Z/Xw512KP9Cnfh3MFbomPu2hVxHTVQIy+ilg68NL64sVPYQbE
 LZbJt4ZFeHiVfVwaZvQXiM1LaLUOkwO+B2Quy+9tco98qOX9LEXBj3NQXEcIk0n7Knr0
 HCbg==
X-Gm-Message-State: AOJu0YxAtwjlUbMauAHwYXcbIAKGE++4Yp/kWKpGep32LdDnNbjPsg4Y
 ewQv2z2GMRnUgT3sUL5HS2feJvso3sP7kj68obGG9lIBFyonW/uPKCfiWoFS8Pb5rJOD9Fi5DbJ
 XUw4=
X-Google-Smtp-Source: AGHT+IFOO2ohKeAzfTgeFmdpqLEFlI4XKSARllOPVtH5erR+9F28N2SJ5Y/hVbHJosSfqDlKRqHNgg==
X-Received: by 2002:a05:600c:3c85:b0:419:d841:d318 with SMTP id
 5b1f17b1804b1-41feac59e6dmr104160995e9.29.1715785733930; 
 Wed, 15 May 2024 08:08:53 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 18/28] linux-user/i386: Split out struct target_fregs_state
Date: Wed, 15 May 2024 17:08:27 +0200
Message-Id: <20240515150837.259747-19-richard.henderson@linaro.org>
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 5b1c570bff..3271ebd333 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -34,6 +34,23 @@ struct target_fpreg {
     uint16_t exponent;
 };
 
+/* Legacy x87 fpu state format for FSAVE/FRESTOR. */
+struct target_fregs_state {
+    uint32_t cwd;
+    uint32_t swd;
+    uint32_t twd;
+    uint32_t fip;
+    uint32_t fcs;
+    uint32_t foo;
+    uint32_t fos;
+    struct target_fpreg st[8];
+
+    /* Software status information [not touched by FSAVE]. */
+    uint16_t status;
+    uint16_t magic;   /* 0xffff: FPU data only, 0x0000: FXSR FPU data */
+};
+QEMU_BUILD_BUG_ON(sizeof(struct target_fregs_state) != 32 + 80);
+
 struct target_fpx_sw_bytes {
     uint32_t magic1;
     uint32_t extended_size;
@@ -44,29 +61,19 @@ struct target_fpx_sw_bytes {
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
 struct target_fpstate_32 {
-    /* Regular FPU environment */
-    uint32_t cw;
-    uint32_t sw;
-    uint32_t tag;
-    uint32_t ipoff;
-    uint32_t cssel;
-    uint32_t dataoff;
-    uint32_t datasel;
-    struct target_fpreg st[8];
-    uint16_t  status;
-    uint16_t  magic;          /* 0xffff = regular FPU data only */
-    X86LegacyXSaveArea fxsave;
+    struct target_fregs_state fpstate;
+    X86LegacyXSaveArea fxstate;
 };
 
 /*
  * For simplicity, setup_frame aligns struct target_fpstate_32 to
  * 16 bytes, so ensure that the FXSAVE area is also aligned.
  */
-QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxsave) & 15);
+QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxstate) & 15);
 
 #ifndef TARGET_X86_64
 # define target_fpstate target_fpstate_32
-# define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxsave)
+# define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxstate)
 #else
 # define target_fpstate X86LegacyXSaveArea
 # define TARGET_FPSTATE_FXSAVE_OFFSET 0
@@ -279,15 +286,15 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     __put_user(env->segs[R_SS].selector, (unsigned int *)&sc->ss);
 
     cpu_x86_fsave(env, fpstate_addr, 1);
-    fpstate->status = fpstate->sw;
+    fpstate->fpstate.status = fpstate->fpstate.swd;
     if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
         magic = 0xffff;
     } else {
-        xsave_sigcontext(env, &fpstate->fxsave,
+        xsave_sigcontext(env, &fpstate->fxstate,
                          fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
         magic = 0;
     }
-    __put_user(magic, &fpstate->magic);
+    __put_user(magic, &fpstate->fpstate.magic);
 #else
     __put_user(env->regs[R_EDI], &sc->rdi);
     __put_user(env->regs[R_ESI], &sc->rsi);
@@ -623,7 +630,7 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
             cpu_x86_frstor(env, fpstate_addr, 1);
             err = 0;
         } else {
-            err = xrstor_sigcontext(env, &fpstate->fxsave,
+            err = xrstor_sigcontext(env, &fpstate->fxstate,
                                     fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
         }
 #else
-- 
2.34.1


