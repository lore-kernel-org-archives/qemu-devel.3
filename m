Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB0EC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFg-0003z2-Gx; Wed, 15 May 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFe-0003yK-Dc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:06 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003FQ-J3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:06 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e3b1b6e9d1so84606281fa.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785741; x=1716390541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+CU/PYG3Ilvn330jaFlX5AWHx4UTtAJ5ukJPjIH0Y8=;
 b=pkTPHOLfKLB4MxKAivC5zdAlJOkgKjoaBKWrArp3kPEhSX/tgyq86+y51etz+oj+AW
 GbeHDWNef9f1Kbxvk+yOlPqXRIpfjM6VR6GLEcKQ856Z27LQ1+aI39B41uZTTY+RsGs+
 +7XGEYdtY+yCBel0TiyEBjJsljvODzEamO8mwYQ7+EpKJ9oShtdK/H1RJI4WqpzQZyle
 GncAeInWwluTR86ADcr8YkceE7nDCZH83NalJ36uB03Vk47ZW1z3gdTUO5NftE0lJIOJ
 TZSYci/wMwsn+qJCE5pWs71yfdHX7Gkfm+cNEtTI3FJjnsI/Sy5P6PJXIVU4AcyyvEvL
 8GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785741; x=1716390541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+CU/PYG3Ilvn330jaFlX5AWHx4UTtAJ5ukJPjIH0Y8=;
 b=ABWOlIjPPWqM1/FIH/Rzh8jqB0nzZOYP4h2/XTTxAJCa7uFWgTvGq/hTxJI55RnaJW
 ZvEvvnarzlhYWma9u4LNPASCjDh6hheWUu0LllC0VxSx7dG1L2tot2kXeW1BbhgAbCrO
 47as9f6hh2MyFygVSz3lMpjTsNgM1nTjKQAnmFmLeexd+mplrkv8Dal8PSfpahfZaaMD
 YAbQCyvOxErnp16qZ9olwnOvLaBamEWwTQ4nSPkpz98W6cTF4Yo/u5hkG5igotM4tHXe
 8FqIX5zdbtuIsoUWlrU8mO0P79+/VPa1JHQzHvyi+oWtY6ge/tcXhQfhWY4nCWL7GUza
 SYVA==
X-Gm-Message-State: AOJu0Yy0O6HG2E/seSjIJpBcsmHF1v+C7OphdY0UqGrXPT8RNgUBtm87
 eOxi79uArkZaxZkg2CWfoyHvLTueo3U5Y3C9qOJvTtASga5hgNzZK3tRKa23uBX8Rb901a4TzUV
 BCgY=
X-Google-Smtp-Source: AGHT+IGBUWB3HzXgxlaYj6vWRMMQ9GCDYt3DCmqjPEX61VarJn9vpJMSqngrZy6+HhpwjBaleJ24AQ==
X-Received: by 2002:a2e:602:0:b0:2e5:3ea9:8d26 with SMTP id
 38308e7fff4ca-2e53ea98d95mr83114021fa.45.1715785741552; 
 Wed, 15 May 2024 08:09:01 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:09:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 28/28] target/i386: Pass host pointer and size to
 cpu_x86_{xsave, xrstor}
Date: Wed, 15 May 2024 17:08:37 +0200
Message-Id: <20240515150837.259747-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x232.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            |  4 ++--
 linux-user/i386/signal.c     | 20 ++++++++++++--------
 target/i386/tcg/fpu_helper.c | 36 +++++++++++++++++++-----------------
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dbd91c064d..df75f4c2b1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2245,8 +2245,8 @@ void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
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
index 1f5a3e9a0b..16f6d17345 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -326,7 +326,7 @@ static void xsave_sigcontext(CPUX86State *env,
 
     /* Zero the header, XSAVE *adds* features to an existing save state.  */
     memset(fxstate + 1, 0, sizeof(X86XSaveHeader));
-    cpu_x86_xsave(env, xstate_addr, env->xcr0);
+    cpu_x86_xsave(env, fxstate, fpend_addr - xstate_addr, env->xcr0);
 
     __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
     __put_user(extended_size, &sw->extended_size);
@@ -611,6 +611,8 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
     uint32_t magic1, magic2;
     uint32_t extended_size, xstate_size, min_size, max_size;
     uint64_t xfeatures;
+    void *xstate;
+    bool ok;
 
     switch (fpkind) {
     case FPSTATE_XSAVE:
@@ -641,8 +643,10 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
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
 
@@ -652,15 +656,15 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
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
index 0e5368951f..c17eaaa22b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3065,42 +3065,44 @@ void cpu_x86_fxrstor(CPUX86State *env, void *host, size_t len)
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


