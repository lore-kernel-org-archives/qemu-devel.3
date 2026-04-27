Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ACBFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2K-0002t1-0f; Mon, 27 Apr 2026 04:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2D-0002SH-C8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2B-00025R-Mz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso103276075e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277378; x=1777882178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JshNpgqW4cCYul7Q+y/QdsSlweDRsNaeeQFwo1ONxPo=;
 b=i5f9AJbNGReyeQIM2GEWxADBdMZ2QavQlXBQP1nsOL9y4n45YbaV7wV489zlN3TXGc
 3mjnyJ4iVhvMKP3tZsXBi3qyqtWXZNX69RnGElBSEVcpwmV4m/EX7PUiieQ/tPz8u5mm
 olxTdnoTN17XiOmDB3XZQVkyy7y5GB+C9hu+de5EknSWRHI4GNppLDsxBQXsPanRupfG
 gKR1dtKgny4rG9iYaNudyiKnF9G6oI406su4yB4tljfvazo3F6vnn/1xtn4z/MSiHFAg
 ehqOMiesxw6YblKbd8/hOzgnakn3GZjbXA56hg2r+RPw3ZMSSEfpJZYyMgrWhBDefNvR
 s9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277378; x=1777882178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JshNpgqW4cCYul7Q+y/QdsSlweDRsNaeeQFwo1ONxPo=;
 b=GGYccJRpNUj5W/aHyBcQLQ575m8OGpRQbmtS73cHKs9za6DBfXDaFON/p6RJFJlxAW
 VV9Zjy8xoFUPnZ4bxSlktb3cyVz9a7q9/B5WXcjKgmlblCgxAGdG0yF0nCHlwKG6wfDh
 tN53No1I2inPLDXj4V4aR+B95J0R89d3LvliXTvH6ud415InMHUyFxZd/Zzjlm+cIaHG
 A6x1UCf6HJi1pa5JVeDs6RXY237Yo7q2h28fYoOJhdmOtXuR0OjXn+Z9vlQI4AedUY7C
 Sye23tabjE7RF7wXQj6x+Yd3Wk3f4LB3UKLbZN37dSaUwe+wYyX7aJxgeZDqTkBl0JU5
 FyMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/q3gj4dnjSrAPtXNzQ623QmXhVZjCKCv+9Bk9GwcnMs3Q6Y9p+z0bsasuurkazyMdKmy9WPg+wdqUc@nongnu.org
X-Gm-Message-State: AOJu0YzMy5aAQlUr9zvqhw2e7V64Rq3CGEmQTA1BpJKyh2U0oi6stBFI
 Sun658azwtnOCaPoELnnuXYzVXdZfeMVaESM2RZnUmSbEQySQ53oMTTxn6qus5hUZA53bF+/XB+
 0ec6DNYA=
X-Gm-Gg: AeBDiethfjIddgFL2UpEpjLc9siBThFndLl8oatiAWsFp6lE55xU8MfKVX+GfLBaUv5
 Z7OfvCft68LGb7/eZylvLGDBzkeTuzMYPwEJDXLAhRWEEBl5eaA7BGoSp2zwsfDNVD9qaTPhZI2
 NPH/7kRLyBLHO1RtUgtbEa/DYCbTlJiSnjj+oCST/si2NDaOryUdkdKI+BCvBR5/JkIPMze54lp
 pKLJXJoImNgoHFanEyeiFTGzoiQaxG0DQdvXcl55jqpnjATjEfvOON2hKkCnRlg2oahfc9EiVP+
 9c/K+zK7p06BgX+rpuEWuDzdm9oAhqja4V98TKBlh0SaevduO69WJeOetjryGmQQ0QDYaBt1bSu
 utSWIX6iriObfzGjAD/qHshfsxR2a+TYFfuHzp/PQm1fqP1C5rmj9qD1kpVw047BLldYTeejA9d
 JpbEOj59qGCRgN/39aHGdap1NnxFCoVQqJSM9jmA7NkX2hD+itS5zRoH7jSVg3YtHWM4FeovdY4
 PLQB+zypZWBq6PGqhsODA==
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr565831465e9.10.1777277377790; 
 Mon, 27 Apr 2026 01:09:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm778866945e9.12.2026.04.27.01.09.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 17/32] monitor: Do not check TARGET_I386/RISCV to build
 'info mem' command
Date: Mon, 27 Apr 2026 10:07:23 +0200
Message-ID: <20260427080738.77138-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

This command is filtered at build-time for i386/x86_64 and
riscv32/riscv64 binaries. By using the recently introduced
HMPCommand::arch_bitmask flag we can filter it at runtime,
making it possible to compile hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 stubs/hmp-cmd-info_mem.c | 12 ++++++++++++
 hmp-commands-info.hx     |  3 +--
 stubs/meson.build        |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_mem.c

diff --git a/stubs/hmp-cmd-info_mem.c b/stubs/hmp-cmd-info_mem.c
new file mode 100644
index 00000000000..8a53e367a9f
--- /dev/null
+++ b/stubs/hmp-cmd-info_mem.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info mem' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_mem)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 336ab870a2c..2d0a8f7d48f 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -209,15 +209,14 @@ SRST
     Show virtual to physical memory mappings.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_RISCV)
     {
         .name       = "mem",
         .args_type  = "",
         .params     = "",
         .help       = "show the active virtual memory mappings",
         .cmd        = hmp_info_mem,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_RISCV,
     },
-#endif
 
 SRST
   ``info mem``
diff --git a/stubs/meson.build b/stubs/meson.build
index f086521cde4..33053d932c8 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -87,6 +87,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
-- 
2.53.0


