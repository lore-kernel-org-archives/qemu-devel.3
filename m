Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02955C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezCo-0001io-9f; Mon, 03 Feb 2025 11:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tezCl-0001cT-Mh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:21:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tezCj-0004v8-Ic
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:21:47 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmsC70fzpz6D97N;
 Tue,  4 Feb 2025 00:19:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 118761401F4;
 Tue,  4 Feb 2025 00:21:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 17:21:43 +0100
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 5/5] mem/cxl_type3: support 3, 6,
 12 and 16 interleave ways
Date: Mon, 3 Feb 2025 16:19:08 +0000
Message-ID: <20250203161908.145406-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

Since the kernel does not check the interleave capability, a
3-way, 6-way, 12-way or 16-way region can be create normally.

Applications can access the memory of 16-way region normally because
qemu can convert hpa to dpa correctly for the power of 2 interleave
ways, after kernel implementing the check, this kind of region will
not be created any more.

For non power of 2 interleave ways, applications could not access the
memory normally and may occur some unexpected behaviors, such as
segmentation fault.

So implements this feature is needed.

Link: https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com/
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c |  9 +++++++--
 hw/mem/cxl_type3.c           | 15 +++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index cd116c0401..473895948b 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -243,8 +243,13 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      POISON_ON_ERR_CAP, 0);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    if (type == CXL2_TYPE3_DEVICE) {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 1);
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 1);
+    } else {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    }
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      UIO_DECODER_COUNT, 0);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d8b45f9bd1..6fffa21ead 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1100,10 +1100,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
             continue;
         }
 
-        *dpa = dpa_base +
-            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
-              >> iw));
+        if (iw < 8) {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
+                  >> iw));
+        } else {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
+                   >> (ig + iw)) / 3) << (ig + 8)));
+        }
 
         return true;
     }
-- 
2.43.0


