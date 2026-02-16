Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEA7E83840
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7T0-0002Os-41; Mon, 16 Feb 2026 17:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7Sy-0002Jl-Fq
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7Sw-0006VC-8t
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso31060435e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282396; x=1771887196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+g06lYMZoxaawxhYckKVy1oz0aLxQfVGw0j/XCTRlo8=;
 b=TQfuuJR/W0ocAdej7PIysq8jorG9btBTK0PS/6CWOWk8ITY8lbtCR0NUoaxuYQCXL9
 rtCH60FIyq1Kuqab3Bo3CjZBnagsAKPx9Igaxe4VeBp4hTYZ451s7hmDNnbJCyjGpY9g
 zvfbzVZ3GZYtOLb/WopXG9FJx46Jd54R6kid6RpIo/WnnxwS6m/L7ysxY8gDMoSJBsbm
 DGY5/MdfZGDiB7r8VhzB1vcVZFHl3hYroVSnCY1kzi44YzVL8eAEMoRceOAE9jGji1kA
 kQ3nPipUu1sc5JGeVNvY0dkrGGaXNDLsIj/3mMSO53AwwNxrPaXr7pSw5/Pewipy64wq
 QBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282396; x=1771887196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+g06lYMZoxaawxhYckKVy1oz0aLxQfVGw0j/XCTRlo8=;
 b=XOzakDueqQQdUkR/jlvjH8vFGabBXkOCj11URtzXLsqQeksCY+N1cskYyYXwmAeNrl
 n0UvnrCdQ8Ajwkfbmkb0eAxrvJAEhM5QxYIi2RT+PNWk6RyUKYBVsmiDN478FwQ7PAiw
 uVQ9DIygR+GT/Pk4xjzvdbU10bsUs1O+sjWjuX8moOZMFFuSRZCH1nH4WQP8K9t6MW0F
 cXgJRe4Kli1NpkP1VohuEWrDTNsgXX3cYjKPc856iCvEHAArftEFs7JZH0nWjS5/vqjn
 tA/uvTybxp4uW3GmvKqPz+GAYDGThIwIbZ3Ey2JVerMnQK/tKc7ligaaRt/WqeRlBqZw
 2AFg==
X-Gm-Message-State: AOJu0YxoDTgW6J8ksBMAmMbT7a0hfskN8skZkpcnwnZJjOTtJbngVslW
 yoyBUnyO6Oo/3A6tQeXUN8WIZdZvpXZprSl0O2N9rCjmrI2xjYVQs0JJ7FjBIsLjXX0rmkkKVBC
 62W48AjI=
X-Gm-Gg: AZuq6aIy/x2I10A1tYCv1kvLSGfOXH0zxctXWw+8evwB9VNQHU+59nriG3oSWd8YmEN
 rkiWn8X85wIRpmJ5gpxSukJlEp0VsQlREwnTevCQqTMM4Yka0etCGn+/p+dZWwamEtAMP/S9fYE
 s5T4YcEG/C5Fxsxk0VY9E+JLVGwENj6Lpma7P9ReuNMEWTOurQV0wbaGW3AORJ52BaP8vIuKBkL
 aKJg2uRSGAaEc/M/7hNjwPOcBtdyJgq5EMfj+R8WmodbEdKSbRM9W15gbQP8lQCGYYSqPt6jw/g
 Fg1bUdKHYww/DIZdnnPi7F2VlJi7FpRn1LYPXQ2P1TLnyfk3Ox2t0dkIa+I8e7FxYuogNjDxv9u
 I9HXf1atU2yMjtvMLVNIPjMcSRP+rR5ymoYPRPbqOS6Q5W5cYMLJRmbZmP2+cIYvc95Vdu8cE88
 ZRMtJdwP/+GW3nQFpaHSXxOiHTrznzRXcQ1DBtit/rhtblkAwhmNwgr3y2S+a4fEm2kkq4vaEd
X-Received: by 2002:a05:600c:8b2f:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-48379c1faccmr122104925e9.29.1771282396044; 
 Mon, 16 Feb 2026 14:53:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a29982sm92061485e9.15.2026.02.16.14.53.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:15 -0800 (PST)
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
Subject: [PATCH 06/11] target/sparc: Expose gdbstub registers to sparc32
 targets
Date: Mon, 16 Feb 2026 23:52:22 +0100
Message-ID: <20260216225228.53959-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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
 target/sparc/cpu.c                   |  3 +-
 target/sparc/gdbstub.c               | 13 +++++----
 gdb-xml/sparc32-cp0.xml              | 18 ++++++++++++
 gdb-xml/sparc32-cpu.xml              | 42 ++++++++++++++++++++++++++++
 gdb-xml/sparc32-fpu.xml              | 42 ++++++++++++++++++++++++++++
 7 files changed, 114 insertions(+), 6 deletions(-)
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
index 08ebbd3640b..ec454affaad 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1096,7 +1096,8 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_core_xml_file = "sparc64-cpu.xml";
     cc->gdb_num_core_regs = 32;
 #else
-    cc->gdb_num_core_regs = 72;
+    cc->gdb_core_xml_file = "sparc32-cpu.xml";
+    cc->gdb_num_core_regs = 32;
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


