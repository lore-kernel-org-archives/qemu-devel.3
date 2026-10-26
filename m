Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A5606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=OfPivGXH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbQ-0002V3-MU; Mon, 26 Oct 2026 08:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPC-0002mG-WB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:16 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPB-000815-7D
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008460; x=1824544460;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/tmmNQTc1uXtVHQp9ghXgdfmfuVHFU+fKjxTNRMw6H4=;
 b=OfPivGXHA2Uvn6Q2rgVeo5ckstTudBy3RRXwByzBlE0VsMqPoArEG7WQ
 YFYz9tkG3lJijEK33XKkhiuma4sWp/sDO1J7y0ZDOobTltZh/rdId31ae
 N0HaXqK5Dvc0Pq9mb93Qp1Q0DuCQ0RpBVWI3up11ORaaOsGsl/GoG7pnl
 H/KhW6y1Z72y2E0JdTskPTTkT8JoEP56pcDg6OmpVBFnKMqIlo1uIeYz1
 HSFqqSFyTw/7PRdrCmSqAEoHUbso43K9fn9hSDQGOUtlP/vp1n8SNOaGt
 U7PW/uB23kLbS4v0P1O8NX9pkATRRSCb4JzWrkIZXGoFa7FD+Fg1YNuHb Q==;
X-CSE-ConnectionGUID: 98wudPVoTD2htf5jAz2kaw==
X-CSE-MsgGUID: XS+iyBYqR7m43XdgYXlt3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="259472559"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="259472559"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:18 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 88DFC1C000CF
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:11 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTP id 020571C002F9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:11 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id C1B00202EBDE;
 Mon, 26 Oct 2026 18:54:09 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
 linux-cxl@vger.kernel.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 3/7] QEMU: hw/cxl: add helper to get HPA range for CXL
 Type 3
Date: Mon, 26 Oct 2026 19:03:24 +0900
Message-ID: <22b52860497f643217fb52f029d87ebd8a6e6492.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.48; envelope-from=fj2110jc@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:14:57 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yukiya Takaki <fj2110jc@fujitsu.com>
From:  Yukiya Takaki via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The previously added `hpa_offset` on CXLType3Dev records the offset of a
device within its CFMW window, but there is no simple helper to obtain the
full host physical address (HPA) range for a given Type 3 device.

This patch adds `ct3_type3_get_hpm_range()`, which returns the HPA base and
size for a CXLType3Dev by combining the CFMW base, the per‑device offset
and the device size. The helper is declared in the header so that other
code can use it when building tables and regions.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c          | 40 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d08a4255c9..811f8e247d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1358,6 +1358,46 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+static uint64_t c3t_addr_size(DeviceState *dev)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+
+    return memory_region_size(vmr);
+}
+
+static uint64_t c3t_hpa_base(DeviceState *dev)
+{
+    GSList *cfmws_list, *iter;
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        struct CXLFixedWindow *fw;
+
+        if (!object_dynamic_cast(iter->data, TYPE_CXL_FMW)) {
+            continue;
+        }
+        fw = CXL_FMW(iter->data);
+
+        PXBCXLDev *pxb = fw->target_hbs[0];
+        if (ct3d_to_cxl_pxb(dev) != pxb->cxl_host_bridge) {
+            continue;
+        }
+
+        g_slist_free(cfmws_list);
+        return fw->base;
+    }
+    g_slist_free(cfmws_list);
+
+    return 0;
+}
+
+void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size)
+{
+    *base = c3t_hpa_base(DEVICE(dev)) + dev->hpa_offset;
+    *size = c3t_addr_size(DEVICE(dev));
+}
+
 static void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c3a729f8c5..07654f4b62 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -878,6 +878,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size);
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp,
-- 
2.52.0


