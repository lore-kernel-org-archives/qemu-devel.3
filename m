Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1CEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQJf-0005e4-Eb; Mon, 29 Jul 2024 09:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJd-0005UO-9N; Mon, 29 Jul 2024 09:21:29 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJX-00028f-Pl; Mon, 29 Jul 2024 09:21:28 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D5B00619AF;
 Mon, 29 Jul 2024 13:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A047C32786;
 Mon, 29 Jul 2024 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722259281;
 bh=mHblHfJUf2FKKARpuzMAKRJCuiW8ycZ+IYNiLWFfA6s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WiZDF5fb44VHhzNVn1pKMC+RtD0/9JpJz7sAXYVlGK0x97BiSqlmvRh2oaTE4PWW9
 mFnnV8VQSW95zBkbmidSdVGzw7KWrrCMaX43syb4OvCZAmChGFYeg/g4V2qhe0DQfC
 hphWcgEds/nPx8UslEjvb2n6XxMNnIsPave+u5jSq5PCsJD75V//3xaDkw+whX/+om
 oEj2OMNKWn6P6BcvL6qYsiTwGLoLh/J6EVwg+9ZJWDKFnNX2cKnk2EC/pD0M/GTwYF
 9U0aCbyqKYLd9Vqtkat8bFOZNIP1HQBoedne0PAKIUAycvQG010lC1MeAFT1aabLuk
 kGnAtEA/QIRSw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJT-000000030Vn-0pvI; Mon, 29 Jul 2024 15:21:19 +0200
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
Subject: [PATCH v4 6/6] acpi/ghes: Add a logic to inject ARM processor CPER
Date: Mon, 29 Jul 2024 15:21:10 +0200
Message-ID: <7e0c1ae181e9792e876ec0e7d2a9e7f32d7b60ac.1722259246.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722259246.git.mchehab+huawei@kernel.org>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Add an ACPI APEI GHES error injection logic for ARM
processor CPER, allowing to set fields at from
UEFI spec 2.10 tables N.16 and N.17 to any valid
value.

As some GHES functions require handling addresses, add
a helper function to support it.

Before starting erorr inject, the QAPI requires to negociate
QMP with:

{ "execute": "qmp_capabilities" }

Afterwards, errors can be injected with:

	{ "execute": "arm-inject-error" }

The error injection events supports several optional arguments,
having Processor Error Information (PEI) mapped into an array.

So, it is possible to inject multiple errors at the same CPER record,
as defined at UEFI spec, with:

	{ "execute": "arm-inject-error", "arguments": {
	   "error": [ {"type": [ "cache-error" ]},
		      {"type": [ "tlb-error" ]} ] } }

The above generates a single CPER record with two PEI info, one
reporting a cache error, and the other one a TLB error, using
default values for other fields.

As all fields from ARM Processor CPER are mapped, so, the error
could contain physical/virtual addresses, register dumps,
vendor-specific data, etc.

This patch is co-authored:
- ghes logic to inject a simple ARM record by Shiju Jose;
- generic logic to handle block addresses by Jonathan Cameron;
- logic to allow changing all fields by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS                         |   7 +
 configs/targets/aarch64-softmmu.mak |   1 +
 hw/acpi/ghes.c                      | 283 ++++++++++++++++++-
 hw/arm/Kconfig                      |   4 +
 hw/arm/arm_error_inject.c           | 420 ++++++++++++++++++++++++++++
 hw/arm/arm_error_inject_stubs.c     |  34 +++
 hw/arm/meson.build                  |   3 +
 include/hw/acpi/ghes.h              |  40 +++
 qapi/arm-error-inject.json          | 284 +++++++++++++++++++
 qapi/meson.build                    |   1 +
 qapi/qapi-schema.json               |   1 +
 11 files changed, 1067 insertions(+), 11 deletions(-)
 create mode 100644 hw/arm/arm_error_inject.c
 create mode 100644 hw/arm/arm_error_inject_stubs.c
 create mode 100644 qapi/arm-error-inject.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae155..713a104ef901 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
+ACPI/HEST/GHES/ARM processor CPER
+R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+S: Maintained
+F: hw/arm/arm_error_inject.c
+F: hw/arm/arm_error_inject_stubs.c
+F: qapi/arm-error-inject.json
+
 ppc4xx
 L: qemu-ppc@nongnu.org
 S: Orphan
diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 84cb32dc2f4f..b4b3cd97934a 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+CONFIG_ARM_EINJ=y
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 9346f45c59a5..e435c9aa0961 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -27,6 +27,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
+#include "qapi/qapi-types-arm-error-inject.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
 #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
@@ -53,6 +54,12 @@
 /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
 #define ACPI_GHES_MEM_CPER_LENGTH           80
 
+/*
+ * ARM Processor error section CPER sizes - UEFI 2.10: N.2.4.4
+ */
+#define ACPI_GHES_ARM_CPER_LENGTH           40
+#define ACPI_GHES_ARM_CPER_PEI_LENGTH       32
+
 /* Masks for block_status flags */
 #define ACPI_GEBS_UNCORRECTABLE         1
 
@@ -234,6 +241,152 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
     return 0;
 }
 
+/* UEFI 2.9: N.2.4.4 ARM Processor Error Section */
+static void acpi_ghes_build_append_arm_cper(ArmError err, uint32_t cper_length,
+                                            GArray *table)
+{
+    unsigned int i, j;
+
+    /*
+     * ARM Processor Error Record
+     */
+
+    /* Validation Bits */
+    build_append_int_noprefix(table, err.validation, 4);
+
+    /* Error Info Num */
+    build_append_int_noprefix(table, err.err_info_num, 2);
+
+    /* Context Info Num */
+    build_append_int_noprefix(table, err.context_info_num, 2);
+
+    /* Section length */
+    build_append_int_noprefix(table, cper_length, 4);
+
+    /* Error affinity level */
+    build_append_int_noprefix(table, err.affinity_level, 1);
+
+    /* Reserved */
+    build_append_int_noprefix(table, 0, 3);
+
+    /* MPIDR_EL1 */
+    build_append_int_noprefix(table, err.mpidr_el1, 8);
+
+    /* MIDR_EL1 */
+    build_append_int_noprefix(table, err.midr_el1, 8);
+
+    /* Running state */
+    build_append_int_noprefix(table, err.running_state, 4);
+
+    /* PSCI state: only valid when running state is zero  */
+    build_append_int_noprefix(table, err.psci_state, 4);
+
+    for (i = 0; i < err.err_info_num; i++) {
+        /* ARM Propcessor error information */
+        /* Version */
+        build_append_int_noprefix(table, 0, 1);
+
+        /*  Length */
+        build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_PEI_LENGTH, 1);
+
+        /* Validation Bits */
+        build_append_int_noprefix(table, err.pei[i].validation, 2);
+
+        /* Type */
+        build_append_int_noprefix(table, err.pei[i].type, 1);
+
+        /* Multiple error count */
+        build_append_int_noprefix(table, err.pei[i].multiple_error, 2);
+
+        /* Flags  */
+        build_append_int_noprefix(table, err.pei[i].flags, 1);
+
+        /* Error information  */
+        build_append_int_noprefix(table, err.pei[i].error_info, 8);
+
+        /* Virtual fault address  */
+        build_append_int_noprefix(table, err.pei[i].virt_addr, 8);
+
+        /* Physical fault address  */
+        build_append_int_noprefix(table, err.pei[i].phy_addr, 8);
+    }
+
+    for (i = 0; i < err.context_info_num; i++) {
+        /* ARM Propcessor error context information */
+        /* Version */
+        build_append_int_noprefix(table, 0, 2);
+
+        /* Validation type */
+        build_append_int_noprefix(table, err.context[i].type, 2);
+
+        /* Register array size */
+        build_append_int_noprefix(table, err.context[i].size * 8, 4);
+
+        /* Register array (byte 8 of Context info) */
+        for (j = 0; j < err.context[i].size; j++) {
+            build_append_int_noprefix(table, err.context[i].array[j], 8);
+        }
+    }
+
+    for (i = 0; i < err.vendor_num; i++) {
+        build_append_int_noprefix(table, err.vendor[i], 1);
+    }
+}
+
+static int acpi_ghes_record_arm_error(ArmError error,
+                                      uint64_t error_block_address)
+{
+    GArray *block;
+
+    /* ARM processor Error Section Type */
+    const uint8_t uefi_cper_arm_sec[] =
+          UUID_LE(0xE19E3D16, 0xBC11, 0x11E4, 0x9C, 0xAA, 0xC2, 0x05, \
+                  0x1D, 0x5D, 0x46, 0xB0);
+
+    /*
+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
+     * Table 17-13 Generic Error Data Entry
+     */
+    QemuUUID fru_id = {};
+    uint32_t cper_length, data_length;
+
+    block = g_array_new(false, true /* clear */, 1);
+
+    /* This is the length if adding a new generic error data entry */
+    cper_length = ACPI_GHES_ARM_CPER_LENGTH;
+    cper_length += ACPI_GHES_ARM_CPER_PEI_LENGTH * error.err_info_num;
+    cper_length += error.context_length;
+    cper_length += error.vendor_num;
+
+    data_length = ACPI_GHES_DATA_LENGTH + cper_length;
+
+    /*
+     * It should not run out of the preallocated memory if adding a new generic
+     * error data entry
+     */
+    assert((data_length + ACPI_GHES_GESB_SIZE) <=
+            ACPI_GHES_MAX_RAW_DATA_LENGTH);
+
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
+        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
+
+    /* Build this new generic error data entry header */
+    acpi_ghes_generic_error_data(block, uefi_cper_arm_sec,
+                                 ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                 cper_length, fru_id, 0);
+
+    /* Build the ARM processor error section CPER */
+    acpi_ghes_build_append_arm_cper(error, cper_length, block);
+
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(error_block_address, block->data, block->len);
+
+    g_array_free(block, true);
+
+    return 0;
+}
+
 /*
  * Build table for the hardware error fw_cfg blob.
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
@@ -400,23 +553,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+static uint64_t ghes_get_state_start_address(void)
+{
+    AcpiGedState *acpi_ged_state =
+        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
+    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
+
+    return le64_to_cpu(ags->ghes_addr_le);
+}
+
 int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 {
     uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
+    uint64_t start_addr = ghes_get_state_start_address();
     bool ret = -1;
-    AcpiGedState *acpi_ged_state;
-    AcpiGhesState *ags;
-
     assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    g_assert(acpi_ged_state);
-    ags = &acpi_ged_state->ghes_state;
-
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
-
     if (physical_address) {
 
         if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
@@ -456,6 +608,115 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     return ret;
 }
 
+/*
+ * Error register block data layout
+ *
+ * | +---------------------+ ges.ghes_addr_le
+ * | |error_block_address0 |
+ * | +---------------------+
+ * | |error_block_address1 |
+ * | +---------------------+ --+--
+ * | |    .............    | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |error_block_addressN |
+ * | +---------------------+
+ * | | read_ack0           |
+ * | +---------------------+ --+--
+ * | | read_ack1           | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |   .............     |
+ * | +---------------------+
+ * | | read_ackN           |
+ * | +---------------------+ --+--
+ * | |      CPER           |   |
+ * | |      ....           | GHES_MAX_RAW_DATA_LENGT
+ * | |      CPER           |   |
+ * | +---------------------+ --+--
+ * | |    ..........       |
+ * | +---------------------+
+ * | |      CPER           |
+ * | |      ....           |
+ * | |      CPER           |
+ * | +---------------------+
+ */
+
+/* Map from uint32_t notify to entry offset in GHES */
+static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
+                                                 0xff, 0xff, 0xff, 1, 0};
+
+static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
+                          uint64_t *read_ack_addr)
+{
+    uint64_t base;
+
+    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
+        return false;
+    }
+
+    /* Find and check the source id for this new CPER */
+    if (error_source_to_index[notify] == 0xff) {
+        return false;
+    }
+
+    base = ghes_get_state_start_address();
+
+    *read_ack_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * sizeof(uint64_t);
+
+    /* Could also be read back from the error_block_address register */
+    *error_block_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+
+    return true;
+}
+
+/* Notify BIOS about an error via Generic Error Device - GED */
+static void generic_error_device_notify(void)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    if (mc->generic_error_device_notify) {
+        mc->generic_error_device_notify();
+    }
+}
+
+bool ghes_record_arm_errors(ArmError error, uint32_t notify)
+{
+    int rc, read_ack = 0;
+    uint64_t read_ack_addr = 0;
+    uint64_t error_block_addr = 0;
+
+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_addr)) {
+        return false;
+    }
+
+    cpu_physical_memory_read(read_ack_addr,
+                             &read_ack, sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack) {
+        error_report("Last time OSPM does not acknowledge the error,"
+                     " record CPER failed this time, set the ack value to"
+                     " avoid blocking next time CPER record! exit");
+        read_ack = 1;
+        cpu_physical_memory_write(read_ack_addr,
+                                  &read_ack, sizeof(uint64_t));
+        return false;
+    }
+
+    read_ack = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_addr,
+                              &read_ack, sizeof(uint64_t));
+    rc = acpi_ghes_record_arm_error(error, error_block_addr);
+
+    generic_error_device_notify();
+
+    return rc;
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa2d..bafac82f9fd3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -712,3 +712,7 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config ARM_EINJ
+    bool
+    default y if AARCH64
diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
new file mode 100644
index 000000000000..5ebbdf2b2adc
--- /dev/null
+++ b/hw/arm/arm_error_inject.c
@@ -0,0 +1,420 @@
+/*
+ * ARM Processor error injection
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
+#include "hw/boards.h"
+#include "hw/acpi/ghes.h"
+#include "cpu.h"
+
+#define ACPI_GHES_ARM_CPER_CTX_DEFAULT_NREGS 74
+
+/* Handle ARM Processor Error Information (PEI) */
+static const ArmProcessorErrorInformationList *default_pei = { 0 };
+
+static ArmPEI *qmp_arm_pei(uint16_t *err_info_num,
+              bool has_error,
+              ArmProcessorErrorInformationList const *error_list)
+{
+    ArmProcessorErrorInformationList const *next;
+    ArmPeiValidationBitsList const *validation_list;
+    ArmPEI *pei = NULL;
+    uint16_t i;
+
+    if (!has_error) {
+        error_list = default_pei;
+    }
+
+    *err_info_num = 0;
+
+    for (next = error_list; next; next = next->next) {
+        (*err_info_num)++;
+
+        if (*err_info_num >= 255) {
+            break;
+        }
+    }
+
+    pei = g_new0(ArmPEI, (*err_info_num));
+
+    for (next = error_list, i = 0;
+                i < *err_info_num; i++, next = next->next) {
+        ArmProcessorErrorTypeList *type_list = next->value->type;
+        uint16_t pei_validation = 0;
+        uint8_t flags = 0;
+        uint8_t type = 0;
+
+        if (next->value->has_validation) {
+            validation_list = next->value->validation;
+
+            while (validation_list) {
+                pei_validation |= BIT(next->value->validation->value);
+                validation_list = validation_list->next;
+            }
+        }
+
+        /*
+         * According with UEFI 2.9A errata, the meaning of this field is
+         * given by the following bitmap:
+         *
+         *   +-----|---------------------------+
+         *   | Bit | Meaning                   |
+         *   +=====+===========================+
+         *   |  1  | Cache Error               |
+         *   |  2  | TLB Error                 |
+         *   |  3  | Bus Error                 |
+         *   |  4  | Micro-architectural Error |
+         *   +-----|---------------------------+
+         *
+         *   All other values are reserved.
+         *
+         * As bit 0 is reserved, QAPI ArmProcessorErrorType starts from bit 1.
+         */
+        while (type_list) {
+            type |= BIT(type_list->value + 1);
+            type_list = type_list->next;
+        }
+        if (!has_error) {
+            type = BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR);
+        }
+        pei[i].type = type;
+
+        if (next->value->has_flags) {
+            ArmProcessorFlagsList *flags_list = next->value->flags;
+
+            while (flags_list) {
+                flags |= BIT(flags_list->value);
+                flags_list = flags_list->next;
+            }
+        } else {
+            flags = BIT(ARM_PROCESSOR_FLAGS_FIRST_ERROR_CAP) |
+                    BIT(ARM_PROCESSOR_FLAGS_PROPAGATED);
+        }
+        pei[i].flags = flags;
+
+        if (next->value->has_multiple_error) {
+            pei[i].multiple_error = next->value->multiple_error;
+            pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_MULTIPLE_ERROR_VALID);
+        }
+
+        if (next->value->has_error_info) {
+            pei[i].error_info = next->value->error_info;
+        } else {
+            switch (type) {
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR):
+                pei[i].error_info = 0x0091000F;
+                break;
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR):
+                pei[i].error_info = 0x0054007F;
+                break;
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR):
+                pei[i].error_info = 0x80D6460FFF;
+                break;
+            case BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR):
+                pei[i].error_info = 0x78DA03FF;
+                break;
+            default:
+                /*
+                 * UEFI 2.9A/2.10 doesn't define how this should be filled
+                 * when multiple types are there. So, set default to zero,
+                 * causing it to be removed from validation bits.
+                 */
+                pei[i].error_info = 0;
+            }
+        }
+
+        if (next->value->has_virt_addr) {
+            pei[i].virt_addr = next->value->virt_addr;
+            pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_VIRT_ADDR_VALID);
+        }
+
+        if (next->value->has_phy_addr) {
+            pei[i].phy_addr = next->value->phy_addr;
+            pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_PHY_ADDR_VALID);
+        }
+
+        if (!next->value->has_validation) {
+            if (pei[i].flags) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_FLAGS_VALID);
+            }
+            if (pei[i].error_info) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_ERROR_INFO_VALID);
+            }
+            if (next->value->has_virt_addr) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_VIRT_ADDR_VALID);
+            }
+
+            if (next->value->has_phy_addr) {
+                pei_validation |= BIT(ARM_PEI_VALIDATION_BITS_PHY_ADDR_VALID);
+            }
+        }
+
+        pei[i].validation = pei_validation;
+    }
+
+    return pei;
+}
+
+/*
+ * UEFI 2.10 default context register type (See UEFI 2.10 table N.21 for more)
+ */
+#define CONTEXT_AARCH32_EL1   1
+#define CONTEXT_AARCH64_EL1   5
+
+static int get_default_context_type(void)
+{
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
+    bool aarch64;
+
+    aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
+
+    if (aarch64) {
+        return CONTEXT_AARCH64_EL1;
+    }
+    return CONTEXT_AARCH32_EL1;
+}
+
+/* Handle ARM Context */
+static ArmContext *qmp_arm_context(uint16_t *context_info_num,
+                                   uint32_t *context_length,
+                                   bool has_context,
+                                   ArmProcessorContextList const *context_list)
+{
+    ArmProcessorContextList const *next;
+    ArmContext *context = NULL;
+    uint16_t i, j, num, default_type;
+
+    default_type = get_default_context_type();
+
+    if (!has_context) {
+        *context_info_num = 0;
+        *context_length = 0;
+
+        return NULL;
+    }
+
+    /* Calculate sizes */
+    num = 0;
+    for (next = context_list; next; next = next->next) {
+        uint32_t n_regs = 0;
+
+        if (next->value->has_q_register) {
+            uint64List *reg = next->value->q_register;
+
+            while (reg) {
+                n_regs++;
+                reg = reg->next;
+            }
+
+            if (next->value->has_minimal_size &&
+                next->value->minimal_size < n_regs) {
+                n_regs = next->value->minimal_size;
+            }
+        } else if (!next->value->has_minimal_size) {
+            n_regs = ACPI_GHES_ARM_CPER_CTX_DEFAULT_NREGS;
+        }
+
+        if (!n_regs) {
+            next->value->minimal_size = 0;
+        } else {
+            next->value->minimal_size = (n_regs + 1) % 0xfffe;
+        }
+
+        num++;
+        if (num >= 65535) {
+            break;
+        }
+    }
+
+    context = g_new0(ArmContext, num);
+
+    /* Fill context data */
+
+    *context_length = 0;
+    *context_info_num = 0;
+
+    next = context_list;
+    for (i = 0; i < num; i++, next = next->next) {
+        if (!next->value->minimal_size) {
+            continue;
+        }
+
+        if (next->value->has_type) {
+            context[*context_info_num].type = next->value->type;
+        } else {
+            context[*context_info_num].type = default_type;
+        }
+        context[*context_info_num].size = next->value->minimal_size;
+        context[*context_info_num].array = g_malloc0(context[*context_info_num].size * 8);
+
+        (*context_info_num)++;
+
+        /* length = 64 bits * (size of the reg array + context type) */
+        *context_length += (context->size + 1) * 8;
+
+        if (!next->value->has_q_register) {
+            *context->array = 0xDEADBEEF;
+        } else {
+            uint64_t *pos = context->array;
+            uint64List *reg = next->value->q_register;
+
+            for (j = 0; j < context->size; j++) {
+                if (!reg) {
+                    break;
+                }
+
+                *(pos++) = reg->value;
+                reg = reg->next;
+            }
+        }
+    }
+
+    if (!*context_info_num) {
+        g_free(context);
+        return NULL;
+    }
+
+    return context;
+}
+
+static uint8_t *qmp_arm_vendor(uint32_t *vendor_num, bool has_vendor_specific,
+                               uint8List const *vendor_specific_list)
+{
+    uint8List const *next = vendor_specific_list;
+    uint8_t *vendor, *p;
+
+    if (!has_vendor_specific) {
+        return NULL;
+    }
+
+    *vendor_num = 0;
+
+    while (next) {
+        next = next->next;
+        (*vendor_num)++;
+    }
+
+    vendor = g_malloc(*vendor_num);
+
+    p = vendor;
+    next = vendor_specific_list;
+    while (next) {
+        *p = next->value;
+        next = next->next;
+        p++;
+    }
+
+    return vendor;
+}
+
+/* For ARM processor errors */
+void qmp_arm_inject_error(bool has_validation,
+                    ArmProcessorValidationBitsList *validation_list,
+                    bool has_affinity_level,
+                    uint8_t affinity_level,
+                    bool has_mpidr_el1,
+                    uint64_t mpidr_el1,
+                    bool has_midr_el1,
+                    uint64_t midr_el1,
+                    bool has_running_state,
+                    ArmProcessorRunningStateList *running_state_list,
+                    bool has_psci_state,
+                    uint32_t psci_state,
+                    bool has_context,
+                    ArmProcessorContextList *context_list,
+                    bool has_vendor_specific,
+                    uint8List *vendor_specific_list,
+                    bool has_error,
+                    ArmProcessorErrorInformationList *error_list,
+                    Error **errp)
+{
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
+    uint32_t running_state = 0;
+    uint16_t validation = 0;
+    ArmError error;
+    uint16_t i;
+
+    /* Handle UEFI 2.0 N.16 specific fields, setting defaults when needed */
+
+    if (!has_midr_el1) {
+        mpidr_el1 = armcpu->midr;
+    }
+
+    if (!has_mpidr_el1) {
+        mpidr_el1 = armcpu->mpidr;
+    }
+
+    if (!has_psci_state) {
+        psci_state = armcpu->power_state;
+    }
+
+    if (has_running_state) {
+        while (running_state_list) {
+            running_state |= BIT(running_state_list->value);
+            running_state_list = running_state_list->next;
+        }
+
+        if (running_state) {
+            psci_state = 0;
+        }
+    }
+
+    if (has_validation) {
+        while (validation_list) {
+            validation |= BIT(validation_list->value);
+            validation_list = validation_list->next;
+        }
+    } else {
+        if (has_vendor_specific) {
+            validation |= BIT(ARM_PROCESSOR_VALIDATION_BITS_VENDOR_SPECIFIC_VALID);
+        }
+
+        if (has_affinity_level) {
+            validation |= BIT(ARM_PROCESSOR_VALIDATION_BITS_AFFINITY_VALID);
+        }
+
+        if (mpidr_el1) {
+            validation = BIT(ARM_PROCESSOR_VALIDATION_BITS_MPIDR_VALID);
+        }
+
+        if (running_state) {
+            validation |= BIT(ARM_PROCESSOR_VALIDATION_BITS_RUNNING_STATE_VALID);
+        }
+    }
+
+    /* Fill an error record */
+
+    error.validation = validation;
+    error.affinity_level = affinity_level;
+    error.mpidr_el1 = mpidr_el1;
+    error.midr_el1 = midr_el1;
+    error.running_state = running_state;
+    error.psci_state = psci_state;
+
+    error.pei = qmp_arm_pei(&error.err_info_num, has_error, error_list);
+    error.context = qmp_arm_context(&error.context_info_num,
+                                    &error.context_length,
+                                    has_context, context_list);
+    error.vendor = qmp_arm_vendor(&error.vendor_num, has_vendor_specific,
+                                  vendor_specific_list);
+
+    ghes_record_arm_errors(error, ACPI_GHES_NOTIFY_GPIO);
+
+    if (error.context) {
+        for (i = 0; i < error.context_info_num; i++) {
+            g_free(error.context[i].array);
+        }
+    }
+    g_free(error.context);
+    g_free(error.pei);
+    g_free(error.vendor);
+
+    return;
+}
diff --git a/hw/arm/arm_error_inject_stubs.c b/hw/arm/arm_error_inject_stubs.c
new file mode 100644
index 000000000000..be6e8be2d0d9
--- /dev/null
+++ b/hw/arm/arm_error_inject_stubs.c
@@ -0,0 +1,34 @@
+/*
+ * QMP stub for ARM processor error injection.
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
+#include "hw/acpi/ghes.h"
+
+void qmp_arm_inject_error(bool has_validation,
+                        ArmProcessorValidationBitsList *validation,
+                        bool has_affinity_level,
+                        uint8_t affinity_level,
+                        bool has_mpidr_el1,
+                        uint64_t mpidr_el1,
+                        bool has_midr_el1,
+                        uint64_t midr_el1,
+                        bool has_running_state,
+                        ArmProcessorRunningStateList *running_state,
+                        bool has_psci_state,
+                        uint32_t psci_state,
+                        bool has_context, ArmProcessorContextList *context,
+                        bool has_vendor_specific, uint8List *vendor_specific,
+                        bool has_error,
+                        ArmProcessorErrorInformationList *error,
+                        Error **errp)
+{
+    error_setg(errp, "ARM processor error support is not compiled in");
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 0c07ab522f4c..cb7fe09fc87b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
+arm_ss.add(when: 'CONFIG_ARM_EINJ', if_true: files('arm_error_inject.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
@@ -77,5 +78,7 @@ system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 system_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
+system_ss.add(when: 'CONFIG_ARM_EINJ', if_false: files('arm_error_inject_stubs.c'))
+system_ss.add(when: 'CONFIG_ALL', if_true: files('arm_error_inject_stubs.c'))
 
 hw_arch += {'arm': arm_ss}
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 4f1ab1a73a06..c591a5fb02c4 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -23,6 +23,7 @@
 #define ACPI_GHES_H
 
 #include "hw/acpi/bios-linker-loader.h"
+#include "qapi/qapi-commands-arm-error-inject.h"
 
 /*
  * Values for Hardware Error Notification Type field
@@ -68,6 +69,43 @@ typedef struct AcpiGhesState {
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
+typedef struct ArmPEI {
+    uint16_t validation;
+    uint8_t type;
+    uint16_t multiple_error;
+    uint8_t flags;
+    uint64_t error_info;
+    uint64_t virt_addr;
+    uint64_t phy_addr;
+} ArmPEI;
+
+typedef struct ArmContext {
+    uint16_t type;
+    uint32_t size;
+    uint64_t *array;
+} ArmContext;
+
+/* ARM processor - UEFI 2.10 table N.16 */
+typedef struct ArmError {
+    uint16_t validation;
+
+    uint8_t affinity_level;
+    uint64_t mpidr_el1;
+    uint64_t midr_el1;
+    uint32_t running_state;
+    uint32_t psci_state;
+
+    /* Those are calculated based on the input data */
+    uint16_t err_info_num;
+    uint16_t context_info_num;
+    uint32_t vendor_num;
+    uint32_t context_length;
+
+    ArmPEI *pei;
+    ArmContext *context;
+    uint8_t *vendor;
+} ArmError;
+
 void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
 void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id);
@@ -75,6 +113,8 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 
+bool ghes_record_arm_errors(ArmError error, uint32_t notify);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
new file mode 100644
index 000000000000..6e3445c7fe0e
--- /dev/null
+++ b/qapi/arm-error-inject.json
@@ -0,0 +1,284 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = ARM Processor Errors
+#
+# These are defined at
+# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html.
+# See tables N.16, N.17 and N.21.
+##
+
+##
+# @ArmProcessorValidationBits:
+#
+# Indicates whether or not fields of ARM processor CPER record are
+# valid.
+#
+# @mpidr-valid:  MPIDR is valid
+#
+# @affinity-valid: Error affinity level is valid
+#
+# @running-state-valid: Running State is valid
+#
+# @vendor-specific-valid: Vendor Specific Info is valid
+#
+# Since: 9.2
+##
+{ 'enum': 'ArmProcessorValidationBits',
+  'data': ['mpidr-valid',
+           'affinity-valid',
+           'running-state-valid',
+           'vendor-specific-valid']
+}
+
+##
+# @ArmProcessorFlags:
+#
+# Indicates error attributes at the Error info section.
+#
+# @first-error-cap: First error captured
+#
+# @last-error-cap:  Last error captured
+#
+# @propagated: Propagated
+#
+# @overflow: Overflow
+#
+# Since: 9.2
+##
+{ 'enum': 'ArmProcessorFlags',
+  'data': ['first-error-cap',
+           'last-error-cap',
+           'propagated',
+           'overflow']
+}
+
+##
+# @ArmProcessorRunningState:
+#
+# Indicates if the processor is running.
+#
+# @processor-running: indicates that the processor is running
+#
+# Since: 9.2
+##
+{ 'enum': 'ArmProcessorRunningState',
+  'data': ['processor-running']
+}
+
+##
+# @ArmProcessorErrorType:
+#
+# Type of ARM processor error information to inject.
+#
+# @cache-error: Cache error
+#
+# @tlb-error: TLB error
+#
+# @bus-error: Bus error
+#
+# @micro-arch-error: Micro architectural error
+#
+# Since: 9.2
+##
+{ 'enum': 'ArmProcessorErrorType',
+  'data': ['cache-error',
+           'tlb-error',
+           'bus-error',
+           'micro-arch-error']
+ }
+
+##
+# @ArmPeiValidationBits:
+#
+# Indicates whether or not fields of Processor Error Info section
+# are valid.
+#
+# @multiple-error-valid: Information at multiple-error field is valid
+#
+# @flags-valid: Information at flags field is valid
+#
+# @error-info-valid: Information at error-info field is valid
+#
+# @virt-addr-valid: Information at virt-addr field is valid
+#
+# @phy-addr-valid: Information at phy-addr field is valid
+#
+# Since: 9.2
+##
+{ 'enum': 'ArmPeiValidationBits',
+  'data': ['multiple-error-valid',
+           'flags-valid',
+           'error-info-valid',
+           'virt-addr-valid',
+           'phy-addr-valid']
+}
+
+##
+# @ArmProcessorErrorInformation:
+#
+# Contains ARM processor error information (PEI) data according
+# with UEFI CPER table N.17.
+#
+# @validation: Valid validation bits for error-info section.
+#   Argument is optional. If not specified, those flags will
+#   be enabled: first-error-cap and propagated.
+#
+# @type: ARM processor error types to inject. Argument is mandatory.
+#
+# @multiple-error: Indicates whether multiple errors have occurred.
+#   Argument is optional. If not specified and @validation not
+#   forced, this field will be marked as invalid at CPER record.
+#   When valid, the meaning of this field is:
+#
+#       ============== ===================================
+#       multiple-error meaning
+#       ============== ===================================
+#       0              single error
+#       1              multiple errors (with a lost count)
+#       2 or more      actual count of multiple errors
+#       ============== ===================================
+#
+# @flags: Indicates flags that describe the error attributes.
+#   Argument is optional. If not specified and defaults to
+#   first-error and propagated.
+#
+# @error-info: Error information structure is specific to each error
+#   type. Argument is optional, and its value depends on the PEI
+#   type(s). If not defined, the default depends on the type:
+#
+#       ================  ==================
+#       For type          error-info default
+#       ================  ==================
+#       cache-error       ``0x0091000F``
+#       tlb-error         ``0x0054007F``
+#       bus-error         ``0x80D6460FFF``
+#       micro-arch-error  ``0x78DA03FF``
+#       ================  ==================
+#
+#    - if multiple types used, this bit is disabled from
+#      @validation bits, as UEFI doesn't define the expected behavior.
+#
+# @virt-addr: Virtual fault address associated with the error.
+#   Argument is optional. If not specified and @validation not
+#   forced, this field will be marked as invalid at CPER record.
+#
+# @phy-addr: Physical fault address associated with the error.
+#   Argument is optional. If not specified and @validation not
+#   forced, this field will be marked as invalid at CPER record.
+#
+# Since: 9.2
+##
+{ 'struct': 'ArmProcessorErrorInformation',
+  'data': { '*validation': ['ArmPeiValidationBits'],
+            'type': ['ArmProcessorErrorType'],
+            '*multiple-error': 'uint16',
+            '*flags': ['ArmProcessorFlags'],
+            '*error-info': 'uint64',
+            '*virt-addr':  'uint64',
+            '*phy-addr': 'uint64'}
+}
+
+##
+# @ArmProcessorContext:
+#
+# Provide processor context state specific to the ARM processor
+# architecture, according with UEFI 2.10 CPER table N.21.
+#
+# @type: Contains an integer value indicating the type of context
+#   state being reported. Argument is optional. If not defined, it
+#   will be set to be EL1 register for the emulation, e. g.:
+#
+#       ========  =============================
+#       on arm32  AArch32 EL1 context registers
+#       on arm64  AArch64 EL1 context registers
+#       ========  =============================
+#
+# @register: Provides the contents of the actual registers or raw
+#   data, depending on the context type. Argument is optional. If
+#   not defined, it will fill the first register with 0xDEADBEEF,
+#   and the other ones with zero.
+#
+# @minimal-size: Argument is optional. If provided, define the minimal
+#   size of the context register array. The actual size is defined by
+#   checking the number of register values plus the content of this
+#   field (if used), ensuring that each processor context information
+#   structure array is padded with zeros if the size is not a multiple
+#   of 16 bytes.
+#
+# Since: 9.2
+##
+{ 'struct': 'ArmProcessorContext',
+  'data': { '*type': 'uint16',
+            '*minimal-size': 'uint32',
+            '*register': ['uint64']}
+}
+
+##
+# @arm-inject-error:
+#
+# Inject ARM Processor error with data to be filled accordign with
+# UEFI 2.10 CPER table N.16.
+#
+# @validation: Valid validation bits for ARM processor CPER.
+#   Argument is optional. If not specified, the default is calculated
+#   based on having the corresponding arguments filled.
+#
+# @affinity-level: Error affinity level for errors that can be
+#   attributed to a specific affinity level. Argument is optional.
+#   If not specified and @validation not forced, this field will be
+#   marked as invalid at CPER record.
+#
+# @mpidr-el1: Processor’s unique ID in the system. Argument is
+#   optional. If not specified, it will use the cpu mpidr field from
+#   the emulation data. If zero and @validation is not forced, this
+#   field will be marked as invalid at CPER record.
+#
+# @midr-el1: Identification info of the chip. Argument is optional.
+#   If not specified, it will use the cpu mpidr field from the
+#   emulation data. If zero and @validation is not forced, this
+#   field will be marked as invalid at CPER record.
+#
+# @running-state: Indicates the running state of the processor.
+#   Argument is optional. If not specified and @validation not
+#   forced, this field will be marked as invalid at CPER record.
+#
+# @psci-state: Provides PSCI state of the processor, as defined in
+#   ARM PSCI document. Argument is optional. If not specified, it
+#   will use the cpu power state field from the emulation data.
+#
+# @context: Contains an array of processor context registers.
+#   Argument is optional. If not specified, no context will be added.
+#
+# @vendor-specific: Contains a byte array of vendor-specific data.
+#   Argument is optional. If not specified, no vendor-specific data
+#   will be added.
+#
+# @error: Contains an array of ARM processor error information (PEI)
+#   sections. Argument is optional. If not specified, defaults to a
+#   single Program Error Information record with a cache error, e. g.
+#   it would be equivalent of filling the PEI argument with::
+#
+#       "error" = { "type"= {[ "cache-error" ]} }
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 9.2
+##
+{ 'command': 'arm-inject-error',
+  'data': {
+    '*validation': ['ArmProcessorValidationBits'],
+    '*affinity-level': 'uint8',
+    '*mpidr-el1': 'uint64',
+    '*midr-el1': 'uint64',
+    '*running-state':  ['ArmProcessorRunningState'],
+    '*psci-state': 'uint32',
+    '*context': ['ArmProcessorContext'],
+    '*vendor-specific': ['uint8'],
+    '*error': ['ArmProcessorErrorInformation']
+  },
+  'features': [ 'unstable' ]
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index e7bc54e5d047..5927932c4be3 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
 endif
 
 qapi_all_modules = [
+  'arm-error-inject',
   'authz',
   'block',
   'block-core',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b1581988e4eb..479a22de7e43 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -81,3 +81,4 @@
 { 'include': 'vfio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'arm-error-inject.json' }
-- 
2.45.2


