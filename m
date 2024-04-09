Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F31DC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dr-0003CW-3O; Tue, 09 Apr 2024 01:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dp-0003CD-S7
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:29 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dn-0005Jf-Vd
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ead4093f85so4257062b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639006; x=1713243806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sAutoO51T8yiouPWosWlBYNCYdh90GN9jDKu8ChGAKw=;
 b=ulDFlVIZ77FV+0lanQXRDy9fpzQC4QcXNhKnNt0MTC3FxlZcoKz0dX+FdReUIwZtF6
 rXeGZJiuKP0VWMQcXrVChcan4DK4gutPoQH62t7W4P4c+b35Uof7fds4mcMIw4bxYBl7
 RilMKU+4uo7YxczC1jwF9nzxFcIJwCR3gryeBWtjLVrqLRp+2DH1+SDue2OOKJIdFjjo
 G4E74Ljize9OMrM/0wW2YYHjg4QR2fT68fCCGhQ7ukkbBElQw7T9grOawgkZllJovEPs
 T6jZqxmMgPXy/yGku8J1kBrMXgQ7FPszlQpgWa/vxz4UgPMPlTMasznRL1+FyxtNjpAK
 XAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639006; x=1713243806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAutoO51T8yiouPWosWlBYNCYdh90GN9jDKu8ChGAKw=;
 b=Vw1dirOUdvZ57Xmmth/3GJ6m3/Dlq2srZ5ZAyiq6Mdhc+VpzlFolMz1x4P1NmvmnVG
 gTdhBhhngPjLIy8RlcBl4d9TcxwVhvVZW9WWrHGAwzrK5MC1CXfz2yjWBlTsZ22TLE0y
 88JE35apqb1+5SeRf+giiuY6lhAvcp61trI6MukPN/WIegTmLAprcPVmqZFN1qGydJGs
 BCl3/4j3mSzHgP8HakiobEi5jP9lHz3tTNCGCOU2yryo4pXaTAJFmKGu0efbP6C2GNr9
 OYiDeGo0kPuuViAj+KTxnWEhTXnEMnsI/XDO0sI63pz8JH6d5n+t9DCcKh4vfKs0BxaM
 TXXA==
X-Gm-Message-State: AOJu0YznabxMBbA4KBa3/4KfmLFpDjz5FlEuzpQlsqkZo+GjEbVgbmrk
 W3QCUMomWWUb7t2fF4R3OXS1oxMIhey+UDQ/dAV1Im4H4vWK86YNcau5KHKvmblF71aakrYIJg9
 Y
X-Google-Smtp-Source: AGHT+IEux2BI+qVzXiRaftveK3LDZM2uXnsuxx7Fs7kipE720yBNuqcWTPNI+F2MNAuX6e8IzTcjDw==
X-Received: by 2002:a05:6a00:2191:b0:6ed:5f66:602 with SMTP id
 h17-20020a056a00219100b006ed5f660602mr2923950pfi.9.1712639006439; 
 Mon, 08 Apr 2024 22:03:26 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/28] linux-user/i386: Replace target_fpstate_fxsave with
 X86LegacyXSaveArea
Date: Mon,  8 Apr 2024 19:02:51 -1000
Message-Id: <20240409050302.1523277-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Use the structure definition from target/i386/cpu.h.
The only minor quirk is re-casting the sw_reserved
area to the OS specific struct target_fpx_sw_bytes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 71 +++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index a4748b743d..ed98b4d073 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -33,16 +33,6 @@ struct target_fpreg {
     uint16_t exponent;
 };
 
-struct target_fpxreg {
-    uint16_t significand[4];
-    uint16_t exponent;
-    uint16_t padding[3];
-};
-
-struct target_xmmreg {
-    uint32_t element[4];
-};
-
 struct target_fpx_sw_bytes {
     uint32_t magic1;
     uint32_t extended_size;
@@ -52,25 +42,6 @@ struct target_fpx_sw_bytes {
 };
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
-struct target_fpstate_fxsave {
-    /* FXSAVE format */
-    uint16_t cw;
-    uint16_t sw;
-    uint16_t twd;
-    uint16_t fop;
-    uint64_t rip;
-    uint64_t rdp;
-    uint32_t mxcsr;
-    uint32_t mxcsr_mask;
-    uint32_t st_space[32];
-    uint32_t xmm_space[64];
-    uint32_t hw_reserved[12];
-    struct target_fpx_sw_bytes sw_reserved;
-};
-#define TARGET_FXSAVE_SIZE   sizeof(struct target_fpstate_fxsave)
-QEMU_BUILD_BUG_ON(TARGET_FXSAVE_SIZE != 512);
-QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_fxsave, sw_reserved) != 464);
-
 struct target_fpstate_32 {
     /* Regular FPU environment */
     uint32_t cw;
@@ -83,7 +54,7 @@ struct target_fpstate_32 {
     struct target_fpreg st[8];
     uint16_t  status;
     uint16_t  magic;          /* 0xffff = regular FPU data only */
-    struct target_fpstate_fxsave fxsave;
+    X86LegacyXSaveArea fxsave;
 };
 
 /*
@@ -96,7 +67,7 @@ QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxsave) & 15);
 # define target_fpstate target_fpstate_32
 # define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxsave)
 #else
-# define target_fpstate target_fpstate_fxsave
+# define target_fpstate X86LegacyXSaveArea
 # define TARGET_FPSTATE_FXSAVE_OFFSET 0
 #endif
 
@@ -240,15 +211,17 @@ struct rt_sigframe {
  * Set up a signal frame.
  */
 
-static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxsave,
+static void xsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
                              abi_ulong fxsave_addr)
 {
+    struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
+
     if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
         /* fxsave_addr must be 16 byte aligned for fxsave */
         assert(!(fxsave_addr & 0xf));
 
         cpu_x86_fxsave(env, fxsave_addr);
-        __put_user(0, &fxsave->sw_reserved.magic1);
+        __put_user(0, &sw->magic1);
     } else {
         uint32_t xstate_size = xsave_area_size(env->xcr0, false);
 
@@ -266,10 +239,10 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         /* Zero the header, XSAVE *adds* features to an existing save state.  */
         memset(fxsave + 1, 0, sizeof(X86XSaveHeader));
         cpu_x86_xsave(env, fxsave_addr, -1);
-        __put_user(TARGET_FP_XSTATE_MAGIC1, &fxsave->sw_reserved.magic1);
-        __put_user(extended_size, &fxsave->sw_reserved.extended_size);
-        __put_user(env->xcr0, &fxsave->sw_reserved.xfeatures);
-        __put_user(xstate_size, &fxsave->sw_reserved.xstate_size);
+        __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
+        __put_user(extended_size, &sw->extended_size);
+        __put_user(env->xcr0, &sw->xfeatures);
+        __put_user(xstate_size, &sw->xstate_size);
         __put_user(TARGET_FP_XSTATE_MAGIC2,
                    (uint32_t *)((void *)fxsave + xstate_size));
     }
@@ -383,9 +356,9 @@ get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t fxsave_offset
     }
 
     if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
-        return (esp - (fxsave_offset + TARGET_FXSAVE_SIZE)) & -8ul;
+        return (esp - (fxsave_offset + sizeof(X86LegacyXSaveArea))) & -8ul;
     } else if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
-        return ((esp - TARGET_FXSAVE_SIZE) & -16ul) - fxsave_offset;
+        return ((esp - sizeof(X86LegacyXSaveArea)) & -16ul) - fxsave_offset;
     } else {
         size_t xstate_size =
                xsave_area_size(env->xcr0, false) + TARGET_FP_XSTATE_MAGIC2_SIZE;
@@ -551,21 +524,29 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxsave,
+static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
                              abi_ulong fxsave_addr)
 {
+    struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
+
     if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
-        uint32_t extended_size = tswapl(fxsave->sw_reserved.extended_size);
-        uint32_t xstate_size = tswapl(fxsave->sw_reserved.xstate_size);
+        uint32_t magic1 = tswapl(sw->magic1);
+        uint32_t extended_size = tswapl(sw->extended_size);
+        uint32_t xstate_size = tswapl(sw->xstate_size);
+        uint32_t minimum_size = (TARGET_FPSTATE_FXSAVE_OFFSET
+                                 + TARGET_FP_XSTATE_MAGIC2_SIZE
+                                 + xstate_size);
+        uint32_t magic2;
 
         /* Linux checks MAGIC2 using xstate_size, not extended_size.  */
-        if (tswapl(fxsave->sw_reserved.magic1) == TARGET_FP_XSTATE_MAGIC1 &&
-            extended_size >= TARGET_FPSTATE_FXSAVE_OFFSET + xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE) {
+        if (magic1 == TARGET_FP_XSTATE_MAGIC1
+            && extended_size >= minimum_size) {
             if (!access_ok(env_cpu(env), VERIFY_READ, fxsave_addr,
                            extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
                 return 1;
             }
-            if (tswapl(*(uint32_t *)((void *)fxsave + xstate_size)) == TARGET_FP_XSTATE_MAGIC2) {
+            magic2 = tswapl(*(uint32_t *)((void *)fxsave + xstate_size));
+            if (magic2 == TARGET_FP_XSTATE_MAGIC2) {
                 cpu_x86_xrstor(env, fxsave_addr, -1);
                 return 0;
             }
-- 
2.34.1


