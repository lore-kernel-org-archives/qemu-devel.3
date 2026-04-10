Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8431EF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHyP-0001oJ-16; Fri, 10 Apr 2026 15:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHyO-0001nl-1D
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:57:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxx-0004nz-Cd
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cfd96354aso1510268f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850991; x=1776455791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHk1fkmZMPSQJTPZJGYUyFHdUWj/VJJojjesXRowi+8=;
 b=XWNwM+XVhZkK5hUhnXf5tbau2IwCa7L7eoyhDgP38BJEt833XQHT/P+1CAPs7+XOne
 BBqiu7QeSvsm+OpcyMgGBMo2BJ5qrImI0WWSd3F8fiucg9wMkPUV9FCEDZ9Qo4OB+h+s
 IDMpI0P7NFjUS71OT7jJF8iegGqFmR2q2SbiX8okhv8LEZ4InCY1QUsFzTLzTka7AVln
 WrERH23rxsUBZW9I71oleGESoN6VE5x+MGztpWsqMFjg8llVP6PA34tXQhZokHgXt4kP
 VYrveoRjpaHGb/BAv4fY9o2gYSJbj+TZ3LWNGhKR3Sfm25mxJ+jrL2q9Rs6BW5xnYWvB
 tkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850991; x=1776455791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iHk1fkmZMPSQJTPZJGYUyFHdUWj/VJJojjesXRowi+8=;
 b=GSUiWFxeLs14AD5dKFigyoAo2M+0O4i9J30Skn65mQZIVH+uLGs1EItRvLoAhFIzvc
 XirGnHY2ECOLPdHKRSLubGVjAoRXIP7QcLKxv0J4rMdNB/Ci5a4p5kZwneFDBd0wDbt8
 Xve/+I0APpXISL8gxpqaMQwzJC8MOdeXzhY5FoOtHkaDxlPHFD8EBx8LHbNnM00kUjXe
 ab746qDAT1lWXcmQyL4zPdwJl2IyS+IpMk/MNkUe/ip4khcrYO2zHb533x65n4xva3yf
 on2exN1VlGtH7pb5pPqUIm/EQMceIc9PN+f8w00v2K4F8GaEpnA0Cs7j6fZ2OKe3HClb
 07cQ==
X-Gm-Message-State: AOJu0Ywo82yNeNyRjuJ739tR1gI8NRDh/AmF6COObOik+99PdzZ13L1+
 ELOUZ4hVHO990bwpYNtyqzQtSgPLEi4H4ohi/Mre1vKV7Nd3Y2xpmmQ4xyw0FvG6je3pURvtJfA
 Z24+jHOU=
X-Gm-Gg: AeBDiesaayomIRwiBWF44Ys1sUbYFLMxZrReDtAtohDXRw1T7kPqSthLiXUk1tkJkNF
 W2xwvhKuNhEbw6ACi5BwC1Xij4EdDw+dkvKe7rq4QSCuBKcIdTZprHaB9xt6XoYvUb2jQkkd1vD
 BXo67RTVijot4MiGIZQhw8sKino/UUUYk3mcwsB1MgVYsspcHo9K6qCU9eRxHovZJN1iyAsoRh2
 5NdxNim3zF1WYjJTcjT4FgxbpsmkFdN8VTS5guxkx2WRgyF9bLz4YwupDqyxhVB4tW8W/B57AmL
 /LScW2xRtTcsahDlbSjVzRKTEkUBMXp9Dvkk7Wm0HUqEMk/W/mX2Qd9l1w7stwRj0GXOgUb2F9e
 VMd5V86sMzht4IK9uWs1RFPdtZk+4jDnV88cujcylJsWap6v7fg5qXkHaWxI7CPeCOiwoJ6euzR
 yUjTdE7t7sNyN90XpXwU+Zd+mbWYNpxL+pAbH5pKS4jQnMgB7O3cDMwYepdi3mbTkZvWjfLR92
X-Received: by 2002:a05:6000:40df:b0:43d:4b00:9ee9 with SMTP id
 ffacd0b85a97d-43d642ca07cmr7372748f8f.43.1775850991514; 
 Fri, 10 Apr 2026 12:56:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e469ddsm9751293f8f.17.2026.04.10.12.56.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:56:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 26/27] monitor: Do not check multiple TARGET_* to build
 'info tlb' command
Date: Fri, 10 Apr 2026 21:53:20 +0200
Message-ID: <20260410195323.17937-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

This command is filtered at build-time for a selection of binaries.
By using the recently introduced HMPCommand::arch_bitmask flag we
can filter them at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/hmp-cmd-info_tlb.c | 12 ++++++++++++
 hmp-commands-info.hx     |  5 ++---
 stubs/meson.build        |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_tlb.c

diff --git a/stubs/hmp-cmd-info_tlb.c b/stubs/hmp-cmd-info_tlb.c
new file mode 100644
index 00000000000..a144e68c1c7
--- /dev/null
+++ b/stubs/hmp-cmd-info_tlb.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info tlb' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_tlb)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 2d0a8f7d48f..0898221a486 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -193,16 +193,15 @@ SRST
     Show PCI information.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC) || \
-    defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     {
         .name       = "tlb",
         .args_type  = "",
         .params     = "",
         .help       = "show virtual to physical memory mappings",
         .cmd        = hmp_info_tlb,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
+                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
     },
-#endif
 
 SRST
   ``info tlb``
diff --git a/stubs/meson.build b/stubs/meson.build
index ed7ca54ae06..3c6d0032e93 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -86,6 +86,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
+  stub_ss.add(files('hmp-cmd-info_tlb.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0


