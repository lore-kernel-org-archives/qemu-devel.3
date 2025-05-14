Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEC8C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLjF-0001qh-2X; Wed, 14 May 2025 19:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj6-0001cO-Qr
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj4-000359-OS
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22e033a3a07so4100455ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266085; x=1747870885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fXGk75xb2Eek1gtiwnDqmCNj/bRoXzc0AZydpuFChw=;
 b=QXbY1gDFq0yeMrfUv0FrJ2VsqxK/YjIY7QaSyII67Ta1Ni8Dz6Eucrpd4Tghzn2sSJ
 mmeRiW8epO9mwjXJ6stB3RbvCAZUzCP6YLCylBkdFijfhahl3BWjXJFVNL5PEXc6NpHH
 1qK0tkULx/AtMetZZyOYgzmFDJWzuGlDLIwCDv4UKA+vmmuqeaJLJ+VqbXFCjNBsU8Ch
 SNj8mXuDSOLz+yYacIJFxwb7RWw9flNlrwCghypPwzJ2dAoJkrSMo5ly+EKH4z5KuvkD
 DCKvhWQWbAOxYO/sw3YiP6WyPJJein5dONLT8xUAAsOIEE00Beuhz2u2+wiVpLJ3w9fY
 4tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266085; x=1747870885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fXGk75xb2Eek1gtiwnDqmCNj/bRoXzc0AZydpuFChw=;
 b=BJV1BSOBhGaJKJ5E97IqNP+GxIWfEzUfNqK+rzCn1YAW8ZMaNLf8ZMIJBrP0M/5Zg2
 rzdGyF+PbR8BJscXAzh0nUQ3NNlM4tQT9n6ijEJdS5PrlCzSKKW7jzivqczb/NHejzql
 4D2Ubu0YAK/pPMkjpOSu5NMTBm6mhZn3PSfaUPQNQeTWddt2rifuYSd6CzBa+izXTZSc
 8DNXq1OcSj2T9wbOmFoZW4zMJpIzASUv1GWzI48COfe5pXZ/4qO9lSIIZ25vOz4nvOQK
 ajoXZMkBaCwHf1d+jqELx6zdZE6/TeMM93oluJhM5a3ZOwB7V64FbIEh1Z3ln02E/dl6
 37qg==
X-Gm-Message-State: AOJu0YzDHHPoqyegwRyQcU2tguYynP79eM0ri8vuEnrOaGQnLf3hr6Fj
 BgsMWpCaVRvFdhw/XnIQvqFjyjf7hunxRu4lpGIwCnsZXZOUOZ7jQfiDk3Yh8Q9MPmGg5JkWkXh
 ZxdI=
X-Gm-Gg: ASbGncuiEi36/d+s3VUCpIBEpogQgKnAjHiWfYoboCiK9K/l0jlMNr1/mQ8BNU7CkPi
 TesHlTfD7E7Fr0ZCIvdEN/M0PD/Fi14RKScynuqB23WKOsNKuGhE1EQEYRskxzQOi1vaKE2WrVe
 TBhqkLgE5jvs0Dod+Fw4F/AqGyW9/p3U2yYX9fqFn/U9mLtOZ/xyHsJBEOiPa9Xv4Q8au/xeb/Y
 JxWUOUaphEztjoo8u9C1tgd3RZQaBoird4Tu2SZg0oHiYIsfhfHu7HmUMLMXJ4P+MERbgbbppJX
 cch0Z9fGOqqKLMvAGiewsJCBtWfFbYUhu+J0Z9SFcGr2Gjgyb2o=
X-Google-Smtp-Source: AGHT+IEy8SP4nqOrCflUwBsXqFNu6lBtEwywgYrljC9BoeTTGYZtrzpKcsEHQEkV4adICnIJN+LNSQ==
X-Received: by 2002:a17:902:d54e:b0:22f:b716:c39d with SMTP id
 d9443c01a7336-23198148d76mr68645155ad.33.1747266085319; 
 Wed, 14 May 2025 16:41:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/12] qapi: make s390x specific CPU commands unconditionally
 available
Date: Wed, 14 May 2025 16:41:06 -0700
Message-ID: <20250514234108.3746675-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/machine-s390x.json         | 121 ++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json           |   2 +-
 include/hw/s390x/cpu-topology.h |   2 +-
 hw/s390x/cpu-topology.c         |   4 +-
 stubs/monitor-cpu-s390x-kvm.c   |  22 ++++++
 tests/qtest/qmp-cmd-test.c      |   1 +
 qapi/meson.build                |   2 +-
 stubs/meson.build               |   1 +
 8 files changed, 150 insertions(+), 5 deletions(-)
 create mode 100644 qapi/machine-s390x.json
 create mode 100644 stubs/monitor-cpu-s390x-kvm.c

diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
new file mode 100644
index 00000000000..966dbd61d2e
--- /dev/null
+++ b/qapi/machine-s390x.json
@@ -0,0 +1,121 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+{ 'include': 'machine-common.json' }
+
+##
+# @S390CpuPolarization:
+#
+# An enumeration of CPU polarization that can be assumed by a virtual
+# S390 CPU
+#
+# Since: 8.2
+##
+{ 'enum': 'S390CpuPolarization',
+  'data': [ 'horizontal', 'vertical' ]
+}
+
+##
+# @set-cpu-topology:
+#
+# Modify the topology by moving the CPU inside the topology tree, or
+# by changing a modifier attribute of a CPU.  Absent values will not
+# be modified.
+#
+# @core-id: the vCPU ID to be moved
+#
+# @socket-id: destination socket to move the vCPU to
+#
+# @book-id: destination book to move the vCPU to
+#
+# @drawer-id: destination drawer to move the vCPU to
+#
+# @entitlement: entitlement to set
+#
+# @dedicated: whether the provisioning of real to virtual CPU is
+#     dedicated
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 8.2
+##
+{ 'command': 'set-cpu-topology',
+  'data': {
+      'core-id': 'uint16',
+      '*socket-id': 'uint16',
+      '*book-id': 'uint16',
+      '*drawer-id': 'uint16',
+      '*entitlement': 'S390CpuEntitlement',
+      '*dedicated': 'bool'
+  },
+  'features': [ 'unstable' ]
+}
+
+##
+# @CPU_POLARIZATION_CHANGE:
+#
+# Emitted when the guest asks to change the polarization.
+#
+# The guest can tell the host (via the PTF instruction) whether the
+# CPUs should be provisioned using horizontal or vertical
+# polarization.
+#
+# On horizontal polarization the host is expected to provision all
+# vCPUs equally.
+#
+# On vertical polarization the host can provision each vCPU
+# differently.  The guest will get information on the details of the
+# provisioning the next time it uses the STSI(15) instruction.
+#
+# @polarization: polarization specified by the guest
+#
+# Features:
+#
+# @unstable: This event is experimental.
+#
+# Since: 8.2
+#
+# .. qmp-example::
+#
+#     <- { "event": "CPU_POLARIZATION_CHANGE",
+#          "data": { "polarization": "horizontal" },
+#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+##
+{ 'event': 'CPU_POLARIZATION_CHANGE',
+  'data': { 'polarization': 'S390CpuPolarization' },
+  'features': [ 'unstable' ]
+}
+
+##
+# @CpuPolarizationInfo:
+#
+# The result of a CPU polarization query.
+#
+# @polarization: the CPU polarization
+#
+# Since: 8.2
+##
+{ 'struct': 'CpuPolarizationInfo',
+  'data': { 'polarization': 'S390CpuPolarization' }
+}
+
+##
+# @query-s390x-cpu-polarization:
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Returns: the machine's CPU polarization
+#
+# Since: 8.2
+##
+{ 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
+  'features': [ 'unstable' ]
+}
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


