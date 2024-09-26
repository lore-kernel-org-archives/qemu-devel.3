Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39585CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmkq-0000Qs-U3; Thu, 26 Sep 2024 07:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1stmkn-0000F5-VU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:33:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1stmkk-00048K-BA
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:33:49 -0400
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XDrzy2DzFzySKX;
 Thu, 26 Sep 2024 19:32:30 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
 by mail.maildlp.com (Postfix) with ESMTPS id 7B4911401E0;
 Thu, 26 Sep 2024 19:33:32 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 26 Sep 2024 19:33:31 +0800
To: <mst@redhat.com>, <imammedo@redhat.com>, <peter.maydell@linaro.org>,
 <wangyanan55@huawei.com>, <anisinha@redhat.com>,
 <jonathan.cameron@huawei.com>, <qemu-devel@nongnu.org>
CC: <shameerali.kolothum.thodi@huawei.com>, <alireza.sanaee@huawei.com>,
 <prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 2/5] hw/acpi/aml-build: Set identical implementation flag for
 PPTT processor nodes
Date: Thu, 26 Sep 2024 19:33:20 +0800
Message-ID: <20240926113323.55991-3-yangyicong@huawei.com>
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

Per ACPI 6.5 Table 5.158: Processor Structure Flags, the identical
implementation flag indicates whether all the children processors
of this node share the same identical implementation revision.
Currently Linux support parsing this field [1] and maybe used to
identify the heterogeneous platform. Since qemu only support
homogeneous emulation, set this flag for all the processor node
to indicates the facts when building the PPTT table. Node leaf
is an exception since spec says this flag should be ignored
on leaf nodes by OSPM.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 hw/acpi/aml-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..53a06d8c1e 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2079,7 +2079,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             core_id = -1;
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
-                (1 << 0), /* Physical package */
+                (1 << 0) | /* Physical package */
+                (1 << 4), /* Identical Implementation */
                 0, socket_id, NULL, 0);
         }
 
@@ -2090,7 +2091,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = -1;
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     socket_offset, cluster_id, NULL, 0);
             }
         } else {
@@ -2108,7 +2110,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = cpus->cpus[n].props.core_id;
                 core_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     cluster_offset, core_id, NULL, 0);
             }
 
-- 
2.24.0


