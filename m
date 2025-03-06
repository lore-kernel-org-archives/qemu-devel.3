Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA708C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 02:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq14h-0002EV-CC; Wed, 05 Mar 2025 21:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tq14f-0002AZ-JB
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:35:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tq14d-000514-Gy
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:35:01 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7YMz713hz6M4NS;
 Thu,  6 Mar 2025 10:31:59 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 0C12F140593;
 Thu,  6 Mar 2025 10:34:58 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.96.233.98) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 03:34:54 +0100
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <imammedo@redhat.com>, <peter.maydell@linaro.org>,
 <wangyanan55@huawei.com>, <anisinha@redhat.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 2/5] hw/acpi/aml-build: Set identical implementation flag
 for PPTT processor nodes
Date: Thu, 6 Mar 2025 02:33:39 +0000
Message-ID: <20250306023342.508-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306023342.508-1-alireza.sanaee@huawei.com>
References: <20250306023342.508-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.96.233.98]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/acpi/aml-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f8f93a9f66..560cee12a2 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2173,7 +2173,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             core_id = -1;
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
-                (1 << 0), /* Physical package */
+                (1 << 0) | /* Physical package */
+                (1 << 4), /* Identical Implementation */
                 0, socket_id, NULL, 0);
         }
 
@@ -2184,7 +2185,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = -1;
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     socket_offset, cluster_id, NULL, 0);
             }
         } else {
@@ -2202,7 +2204,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = cpus->cpus[n].props.core_id;
                 core_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     cluster_offset, core_id, NULL, 0);
             }
 
-- 
2.43.0


