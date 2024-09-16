Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B405FC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFkY-00047W-5i; Mon, 16 Sep 2024 13:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFkS-0003o6-42
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:42:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFkN-00043q-7W
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:42:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sZt3xSXz6K9F9;
 Tue, 17 Sep 2024 01:38:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B7004140AB8;
 Tue, 17 Sep 2024 01:42:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:42:39 +0200
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: [PATCH v6 11/15] hw/acpi: Make storage of node id uint32_t to reduce
 fragility
Date: Mon, 16 Sep 2024 18:42:37 +0100
Message-ID: <20240916174237.1843213-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_NONE=0.001,
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

From review of generic port introduction.

The value is handled as a uint32_t so store it in that type.
The value cannot in reality exceed MAX_NODES which is currently
128 but if the types are matched there is no need to rely on that
restriction.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: New patch bringing Generic Initiator handling inline with
    updated generic ports code following Igor's review.
    Kind of suggested-by Igor, indirectly...
---
 include/hw/acpi/aml-build.h | 2 +-
 hw/acpi/aml-build.c         | 2 +-
 hw/acpi/pci.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 47a4692a7d..4fd5da49e7 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -486,7 +486,7 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set, uint32_t io_offset,
 void build_srat_memory(GArray *table_data, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-void build_srat_pci_generic_initiator(GArray *table_data, int node,
+void build_srat_pci_generic_initiator(GArray *table_data, uint32_t node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn);
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 4aa4debf44..91540df826 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1973,7 +1973,7 @@ static void build_append_srat_acpi_device_handle(GArray *table_data,
  * 5.2.16.6 Generic Initiator Affinity Structure
  *    With PCI Device Handle.
  */
-void build_srat_pci_generic_initiator(GArray *table_data, int node,
+void build_srat_pci_generic_initiator(GArray *table_data, uint32_t node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn)
 {
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index d7a0e91f01..a4835ce563 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -72,7 +72,7 @@ typedef struct AcpiGenericInitiator {
 
     /* public */
     char *pci_dev;
-    uint16_t node;
+    uint32_t node;
 } AcpiGenericInitiator;
 
 typedef struct AcpiGenericInitiatorClass {
-- 
2.43.0


