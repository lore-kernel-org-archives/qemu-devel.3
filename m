Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E88DC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBF0-0000wT-6U; Thu, 22 May 2025 15:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEq-0000vH-E7
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:59 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEo-0006SW-IO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso4188100b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940753; x=1748545553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJmzJEfKJJ8E8nGh8tBJZD/8AHQeg+38e6Umva3AajU=;
 b=G6Gm6sRY1EOqik7DlDrs/S+o7+S3odxAUYrPRWZcksoq3aa/7vPb7/AFk5tGq+ESKQ
 cavYux3keJE3vtX1UOKzcLJUW1Cq3VgEHMJjMcIbMa3TuMmNyxN3VwxU2GiY/QwnZtRT
 QuAQ2s/HmWiSA0uGRCc6xN063G4Jg3FKDl9ckHf4hHDxsnkwjfnlGrasCtTct/cR6xWv
 YquhIxrdv7QGX50sMpJXNNKYkq8DJFQ6kpyopUQ+mWZtnqfXeVR8T7m3d2tzcT8Kfy6N
 mVC3XdaPy/eHnlMQR63ox/UYpJLyto7AjHFYX8KXH8LEQJ9z81SHnHmp9CFBiiGFjDMz
 0Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940753; x=1748545553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJmzJEfKJJ8E8nGh8tBJZD/8AHQeg+38e6Umva3AajU=;
 b=JzoQu10FYvIY4JqiUHSTKHqFVodkW7XbQ/D9wuEkdsKP01AwK0l6PBTwnScVrLJu6n
 OzT1sUO1j8IFhQdikea+Jfw01ZThxQHBHPGSlYdwo18+ACAvSSj45YIsw2q+gqhcVbJy
 rOlRrUuBl/qreKdbM9u+a/qL1bSmxcTUG/wtEh8H0qeEw0ZVSlplIW0rKX0yiYu8xoih
 fobp0GfqLYSEJDpE9sVKpsQwyDat4egj6H9ulb0Rbnf7SGRMRu6IofdSDWfVjK1V800J
 XyYpNAF3tqF6M2gzdJYA4MMgdtweyJUE/piWRd9OItxs2974Msn+1w/bmuOTp3dCAc9P
 EdfA==
X-Gm-Message-State: AOJu0YxJ+oNzNIXJwxmvgI1y4MySzHrBltdmLoBwEZP3ahE7fFqdt5QS
 09aBWRLEtLJyuReVgqIevvRRLHsAt6ex+TB/aHFv2nVJ7nwwkFLl29cSypiEY1GSKl025N6+J/s
 rLrXX
X-Gm-Gg: ASbGnct8wfrCtqCdRRnFRhLccjpNg1hQBA813kL9Ic3o1VQ5hwlgOBIveMshZcIB3lv
 YlULTUzth0RxnDwx8ooPw7VFuS3IscpfgwlcLsaadgX5vqmGSB+KE7w8X+pq+xuyJLVFrrEkv8n
 S+nVMN02RgC64nN8kPlf3BmbRIP3jxDB2mQE+6WJfN3vuoFAJi18C8zeopXJOJPyIeux8CAtShh
 PQhehR/ixN6Ll7K9GzpluMa7Mwejub9xrD9bApbm6Txb+Zyu8k3+nJKJLRkY4gnIU+IGnj8DKXX
 Dcsh5/rviTjbA3lUAbCzdz5sM0OQiojMyrMwG1Tb9tMPoOQzJss=
X-Google-Smtp-Source: AGHT+IE+ykTI9RpZD2/Uc440hpTG/WCKUufd96fQd4fMyDkd9oFXL8vNcWfm2ql89uyA1hRCuH0n4w==
X-Received: by 2002:a05:6a20:7353:b0:215:df62:7d51 with SMTP id
 adf61e73a8af0-216218ca4acmr38115553637.11.1747940753099; 
 Thu, 22 May 2025 12:05:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 04/15] qapi: expose query-gic-capability command
 unconditionally
Date: Thu, 22 May 2025 12:05:31 -0700
Message-ID: <20250522190542.588267-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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


