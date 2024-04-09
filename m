Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC9EC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3e6-0003KW-F2; Tue, 09 Apr 2024 01:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3e3-0003Gh-2o
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:43 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3e1-0005Pm-C3
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:42 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c60019eecaso73220b6e.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639020; x=1713243820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GoHB33Bfj8uNurFePxqw98pp2Ot/UcwhxjflbY0n1tE=;
 b=rg5UeMKelVb+VYFki35FKnJSejyhrfAiOavh4hV5rzfgqDD8jETMYleaaQyAw3mJVi
 BoIa+4XeVNsVRTWz/rxrZEbxeNFrXiX48wdsJcWURfDo1gTskmX1G/knaP+9om9NWhjd
 iTuhz10YX0BUt/ak9oOybl8Fa2MODjQvRbWVSlF9pZ7ziwaUVq8j8dPVM7LpByiMq/2j
 m890oiqgoXVwM9+nDJnBXruAdObgsFRCNnoJdmlWKWcfy30ASWP62EKgSVARVIB9Ekcq
 okAD3WViSFlVWU4MPl2SEp0tlIdlIgh3pgjW4IA8KOwYTOoKTXeIvumOexCnQyK/4/CG
 vexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639020; x=1713243820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoHB33Bfj8uNurFePxqw98pp2Ot/UcwhxjflbY0n1tE=;
 b=P/UWIoavd8axhSxePNUuxULnezWfxUg8gwm5ezAXLMyHDzBKEtc1NKdQIYV2CkCtms
 jiJbJFrPQbb456/wGjcfpCa4lz/ioXIY7cPt8Gi9N5TTJBP4zj2UjAIT+MlJKqfqf0fD
 d4RwtVQMUM7/GxKgBYw2Wrm9n2fGvEZeFsgbu9JgIBhPSrZhJNFXEkcGOGS1zWcZHs+M
 2UdUTz0bHFRqL9Q/hl40yVsm5g0kk1b0SnZ946ZSqQMCBp8UHfVw6yS35TI9tv1ftRUW
 is3r8BJGqGGRZxcues8zaa+haTtzeP8QLcr5PBySPJb5i58uITOwLXaPy+5iBq4Z9t5r
 BeJg==
X-Gm-Message-State: AOJu0Yz6AaBkMjYuAUJRnDSyHzfJnXJ1t+XdPHF7KMc54rgNRBYZtfdz
 w/WXnRYiPJstGz3s68axfb62eXie/+m+iUpc9GhFHKym9ushi9zkGk2u/HvLg5+ugutcxIioo2i
 v
X-Google-Smtp-Source: AGHT+IH6TR2dEdiFOf17bUH31ONghCkGbi26ot/IMGO5L7rydNLUbKLe9W4qC4cBtbkTO8pfR1gZDg==
X-Received: by 2002:a05:6808:f02:b0:3c4:f52c:64d with SMTP id
 m2-20020a0568080f0200b003c4f52c064dmr12254553oiw.59.1712639020266; 
 Mon, 08 Apr 2024 22:03:40 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/28] target/i386: Pass host pointer and size to
 cpu_x86_{xsave, xrstor}
Date: Mon,  8 Apr 2024 19:03:02 -1000
Message-Id: <20240409050302.1523277-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

We have already validated the memory region in the course of
validating the signal frame.  No need to do it again within
the helper function.

In addition, return failure when the header contains invalid
xstate_bv.  The kernel handles this via exception handling
within XSTATE_OP within xrstor_from_user_sigframe.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            |  4 ++--
 linux-user/i386/signal.c     | 20 ++++++++++++--------
 target/i386/tcg/fpu_helper.c | 36 +++++++++++++++++++-----------------
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 35a8bf831f..21d905d669 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2236,8 +2236,8 @@ void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
 void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxsave(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxrstor(CPUX86State *s, void *host, size_t len);
-void cpu_x86_xsave(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
-void cpu_x86_xrstor(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
+void cpu_x86_xsave(CPUX86State *s, void *host, size_t len, uint64_t rbfm);
+bool cpu_x86_xrstor(CPUX86State *s, void *host, size_t len, uint64_t rbfm);
 
 /* cpu.c */
 void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index b823dee17f..d8803e7df3 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -325,7 +325,7 @@ static void xsave_sigcontext(CPUX86State *env,
 
     /* Zero the header, XSAVE *adds* features to an existing save state.  */
     memset(fxstate + 1, 0, sizeof(X86XSaveHeader));
-    cpu_x86_xsave(env, xstate_addr, env->xcr0);
+    cpu_x86_xsave(env, fxstate, fpend_addr - xstate_addr, env->xcr0);
 
     __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
     __put_user(extended_size, &sw->extended_size);
@@ -610,6 +610,8 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
     uint32_t magic1, magic2;
     uint32_t extended_size, xstate_size, min_size, max_size;
     uint64_t xfeatures;
+    void *xstate;
+    bool ok;
 
     switch (fpkind) {
     case FPSTATE_XSAVE:
@@ -640,8 +642,10 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
             return false;
         }
 
-        if (!access_ok(env_cpu(env), VERIFY_READ, fxstate_addr,
-                       xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE)) {
+        /* Re-lock the entire xstate area, with the extensions and magic. */
+        xstate = lock_user(VERIFY_READ, fxstate_addr,
+                           xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE, 1);
+        if (!xstate) {
             return false;
         }
 
@@ -651,15 +655,15 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
          * fpstate layout with out copying the extended state information
          * in the memory layout.
          */
-        if (get_user_u32(magic2, fxstate_addr + xstate_size)) {
-            return false;
-        }
+        magic2 = tswap32(*(uint32_t *)(xstate + xstate_size));
         if (magic2 != FP_XSTATE_MAGIC2) {
+            unlock_user(xstate, fxstate_addr, 0);
             break;
         }
 
-        cpu_x86_xrstor(env, fxstate_addr, xfeatures);
-        return true;
+        ok = cpu_x86_xrstor(env, xstate, xstate_size, xfeatures);
+        unlock_user(xstate, fxstate_addr, 0);
+        return ok;
 
     default:
         break;
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 1c2121c559..4ec0f3786f 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3064,42 +3064,44 @@ void cpu_x86_fxrstor(CPUX86State *env, void *host, size_t len)
     do_fxrstor(&ac, 0);
 }
 
-void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
+void cpu_x86_xsave(CPUX86State *env, void *host, size_t len, uint64_t rfbm)
 {
-    X86Access ac;
-    unsigned size;
+    X86Access ac = {
+        .haddr1 = host,
+        .env = env,
+    };
 
     /*
      * Since this is only called from user-level signal handling,
      * we should have done the job correctly there.
      */
     assert((rfbm & ~env->xcr0) == 0);
-    size = xsave_area_size(rfbm, false);
-
-    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, 0);
-    do_xsave_access(&ac, ptr, rfbm, get_xinuse(env), rfbm);
+    ac.size = xsave_area_size(rfbm, false);
+    assert(ac.size <= len);
+    do_xsave_access(&ac, 0, rfbm, get_xinuse(env), rfbm);
 }
 
-void cpu_x86_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
+bool cpu_x86_xrstor(CPUX86State *env, void *host, size_t len, uint64_t rfbm)
 {
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .env = env,
+    };
     uint64_t xstate_bv;
-    unsigned size;
 
     /*
      * Since this is only called from user-level signal handling,
      * we should have done the job correctly there.
      */
     assert((rfbm & ~env->xcr0) == 0);
-    size = xsave_area_size(rfbm, false);
-    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
+    ac.size = xsave_area_size(rfbm, false);
+    assert(ac.size <= len);
 
-    if (!valid_xrstor_header(&ac, &xstate_bv, ptr)) {
-        /* TODO: Report failure to caller. */
-        xstate_bv &= env->xcr0;
+    if (!valid_xrstor_header(&ac, &xstate_bv, 0)) {
+        return false;
     }
-
-    do_xrstor(&ac, ptr, rfbm, xstate_bv);
+    do_xrstor(&ac, 0, rfbm, xstate_bv);
+    return true;
 }
 #endif
 
-- 
2.34.1


