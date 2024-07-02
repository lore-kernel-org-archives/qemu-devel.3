Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3874AC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdPv-0002Ne-89; Tue, 02 Jul 2024 09:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOdPg-00023s-MV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:19:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOdPd-00071x-1a
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:19:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3Q33dGhz6JBvW;
 Tue,  2 Jul 2024 21:18:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 426D5140B33;
 Tue,  2 Jul 2024 21:19:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:19:10 +0100
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 09/13] hw/pci-host/gpex-acpi: Use acpi_uid property.
Date: Tue, 2 Jul 2024 14:14:14 +0100
Message-ID: <20240702131428.664859-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reduce the direct use of PCI internals inside ACPI table creation.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4: New patch
---
 hw/pci-host/gpex-acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f69413ea2c..5faebdd467 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -140,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint8_t uid;
             bool is_cxl = pci_bus_is_cxl(bus);
 
             if (!pci_bus_is_root(bus)) {
@@ -155,7 +156,9 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 nr_pcie_buses = bus_num;
             }
 
-            dev = aml_device("PC%.02X", bus_num);
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
+            dev = aml_device("PC%.02X", uid);
             if (is_cxl) {
                 struct Aml *pkg = aml_package(2);
                 aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
@@ -167,7 +170,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
             }
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
             aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
             aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
             if (numa_node != NUMA_NODE_UNASSIGNED) {
-- 
2.43.0


