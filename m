Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CCEC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzq0-0004UV-7q; Mon, 05 Feb 2024 09:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWzpz-0004PL-4t
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:20:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWzpw-0007N4-D3
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:20:42 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7kC5Shxz6K9Bl;
 Mon,  5 Feb 2024 22:17:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D9232140A9C;
 Mon,  5 Feb 2024 22:20:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:20:37 +0000
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
 <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 02/11] hw/acpi: Allow GPEX _OSC to keep fw first control
 of AER and CXL errors.
Date: Mon, 5 Feb 2024 14:19:31 +0000
Message-ID: <20240205141940.31111-3-Jonathan.Cameron@huawei.com>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/cxl.h      |  2 +-
 include/hw/pci-host/gpex.h |  1 +
 hw/acpi/cxl-stub.c         |  2 +-
 hw/acpi/cxl.c              | 31 +++++++++++++++++++++++++++----
 hw/i386/acpi-build.c       |  2 +-
 hw/pci-host/gpex-acpi.c    | 17 +++++++++++------
 hw/pci-host/gpex.c         |  1 +
 7 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index 8f22c71530..38714147ec 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -24,7 +24,7 @@
 void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state);
-void build_cxl_osc_method(Aml *dev);
+void build_cxl_osc_method(Aml *dev, bool fw_first);
 void build_cxl_dsm_method(Aml *dev);
 
 #endif
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index dce883573b..866ae71ba0 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -47,6 +47,7 @@ struct GPEXConfig {
     MemMapEntry pio;
     int         irq;
     PCIBus      *bus;
+    bool        fw_first_ras;
 };
 
 struct GPEXHost {
diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
index 15bc21076b..0ec5c48850 100644
--- a/hw/acpi/cxl-stub.c
+++ b/hw/acpi/cxl-stub.c
@@ -6,7 +6,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/cxl.h"
 
-void build_cxl_osc_method(Aml *dev)
+void build_cxl_osc_method(Aml *dev, bool fw_first)
 {
     g_assert_not_reached();
 }
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index d0e6a4b45e..526cfe961a 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -27,6 +27,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/ghes.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 
@@ -222,11 +223,12 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
     acpi_table_end(linker, &table);
 }
 
-static Aml *__build_cxl_osc_method(void)
+static Aml *__build_cxl_osc_method(bool fw_first)
 {
     Aml *method, *if_uuid, *else_uuid, *if_arg1_not_1, *if_cxl, *if_caps_masked;
     Aml *a_ctrl = aml_local(0);
     Aml *a_cdw1 = aml_name("CDW1");
+    Aml *cxl_ctrl = aml_local(2);
 
     method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
     /* CDW1 is used for the return value so is present whether or not a match occurs */
@@ -260,7 +262,11 @@ static Aml *__build_cxl_osc_method(void)
      * Allows OS control for all 5 features:
      * PCIeHotplug SHPCHotplug PME AER PCIeCapability
      */
-    aml_append(if_uuid, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
+    if (fw_first) {
+        aml_append(if_uuid, aml_and(a_ctrl, aml_int(0x17), a_ctrl));
+    } else {
+        aml_append(if_uuid, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
+    }
 
     /*
      * Check _OSC revision.
@@ -290,6 +296,23 @@ static Aml *__build_cxl_osc_method(void)
     aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(12), "CDW4"));
     /* CXL capabilities */
     aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(16), "CDW5"));
+
+    aml_append(if_cxl, aml_store(aml_name("CDW5"), cxl_ctrl));
+    if (fw_first) {
+        aml_append(if_cxl, aml_and(cxl_ctrl, aml_int(0x0), cxl_ctrl));
+    } else {
+        /* Only allow CXL Memory Error Reporting */
+        aml_append(if_cxl, aml_and(cxl_ctrl, aml_int(0x1), cxl_ctrl));
+    }
+
+    if_caps_masked = aml_if(aml_lnot(aml_equal(aml_name("CDW5"), cxl_ctrl)));
+
+    /* Capability bits were masked */
+    aml_append(if_caps_masked, aml_or(a_cdw1, aml_int(0x10), a_cdw1));
+    aml_append(if_cxl, if_caps_masked);
+
+    aml_append(if_cxl, aml_store(cxl_ctrl, aml_name("CDW5")));
+
     aml_append(if_cxl, aml_store(aml_name("CDW4"), aml_name("SUPC")));
     aml_append(if_cxl, aml_store(aml_name("CDW5"), aml_name("CTRC")));
 
@@ -316,11 +339,11 @@ static Aml *__build_cxl_osc_method(void)
     return method;
 }
 
-void build_cxl_osc_method(Aml *dev)
+void build_cxl_osc_method(Aml *dev, bool fw_first)
 {
     aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
     aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
-    aml_append(dev, __build_cxl_osc_method());
+    aml_append(dev, __build_cxl_osc_method(fw_first));
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 58e4c54f31..2fbac1d826 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1655,7 +1655,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(aml_pkg, aml_eisaid("PNP0A08"));
                 aml_append(aml_pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", aml_pkg));
-                build_cxl_osc_method(dev);
+                build_cxl_osc_method(dev, false);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
                 aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f69413ea2c..f003669975 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -49,7 +49,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
     }
 }
 
-static void acpi_dsdt_add_pci_osc(Aml *dev)
+static void acpi_dsdt_add_pci_osc(Aml *dev, bool fw_first_aer)
 {
     Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
 
@@ -79,8 +79,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
      * Allow OS control for all 5 features:
      * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
      */
-    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
-                              aml_name("CTRL")));
+    if (fw_first_aer) {
+        aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x17),
+                                  aml_name("CTRL")));
+    } else {
+        aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
+                                  aml_name("CTRL")));
+    }
 
     ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
     aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
@@ -186,9 +191,9 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             aml_append(dev, aml_name_decl("_CRS", crs));
 
             if (is_cxl) {
-                build_cxl_osc_method(dev);
+                build_cxl_osc_method(dev, cfg->fw_first_ras);
             } else {
-                acpi_dsdt_add_pci_osc(dev);
+                acpi_dsdt_add_pci_osc(dev, cfg->fw_first_ras);
             }
 
             aml_append(scope, dev);
@@ -263,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_pci_osc(dev);
+    acpi_dsdt_add_pci_osc(dev, cfg->fw_first_ras);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e9cf455bf5..49fc69eec6 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -166,6 +166,7 @@ static Property gpex_host_properties[] = {
                        gpex_cfg.mmio64.base, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
                      gpex_cfg.mmio64.size, 0),
+    DEFINE_PROP_BOOL("fw_first_ras", GPEXHost, gpex_cfg.fw_first_ras, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.39.2


