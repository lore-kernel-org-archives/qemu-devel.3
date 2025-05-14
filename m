Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77602C54755
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj4-0001Uq-5c; Wed, 14 May 2025 19:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj1-0001Pa-Lb
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLiz-00032O-19
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e4db05fe8so3181665ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266079; x=1747870879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqewT8RcOqdr655RwHxx5Aazd/ICT+n56pHpqqFvRbw=;
 b=W1izTu/2ffk7Q2JmQrNnRvEWmx9sjlbGNRTrFuLlENTIDVn5EQTqhK9z1zhQMcRNXI
 8/Gfj+67yxtFT9M85WS3SS6h410F5P65jvEZEB31W5gblQS6pspUzYdspBZPZPMChQNO
 Sr4CilJvw7I3kNldP0SmEvNiX7Uixde5MVUh3j3z5roeYIqJcyo9p5wgDKq9MjyvVfdG
 qAhQB2YYEhTDzQi1RlM2n83QyvaA2IkjikM5p6qComuCO/1IoDvN5aa7MWS6s85d3MSs
 FCBcF48x9pEtwPEFdyTUtrGnq4o0eehqJl09fkNjOcET39+MJVkVg3ww+tzuOeqMAwH0
 UQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266079; x=1747870879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NqewT8RcOqdr655RwHxx5Aazd/ICT+n56pHpqqFvRbw=;
 b=s4xgUqONjEBAHgS+RqCaAE5gJPa9TI79v3T/CffqoBKNBfJ9LbrCp+hCNNinKgOr70
 kyu+c+P+BpKyY799wDim7xSzs0npuA0+TxzVQbxuo6IBQ7RUmiYdkWxEK6bCAiv9MPSu
 ukSI1DDQwxBTkIFMf1oP48VqlQ/ylS9GJYhr3fFIDMokIolUVNhNSQ7oX5n0WbSkezmL
 DhgrQrC1Mt/EK4FHPmyeK1mXqZWpe3v9AcHBFLmAlipbQ6h3Q0B0RwzJC+KAJ3HGgzNI
 YycKq5iLK9GfZZ9bF/Iyq2PJyhD5/YE76YM9lC8vHLbsA5E3FiuhJoHVJyz4zGpGUzPt
 NFfA==
X-Gm-Message-State: AOJu0YzQ89Ens7ii3WsEExFxoHBbjSC/yPtAeCrmCZ8iOjOkMfL7nNcg
 59Rg9UsLg+EVelS4E1J1+yrrxaxeHPVeAMHII9V+E0gKAgnod9r2qXgt++iP1TY0fnfithBlXZL
 s0gw=
X-Gm-Gg: ASbGncuE9QYPv+4IZ7ksC9PnVIEchlkg8lFr5jgcvFFOxxvERaaOYnjGoJqrOtQLgBV
 VMj+vbAkgcenn4kfE40nVc/SPX7ksujnhuuF4YmMt0L7amj8V2vOl6fBdo2o3LYhLpMy9ZCnXlp
 Ah4zqc5Mk4LIK4q0YHAm2PdbUo4BOZHjNqv9HRW24iqIagXfIKPzUn2ax87X9J94CJcokHqNodl
 NpjzWvctBKbF78MeJApe15WYUdb7mjJ5pNEu3gjez/8y39ag50xjL5Q+F6GABINcIDpFjdB9tLL
 1KF71/jo1f2I3LNQK0ohqInG7onhL5u30U8hOt/794UXoyHP9GM=
X-Google-Smtp-Source: AGHT+IHaRwGpDMSKNt2vEwd0mjR0FG0kfxge+diKSz/KGUUjT2HJA8nVhlH6nXyvdSQlN+LaCsgiQg==
X-Received: by 2002:a17:903:946:b0:22d:e57a:2795 with SMTP id
 d9443c01a7336-231b5ed186amr5294765ad.47.1747266079479; 
 Wed, 14 May 2025 16:41:19 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/12] qapi: expose query-gic-capability command
 unconditionally
Date: Wed, 14 May 2025 16:41:00 -0700
Message-ID: <20250514234108.3746675-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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


