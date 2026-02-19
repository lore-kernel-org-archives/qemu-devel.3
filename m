Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4836AE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9bi-0002vH-5S; Thu, 19 Feb 2026 14:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ay-0002W6-3b
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9au-00086L-3x
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso14851855e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528906; x=1772133706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBslSAoVL6gslfaibh72PbWC4QaSzp3PaLMupF2j1EA=;
 b=K1pqDAmpYgDuBKAwecufOFmEyW/A/aX1YihG5UHh1IMWP6204ghhNMypqbp0r79b9h
 RHgbRPcSHFpBx8o1g8msw8Ez0/yD6kY7pdUzyTXuSYFC0AuFMDlX3iOrDUhJ5v2X5Xuz
 tEqUAaSWFuHIz2/PWuRDlr+mBCoVFP43wsCJGs0OJQZ+i9HJYhksot5WRaW6iNlpqx3s
 tleV29dOlfoblnfkPEhwOhLo9oCiE115oHbu44sjdylO9g1wtJ78jkgyieTAm4clqSag
 zjlo9D8Wh623iOkB4FlOBgvjEQI27Kh+Cu4gxKrsZ++9ZHk6rCiu30fbaytaMggfb3RE
 jTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528906; x=1772133706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iBslSAoVL6gslfaibh72PbWC4QaSzp3PaLMupF2j1EA=;
 b=W/b7OshDNKLRpA0MFWgjUhWCnC/+JVVB+rkU/STS3iJFT8WY5+I3vwsWBN0SFJxMG5
 bI7ikodwZ4NoYqMQUCxReOTP4uP83DkqwoQpU875G9DtmIY8ZU6DH2gLkhKykGvxWJmV
 zGSyzU+CNej4Y3I9djQRTPaXKsOJqz3WHDj6A71tG4jVODsxDpQRFuEC0y0bAD7bbHzL
 PxyAluOLG1f+E9xLWTUDzPsj+AvSGYq3yCjC/vT6eTPUcp08JgL6RGenZTra33NBfwmk
 Mt7e0N8u7/p/riFr0ZFCHC+b81vK5J4ULWkfU8EXX8PZna0110aGprYSLXpKrAdrdaQI
 y/UA==
X-Gm-Message-State: AOJu0YxMSEpoXb7EnZYk0U4PpafdszILi8p/9sEhbCLHtnAU1y5/LYKc
 eq5k4w5krmj6au5qVhpBLjAskIFLVJqv038GwFJXiED2mfud8s7UoJlX+CeIsesZBePQkRB//4X
 f/VS2enixAg==
X-Gm-Gg: AZuq6aIATrKj7X5gwS43YUbIAhglN0FFXQDJ8/vB5gJgcw+N5aOjtds2KlUcjTkJiFx
 cpupyKJjBpq9r7enLRa/nxuOw16Pdqu3ZvAf3KMBKfs4YoZcHsFeyUtRSi0XqDSYCKX4i8dwIkH
 gifxy6e+R54bDWjDOHdLBY8+ZXMWqxn46YOwLJI/ErBz49pCKGF24n451/eVRlqTYVyKqZUSmk/
 YisE22m+wbkPU1R8P6T8aj0Af9HwAdoXsYIJUoTjQV5scyLReugWZvfSEYhIaa7eqEDAr0RqEih
 IbpZzrqPWI3vT7XmbvmhvzXVifqt1Sp6DfszBvIoqzeYFbf44n2xEpIN/iyrwTZ84EycEhEePas
 15CDH0sRIwX9Sc8wQOxggcZ7iZfOYDVyZ9ck2ZJkb4NGLJkMNl2WSaOId5nTtGhL8jIQsHJ7WRq
 pUI+8kTiUPitLZJTm05N7DFItxHuwC0PSH/ShcLFDUJjqkisUbqsZVWUWI4Z2vwnkvOZogGtyQ
X-Received: by 2002:a05:600c:8b61:b0:47e:e78a:c832 with SMTP id
 5b1f17b1804b1-48379c286d4mr306325785e9.37.1771528906207; 
 Thu, 19 Feb 2026 11:21:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a316eb08sm25010325e9.0.2026.02.19.11.21.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:21:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 15/50] target/sparc: Expose gdbstub registers to sparc32
 targets
Date: Thu, 19 Feb 2026 20:19:17 +0100
Message-ID: <20260219191955.83815-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Import gdb-xml/sparc32-{cpu,fpu,cp0}.xml from mainstream binutils,
tag 'binutils-2_46', found in the gdb/features/sparc/folder [*].

Register them by setting the CPUClass::gdb_core_xml_file field and
calling gdb_register_coprocessor() in sparc_cpu_register_gdb_regs().

[*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc-linux-user.mak |  1 +
 configs/targets/sparc-softmmu.mak    |  1 +
 target/sparc/cpu.c                   |  2 +-
 target/sparc/gdbstub.c               | 13 +++++----
 gdb-xml/sparc32-cp0.xml              | 18 ++++++++++++
 gdb-xml/sparc32-cpu.xml              | 42 ++++++++++++++++++++++++++++
 gdb-xml/sparc32-fpu.xml              | 42 ++++++++++++++++++++++++++++
 7 files changed, 113 insertions(+), 6 deletions(-)
 create mode 100644 gdb-xml/sparc32-cp0.xml
 create mode 100644 gdb-xml/sparc32-cpu.xml
 create mode 100644 gdb-xml/sparc32-fpu.xml

diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index d3f0716ca2d..01446e28783 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -2,5 +2,6 @@ TARGET_ARCH=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml gdb-xml/sparc32-cp0.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index c4c38946d54..ed846735f41 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,5 +1,6 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml gdb-xml/sparc32-cp0.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index d82f858efb1..1493336e7a2 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1095,7 +1095,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
     cc->gdb_core_xml_file = "sparc64-cpu.xml";
 #else
-    cc->gdb_num_core_regs = 72;
+    cc->gdb_core_xml_file = "sparc32-cpu.xml";
 #endif
     cc->tcg_ops = &sparc_tcg_ops;
 }
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index b5b1494950a..ed52e521dcc 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -43,7 +43,6 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     return 0;
 }
 
-__attribute__((unused))
 static int sparc_fpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CPUSPARCState *env = cpu_env(cs);
@@ -79,7 +78,6 @@ static int sparc_fpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     return 0;
 }
 
-__attribute__((unused))
 static int sparc_cp0_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CPUSPARCState *env = cpu_env(cs);
@@ -154,7 +152,6 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #endif
 }
 
-__attribute__((unused))
 static int sparc_fpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUSPARCState *env = cpu_env(cs);
@@ -197,7 +194,6 @@ static int sparc_fpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #endif
 }
 
-__attribute__((unused))
 static int sparc_cp0_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUSPARCState *env = cpu_env(cs);
@@ -271,7 +267,14 @@ static int sparc_cp0_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 void sparc_cpu_register_gdb_regs(CPUState *cs)
 {
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
-    /* Not yet supported */
+    gdb_register_coprocessor(cs, sparc_fpu_gdb_read_register,
+                             sparc_fpu_gdb_write_register,
+                             gdb_find_static_feature("sparc32-fpu.xml"),
+                             0);
+    gdb_register_coprocessor(cs, sparc_cp0_gdb_read_register,
+                             sparc_cp0_gdb_write_register,
+                             gdb_find_static_feature("sparc32-cp0.xml"),
+                             0);
 #else
     gdb_register_coprocessor(cs, sparc_fpu_gdb_read_register,
                              sparc_fpu_gdb_write_register,
diff --git a/gdb-xml/sparc32-cp0.xml b/gdb-xml/sparc32-cp0.xml
new file mode 100644
index 00000000000..eacd89cf3b5
--- /dev/null
+++ b/gdb-xml/sparc32-cp0.xml
@@ -0,0 +1,18 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2013-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.sparc.cp0">
+  <reg name="y" bitsize="32" type="uint32" regnum="64"/>
+  <reg name="psr" bitsize="32" type="uint32" regnum="65"/>
+  <reg name="wim" bitsize="32" type="uint32" regnum="66"/>
+  <reg name="tbr" bitsize="32" type="uint32" regnum="67"/>
+  <reg name="pc" bitsize="32" type="code_ptr" regnum="68"/>
+  <reg name="npc" bitsize="32" type="code_ptr" regnum="69"/>
+  <reg name="fsr" bitsize="32" type="uint32" regnum="70"/>
+  <reg name="csr" bitsize="32" type="uint32" regnum="71"/>
+</feature>
diff --git a/gdb-xml/sparc32-cpu.xml b/gdb-xml/sparc32-cpu.xml
new file mode 100644
index 00000000000..242295c886e
--- /dev/null
+++ b/gdb-xml/sparc32-cpu.xml
@@ -0,0 +1,42 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2013-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.sparc.cpu">
+  <reg name="g0" bitsize="32" type="uint32" regnum="0"/>
+  <reg name="g1" bitsize="32" type="uint32" regnum="1"/>
+  <reg name="g2" bitsize="32" type="uint32" regnum="2"/>
+  <reg name="g3" bitsize="32" type="uint32" regnum="3"/>
+  <reg name="g4" bitsize="32" type="uint32" regnum="4"/>
+  <reg name="g5" bitsize="32" type="uint32" regnum="5"/>
+  <reg name="g6" bitsize="32" type="uint32" regnum="6"/>
+  <reg name="g7" bitsize="32" type="uint32" regnum="7"/>
+  <reg name="o0" bitsize="32" type="uint32" regnum="8"/>
+  <reg name="o1" bitsize="32" type="uint32" regnum="9"/>
+  <reg name="o2" bitsize="32" type="uint32" regnum="10"/>
+  <reg name="o3" bitsize="32" type="uint32" regnum="11"/>
+  <reg name="o4" bitsize="32" type="uint32" regnum="12"/>
+  <reg name="o5" bitsize="32" type="uint32" regnum="13"/>
+  <reg name="sp" bitsize="32" type="uint32" regnum="14"/>
+  <reg name="o7" bitsize="32" type="uint32" regnum="15"/>
+  <reg name="l0" bitsize="32" type="uint32" regnum="16"/>
+  <reg name="l1" bitsize="32" type="uint32" regnum="17"/>
+  <reg name="l2" bitsize="32" type="uint32" regnum="18"/>
+  <reg name="l3" bitsize="32" type="uint32" regnum="19"/>
+  <reg name="l4" bitsize="32" type="uint32" regnum="20"/>
+  <reg name="l5" bitsize="32" type="uint32" regnum="21"/>
+  <reg name="l6" bitsize="32" type="uint32" regnum="22"/>
+  <reg name="l7" bitsize="32" type="uint32" regnum="23"/>
+  <reg name="i0" bitsize="32" type="uint32" regnum="24"/>
+  <reg name="i1" bitsize="32" type="uint32" regnum="25"/>
+  <reg name="i2" bitsize="32" type="uint32" regnum="26"/>
+  <reg name="i3" bitsize="32" type="uint32" regnum="27"/>
+  <reg name="i4" bitsize="32" type="uint32" regnum="28"/>
+  <reg name="i5" bitsize="32" type="uint32" regnum="29"/>
+  <reg name="fp" bitsize="32" type="uint32" regnum="30"/>
+  <reg name="i7" bitsize="32" type="uint32" regnum="31"/>
+</feature>
diff --git a/gdb-xml/sparc32-fpu.xml b/gdb-xml/sparc32-fpu.xml
new file mode 100644
index 00000000000..38217ca7a92
--- /dev/null
+++ b/gdb-xml/sparc32-fpu.xml
@@ -0,0 +1,42 @@
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
+</feature>
-- 
2.52.0


