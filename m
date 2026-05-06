Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39640CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrJ-00014p-CD; Wed, 06 May 2026 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpK-00075T-SF
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpI-0000se-DK
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso62695875e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076130; x=1778680930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rqzyk5r26PUHXn/obZCfF5gHTJGmPpfm5BDUQeQj+1I=;
 b=AlkLT9/YcbPsCSLF9FX3mP8ZMZtvon6/WHkLvf3JdPnbvB3mSQF7Oabn6/Oy1qtpQX
 3V1vSi7ty8sppt3Vd3WXPkF7ESzHfq1gFvoFDCljkcG7g8t/V1XZBcZw4vnR8pfmCSMx
 A7k6kWhGdjtOKFySYoufF37wQ3MvfMTebM+J+WnTTgEKLNyETN91zgOj8Nloijchsawh
 bXQm/B0OLl+FOIvHeZFlz2fhqy8HIIDqekA2RRlqj2oPBSO2TQN5ZXrmlmpKooh0m9cJ
 IwU8mDz3KkcVfLXEwPSMriq3V906D+U1DP6eYINuycWleFBn0fm2zUmdIS277DoOcLSe
 sDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076130; x=1778680930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rqzyk5r26PUHXn/obZCfF5gHTJGmPpfm5BDUQeQj+1I=;
 b=in6C0jvOlF0Nc+SU2JZPoujjTWB0FOb9nWQsKehETDdRivQ1LTHl5WMVgcw8nXy5UO
 TP1uNt+pdVd6dbV0c3eh1TNs+zgETSbEdflxoRXcjQj0NNkNmm77r9S1eIo6bz523rN4
 RhzKHUrRB+1XHtBClRxU1qJeUou8w7uy7+pjUZlg0CgN9tMQaXo0nuHfa1NDaCTibGp/
 irOIR3GjEg9hIQ7fQzXMqwSQqALfDHF05qXZu2778UlobBYRJ7N422GDuystU0CZnsGd
 SnKVS8dNBa4qFNLk5dyvtCdDQKOeURhnIfAeYZ/TAjMOBqfmu2v5z069NEbTHbGA880j
 EWew==
X-Gm-Message-State: AOJu0Yx5UBAKdWY5lfnHuMKqWv5j6XT0ZogYk0QHKFKRpmODkR8pjQ9s
 SzEVKbc3n+mZv6wUWf/M8FT65Ykhyaq89tX+3Qz9YlElVuSF/KQZO3xMZe1JMT1vlTS+113pbRS
 04Dp4ul4=
X-Gm-Gg: AeBDievdc1Uc9SfuJ/c+kgQ/4+Ucwh8xSfWYkx1tt85KBc1125F3JWzWzOFIW9+Ohnm
 PcFzr6wMGAkvzD+PbLt4mDRRSMvxCxvumaoH20sRG4nHjnm0gonLd0zGvF5CAMuj9mqL5OxDemB
 t3A0fXg7J251XM8fZzinMc3h67CluYmyf930r5i60nT4fzB05x7vjUa0KwdVQuQVv4MdYISt+/g
 aJduFWE1RzSeyQPWE4CGo33A7w792TbsL64Q8ftdne2e3cy1wcdwhgPIivqUZZHODO9cDDWA2SU
 FgKlxg7/oHovd9pOV06bvTKO/zqWrGJWmgmuyvRMnQ77HL9tT7XqX/Lef9hTwe3NLF3bNFielOD
 asEqWweNDn2aGd8YIR3g/GYeRLTjJZ278OpLk3l59hUNj/Sr7j8YmbG+RRnqbJ41duAWeUrQwjV
 pSZafq8pfhUURsfwTUoOD88ngbPnhv7WkqKoEsBv0FoaP5D2GBID+XT+44gPi+9tWwZWDVjgOTz
 x5ivNFtA00=
X-Received: by 2002:a05:600c:4e0c:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48e51e16e58mr68269965e9.9.1778076129315; 
 Wed, 06 May 2026 07:02:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm17412135e9.18.2026.05.06.07.02.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:02:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 052/110] monitor: Do not check TARGET_I386 to build 'info sev'
 command
Date: Wed,  6 May 2026 15:54:24 +0200
Message-ID: <20260506135524.20617-53-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

This command is filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter it at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on the CONFIG_SEV definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-17-philmd@linaro.org>
---
 MAINTAINERS                   |  1 +
 stubs/hmp-cmd-info_sev.c      | 16 ++++++++++++++++
 target/i386/sev-system-stub.c |  5 -----
 hmp-commands-info.hx          |  3 +--
 stubs/meson.build             |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_sev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7515025e09b..1eb7903268b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -515,6 +515,7 @@ S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
 F: hw/i386/sgx*
+F: stubs/hmp-cmd-info_sev.c
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/stubs/hmp-cmd-info_sev.c b/stubs/hmp-cmd-info_sev.c
new file mode 100644
index 00000000000..f3624423a33
--- /dev/null
+++ b/stubs/hmp-cmd-info_sev.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sev' stub (CONFIG_SEV)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+void hmp_info_sev(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SEV is not available in this QEMU\n");
+}
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index fb84aee94d2..2ea85597cf9 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -32,11 +32,6 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
     g_assert_not_reached();
 }
 
-void hmp_info_sev(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SEV is not available in this QEMU\n");
-}
-
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
 {
 }
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 576adbbf5a6..480a5a79ecb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -805,15 +805,14 @@ SRST
     enabled) memory in bytes.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sev",
         .args_type  = "",
         .params     = "",
         .help       = "show SEV information",
         .cmd        = hmp_info_sev,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sev``
diff --git a/stubs/meson.build b/stubs/meson.build
index 6142e0f4d9d..f086521cde4 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -87,6 +87,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0


