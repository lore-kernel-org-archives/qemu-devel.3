Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517F8C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribN3-0005Ua-0q; Fri, 08 Mar 2024 09:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ribN0-0005UI-Em
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:38:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ribMn-0000IG-1y
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:38:46 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Trpb94r48z6K8sy;
 Fri,  8 Mar 2024 22:34:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 90C68140D1D;
 Fri,  8 Mar 2024 22:38:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 14:38:29 +0000
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: [PATCH] hw/cxl: Fix missing reserved data in CXL Device DVSEC
Date: Fri, 8 Mar 2024 14:38:31 +0000
Message-ID: <20240308143831.6256-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

The r3.1 specification introduced a new 2 byte field, but
to maintain DWORD alignment, a additional 2 reserved bytes
were added. Forgot those in updating the structure definition
but did include them in the size define leading to a buffer
overrun.

Also use the define so that we don't duplicate the value.

Fixes: Coverity ID 1534095 buffer overrun
Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_pci.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 265db6c407..d0855ed78b 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -92,8 +92,9 @@ typedef struct CXLDVSECDevice {
     uint32_t range2_base_hi;
     uint32_t range2_base_lo;
     uint16_t cap3;
+    uint16_t resv;
 } QEMU_PACKED CXLDVSECDevice;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x3A);
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != PCIE_CXL_DEVICE_DVSEC_LENGTH);
 
 /*
  * CXL r3.1 Section 8.1.5: CXL Extensions DVSEC for Ports
-- 
2.39.2


