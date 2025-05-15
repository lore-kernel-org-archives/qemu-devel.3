Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADF2C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcN7-0008WV-LG; Thu, 15 May 2025 13:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN1-000864-Dv
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMy-00024v-L0
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso1299728b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330063; x=1747934863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otN1ZYxqLIukz5ceFORIX+3/pUpnYfvslClWMIlE2/E=;
 b=mIFk2dlY3M5Fga8pDPqGHQNos8XVmfQIwpv5zFyemVf1WryUWasBySwygi5vww1X9x
 exfRberrgAudnTcAg0wxRrFGWB2m0xvx0FYaEk/ZuFrk2PiUSxqDEKZVmFNBYwQ35PG4
 I34ty7UQRdP4xh4uH2oOpBkT6eRhdSX/hRFLFzbQ0brMUjVK/eiehGBF4Ep/srhRzlNk
 hUSperD/DtYLyuokszStlUC9NvwmhjtN1YaDcHhopbBJPlthmR/r9oZUaaXmVE9yxNC9
 wJJcah6mPVs9v5pZfQp/6PQr3/wlXyxzphmSOs+CpXQxL1eMllb42THlJVD1ld6vy5x0
 lU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330063; x=1747934863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otN1ZYxqLIukz5ceFORIX+3/pUpnYfvslClWMIlE2/E=;
 b=kCXng6hQW+v8jxJ3JA+MddRsKxHmlNUzH5AXO5K/6LNq3JPdGnPDFFBp7ysQDSKnOs
 bRQhFhU1RQB5Ao2VaE8Siu7JTlpoc930OC4k0cG12KGmRCpx79FnbatfcsmPIbIBOT4L
 SFdGiLetrskvmDF6Cn70KFg3iCnyU3C9hQU47zUeIvklxqvWZigbW00XCTLUDyZvkZrP
 OUBvw0OwGXGfEkQiTjH9te6uZrfmH3u9Wt5Tkf2ialOCiLL1tlueIQDshdCqpUVW8nGx
 0LktayGRBei3vTUj3RXcrVmIZGL07eUaz1xYxbSeEUmBOulA0DY8cBUUi6XiPBLQKLi4
 Js4Q==
X-Gm-Message-State: AOJu0Ywen188F7f0kQV0VgsZBn74yE6VH9qWUUWXcnYZ4YgCcya5+87v
 FBGgtRtLBmuYuT7a5N17DyTtK53GIE4hS8K3Q0LydDpURhQHDokKef8kmH2WJfB/4LcjCo8fjfM
 7ixwP
X-Gm-Gg: ASbGnct1Z+dt4zW3K339obIH//SilvJer0pZaSupC7hDiDghleTfZvD7UaTRWmlvdaY
 sQqRVdUbbg03BVWqIedTSd1QrtHdAb8TkROWkFk0UM22dHgb/1gSLvanXtjqVV5ZWrnKEnQVmfz
 YJUzv+WbTQYuPaz/qR4Gga6LJlgvHrCwFPRHRxpQ1XQhUbpKpa6sx0sVwzoh4jItuDWSN5c1ZCf
 jpUJSpraEooMuOs+coCoj9S73LfP7/7ybr9/e/RYB7i0rIFzu2rqKm2S8pDwqPMmVkXsh9VKTeh
 UhHS28BODla4vZRjLgKzDijmj+Hv69GzZ4jwqyQxTY2mfAM8hQg=
X-Google-Smtp-Source: AGHT+IGLjKV2ag6SkxFNEdJpoilfMlrj+hKA/N9o9Xfq2hepc/vMkbVrBwYxd6d5S39xxBnlL2XXlw==
X-Received: by 2002:aa7:9a8c:0:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-742a9a282demr219937b3a.4.1747330063010; 
 Thu, 15 May 2025 10:27:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 04/12] qapi: expose query-gic-capability command
 unconditionally
Date: Thu, 15 May 2025 10:27:24 -0700
Message-ID: <20250515172732.3992504-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_ARM condition from the query-gic-capability
command. This requires providing a QMP command stub for non-ARM targets.
This in turn requires moving the command out of misc-target.json, since
that will trigger symbol poisoning errors when built from target
independent code.

Following the earlier precedent, this creates a misc-arm.json file to
hold this ARM specific command.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-arm.json        | 49 +++++++++++++++++++++++++++++++++++++++
 qapi/misc-target.json     | 44 -----------------------------------
 qapi/qapi-schema.json     |  1 +
 stubs/monitor-arm-gic.c   | 12 ++++++++++
 target/arm/arm-qmp-cmds.c |  2 +-
 qapi/meson.build          |  1 +
 stubs/meson.build         |  1 +
 7 files changed, 65 insertions(+), 45 deletions(-)
 create mode 100644 qapi/misc-arm.json
 create mode 100644 stubs/monitor-arm-gic.c

diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
new file mode 100644
index 00000000000..f5341372f5a
--- /dev/null
+++ b/qapi/misc-arm.json
@@ -0,0 +1,49 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# @GICCapability:
+#
+# The struct describes capability for a specific GIC (Generic
+# Interrupt Controller) version.  These bits are not only decided by
+# QEMU/KVM software version, but also decided by the hardware that the
+# program is running upon.
+#
+# @version: version of GIC to be described.  Currently, only 2 and 3
+#     are supported.
+#
+# @emulated: whether current QEMU/hardware supports emulated GIC
+#     device in user space.
+#
+# @kernel: whether current QEMU/hardware supports hardware accelerated
+#     GIC device in kernel.
+#
+# Since: 2.6
+##
+{ 'struct': 'GICCapability',
+  'data': { 'version': 'int',
+            'emulated': 'bool',
+            'kernel': 'bool' } }
+
+##
+# @query-gic-capabilities:
+#
+# It will return a list of GICCapability objects that describe its
+# capability bits.
+#
+# On non-ARM targets this command will report an error as the GIC
+# technology is not applicable.
+#
+# Returns: a list of GICCapability objects.
+#
+# Since: 2.6
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-gic-capabilities" }
+#     <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
+#                     { "version": 3, "emulated": false, "kernel": true } ] }
+##
+{ 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index ba4403a9241..d36292b3321 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,50 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @GICCapability:
-#
-# The struct describes capability for a specific GIC (Generic
-# Interrupt Controller) version.  These bits are not only decided by
-# QEMU/KVM software version, but also decided by the hardware that the
-# program is running upon.
-#
-# @version: version of GIC to be described.  Currently, only 2 and 3
-#     are supported.
-#
-# @emulated: whether current QEMU/hardware supports emulated GIC
-#     device in user space.
-#
-# @kernel: whether current QEMU/hardware supports hardware accelerated
-#     GIC device in kernel.
-#
-# Since: 2.6
-##
-{ 'struct': 'GICCapability',
-  'data': { 'version': 'int',
-            'emulated': 'bool',
-            'kernel': 'bool' },
-  'if': 'TARGET_ARM' }
-
-##
-# @query-gic-capabilities:
-#
-# This command is ARM-only.  It will return a list of GICCapability
-# objects that describe its capability bits.
-#
-# Returns: a list of GICCapability objects.
-#
-# Since: 2.6
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-gic-capabilities" }
-#     <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
-#                     { "version": 3, "emulated": false, "kernel": true } ] }
-##
-{ 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
-  'if': 'TARGET_ARM' }
-
 ##
 # @SGXEPCSection:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 96f6aa44133..e96bff8d38c 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -61,6 +61,7 @@
 { 'include': 'replay.json' }
 { 'include': 'yank.json' }
 { 'include': 'misc.json' }
+{ 'include': 'misc-arm.json' }
 { 'include': 'misc-i386.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
diff --git a/stubs/monitor-arm-gic.c b/stubs/monitor-arm-gic.c
new file mode 100644
index 00000000000..b3429243ef8
--- /dev/null
+++ b/stubs/monitor-arm-gic.c
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-arm.h"
+
+
+GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
+{
+    error_setg(errp, "GIC hardware is not available on this target");
+    return NULL;
+}
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index a1a944adb43..ef18c867ca4 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -27,7 +27,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 
diff --git a/qapi/meson.build b/qapi/meson.build
index 3a9bd061047..5e93e6b8cfd 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -64,6 +64,7 @@ if have_system
     'qdev',
     'pci',
     'rocker',
+    'misc-arm',
     'misc-i386',
     'tpm',
     'uefi',
diff --git a/stubs/meson.build b/stubs/meson.build
index 9922ec7b88e..07e9d3799a5 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -77,6 +77,7 @@ if have_system
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
+  stub_ss.add(files('monitor-arm-gic.c'))
   stub_ss.add(files('monitor-i386-rtc.c'))
   stub_ss.add(files('monitor-i386-sev.c'))
 endif
-- 
2.47.2


