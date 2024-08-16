Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E22C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serX7-0006nX-EF; Fri, 16 Aug 2024 03:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serX5-0006dH-88; Fri, 16 Aug 2024 03:37:59 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serX1-0005uC-Us; Fri, 16 Aug 2024 03:37:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A85EB6210D;
 Fri, 16 Aug 2024 07:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF6DC32782;
 Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723793873;
 bh=3cYjdqh72I0rkHpnXfZu4oYXXcaaYATYUr29BIY2RJU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qW4y6Zc/S9sfNYQd3rLyXi7ZQDGCe8drrmNz4PYOY1/ZR+dU6et9hpBuO6ilPZ+k4
 zaJC6I0yFr+14bpCFJYGvcn9T2+8M8YXW5nqDfrrGofDHUPg3tTTY2wozd3VaU7yJU
 ujwBkhHcIDG7WDbZHoOLEBDEcLq3myA4Pscyv5J2uobvK7+CtRV4lLZCh0V9lPoUQa
 uKbvdbh9hXEB7mIYCWaRLLzsOnlzM1JnnOrJ/qSJ4ZKAZ64uFsK2PVqoVX8umC/cdq
 6/dBInIRo1sLWmDdkPitqaUvjd+oVYilzl91nskLfaD6TlHlie1FpoKls6Z7cJ0lEH
 YTklhJJEzuSvA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1serWx-000000055eX-291s; Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v8 04/13] qapi/acpi-hest: add an interface to do generic CPER
 error injection
Date: Fri, 16 Aug 2024 09:37:36 +0200
Message-ID: <f25af812712304aa754103250ee45bfcdd8314ce.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Creates a QMP command to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2.

The actual GHES code will be added at the followup patch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS              |  7 +++++++
 hw/acpi/Kconfig          |  5 +++++
 hw/acpi/ghes_cper.c      | 33 +++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper_stub.c | 19 +++++++++++++++++++
 hw/acpi/meson.build      |  2 ++
 hw/arm/Kconfig           |  5 +++++
 include/hw/acpi/ghes.h   |  3 +++
 qapi/acpi-hest.json      | 36 ++++++++++++++++++++++++++++++++++++
 qapi/meson.build         |  1 +
 qapi/qapi-schema.json    |  1 +
 10 files changed, 112 insertions(+)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/acpi-hest.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6da..1d8091818899 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2077,6 +2077,13 @@ F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
+ACPI/HEST/GHES/ARM processor CPER
+R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+S: Maintained
+F: hw/arm/ghes_cper.c
+F: hw/acpi/ghes_cper_stub.c
+F: qapi/acpi-hest.json
+
 ppc4xx
 L: qemu-ppc@nongnu.org
 S: Orphan
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index e07d3204eb36..73ffbb82c150 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -51,6 +51,11 @@ config ACPI_APEI
     bool
     depends on ACPI
 
+config GHES_CPER
+    bool
+    depends on ACPI_APEI
+    default y
+
 config ACPI_PCI
     bool
     depends on ACPI && PCI
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
new file mode 100644
index 000000000000..92ca84d738de
--- /dev/null
+++ b/hw/acpi/ghes_cper.c
@@ -0,0 +1,33 @@
+/*
+ * CPER payload parser for error injection
+ *
+ * Copyright(C) 2024 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/base64.h"
+#include "qemu/error-report.h"
+#include "qemu/uuid.h"
+#include "qapi/qapi-commands-acpi-hest.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_ghes_cper(const char *qmp_cper,
+                   Error **errp)
+{
+
+    uint8_t *cper;
+    size_t  len;
+
+    cper = qbase64_decode(qmp_cper, -1, &len, errp);
+    if (!cper) {
+        error_setg(errp, "missing GHES CPER payload");
+        return;
+    }
+
+    /* TODO: call a function at ghes */
+}
diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
new file mode 100644
index 000000000000..36138c462ac9
--- /dev/null
+++ b/hw/acpi/ghes_cper_stub.c
@@ -0,0 +1,19 @@
+/*
+ * Stub interface for CPER payload parser for error injection
+ *
+ * Copyright(C) 2024 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-acpi-hest.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_ghes_cper(const char *cper, Error **errp)
+{
+    error_setg(errp, "GHES QMP error inject is not compiled in");
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fa5c07db9068..6cbf430eb66d 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -34,4 +34,6 @@ endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
+system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
+system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c'))
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa2d..bed6ba27d715 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -712,3 +712,8 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config GHES_CPER
+    bool
+    depends on ARM
+    default y if AARCH64
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 419a97d5cbd9..b977d65564ba 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -23,6 +23,7 @@
 #define ACPI_GHES_H
 
 #include "hw/acpi/bios-linker-loader.h"
+#include "qapi/error.h"
 #include "qemu/notify.h"
 
 extern NotifierList acpi_generic_error_notifiers;
@@ -77,6 +78,8 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
+void ghes_record_cper_errors(const void *cper, size_t len,
+                             enum AcpiGhesNotifyType notify, Error **errp);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
new file mode 100644
index 000000000000..91296755d285
--- /dev/null
+++ b/qapi/acpi-hest.json
@@ -0,0 +1,36 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = GHESv2 CPER Error Injection
+#
+# Defined since ACPI Specification 6.2,
+# section 18.3.2.8 Generic Hardware Error Source version 2. See:
+#
+# https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10
+##
+
+
+##
+# @ghes-cper:
+#
+# Inject a CPER error data to be filled according to ACPI 6.2
+# spec via GHESv2.
+#
+# @cper: contains a base64 encoded string with raw data for a single CPER
+#     record with Generic Error Status Block, Generic Error Data Entry and
+#     generic error data payload, as described at
+#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 9.2
+##
+{ 'command': 'ghes-cper',
+  'data': {
+    'cper': 'str'
+  },
+  'features': [ 'unstable' ]
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index e7bc54e5d047..35cea6147262 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -59,6 +59,7 @@ qapi_all_modules = [
 if have_system
   qapi_all_modules += [
     'acpi',
+    'acpi-hest',
     'audio',
     'cryptodev',
     'qdev',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b1581988e4eb..baf19ab73afe 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -75,6 +75,7 @@
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
+{ 'include': 'acpi-hest.json' }
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
-- 
2.46.0


