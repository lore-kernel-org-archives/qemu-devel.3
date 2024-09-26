Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7260CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmkq-0000OB-61; Thu, 26 Sep 2024 07:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1stmkn-0000Eu-Sr
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:33:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1stmkk-00048P-0g
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:33:49 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XDrzV2YF8zcbh2;
 Thu, 26 Sep 2024 19:32:06 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
 by mail.maildlp.com (Postfix) with ESMTPS id EFC85140390;
 Thu, 26 Sep 2024 19:33:32 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 26 Sep 2024 19:33:32 +0800
To: <mst@redhat.com>, <imammedo@redhat.com>, <peter.maydell@linaro.org>,
 <wangyanan55@huawei.com>, <anisinha@redhat.com>,
 <jonathan.cameron@huawei.com>, <qemu-devel@nongnu.org>
CC: <shameerali.kolothum.thodi@huawei.com>, <alireza.sanaee@huawei.com>,
 <prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 3/5] hw/acpi/aml-build: Build a root node in the PPTT table
Date: Thu, 26 Sep 2024 19:33:21 +0800
Message-ID: <20240926113323.55991-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240926113323.55991-1-yangyicong@huawei.com>
References: <20240926113323.55991-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=yangyicong@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Yicong Yang <yangyicong@huawei.com>
From:  Yicong Yang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yicong Yang <yangyicong@hisilicon.com>

Currently we build the PPTT starting from the socket node and each
socket will be a separate tree. For a multi-socket system it'll
be hard for the OS to know the whole system is homogeneous or not
(actually we're in the current implementation) since no parent node
to telling the identical implementation informentation. Add a
root node for indicating this.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 hw/acpi/aml-build.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 53a06d8c1e..e2717ee0e9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2059,12 +2059,25 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
     int64_t socket_id = -1, cluster_id = -1, core_id = -1;
     uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
     uint32_t pptt_start = table_data->len;
+    uint32_t root_offset;
     int n;
     AcpiTable table = { .sig = "PPTT", .rev = 2,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
 
+    /*
+     * Build a root node for all the processor nodes. Otherwise when
+     * building a multi-socket system each socket tree are separated
+     * and will be hard for the OS like Linux to know whether the
+     * system is homogeneous.
+     */
+    root_offset = table_data->len - pptt_start;
+    build_processor_hierarchy_node(table_data,
+        (1 << 0) | /* Physical package */
+        (1 << 4), /* Identical Implementation */
+        0, 0, NULL, 0);
+
     /*
      * This works with the assumption that cpus[n].props.*_id has been
      * sorted from top to down levels in mc->possible_cpu_arch_ids().
@@ -2081,7 +2094,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             build_processor_hierarchy_node(table_data,
                 (1 << 0) | /* Physical package */
                 (1 << 4), /* Identical Implementation */
-                0, socket_id, NULL, 0);
+                root_offset, socket_id, NULL, 0);
         }
 
         if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
-- 
2.24.0


