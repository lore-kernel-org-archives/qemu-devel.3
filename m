Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98B8F0182B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyU2k-0005W5-Rd; Fri, 06 Mar 2026 07:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vyU2g-0005T1-RM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:12:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vyU2f-0007Bk-82
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:12:30 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS4y74FY9zHnHGN;
 Fri,  6 Mar 2026 20:11:27 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 3A3AC40585;
 Fri,  6 Mar 2026 20:12:27 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.206.167.72) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 12:12:26 +0000
To: <qemu-devel@nongnu.org>, <gourry@gourry.net>, <lizhijian@fujitsu.com>
CC: <alireza.sanaee@huawei.com>, <anisa.su887@gmail.com>, <armbru@redhat.com>, 
 <david@kernel.org>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>, 
 <linuxarm@huawei.com>, <mst@redhat.com>, <nifan.cxl@gmail.com>,
 <peterx@redhat.com>, <philmd@linaro.org>, <pbonzini@redhat.com>,
 <venkataravis@micron.com>, <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v7 1/3] hw/cxl: Use HPA in cxl_cfmws_find_device() rather than
 offset in window.
Date: Fri, 6 Mar 2026 12:11:49 +0000
Message-ID: <20260306121151.883-2-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260306121151.883-1-alireza.sanaee@huawei.com>
References: <20260306121151.883-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.206.167.72]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
device, serving an HPA, under a particular fixed memory window. Rather than
having that new use case subtract the base address in the caller, only to
add it again in cxl_cfmws_find_device(), push the responsibility for
calculating the HPA to the caller.

This also reduces the inconsistency in the meaning of the hwaddr addr
parameter between this function and the calls made within it that access
the HDM decoders that operating on HPA.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
Thanks to Li for the tag.
Change log:
v6->v7: No change.

 hw/cxl/cxl-host.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f3479b1991..a94b893e99 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -168,9 +168,6 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     bool target_found;
     PCIDevice *rp, *d;
 
-    /* Address is relative to memory region. Convert to HPA */
-    addr += fw->base;
-
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
@@ -254,7 +251,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base);
     if (d == NULL) {
         *data = 0;
         /* Reads to invalid address return poison */
@@ -271,7 +268,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base);
     if (d == NULL) {
         /* Writes to invalid address are silent */
         return MEMTX_OK;
-- 
2.43.0


