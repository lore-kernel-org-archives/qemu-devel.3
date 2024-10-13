Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4855CF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pR-00077k-2N; Sun, 13 Oct 2024 18:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pQ-00077J-75
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:44 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pO-0000tt-CK
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:43 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2a999b287so2850979a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857561; x=1729462361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8ym6NLxoNvu+SOj1YsRaeOvfI7iJrafTEN4muCnoIE=;
 b=PqXzSt9nkLrEQLmFXdYaeSzAtNrSSJ9aM3c5+Ohl8HPp2NH/HPuI8xQuiKe6urdXr3
 Y/859erIANdDpfnjIoD6pUf4VeuTNPYW5PSGoSViQqws/qNCYvBvef/4FD/6JmJbe8Mq
 HQa2++Y5ZxamOP5OZ/v8il+EU16xgZB1F9JYhA9jfUGhlYT+rPgyjXvDcxJA+tx5sa5D
 MPN4kGM6OePuxcQ6xmL2nCFaS/Tee+S6q1qlkpoWRlSQQ7fI+gF6BPLNNGDLFFsec75R
 J+kA9WaaB+kUxxlkncUeVSN1H7+9+fBcSemw/Vhx3RNpNGVShuLUvUN72yANFWIRBr2q
 ILRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857561; x=1729462361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8ym6NLxoNvu+SOj1YsRaeOvfI7iJrafTEN4muCnoIE=;
 b=JvP4+SiZI8eb71x82ddPeLzlK6glFbxa5z74ZJWBwo7Cr2wYglcy7+18YKjA16Vugr
 xsdXPjdih+gEDjEZ/JaDzz4g8ZEsgoz/XBCCizCkgNBZYBD8KSPmIfCnTzObX1V+PoFv
 hZQItCqecjiXBs1iprMQPXNxNb7cHi/v4pzBeyrdH0H+gcnH+UqX/Jz7goe/VIihlX7e
 0UcBVMYcBWnFQs8FNKWSxxCXeQW7SKiMi/pCriiPeuxVVzbAsBH7toiutf4MOf2gt5T0
 Bmd9YcCfTJybbeymySGDV48ARZ/cBWxFFdWl0cj9nGpPYzYahzpqafxLrFx4D4xfu6G1
 2MTw==
X-Gm-Message-State: AOJu0YxqWMLs1oJgnDfqvudmQqTSahPvQWrOqIWtuBTMdU9N+vQ423nA
 xRIxCukaEtMsCTpOFCeL/z0wLW9n4kSzlISZXJeJ7z8l4BWPwiJZmsjtOBjnia58BVREdEGgqnV
 9
X-Google-Smtp-Source: AGHT+IHWnNiIXpnTD8cm8+35JeXmrYMBP90R1Lxi3XKuJdKRPVisipex8kl+OarBqksPeznQczuUnA==
X-Received: by 2002:a17:90b:d97:b0:2e2:ebbb:7619 with SMTP id
 98e67ed59e1d1-2e2f0ab98cfmr11287608a91.9.1728857561006; 
 Sun, 13 Oct 2024 15:12:41 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 05/27] target/i386/gdbstub: Expose orig_ax
Date: Sun, 13 Oct 2024 15:12:13 -0700
Message-ID: <20241013221235.1585193-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Copy XML files describing orig_ax from GDB and glue them with
CPUX86State.orig_ax.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240912093012.402366-5-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h                     |  1 +
 target/i386/cpu.c                     |  1 +
 target/i386/gdbstub.c                 | 51 +++++++++++++++++++++++++++
 configs/targets/i386-linux-user.mak   |  2 +-
 configs/targets/x86_64-linux-user.mak |  2 +-
 gdb-xml/i386-32bit-linux.xml          | 11 ++++++
 gdb-xml/i386-64bit-linux.xml          | 11 ++++++
 7 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 gdb-xml/i386-32bit-linux.xml
 create mode 100644 gdb-xml/i386-64bit-linux.xml

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c39384ac0..4c63e7b045 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2226,6 +2226,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void x86_cpu_gdb_init(CPUState *cs);
 
 void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff227a8c5c..0d30191482 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7831,6 +7831,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     mce_init(cpu);
 
+    x86_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
 
     /*
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index cc5eceeb7e..04c49e802d 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -18,8 +18,13 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "accel/tcg/vcpu-state.h"
 #include "cpu.h"
+#include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
+#ifdef CONFIG_LINUX_USER
+#include "linux-user/qemu.h"
+#endif
 
 #ifdef TARGET_X86_64
 static const int gpr_map[16] = {
@@ -406,3 +411,49 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     /* Unrecognised register.  */
     return 0;
 }
+
+#ifdef CONFIG_LINUX_USER
+
+#define IDX_ORIG_AX 0
+
+static int x86_cpu_gdb_read_linux_register(CPUState *cs, GByteArray *mem_buf,
+                                           int n)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    switch (n) {
+    case IDX_ORIG_AX:
+        return gdb_get_reg(env, mem_buf, get_task_state(cs)->orig_ax);
+    }
+    return 0;
+}
+
+static int x86_cpu_gdb_write_linux_register(CPUState *cs, uint8_t *mem_buf,
+                                            int n)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    switch (n) {
+    case IDX_ORIG_AX:
+        return gdb_write_reg(env, mem_buf, &get_task_state(cs)->orig_ax);
+    }
+    return 0;
+}
+
+#endif
+
+void x86_cpu_gdb_init(CPUState *cs)
+{
+#ifdef CONFIG_LINUX_USER
+    gdb_register_coprocessor(cs, x86_cpu_gdb_read_linux_register,
+                             x86_cpu_gdb_write_linux_register,
+#ifdef TARGET_X86_64
+                             gdb_find_static_feature("i386-64bit-linux.xml"),
+#else
+                             gdb_find_static_feature("i386-32bit-linux.xml"),
+#endif
+                             0);
+#endif
+}
diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index 5b2546a430..b72a156473 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
-TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+TARGET_XML_FILES= gdb-xml/i386-32bit.xml gdb-xml/i386-32bit-linux.xml
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 9ceefbb615..86042814d3 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,4 +2,4 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml
diff --git a/gdb-xml/i386-32bit-linux.xml b/gdb-xml/i386-32bit-linux.xml
new file mode 100644
index 0000000000..5ffe5616e6
--- /dev/null
+++ b/gdb-xml/i386-32bit-linux.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2024 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.linux">
+  <reg name="orig_eax" bitsize="32" type="int"/>
+</feature>
diff --git a/gdb-xml/i386-64bit-linux.xml b/gdb-xml/i386-64bit-linux.xml
new file mode 100644
index 0000000000..0f26990d2f
--- /dev/null
+++ b/gdb-xml/i386-64bit-linux.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2024 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.linux">
+  <reg name="orig_rax" bitsize="64" type="int"/>
+</feature>
-- 
2.43.0


