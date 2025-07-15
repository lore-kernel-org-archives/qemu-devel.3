Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58508C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublns-0000kc-FU; Tue, 15 Jul 2025 15:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublas-0001wz-8V
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublaq-0002fu-2R
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4561607166aso21269325e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608732; x=1753213532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fEm4PPsUISdbcIL8hauQYYBs3+RjFypTP2CiyzADTEc=;
 b=lNBCKhuecYU9+T4vbW98rvIpXFtwn8CRHo0pjflFDCyWfET5UM6lF1Oa0HvZs6Zv7z
 coedlTugU4R/jxIIpWwq7e+gDbw8irzMLVIRxUUYdjrEzWhjzT7xxbnRwF1peof7QMqF
 jeBnyk9b4jhZr3q9nSyFF0mpH5Yo+VA7gmpZtJB5Cxdpv0+X5crYdHdcZAFSNsbf646o
 cAo/biXO3Y891pbthvlgXwb69IahDbIrtLkWZRVB1jhf6+4ancdyWd2ttllg9KbfX4Ch
 3k8C37vYm9+DQC8azkKXSF3LLh3equijU3cSgLTU+8eEefHKHHIsFTt9UaG7t5s124hg
 3u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608732; x=1753213532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEm4PPsUISdbcIL8hauQYYBs3+RjFypTP2CiyzADTEc=;
 b=nC1kvgsiUriyQP1FcnLCPcmfrKIKmvefPbqqBdS6Qi7FEahk58k0gAJIG5VwtXPdC6
 rN5tno+c0t8ijUmpdsOMkVcnbLW0paGoVlN3ZRWo8oLA5ffuPiba2N168q8csVUkdP4P
 P/gINB9sk4Pchw8Wmof+EJ/u+o5RftczjuSLQ6MmPvy170u+ZBuEOupEC1/KtfmzYOvt
 rtSSX9wLdvlynhOTQHyCFCqZAfGa312c3JXhqzkGUdPkMk6m8Ini06nUVgWalF8ehm77
 hg4xP3xhTDfvxj2mP4UkrEQk3k5ep3Pkm4Dv18O06gjGrTRItKnXw174QhWP4In0J6KH
 tPBQ==
X-Gm-Message-State: AOJu0YwYROqDr1gcN9I/jRbsIS0SqBrOQJaZf9yiYKG78AL/lzGWj2sh
 Dp5XbOIGMIUD2OOUvw2JZx63WLWNb3my5yDmiVnyUFDS0m/fqEBCJ/VTokRkKHMbYHSQNgh9s02
 ePea9
X-Gm-Gg: ASbGncvw1Z2/+NSXk9uhA7QwQFp57dBoUJf63poSIhV4VATCE0vIMCEpUSw9I8qrMzE
 BqUIT0cbDX75uk0nNNcsAliPIaHGXC639PIYkYOT4EtGsnX3vk9zGloLPbLkd0AFUzjsDaxHa63
 0ZOSgNcUGnyPx/FImtPfoke7X13ex6ZzsprJ1d2HfhicrKv2X1ajp7L/S4hWs+VQkRnA70Ivqt2
 K4/4Qfq8B/BMyEzydZIAcVq4wF2GdF8NNA/867UQpB9AKe16QOAmAIofPkVTIaOOVdmwknJjGjx
 a00FItALZBVvQiz3fHCnl6739K6zlDG/eL1vphv+T8TXyNQfvZUj20dcIcg1ASf03s35PClJXjG
 FjrakvMa9i4EfvFWtvkh8304BKnNZLqI1I4CsG96u9N7ojrs1IaFHe227kHLVywEyf7rZlIXgz/
 s4MN9/X7eIziTJ
X-Google-Smtp-Source: AGHT+IG0d+wRCK39ryFCrncq5yv0a2BtHfS46fY09WxS3G3LsJRerUXKkkXstEvAxFTBd7be3ka1Lw==
X-Received: by 2002:a05:600c:c16a:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-4562e03207dmr1648905e9.6.1752608732279; 
 Tue, 15 Jul 2025 12:45:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456084873b0sm109690305e9.39.2025.07.15.12.45.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] qapi/accel: Move definitions related to accelerators in
 their own file
Date: Tue, 15 Jul 2025 21:45:02 +0200
Message-ID: <20250715194516.91722-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Extract KVM definitions from machine.json to accelerator.json.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703105540.67664-29-philmd@linaro.org>
---
 MAINTAINERS                |  1 +
 qapi/accelerator.json      | 39 ++++++++++++++++++++++++++++++++++++++
 qapi/machine.json          | 29 ----------------------------
 qapi/qapi-schema.json      |  1 +
 hw/core/machine-hmp-cmds.c |  1 +
 hw/core/machine-qmp-cmds.c |  1 +
 qapi/meson.build           |  1 +
 7 files changed, 44 insertions(+), 29 deletions(-)
 create mode 100644 qapi/accelerator.json

diff --git a/MAINTAINERS b/MAINTAINERS
index e88ed2c0a97..0e945f3bd26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -509,6 +509,7 @@ F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
 F: cpu-target.c
+F: qapi/accelerator.json
 F: system/cpus.c
 
 Apple Silicon HVF CPUs
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
new file mode 100644
index 00000000000..d55fe1aa0a3
--- /dev/null
+++ b/qapi/accelerator.json
@@ -0,0 +1,39 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# = Accelerators
+##
+
+{ 'include': 'common.json' }
+
+##
+# @KvmInfo:
+#
+# Information about support for KVM acceleration
+#
+# @enabled: true if KVM acceleration is active
+#
+# @present: true if KVM acceleration is built into this executable
+#
+# Since: 0.14
+##
+{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+
+##
+# @query-kvm:
+#
+# Return information about KVM acceleration
+#
+# Returns: @KvmInfo
+#
+# Since: 0.14
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-kvm" }
+#     <- { "return": { "enabled": true, "present": true } }
+##
+{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
diff --git a/qapi/machine.json b/qapi/machine.json
index f712e7da6d6..f80ba264b53 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -451,35 +451,6 @@
 ##
 { 'command': 'inject-nmi' }
 
-##
-# @KvmInfo:
-#
-# Information about support for KVM acceleration
-#
-# @enabled: true if KVM acceleration is active
-#
-# @present: true if KVM acceleration is built into this executable
-#
-# Since: 0.14
-##
-{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
-
-##
-# @query-kvm:
-#
-# Return information about KVM acceleration
-#
-# Returns: @KvmInfo
-#
-# Since: 0.14
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-kvm" }
-#     <- { "return": { "enabled": true, "present": true } }
-##
-{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
-
 ##
 # @NumaOptionsType:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index a8f66163cb7..0477696ff02 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -37,6 +37,7 @@
 { 'include': 'run-state.json' }
 { 'include': 'crypto.json' }
 { 'include': 'job.json' }
+{ 'include': 'accelerator.json' }
 { 'include': 'block.json' }
 { 'include': 'block-export.json' }
 { 'include': 'char.json' }
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index c6325cdcaaa..5ca0da77b14 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -18,6 +18,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qapi/qapi-commands-accelerator.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
 #include "qapi/string-output-visitor.h"
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c68..1af0f29f7d3 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -14,6 +14,7 @@
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qapi/qapi-commands-accelerator.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qobject.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/qapi/meson.build b/qapi/meson.build
index 3b035aea339..ca6b61a608d 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -57,6 +57,7 @@ qapi_all_modules = [
 ]
 if have_system
   qapi_all_modules += [
+    'accelerator',
     'acpi',
     'audio',
     'cryptodev',
-- 
2.49.0


