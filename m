Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F4AF531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgl-0002pC-Sy; Mon, 13 Apr 2026 20:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgl-0002lS-2y
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgj-0003F3-Ds
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so34955205e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126692; x=1776731492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bt+4kyReD5cZ8XMM2eCoJcAo0IpKXrafGm4URfy/RPM=;
 b=vgg2DXgiAQDowJFrSu+KqdEc8kILn9hc91SrGCLEc0ZleLJRBPehsKwGxAOq9XU5nc
 5w2BoBmB+QxUIrDSW1E83pFFPVJJgswZ2pAMNt7AnpL2YtmDJAFpUETdZvdAclvbKoml
 B8gfq2Yk29/rPox7bv84wS3XLhBnoNj92sa1kRcdPtXlFXSwoc4d1SSHT4feI7rrpOVs
 YB7+P3sM259EOr8TTdvTnOBArxIB8kSZ4OB67Jxg4Qz/XWER17q3sVKCuX1b+d7FdZQh
 ueRMuIl/2bHdgms8bnQDHOT2WDStqf1QabvLdo9Y18Q/biH1pIZFmYvLSSJb3TbwKaBK
 BV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126692; x=1776731492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bt+4kyReD5cZ8XMM2eCoJcAo0IpKXrafGm4URfy/RPM=;
 b=Rooqe2baIW0LssJ+HiwQYlLEJUPSxa9oQztEZOuPq/jrZAjGvXmwjfeaD5KJLJIgtB
 /zh0t4FKifzb2dG7Jha4VZtcqnd4Rm4Xs8D+q+Txx3NftH0wRo07yNXUwF1loT5AfBPE
 9aeN/k11tlfQ0mEjiRoko+Gm8R3dhXBqsVqbQ9R1AFKPbaIsFQCgBVL0Z/u91a7Ai6eL
 UMuBiTz4pznArS9JVStO/KMXOS3QRxgsDUeoiv/igImoHm+f+YEgglFm8C9Gw6XYe5UO
 Xzc0jCiNBOcPK8xe984e4P6YXSNEOqSlFBpu+PgfdJBhaA/Jo2nufOzY3b7FfCGAkEUZ
 ppRA==
X-Gm-Message-State: AOJu0YxEUAzPkB0f1/iIqsDe8RArWLv1XBj26Mo58lCZqw9S+iPJmuYE
 OOstrNPHse8c8Cct+4965kQPhW014Cx+h+vI3EztXB4PIjFVGn5b+LYyAPUCZxgGOBxXDAxO2nn
 DDu33Y3c=
X-Gm-Gg: AeBDietpGopNvmKSX9br4XPQZiethdxk0SFzH+H0i09DVgjTT9sCTLwg0LrFv49/bLR
 o7cArDEgOCm4n9ffQHz3mpZv8AIToFwOTk8yjzJXYen38VpkrTLkaKaR9FsXw8LcyJ60K2SuJtM
 BiXFJ2W4BfKrdqaFPYQ8TtJaLlKxQkqCakvbYqJGQkzQAH2OPz3ySa1J06c7XHYTQKlVPItQmxI
 n3rwBpy/tDddBdG7/x/Z5RSJM9abdwLihyw4ktMNN2JJvP9KH0LZMNVMZ8Jz8sbfB0NGrRqnHSA
 VHgZ8TrxN3ulFU/pfXDhXERWvPQjwc1Wv8Wpceyhyk8MOHmC7HkKlTn5ResqCmQPyOpHON2yE8j
 MNQVNohj8BiqvkjTlS0NQ2afV+pf4UZcuPvyhDvepi7qzLAHk8lsnpjrqWySBy25cFO/oBy1a08
 vzme10aKY/c5PuHHYHRI7I5u/+bqKUL7JwVpDiOsOYPJqhFlz3CXFMg4ISEpDKv6dwJ6EsS9wi
X-Received: by 2002:a05:600c:64c4:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-488d686c04fmr187577555e9.21.1776126691684; 
 Mon, 13 Apr 2026 17:31:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e05bsm12018185e9.6.2026.04.13.17.31.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org
Subject: [PATCH v3 12/27] monitor: Do not check TARGET_I386 to build 'info
 sev' command
Date: Tue, 14 Apr 2026 02:29:44 +0200
Message-ID: <20260414003001.97571-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
index 16a3d71af02..580a80ab254 100644
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
index 4d1a803c17c..4a1d687a111 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -86,6 +86,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0


