Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08610FC6169
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 06:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spM2m-0008Oi-5E; Sat, 14 Sep 2024 02:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2j-0008DZ-IF; Sat, 14 Sep 2024 02:14:01 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2g-0000vw-2A; Sat, 14 Sep 2024 02:14:00 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5C897A40275;
 Sat, 14 Sep 2024 06:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D67C4AF0C;
 Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726294434;
 bh=3RQrGDT5taLaInTyANAJcj293zLQkcMfYoDxqj5xZkY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hIOiBJ0utC/sP06liMcY33wEpq3NI/RZqcMiOZoEXYjvnneBkcz7nIUOFbLfEMZvM
 jnbfgEvLuc68YRHr4PTHmp8BbbZ2HXhC6qPLiIBCGPydBJxvvfSdO5nZlu2Cwz9Msf
 XMtFuQPAfm+NCkDV9zYX15QzhNhSc7BOhoo2sYlis1soPvCloiaCIX3yVnDNteSD3Z
 oOseDBSeUheEkrt2HDuReGbeJKmMYxjoMm/826Onm/c7NcWDLy2uKNDdYq+1g1L2RL
 lI3WXeyodQhesL2oIdTQcnT8VNnH5Uvkf/5CTAyviu+h6+MiaKo6X0T7KYSlPPFryh
 tVncDCYE3VgBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2a-00000003V6V-1c0V; Sat, 14 Sep 2024 08:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v10 17/21] qapi/acpi-hest: add an interface to do generic CPER
 error injection
Date: Sat, 14 Sep 2024 08:13:38 +0200
Message-ID: <183121425ad8745e064b210461679e0f534b14ed.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Creates a QMP command to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2, and add support for it for ARM guests.

Error injection uses ACPI_HEST_SRC_ID_QMP source ID to be platform
independent. This is mapped at arch virt bindings, depending on the
types supported by QEMU and by the BIOS. So, on ARM, this is supported
via ACPI_GHES_NOTIFY_GPIO notification type.

This patch is co-authored:
    - original ghes logic to inject a simple ARM record by Shiju Jose;
    - generic logic to handle block addresses by Jonathan Cameron;
    - generic GHESv2 error inject by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---

Changes since v9:
- ARM source IDs renamed to reflect SYNC/ASYNC;
- command name changed to better reflect what it does;
- some improvements at JSON documentation;
- add a check for QMP source at the notification logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS              |  7 +++++++
 hw/acpi/Kconfig          |  5 +++++
 hw/acpi/ghes.c           |  2 +-
 hw/acpi/ghes_cper.c      | 32 ++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper_stub.c | 19 +++++++++++++++++++
 hw/acpi/meson.build      |  2 ++
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            |  7 +++++++
 include/hw/acpi/ghes.h   |  1 +
 include/hw/arm/virt.h    |  1 +
 qapi/acpi-hest.json      | 35 +++++++++++++++++++++++++++++++++++
 qapi/meson.build         |  1 +
 qapi/qapi-schema.json    |  1 +
 13 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/acpi-hest.json

diff --git a/MAINTAINERS b/MAINTAINERS
index c59f7b253825..776f94efff02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2094,6 +2094,13 @@ F: hw/acpi/ghes.c
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
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 7bea265c7ef3..d7d147ef40f2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -503,7 +503,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
 
-    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+    notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
 }
 
 int acpi_ghes_memory_errors(int source_id, uint64_t physical_address)
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
new file mode 100644
index 000000000000..02c47b41b990
--- /dev/null
+++ b/hw/acpi/ghes_cper.c
@@ -0,0 +1,32 @@
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
+void qmp_inject_ghes_error(const char *qmp_cper, Error **errp)
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
+    ghes_record_cper_errors(cper, len, ACPI_HEST_SRC_ID_QMP, errp);
+}
diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
new file mode 100644
index 000000000000..8782e2c02fa8
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
+void qmp_inject_ghes_error(const char *cper, Error **errp)
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
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b0606434c972..f2db8bc485f9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -893,6 +893,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
 
 static const AcpiNotificationSourceId hest_ghes_notify[] = {
     {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},
+    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO},
 };
 
 static
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d970893a3db6..5fdff23610d8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1011,6 +1011,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
 
 static void virt_generic_error_req(Notifier *n, void *opaque)
 {
+    uint16_t *source_id = opaque;
+
+    /* Currently, only QMP source ID is async */
+    if (*source_id != ACPI_HEST_SRC_ID_QMP) {
+        return;
+    }
+
     VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
 
     acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 83c912338137..54490a6dd13e 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -71,6 +71,7 @@ typedef struct AcpiGhesState {
  */
 enum AcpiGhesSourceID {
     ACPI_HEST_SRC_ID_SYNC,
+    ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
 };
 
 typedef struct AcpiNotificationSourceId {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 24ab84cd623d..d96edea8a3f9 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -33,6 +33,7 @@
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
 #include "hw/boards.h"
+#include "hw/acpi/ghes.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
new file mode 100644
index 000000000000..d58fba485180
--- /dev/null
+++ b/qapi/acpi-hest.json
@@ -0,0 +1,35 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# == GHESv2 CPER Error Injection
+#
+# Defined since ACPI Specification 6.1,
+# section 18.3.2.8 Generic Hardware Error Source version 2. See:
+#
+# https://uefi.org/sites/default/files/resources/ACPI_6_1.pdf
+##
+
+
+##
+# @inject-ghes-error:
+#
+# Inject an error with additional ACPI 6.1 GHESv2 error information
+#
+# @cper: contains a base64 encoded string with raw data for a single
+#     CPER record with Generic Error Status Block, Generic Error Data
+#     Entry and generic error data payload, as described at
+#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 9.2
+##
+{ 'command': 'inject-ghes-error',
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


