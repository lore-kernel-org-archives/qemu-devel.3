Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED711C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZL-0007FR-4I; Sun, 26 May 2024 20:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ0-00072Z-Rk
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOYv-0003Zi-Sz
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f8e98784b3so2008490b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771004; x=1717375804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YlnBqdWRAdGOIDkFc78uZlpVYy9Rupt5PRiXjMOq17M=;
 b=dNg0VyPqXSLNPkLaw0E7uZYfLStxCZKuBiFsLByFjGQOmou4+cRpmiGpjrpS38MwAg
 xo+7BO9nw+q+3xQ+BgaN4uBKvd7dJ6/nui95E4X1V6Z/EYRPHwBHO0cgSVqNxOvdEWrs
 bXtMc9XFPlLTzPUlczjGVXDx0RgELLYEFGPMrH9XFFABxZ84cVlI3aFgTdz7kJ8av29B
 XTZd05y3hpI9Gxd3QZFqhDFkdA5GJi3ELth75LkIB/Sx+9pEpPAlf1e9rm8pC5cNp+RF
 8lrUn0z7sno87qQv5soKUOyfR51rZB342GPGrkwdI0T+0ABveUGy0PZzvo7HEdUhDCRW
 eKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771004; x=1717375804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlnBqdWRAdGOIDkFc78uZlpVYy9Rupt5PRiXjMOq17M=;
 b=IMdCWwqC+xUvYGFQ5aXA76NOovkHM3+G+6fKEBsked8Mjzfi4nPbRSovmp1g9HS7XN
 rxrI44mMI3rs3OKyXrxVSxmYx72iuuIfQiDkkwW7smH7sHz/HC4yOilBhWLVoIgnwlfh
 SNqyoyflSTj9Ot0YO+j7De3DbDpeTUB/n6lnfhVBWG9U0mR8Mk6SaXh1bLllFEmC/U9K
 3Hej6k3xjg8JKdfo5y+oe+JpD6mmIBTtCzawPxTLF72Vb1jUlLbN0a64AbcM8sZhLh9r
 U4LuWi1o5L2oPN+tCnolwpi4qLVTgUcfWW5iI1VY0gqgIqIEdZ2TV+ybBdVk/sIFs2ZN
 yNpw==
X-Gm-Message-State: AOJu0YwqiGrB+vKrGKyYHglQaJq2nuIFt2qqD7VUb9vCppbMHAjrZxOt
 A5qfKJ47Tefd1lxdl6CX6TbQoKIlhNC27NCC/p+XsROO1K0j7dobNaMXGBMoh1ip4Cs0S1iaG2T
 e
X-Google-Smtp-Source: AGHT+IHBh1u31ULCNDsHtC23S2HUUA5Hp+VGMNBhVgSy94Ll97ruxxcQ4fg13DmMxp2VMHoRGBRCTA==
X-Received: by 2002:a05:6a00:908f:b0:6f4:d07a:e7f0 with SMTP id
 d2e1a72fcca58-6f8f3d784b0mr9348950b3a.27.1716771004039; 
 Sun, 26 May 2024 17:50:04 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/28] target/i386: Convert do_fldt, do_fstt to X86Access
Date: Sun, 26 May 2024 17:49:35 -0700
Message-Id: <20240527005001.642825-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


