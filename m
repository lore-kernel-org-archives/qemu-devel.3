Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B94AC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 23:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHu5W-0005K3-Q8; Thu, 13 Jun 2024 19:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu5P-00059d-05; Thu, 13 Jun 2024 19:42:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu5N-0003xX-2i; Thu, 13 Jun 2024 19:42:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0f72734Tz6H7LJ;
 Fri, 14 Jun 2024 07:41:02 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id 687561400D9;
 Fri, 14 Jun 2024 07:42:26 +0800 (CST)
Received: from 00293818-MRGF.china.huawei.com (10.195.245.24) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:42:04 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH RFC V3 12/29] arm/virt/acpi: Build CPUs AML with CPU Hotplug
 support
Date: Fri, 14 Jun 2024 00:36:22 +0100
Message-ID: <20240613233639.202896-13-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613233639.202896-1-salil.mehta@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.195.245.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Support for Virtual CPU Hotplug requires a sequence of ACPI handshakes between
QEMU and the guest kernel when a vCPU is plugged or unplugged. Most of the AML
code to support these handshakes already exists. This AML needs to be built
during VM initialization for the ARM architecture as well, if GED support
exists.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt-acpi-build.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3ccfef026..2d44567df5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -799,6 +799,7 @@ static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    MachineClass *mc = MACHINE_GET_CLASS(vms);
     Aml *scope, *dsdt;
     MachineState *ms = MACHINE(vms);
     const MemMapEntry *memmap = vms->memmap;
@@ -815,7 +816,18 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      * the RTC ACPI device at all when using UEFI.
      */
     scope = aml_scope("\\_SB");
-    acpi_dsdt_add_cpus(scope, vms);
+    /* if GED is enabled then cpus AML shall be added as part build_cpus_aml */
+    if (vms->acpi_dev && mc->has_hotpluggable_cpus) {
+        CPUHotplugFeatures opts = {
+             .acpi_1_compatible = false,
+             .has_legacy_cphp = false
+        };
+
+        build_cpus_aml(scope, ms, opts, NULL, memmap[VIRT_CPUHP_ACPI].base,
+                       "\\_SB", NULL, AML_SYSTEM_MEMORY);
+    } else {
+        acpi_dsdt_add_cpus(scope, vms);
+    }
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
-- 
2.34.1


