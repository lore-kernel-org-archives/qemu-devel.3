Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF9FC5B553
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZo-0002dJ-5o; Wed, 28 May 2025 14:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZR-0002Le-Ce
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZJ-00071n-36
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzbsz/7MZy1fxk5o19sh7nCOQECtCVbwl8X7bRIulEs=;
 b=KhZY8Y4V9lK/N42Rl4oiSgAvOcHmR5Cpi8uwz+KZH1JOG2icgIsCbA380sOUB7T0CmLRBY
 u57DAKZjShTYkesWU4jQOo0T7wBoXziURTffkRArl3WizZaqDDYsQVjwqDd/pEV9qQkT8v
 kZxq7mtMiY2FxpBBO6ykKkqCgGSPoLs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-RbiXkxrJOWeDrqvPx3DRgw-1; Wed,
 28 May 2025 14:31:55 -0400
X-MC-Unique: RbiXkxrJOWeDrqvPx3DRgw-1
X-Mimecast-MFC-AGG-ID: RbiXkxrJOWeDrqvPx3DRgw_1748457115
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA36019560A0; Wed, 28 May 2025 18:31:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BB481956096; Wed, 28 May 2025 18:31:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BD7F21E66BB; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/13] qapi: expose query-gic-capability command unconditionally
Date: Wed, 28 May 2025 20:31:42 +0200
Message-ID: <20250528183151.2839034-5-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20250522190542.588267-5-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
index 0000000000..f5341372f5
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
index c0d7b311f3..cc472ce91c 100644
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
index 96f6aa4413..e96bff8d38 100644
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
index 0000000000..b3429243ef
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
index a1a944adb4..ef18c867ca 100644
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
index 3a9bd06104..5e93e6b8cf 100644
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
index 9922ec7b88..07e9d3799a 100644
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
2.48.1


