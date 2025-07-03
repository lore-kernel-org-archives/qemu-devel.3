Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F94CC83F09
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHh1-0000mL-Iu; Thu, 03 Jul 2025 07:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdz-0005Lo-2F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdt-0002ZL-C5
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so5257861f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540291; x=1752145091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIKdQEQMhRvU2if5P5ei68jHnjUcTCqPA9NR4/HOCwU=;
 b=sAaAF05vWwrETqXLmonqmQiRcaRupAhJdR4puYUkc71ueMiuIQJEvOZ8jHMnHQUEYz
 EuSwj80tdKkkmND3zhJx4htgGn6BrSfkh++HGyAQ8WgGkZwEqFZwJbgU4h0l0YxTkMBf
 LdkyAA9VoOrLM68J9V+qLNarMGS7rD9YsL/KEBWGm98lV8amVOoQV+meyMcGmgxL88pu
 gokjnz0SMfWaRRqFWgvwhMvV4jgxm1pjB8n7L7zojf8RD9H6JvVri4xhq/55aplq9xF+
 b3bVhwOpilShmBZIKRt7XwT8d1+a+8t1r1dvpXxNoES47Rd6zbWpqhp6S6mukwzW7Z1C
 e5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540291; x=1752145091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIKdQEQMhRvU2if5P5ei68jHnjUcTCqPA9NR4/HOCwU=;
 b=Sg2E0iRpA3RuOUWz3EY8HaUMmy+y98lpmFUoO+A/nxrg/JLb4QGdiSWghdMOFxCL2e
 GOVwHuyZqppKhDPYd1eQ5tHa6J7jblcZgr5q5PgAy6Hl7+DmVldciUY1x4ZPY1P4kuW6
 6fpA16ZFFvrQq3JyZTlKX0pCQpim3OLLi4lJliFa2iWcQwF0pOM3EnRNZwpRGrLyYGyz
 MMn/d0VBCV7uSxcnF1OtvDGlEf02q7N2OBc7h5NZ7Nvs3wVMQoBwMMDRm28/Q52v60ya
 MK3prdN8yFRLjgCBbV6UmC7gvohY2v8kkx/F73DPJ7xViFMRvIVXYBhBEjoo8yDqPZld
 rKoQ==
X-Gm-Message-State: AOJu0YxbU4fwcQ4HSg4jIO1yBU+thgVkD2lI6XOsttilAE6p+33CSJwv
 v2Hsq3q033o1NK7Q/HrxZLQhMOSRIzNc/XxzpQjz/tMPRWYs0fT1/H8pR1oE74y5EQzmoclednP
 pudt1geE=
X-Gm-Gg: ASbGncsc0sg5ovDu0Tabt0xWF+qQfqCN2WdzmH5pvT8pwq/y3wQMKa9CfvzdI7lNSCe
 6xmbeyZUvFazJbZBClRkAs3zeRvS4pprrz/drf1Eu3DpUrENGlocv6xnsiZDJHSyWXFZu8OJf7T
 y+LrkEsZ91e2LJ75yzAPxraCQDzuvjUMyF7usujjP5CIrDpsA+y0OTuG502Olg6mskFo1loxHhZ
 USByR9kT6rCW7uzj+ua+IG/HS14K4KRVP+WGpUW1Yk6lVJld5o2v9UNbTLCd/zgHub0alpa+73O
 L0Smy9LLV9Vnd3XSwUlguqIpdsRZ3oX4p4SrK0ub3vNFGudMswxgwkTWjDS/7a7/cjutgczox2h
 aIjKLfH6BMUw=
X-Google-Smtp-Source: AGHT+IHwgKk5VrVHFX9rm+LGEdeJ7fke42sHffpGrRf9jRGQsl8mPqZf5MQ41AzswLHhRi5K9UL9vQ==
X-Received: by 2002:a05:6000:4611:b0:3a6:ec1d:1cba with SMTP id
 ffacd0b85a97d-3b1fea90838mr5549124f8f.20.1751540290789; 
 Thu, 03 Jul 2025 03:58:10 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52bb3sm18652440f8f.56.2025.07.03.03.58.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH v5 28/69] qapi: Move definitions related to accelerators in
 their own file
Date: Thu,  3 Jul 2025 12:54:54 +0200
Message-ID: <20250703105540.67664-29-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Extract TCG and KVM definitions from machine.json to accelerator.json.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS                |  1 +
 qapi/accelerator.json      | 57 ++++++++++++++++++++++++++++++++++++++
 qapi/machine.json          | 47 -------------------------------
 qapi/qapi-schema.json      |  1 +
 accel/tcg/monitor.c        |  2 +-
 hw/core/machine-hmp-cmds.c |  1 +
 hw/core/machine-qmp-cmds.c |  1 +
 qapi/meson.build           |  1 +
 8 files changed, 63 insertions(+), 48 deletions(-)
 create mode 100644 qapi/accelerator.json

diff --git a/MAINTAINERS b/MAINTAINERS
index b1cbfe115bc..c3ce0d37779 100644
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
index 00000000000..00d25427059
--- /dev/null
+++ b/qapi/accelerator.json
@@ -0,0 +1,57 @@
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
diff --git a/qapi/machine.json b/qapi/machine.json
index acf6610efa5..e4713c405e8 100644
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
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index a8f66163cb7..616e04970ef 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -55,6 +55,7 @@
 { 'include': 'introspect.json' }
 { 'include': 'qom.json' }
 { 'include': 'qdev.json' }
+{ 'include': 'accelerator.json' }
 { 'include': 'machine-common.json' }
 { 'include': 'machine.json' }
 { 'include': 'machine-s390x.json' }
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index adb9de5a1c6..d5dd677f2a4 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
-#include "qapi/qapi-commands-machine.h"
+#include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
 #include "system/tcg.h"
 #include "internal-common.h"
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


