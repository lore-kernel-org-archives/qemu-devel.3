Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467C9C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy5H-0001vQ-AU; Wed, 19 Mar 2025 14:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4Q-0000PY-Uv
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4G-0006QB-RE
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913fdd003bso633842f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408583; x=1743013383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OU7UFVG34yucEkVj19LxykWHxo5v2TaWVJvCEDbmtCg=;
 b=Mso5OhHx1KA0sj5ehVAX7rooa5Kvx3JcjYa8ih/PHewjY4Sm0iyQcobaVQMpMJugrD
 xlmL+/wRCwEcZBmdvfrmh3oyNWNXusSc4J4gYU4nIvhdOoyhGpV5D9kMxXELGlSYrnfL
 tbrELCk7KqMXHaiZyA+rWiGaK8GmdB++qwf9UmDJjzcfafaNDDsLJYJ/6Q98Dhkvs0/O
 0OsoMmebaEqBGa5C/JWRceHP9j2qflCgxE3kvY4S0VaiNZvM326TBDjSV/kxHY2aSlft
 G/DIxw6LRTz75s6Mr0MyqlXiJ5h4lcDYjEaYv/dXFIe3p2pRsMykM8zs/4doAR6c3sjz
 XRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408583; x=1743013383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OU7UFVG34yucEkVj19LxykWHxo5v2TaWVJvCEDbmtCg=;
 b=hVPM2AFwHDWk0mJc1QYwxFJlFC7Pyce0B5I5xTCQ2WPIJdawtCNM0N5ITx3DaI4m/A
 7PbLj5kILgz1kLg0Tm1pBP2ZQgoNwb9EcTRZ7av5k1B9NN29Xf0gbTpZ6okrCM+KxD8T
 GJ2uwpz01vWrERLqSL/UHX1GuLee5gw5eD9OSmXZfWBsED21yxfgfwh9tlJkJmuLuR7X
 x5fzQjgOg1lu9ZMnPz7w7etmfxzbUlY+ZLhCfBJVvOXIRke3qkc252ngaS4U3UI+4B1i
 dR54+/nGSr1jsYukoTsDB4Zaxb2fMnwAEnAVH01UyweCXoJnbeXz6WQ+fNgaKl0IIqw6
 3r7w==
X-Gm-Message-State: AOJu0YznpZc1ZLPsZICzrN3vBz1OPlNMHaa5qJZ5xjcvPwZ7wAYwFmpS
 C+T0JKSTTJMh3bkBor5rWPvxh2LCOlJ5RKnhKY0Az6mo7Qjw6JOBpSJ/WyARV+M=
X-Gm-Gg: ASbGncsqxbhkg0AdmNHJuQpK54t/Ub1CJ0LlnsBg/GtmyxOsTktFjNXHIqMny39o8bb
 zK143LM6JgWWz6u3yFvuw9Uq9V1ePaVCsyldQ2ULoEALAbQc97k/q7hzBU2F0iUIhOJcjnb8+9E
 xY+gVI2r8Pb4Fd1eY1yCyahGs38AL6dkNFXesVWjoFIQbulaaN906pc2gkwvbClCwucJ/0DlYZv
 +AW84OkfA11uPM1KjxfVmIuzg7j7CG9e6/fTlTrvq/d6Iy3x9Zar9mQKXK8X50iOC5JzX/xfY6S
 lO7e/oX+rZSUbbc5NMMRSKS08PvQ+58RuzMFK35tKobQHCE=
X-Google-Smtp-Source: AGHT+IF9E6JKQPi9tluJ6OUr25qldD3NRwdoH8mAO1y99S6f3XNZ1rtMYosl0B7oAQQXT+UROXeuYw==
X-Received: by 2002:a5d:6da6:0:b0:38d:d166:d44 with SMTP id
 ffacd0b85a97d-3997959ce47mr437009f8f.23.1742408582915; 
 Wed, 19 Mar 2025 11:23:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f47c60sm25386695e9.13.2025.03.19.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D366860357;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 07/10] target/ppc: convert gdbstub to new helper (!hacky)
Date: Wed, 19 Mar 2025 18:22:52 +0000
Message-Id: <20250319182255.3096731-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

By passing the explicit state of LE/BE via the memop we can avoid the
messing about we do with ppc_maybe_bswap_register() at least for
supplying register values to gdbstub.

The fact we still need the helper for setting the values probably
indicates we could do with a reverse helper, possibly to setting env
vars directly? This is complicated by aliasing though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/gdbstub.c | 192 ++++++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 84 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index c09e93abaf..663a97d986 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "gdbstub/helpers.h"
+#include "gdbstub/registers.h"
 #include "internal.h"
 
 static int ppc_gdb_register_len_apple(int n)
@@ -74,12 +74,12 @@ static int ppc_gdb_register_len(int n)
 }
 
 /*
- * We need to present the registers to gdb in the "current" memory
- * ordering.  For user-only mode we get this for free;
- * TARGET_BIG_ENDIAN is set to the proper ordering for the
- * binary, and cannot be changed.  For system mode,
- * TARGET_BIG_ENDIAN is always set, and we must check the current
- * mode of the chip to see if we're running in little-endian.
+ * We need to map the target endian registers from gdb in the
+ * "current" memory ordering. For user-only mode we get this for free;
+ * TARGET_BIG_ENDIAN is set to the proper ordering for the binary, and
+ * cannot be changed. For system mode, TARGET_BIG_ENDIAN is always
+ * set, and we must check the current mode of the chip to see if we're
+ * running in little-endian.
  */
 static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
@@ -98,6 +98,38 @@ static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len
 #endif
 }
 
+/*
+ * We need to present the registers to gdb in the "current" memory
+ * ordering. For user-only mode this is hardwired by TARGET_BIG_ENDIAN
+ * and cannot be changed. For system mode we must check the current
+ * mode of the chip to see if we're running in little-endian.
+ */
+static MemOp ppc_gdb_memop(CPUPPCState *env, int len)
+{
+#ifndef CONFIG_USER_ONLY
+    MemOp end = FIELD_EX64(env->msr, MSR, LE) ? MO_LE : MO_BE;
+#else
+    #ifdef TARGET_BIG_ENDIAN
+    MemOp end = MO_BE;
+    #else
+    MemOp end = MO_LE;
+    #endif
+#endif
+
+    return size_memop(len) | end;
+}
+
+/*
+ * Helpers copied from helpers.h just for loading target_ulong values
+ * from gdbstub's GByteArray
+ */
+
+#if TARGET_LONG_BITS == 64
+#define ldtul_p(addr) ldq_p(addr)
+#else
+#define ldtul_p(addr) ldl_p(addr)
+#endif
+
 /*
  * Old gdb always expects FP registers.  Newer (xml-aware) gdb only
  * expects whatever the target description contains.  Due to a
@@ -109,51 +141,50 @@ static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len
 int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
-    uint8_t *mem_buf;
     int r = ppc_gdb_register_len(n);
+    MemOp mo;
 
     if (!r) {
         return r;
     }
 
+    mo = ppc_gdb_memop(env, r);
+
     if (n < 32) {
         /* gprs */
-        gdb_get_regl(buf, env->gpr[n]);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &env->gpr[n]);
     } else {
         switch (n) {
         case 64:
-            gdb_get_regl(buf, env->nip);
-            break;
+            return gdb_get_register_value(mo, buf, (uint8_t *) &env->nip);
         case 65:
-            gdb_get_regl(buf, env->msr);
-            break;
+            return gdb_get_register_value(mo, buf, (uint8_t *) &env->msr);
         case 66:
             {
                 uint32_t cr = ppc_get_cr(env);
-                gdb_get_reg32(buf, cr);
-                break;
+                return gdb_get_register_value(ppc_gdb_memop(env, 4), buf, (uint8_t *) &cr);
             }
         case 67:
-            gdb_get_regl(buf, env->lr);
+            return gdb_get_register_value(mo, buf, (uint8_t *) &env->lr);
             break;
         case 68:
-            gdb_get_regl(buf, env->ctr);
+            return gdb_get_register_value(mo, buf, (uint8_t *) &env->ctr);
             break;
         case 69:
-            gdb_get_reg32(buf, cpu_read_xer(env));
-            break;
+            uint32_t val = cpu_read_xer(env);
+            return gdb_get_register_value(ppc_gdb_memop(env, 4), buf, (uint8_t *) &val);
         }
     }
-    mem_buf = buf->data + buf->len - r;
-    ppc_maybe_bswap_register(env, mem_buf, r);
-    return r;
+
+    return 0;
 }
 
 int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
-    uint8_t *mem_buf;
     int r = ppc_gdb_register_len_apple(n);
+    MemOp mo = ppc_gdb_memop(env, r);
+    int actual = 0;
 
     if (!r) {
         return r;
@@ -161,44 +192,48 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_reg64(buf, env->gpr[n]);
+        actual = gdb_get_register_value(mo, buf, (uint8_t *) &env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        actual = gdb_get_register_value(mo, buf, (uint8_t *) cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
-        /* Altivec */
-        gdb_get_reg64(buf, n - 64);
-        gdb_get_reg64(buf, 0);
+        /* Altivec - where are they? ppc_vsr_t vsr[64]? */
+        uint64_t empty = 0;
+        actual = gdb_get_register_value(mo, buf, (uint8_t *) &empty);
+        actual = gdb_get_register_value(mo, buf, (uint8_t *) &empty);
     } else {
         switch (n) {
         case 64 + 32:
-            gdb_get_reg64(buf, env->nip);
+            actual = gdb_get_register_value(mo, buf, (uint8_t *) &env->nip);
             break;
         case 65 + 32:
-            gdb_get_reg64(buf, env->msr);
+            actual = gdb_get_register_value(mo, buf, (uint8_t *) &env->msr);
             break;
         case 66 + 32:
-            {
-                uint32_t cr = ppc_get_cr(env);
-                gdb_get_reg32(buf, cr);
-                break;
-            }
+        {
+            uint32_t cr = ppc_get_cr(env);
+            actual = gdb_get_register_value(mo, buf, (uint8_t *) &cr);
+            break;
+        }
         case 67 + 32:
-            gdb_get_reg64(buf, env->lr);
+            actual = gdb_get_register_value(mo, buf, (uint8_t *) &env->lr);
             break;
         case 68 + 32:
-            gdb_get_reg64(buf, env->ctr);
+            actual = gdb_get_register_value(mo, buf, (uint8_t *) &env->ctr);
             break;
         case 69 + 32:
-            gdb_get_reg32(buf, cpu_read_xer(env));
+        {
+            uint32_t xer = cpu_read_xer(env);
+            actual = gdb_get_register_value(mo, buf, (uint8_t *) &xer);
             break;
+        }
         case 70 + 32:
-            gdb_get_reg64(buf, env->fpscr);
+            actual = gdb_get_register_value(mo, buf, (uint8_t *) &env->fpscr);
             break;
         }
     }
-    mem_buf = buf->data + buf->len - r;
-    ppc_maybe_bswap_register(env, mem_buf, r);
+
+    g_assert(r == actual);
     return r;
 }
 
@@ -210,6 +245,9 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (!r) {
         return r;
     }
+
+    g_assert(r == n);
+    
     ppc_maybe_bswap_register(env, mem_buf, r);
     if (n < 32) {
         /* gprs */
@@ -367,18 +405,16 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    MemOp mo = ppc_gdb_memop(env, TARGET_LONG_SIZE);
+    target_ulong val;
     int reg;
-    int len;
 
     reg = gdb_find_spr_idx(env, n);
     if (reg < 0) {
         return 0;
     }
 
-    len = TARGET_LONG_SIZE;
-
     /* Handle those SPRs that are not part of the env->spr[] array */
-    target_ulong val;
     switch (reg) {
 #if defined(TARGET_PPC64)
     case SPR_CFAR:
@@ -400,10 +436,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
     default:
         val = env->spr[reg];
     }
-    gdb_get_regl(buf, val);
-
-    ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
-    return len;
+    return gdb_get_register_value(mo, buf, (uint8_t *) &val);
 }
 
 static int gdb_set_spr_reg(CPUState *cs, uint8_t *mem_buf, int n)
@@ -441,18 +474,14 @@ static int gdb_get_float_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
-    uint8_t *mem_buf;
+    MemOp mo;
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
-        mem_buf = gdb_get_reg_ptr(buf, 8);
-        ppc_maybe_bswap_register(env, mem_buf, 8);
-        return 8;
+        mo = ppc_gdb_memop(env, 8);
+        return gdb_get_register_value(mo, buf, (uint8_t *)cpu_fpr_ptr(env, n));
     }
     if (n == 32) {
-        gdb_get_reg32(buf, env->fpscr);
-        mem_buf = gdb_get_reg_ptr(buf, 4);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
-        return 4;
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &env->fpscr);
     }
     return 0;
 }
@@ -479,26 +508,21 @@ static int gdb_get_avr_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
-    uint8_t *mem_buf;
+    MemOp mo;
 
     if (n < 32) {
         ppc_avr_t *avr = cpu_avr_ptr(env, n);
-        gdb_get_reg128(buf, avr->VsrD(0), avr->VsrD(1));
-        mem_buf = gdb_get_reg_ptr(buf, 16);
-        ppc_maybe_bswap_register(env, mem_buf, 16);
-        return 16;
+        mo = ppc_gdb_memop(env, 16);
+        return gdb_get_register_value(mo, buf, (uint8_t *) avr);
     }
     if (n == 32) {
-        gdb_get_reg32(buf, ppc_get_vscr(env));
-        mem_buf = gdb_get_reg_ptr(buf, 4);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
-        return 4;
+        uint32_t vscr = ppc_get_vscr(env);
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &vscr);
     }
     if (n == 33) {
-        gdb_get_reg32(buf, (uint32_t)env->spr[SPR_VRSAVE]);
-        mem_buf = gdb_get_reg_ptr(buf, 4);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
-        return 4;
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &env->spr[SPR_VRSAVE]);
     }
     return 0;
 }
@@ -532,25 +556,25 @@ static int gdb_get_spe_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    MemOp mo;
 
     if (n < 32) {
 #if defined(TARGET_PPC64)
-        gdb_get_reg32(buf, env->gpr[n] >> 32);
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 4), 4);
+        uint32_t low = env->gpr[n] >> 32;
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &low);
 #else
-        gdb_get_reg32(buf, env->gprh[n]);
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &env->gprh[n]);
 #endif
-        return 4;
     }
     if (n == 32) {
-        gdb_get_reg64(buf, env->spe_acc);
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 8), 8);
-        return 8;
+        mo = ppc_gdb_memop(env, 8);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &env->spe_acc);
     }
     if (n == 33) {
-        gdb_get_reg32(buf, env->spe_fscr);
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 4), 4);
-        return 4;
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_register_value(mo, buf, (uint8_t *) &env->spe_fscr);
     }
     return 0;
 }
@@ -593,9 +617,9 @@ static int gdb_get_vsx_reg(CPUState *cs, GByteArray *buf, int n)
     CPUPPCState *env = &cpu->env;
 
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_vsrl_ptr(env, n));
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 8), 8);
-        return 8;
+        return gdb_get_register_value(ppc_gdb_memop(env, 8),
+                                      buf,
+                                      (uint8_t *)cpu_vsrl_ptr(env, n));
     }
     return 0;
 }
-- 
2.39.5


