Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C25C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 21:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEbeV-0006IP-Ax; Tue, 04 Jun 2024 17:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sEbeP-0006Gp-2y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:25:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sEbeK-00056n-Gb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:25:00 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240604212444epoutp03d17e2e259506a875943809c1786f01d0~V6iaQYYO80208402084epoutp031
 for <qemu-devel@nongnu.org>; Tue,  4 Jun 2024 21:24:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240604212444epoutp03d17e2e259506a875943809c1786f01d0~V6iaQYYO80208402084epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1717536284;
 bh=TnXiYs2/k0Gc5aoNkCHwoW4SIGaIOXDxVlVQ5gb3zzU=;
 h=From:To:Cc:Subject:Date:References:From;
 b=ig5PnWV6yX5lXL4tvkVN4WRX4jA1idHPYgOqcSGIe6GWRYhUVRNJhYMwjX9efk+F/
 1v3cfYJv48SjDKFtvV16ev7BaNFVGZgqiixswfy6qwUqhFAelFikkEgXm7hkuaZhB+
 ZmIKbC7aq9jU3UECu6XwkO4N2gm8x8T6ika002Hk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240604212443epcas2p4b2f57d3e6e480bd370fcf5aa2ef3ee25~V6iZkcsj_1976819768epcas2p4D;
 Tue,  4 Jun 2024 21:24:43 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Vv3Wt5dMzz4x9Pr; Tue,  4 Jun
 2024 21:24:42 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.B3.18956.A168F566; Wed,  5 Jun 2024 06:24:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240604212442epcas2p19b786aa21b03d671b7b5cf7857ce24bd~V6iYV5Wtd2618526185epcas2p1t;
 Tue,  4 Jun 2024 21:24:42 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240604212442epsmtrp1b1f2e8afdc6250ee298309ea971651ce~V6iYVUEH40159401594epsmtrp1l;
 Tue,  4 Jun 2024 21:24:42 +0000 (GMT)
X-AuditID: b6c32a4d-f95ff70000004a0c-cf-665f861a5366
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D1.07.07412.A168F566; Wed,  5 Jun 2024 06:24:42 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240604212442epsmtip10c40bb4138a711686c0328859df4e01f~V6iYKQjNk2749727497epsmtip16;
 Tue,  4 Jun 2024 21:24:42 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Minwoo Im
 <minwoo.im@samsung.com>, gost.dev@samsung.com
Subject: [PATCH] hw/nvme: fix BAR size mismatch of SR-IOV VF
Date: Wed,  5 Jun 2024 06:13:06 +0900
Message-Id: <20240604211306.2155791-1-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmma5UW3yawYxX6hY3D+xksth/8Bur
 xaRD1xgtnp0+wGwx6107m8Xx3h0sDmwe53acZ/fYtKqTzePJtc1MHn1bVjEGsERl22SkJqak
 Fimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVdSKEvMKQUKBSQW
 Fyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGec72EpWCtd
 cW37efYGxskiXYycHBICJhK7Jsxm7GLk4hAS2MMosaejhQnC+cQosezNQyaQKiGBb4wSax9a
 wHQ0z1nADFG0l1Hi5s7fUO2/GSU+P7nBClLFJqAu0TD1FQuILSLgKnFt+QR2EJtZIFviaddC
 sLiwgI1ES+ddsA0sAqoSp682g/XyAsW3rbzGDLFNXmL/wbPMEHFBiZMzn7BAzJGXaN46G6pm
 F7tE5/F8CNtFYsKhbywQtrDEq+Nb2CFsKYmX/W1QdrnEzzeTGCHsComDs26zdTFyANn2Etee
 p4CYzAKaEut36UNElSWO3IJayifRcfgvO0SYV6KjTQhihrLEx0OHoG6RlFh+6TUbhO0hsWFG
 HzskBGMlHtybyTyBUX4WkldmIXllFsLeBYzMqxilUguKc9NTk40KDHXzUsvhkZqcn7uJEZwA
 tXx3ML5e/1fvECMTB+MhRgkOZiURXr/i+DQh3pTEyqrUovz4otKc1OJDjKbAAJ7ILCWanA9M
 wXkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTA5XnT+pM0S/fGs
 sPY37U3cMqVMnTtL2M3T7+0LNGi0sJOX5Zuu+TeZUdXSb+H/OOa9T22Fvl2bHzif//TyqU5t
 ES37Wp9Nd93U8O3SfOaNK8Mbc3Pn1ep732M/HflLSpbxTbSwrNiyZKWq/4ohbfKqyhEbLAS/
 xGmzhnC6Gnza/1GgNF8hY5v33R1p81T76yQDldx33HRYcGvjtVNX3jw/+uni7wxxEc/zPG9k
 jF1WHcsW2nF8ubZvR0LsrwvNO566vvNRLFmUW6EX97vgsOnMXSuMTUVfLz/9+VNT9YTw8hXa
 r21un3z39NsdgStas5cuc071Onhb+67DZ9YXNq1T46xLY0/Ov/lyqv6+3BVKLMUZiYZazEXF
 iQBh+CiQCQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnK5UW3yawefd7BY3D+xksth/8Bur
 xaRD1xgtnp0+wGwx6107m8Xx3h0sDmwe53acZ/fYtKqTzePJtc1MHn1bVjEGsERx2aSk5mSW
 pRbp2yVwZZzvYSlYK11xbft59gbGySJdjJwcEgImEs1zFjCD2EICuxkl/m2rgohLSuw7fZMV
 whaWuN9yBMjmAqr5ySix7etPFpAEm4C6RMPUV2C2iIC7xPNnH5lAbGaBfIkZ09eBDRUWsJFo
 6bwLFmcRUJU4fbUZbCgvUHzbymvMEAvkJfYfPMsMEReUODnzCQvEHHmJ5q2zmScw8s1CkpqF
 JLWAkWkVo2RqQXFuem6yYYFhXmq5XnFibnFpXrpecn7uJkZwQGpp7GC8N/+f3iFGJg7GQ4wS
 HMxKIrx+xfFpQrwpiZVVqUX58UWlOanFhxilOViUxHkNZ8xOERJITyxJzU5NLUgtgskycXBK
 NTDl8E1i+rnk4gzLe6Fr+47+jc0rlKup4bXezfjhdMLuW1dTxCf11umU+F8SW7KnhOXl/g26
 2ftFCrMXGsm8XncgeZqvvN/XE79tLn5w2D2jTvdI0vJW5d49vc9+WQQueV489fjMPM6W0q8q
 s23fFUm4Z16cy2x14ozmkpPfFHN3iLyU9Zy8mvGnxgan5AC1xOD7zPt1H2seX1vJ/7HmnPu2
 3e2ifVnvUtxWcKR3nm288Y7Bza0+PpblajN3wrWzAZrrSq/tPKm5f9ZOs0OPMwr2+rzl7l/8
 qfD7zrLnK5wKn3fvqTAx+fiTx3FPmnvxtJeTds9aeTF40ZEL5WsZT11WLJSc3cnN9P/OIum5
 vzt/KLEUZyQaajEXFScCAHXIade3AgAA
X-CMS-MailID: 20240604212442epcas2p19b786aa21b03d671b7b5cf7857ce24bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240604212442epcas2p19b786aa21b03d671b7b5cf7857ce24bd
References: <CGME20240604212442epcas2p19b786aa21b03d671b7b5cf7857ce24bd@epcas2p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=minwoo.im@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PF initializes SR-IOV VF BAR0 region in nvme_init_sriov() with bar_size
calcaulted by Primary Controller Capability such as VQFRSM and VIFRSM
rather than `max_ioqpairs` and `msix_qsize` which is for PF only.

In this case, the bar size reported in nvme_init_sriov() by PF and
nvme_init_pci() by VF might differ especially with large number of
sriov_max_vfs (e.g., 127 which is curret maximum number of VFs).  And
this reports invalid BAR0 address of VFs to the host operating system
so that MMIO access will not be caught properly and, of course, NVMe
driver initialization is failed.

For example, if we give the following options, BAR size will be
initialized by PF with 4K, but VF will try to allocate 8K BAR0 size in
nvme_init_pci().

	#!/bin/bash

	nr_vf=$((127))
	nr_vq=$(($nr_vf * 2 + 2))
	nr_vi=$(($nr_vq / 2 + 1))
	nr_ioq=$(($nr_vq + 2))

	...

	-device nvme,serial=foo,id=nvme0,bus=rp2,subsys=subsys0,mdts=9,msix_qsize=$nr_ioq,max_ioqpairs=$nr_ioq,sriov_max_vfs=$nr_vf,sriov_vq_flexible=$nr_vq,sriov_vi_flexible=$nr_vi \

To fix this issue, this patch modifies the calculation of BAR size in
the PF and VF initialization by using different elements:

	PF: `max_ioqpairs + 1` with `msix_qsize`
	VF: VQFRSM with VIFRSM

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..57bc26034c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8093,6 +8093,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     uint8_t *pci_conf = pci_dev->config;
     uint64_t bar_size;
     unsigned msix_table_offset = 0, msix_pba_offset = 0;
+    unsigned nr_vectors;
     int ret;
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
@@ -8125,9 +8126,19 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         assert(n->params.msix_qsize >= 1);
 
         /* add one to max_ioqpairs to account for the admin queue pair */
-        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
-                                  n->params.msix_qsize, &msix_table_offset,
-                                  &msix_pba_offset);
+        if (!pci_is_vf(pci_dev)) {
+            nr_vectors = n->params.msix_qsize;
+            bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
+                                      nr_vectors, &msix_table_offset,
+                                      &msix_pba_offset);
+        } else {
+            NvmeCtrl *pn = NVME(pcie_sriov_get_pf(pci_dev));
+            NvmePriCtrlCap *cap = &pn->pri_ctrl_cap;
+
+            nr_vectors = le16_to_cpu(cap->vifrsm);
+            bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm), nr_vectors,
+                                      &msix_table_offset, &msix_pba_offset);
+        }
 
         memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
         memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
@@ -8141,7 +8152,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
                              PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
         }
 
-        ret = msix_init(pci_dev, n->params.msix_qsize,
+        ret = msix_init(pci_dev, nr_vectors,
                         &n->bar0, 0, msix_table_offset,
                         &n->bar0, 0, msix_pba_offset, 0, errp);
     }
-- 
2.34.1


