Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28457C25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZk-0007o0-Py; Sun, 26 May 2024 20:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZO-0007IF-AF
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZK-0003jD-27
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:33 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-681953ad4f2so2008869a12.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771025; x=1717375825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKJkFZRwEV4YZxjsRrsydfwYbnWmnSukOPtEYS8mQtY=;
 b=y9mj+An+h+3lx1rDl6dgpPsx+8O4KNrEed/SXgXeTeWVAJtO/CcTwqKc66yviPVSSI
 k+AIQS/mKk2snZDgMEJRUJEDYHktetCPWUAtDlI7wZI0rxod1BT0sBSS2YZyGl5xXEoc
 hr9vUziGQqjtDcu6OF9UggRK7NtZsmXORxNklF1vIpFPic+57uVOcIMAos1vg2MTHpL2
 spFdyFncqjaxp+SC1VNXMsLr6D7gYDKdTdQyyhlJto7RLeK6qFTDMCwrzDdYiYUJDHAD
 hoHGFOskSNm/labfZSwloNiMS8cdsNNrXQJOUPEMBOPKvbqEK2AONU/T+PvEtqPp2umD
 F5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771025; x=1717375825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKJkFZRwEV4YZxjsRrsydfwYbnWmnSukOPtEYS8mQtY=;
 b=F73WKWRl3ATwEw8lzXRBfabR/C6ZnPPJgVEuLmpaPecSKkwFLIxxzAen80TOyWB+XD
 P6MGQP0EqAXtUbg/oPxwiEZcqyOBCwTbLKZStwGrbFrbKhvUb4CVNiTvhSTDVhoAknVy
 Ejcu4BRMHsVJPVNbgouRhFtiSwwcUJQVDphmuqp9JVAq7sgJS/41jJxL/j1k9Ehm9Kc6
 jgfuDYnZtLG1LO64b74YzunKEY2oSsUFw8bcFN4N+C8m+/lvoPyxahBFYxgvC6TEVKaV
 /1xDqjjKqYtGokG1D0W5pPKve5IsYtofL1RMf3OaVIUnHU6pAK2d1NFb6JgRnWWtTonp
 faBw==
X-Gm-Message-State: AOJu0YwEwWGRNPm9mFSC8QI426cOGBP7nbSNgOy9ijtXip5lG1HUZIyP
 C0cmWxfB2ygwuspsLFAJOpXsyCOMl51HIYOOLdjIHrLUOje0odyNVDzVa2d8Z+rY7er1eP2iO6v
 R
X-Google-Smtp-Source: AGHT+IHUWKxBuzjHK2YT6HdTVDoAzzKhy0+KTLFltt57G/haxlmnMJQSCpSx41FlWmrOzFDqifPbHQ==
X-Received: by 2002:a05:6a20:72a6:b0:1af:f64c:b795 with SMTP id
 adf61e73a8af0-1b212d398c4mr9292045637.30.1716771025557; 
 Sun, 26 May 2024 17:50:25 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 28/28] target/i386: Pass host pointer and size to
 cpu_x86_{xsave, xrstor}
Date: Sun, 26 May 2024 17:50:01 -0700
Message-Id: <20240527005001.642825-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
index 257cd5a617..c64ef0c1a2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2275,8 +2275,8 @@ void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
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
index 2e2972002b..cb90711834 100644
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
         if (magic2 != TARGET_FP_XSTATE_MAGIC2) {
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


