Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E4EE9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9cq-0006OW-W9; Thu, 19 Feb 2026 14:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bk-0003Ga-8q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bh-0008Fh-BP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:39 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so10136835e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528955; x=1772133755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9iEphdQeaiZaph+ao0QTT23RTfI+/n5dC07U1n0Jv0=;
 b=yWDN2BicnBpyFy6LIcQPWUbkr2EnYOk+vvSSIiVHC6ecWwcy3KH3CQJOgPK17OX5b1
 8OF202/+Nfibb7HZtPgDp9eUI8HvDfzkaVo5AqTzImaQtR8hQFyzJaSxhhH2hjD93idU
 mTJRj3khagdW84Zb3T4VwVWnE0SQKDXUfxYdU1WGhFLJqkk8VQk9FyXds+RQHQZnOEmF
 0Y7DTc4RGojIzjSkL3upENWb7xnMgP1+k5Ew9V7TyipFkQ0674wRET8Y93OOXwi/gb5d
 Ej8zZWonKsiHyhx3iYU+es6BT6eSEFR45KlTVru0KUS6lYcBVdQGrAIcpmpzboo72vel
 sDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528955; x=1772133755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V9iEphdQeaiZaph+ao0QTT23RTfI+/n5dC07U1n0Jv0=;
 b=KTOwN80220oYDOTO/0swwUvOhyfwaXZ9km49F7XgZGAyb8pM4yo4nOemgSNMjT4yJI
 SdG8+eUsS0i4yYTMlFtnB1H9CZqYZS9ah3PS2W56x0n2qsfOtUI2VmW7X/u8LRUujAu0
 r3eJK0UVUUoLdsm5/jOt6+U8hnCBxkH8Ggp0+GHhqTE5O83Wp6XdM2r4pcadUkcJd+cI
 auoruP5pQ50w1w/DPr65gJ1v+Z8yETizd/v6+DFOSJS2JODUOZS0kzzUvtki9V9H7bej
 0BrxsSDLpUoATW+OrxOxJmDfkAwmk5j9AW0dr9U1uX/DpzuYdaa01oD8iCYv46060iry
 aejg==
X-Gm-Message-State: AOJu0YxenNZB7icN02R7e8BaxOyVw2MHgyfFP39Z4bdo+3KrgB+FpZ9W
 iiqd5nXuqgMWG2eu525fuvVHN8poU0gBCEJlYmLX9v2c6ELu1Xbwe2lp+BCSlFQufvGD2A77maF
 hKOhtpejmN44M
X-Gm-Gg: AZuq6aIwVZZwfv9k6ie2KkxdDg0VyUSI/8PNtsldYLcYFrSYNtCHR0XJte1xsaRIGny
 wx8/hOPtRYjWkxpP4god5XCEm8gPy1LlfpAF73K1Z656PVayssl9HrcHaBMpPy9hHWFDHJjngSk
 OQBQOQRaKi/t/8AmAAdFXym5L548Xi5l/7rKi0GhWSVVYOpY9JqmavppE/5DuHUiLnB3UFkR4vG
 KicyuQ6BMduqdv4k9iOPWGWBLF2EZiRXiAdsWyNvKs0TiEM0RGlkdqkqtsliBIdt1U43t/A3Kt9
 WpGwgMfHiYA+YeEXshFXChIQz8Ew1IxToLOlB3aqSANVcAVIZVdpy6+R5ceacq5f3t4wZx1tMfV
 hB4BHFgFYI7G+VdVDeqXkMBrDWSblhlTmCzt8vouoFIZGeFcM2vSUYlJtQLmFqHN7kB9UY4TMg8
 vzBm1TwM81oT7IMmKyigWYqWkpyOc+mPsku4QF9SUx+StkXdN5MJx+j3rz92h6f7iBLeBtlpqc
X-Received: by 2002:a05:600c:8b70:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-48398a548c5mr122277135e9.9.1771528955411; 
 Thu, 19 Feb 2026 11:22:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8075sm48232894f8f.29.2026.02.19.11.22.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 22/50] target/or1k: Use XML register definitions from GDB
Date: Thu, 19 Feb 2026 20:19:24 +0100
Message-ID: <20260219191955.83815-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Import gdb-xml/or1k-fpu.xml from mainstream binutils, tag
'binutils-2_46' [*]. Register as CPUClass::gdb_core_xml_file.

[*] https://sourceware.org/git/?p=binutils-gdb.git;a=blob_plain;f=gdb/features/or1k-core.xml;h=0d13f355f5296ae426794eb3003dcc18fbbd49d5;hb=refs/tags/binutils-2_46

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/or1k-linux-user.mak |  1 +
 configs/targets/or1k-softmmu.mak    |  1 +
 target/or1k/cpu.c                   |  2 +-
 gdb-xml/or1k-core.xml               | 65 +++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 gdb-xml/or1k-core.xml

diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 0ee3a05884d..9f8c178ef10 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -2,5 +2,6 @@ TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
+TARGET_XML_FILES= gdb-xml/or1k-core.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 204283d604f..24d89bc3e65 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -2,6 +2,7 @@ TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
+TARGET_XML_FILES= gdb-xml/or1k-core.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index c64542a59a2..3d1c22bf75d 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -288,13 +288,13 @@ static void openrisc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
+    cc->gdb_core_xml_file = "or1k-core.xml";
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
     cc->gdb_write_register = openrisc_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     dc->vmsd = &vmstate_openrisc_cpu;
     cc->sysemu_ops = &openrisc_sysemu_ops;
 #endif
-    cc->gdb_num_core_regs = 32 + 3;
     cc->disas_set_info = openrisc_disas_set_info;
     cc->tcg_ops = &openrisc_tcg_ops;
 }
diff --git a/gdb-xml/or1k-core.xml b/gdb-xml/or1k-core.xml
new file mode 100644
index 00000000000..0d13f355f52
--- /dev/null
+++ b/gdb-xml/or1k-core.xml
@@ -0,0 +1,65 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2017-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.or1k.group0">
+  <reg name="r0" bitsize="32" type="int"/>
+  <reg name="r1" bitsize="32" type="data_ptr"/>
+  <reg name="r2" bitsize="32" type="data_ptr"/>
+  <reg name="r3" bitsize="32" type="int"/>
+  <reg name="r4" bitsize="32" type="int"/>
+  <reg name="r5" bitsize="32" type="int"/>
+  <reg name="r6" bitsize="32" type="int"/>
+  <reg name="r7" bitsize="32" type="int"/>
+  <reg name="r8" bitsize="32" type="int"/>
+  <reg name="r9" bitsize="32" type="code_ptr"/>
+  <reg name="r10" bitsize="32" type="int"/>
+  <reg name="r11" bitsize="32" type="int"/>
+  <reg name="r12" bitsize="32" type="int"/>
+  <reg name="r13" bitsize="32" type="int"/>
+  <reg name="r14" bitsize="32" type="int"/>
+  <reg name="r15" bitsize="32" type="int"/>
+  <reg name="r16" bitsize="32" type="int"/>
+  <reg name="r17" bitsize="32" type="int"/>
+  <reg name="r18" bitsize="32" type="int"/>
+  <reg name="r19" bitsize="32" type="int"/>
+  <reg name="r20" bitsize="32" type="int"/>
+  <reg name="r21" bitsize="32" type="int"/>
+  <reg name="r22" bitsize="32" type="int"/>
+  <reg name="r23" bitsize="32" type="int"/>
+  <reg name="r24" bitsize="32" type="int"/>
+  <reg name="r25" bitsize="32" type="int"/>
+  <reg name="r26" bitsize="32" type="int"/>
+  <reg name="r27" bitsize="32" type="int"/>
+  <reg name="r28" bitsize="32" type="int"/>
+  <reg name="r29" bitsize="32" type="int"/>
+  <reg name="r30" bitsize="32" type="int"/>
+  <reg name="r31" bitsize="32" type="int"/>
+  <reg name="ppc" bitsize="32" type="code_ptr"/>
+  <reg name="npc" bitsize="32" type="code_ptr"/>
+  <flags id="sr_flags" size="4">
+    <field name="SM" start="0" end="0"/>
+    <field name="TEE" start="1" end="1"/>
+    <field name="IEE" start="2" end="2"/>
+    <field name="DCE" start="3" end="3"/>
+    <field name="ICE" start="4" end="4"/>
+    <field name="DME" start="5" end="5"/>
+    <field name="IME" start="6" end="6"/>
+    <field name="LEE" start="7" end="7"/>
+    <field name="CE" start="8" end="8"/>
+    <field name="F" start="9" end="9"/>
+    <field name="CY" start="10" end="10"/>
+    <field name="OV" start="11" end="11"/>
+    <field name="OVE" start="12" end="12"/>
+    <field name="DSX" start="13" end="13"/>
+    <field name="EPH" start="14" end="14"/>
+    <field name="FO" start="15" end="15"/>
+    <field name="SUMRA" start="16" end="16"/>
+    <field name="CID" start="28" end="31"/>
+  </flags>
+  <reg name="sr" bitsize="32" type="sr_flags"/>
+</feature>
-- 
2.52.0


