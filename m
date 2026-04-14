Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7A7F531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgY-0002L3-TI; Mon, 13 Apr 2026 20:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgX-0002Ev-Bu
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgV-0003Cd-IR
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso61868225e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126678; x=1776731478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HhO+vrX/AM//JPlmWhzirx7E6tYyJP7oHGnG3g4hvE=;
 b=cEKIUQTOu4UTY373u49k8K1qJkBYaSD77VDfzR2Axvl3JpF26fn5qqGoxTCKN3Msw6
 k//4JHxZav8yJdQXejpTwUNVLCySIE/s51t+rY7+jSPTkZRrJB3AsQN906SnOBukQG+d
 G8kYz3Uclt6MdNREJlxCcUskMXF6B5aclBFabEVsrjiRE9LLHsmKDWQFUmihOKEar1gx
 oyTnV4faX4Cu90TH7/aidXVVVFLxHiJRwxEgC/bj3rvUl/ITBREaubJ/tP//wcvgezQP
 CB/UQxciM5zslnQ5118xvlwK5JTFt09GRU/jkfqJXGRIjZKw1g9xS3DtBNORFXuE8NO4
 zq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126678; x=1776731478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4HhO+vrX/AM//JPlmWhzirx7E6tYyJP7oHGnG3g4hvE=;
 b=B1SC1pKieaoiL8lL/4qbO5aqFYCGxBZMlCpuOOFiaYmtC3YcU7g7/xTXJbY4wyzb+V
 dgQQx7xmh1fbiAy4ZmS65omIkDFlBu3n9gIhHjJoYGHg9RNBUGiCkbJdsTyczERPVIUG
 kDvoZWmtI5b858bdfikf/ikl24vnRfVS+WaiWmS9kRQPUp+Ff6hIXN0PQhkYL5U3JsqA
 OQB4K2sxX+1v4W2QQKrj8k7/qMKBWJYamIteTjWKyc2KpcuF39uQshZ11F4gQwvjIbG8
 Vuid+oUFv1M+kDFzSVTX3OnSdMS5LDnk3b1lUnObMn/oAeV7hBvtrlc8j9sWah3ftyXN
 i65A==
X-Gm-Message-State: AOJu0YzrSKuXl5jPEzK+lumsTugOv7MdRCY+fdkP20SQCVIM/ixZkZjn
 uyui/ALSAkdO6aPS7JXrKbzydDV+aMPyIqDwaOqDe7mytoJ1eGW8nM23LWHsy6YMOp0Tmz8ea9T
 /pFrGPB4=
X-Gm-Gg: AeBDiete2YzyRsNjdQEiKEgdZY45SZ+VnVyYB8eCcP0d7PC/jLArOZJPS2ShlUK2hop
 3LKj+q+/TGNOKTqNaGUuGuq0LoDEnAxAmQ6sG67Ll7wmkfr+juQM/uqGFaGyRxC3FaCkbi+MR8g
 6DYds34V6ipamV1Kas45IdyYiiGZy7b50g7dgQ3JSj949m5IRDrm1ghOSglM7MY5rKGL8poL0kZ
 q1fk/4xIiy00/fz9pBWFllgMkUArEeBQN+3xq0/RjpL8vTketqwBCSFfGTZ0nwHBcMNYH3UD+Dj
 +A6s/hER/fAnWBKJO5OvGC0JTxPmlnPcDd2B9uaRODOFUXxoL1DuivN8Bjwc3KXSL5KHndni3Ix
 09fWCmUxxsdFwwn0Rw2aL1+KWYsFXdKH3cV4+Y2TRQbAyNBT+22nBU7DHHghiJD0IuO6nM1G4zN
 4f/9ytbgDAjYjkfKIbJhN1uuhi2wwca5W3WymE8HK8Csob30DnX6CveK2/p0lDoOHjSsEFHOB6
X-Received: by 2002:a05:600c:3150:b0:486:fcc7:d6a with SMTP id
 5b1f17b1804b1-488d67f4c4dmr233519535e9.13.1776126677556; 
 Mon, 13 Apr 2026 17:31:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e217sm10822615e9.5.2026.04.13.17.31.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 10/27] monitor: Do not check TARGET_I386 to build
 target/i386/ commands
Date: Tue, 14 Apr 2026 02:29:42 +0200
Message-ID: <20260414003001.97571-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

These commands are filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter them at runtime, making it possible to compile
hmp-commands[-info].hx files once.

Since these methods are used inconditionally within target/i386/,
define them in the same stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                  |  1 +
 stubs/hmp-cmds-target-i386.c | 13 +++++++++++++
 hmp-commands-info.hx         |  4 +---
 hmp-commands.hx              |  5 +----
 stubs/meson.build            |  1 +
 5 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmds-target-i386.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 306835ff678..a0c8f484163 100644
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
index 32c16209543..4d1a803c17c 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -87,6 +87,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
+  stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


