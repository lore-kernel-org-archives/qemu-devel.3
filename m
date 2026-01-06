Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8B5CE9D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9W5-0001An-34; Tue, 06 Jan 2026 11:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9Uq-0000KL-Fx; Tue, 06 Jan 2026 11:01:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9Uo-0007DH-RI; Tue, 06 Jan 2026 11:01:24 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwrX2VpTzHnHD1;
 Wed,  7 Jan 2026 00:01:16 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id C531140569;
 Wed,  7 Jan 2026 00:01:20 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.31.135) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Jan 2026 16:01:19 +0000
To: <qemu-devel@nongnu.org>, <gustavo.romero@linaro.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <maobibo@loongson.cn>, <mst@redhat.com>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <zhao1.liu@intel.com>
Subject: [PATCH v17 5/8] acpi: add caches to ACPI build_pptt table function
Date: Tue, 6 Jan 2026 15:58:24 +0000
Message-ID: <20260106155828.643-6-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260106155828.643-1-alireza.sanaee@huawei.com>
References: <20260106155828.643-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.31.135]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add caches to build_pptt table function in ACPI for both ARM and
Loongarch.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/acpi/aml-build.c            | 3 ++-
 hw/arm/virt-acpi-build.c       | 2 +-
 hw/loongarch/virt-acpi-build.c | 4 ++--
 include/hw/acpi/aml-build.h    | 4 +++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index dad4cfcc7d..a711a9600e 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2145,7 +2145,8 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
  * 5.2.29 Processor Properties Topology Table (PPTT)
  */
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id,
+                int num_caches, CPUCoreCaches *caches)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUArchIdList *cpus = ms->possible_cpus;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 03b4342574..8e7bc029f3 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1166,7 +1166,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms,
-                   vms->oem_id, vms->oem_table_id);
+                   vms->oem_id, vms->oem_table_id, 0, NULL);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 8ff9ebdcd9..47c9f96821 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -550,8 +550,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     build_madt(tables_blob, tables->linker, lvms);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_pptt(tables_blob, tables->linker, machine,
-               lvms->oem_id, lvms->oem_table_id);
+    build_pptt(tables_blob, tables->linker, machine, lvms->oem_id,
+               lvms->oem_table_id, 0, NULL);
 
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index f38e129719..e70e0643b1 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -3,6 +3,7 @@
 
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/core/cpu.h"
 
 #define ACPI_BUILD_APPNAME6 "BOCHS "
 #define ACPI_BUILD_APPNAME8 "BXPC    "
@@ -499,7 +500,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id,
+                int num_caches, CPUCoreCaches *caches);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
-- 
2.43.0


