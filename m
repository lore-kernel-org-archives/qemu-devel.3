Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E81C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUms-00088U-8u; Mon, 29 Jan 2024 11:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlg-00062B-Jp
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlb-0003hl-M5
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:56 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ed3101ce3so44774385e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546749; x=1707151549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6GmB2IPQQ3XezKE8bqOs65jaQBYCmOI4YcRWUsHLHk=;
 b=czbKw03mCMTdRk0AFEO/zBU4kMqdogCSgrY7zp53aSAttdQh7z7VzU42W8FX2jV/5e
 fNQzi4oc5l3EXpTERwq/CJkDVA3yxlZTAa7S1BB2fKErBt1wP+Wd4Lq1ihIWjPqij9A+
 4cPBQyUQzbQXbsfmw04PGLBCE4pyDmdzG2qd9WhJiCUACFEsjMTutiYql5ayP2jSWcb/
 WOVTyxTX+EuXSPKwy7RmW9Fo5S+Wxw+JnaSqgvy6J1jgVpImtuptVBcUndFVHUk7kr9V
 VKf+e3DVdSL8x1S/nHpyRPt2gAJ8mvEYkq+Lb5iz+nEJ4H3ndSVk/1HGeN0YPmLkyEsb
 lFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546749; x=1707151549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6GmB2IPQQ3XezKE8bqOs65jaQBYCmOI4YcRWUsHLHk=;
 b=gpV8je9dqUAw6VJip7VmDzawti3ZTzOT/RZbto5eTbcE2WTOoOjkjx2Tzhg3Df7WYY
 yOP5hE1miby+J6ojocilEyVeIdSGNZY0fuBKLegSuQb4K3PihVt1Scr1xVDkDQ0Os2kE
 qUpF8RwCOcCkfIAcTUdAwJPniKC5B0k+EKWhc746ekLTcIg6GDlHJp/WmffBHyYhP4MW
 7FvP5oL2H6Iof6AYhT3fu/xLhvw8SFR69AlPc48KzBz0SVFIfv7i8pUeuTfRtEs5Fn0M
 EnUPboryYL1rLDRvNiRaqugyoeJMmetuCybZ6XCoJ5jMb2xY0en/qYg2QRBp0qhiK/2b
 daDw==
X-Gm-Message-State: AOJu0Yy7qT4/bc1v16RgS7yyK+knztNKa/F/wRXIJ3vAkgd88t4t8rmO
 4C3s2klXcp2Sa9Zov2T0kBLz8GrGA6byNhhpa9f1zXscKb3kF7OIe4qZHpGvCJyTN+6JmPUEuP9
 j
X-Google-Smtp-Source: AGHT+IF/M4JMBgkyz42lTen3ZH5avOQ7AmvAMgZOIUtFFNwiFxYGzMm049Zz6nlzZCQLDXADh4NIrw==
X-Received: by 2002:a05:600c:1f83:b0:40e:b1f6:2ed7 with SMTP id
 je3-20020a05600c1f8300b0040eb1f62ed7mr5943831wmb.32.1706546749731; 
 Mon, 29 Jan 2024 08:45:49 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600003c600b0033aed4e3b55sm3381414wrg.102.2024.01.29.08.45.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:45:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/29] scripts/coccinelle: Add cpu_env.cocci script
Date: Mon, 29 Jan 2024 17:44:47 +0100
Message-ID: <20240129164514.73104-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a Coccinelle script to convert the following slow path
(due to the QOM cast macro):

  &ARCH_CPU(..)->env

to the following fast path:

  cpu_env(..)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                      |   1 +
 scripts/coccinelle/cpu_env.cocci | 100 +++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 scripts/coccinelle/cpu_env.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index dfaca8323e..ca3c8c18ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,7 @@ F: accel/tcg/
 F: accel/stubs/tcg-stub.c
 F: util/cacheinfo.c
 F: util/cacheflush.c
+F: scripts/coccinelle/cpu_env.cocci
 F: scripts/decodetree.py
 F: docs/devel/decodetree.rst
 F: docs/devel/tcg*
diff --git a/scripts/coccinelle/cpu_env.cocci b/scripts/coccinelle/cpu_env.cocci
new file mode 100644
index 0000000000..5a70c2211a
--- /dev/null
+++ b/scripts/coccinelle/cpu_env.cocci
@@ -0,0 +1,100 @@
+/*
+ * Convert &ARCH_CPU(..)->env to use cpu_env(..).
+ *
+ * Rationale: ARCH_CPU() might be slow, being a QOM cast macro.
+ *            cpu_env() is its fast equivalent.
+ *            CPU() macro is a no-op.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * SPDX-FileCopyrightText: Linaro Ltd 2024
+ * SPDX-FileContributor: Philippe Mathieu-Daudé
+ */
+
+@@
+type ArchCPU =~ "CPU$";
+identifier cpu;
+type CPUArchState =~ "^CPU";
+identifier env;
+@@
+     ArchCPU *cpu;
+     ...
+     CPUArchState *env = &cpu->env;
+     <...
+-    &cpu->env
++    env
+     ...>
+
+
+/*
+ * Due to commit 8ce5c64499 ("semihosting: Return failure from
+ * softmmu-uaccess.h functions"), skip functions using softmmu-uaccess.h
+ * macros (they don't pass 'env' as argument).
+ */
+@ uaccess_api_used exists @
+identifier semihosting_func =~ "^(put|get)_user_[us](al|8|16|32)$";
+@@
+      semihosting_func(...)
+
+
+/*
+ * Argument is CPUState*
+ */
+@ cpustate_arg depends on !uaccess_api_used @
+identifier cpu;
+type ArchCPU =~ "CPU$";
+type CPUArchState;
+identifier ARCH_CPU =~ "CPU$";
+identifier env;
+CPUState *cs;
+@@
+-    ArchCPU *cpu = ARCH_CPU(cs);
+     ...
+-    CPUArchState *env = &cpu->env;
++    CPUArchState *env = cpu_env(cs);
+     ... when != cpu
+
+
+/*
+ * Argument is not CPUState* but a related QOM object.
+ * CPU() is not a QOM macro but a cast (See commit 0d6d1ab499).
+ */
+@ depends on !uaccess_api_used  && !cpustate_arg @
+identifier cpu;
+type ArchCPU =~ "CPU$";
+type CPUArchState;
+identifier ARCH_CPU =~ "CPU$";
+identifier env;
+expression cs;
+@@
+-    ArchCPU *cpu = ARCH_CPU(cs);
+     ...
+-    CPUArchState *env = &cpu->env;
++    CPUArchState *env = cpu_env(CPU(cs));
+     ... when != cpu
+
+
+/* When single use of 'env', call cpu_env() in place */
+@ depends on !uaccess_api_used @
+type CPUArchState;
+identifier env;
+expression cs;
+@@
+-    CPUArchState *env = cpu_env(cs);
+     ... when != env
+-     env
++     cpu_env(cs)
+     ... when != env
+
+
+/* Both first_cpu/current_cpu are extern CPUState* */
+@@
+symbol first_cpu;
+symbol current_cpu;
+@@
+(
+-    CPU(first_cpu)
++    first_cpu
+|
+-    CPU(current_cpu)
++    current_cpu
+)
-- 
2.41.0


