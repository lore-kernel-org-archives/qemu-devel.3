Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134B1F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHxd-0007aE-HB; Fri, 10 Apr 2026 15:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxZ-0007Et-HU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxV-0003pJ-Fv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so22042275e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850964; x=1776455764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k99xMD4s012E4So2wpbCNS02HNMrfRabi5ydC/W3ahM=;
 b=HR6rYuG7MCfqMjkRpYpiB9r9Pt99jtuZP6ntxr9DHjMPTiFKjZ24GVbQyzxAk5Cyl4
 Fl1LGtMb4fqlP9Yg805AYPplTqd08RwO6ZMUeOu8IpMADS2CYu3S2kzkjuDXtPKDkCut
 hOo6etvObrAk2qGeokHR62N9hu4zYW3dYgx1nbqXTg4wsghc6IhA1YHOMWX7lq7whnzx
 45/IEFQjvyEZ/4dMeWBzFNHz0VCAhV5M8LaGXfc0VeIWoinPuj/mzIMksCRcZNbGi3Gg
 poQI+Lt7CccRV6k+BDg2s4N888Djc+xc5gTl9oPaToDkgIdtnBVIH5TcWcjA+2aoziMt
 vXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850964; x=1776455764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k99xMD4s012E4So2wpbCNS02HNMrfRabi5ydC/W3ahM=;
 b=Uwn6lBmSZLpdO1lmnxqIUMIw0OBLiIPlPiN/A/RsyKtaq99Zo1Fz+nJU1doiXj/igy
 6YQXXXbVtYqGBfz3jpUIWWebN9xEXMxXTx3qkZ+CJjdQBBqyGVa2TkKZJNR7aLMhG6ba
 upyNtcyKPmGF4IGVivPQDJ7Wmx5+I7jsw3j4Wr9Hz1sD5c3aFGNx+NrdBbpeFLJxz/m9
 8kMLyBjF6mGVLDtobs95zB1aoAjSFpUNEkZeRIgbZT/l7eHJ67tqZfhulRR9+KeQF3zk
 2V1J4ZnXu3bdoOjDOuvL8tKpiSMvPSC15FMmN8vhHeQqAvVZVHWGkUvjsDBWOsEM0DZI
 wVew==
X-Gm-Message-State: AOJu0Yz+mgvO/+/fV6hDresBmgLh3XTvxHD6a/Rqm9nZMNOSmGN8nQxE
 0ttOXAE7Hl1CS6V/XgfrdjkGG771f9+xq72X7Y7IH1GH5Ga5ro25BMusQIxH/3jyUqR63j4Qn7Z
 +9zinmUg=
X-Gm-Gg: AeBDievuZShiH0INikSY2gQVwRWjg+fFI2l8ybMvD2GYPwlefXGB6W6SXPOEtPUsGG6
 aEyXrNwytIq/BGFnL+zqLl1WgRWqRyRrgLb+oKUdn03TpXzPlJpeC4b+iGzheP6H/kQM2G3sFro
 yDQJYl2XImA+ZZ5vFYGOT9741CT5wZsZlUJaP8JgEhgMUP9UvxMFZnm30KuBEf5L/Miy1uyCkxw
 +x4HrdWJitCqdEZURoeiRiZ0nMNy7HJswXj4NlrmnfJ0ZOMWk+50nou3/ADVPuxQC+F4LogG7Q6
 JGntaE1nCj0nDapN6r4zTALHYEp1x+xlD4ImWAimjhsyg5WrmQBL7XsUsci+/BSe2LYAR1jOyt3
 4lljShKPu2CPgcOhe58OZN26U4+ZuMtoorYsuY/+KgSvTql58aI8y54BMDkyQ8zw5ZsOid/+IpC
 5orZmIA6OEzG9HIGQ4MxSVoL73PgRsbJbmmfzEdlNaAqLKhAPJRT+K1OGIVNyAT6AeOriCJUco
X-Received: by 2002:a05:600c:609a:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-488d68ae78amr59095475e9.9.1775850963612; 
 Fri, 10 Apr 2026 12:56:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d525c931sm98635955e9.0.2026.04.10.12.56.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:56:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 22/27] monitor: Do not check TARGET_I386 to build
 target/i386/ commands
Date: Fri, 10 Apr 2026 21:53:16 +0200
Message-ID: <20260410195323.17937-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
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

These commands are filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter them at runtime, making it possible to compile
hmp-commands[-info].hx files once.

Since these methods are used inconditionally within target/i386/,
define them in the same stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                  |  1 +
 stubs/hmp-cmds-target-i386.c | 13 +++++++++++++
 hmp-commands-info.hx         |  4 +---
 hmp-commands.hx              |  5 +----
 stubs/meson.build            |  1 +
 5 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmds-target-i386.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e53158143a8..458951bc051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -148,6 +148,7 @@ F: configs/targets/i386-softmmu.mak
 F: configs/targets/x86_64-softmmu.mak
 F: docs/system/i386/
 F: docs/system/target-i386*
+F: stubs/hmp-cmds-target-i386.c
 F: target/i386/*.[ch]
 F: target/i386/Kconfig
 F: target/i386/meson.build
diff --git a/stubs/hmp-cmds-target-i386.c b/stubs/hmp-cmds-target-i386.c
new file mode 100644
index 00000000000..43a167056d5
--- /dev/null
+++ b/stubs/hmp-cmds-target-i386.c
@@ -0,0 +1,13 @@
+/*
+ * Human Monitor x86 stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_local_apic)
+HMP_STUB(mce)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 28dec25642d..b575e4ac993 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -113,16 +113,14 @@ SRST
     Show the cpu registers.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "lapic",
         .args_type  = "apic-id:i?",
         .params     = "[apic-id]",
         .help       = "show local apic state (apic-id: local apic to read, default is which of current CPU)",
-
         .cmd        = hmp_info_local_apic,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info lapic``
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ff65b39b454..cfd53bdc744 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1488,18 +1488,15 @@ SRST
   Stop the QEMU embedded NBD server.
 ERST
 
-
-#if defined(TARGET_I386)
-
     {
         .name       = "mce",
         .args_type  = "broadcast:-b,cpu_index:i,bank:i,status:l,mcg_status:l,addr:l,misc:l",
         .params     = "[-b] cpu bank status mcgstatus addr misc",
         .help       = "inject a MCE on the given CPU [and broadcast to other CPUs with -b option]",
         .cmd        = hmp_mce,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
 
-#endif
 SRST
 ``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
   Inject an MCE on the given CPU (x86 only).
diff --git a/stubs/meson.build b/stubs/meson.build
index d4a6bc0dde4..dc289e3a482 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -85,6 +85,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
+  stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


