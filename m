Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039A9E9D3F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 15:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vneN1-00056V-8M; Wed, 04 Feb 2026 10:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vneMz-00055z-UM
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 10:00:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vneMy-0005N8-9i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 10:00:41 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5k6F2mzFzJ46ZW;
 Wed,  4 Feb 2026 22:59:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 8DF5A40086;
 Wed,  4 Feb 2026 23:00:38 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.68.30) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 15:00:37 +0000
To: <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
 <nifan.cxl@gmail.com>, <anisa.su887@gmail.com>, <mst@redhat.com>,
 <armbru@redhat.com>, <lizhijian@fujitsu.com>, <ppbonzini@redhat.com>,
 <peterx@redhat.com>, <philmd@linaro.org>, <david@kernel.org>,
 <imammedo@redhat.com>, <xiaoguangrong.eric@gmail.com>,
 <venkataravis@micron.com>, <gourry@gourry.net>
Subject: [PATCH v2 1/2] hw/cxl: Use HPA in cxl_cfmws_find_device() rather than
 offset in window.
Date: Wed, 4 Feb 2026 15:00:00 +0000
Message-ID: <20260204150002.669-2-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260204150002.669-1-alireza.sanaee@huawei.com>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.68.30]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
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
---
 hw/cxl/cxl-host.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f3479b1991..9633b01abf 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -168,8 +168,6 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     bool target_found;
     PCIDevice *rp, *d;
 
-    /* Address is relative to memory region. Convert to HPA */
-    addr += fw->base;
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
@@ -254,7 +252,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         *data = 0;
         /* Reads to invalid address return poison */
@@ -271,7 +269,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         /* Writes to invalid address are silent */
         return MEMTX_OK;
-- 
2.43.0


