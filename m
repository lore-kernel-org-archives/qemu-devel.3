Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754A7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFO-0003rN-E9; Wed, 15 May 2024 11:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFL-0003q5-0n
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFH-0002l6-Ew
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4201986d60aso21043035e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785720; x=1716390520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlnBqdWRAdGOIDkFc78uZlpVYy9Rupt5PRiXjMOq17M=;
 b=M2gEPD10Oiza2L1ULqUV5CbXdkPh2UaSrQUhcPWJz3mdNMZxSCUufEAHCn0KK8UPTs
 f6Vbyw5VG0wojwWAteRnzGsDC1edrikgqSKNkO8HG5FQ5Yo4pQuFGVJPB6SxUZhtH/i8
 DnWqC3QTKoi7dSJpvJgRk62acPI8Uaz/nKvdrKMKYTIHnp3bptz/pjZLQVc4giyIlFqI
 2zfgsjE4eN0Ns84TPoDfNDmDdRATyU/ZTz5m6sMLQjZLgav9Is8xnjpv1Shb9SDunbkP
 6ailq18Pn5l3ev/lXu2r9OAmVIi4JoW/wlS0+QG6zMRGsfLLOa+tdlVaEiyEtrIRr93G
 ENEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785720; x=1716390520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlnBqdWRAdGOIDkFc78uZlpVYy9Rupt5PRiXjMOq17M=;
 b=HbZRQSNLfryLFgPwKA8ZAXYi09FQOYMe0TG0ePVLGYkj6U9IBxwNG5KNw7Edk3P0XL
 a6r1sHGFFHHVApFO6sSZKxuTJKnf8bwIS6zFcbA2wwmdA+byQN74vcZHxKe/ZMUo2gZI
 7W8mH2nvwIoVUF5L8mS/R0HasnyqfzwI9Z4tvg5kvUItpfkQU/tRP6CsnDYfK3V21lDL
 5sqBiHTh0VNU0TBO70VW3pig6V4RnuLQC0h8KNEwGYEaglZkN+J1XIfqnMy+W//2egGd
 zxhUTXltTOCU6nkaHbQUqAwctR/+yV1M6zMrVNwOz9BLE1Rrp5miLOhbwGlW/X3iJ7So
 ekqA==
X-Gm-Message-State: AOJu0YxLooXid6ZUh8x6KpBNVP6V/Bie2s34mDADtvPHX2UWrWIkXk7Q
 t4Rmn1yyXSjEpXXdXCK+VdHbFnDs5SLR0jbGvy+HpXWkalLAbrH5KBrLIAC4Z41RTWwl8PA4zTD
 uRFo=
X-Google-Smtp-Source: AGHT+IFSccWaiv48tpYp9hPJqawE46kJveEjFq25Q2nPgHkiOOTp/yx2I6Hn9wWjGhU5vsiMbvmnjA==
X-Received: by 2002:a05:600c:3548:b0:41a:9a6a:41e1 with SMTP id
 5b1f17b1804b1-41feac5a3c3mr103312585e9.29.1715785720182; 
 Wed, 15 May 2024 08:08:40 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 02/28] target/i386: Convert do_fldt, do_fstt to X86Access
Date: Wed, 15 May 2024 17:08:11 +0200
Message-Id: <20240515150837.259747-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
 target/i386/tcg/fpu_helper.c | 44 +++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index ece22a3553..1662643a8f 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -27,6 +27,7 @@
 #include "fpu/softfloat.h"
 #include "fpu/softfloat-macros.h"
 #include "helper-tcg.h"
+#include "access.h"
 
 /* float macros */
 #define FT0    (env->ft0)
@@ -84,23 +85,22 @@ static inline void fpop(CPUX86State *env)
     env->fpstt = (env->fpstt + 1) & 7;
 }
 
-static floatx80 do_fldt(CPUX86State *env, target_ulong ptr, uintptr_t retaddr)
+static floatx80 do_fldt(X86Access *ac, target_ulong ptr)
 {
     CPU_LDoubleU temp;
 
-    temp.l.lower = cpu_ldq_data_ra(env, ptr, retaddr);
-    temp.l.upper = cpu_lduw_data_ra(env, ptr + 8, retaddr);
+    temp.l.lower = access_ldq(ac, ptr);
+    temp.l.upper = access_ldw(ac, ptr + 8);
     return temp.d;
 }
 
-static void do_fstt(CPUX86State *env, floatx80 f, target_ulong ptr,
-                    uintptr_t retaddr)
+static void do_fstt(X86Access *ac, target_ulong ptr, floatx80 f)
 {
     CPU_LDoubleU temp;
 
     temp.d = f;
-    cpu_stq_data_ra(env, ptr, temp.l.lower, retaddr);
-    cpu_stw_data_ra(env, ptr + 8, temp.l.upper, retaddr);
+    access_stq(ac, ptr, temp.l.lower);
+    access_stw(ac, ptr + 8, temp.l.upper);
 }
 
 /* x87 FPU helpers */
@@ -382,16 +382,22 @@ int64_t helper_fisttll_ST0(CPUX86State *env)
 void helper_fldt_ST0(CPUX86State *env, target_ulong ptr)
 {
     int new_fpstt;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_LOAD, GETPC());
 
     new_fpstt = (env->fpstt - 1) & 7;
-    env->fpregs[new_fpstt].d = do_fldt(env, ptr, GETPC());
+    env->fpregs[new_fpstt].d = do_fldt(&ac, ptr);
     env->fpstt = new_fpstt;
     env->fptags[new_fpstt] = 0; /* validate stack entry */
 }
 
 void helper_fstt_ST0(CPUX86State *env, target_ulong ptr)
 {
-    do_fstt(env, ST0, ptr, GETPC());
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 10, MMU_DATA_STORE, GETPC());
+    do_fstt(&ac, ptr, ST0);
 }
 
 void helper_fpush(CPUX86State *env)
@@ -2460,15 +2466,18 @@ void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
 static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
                      uintptr_t retaddr)
 {
+    X86Access ac;
     floatx80 tmp;
     int i;
 
     do_fstenv(env, ptr, data32, retaddr);
 
     ptr += (target_ulong)14 << data32;
+    access_prepare(&ac, env, ptr, 80, MMU_DATA_STORE, retaddr);
+
     for (i = 0; i < 8; i++) {
         tmp = ST(i);
-        do_fstt(env, tmp, ptr, retaddr);
+        do_fstt(&ac, ptr, tmp);
         ptr += 10;
     }
 
@@ -2483,14 +2492,17 @@ void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
 static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
                       uintptr_t retaddr)
 {
+    X86Access ac;
     floatx80 tmp;
     int i;
 
     do_fldenv(env, ptr, data32, retaddr);
     ptr += (target_ulong)14 << data32;
 
+    access_prepare(&ac, env, ptr, 80, MMU_DATA_LOAD, retaddr);
+
     for (i = 0; i < 8; i++) {
-        tmp = do_fldt(env, ptr, retaddr);
+        tmp = do_fldt(&ac, ptr);
         ST(i) = tmp;
         ptr += 10;
     }
@@ -2507,6 +2519,7 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
     int fpus, fptag, i;
     target_ulong addr;
+    X86Access ac;
 
     fpus = (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
     fptag = 0;
@@ -2525,9 +2538,11 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     cpu_stq_data_ra(env, ptr + XO(legacy.fpdp), 0, ra); /* edp+sel; rdp */
 
     addr = ptr + XO(legacy.fpregs);
+    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_STORE, ra);
+
     for (i = 0; i < 8; i++) {
         floatx80 tmp = ST(i);
-        do_fstt(env, tmp, addr, ra);
+        do_fstt(&ac, addr, tmp);
         addr += 16;
     }
 }
@@ -2700,6 +2715,7 @@ static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
     int i, fpuc, fpus, fptag;
     target_ulong addr;
+    X86Access ac;
 
     fpuc = cpu_lduw_data_ra(env, ptr + XO(legacy.fcw), ra);
     fpus = cpu_lduw_data_ra(env, ptr + XO(legacy.fsw), ra);
@@ -2712,8 +2728,10 @@ static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     }
 
     addr = ptr + XO(legacy.fpregs);
+    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_LOAD, ra);
+
     for (i = 0; i < 8; i++) {
-        floatx80 tmp = do_fldt(env, addr, ra);
+        floatx80 tmp = do_fldt(&ac, addr);
         ST(i) = tmp;
         addr += 16;
     }
-- 
2.34.1


