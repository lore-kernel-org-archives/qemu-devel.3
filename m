Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC333CCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFC-00015N-CT; Sun, 05 Oct 2025 15:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEN-0007mN-8G
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEG-0006TD-KK
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoo23lLJOe1UY22DY2evFce08dzQGIGFIEQ1PeuRF6g=;
 b=MFmhRyD/Kp07bDgmVK6WgACzk1AxeMwuqxcXrSiWIID5TnoO/TEpgHJ8A6oZEWDGHFi+0O
 4QJw4wj3gZLS5KsBA1byJQ71QDZi5LgYpsFqWrAAqsPus/2o3x/beVM7ABPsb29ZR33UUt
 eYwLTMY13miOLF5TDUtUlB5KidTTxvc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-cGU3Jm13PCC9zgThy7QmcQ-1; Sun, 05 Oct 2025 15:17:06 -0400
X-MC-Unique: cGU3Jm13PCC9zgThy7QmcQ-1
X-Mimecast-MFC-AGG-ID: cGU3Jm13PCC9zgThy7QmcQ_1759691825
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso2577009f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691825; x=1760296625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoo23lLJOe1UY22DY2evFce08dzQGIGFIEQ1PeuRF6g=;
 b=QP1w4cx1eJMxX90V+yeefFBlnB09kwQUoECUD4zh6bNB0bG0wunF7Wtd2vgIyrqBD7
 /OpJFPuojDsmytEj4M0e4nrmpVqyxB5bC0iQj+Yhw2YCOeuFfGXQbf5NLMgyf7jlACTp
 Z72+rpIHysByJeE8PQ4TmaViTqWn96U0IF92vp0MUVvhIMu5iWYcIqsvih1Wrn2OEZzU
 6ACuOa6ktskkMZRdp4GeVoCKiJkRj1vm3MhOgvuvZROburMv9tKuESc4z0sGedAkYOzX
 WHdtZa+EGhjvITjjXDre0XDB2LIR8clkQCxHD8UmcMpncLURaS3GPbKgrDQMUJ8+Hghw
 VnSA==
X-Gm-Message-State: AOJu0Ywsl6DNetfcLV5JWxJ3S8TIMtiKUwoEX3c3MH85R7bjuvQcjR/a
 0VqEYZ0bkvTtbnvT5QX1XinL/HD3KkCR/W+cXPFE+KKSkU5wFtTfuVxxyTQYi7h06V6yy7b6EV2
 NEX3ce+kEg0416+9DLL4UW4aePDaWwMyTLAJiLp5lQgKQVYU7MpIMy78vsQxKXamTjsqqnC418p
 sy8HIEbxUXzq8Dj4VrQrBPhLF7HlfEJNq1BQ==
X-Gm-Gg: ASbGnctqDs+ToCu2UM4rdwMGsHdV0y770t5DTDW8GQZUMyTPrbC9DzUT0F+0cbQ/iKi
 mdolYL8C9lD6xQU2xMdx8cshTKFLpHZjnVqjWA/6kE6De/Xi4/FU2gfb9LKyWg8rj1CeFfLtqgT
 /yxrIzPBgkBNAiKepBV7mYBqaMDOHsNH6cmXx7GlNz+SXd8nWVFEOtgfGNWU/Haq0Q4nLEaNTTh
 kp5sOKyUqeh2Wq/VZPfA22g46ykEWSJ5sdr8xpyHwHalE65NHYg93h3meB3NQrFnNLx57gz8tUO
 RkhfpgEgn5WzNHxp74+drx+6WIfQ8f+BdNtrHF0=
X-Received: by 2002:a05:6000:2083:b0:3ea:fb3d:c4cb with SMTP id
 ffacd0b85a97d-425671c5e49mr7574436f8f.56.1759691825000; 
 Sun, 05 Oct 2025 12:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc/un9kSCmaLjU7k6r7VuKi/l5IaSlZol5DIlwtNnVTC1dFbukWODQkQbUykX9nxfuQAfH3A==
X-Received: by 2002:a05:6000:2083:b0:3ea:fb3d:c4cb with SMTP id
 ffacd0b85a97d-425671c5e49mr7574404f8f.56.1759691824369; 
 Sun, 05 Oct 2025 12:17:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f027csm17692870f8f.40.2025.10.05.12.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:03 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-arm@nongnu.org
Subject: [PULL 27/75] qapi/acpi-hest: add an interface to do generic CPER
 error injection
Message-ID: <ddd8f3baa27dc05251f52e94d1b643bfb93cbc83.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Create a QMP command to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2, and add support for it for ARM guests.

Error injection uses ACPI_HEST_SRC_ID_QMP source ID to be platform
independent. This is mapped at arch virt bindings, depending on the
types supported by QEMU and by the BIOS. So, on ARM, this is supported
via ACPI_GHES_NOTIFY_GPIO notification type.

This patch was co-authored:
    - original ghes logic to inject a simple ARM record by Shiju Jose;
    - generic logic to handle block addresses by Jonathan Cameron;
    - generic GHESv2 error inject by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <81e2118b3c8b7e5da341817f277d61251655e0db.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/acpi-hest.json      | 36 ++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json    |  1 +
 include/hw/acpi/ghes.h   |  1 +
 include/hw/arm/virt.h    |  1 +
 hw/acpi/ghes.c           |  2 +-
 hw/acpi/ghes_cper.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper_stub.c | 20 ++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            |  7 +++++++
 MAINTAINERS              |  7 +++++++
 hw/acpi/Kconfig          |  5 +++++
 hw/acpi/meson.build      |  2 ++
 qapi/meson.build         |  1 +
 13 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 qapi/acpi-hest.json
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c

diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
new file mode 100644
index 0000000000..28af1266a7
--- /dev/null
+++ b/qapi/acpi-hest.json
@@ -0,0 +1,36 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+# @inject-ghes-v2-error:
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
+# Since: 10.2
+##
+{ 'command': 'inject-ghes-v2-error',
+  'data': {
+    'cper': 'str'
+  },
+  'features': [ 'unstable' ]
+}
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 82f111ba06..b93dd68d94 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -68,6 +68,7 @@
 { 'include': 'misc-i386.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
+{ 'include': 'acpi-hest.json' }
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 390943e46d..df2ecbf6e4 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -65,6 +65,7 @@ enum AcpiGhesNotifyType {
  */
 enum AcpiGhesSourceID {
     ACPI_HEST_SRC_ID_SYNC,
+    ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
 };
 
 typedef struct AcpiNotificationSourceId {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e14ea0f9d4..04a09af354 100644
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
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index d666f1b10b..06555905ce 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -553,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
 
-    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+    notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
 }
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
new file mode 100644
index 0000000000..31cb2ffabe
--- /dev/null
+++ b/hw/acpi/ghes_cper.c
@@ -0,0 +1,40 @@
+/*
+ * CPER payload parser for error injection
+ *
+ * Copyright(C) 2024-2025 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+void qmp_inject_ghes_v2_error(const char *qmp_cper, Error **errp)
+{
+    AcpiGhesState *ags;
+    uint8_t *cper;
+    size_t  len;
+
+    ags = acpi_ghes_get_state();
+    if (!ags) {
+        return;
+    }
+
+    cper = qbase64_decode(qmp_cper, -1, &len, errp);
+    if (!cper) {
+        error_setg(errp, "missing GHES CPER payload");
+        return;
+    }
+
+    ghes_record_cper_errors(ags, cper, len, ACPI_HEST_SRC_ID_QMP, errp);
+
+    g_free(cper);
+}
diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
new file mode 100644
index 0000000000..b16be73502
--- /dev/null
+++ b/hw/acpi/ghes_cper_stub.c
@@ -0,0 +1,20 @@
+/*
+ * Stub interface for CPER payload parser for error injection
+ *
+ * Copyright(C) 2024-2025 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-acpi-hest.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_inject_ghes_v2_error(const char *cper, Error **errp)
+{
+    error_setg(errp, "GHES QMP error inject is not compiled in");
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2b63008df0..8bb6b60515 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1128,6 +1128,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
 
 static const AcpiNotificationSourceId hest_ghes_notify[] = {
     { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+    { ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO },
 };
 
 static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6960f6113f..aad557be1a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1052,6 +1052,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
 
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 406cef88f0..b31ae5193d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2173,6 +2173,13 @@ F: hw/acpi/ghes.c
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
index 1d4e9f0845..daabbe6cd1 100644
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
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 73f02b9691..56b5d1ec96 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -34,4 +34,6 @@ endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
+system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
+system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c'))
diff --git a/qapi/meson.build b/qapi/meson.build
index ca6b61a608..a46269b5a0 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -59,6 +59,7 @@ if have_system
   qapi_all_modules += [
     'accelerator',
     'acpi',
+    'acpi-hest',
     'audio',
     'cryptodev',
     'qdev',
-- 
MST


