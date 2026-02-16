Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380D2E83842
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7Sf-0001sG-H7; Mon, 16 Feb 2026 17:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7Sd-0001rV-NS
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7Sb-0006TD-GG
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso28391305e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282375; x=1771887175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1qYXxoXs3fg7sMo9aLOdEMvIAw8M+fxuDARxQQ5jdw=;
 b=Wg9NE9MHlbIB+kM8zj1XeJFw3gRRvGUPUDgyyC0vApcQEohLB8z+fisXlCVjaYpERR
 aEdepDTP6udelwxnXolaih59pYdZ2oJ2OBl1d111QSjpBPzUQzlvOY1CDVisx/mVJh8H
 wLqiuv9TrzkkupsNZ8QkGTvgBgITt8eNFXVFOiNY5kKRW2oD3qdmCwPWJWK/R1KxnGB1
 ow7ODoDV1m7PdIG9uZbk0OhcvMm9Lrs2O1JTD0uDdKSDD4BC2Mh8FMI22sMTgfewcGAm
 1X6q9zYxK3zBB4Wbv7YrqtY6pHv87RwnlAhZ7/SO5nDdYRi2GX5bJJig0L4XzIkMXJue
 +vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282375; x=1771887175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q1qYXxoXs3fg7sMo9aLOdEMvIAw8M+fxuDARxQQ5jdw=;
 b=o2FMD+eyhK3WjV7tIJsCGgLIt2erP8ZksHVx1TxDFHqEYWk7qUeF+eek+Um4Y3hMp2
 gLCaYsEYWLUBIacLjZCtiYM+c0GFKQRSJR86Zais+9016JYq8qJ7QVtiqiLOAJmcaxDW
 RNYt4dys6sgwkJrBKzrfSg36KqT5c25aorLX/jD3xAaugRd5vvnsfNGbs8obBb0KGamB
 3KUFNPsI3mlv8wjBUUXwdtWo53NVhzuEvTvURIIsMHq50gsg/hHFoLv7lDpz1u9RpzSQ
 UQh4kW3SizPna34G6AohIc1d44sMP0w4vF4TaFRhLNnRw/Vd5aZzBNIDROCIX0P34CMw
 CRpw==
X-Gm-Message-State: AOJu0Yz+eOTE0iNZmVuh4nyiyu0QqLBMKxvOjoBuP4Md7m5ZMsFbFuNx
 fKcs0/C10bLa5KaR91tbXhNOK+XTOEBEN/C4F0UX/Go2BTUmKBkFS6zcz2tvrgUUW+pjjOnz6PK
 43rlAozA=
X-Gm-Gg: AZuq6aLLxIqAV23Hd95JcOd0E2+sjs5lVJWPYdx5S5O9XsRfgG44gslPUu7b1+s3jGx
 w0uyJ3HCr/cCnOzZo6HiVnW+AfTAe1tEh4Lgd3ntP4/CjkZj8hPWe84Fb3hZPhCg3k0PY3HtJ4q
 leZDlN4tXKqoUD6acuLWLW59du2T5qA4flwFlgIY6TokCKEp2eWk9DH8tlrYm2IRGjw6beI2ze+
 9pVJkCe0CR7gpZFXljnCI1U/meixdSon4m/N7LsLQtsvrd5KwxJF32amePgEImNqOJFdhhzZ9H0
 h+YU+CE6bi80kyKIfEzhB56M4Lq9y+J5eN8pWLQWk/17SJ6SY1ULENlpZCIun4w0VGm6X8zwDvM
 GwXeyPqaLRrM4zSXe+fPfgMvNoQx3Rf/TioEYujmlWsYPNxBPomRuw9sIW9fx6/PNXFZACuWflm
 85Er/OSI3qTAS6/Gt4FeWMepp07BjH7Tnriq2ZIcJ6O2Ic/JeWqsBhG4yqaXDGNYZZL4vWjhvK
X-Received: by 2002:a05:600c:8a16:10b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-4838e436e43mr27418275e9.29.1771282374604; 
 Mon, 16 Feb 2026 14:52:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99e194sm356603725e9.8.2026.02.16.14.52.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:52:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 03/11] target/sparc: Restore 'gdb-xml/sparc64-fpu.xml'
Date: Mon, 16 Feb 2026 23:52:19 +0100
Message-ID: <20260216225228.53959-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Restore gdb-xml/sparc64-fpu.xml from mainstream binutils, tag
'binutils-2_46', found in the gdb/features/sparc/folder [*].

Extract sparc_fpu_gdb_write_register() out of
sparc_cpu_gdb_read_register() and sparc_fpu_gdb_write_register()
out of sparc_cpu_gdb_write_register(), taking care to update the
register indexes in the switch cases.

Register these helpers with a call to gdb_register_coprocessor()
in sparc_cpu_register_gdb_regs().

[*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc64-linux-user.mak |  2 +-
 configs/targets/sparc64-softmmu.mak    |  2 +-
 target/sparc/cpu.c                     |  2 +-
 target/sparc/gdbstub.c                 | 88 +++++++++++++++++---------
 gdb-xml/sparc64-core.xml               | 50 ---------------
 gdb-xml/sparc64-fpu.xml                | 59 +++++++++++++++++
 6 files changed, 120 insertions(+), 83 deletions(-)
 create mode 100644 gdb-xml/sparc64-fpu.xml

diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 930f7e13ab9..a5f8f8d51a2 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -4,6 +4,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-cp0.xml
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 22e7f3c94a7..c35b6b1bb8a 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-cp0.xml
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 6f7b250abb3..2db34d88b97 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1094,7 +1094,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
     cc->gdb_core_xml_file = "sparc64-core.xml";
-    cc->gdb_num_core_regs = 80;
+    cc->gdb_num_core_regs = 32;
 #else
     cc->gdb_num_core_regs = 72;
 #endif
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index bdd759dd0a9..b5b1494950a 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -40,32 +40,40 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         /* register window */
         return gdb_get_rega(mem_buf, env->regwptr[n - 8]);
     }
+    return 0;
+}
+
+__attribute__((unused))
+static int sparc_fpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    CPUSPARCState *env = cpu_env(cs);
+
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
-    if (n < 64) {
+    if (n < 32) {
         /* fprs */
         if (n & 1) {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.lower);
+            return gdb_get_reg32(mem_buf, env->fpr[n / 2].l.lower);
         } else {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.upper);
+            return gdb_get_reg32(mem_buf, env->fpr[n / 2].l.upper);
         }
     }
 #else
-    if (n < 64) {
+    if (n < 32) {
         /* f0-f31 */
         if (n & 1) {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.lower);
+            return gdb_get_reg32(mem_buf, env->fpr[n / 2].l.lower);
         } else {
-            return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.upper);
+            return gdb_get_reg32(mem_buf, env->fpr[n / 2].l.upper);
         }
     }
-    if (n < 80) {
+    if (n < 48) {
         /* f32-f62 (16 double width registers, even register numbers only)
-         * n == 64: f32 : env->fpr[16]
-         * n == 65: f34 : env->fpr[17]
+         * n == 32: f32 : env->fpr[16]
+         * n == 33: f34 : env->fpr[17]
          * etc...
-         * n == 79: f62 : env->fpr[31]
+         * n == 47: f62 : env->fpr[31]
          */
-        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);
+        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) + 16].ll);
     }
 #endif
     return 0;
@@ -135,39 +143,55 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < 8) {
         /* g0..g7 */
         env->gregs[n] = tmp;
-    } else if (n < 32) {
+    } else {
         /* register window */
         env->regwptr[n - 8] = tmp;
     }
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
-    else if (n < 64) {
-        /* fprs */
-        /* f0-f31 */
-        if (n & 1) {
-            env->fpr[(n - 32) / 2].l.lower = tmp;
-        } else {
-            env->fpr[(n - 32) / 2].l.upper = tmp;
-        }
-    }
     return 4;
 #else
-    else if (n < 64) {
+    return 8;
+#endif
+}
+
+__attribute__((unused))
+static int sparc_fpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    CPUSPARCState *env = cpu_env(cs);
+
+#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
+    uint32_t tmp;
+
+    tmp = ldl_p(mem_buf);
+
+    /* fprs */
+    /* f0-f31 */
+    if (n & 1) {
+        env->fpr[n / 2].l.lower = tmp;
+    } else {
+        env->fpr[n / 2].l.upper = tmp;
+    }
+
+    return 4;
+#else
+    if (n < 32) {
         /* f0-f31 */
-        tmp = ldl_p(mem_buf);
+        uint32_t tmp = ldl_p(mem_buf);
         if (n & 1) {
-            env->fpr[(n - 32) / 2].l.lower = tmp;
+            env->fpr[n / 2].l.lower = tmp;
         } else {
-            env->fpr[(n - 32) / 2].l.upper = tmp;
+            env->fpr[n  / 2].l.upper = tmp;
         }
         return 4;
-    } else if (n < 80) {
+    } else {
+        uint64_t tmp = ldq_p(mem_buf);
         /* f32-f62 (16 double width registers, even register numbers only)
-         * n == 64: f32 : env->fpr[16]
-         * n == 65: f34 : env->fpr[17]
+         * n == 32: f32 : env->fpr[16]
+         * n == 33: f34 : env->fpr[17]
          * etc...
-         * n == 79: f62 : env->fpr[31]
+         * n == 47: f62 : env->fpr[31]
          */
-        env->fpr[(n - 64) + 16].ll = tmp;
+        env->fpr[(n - 32) + 16].ll = tmp;
     }
     return 8;
 #endif
@@ -249,6 +273,10 @@ void sparc_cpu_register_gdb_regs(CPUState *cs)
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
     /* Not yet supported */
 #else
+    gdb_register_coprocessor(cs, sparc_fpu_gdb_read_register,
+                             sparc_fpu_gdb_write_register,
+                             gdb_find_static_feature("sparc64-fpu.xml"),
+                             0);
     gdb_register_coprocessor(cs, sparc_cp0_gdb_read_register,
                              sparc_cp0_gdb_write_register,
                              gdb_find_static_feature("sparc64-cp0.xml"),
diff --git a/gdb-xml/sparc64-core.xml b/gdb-xml/sparc64-core.xml
index 1c26d8c01c1..85b0820a408 100644
--- a/gdb-xml/sparc64-core.xml
+++ b/gdb-xml/sparc64-core.xml
@@ -39,54 +39,4 @@
   <reg name="i5" bitsize="64" type="uint64" regnum="29"/>
   <reg name="fp" bitsize="64" type="uint64" regnum="30"/>
   <reg name="i7" bitsize="64" type="uint64" regnum="31"/>
-
-  <reg name="f0" bitsize="32" type="ieee_single" regnum="32"/>
-  <reg name="f1" bitsize="32" type="ieee_single" regnum="33"/>
-  <reg name="f2" bitsize="32" type="ieee_single" regnum="34"/>
-  <reg name="f3" bitsize="32" type="ieee_single" regnum="35"/>
-  <reg name="f4" bitsize="32" type="ieee_single" regnum="36"/>
-  <reg name="f5" bitsize="32" type="ieee_single" regnum="37"/>
-  <reg name="f6" bitsize="32" type="ieee_single" regnum="38"/>
-  <reg name="f7" bitsize="32" type="ieee_single" regnum="39"/>
-  <reg name="f8" bitsize="32" type="ieee_single" regnum="40"/>
-  <reg name="f9" bitsize="32" type="ieee_single" regnum="41"/>
-  <reg name="f10" bitsize="32" type="ieee_single" regnum="42"/>
-  <reg name="f11" bitsize="32" type="ieee_single" regnum="43"/>
-  <reg name="f12" bitsize="32" type="ieee_single" regnum="44"/>
-  <reg name="f13" bitsize="32" type="ieee_single" regnum="45"/>
-  <reg name="f14" bitsize="32" type="ieee_single" regnum="46"/>
-  <reg name="f15" bitsize="32" type="ieee_single" regnum="47"/>
-  <reg name="f16" bitsize="32" type="ieee_single" regnum="48"/>
-  <reg name="f17" bitsize="32" type="ieee_single" regnum="49"/>
-  <reg name="f18" bitsize="32" type="ieee_single" regnum="50"/>
-  <reg name="f19" bitsize="32" type="ieee_single" regnum="51"/>
-  <reg name="f20" bitsize="32" type="ieee_single" regnum="52"/>
-  <reg name="f21" bitsize="32" type="ieee_single" regnum="53"/>
-  <reg name="f22" bitsize="32" type="ieee_single" regnum="54"/>
-  <reg name="f23" bitsize="32" type="ieee_single" regnum="55"/>
-  <reg name="f24" bitsize="32" type="ieee_single" regnum="56"/>
-  <reg name="f25" bitsize="32" type="ieee_single" regnum="57"/>
-  <reg name="f26" bitsize="32" type="ieee_single" regnum="58"/>
-  <reg name="f27" bitsize="32" type="ieee_single" regnum="59"/>
-  <reg name="f28" bitsize="32" type="ieee_single" regnum="60"/>
-  <reg name="f29" bitsize="32" type="ieee_single" regnum="61"/>
-  <reg name="f30" bitsize="32" type="ieee_single" regnum="62"/>
-  <reg name="f31" bitsize="32" type="ieee_single" regnum="63"/>
-
-  <reg name="f32" bitsize="64" type="ieee_double" regnum="64"/>
-  <reg name="f34" bitsize="64" type="ieee_double" regnum="65"/>
-  <reg name="f36" bitsize="64" type="ieee_double" regnum="66"/>
-  <reg name="f38" bitsize="64" type="ieee_double" regnum="67"/>
-  <reg name="f40" bitsize="64" type="ieee_double" regnum="68"/>
-  <reg name="f42" bitsize="64" type="ieee_double" regnum="69"/>
-  <reg name="f44" bitsize="64" type="ieee_double" regnum="70"/>
-  <reg name="f46" bitsize="64" type="ieee_double" regnum="71"/>
-  <reg name="f48" bitsize="64" type="ieee_double" regnum="72"/>
-  <reg name="f50" bitsize="64" type="ieee_double" regnum="73"/>
-  <reg name="f52" bitsize="64" type="ieee_double" regnum="74"/>
-  <reg name="f54" bitsize="64" type="ieee_double" regnum="75"/>
-  <reg name="f56" bitsize="64" type="ieee_double" regnum="76"/>
-  <reg name="f58" bitsize="64" type="ieee_double" regnum="77"/>
-  <reg name="f60" bitsize="64" type="ieee_double" regnum="78"/>
-  <reg name="f62" bitsize="64" type="ieee_double" regnum="79"/>
 </feature>
diff --git a/gdb-xml/sparc64-fpu.xml b/gdb-xml/sparc64-fpu.xml
new file mode 100644
index 00000000000..d7151b34c7f
--- /dev/null
+++ b/gdb-xml/sparc64-fpu.xml
@@ -0,0 +1,59 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2013-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.sparc.fpu">
+  <reg name="f0" bitsize="32" type="ieee_single" regnum="32"/>
+  <reg name="f1" bitsize="32" type="ieee_single" regnum="33"/>
+  <reg name="f2" bitsize="32" type="ieee_single" regnum="34"/>
+  <reg name="f3" bitsize="32" type="ieee_single" regnum="35"/>
+  <reg name="f4" bitsize="32" type="ieee_single" regnum="36"/>
+  <reg name="f5" bitsize="32" type="ieee_single" regnum="37"/>
+  <reg name="f6" bitsize="32" type="ieee_single" regnum="38"/>
+  <reg name="f7" bitsize="32" type="ieee_single" regnum="39"/>
+  <reg name="f8" bitsize="32" type="ieee_single" regnum="40"/>
+  <reg name="f9" bitsize="32" type="ieee_single" regnum="41"/>
+  <reg name="f10" bitsize="32" type="ieee_single" regnum="42"/>
+  <reg name="f11" bitsize="32" type="ieee_single" regnum="43"/>
+  <reg name="f12" bitsize="32" type="ieee_single" regnum="44"/>
+  <reg name="f13" bitsize="32" type="ieee_single" regnum="45"/>
+  <reg name="f14" bitsize="32" type="ieee_single" regnum="46"/>
+  <reg name="f15" bitsize="32" type="ieee_single" regnum="47"/>
+  <reg name="f16" bitsize="32" type="ieee_single" regnum="48"/>
+  <reg name="f17" bitsize="32" type="ieee_single" regnum="49"/>
+  <reg name="f18" bitsize="32" type="ieee_single" regnum="50"/>
+  <reg name="f19" bitsize="32" type="ieee_single" regnum="51"/>
+  <reg name="f20" bitsize="32" type="ieee_single" regnum="52"/>
+  <reg name="f21" bitsize="32" type="ieee_single" regnum="53"/>
+  <reg name="f22" bitsize="32" type="ieee_single" regnum="54"/>
+  <reg name="f23" bitsize="32" type="ieee_single" regnum="55"/>
+  <reg name="f24" bitsize="32" type="ieee_single" regnum="56"/>
+  <reg name="f25" bitsize="32" type="ieee_single" regnum="57"/>
+  <reg name="f26" bitsize="32" type="ieee_single" regnum="58"/>
+  <reg name="f27" bitsize="32" type="ieee_single" regnum="59"/>
+  <reg name="f28" bitsize="32" type="ieee_single" regnum="60"/>
+  <reg name="f29" bitsize="32" type="ieee_single" regnum="61"/>
+  <reg name="f30" bitsize="32" type="ieee_single" regnum="62"/>
+  <reg name="f31" bitsize="32" type="ieee_single" regnum="63"/>
+
+  <reg name="f32" bitsize="64" type="ieee_double" regnum="64"/>
+  <reg name="f34" bitsize="64" type="ieee_double" regnum="65"/>
+  <reg name="f36" bitsize="64" type="ieee_double" regnum="66"/>
+  <reg name="f38" bitsize="64" type="ieee_double" regnum="67"/>
+  <reg name="f40" bitsize="64" type="ieee_double" regnum="68"/>
+  <reg name="f42" bitsize="64" type="ieee_double" regnum="69"/>
+  <reg name="f44" bitsize="64" type="ieee_double" regnum="70"/>
+  <reg name="f46" bitsize="64" type="ieee_double" regnum="71"/>
+  <reg name="f48" bitsize="64" type="ieee_double" regnum="72"/>
+  <reg name="f50" bitsize="64" type="ieee_double" regnum="73"/>
+  <reg name="f52" bitsize="64" type="ieee_double" regnum="74"/>
+  <reg name="f54" bitsize="64" type="ieee_double" regnum="75"/>
+  <reg name="f56" bitsize="64" type="ieee_double" regnum="76"/>
+  <reg name="f58" bitsize="64" type="ieee_double" regnum="77"/>
+  <reg name="f60" bitsize="64" type="ieee_double" regnum="78"/>
+  <reg name="f62" bitsize="64" type="ieee_double" regnum="79"/>
+</feature>
-- 
2.52.0


