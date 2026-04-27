Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260F0FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2I-0002Xx-4V; Mon, 27 Apr 2026 04:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH27-00029B-Mf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH25-00023n-Sa
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso9505328f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277371; x=1777882171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UyizkhPwA66T9NIfFzFir+Q1fq4kdPQuZBgZLFR1jbQ=;
 b=g0ynTMmVXv59PgU77K8PcD9pN8TMnxWdzPMTdtC2RftZpXjp2jD79CY3V0MqCgHMS8
 PErOL4aFy84lusbaPiwal8sL0EDWZxxe50Uqto0+R/m49i8o2H+4OWvmCqWOYvW2AlDt
 QzW2GjAk5oJ4HrKTAcapW0+OSTS6O4avYXJQppFI0E829CGVM8BPrWOTKTqX/42Qmv/n
 CwqO6gxn30bcsEZezrSEFCsFqMLaf8Ssy0P7ePVmvwVhKAFzzoRUF0QRznKwFpbHM5UZ
 jA9Jn6Q0fOi/z8vEVq+TSn9Zh6OfVEef13O/JCb7IcWDWCxPdMnYz+pXXc5Y4NABL/5n
 Kvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277371; x=1777882171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UyizkhPwA66T9NIfFzFir+Q1fq4kdPQuZBgZLFR1jbQ=;
 b=Ogd5zrz5wX1dwsTviqR+P3G+THwALQMY2w/tlPVFPPw88zYIBQqB6PbPXwzrIpvy6I
 5qbUE3WdKmZKQbA8J6xxAXgSD6NNrHpElyb04apgmOCGzu0Pe30vPkq9Hr0mrqedV/ei
 WGjaM5AtxUfSx+UlxXo+Pg4Xtgf4sFm4Fl0mNLIG8FtF2R38gSMNrkhpR8rKKgkWtQ8w
 jTvI5H1TenItQAwE8Rkwz/vgs+IZy9ElWEujZ79O/O25E0xKGbL1aOhsh1DGCg6/9/p6
 KvOazNMoQzQV8lWM1M1GEk5IGizOkcGYUk5+gGeQNZRr4NvKiiKsgAfxBOFKW0Y6npt9
 6ctA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+L9fDkYOoHwz8rMsoci0EoLpM22Ly1lXTESoTLzpFI2wQzbDNMxQ916pr+w1+G71jAgh19kaivg2Vm@nongnu.org
X-Gm-Message-State: AOJu0YwZT214K1YZ/ltl7gCp8M5Jk9Y1JBAwFJk4HV06x4drV9Fzy+jV
 ltdIcsWwJ++TIBUMcatkF5vKd8n0PgJDsu0oJV9RVSKFUek3XYSnsFLYH8zo7cHXa3NszL0Pjcj
 QMoHcu30=
X-Gm-Gg: AeBDietmkFbqII0EcmNzVPZPrJSn+ZtfosuhK+k75i7WSG2lkPXaRzruLTNThU5IcNz
 /3K3nMC3hXT1No3PlDBNMpd9y0AwOtflbS4yrm1yR8RcJuKe3k/+SNS9HOvo+Xc1xAmwsbBgG9q
 7Qtt0Uc41K8WnElpMeTxmF8VW63Y6wE6R8YYm9PUQ5qA0GwIPgRt2t79hJBtRFSw1hn2Qe1CJfg
 PZje2L/AVVV8Cy7aBd8w0IESU7DgzK0KifT0NIzdd92BP+32wF2QBaPkO7ilMv9GEyS+HNAZ6LA
 gtHAzWLjm/ZF1L1llhUsXgJQINRSw46zuARh7LqWuB7fSeAjsaO6BQMH+TO/wf84bOprWyG2NmF
 0koYQh3xu15J1r2Yk/ZtROasJbV5CHYCcBCUEF9QfIiW1aafZw9KnKF3g77tF9f4He/leWkGPeN
 fPyB4PsvCj/sTRRX0H6xSYH8NV44TzvCul6Qc9XACEwKnC7XRSl7lSjF5lcHmbrOoj+xFJpEXZa
 crK7HV8oqc=
X-Received: by 2002:a05:6000:2dc3:b0:43d:d037:d59c with SMTP id
 ffacd0b85a97d-43fe3dd5069mr64972242f8f.16.1777277371176; 
 Mon, 27 Apr 2026 01:09:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-444eebec868sm3920561f8f.31.2026.04.27.01.09.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 16/32] monitor: Do not check TARGET_I386 to build 'info
 sev' command
Date: Mon, 27 Apr 2026 10:07:22 +0200
Message-ID: <20260427080738.77138-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
---
 MAINTAINERS                   |  1 +
 stubs/hmp-cmd-info_sev.c      | 16 ++++++++++++++++
 target/i386/sev-system-stub.c |  5 -----
 hmp-commands-info.hx          |  3 +--
 stubs/meson.build             |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_sev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f587756cbd..eeb7115edcd 100644
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
index da9fdc0ab7b..336ab870a2c 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -812,15 +812,14 @@ SRST
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


