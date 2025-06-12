Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14626C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkKb-00057y-NK; Thu, 12 Jun 2025 11:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkKY-00051u-J5
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:59:07 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkKV-0003Q9-Qp
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:59:05 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ6bh3GCMz6K9B2;
 Thu, 12 Jun 2025 23:57:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2DFD31404F9;
 Thu, 12 Jun 2025 23:59:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 17:58:59 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Bowman Terry <terry.bowman@amd.com>
CC: <linuxarm@huawei.com>, <rientjes@google.com>, <dave@stgolabs.net>,
 <joshua.hahnjy@gmail.com>, <rkodsara@amd.com>, <sj@kernel.org>,
 <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <ziy@nvidia.com>,
 <weixugc@google.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 QEMU 3/4] hw/cxl: Provide a means to get the interleave
 set position for an EP
Date: Thu, 12 Jun 2025 16:57:23 +0100
Message-ID: <20250612155724.1887266-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
References: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

CXL interleave decoding is hieriarchical in a fashion that means the CXL
memory devices only need to know the interleave granularity and interleave
ways to figure out which address bits to drop from incoming translactions.
Unfortunately to provide the right information to the hotness monitoring
plugin, which filters transactions in Host Physical Address space, it is
necessary to know which interleave set position a given device is in.

I tried various more sophisticated solutions to provide this information
but they were all rather complex. The solution used here is the brute force
one.  Every time an HDM Decoder is committed (these are the address routing
elements) it checks every Type 3 Device HDM Decoder to find a HPA range. It
then uses the address routing HPA to Device matching heirarchical routing
at a series of addresses corresponding to the first byte of each interleave
set. When the same device is reached then we know we have the correct
Interleave Set Position and pass that to the CHMU.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
RFC v2: New patch. Note lightly tested only so far.
---
 include/hw/cxl/cxl.h         |  1 +
 hw/cxl/cxl-component-utils.c |  4 ++
 hw/cxl/cxl-host.c            | 72 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  2 +
 4 files changed, 79 insertions(+)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 12844d3418..b4b83c0b63 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -71,4 +71,5 @@ CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
 typedef struct CXLDownstreamPort CXLDownstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
 
+void cxl_update_isp(void);
 #endif
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 473895948b..f53ce1ebaa 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -116,6 +116,10 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
         value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
     }
     stl_le_p((uint8_t *)cache_mem + offset, value);
+
+    if (should_commit) {
+        cxl_update_isp();
+    }
 }
 
 static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 5239555f6c..893ef7f7fa 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -279,6 +279,78 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     return cxl_type3_write(d, addr + fw->base, data, size, attrs);
 }
 
+/*
+ * Updating the end point decoder stashed Interleave Set Positions (ISP)
+ * that is needed for the CHMU to pass to the cache plugin + hotness tracker
+ * is tricky as the decoders can be committed in any order.
+ *
+ * Brute force the problem by finding any endpoints below a cfmws and for
+ * each enabled decoder, probing until we get a match - if any upstream
+ * decoders are not commited this will fail but that is fine as we try again
+ * later when the situation is resolved by commiting upstream decoders.
+ *
+ * This is a rare operation, so not worth complexity of walking down from
+ * the Fixed memory windows. Just compare all with all.
+ */
+
+/* Update ISP for a given Type 3 memory device */
+static int cxl_type3_update_isp(Object *obj, void *opaque)
+{
+    CXLType3Dev *ct3d;
+    CXLFixedWindow *fw = opaque;
+    int i;
+
+    /*
+     * From the CXL Type 3 HDM decoders we need interleave info.
+     * That will let us then find out for each decoder what hits it....
+     */
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+
+    ct3d = CXL_TYPE3(obj);
+
+    for (i = 0; i < CXL_HDM_DECODER_COUNT; i++) {
+        uint64_t hpa_base;
+        uint16_t granual;
+        uint8_t ways, w;
+        PCIDevice *d;
+
+        if (!cxl_type3_get_hdm_interleave_props(ct3d, i, &hpa_base, &granual,
+                                                &ways)) {
+            continue; /* commit in order, but teardown can be messy */
+        }
+
+        for (w = 0; w < ways; w++) {
+            d = cxl_cfmws_find_device(fw, hpa_base + w * granual - fw->base);
+            if (d == PCI_DEVICE(ct3d)) {
+                cxl_type3_set_hdm_isp(ct3d, i, w);
+            }
+        }
+    }
+    return 0;
+}
+
+static int cxl_fmw_update_isp(Object *obj, void *priv)
+{
+    struct CXLFixedWindow *fw;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    fw = CXL_FMW(obj);
+    object_child_foreach_recursive(object_get_root(),
+                                   cxl_type3_update_isp, fw);
+    return 0;
+}
+
+/* Update all Interleave Set Positions on all EP HDM decoders */
+void cxl_update_isp(void)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   cxl_fmw_update_isp, NULL);
+}
+
 const MemoryRegionOps cfmws_ops = {
     .read_with_attrs = cxl_read_cfmws,
     .write_with_attrs = cxl_write_cfmws,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 43f4cd8023..8e9f76a07a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -484,6 +484,8 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 
+    cxl_update_isp();
+
     low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc);
     high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc);
     ct3d->cxl_dstate.chmu[0].decoder[which].base =
-- 
2.48.1


