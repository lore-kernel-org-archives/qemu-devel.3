Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD8C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4Y-0006Am-FT; Wed, 21 May 2025 18:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4W-00069i-8h
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4R-0005aB-Ku
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2320e53167dso51045665ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867073; x=1748471873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbuE30bzkvC7HXdLQ6ZO7n7D2r6LctI3gV9TqL6oovs=;
 b=c/TrN5HSVRdSUetqgljHJ6cJiy7gEyDEFMugUuk2q54j9yEwHIMrPi2UDv5ioMVadd
 K0+jLn0zQdQDrSzXxs0sw2UBRb0N3lg8383BWgdtZ/VJGCPzBVPbYY5Vm5Wej2VM8TqQ
 SzSy9Tqray0DOKQCq+lE3bPnrpX/U5naGm+v2HDB4qe/pJDySair8MYl32ZTmDN9kfb5
 W0JDcllnLuljm8/mNC2bzqsNyDSaP+kqlcuro2bmoRTlCtiV0DJFyAnFS2GSN52awPCk
 3MgtGOlFewOXKiFMxNNQLTsjSjF8cvfNDmfcQFLnpj96buuJcM0lU8fgEL9qQ+h+FL8d
 9KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867073; x=1748471873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbuE30bzkvC7HXdLQ6ZO7n7D2r6LctI3gV9TqL6oovs=;
 b=ois8u8le1tV9WZY1PrSzFGqcL8KeU+lUvG79QrKRHXgTEaY4LKUKlSHRSOhr048suz
 3naDCGt+CRgT/9Vy1jEainam/87DLlURNoJdfJ4BS7Z7552hVuCl3pTje+Q9yLIU4Dlg
 O8gIH8IMQLbbOMsg4eobeAbGjNAfsMwsYR5OGhAFBdU5Q5UzFQi5LYCF1PqBzPmMFapk
 XYt0fGLPHNn+YO08rFquhE4NsLe4reloTCEj9ae/G27+m+9NATNCRiJ1oBplGKgBoBxB
 XhTAqBhKKp3VHWzJR0YVc0Loaxm2/WXjG+6Gf2WbHfH9WVMXNvLrZJ6fp8zUQXRFLhdm
 LlwQ==
X-Gm-Message-State: AOJu0YzI54UI/9VfG8OapQXh/GfZ5v4iiF99o1xr6rOQwTaDgsClB685
 3y1Zew4pudyFhJbTmldDYqr9GNQ9Nvn9uxzJ2SHNowyhP2OKsmmcTIGjxGUNyKXm8e1x/zimjQW
 A/xvg
X-Gm-Gg: ASbGncsQHOBpa1wbsKCIiSwJ6dY4L7Qp1PTYQu9QkB3fXjOvn7GG2RXptmIPd1nByGv
 NRTiTEdmV+3bjcj9ha9dYCBCI+4+loGcndznrQfgQKU6OoIOOZARHBqF9hqwl2EV+PQm5yrrqGJ
 MS9hnaG0EEy1mkA6CE8DHXobBhuV4ZDtaPJVX0zvgSKpJBLc0veYhnm3SqMTZIALURPb7Hxx15S
 xcDfAvApXCbR1LSlhHzFImSCZmSuZyDZArQFwaO+ARzJxtBIwjSwfskzgWr5WFx+ivIrlPIjA+d
 Vc2J/g4cB/qFtE7SHVJR3ovhV7B0KR0Q7sQE0/tZB/P87ZXw3Ec=
X-Google-Smtp-Source: AGHT+IGdHGKLPSXb4JH0oFHxOaXRTerPf/3lAmTcaL8rYv4Vi2QwiCnqaUykurEmSweMSU6mL289Dg==
X-Received: by 2002:a17:903:1983:b0:22e:62c3:6990 with SMTP id
 d9443c01a7336-231d44e7182mr324414615ad.16.1747867073650; 
 Wed, 21 May 2025 15:37:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 09/14] qapi: make s390x specific CPU commands
 unconditionally available
Date: Wed, 21 May 2025 15:37:35 -0700
Message-ID: <20250521223740.249720-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

This removes the TARGET_S390X and CONFIG_KVM conditions from the
CPU commands that are conceptually specific to s390x. Top level
stubs are provided to cope with non-s390x targets, or builds
without KVM.

The removal of CONFIG_KVM is justified by the fact there is no
conceptual difference between running 'qemu-system-s390x -accel tcg'
on a build with and without KVM built-in, so apps only using TCG
can't rely on the CONFIG_KVM in the schema.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 ...machine-target.json => machine-s390x.json} | 16 +++++---------
 qapi/qapi-schema.json                         |  2 +-
 include/hw/s390x/cpu-topology.h               |  2 +-
 hw/s390x/cpu-topology.c                       |  4 ++--
 stubs/monitor-cpu-s390x-kvm.c                 | 22 +++++++++++++++++++
 tests/qtest/qmp-cmd-test.c                    |  1 +
 qapi/meson.build                              |  2 +-
 stubs/meson.build                             |  1 +
 8 files changed, 35 insertions(+), 15 deletions(-)
 rename qapi/{machine-target.json => machine-s390x.json} (85%)
 create mode 100644 stubs/monitor-cpu-s390x-kvm.c

diff --git a/qapi/machine-target.json b/qapi/machine-s390x.json
similarity index 85%
rename from qapi/machine-target.json
rename to qapi/machine-s390x.json
index f19e34adaf9..966dbd61d2e 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-s390x.json
@@ -1,6 +1,7 @@
 # -*- Mode: Python -*-
 # vim: filetype=python
 #
+# SPDX-License-Identifier: GPL-2.0-or-later
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
@@ -15,8 +16,7 @@
 # Since: 8.2
 ##
 { 'enum': 'S390CpuPolarization',
-  'data': [ 'horizontal', 'vertical' ],
-  'if': 'TARGET_S390X'
+  'data': [ 'horizontal', 'vertical' ]
 }
 
 ##
@@ -54,8 +54,7 @@
       '*entitlement': 'S390CpuEntitlement',
       '*dedicated': 'bool'
   },
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -90,8 +89,7 @@
 ##
 { 'event': 'CPU_POLARIZATION_CHANGE',
   'data': { 'polarization': 'S390CpuPolarization' },
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -104,8 +102,7 @@
 # Since: 8.2
 ##
 { 'struct': 'CpuPolarizationInfo',
-  'data': { 'polarization': 'S390CpuPolarization' },
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'data': { 'polarization': 'S390CpuPolarization' }
 }
 
 ##
@@ -120,6 +117,5 @@
 # Since: 8.2
 ##
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'features': [ 'unstable' ]
 }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index d8eb79cfda6..a8f66163cb7 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -57,7 +57,7 @@
 { 'include': 'qdev.json' }
 { 'include': 'machine-common.json' }
 { 'include': 'machine.json' }
-{ 'include': 'machine-target.json' }
+{ 'include': 'machine-s390x.json' }
 { 'include': 'replay.json' }
 { 'include': 'yank.json' }
 { 'include': 'misc.json' }
diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index 9283c948e3a..d5e9aa43f8f 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -13,7 +13,7 @@
 
 #include "qemu/queue.h"
 #include "hw/boards.h"
-#include "qapi/qapi-types-machine-target.h"
+#include "qapi/qapi-types-machine-s390x.h"
 
 #define S390_TOPOLOGY_CPU_IFL   0x03
 
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 7d4e1f54727..b513f8936e4 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -23,8 +23,8 @@
 #include "target/s390x/cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/cpu-topology.h"
-#include "qapi/qapi-commands-machine-target.h"
-#include "qapi/qapi-events-machine-target.h"
+#include "qapi/qapi-commands-machine-s390x.h"
+#include "qapi/qapi-events-machine-s390x.h"
 
 /*
  * s390_topology is used to keep the topology information.
diff --git a/stubs/monitor-cpu-s390x-kvm.c b/stubs/monitor-cpu-s390x-kvm.c
new file mode 100644
index 00000000000..8683dd2d4c6
--- /dev/null
+++ b/stubs/monitor-cpu-s390x-kvm.c
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine-s390x.h"
+
+void qmp_set_cpu_topology(uint16_t core,
+                          bool has_socket, uint16_t socket,
+                          bool has_book, uint16_t book,
+                          bool has_drawer, uint16_t drawer,
+                          bool has_entitlement, S390CpuEntitlement entitlement,
+                          bool has_dedicated, bool dedicated,
+                          Error **errp)
+{
+    error_setg(errp, "CPU topology change is not supported on this target");
+}
+
+CpuPolarizationInfo *qmp_query_s390x_cpu_polarization(Error **errp)
+{
+    error_setg(errp, "CPU polarization is not supported on this target");
+    return NULL;
+}
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 15c88248b79..040d042810b 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -100,6 +100,7 @@ static bool query_is_ignored(const char *cmd)
         /* Success depends on target arch: */
         "query-cpu-definitions",  /* arm, i386, ppc, s390x */
         "query-gic-capabilities", /* arm */
+        "query-s390x-cpu-polarization", /* s390x */
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
         "x-query-virtio",         /* CONFIG_VIRTIO */
diff --git a/qapi/meson.build b/qapi/meson.build
index ffe44f9e0b8..e038b636c9d 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -39,7 +39,7 @@ qapi_all_modules = [
   'job',
   'machine-common',
   'machine',
-  'machine-target',
+  'machine-s390x',
   'migration',
   'misc',
   'net',
diff --git a/stubs/meson.build b/stubs/meson.build
index 3b2fad0824f..cef046e6854 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('monitor-i386-xen.c'))
   stub_ss.add(files('monitor-cpu.c'))
   stub_ss.add(files('monitor-cpu-s390x.c'))
+  stub_ss.add(files('monitor-cpu-s390x-kvm.c'))
 endif
 
 if have_system or have_user
-- 
2.47.2


