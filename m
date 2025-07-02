Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE243C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dK-0005lW-1r; Wed, 02 Jul 2025 14:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2d6-0005TN-UR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2d0-0002SK-IV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so2794662f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482575; x=1752087375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFx3N/Sw8FKjhjXRe+TJd3AuO90MwVK80ZLLTDnhkYU=;
 b=shMfwYL2KLMbldbhds/1F2hnA1ts7VrZR3wHuk5M+z07s8e7zUKFluChpdSmOfMbir
 No/zfAyYiColD6AroNRlD0fhHJSmSqr23Ao31zH2kIRcm3Uy8RXDN0vmU/zYPxUGzQjw
 ttxay7eZDAgt6Pci1ZZLuA1y5T1zrZHk+Bmws372GJFA9IOqH1X8b0uvUBZOltyLdeXk
 Xcp4c2T6hy4tBz15HGmnmbwu0oTLsYmmB+BRzOJdZ/85nJyvt1Lo+aFcNSTEBWpMqW6X
 LxEAeBNGMftTiZORVw0ChuYAF1aftwcxvFuKIbaix5+OrY0hxOGrARpagVgjNf4CBIqE
 iN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482575; x=1752087375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFx3N/Sw8FKjhjXRe+TJd3AuO90MwVK80ZLLTDnhkYU=;
 b=OrQcRo/k5YFM8/Svtjgan3T0mv1FrICMCCR9T6LJF0B1TUWseLJ1C1cMbJpAY/ryNG
 hyzkyY0LAQmB/uPyED/spdp8dPJjv6FBPVJBC3iDWotvNyQatK/nsVNOIrDHmlYUdrbt
 Oio2x6aAFAkaT2pwhAIJbUpgmlorHwJMXPFGZmEeTrZjdKmEMJqUWeB+47HWyiuz4yPR
 iqb3cbkRrFeerJi0/DbFD0HY4U24Th0C4+g3HlFUSsdNVsREj7q+CH+S7N8HG/Of5fGL
 JjCPUjO6cWmHzPVRl5/BfVYg2GOFKqN6awyXSrjEaHLiSnYc20wLkJ73bVhfQjCtZotp
 w7jQ==
X-Gm-Message-State: AOJu0YyADOgDzJD3knRJld1n79YppEAx6xgY8Kli0rN2RwUopjb51HGd
 Gn3sc5Ha/KMnafHF9QR582OMkisr1rb+8CfHTlX/9iJQQfzD/9CLvjtV4Xm+8f5nOdoP8AGuNbw
 PHWoe
X-Gm-Gg: ASbGncsXIA15xEi3c7qvIOvyV8BbBDPIJtdJcWWsAu4hdPFNgkCG9KWWfCYlwPXDiea
 Zw9c/sNFQNxP355LgT74vYOo4PHJ4I47LxSR31eJ9KqNY+FgdnWKU5hgrOzQFaPm5dcU9shiMNe
 h2T+CDDD612wIjT5VFpR7MLebAtN895aTf2iktQPDtVSE3Z7stCSYeUgYwU9BR8fFKA/h/5GCoD
 OqCyeZoQSVbOkbGnm3wG+mCTI4SaJWH/dHXN+nGk5Efcag6hO2uHLrLzLy7UnZ/DC3NCoMHqHtS
 ysZmoN5xcz8F3IBnsYwwUrjGW52t1SId+Xp54OZo5pxSarxEAcar0t0TYGW2Jun03l0qTQ3G0wi
 X8PvoiAWogEFm+0ndUCvnJt1I1wRrcQkLcP6y
X-Google-Smtp-Source: AGHT+IH+eXOXaGjfjtwP7dnGyYo7Hf80QwmNhdYqXAx1WDfQzlhVe2uvb1k4drG12WzGIPW8PKTW6Q==
X-Received: by 2002:a5d:5888:0:b0:3a4:d0ed:257b with SMTP id
 ffacd0b85a97d-3b1ff42f9b6mr3335947f8f.22.1751482575474; 
 Wed, 02 Jul 2025 11:56:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8absm17000638f8f.95.2025.07.02.11.56.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v4 22/65] qapi: Move definitions related to accelerators in
 their own file
Date: Wed,  2 Jul 2025 20:52:44 +0200
Message-ID: <20250702185332.43650-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Extract TCG and KVM definitions from machine.json to accelerator.json.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                |  1 +
 qapi/accelerator.json      | 75 ++++++++++++++++++++++++++++++++++++++
 qapi/machine.json          | 65 ---------------------------------
 qapi/qapi-schema.json      |  1 +
 accel/tcg/monitor.c        |  2 +-
 hw/core/machine-hmp-cmds.c |  1 +
 hw/core/machine-qmp-cmds.c |  1 +
 qapi/meson.build           |  1 +
 8 files changed, 81 insertions(+), 66 deletions(-)
 create mode 100644 qapi/accelerator.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 7128e0bc98e..5d6b337cef6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -507,6 +507,7 @@ F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
 F: cpu-target.c
+F: qapi/accelerator.json
 F: system/cpus.c
 
 Apple Silicon HVF CPUs
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
new file mode 100644
index 00000000000..1d2a83f1b22
--- /dev/null
+++ b/qapi/accelerator.json
@@ -0,0 +1,75 @@
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
+
+##
+# @x-query-jit:
+#
+# Query TCG compiler statistics
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: TCG compiler statistics
+#
+# Since: 6.2
+##
+{ 'command': 'x-query-jit',
+  'returns': 'HumanReadableText',
+  'if': 'CONFIG_TCG',
+  'features': [ 'unstable' ] }
+
+##
+# @x-query-opcount:
+#
+# Query TCG opcode counters
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: TCG opcode counters
+#
+# Since: 6.2
+##
+{ 'command': 'x-query-opcount',
+  'returns': 'HumanReadableText',
+  'if': 'CONFIG_TCG',
+  'features': [ 'unstable' ] }
diff --git a/qapi/machine.json b/qapi/machine.json
index d5bbb5e367e..e4713c405e8 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -454,35 +454,6 @@
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
@@ -1729,24 +1700,6 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
-##
-# @x-query-jit:
-#
-# Query TCG compiler statistics
-#
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
-# Returns: TCG compiler statistics
-#
-# Since: 6.2
-##
-{ 'command': 'x-query-jit',
-  'returns': 'HumanReadableText',
-  'if': 'CONFIG_TCG',
-  'features': [ 'unstable' ] }
-
 ##
 # @x-query-numa:
 #
@@ -1764,24 +1717,6 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
-##
-# @x-query-opcount:
-#
-# Query TCG opcode counters
-#
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
-# Returns: TCG opcode counters
-#
-# Since: 6.2
-##
-{ 'command': 'x-query-opcount',
-  'returns': 'HumanReadableText',
-  'if': 'CONFIG_TCG',
-  'features': [ 'unstable' ] }
-
 ##
 # @x-query-ramblock:
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
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 1c182b6bfb5..5bdd837006c 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -11,7 +11,7 @@
 #include "qemu/qht.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
-#include "qapi/qapi-commands-machine.h"
+#include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
 #include "system/cpu-timers.h"
 #include "exec/icount.h"
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 65eeb5e9cc2..15ae5864d16 100644
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
index ab4fd1ec08a..f37fd220c2d 100644
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


