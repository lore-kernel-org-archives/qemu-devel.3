Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8829E81A2F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 14:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrzyL-0006jC-Au; Mon, 16 Feb 2026 09:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vrzyJ-0006iU-57
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:53:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vrzyG-0004s4-4a
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 09:53:10 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fF5Nb39cjzJ468n;
 Mon, 16 Feb 2026 22:52:47 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 0E3EB40572;
 Mon, 16 Feb 2026 22:52:56 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.67.55) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Feb 2026 14:52:55 +0000
To: <qemu-devel@nongnu.org>, <lizhijian@fujitsu.com>
CC: <anisa.su887@gmail.com>, <armbru@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <mst@redhat.com>, <nifan.cxl@gmail.com>,
 <peterx@redhat.com>, <philmd@linaro.org>, <ppbonzini@redhat.com>,
 <venkataravis@micron.com>, <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v3 1/2] hw/cxl: Use HPA in cxl_cfmws_find_device() rather than
 offset in window.
Date: Mon, 16 Feb 2026 14:52:17 +0000
Message-ID: <20260216145219.1959-2-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260216145219.1959-1-alireza.sanaee@huawei.com>
References: <20260216145219.1959-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.67.55]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This function will shortly be used to help find if there is a route to a
device, serving an HPA, under a particular fixed memory window. Rather
than having that new use case subtract the base address in the caller,
only to add it again in cxl_cfmws_find_device(), push the responsibility
for calculating the HPA to the caller.

This also reduces the inconsistency in the meaning of the hwaddr
addr parameter between this function and the calls made within it
that access the HDM decoders that operating on HPA.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 hw/cxl/cxl-host.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f3479b1991..415a792380 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -157,7 +157,8 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     return found;
 }
 
-static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
+static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
+                                        bool allow_interleave)
 {
     CXLComponentState *hb_cstate, *usp_cstate;
     PCIHostState *hb;
@@ -168,8 +169,6 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     bool target_found;
     PCIDevice *rp, *d;
 
-    /* Address is relative to memory region. Convert to HPA */
-    addr += fw->base;
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
@@ -254,7 +253,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         *data = 0;
         /* Reads to invalid address return poison */
@@ -271,7 +270,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         /* Writes to invalid address are silent */
         return MEMTX_OK;
-- 
2.43.0


