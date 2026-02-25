Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1968CFD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO89-0001Zl-7m; Wed, 25 Feb 2026 18:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7G-0007fv-Dt
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:30 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7D-0002qj-Jz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-43945763558so140687f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061381; x=1772666181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=79YYFz+D1ATPDrAXduKKP2uVEJuaEL+fM5BNyaSmPPU=;
 b=C/rgtJgVV0VIFXFT/Me19ByAgSiSrd8AdZWkxuYksdXYU56ypGUxdHCiQlDlliUp4A
 vvcgaKp9xwIKslwQLJZhGA/NFZ4J1bHnKYUnhas36EftAM8TjdNpM19PUYIqP+dHEvfz
 d6+UF6QVgzAR299KeMVB2v3as/Kf//hkv51zCUmY+3VN7zPuScEzhPUn2Y7B2jP1Sgw2
 sYWvmanBMkQskqkitNoXEbbVIIKgr2j/Taw1PKeB7vj0fnoPiPc5MsQgEh4ZkNnt8h4D
 ngKrhhH+cHLaIQRWowAnt3FNaKNYZaDnSkMjB+MfbNxK506/qQHndlJuUAyVuVCz2U4Z
 jTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061381; x=1772666181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=79YYFz+D1ATPDrAXduKKP2uVEJuaEL+fM5BNyaSmPPU=;
 b=WE0aa/ZykydPUEJ7/utpGqYRCef8GxMF8QHSQnYf7MlQre97tft8aNTj+9zlGjY67M
 0f4BXzkwivJgZbMhqlHnHGRxRHc03VBRlZRlWy90FHlIFW8fyJNfvpcKyGHgFNbYxUh1
 rvMGnLPa1yYvjI3BBVKG0C2/T+LVQE9lF1PPIPlGFwXZQXyah3OecRtOV2i6HXXg0Qva
 F5maIPg4P2j1X0b69hkQRbjZWoHvml7Fv121I8ilxCnGigD3PBTftS4c2H7dDbArvJK9
 QzSgTOwe6DNAOwy8CLROqHb17/4OSJp5m1peuuvtQCz4pE/m8BkIUwUcUq7+O0gSSj7B
 G0pg==
X-Gm-Message-State: AOJu0YwrwKYwFuZJbi/pj7FzKhzw3UxOeyGy0cDyoBxbwV5DR5N8y8tb
 fx0Zo0+3ISABcqQkosoxE7ytl+bBw/9zVKW4lG7VWFlV21Mtwf7cl6IGFSdoLmobcft4uHIOVv0
 i0otYiKM=
X-Gm-Gg: ATEYQzxlgosFPrLevK7q7E3xs+DBl6pzE2hr84005Q0GaBwdZmbti3cCxjOi8euhpN0
 9joPkELP3OiIpk08oleXgUL9Ir1uM33GwDUZzi5b5X/6nQlkkjjl0lWGIoQfZdnp6uSajUcpvK7
 svjMoc6+UB/AW2VHgpDqTQuSBMjTZMb2zkA7YPaUbrI+MhO6gKhBY/2fmr5dyFqQYh6HclO2AE5
 31QDn+ultvG4D68Yz4UbVlnUoxKRgkProI2fV8lQT13cQ65hPPa29xOZM6VEMroPs87zsPECJLe
 AKZ1eXNkkrd2wSA+hsFboaGChuDkzj1JE7B+Wk/Pp9CICcgbtiBODix3bSLeaZgHUyKFqckVPAi
 NrMG68vRBGVKU0Dj4k7H3hgBNHRancYdYwlUFXS4A5lWiysgNu8mp+SqUXMEdT9E1J0wc1b2GOU
 wKKnjyaH8IvW/DGj/TIj0dokfUq6cgzTIYV+ePafU8amgYRF+pbvqpAlXcnI2r2IRM95zpynD6
X-Received: by 2002:a05:6000:2403:b0:431:752:671e with SMTP id
 ffacd0b85a97d-4396f173e6bmr27280237f8f.15.1772061381379; 
 Wed, 25 Feb 2026 15:16:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398a292babsm13302742f8f.37.2026.02.25.15.16.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:16:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/70] target/sparc: Restore 'gdb-xml/sparc64-cp0.xml'
Date: Thu, 26 Feb 2026 00:13:19 +0100
Message-ID: <20260225231411.96482-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

Restore gdb-xml/sparc64-cp0.xml from mainstream binutils, tag
'binutils-2_46', found in the gdb/features/sparc/folder [*].

Extract sparc_cp0_gdb_write_register() out of
sparc_cpu_gdb_read_register() and sparc_cp0_gdb_write_register()
out of sparc_cpu_gdb_write_register(), taking care to update the
register indexes in the switch cases.

Register these helpers with a call to gdb_register_coprocessor()
in sparc_cpu_register_gdb_regs().

[*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-12-philmd@linaro.org>
---
 MAINTAINERS                            |   1 +
 configs/targets/sparc64-linux-user.mak |   2 +-
 configs/targets/sparc64-softmmu.mak    |   2 +-
 target/sparc/gdbstub.c                 | 193 ++++++++++++++-----------
 gdb-xml/sparc64-core.xml               |   7 -
 gdb-xml/sparc64-cp0.xml                |  16 ++
 6 files changed, 131 insertions(+), 90 deletions(-)
 create mode 100644 gdb-xml/sparc64-cp0.xml

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71f..693b51166f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -402,6 +402,7 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
 F: target/sparc/
+F: gdb-xml/sparc*.xml
 F: hw/sparc/
 F: hw/sparc64/
 F: include/hw/sparc/sparc64.h
diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 3bbd8495210..930f7e13ab9 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -4,6 +4,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-core.xml
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 8a0290c2093..22e7f3c94a7 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-core.xml
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 79d661fbc10..bdd759dd0a9 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "exec/gdbstub.h"
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
@@ -48,27 +49,6 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             return gdb_get_reg32(mem_buf, env->fpr[(n - 32) / 2].l.upper);
         }
     }
-    /* Y, PSR, WIM, TBR, PC, NPC, FPSR, CPSR */
-    switch (n) {
-    case 64:
-        return gdb_get_rega(mem_buf, env->y);
-    case 65:
-        return gdb_get_rega(mem_buf, cpu_get_psr(env));
-    case 66:
-        return gdb_get_rega(mem_buf, env->wim);
-    case 67:
-        return gdb_get_rega(mem_buf, env->tbr);
-    case 68:
-        return gdb_get_rega(mem_buf, env->pc);
-    case 69:
-        return gdb_get_rega(mem_buf, env->npc);
-    case 70:
-        return gdb_get_rega(mem_buf, cpu_get_fsr(env));
-    case 71:
-        return gdb_get_rega(mem_buf, 0); /* csr */
-    default:
-        return gdb_get_rega(mem_buf, 0);
-    }
 #else
     if (n < 64) {
         /* f0-f31 */
@@ -87,21 +67,51 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
          */
         return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);
     }
+#endif
+    return 0;
+}
+
+__attribute__((unused))
+static int sparc_cp0_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    CPUSPARCState *env = cpu_env(cs);
+
+#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
+    /* Y, PSR, WIM, TBR, PC, NPC, FPSR, CPSR */
     switch (n) {
-    case 80:
+    case 0:
+        return gdb_get_rega(mem_buf, env->y);
+    case 1:
+        return gdb_get_rega(mem_buf, cpu_get_psr(env));
+    case 2:
+        return gdb_get_rega(mem_buf, env->wim);
+    case 3:
+        return gdb_get_rega(mem_buf, env->tbr);
+    case 4:
+        return gdb_get_rega(mem_buf, env->pc);
+    case 5:
+        return gdb_get_rega(mem_buf, env->npc);
+    case 6:
+        return gdb_get_rega(mem_buf, cpu_get_fsr(env));
+    case 7:
+        return gdb_get_rega(mem_buf, 0); /* csr */
+    }
+#else
+    switch (n) {
+    case 0:
         return gdb_get_regl(mem_buf, env->pc);
-    case 81:
+    case 1:
         return gdb_get_regl(mem_buf, env->npc);
-    case 82:
+    case 2:
         return gdb_get_regl(mem_buf, (cpu_get_ccr(env) << 32) |
                                      ((env->asi & 0xff) << 24) |
                                      ((env->pstate & 0xfff) << 8) |
                                      cpu_get_cwp64(env));
-    case 83:
+    case 3:
         return gdb_get_regl(mem_buf, cpu_get_fsr(env));
-    case 84:
+    case 4:
         return gdb_get_regl(mem_buf, env->fprs);
-    case 85:
+    case 5:
         return gdb_get_regl(mem_buf, env->y);
     }
 #endif
@@ -138,33 +148,6 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         } else {
             env->fpr[(n - 32) / 2].l.upper = tmp;
         }
-    } else {
-        /* Y, PSR, WIM, TBR, PC, NPC, FPSR, CPSR */
-        switch (n) {
-        case 64:
-            env->y = tmp;
-            break;
-        case 65:
-            cpu_put_psr(env, tmp);
-            break;
-        case 66:
-            env->wim = tmp;
-            break;
-        case 67:
-            env->tbr = tmp;
-            break;
-        case 68:
-            env->pc = tmp;
-            break;
-        case 69:
-            env->npc = tmp;
-            break;
-        case 70:
-            cpu_put_fsr(env, tmp);
-            break;
-        default:
-            return 0;
-        }
     }
     return 4;
 #else
@@ -185,32 +168,77 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
          * n == 79: f62 : env->fpr[31]
          */
         env->fpr[(n - 64) + 16].ll = tmp;
-    } else {
-        switch (n) {
-        case 80:
-            env->pc = tmp;
-            break;
-        case 81:
-            env->npc = tmp;
-            break;
-        case 82:
-            cpu_put_ccr(env, tmp >> 32);
-            env->asi = (tmp >> 24) & 0xff;
-            env->pstate = (tmp >> 8) & 0xfff;
-            cpu_put_cwp64(env, tmp & 0xff);
-            break;
-        case 83:
-            cpu_put_fsr(env, tmp);
-            break;
-        case 84:
-            env->fprs = tmp;
-            break;
-        case 85:
-            env->y = tmp;
-            break;
-        default:
-            return 0;
-        }
+    }
+    return 8;
+#endif
+}
+
+__attribute__((unused))
+static int sparc_cp0_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    CPUSPARCState *env = cpu_env(cs);
+
+#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
+    uint32_t tmp;
+
+    tmp = ldl_p(mem_buf);
+
+    /* Y, PSR, WIM, TBR, PC, NPC, FPSR, CPSR */
+    switch (n) {
+    case 0:
+        env->y = tmp;
+        break;
+    case 1:
+        cpu_put_psr(env, tmp);
+        break;
+    case 2:
+        env->wim = tmp;
+        break;
+    case 3:
+        env->tbr = tmp;
+        break;
+    case 4:
+        env->pc = tmp;
+        break;
+    case 5:
+        env->npc = tmp;
+        break;
+    case 6:
+        cpu_put_fsr(env, tmp);
+        break;
+    default:
+        return 0;
+    }
+    return 4;
+#else
+    uint64_t tmp;
+
+    tmp = ldq_p(mem_buf);
+
+    switch (n) {
+    case 0:
+        env->pc = tmp;
+        break;
+    case 1:
+        env->npc = tmp;
+        break;
+    case 2:
+        cpu_put_ccr(env, tmp >> 32);
+        env->asi = (tmp >> 24) & 0xff;
+        env->pstate = (tmp >> 8) & 0xfff;
+        cpu_put_cwp64(env, tmp & 0xff);
+        break;
+    case 3:
+        cpu_put_fsr(env, tmp);
+        break;
+    case 4:
+        env->fprs = tmp;
+        break;
+    case 5:
+        env->y = tmp;
+        break;
+    default:
+        return 0;
     }
     return 8;
 #endif
@@ -221,6 +249,9 @@ void sparc_cpu_register_gdb_regs(CPUState *cs)
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
     /* Not yet supported */
 #else
-    /* Not yet supported */
+    gdb_register_coprocessor(cs, sparc_cp0_gdb_read_register,
+                             sparc_cp0_gdb_write_register,
+                             gdb_find_static_feature("sparc64-cp0.xml"),
+                             0);
 #endif
 }
diff --git a/gdb-xml/sparc64-core.xml b/gdb-xml/sparc64-core.xml
index 375b9bb0cc6..1c26d8c01c1 100644
--- a/gdb-xml/sparc64-core.xml
+++ b/gdb-xml/sparc64-core.xml
@@ -89,11 +89,4 @@
   <reg name="f58" bitsize="64" type="ieee_double" regnum="77"/>
   <reg name="f60" bitsize="64" type="ieee_double" regnum="78"/>
   <reg name="f62" bitsize="64" type="ieee_double" regnum="79"/>
-
-  <reg name="pc" bitsize="64" type="code_ptr" regnum="80"/>
-  <reg name="npc" bitsize="64" type="code_ptr" regnum="81"/>
-  <reg name="state" bitsize="64" type="uint64" regnum="82"/>
-  <reg name="fsr" bitsize="64" type="uint64" regnum="83"/>
-  <reg name="fprs" bitsize="64" type="uint64" regnum="84"/>
-  <reg name="y" bitsize="64" type="uint64" regnum="85"/>
 </feature>
diff --git a/gdb-xml/sparc64-cp0.xml b/gdb-xml/sparc64-cp0.xml
new file mode 100644
index 00000000000..9b938dc7ecc
--- /dev/null
+++ b/gdb-xml/sparc64-cp0.xml
@@ -0,0 +1,16 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2013-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.sparc.cp0">
+  <reg name="pc" bitsize="64" type="code_ptr" regnum="80"/>
+  <reg name="npc" bitsize="64" type="code_ptr" regnum="81"/>
+  <reg name="state" bitsize="64" type="uint64" regnum="82"/>
+  <reg name="fsr" bitsize="64" type="uint64" regnum="83"/>
+  <reg name="fprs" bitsize="64" type="uint64" regnum="84"/>
+  <reg name="y" bitsize="64" type="uint64" regnum="85"/>
+</feature>
-- 
2.52.0


