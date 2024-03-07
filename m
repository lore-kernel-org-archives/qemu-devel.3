Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F0CC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGEX-0006Hl-Hr; Thu, 07 Mar 2024 11:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riGET-0006EN-9R
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riGEO-0006We-Lv
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:32 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrDXq6RZgz6K7Jc;
 Fri,  8 Mar 2024 00:00:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 615CC14166F;
 Fri,  8 Mar 2024 00:04:26 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 16:04:25 +0000
To: Liu Jingqi <jingqi.liu@intel.com>, <qemu-devel@nongnu.org>,
 <ankita@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
CC: <linuxarm@huawei.com>, Markus Armbruster <armbru@redhat.com>, Daniel Black
 <daniel@linux.ibm.com>
Subject: [PATCH v2 2/2] hmat acpi: Fix out of bounds access due to missing use
 of indirection
Date: Thu, 7 Mar 2024 16:03:26 +0000
Message-ID: <20240307160326.31570-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307160326.31570-1-Jonathan.Cameron@huawei.com>
References: <20240307160326.31570-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

With a numa set up such as

-numa nodeid=0,cpus=0 \
-numa nodeid=1,memdev=mem \
-numa nodeid=2,cpus=1

and appropriate hmat_lb entries the initiator list is correctly
computed and writen to HMAT as 0,2 but then the LB data is accessed
using the node id (here 2), landing outside the entry_list array.

Stash the reverse lookup when writing the initiator list and use
it to get the correct array index index.

Fixes: 4586a2cb83 ("hmat acpi: Build System Locality Latency and Bandwidth Information Structure(s)")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/hmat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 723ae28d32..b933ae3c06 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -78,6 +78,7 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
                           uint32_t *initiator_list)
 {
     int i, index;
+    uint32_t initiator_to_index[MAX_NODES] = {};
     HMAT_LB_Data *lb_data;
     uint16_t *entry_list;
     uint32_t base;
@@ -121,6 +122,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     /* Initiator Proximity Domain List */
     for (i = 0; i < num_initiator; i++) {
         build_append_int_noprefix(table_data, initiator_list[i], 4);
+        /* Reverse mapping for array possitions */
+        initiator_to_index[initiator_list[i]] = i;
     }
 
     /* Target Proximity Domain List */
@@ -132,7 +135,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     entry_list = g_new0(uint16_t, num_initiator * num_target);
     for (i = 0; i < hmat_lb->list->len; i++) {
         lb_data = &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
-        index = lb_data->initiator * num_target + lb_data->target;
+        index = initiator_to_index[lb_data->initiator] * num_target +
+            lb_data->target;
 
         entry_list[index] = (uint16_t)(lb_data->data / hmat_lb->base);
     }
-- 
2.39.2


