Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFADF531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgs-0003BB-Vr; Mon, 13 Apr 2026 20:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgs-00038F-28
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgq-0003FN-E3
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so2934452f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126699; x=1776731499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L00sTYsnDkewYLMKY3Xwi/QsSf8SDpEAlxJYefdp+KA=;
 b=QQ1XdI2YiJreBBpp7xQlOEpJh6qKdkNE/w0Hvq+Qlsm8xDXHrmUmMc4krfjcPA7K4Q
 uCagRIXaNKnxfeJLnRg5da5P6zuil9EwcYgH7rQ6aXnIHTtYJMqB8KavW3sHjZQzGmaM
 Gkd91WIZl3zzHVkMtJirf3+lIYiUskEFmnqNX19nEjWFCFwHT08TaraBLcwojA/qXw0M
 txQ+euOyhH/bHeuqSJeVqdfzPuuIC0XMug0CpdigK3rwZuaX5u0UNdx8PTVST74UH5n9
 MFCrVXmXe4GGPkTS+27rMCrvefX/ZUw6p7y+BS85DWuzl4q6Rs7e/P3JIwE0l9f7hKZ4
 wS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126699; x=1776731499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L00sTYsnDkewYLMKY3Xwi/QsSf8SDpEAlxJYefdp+KA=;
 b=H0/nX67lnbaIl2MiO6+X5dcXL6J9y+hWlP6IEUwR3S1H6Ng87sHNcVfF0e0A9Dp/tD
 E/0woraVg+wSCmhJikpPkwkgqSUtmtR/sEtyBKNvdRR9nS8d0NvnQ6maxtpuV1lxhGhA
 JoICVPXsmbpmwuqZea7FqogpNGuvoNALhR8EuRcaNfHd9UXA/wrYtIk6XE9rIoDlZr6f
 XiAd5+sDDKuqLqUZUTiCqsAjTtRPeYsNgPXcsdrRk1VN3pfNoHVZTCbHEOmU4tN6n458
 RY9YAGsDzrI/Q+st1OOGhUn1pGqo6E38ylXXbp8hoL4UJo0+bGwqJWkf39vU33edYQG4
 ObgQ==
X-Gm-Message-State: AOJu0YwHGgExZA12P6Uch37ztTddXFHVYvlHhFNExxg4HB9L97Z7broa
 ccEuZivV3gjisMkaBbcOwIy2lscw2vPWJXU5Pf/dra8xpECRgaqHRf1+qhCZk5IZxC0aMZ8M6vn
 pmenUO/I=
X-Gm-Gg: AeBDievZjv6Ho3tFiQmDAIv4eKRW++fjYlsBpyYQEJ9EEx4dLV7DrAWrsykMRjnxEqr
 548fhNH0I/6dFgbUbFqzM5boHnr+CIPHSg2O3E0LDYpZlZZ+/WD1s4ViUUSI0RZ3Jh2iwpdaqHM
 aZwMGjCF7giwJ+qTI35jnrz3pUnyYQPyE+YYPBZDjqF3X0Z2sO3X9sOkpwOb2GamjDlV5MmdDgP
 DvGvZDKcYvt2UhakVqQaR0v4V1nS8dSgpusEDMPrmYL/PBx3MRIdpn62HWM8W8+VbHAlkcPWzzn
 fbMYAj5bLILiQHvX5avwTTON2I34x8rL4+8soEBqSdp9CmINQaChXy8Pti1bwU+SwpocWwZupxG
 f4c7fhtW5GDwOJLzHA+qTsGh0grdyPctUZBcFbw3XZtvyhrFF2P+xl4Zk/0P1s0lrfcYyGdgZ4e
 56ic535+5Qnb9IDXFbCqsUhMNcW8xczuoUgTG4L3pGbFRQXupJAY0sRUPNPUwG4C1HS82BvXDh
X-Received: by 2002:a05:6000:2585:b0:43d:73d4:b34 with SMTP id
 ffacd0b85a97d-43d73d4185bmr10976447f8f.16.1776126698629; 
 Mon, 13 Apr 2026 17:31:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2a69sm37588554f8f.4.2026.04.13.17.31.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/27] monitor: Do not check TARGET_I386/RISCV to build
 'info mem' command
Date: Tue, 14 Apr 2026 02:29:45 +0200
Message-ID: <20260414003001.97571-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
index 4a1d687a111..9aaf80e6c1b 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -86,6 +86,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
-- 
2.53.0


