Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDBCC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhJ0-0003ee-N9; Fri, 05 Jul 2024 07:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhIq-0003cl-QG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:40:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhIn-0007kr-Lu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:40:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFs4b4R1nz6JBWG;
 Fri,  5 Jul 2024 19:39:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BDBF81400D1;
 Fri,  5 Jul 2024 19:40:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 12:40:27 +0100
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <linux-cxl@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, <linuxarm@huawei.com>, Zhao Liu
 <zhao1.liu@linux.intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 1/3] hw/cxl/cxl-host: Fix segmentation fault when getting
 cxl-fmw property
Date: Fri, 5 Jul 2024 12:39:54 +0100
Message-ID: <20240705113956.941732-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
References: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

QEMU crashes (Segmentation fault) when getting cxl-fmw property via
qmp:

(QEMU) qom-get path=machine property=cxl-fmw

This issue is caused by accessing wrong callback (opaque) type in
machine_get_cfmw().

cxl_machine_init() sets the callback as `CXLState *` type but
machine_get_cfmw() treats the callback as
`CXLFixedMemoryWindowOptionsList **`.

Fix this error by casting opaque to `CXLState *` type in
machine_get_cfmw().

Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Link: https://lore.kernel.org/r/20240704093404.1848132-1-zhao1.liu@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64..e9f2543c43 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -315,7 +315,8 @@ static void machine_set_cxl(Object *obj, Visitor *v, const char *name,
 static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    CXLFixedMemoryWindowOptionsList **list = opaque;
+    CXLState *state = opaque;
+    CXLFixedMemoryWindowOptionsList **list = &state->cfmw_list;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, list, errp);
 }
-- 
2.43.0


