Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7400C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWztU-0000fC-LO; Mon, 05 Feb 2024 09:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWztP-0000dn-2F
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:24:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWztN-00013N-9F
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:24:14 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7nx2FVLz6JB89;
 Mon,  5 Feb 2024 22:20:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 80801140A87;
 Mon,  5 Feb 2024 22:24:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:24:10 +0000
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
 <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 09/11] cxl/ras: Set registers to sensible state for FW
 first ras
Date: Mon, 5 Feb 2024 14:19:38 +0000
Message-ID: <20240205141940.31111-10-Jonathan.Cameron@huawei.com>
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

Even if we are doing native RAS, until the point where the OS
requests it via an _OSC the firmware may well be handling any
errors from CXL devices.  As such configure them as if a firmware
has been doing so.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a0ff7d4396..e869c482a7 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -217,13 +217,13 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
     stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, 0);
     stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_STATUS, 0x1cfff);
     /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
-    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
+    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0/*0x1cfff*/);
     stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
     stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
     stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
     stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, 0);
     stl_le_p(write_msk + R_CXL_RAS_COR_ERR_STATUS, 0x7f);
-    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0x7f);
+    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0/*0x7f*/);
     stl_le_p(write_msk + R_CXL_RAS_COR_ERR_MASK, 0x7f);
     /* CXL switches and devices must set */
     stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x200);
-- 
2.39.2


