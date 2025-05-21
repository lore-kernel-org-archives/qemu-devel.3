Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1782C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4X-0006AO-By; Wed, 21 May 2025 18:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4U-00068x-79
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4N-0005Yd-MX
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:57 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so6094809b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867069; x=1748471869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJmzJEfKJJ8E8nGh8tBJZD/8AHQeg+38e6Umva3AajU=;
 b=tlPKnQu+Ou/gwTvW0G6YdW0A1aXIg0TIZle5VA67zGsFpUy9vpKTs45ruZBN0wt5c0
 Zzi/QzJG1sX9vrCm6sw26JgKUHUUYKCBpyaePEgKq88KpK5LK1gBp3lqzD3toEWbJxRi
 FoPZg4ycPx+5s/O0lz5sjy28QReTFlWPYWYQo7+nlIO9s6F7wEhzqOoJMJxhHc40g9FC
 cfiVNsSei01As/nfCL4Ho6bQW1t3LvgzYAtSjt52rIVZDbOWh1KMc4yAMYceVwpNkF8m
 0ifXpranKHKs+kwIFvsYsugbZBGzkdawW7ZQJ16R6ITYc9pDXCJrC5+5IWQiZ/4E4l7z
 ZLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867069; x=1748471869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJmzJEfKJJ8E8nGh8tBJZD/8AHQeg+38e6Umva3AajU=;
 b=Lnb10jpuU+Rb0KP1ZRWMhne/yErq1mqJ7n9wIUbfEEOztGyGcEWGTITSPJLCHnwZOu
 R53av10O8P5UI4Tab31RLzonnD38iGFPQ8IkxmSMxH7FcpO7B99l+BzDlg6vgoVop3ix
 A6RHSBNAYL3DuijQaUdCMiVhDojlMAREcXoINJkVay5GTTiouJsItN/uOYK18CzHgjXJ
 N6k8pGXWyVR0cf2WGoKxR8Ca2A7HBJcfO0H2z7yJGsoldGDEBnuKhrM1hRByZyB/kei1
 85xFWDB1Fi5D82M4cO9G+AEk1RelJL1s9bK+ZUgvlVk4hHePvkuzyK/eekR9A522c5wQ
 aQIg==
X-Gm-Message-State: AOJu0Ywt5F/pzZZRm6WfUWT+7bxQOBYrACeYmGr6CB98TAp+DzFcdk6v
 jQ+HbUtWZyNBqnfV+DfhZMrl6FQdu7iLnU7MQhdxRZqQzsoI9o/4l0A3L4G/o9/WsbumfSLu3eQ
 uTxTh
X-Gm-Gg: ASbGncuv3G8cKpeSJjP7YAYzwFQB7TGSFDmKIiZuQSO6ZzcK6vL8O5RI+0XLlkpqnne
 LPqq2htQ32iaRkKVIWTagjw1s2gZ+jKvY1GTwgc46e8F3uXrjal2j/AMCnrvFGi+AuJMRuuKPnI
 t4sTlYls9nMFhZfxsInOqSg+zQ11z0VSe8+z/W51Mr1FZXwG6BHOWeAM6Wrzg+19Np91QrjK7JB
 qN3yzy2QulIUeeV8/keRXiC5+a+mkpAK+sMTuD3Eshdo/d09hzy+QffCEC7xxrJisbDyRB9Up4S
 lZQGqUXG/1qoOPHj8EHH60wpEx5dluG7n65JmzgByUJqG2+tpKs=
X-Google-Smtp-Source: AGHT+IF4ruTupc6N4Ph1aCd9Z2wlGTx+6ATH6Z8x4OvNlsOK8khWfSF5oWBGIVxNJLObTZnSFZbqpQ==
X-Received: by 2002:a05:6a20:3d88:b0:1fd:e9c8:cf3b with SMTP id
 adf61e73a8af0-216219b24cdmr36276934637.30.1747867068699; 
 Wed, 21 May 2025 15:37:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 04/14] qapi: expose query-gic-capability command
 unconditionally
Date: Wed, 21 May 2025 15:37:30 -0700
Message-ID: <20250521223740.249720-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
index c0d7b311f30..cc472ce91cb 100644
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
 # @SgxEpcSection:
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


