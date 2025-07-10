Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA7C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZon7-00028G-1U; Thu, 10 Jul 2025 06:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomf-0001r7-V0
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomZ-000784-Sn
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:44 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so705487f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144336; x=1752749136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iz/LY4KOmNjK8aVdmnn+2X+hPVBWX9P2bT1YuqmMXP8=;
 b=xGnF/o9vL62rNQM0guLm7ewll9b/nPbuSue+LQW8uQDmEI6l28psxIyvJjgXG6t6FT
 eogFgWoqfSJcMHaYog8vUPdI4oA5icfWgsXni7VJzjDRFn9RtAafurHuThwzw4sD7PIR
 /Pqa6Y7XkRvnZ1H4udD8Phhux+afIYQ16LriOUifXpCY8nameIRUt393h0YsOHl8gDk0
 +AylzaZegYgPOf8VqtZTpOfE4XELCixdr0IfVT/LBKHEu0LSNPQhaunFWN8AfVG1I/zJ
 97I/paJu3ILGT42GgSFH3dwuQ/hRMDDSOa+KngCljoFyTyOSN+SzG1dgNLjNX37HDZoN
 uZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144336; x=1752749136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iz/LY4KOmNjK8aVdmnn+2X+hPVBWX9P2bT1YuqmMXP8=;
 b=EkquMrjQKp3mKjiLzC34F/PC8NA2yytQsRhooq8JZG7kIG9H4gBaUHEVSVfFKjP/uE
 Ql6rEPR6IoUGfi/rsjqQGIBQMzlcjTeoIncSVf1MLgB/AiKF1cYt1qZhAmsQ5zXmwu0W
 +vRQtX2aK5doXbzBd95J2XvXuO+8ljk0f1CJo2OrQKgiglL08O6RSfVZGsdI2uMVyfa3
 bj3iG+xEJqaK022Dr25K8pfRL6QWaUxrK3Nbc45UCTsRBIZ8EHwi9VvPf9rNJlPcJSLz
 rDl7Cs2E1zImRTUE6fu//sQb5kcsdVOEKLOHfa7cztIBGDmRx8ULeJdlrHM9hh2MXMf5
 6Vnw==
X-Gm-Message-State: AOJu0YwWOWOKniW1CoavsBPas40J/8+Kkx4jvZT/8+A3daHGiHr711mh
 9NG6lqkojrfN2ZvoZofYVJylslS+6XDXi39lY6aweshFZcTSNoS3z+T9hnFQ/422UT0=
X-Gm-Gg: ASbGncsuneqewFzOUjK4T7q7TaIe6SNyVaaV+Jox5y+4lYzRlQ7s3Tib8xsG9Q29C4w
 g0sME2EDJU3riPWOrTkVtinEeNNKqnb1SOfDmcSCXWRN4hNY+w4OLuyu7O96j03NS0DhyXb/uf/
 qgK7eNABHUFr3MPCKBZGIw2V8WHrrNONPnmZ6+gSvQg0BUSEvfUKJ4eJKvH0t3zMutIaaoa9Lq+
 8vrTfq6irv0AujDYEmvEhVEJBjDjxgldWMl0PQxa00T2HFTSFYHyILhCEvpeWm3Z+dpNxfY3/kI
 +f6BmNpIW6EDHoxrhMnYgvyf8uR0+TnDwBVk5ZGcn0dPeNjb3n/X6JarCU+FLDE=
X-Google-Smtp-Source: AGHT+IGhQz+1/FpaU9qTEzmSHmCxSUrkMjowKvaC+7X52KGoS+0rQn3z3TvQLs/OgkEQqc/RPevKHQ==
X-Received: by 2002:adf:e38d:0:b0:3a3:6e85:a529 with SMTP id
 ffacd0b85a97d-3b5e78f891cmr2680481f8f.51.1752144335992; 
 Thu, 10 Jul 2025 03:45:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e2fasm1499722f8f.77.2025.07.10.03.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 945175F893;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yodel Eldar <yodel.eldar@gmail.com>
Subject: [PATCH 4/7] target/alpha: Add GDB XML feature file
Date: Thu, 10 Jul 2025 11:45:27 +0100
Message-ID: <20250710104531.3099313-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710104531.3099313-1-alex.bennee@linaro.org>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@gmail.com>

This patch adds the GDB XML feature file that describes Alpha's core
registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2569

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
Message-ID: <20250630164124.26315-3-yodel.eldar@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/targets/alpha-linux-user.mak |   1 +
 configs/targets/alpha-softmmu.mak    |   1 +
 target/alpha/cpu.c                   |   1 +
 gdb-xml/alpha-core.xml               | 136 +++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 gdb-xml/alpha-core.xml

diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index ef8e365b09..aa25766236 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=alpha
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= gdb-xml/alpha-core.xml
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index 5275076e50..e31f059a52 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= gdb-xml/alpha-core.xml
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 2082db45ea..bf1787a69d 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -286,6 +286,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
     cc->get_pc = alpha_cpu_get_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
     cc->gdb_write_register = alpha_cpu_gdb_write_register;
+    cc->gdb_core_xml_file = "alpha-core.xml";
 #ifndef CONFIG_USER_ONLY
     dc->vmsd = &vmstate_alpha_cpu;
     cc->sysemu_ops = &alpha_sysemu_ops;
diff --git a/gdb-xml/alpha-core.xml b/gdb-xml/alpha-core.xml
new file mode 100644
index 0000000000..c9e12f4ffd
--- /dev/null
+++ b/gdb-xml/alpha-core.xml
@@ -0,0 +1,136 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2025 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.alpha.core">
+  <!-- IEEE rounding mode values -->
+  <enum id="dyn_rm_enum" size="8">
+    <!-- Chopped rounding mode -->
+    <evalue name="chop" value="0"/>
+    <!-- Minus infinity -->
+    <evalue name="-inf" value="1"/>
+    <!-- Normal rounding -->
+    <evalue name="norm" value="2"/>
+    <!-- Plus infinity -->
+    <evalue name="+inf" value="3"/>
+  </enum>
+
+  <!-- Floating-Point Control Register Flags -->
+  <flags id="fpcr_flags" size="8">
+    <!-- Denormal Operand Exception Disable -->
+    <field name="DNOD"   start="47" end="47"/>
+    <!-- Denormal Operands to Zero -->
+    <field name="DNZ"    start="48" end="48"/>
+    <!-- Invalid Operation Disable -->
+    <field name="INVD"   start="49" end="49"/>
+    <!-- Division by Zero Disable -->
+    <field name="DZED"   start="50" end="50"/>
+    <!-- Overflow Disable -->
+    <field name="OVFD"   start="51" end="51"/>
+    <!-- Invalid Operation -->
+    <field name="INV"    start="52" end="52"/>
+    <!-- Division by Zero -->
+    <field name="DZE"    start="53" end="53"/>
+    <!-- Overflow -->
+    <field name="OVF"    start="54" end="54"/>
+    <!-- Underflow -->
+    <field name="UNF"    start="55" end="55"/>
+    <!-- Inexact Result -->
+    <field name="INE"    start="56" end="56"/>
+    <!-- Integer Overflow -->
+    <field name="IOV"    start="57" end="57"/>
+    <!-- Dynamic Rounding Mode -->
+    <field name="DYN_RM" start="58" end="59" type="dyn_rm_enum"/>
+    <!-- Underflow to Zero -->
+    <field name="UNDZ"   start="60" end="60"/>
+    <!-- Underflow Disable -->
+    <field name="UNFD"   start="61" end="61"/>
+    <!-- Inexact Disable -->
+    <field name="INED"   start="62" end="62"/>
+    <!-- Summary Bit -->
+    <field name="SUM"    start="63" end="63"/>
+  </flags>
+
+  <!-- Integer Registers -->
+  <reg name="v0"   bitsize="64" type="int64"/>
+  <reg name="t0"   bitsize="64" type="int64"/>
+  <reg name="t1"   bitsize="64" type="int64"/>
+  <reg name="t2"   bitsize="64" type="int64"/>
+  <reg name="t3"   bitsize="64" type="int64"/>
+  <reg name="t4"   bitsize="64" type="int64"/>
+  <reg name="t5"   bitsize="64" type="int64"/>
+  <reg name="t6"   bitsize="64" type="int64"/>
+  <reg name="t7"   bitsize="64" type="int64"/>
+  <reg name="s0"   bitsize="64" type="int64"/>
+  <reg name="s1"   bitsize="64" type="int64"/>
+  <reg name="s2"   bitsize="64" type="int64"/>
+  <reg name="s3"   bitsize="64" type="int64"/>
+  <reg name="s4"   bitsize="64" type="int64"/>
+  <reg name="s5"   bitsize="64" type="int64"/>
+  <reg name="fp"   bitsize="64" type="int64"/>
+  <reg name="a0"   bitsize="64" type="int64"/>
+  <reg name="a1"   bitsize="64" type="int64"/>
+  <reg name="a2"   bitsize="64" type="int64"/>
+  <reg name="a3"   bitsize="64" type="int64"/>
+  <reg name="a4"   bitsize="64" type="int64"/>
+  <reg name="a5"   bitsize="64" type="int64"/>
+  <reg name="t8"   bitsize="64" type="int64"/>
+  <reg name="t9"   bitsize="64" type="int64"/>
+  <reg name="t10"  bitsize="64" type="int64"/>
+  <reg name="t11"  bitsize="64" type="int64"/>
+  <reg name="ra"   bitsize="64" type="int64"/>
+  <reg name="t12"  bitsize="64" type="int64"/>
+  <reg name="at"   bitsize="64" type="int64"/>
+  <reg name="gp"   bitsize="64" type="data_ptr"/>
+  <reg name="sp"   bitsize="64" type="data_ptr"/>
+  <reg name="zero" bitsize="64" type="int64" save-restore="no"/>
+
+  <!-- Floating-Point Registers -->
+  <reg name="f0"  bitsize="64" type="float" group="float"/>
+  <reg name="f1"  bitsize="64" type="float" group="float"/>
+  <reg name="f2"  bitsize="64" type="float" group="float"/>
+  <reg name="f3"  bitsize="64" type="float" group="float"/>
+  <reg name="f4"  bitsize="64" type="float" group="float"/>
+  <reg name="f5"  bitsize="64" type="float" group="float"/>
+  <reg name="f6"  bitsize="64" type="float" group="float"/>
+  <reg name="f7"  bitsize="64" type="float" group="float"/>
+  <reg name="f8"  bitsize="64" type="float" group="float"/>
+  <reg name="f9"  bitsize="64" type="float" group="float"/>
+  <reg name="f10" bitsize="64" type="float" group="float"/>
+  <reg name="f11" bitsize="64" type="float" group="float"/>
+  <reg name="f12" bitsize="64" type="float" group="float"/>
+  <reg name="f13" bitsize="64" type="float" group="float"/>
+  <reg name="f14" bitsize="64" type="float" group="float"/>
+  <reg name="f15" bitsize="64" type="float" group="float"/>
+  <reg name="f16" bitsize="64" type="float" group="float"/>
+  <reg name="f17" bitsize="64" type="float" group="float"/>
+  <reg name="f18" bitsize="64" type="float" group="float"/>
+  <reg name="f19" bitsize="64" type="float" group="float"/>
+  <reg name="f20" bitsize="64" type="float" group="float"/>
+  <reg name="f21" bitsize="64" type="float" group="float"/>
+  <reg name="f22" bitsize="64" type="float" group="float"/>
+  <reg name="f23" bitsize="64" type="float" group="float"/>
+  <reg name="f24" bitsize="64" type="float" group="float"/>
+  <reg name="f25" bitsize="64" type="float" group="float"/>
+  <reg name="f26" bitsize="64" type="float" group="float"/>
+  <reg name="f27" bitsize="64" type="float" group="float"/>
+  <reg name="f28" bitsize="64" type="float" group="float"/>
+  <reg name="f29" bitsize="64" type="float" group="float"/>
+  <reg name="f30" bitsize="64" type="float" group="float"/>
+
+  <!-- Floating-Point Control Register -->
+  <reg name="fpcr" bitsize="64" type="fpcr_flags" group="float"/>
+
+  <!-- Program Counter -->
+  <reg name="pc" bitsize="64" type="code_ptr"/>
+
+  <!-- Reserved Index for Former Virtual Register -->
+  <reg name="" bitsize="64" type="int64" save-restore="no"/>
+
+  <!-- PALcode Memory Slot -->
+  <reg name="unique" bitsize="64" type="int64" group="system"/>
+</feature>
-- 
2.47.2


