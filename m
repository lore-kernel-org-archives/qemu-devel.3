Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80140C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFO-0003rp-P9; Wed, 15 May 2024 11:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFN-0003qW-2R
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFK-0002pi-Jk
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-420116a6652so29815615e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785725; x=1716390525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qu8at7vOdb1WvbcdbtxhwbQTz1oNXGTTdYMgD98z5zw=;
 b=Qh1EWioZt62zrLR2ADmPa0MYokndM0q0NgvQN5GCZmvYMdQMnNlsL4KkOH4hyqNJ5W
 7qW/oGgAa9MkERKz5cnUwfp43ErS+UWx9+o1HsIWhZ2p+k3UMriWFQeXOQlXKP9k/oVS
 i7vjRYUhNDFQWEwCUHo58PjRNPHAStthw3TfyUHtXSk/bgiDUA6ga7052YlfXPI3XYIe
 eB+qUMPfyCTkGuwymB6iN3azFTUmslsjl5Y0JHN0bJMvRlSnujiOW0ASr0tUghbOF+ea
 eYSx696nUNLamJavfPBYCsWbPzG1D/3nUU6y54PxEdXVYSSmqmS1+aYU8NVYEbrRcsgF
 MKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785725; x=1716390525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qu8at7vOdb1WvbcdbtxhwbQTz1oNXGTTdYMgD98z5zw=;
 b=NTvPKL6YUbFSY6aZpuRE+wLnHnd9vKObd9A5VTNtOuGzP1/64v7emOtCnnomdHK8R3
 QmALua2ZKIcyi+h9K5SFpcNoETqW/BSq2u7dHKzRFuPh8x01f+yw+3qB0B2nIVFfIki8
 rh5R2GG6EVpfFTkWpya1A5UmveUhdmUbmsh+8oTDFO91VTKotp3KqP8mITlSwbajLTd7
 kLumL2Xpi6q4shZEGImEcabBfOQ+JAHja6ECc/CMHzVTbK7tV3aWBs3Gh/6SxlakkMMB
 qULjLhUJ7fQEo/iC0cn65qk4gNmM6y3qX8iRNT1Yb+S5LG8XImRPmR6hrfsiiqrX075C
 3QIw==
X-Gm-Message-State: AOJu0Ywet1idgMQpYcB9yS0AZt8WHE5EfajE2R+ubqA03cDLnmOeZUne
 PFsq/g4lMG4Q/ZWxYkUBJYd9ptRybkg5z/KTh/sMOWmPWbqSRSvgk356bt5ma+wOeT3TnHnwRn3
 r9ak=
X-Google-Smtp-Source: AGHT+IF+xAoSPYyRjgzqjZ4Z/QoEGgnFjrByDUNf34naFYO3D4NSrrU7HGkqh9dE87zwDVOxf/ObnQ==
X-Received: by 2002:a05:600c:1c9f:b0:41c:35c:2da7 with SMTP id
 5b1f17b1804b1-41feac551a0mr124557995e9.30.1715785725094; 
 Wed, 15 May 2024 08:08:45 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 06/28] target/i386: Convert do_fsave, do_frstor to X86Access
Date: Wed, 15 May 2024 17:08:15 +0200
Message-Id: <20240515150837.259747-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
 target/i386/tcg/fpu_helper.c | 60 ++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 01e9a1fbbf..df12eac71e 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2469,21 +2469,16 @@ void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
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
 
-    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_STORE, retaddr);
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
 
@@ -2492,23 +2487,22 @@ static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
 
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
@@ -2516,7 +2510,11 @@ static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
 
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
@@ -2972,12 +2970,20 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
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


