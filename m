Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BD4C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzty-0001HO-LZ; Mon, 05 Feb 2024 09:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWztw-0001H4-Aa
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:24:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWzts-0002Yw-3H
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:24:47 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7px6mcZz6J68p;
 Mon,  5 Feb 2024 22:21:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 407BA1404FC;
 Mon,  5 Feb 2024 22:24:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:24:41 +0000
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
 <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 10/11] cxl/type3: FW first protocol error injection.
Date: Mon, 5 Feb 2024 14:19:39 +0000
Message-ID: <20240205141940.31111-11-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Note this is only hooked up to type 3 device so far.
Injection via the same interface as for native errors.

e.g.
{ "execute": "cxl-inject-uncorrectable-errors",
  "arguments": {
    "path": "/machine/peripheral/cxl-pmem2",
    "errors": [
        {
            "type": "cache-address-parity",
            "header": [ 3, 4]
        }
        ]
  }}

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/ghes.h        |   4 +
 include/hw/cxl/cxl.h          |   2 +
 hw/acpi/ghes-stub.c           |   5 +
 hw/acpi/ghes.c                | 212 ++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c            |  28 ++++-
 hw/pci-bridge/cxl_root_port.c |   1 -
 6 files changed, 248 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 437aeae7f6..3426697ecd 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -79,6 +79,10 @@ int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 typedef struct PCIDevice PCIDevice;
 bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify);
 
+typedef struct CXLError CXLError;
+bool ghes_record_cxl_errors(PCIDevice *dev, PCIEAERErr *err,
+                            CXLError *cxl_err, uint32_t notify);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 857fa61898..24b2166431 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -57,6 +57,8 @@ struct CXLHost {
     bool passthrough;
 };
 
+#define TYPE_CXL_ROOT_PORT "cxl-rp"
+
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
 OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 
diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index bd208af4ec..cbc7d57465 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -19,6 +19,11 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 {
     return -1;
 }
+bool ghes_record_cxl_errors(PCIDevice *dev, PCIEAERErr *err,
+                            CXLError *cxl_err, uint32_t notify)
+{
+    return false;
+}
 
 bool acpi_ghes_present(void)
 {
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index d0103c0a6a..c6e863d375 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -29,6 +29,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/uuid.h"
+#include "hw/cxl/cxl_device.h"
+#include "hw/cxl/cxl.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
 #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
@@ -279,6 +281,140 @@ static void build_append_aer_cper(PCIDevice *dev, GArray *table)
     }
 }
 
+static void build_append_cxl_cper(PCIDevice *dev, CXLError *cxl_err,
+                                  GArray *table)
+{
+    PCIDeviceClass *pci_class = PCI_DEVICE_GET_CLASS(dev);
+    uint16_t sn_cap_offset = pcie_find_capability(dev, 0x3);
+    uint16_t pcie_cap_offset = pci_find_capability(dev, 0x10);
+    uint16_t cxl_dvsec_offset;
+    uint16_t cxl_dvsec_len = 0;
+    uint8_t type = 0xff;
+    int i;
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_TYPE3)) {
+        type = 2;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_USP)) {
+        type = 7;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
+        type = 6;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_ROOT_PORT)) {
+        type = 5;
+    }
+
+    /* Only device or port dvsec should exist */
+    cxl_dvsec_offset = pcie_find_dvsec(dev, 0x1e98, 0);
+    if (cxl_dvsec_offset == 0) {
+        cxl_dvsec_offset = pcie_find_dvsec(dev, 0x1e98, 3);
+    }
+
+    if (cxl_dvsec_offset) {
+        cxl_dvsec_len = pci_get_long(dev->config + cxl_dvsec_offset + 4) >> 20;
+    }
+
+    /* CXL Protocol error record */
+    build_append_int_noprefix(table,
+                              (type != 0xff ? 1UL << 0 : 0) |
+                              (1UL << 1) | /* Agent address valid */
+                              (1UL << 2) | /* Device ID */
+                              ((sn_cap_offset ? 1UL : 0UL) << 3) |
+                              (1UL << 4) | /* Capability structure */
+                              ((cxl_dvsec_offset ? 1UL : 0UL) << 5) |
+                              (1UL << 6), /* Error Log */
+                              8);
+    /* Agent Type */
+    build_append_int_noprefix(table, type, 1); /* CXL 2.0 device */
+
+    /* Reserved */
+    build_append_int_noprefix(table, 0, 7);
+    /* Agent Address */
+    build_append_int_noprefix(table, PCI_FUNC(dev->devfn), 1);
+    build_append_int_noprefix(table, PCI_SLOT(dev->devfn), 1);
+    build_append_int_noprefix(table, pci_dev_bus_num(dev), 1);
+    build_append_int_noprefix(table, 0 /* Seg */, 2);
+    /* Reserved */
+    build_append_int_noprefix(table, 0, 3);
+    /* Device id */
+    build_append_int_noprefix(table, pci_class->vendor_id, 2);
+    build_append_int_noprefix(table, pci_class->device_id, 2);
+    build_append_int_noprefix(table, pci_class->subsystem_vendor_id, 2);
+    build_append_int_noprefix(table, pci_class->subsystem_id, 2);
+    build_append_int_noprefix(table, pci_class->class_id, 2);
+    /*
+     * TODO: figure out how to get the slot number as the slot number
+     * capabiltiy is deprecated so it only really exists via _DSM
+     */
+    build_append_int_noprefix(table, 0, 2);
+    /* Reserved */
+    build_append_int_noprefix(table, 0, 4);
+
+    if (sn_cap_offset) {
+        uint32_t dw = pci_get_long(dev->config + sn_cap_offset + 4);
+
+        build_append_int_noprefix(table, dw, 4);
+        dw = pci_get_long(dev->config + sn_cap_offset + 8);
+        build_append_int_noprefix(table, dw, 4);
+    } else {
+        build_append_int_noprefix(table, 0, 8);
+    }
+
+    if (pcie_cap_offset) {
+        uint32_t *pcie_cap = (uint32_t *)(dev->config + pcie_cap_offset);
+        for (i = 0; i < 60 / sizeof(uint32_t); i++) {
+            build_append_int_noprefix(table, pcie_cap[i], sizeof(uint32_t));
+        }
+    } else { /* Odd if we don't have one of these! */
+        build_append_int_noprefix(table, 0, 60);
+    }
+
+    /* CXL DVSEC Length */
+    build_append_int_noprefix(table, cxl_dvsec_len, 2);
+
+    /* Error log length */
+    build_append_int_noprefix(table, 0x18, 2); /* No head log as I'm lazy */
+    /* Reserved */
+    build_append_int_noprefix(table, 0, 4);
+    /* DVSEC */
+    for (i = 0; i < cxl_dvsec_len; i += sizeof(uint32_t)) {
+        uint32_t dw = pci_get_long(dev->config + cxl_dvsec_offset + i);
+
+        build_append_int_noprefix(table, dw, sizeof(dw));
+    }
+
+    /* error log */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_TYPE3)) {
+        CXLType3Dev *ct3d = CXL_TYPE3(dev);
+        uint32_t *rs = ct3d->cxl_cstate.crb.cache_mem_registers;
+
+        /*
+         * TODO: Possibly move this to caller to gather up  - or work out
+         * generic way to get to it.
+         */
+        build_append_int_noprefix(table,
+                                  ldl_le_p(rs + R_CXL_RAS_UNC_ERR_STATUS), 4);
+        build_append_int_noprefix(table,
+                                  ldl_le_p(rs + R_CXL_RAS_UNC_ERR_MASK), 4);
+        build_append_int_noprefix(table,
+                                  ldl_le_p(rs + R_CXL_RAS_UNC_ERR_SEVERITY), 4);
+        build_append_int_noprefix(table,
+                                  ldl_le_p(rs + R_CXL_RAS_COR_ERR_STATUS), 4);
+        build_append_int_noprefix(table,
+                                  ldl_le_p(rs + R_CXL_RAS_COR_ERR_MASK), 4);
+        build_append_int_noprefix(table,
+                                  ldl_le_p(rs + R_CXL_RAS_ERR_CAP_CTRL), 4);
+        if (cxl_err) {
+            for (i = 0; i < CXL_RAS_ERR_HEADER_NUM; i++) {
+                build_append_int_noprefix(table, cxl_err->header[i], 4);
+            }
+        } else {
+            build_append_int_noprefix(table, 0, 4 * CXL_RAS_ERR_HEADER_NUM);
+        }
+    } else {
+        /* TODO: Add support for ports etc */
+        build_append_int_noprefix(table, 0, 0x18 + 512);
+    }
+}
+
 static int acpi_ghes_record_mem_error(uint64_t error_block_address,
                                       uint64_t error_physical_addr)
 {
@@ -365,6 +501,52 @@ static int ghes_record_aer_error(PCIDevice *dev, uint64_t error_block_address)
     return true;
 }
 
+static int ghes_record_cxl_error(PCIDevice *dev, CXLError *cxl_err,
+                                 uint64_t error_block_address)
+{
+    GArray *block;
+    uint32_t data_length;
+    const uint8_t aer_section_id_le[] = {
+        0xB4, 0xEF, 0xB9, 0x80,
+        0xB5, 0x52,
+        0xE3, 0x4D,
+        0xA7, 0x77, 0x68, 0x78, 0x4B, 0x77, 0x10, 0x48 };
+    QemuUUID fru_id = {0};
+
+    block = g_array_new(false, true /* clear */, 1);
+    /* Read the current length in bytes of the generic error data */
+    cpu_physical_memory_read(error_block_address + 8,
+                             &data_length, 4);
+
+    /* Add a new generic error data entry */
+    data_length += ACPI_GHES_DATA_LENGTH;
+    /* TO FIX: Error record dependent */
+    data_length += ACPI_GHES_PCIE_CPER_LENGTH;
+
+    /*
+     * Check whether it will run out of the preallocated memory if adding a new
+     * generic error data entry
+     */
+    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_report("Record CPER out of boundary!!!");
+        return false;
+    }
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE, 0, 0,
+                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
+
+    /* Build the new generic error data entry header */
+    acpi_ghes_generic_error_data(block, aer_section_id_le,
+                                 ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                 ACPI_GHES_PCIE_CPER_LENGTH, fru_id, 0);
+    /* Build the CXL CPER */
+    build_append_cxl_cper(dev, cxl_err, block);
+    /* Write back above whole new generic error data entry to guest memory */
+    cpu_physical_memory_write(error_block_address, block->data, block->len);
+    g_array_free(block, true);
+    return true;
+}
+
 /*
  * Build table for the hardware error fw_cfg blob.
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
@@ -676,6 +858,36 @@ bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify)
     return ghes_record_aer_error(dev, error_block_addr);
 }
 
+bool ghes_record_cxl_errors(PCIDevice *dev, PCIEAERErr *aer_err,
+                            CXLError *cxl_err, uint32_t notify)
+{
+    int read_ack_register = 0;
+    uint64_t read_ack_register_addr = 0;
+    uint64_t error_block_addr = 0;
+
+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_register_addr)) {
+        return false;
+    }
+
+    cpu_physical_memory_read(read_ack_register_addr,
+                             &read_ack_register, sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("Last time OSPM does not acknowledge the error,"
+                     " record CPER failed this time, set the ack value to"
+                     " avoid blocking next time CPER record! exit");
+        read_ack_register = 1;
+        cpu_physical_memory_write(read_ack_register_addr,
+                                  &read_ack_register, sizeof(uint64_t));
+        return false;
+    }
+
+    read_ack_register = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_register_addr,
+                              &read_ack_register, sizeof(uint64_t));
+    return ghes_record_cxl_error(dev, cxl_err, error_block_addr);
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index db950d10dc..3a7881118a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -29,6 +29,8 @@
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/spdm.h"
+#include "hw/boards.h"
+#include "hw/acpi/ghes.h"
 
 #define DWORD_BYTE 4
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
@@ -1520,6 +1522,8 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
                                          CXLUncorErrorRecordList *errors,
                                          Error **errp)
 {
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     Object *obj = object_resolve_path(path, NULL);
     static PCIEAERErr err = {};
     CXLType3Dev *ct3d;
@@ -1605,7 +1609,16 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
     }
 
     stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, unc_err);
-    pcie_aer_inject_error(PCI_DEVICE(obj), &err);
+    if (!acpi_fw_first_pci()) {
+        pcie_aer_inject_error(PCI_DEVICE(obj), &err);
+    } else {
+        ghes_record_cxl_errors(PCI_DEVICE(obj), &err,
+                               QTAILQ_FIRST(&ct3d->error_list),
+                               ACPI_GHES_NOTIFY_GPIO);
+        if (mc->set_error) {
+            mc->set_error();
+        }
+    }
 
     return;
 }
@@ -1613,6 +1626,8 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
 void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
                                       Error **errp)
 {
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     static PCIEAERErr err = {};
     Object *obj = object_resolve_path(path, NULL);
     CXLType3Dev *ct3d;
@@ -1650,8 +1665,15 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
     cor_err |= (1 << cxl_err_type);
     stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, cor_err);
-
-    pcie_aer_inject_error(PCI_DEVICE(obj), &err);
+    if (!acpi_fw_first_pci()) {
+        pcie_aer_inject_error(PCI_DEVICE(obj), &err);
+    } else {
+        ghes_record_cxl_errors(PCI_DEVICE(obj), &err, NULL,
+                               ACPI_GHES_NOTIFY_GPIO);
+        if (mc->set_error) {
+            mc->set_error();
+        }
+    }
 }
 
 static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index deee8cdb37..15d783913d 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -54,7 +54,6 @@ typedef struct CXLRootPort {
     PCIResReserve res_reserve;
 } CXLRootPort;
 
-#define TYPE_CXL_ROOT_PORT "cxl-rp"
 DECLARE_INSTANCE_CHECKER(CXLRootPort, CXL_ROOT_PORT, TYPE_CXL_ROOT_PORT)
 
 /*
-- 
2.39.2


