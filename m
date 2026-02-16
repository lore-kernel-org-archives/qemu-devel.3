Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96EEE83840
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7SW-0001oQ-RG; Mon, 16 Feb 2026 17:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7SV-0001no-6l
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7ST-0006SQ-7u
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so2953686f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282367; x=1771887167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9RadEY770T8BkT80nF7ZFO+SaaJXMTONCcTkYs0sK4=;
 b=a9rY5x3e1nGjCmF5TBHm3q53odWbiLd5vGWi3pkAcBalSkIJcWHeL6WbhdqWfFzNLn
 kp2Ss4tc1by9idMWevoWyrN4TZi17AE5/cNjC98ganGyuc9t5rGQlnWSUfh/hx2+mdwY
 jlR8YvQdrYRnRxxtm1d6k05j39L9ojrklpd9IjuuZqH+ftHxcuvyka+t5MewJRkRlxxU
 Etzp9HVqVGFlZXfUJ1WhXDcGhFfeXADF82uuHMcXn9NQgI7FCU7csbkRgJIBUBEFGUqp
 ssSR2QEpYbe2gzShnMwy755YFL+HJR1o8YgxdCyadYlvOpcNR43ALiukSH5oAiG0kMeB
 leFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282367; x=1771887167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e9RadEY770T8BkT80nF7ZFO+SaaJXMTONCcTkYs0sK4=;
 b=wM8qsTNQ/gGDlgigWlmcDj9irmdgPS4Bg5Y1EVkMcUiiS/c2Rl4NEWwqLFKPhqZ+Y9
 uM9uCBMNvHSDiaFtZ5MlOrrGsdKN/HsD1maUemXxJ7iM7Gp2TLNdsmcYHec8H4cdxlQF
 ig6xQB6c3pXe3VB9o6YdCRctwNStd9TpfBdpJt5MRuICHz2rQdqRYLEF76LoD/yS6D6i
 yi2DtJGYFt27VCqrnNjZcUyzU+gCD6TNddhihI4zRyZ+Nuc4de1sdKTNOotihUS8er8E
 kdlNw364q/3B1dTXJzN+ignsR111u1Db2uZr5XMmxGxMDiA0L3BiqikgebaAn9HWyHIO
 vqZA==
X-Gm-Message-State: AOJu0Yw7uNhl4MVCxeMGe5hsX3p6yJu4bawr/C9o5GS+eknYxrsAOYmg
 Lwo0hWkKZ9R9EjiyO4zK8N9AOG54Abfibhs0dE8R15Lxz9ngFD6iPX8hOBE8Avh7LXh5DNzW/YB
 elmpRugA=
X-Gm-Gg: AZuq6aJOZTg7BGl7FqWh+MWxuoD4WfJgg1ue+yuATcprskR3BMOSKNlOS8JIJblr2G6
 sDWm0uXh13B98DB0lkdxtEDx/+HU+7+uOvsSjfcX7QA7FJqldCcqD2+5xV/WcKsbi5Gj3ypV1wK
 5V3OEwDoKvYsBwP83AfDyfumhAQCv/qbdHEmkb3yTWwWfn7kiErsBYt+a2etg1mmYBfJ5oM+AhX
 wu+Wvk4dxAKBhuylTklV7N7DF3VxkVP+4bix7v6p3ADeiKLBBaA3OFEuRLQ9FhetM1NAoVrgyer
 uMFYBOVtBPl2Ik7htx12Od4B1W08GP8m/0wF6P0qrmc4/cSVFwpr8ZdhMJPIp/YsiY1EnKVEsU+
 WzBrBD7tOPpTSk5fRu5chS9Eorkx8o1ZYGxuQojXCEJgemKI9PE0IzQaI5MjFpmSGgTxEoJoBjd
 WV2bKCzeQ0iJkjerJmpgJHduVLLEKmNZSS5RZgc+yGteHuPpvawWys0iCcAj8auN0XIeiKuP72
X-Received: by 2002:a05:6000:1ace:b0:437:6963:a115 with SMTP id
 ffacd0b85a97d-4379dba6814mr17409563f8f.42.1771282367365; 
 Mon, 16 Feb 2026 14:52:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5acaasm27211976f8f.6.2026.02.16.14.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:52:46 -0800 (PST)
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
Subject: [PATCH 02/11] target/sparc: Restore 'gdb-xml/sparc64-cp0.xml'
Date: Mon, 16 Feb 2026 23:52:18 +0100
Message-ID: <20260216225228.53959-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

Restore gdb-xml/sparc64-cp0.xml from mainstream binutils, tag
'binutils-2_46', found in the gdb/features/sparc/folder [*].

Extract sparc_cp0_gdb_write_register() out of
sparc_cpu_gdb_read_register() and sparc_cp0_gdb_write_register()
out of sparc_cpu_gdb_write_register(), taking care to update the
register indexes in the switch cases.

Register these helpers with a call to gdb_register_coprocessor()
in sparc_cpu_register_gdb_regs().

[*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc64-linux-user.mak |   2 +-
 configs/targets/sparc64-softmmu.mak    |   2 +-
 target/sparc/cpu.c                     |   2 +-
 target/sparc/gdbstub.c                 | 193 ++++++++++++++-----------
 gdb-xml/sparc64-core.xml               |   7 -
 gdb-xml/sparc64-cp0.xml                |  16 ++
 6 files changed, 131 insertions(+), 91 deletions(-)
 create mode 100644 gdb-xml/sparc64-cp0.xml

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
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index f58d0298966..6f7b250abb3 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1094,7 +1094,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
     cc->gdb_core_xml_file = "sparc64-core.xml";
-    cc->gdb_num_core_regs = 86;
+    cc->gdb_num_core_regs = 80;
 #else
     cc->gdb_num_core_regs = 72;
 #endif
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


