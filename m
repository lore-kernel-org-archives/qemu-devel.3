Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ECDCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcph-0007JE-VM; Wed, 06 May 2026 10:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcp6-0006sr-Kz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:02 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcp4-0000rL-Tl
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:00 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bc177ebda91so661750366b.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076116; x=1778680916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7fgSwGJ7wTlpU7DVYblOuyxY/0XBFQuA41SqLkoPpK4=;
 b=yIPuOX/JmD0EXBnZSshvr3ED9EHyyOb15iJDvqIPOp3MZr4N0rBIHZaYvQ0tE5F+nS
 +8oDR60ILZDP/X7lMY0Q2TronFRn2dvb/rvCs3kpM+dE3GItL7oz1n1004S0Pz3K9qYL
 bcDcyGtTNYab9cdKnbamVBh2UAbrvcK+F9XskGDgruM6DP6xCA+Tf1D6cT97pr8VCviQ
 B7RnPzUJ+AFvT/CDSBGIXnuPIpupGeIQT7jHGm1Z2PHJE59qwbyecj++FLnWbNFuP8EI
 dMWIwB7fDfzCcOR6MPRQVtSxqIdTQN62fKwzQC14K4ednn2bCLYYJIcJ+Ff8n2RzBeta
 USVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076116; x=1778680916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7fgSwGJ7wTlpU7DVYblOuyxY/0XBFQuA41SqLkoPpK4=;
 b=pYlInoy6FDOUGUidwMhd7nwyXvN7iv07zgBmC4pAxWnMY3vh2UODwMHo/BQKF8Qr/L
 z+mXsM9BcvS5kt2hc6qNlhAyRjxSnngEDpZg2EuxapTBMLAZrwLLECd543Dl6kaGIB6q
 Sh0Ie70o9FYB3uDsdMAssGj9vprQzRCDNokqLKCxe50H3bsz2yOmMcoecYLNgyPD3Lwh
 e0cRU2lfONifymFbFqTudqLg7CSj0xwNsl/sBofioxaTy+NX0UAQNeXVGRteR79Lt1+p
 IiVe9bP1MHyIhEe5vfzqTGD+sepMyqF2+zXUbs/dS762cD7kRZpzi5GNUoq+KS2RwaS2
 u9Xg==
X-Gm-Message-State: AOJu0Yz49Jha+cIXPSACXHbyQT/8BP08LjBqbbym11afE68hzUVreJ0t
 ahZ0VTvsUdk/AIF0JVr0MmfM580IXRQsPXJCwQhEImL+ytFiKvSNV1tvQXFXuHh6Ocsf3a7uGCi
 9Deql7so=
X-Gm-Gg: AeBDiev9eBWt94sWnm6vzDrflGzUUU0Z4qC8lq6zkUM5Z5VvtG9qByi+xnxpTwZhqTQ
 SB8pegP82QqdvU2sqTXKv85l37TwrVlEuZ/8eElcxfrloXTTx3WD9AWkZv/eCDurxWsXNabZV/X
 pTpkjSFEESUA44BfmF2oO9OHkuuCUPuNnIx1ISZEU7E2qmJG5VRNqGp4vfXDO3DQD6mCljPf7Fu
 40IGh9XGhzgew7L4cShy4qKEOzqpmhgrCle4lyB6IidK1f+tQKpEf7oJz+lIiNpNEUbst5E6g00
 LPj6GwhAWeyalu/akJR/iy6DjTPqBCRd5Fb7iVR8YT0A2yhmdRavHw++Bl1WDF4/m3HmiKgRgNH
 UqiLdej0wMUbUV8ozNXx3zwO+nOXGooUyylIA4LILl14AlWmQWg4WZm+4gtDsnk5Bvb6oc8RGJ7
 tsvMulR1C/V8C7dFVARej4XgVU7u05HDnE8RL+dG7mPkrk/cvH7Pleo83koJlXGlkXnOuzfEGic
 z1WHZk0caU=
X-Received: by 2002:a17:907:ea7:b0:ba6:8f34:b419 with SMTP id
 a640c23a62f3a-bc56ae27aa7mr178090266b.13.1778076112686; 
 Wed, 06 May 2026 07:01:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02f76sm12361742f8f.23.2026.05.06.07.01.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 050/110] monitor: Do not check TARGET_I386 to build
 target/i386/ commands
Date: Wed,  6 May 2026 15:54:22 +0200
Message-ID: <20260506135524.20617-51-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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
Message-Id: <20260427080738.77138-15-philmd@linaro.org>
---
 MAINTAINERS                  |  1 +
 stubs/hmp-cmds-target-i386.c | 13 +++++++++++++
 hmp-commands-info.hx         |  4 +---
 hmp-commands.hx              |  5 +----
 stubs/meson.build            |  1 +
 5 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmds-target-i386.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c57a01131c4..d022070a74c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -149,6 +149,7 @@ F: configs/targets/i386-softmmu.mak
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
index b1e2bf3c059..65af86278b4 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -106,16 +106,14 @@ SRST
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
index b41f44f5ad4..c3a1a95c5fb 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1502,18 +1502,15 @@ SRST
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
index 99a89c00066..6142e0f4d9d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -88,6 +88,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
+  stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


