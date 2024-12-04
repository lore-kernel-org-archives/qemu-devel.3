Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8ECE77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 15:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIrm1-0007cl-Id; Wed, 04 Dec 2024 10:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1tIrlx-0007bS-AK; Wed, 04 Dec 2024 10:58:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1tIrlv-00074s-N2; Wed, 04 Dec 2024 10:58:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9FD185C6F09;
 Wed,  4 Dec 2024 15:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A83C4CEDF;
 Wed,  4 Dec 2024 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733327909;
 bh=cNJNXcDyaPC/qoa52vKI7D64a4wlMaDEwHHZJBjP9+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RcsDAkpFQZ/0hJEnhv77vtNHqBJns9dPdU0D2xeIc2F+dhPOwMaWREJ+tBLv9Zc/2
 ZFsDo+b1TNzXcOHEqyqYIoo+2uIWIAjsHdaxSVX8hHAXq7fYHdn6xRTM7QzozQkpbO
 5Fk9YemsyQYa9/ydTsgB4GlvMQMJ/uiO5qFHOmS7TqH1vdwjQc8PF6Ju8ftrr4pTbA
 GnKHZx/wjXMSP6yZ5EOulwfmSNidBjopu67fNbZsnlKWtLMBEcoI2M0LUXupo30AEp
 czyiVFBgxlO7c7Oocnu17mdYoLrkNjcVV878j8lZ+ntj7eRloPLE2MEts9qsyhWurH
 SzoLP4qPovWPQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab@kernel.org>) id 1tIrlf-00000000HZ4-3cIR;
 Wed, 04 Dec 2024 16:58:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 5/5] acpi/generic_event_device: add logic to detect if HEST
 addr is available
Date: Wed,  4 Dec 2024 16:57:59 +0100
Message-ID: <d136d20b57c86ba979bd0d5238ad8d300c4f50aa.1733327276.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733327276.git.mchehab+huawei@kernel.org>
References: <cover.1733327276.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=mchehab@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Create a new property (x-has-hest-addr) and use it to detect if
the GHES table offsets can be calculated from the HEST address
(qemu 9.2 and upper) or via the legacy way via an offset obtained
from the hardware_errors firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/generic_event_device.c |  1 +
 hw/acpi/ghes.c                 | 24 +++++++++++++++++-------
 hw/arm/virt-acpi-build.c       | 30 ++++++++++++++++++++++++++----
 hw/core/machine.c              |  2 ++
 include/hw/acpi/ghes.h         |  1 +
 5 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index c1116dd8d7ae..df6b4fab2d30 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 
 static Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
+    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.hest_lookup, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index af55bfe106bf..c9295a3b0db7 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -361,6 +361,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
+    AcpiGedState *acpi_ged_state;
+    AcpiGhesState *ags;
     int i;
 
     build_ghes_error_table(hardware_errors, linker, num_sources);
@@ -381,10 +383,16 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
      * tell firmware to write into GPA the address of HEST via fw_cfg,
      * once initialized.
      */
-    bios_linker_loader_write_pointer(linker,
-                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
-                                     sizeof(uint64_t),
-                                     ACPI_BUILD_TABLE_FILE, hest_offset);
+
+    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                       NULL));
+    ags = &acpi_ged_state->ghes_state;
+    if (ags->hest_lookup) {
+        bios_linker_loader_write_pointer(linker,
+                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
+                                         sizeof(uint64_t),
+                                         ACPI_BUILD_TABLE_FILE, hest_offset);
+    }
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
@@ -398,8 +406,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
         NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
 
-    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    if (ags->hest_lookup) {
+        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
+            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    }
 
     ags->present = true;
 }
@@ -520,7 +530,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    if (!ags->hest_addr_le) {
+    if (!ags->hest_lookup) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
     } else {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bd5582bc75f8..46ce3f3bb07a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -893,6 +893,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
     { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
 };
 
+static const AcpiNotificationSourceId hest_ghes_notify_9_1[] = {
+    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -946,10 +950,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_dbg2(tables_blob, tables->linker, vms);
 
     if (vms->ras) {
-        acpi_add_table(table_offsets, tables_blob);
-        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
-                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
-                        vms->oem_id, vms->oem_table_id);
+        AcpiGhesState *ags;
+        AcpiGedState *acpi_ged_state;
+
+        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                       NULL));
+        if (acpi_ged_state) {
+            ags = &acpi_ged_state->ghes_state;
+
+            acpi_add_table(table_offsets, tables_blob);
+
+            if (!ags->hest_lookup) {
+                acpi_build_hest(tables_blob, tables->hardware_errors,
+                                tables->linker, hest_ghes_notify_9_1,
+                                ARRAY_SIZE(hest_ghes_notify_9_1),
+                                vms->oem_id, vms->oem_table_id);
+            } else {
+                acpi_build_hest(tables_blob, tables->hardware_errors,
+                                tables->linker, hest_ghes_notify,
+                                ARRAY_SIZE(hest_ghes_notify),
+                                vms->oem_id, vms->oem_table_id);
+            }
+        }
     }
 
     if (ms->numa_state->num_nodes > 0) {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f29fe959647f..b81fea273e6b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,10 +34,12 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/acpi/generic_event_device.h"
 #include "audio/audio.h"
 
 GlobalProperty hw_compat_9_1[] = {
     { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
+    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
 };
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 237721fec0a2..164ed8b0f9a3 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
     uint64_t hest_addr_le;
     uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
+    bool hest_lookup; /* True if HEST address is present */
 } AcpiGhesState;
 
 /*
-- 
2.47.1


