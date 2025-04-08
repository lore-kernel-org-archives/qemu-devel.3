Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C89C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28HU-0005FZ-DU; Tue, 08 Apr 2025 08:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u28Gc-000500-H2; Tue, 08 Apr 2025 08:41:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u28Ga-0003LU-Iv; Tue, 08 Apr 2025 08:41:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5383l7iH030590;
 Tue, 8 Apr 2025 12:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qkffYc3WRNkToOyQA
 lH8U4o8zXaA0caSj22NjnTwEiI=; b=gJ5S2ILd//JGMvhz/5MFrJSWN+oaKMaou
 5Wlw/ZHpOm7HJzCm9nGPAoqGZYKKvb73iU91Kn+wi1vTGiPK/r06UHNPRyTC1/7Q
 at7SwBAioBtYmKRU7TYdHHIZOvVTBbkfu3k+O4kF9yWWdvR4BGtK1xWhEmfWzkRp
 qyvc1iy5LUkGmnYNxh5qcKZ2xwSg/LrUaxVdPmVQ+Lmn9HERiHfSNlkj8sVg+bGA
 AMcdvXfQB3m3kPgQet7uv+gVOeuftTfNWcorzE+8vBNdrr4GvKuAit1vXxTCs/Mc
 3WfJdLamAl46G+c1E/EKobWVQ0OM7wBVigUZgZGegWCEihJuhaNrQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a2a05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 538CU6wa021367;
 Tue, 8 Apr 2025 12:41:22 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a2a02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538BUt2V024605;
 Tue, 8 Apr 2025 12:41:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutauh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538CfHEd49283526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 12:41:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFBA520040;
 Tue,  8 Apr 2025 12:41:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A5D62004D;
 Tue,  8 Apr 2025 12:41:15 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.in.ibm.com (unknown
 [9.109.198.22]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 12:41:15 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 2/2] vfio/spapr: Fix L2 crash with PCI device passthrough
 and memory > 128G
Date: Tue,  8 Apr 2025 18:10:42 +0530
Message-ID: <20250408124042.2695955-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
References: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BBTdBGAxrYCwlsCCpACmA3UsHPg7wYz8
X-Proofpoint-GUID: g8f8brxx3lcaF8vLAkmUKS9Cj1PaRHSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_04,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080088
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

An L2 KVM guest fails to boot inside a pSeries LPAR when booted with a
memory more than 128 GB and PCI device passthrough. The L2 guest also
crashes when it is booted with a memory greater than 128 GB and a PCI
device is hotplugged later.

The issue arises from a conditional check for `levels > 1` in
`spapr_tce_create_table()` within L1 KVM. This check is meant to prevent
multi-level TCEs, which are not supported by the PowerVM hypervisor. As
a result, when QEMU makes a `VFIO_IOMMU_SPAPR_TCE_CREATE` ioctl call
with `levels > 1`, it triggers the conditional check and returns
`EINVAL`, causing the guest to crash with the following errors:

 2025-03-04T06:36:36.133117Z qemu-system-ppc64: Failed to create a window, ret = -1 (Invalid argument)
 2025-03-04T06:36:36.133176Z qemu-system-ppc64: Failed to create SPAPR window: Invalid argument
 qemu: hardware error: vfio: DMA mapping failed, unable to continue

Fix this by checking the supported DDW "levels" returned by the
VFIO_IOMMU_SPAPR_TCE_GET_INFO ioctl before attempting the TCE create
ioctl in KVM.

The patch has been tested on KVM guests with memory configurations of up
to 390GB, and 450GB on PowerVM and bare-metal environments respectively.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/vfio/spapr.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index dd9207679dbe..32611096fa29 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -26,6 +26,7 @@ typedef struct VFIOSpaprContainer {
     VFIOContainer container;
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
+    unsigned int levels;
 } VFIOSpaprContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
@@ -236,9 +237,11 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
 {
     int ret = 0;
     VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
-    unsigned entries, bits_total, bits_per_level, max_levels;
+    unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
     long rampagesize = qemu_minrampagesize();
 
@@ -291,16 +294,29 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
      */
     bits_per_level = ctz64(qemu_real_host_page_size()) + 8;
     create.levels = bits_total / bits_per_level;
-    if (bits_total % bits_per_level) {
-        ++create.levels;
-    }
-    max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
-    for ( ; create.levels <= max_levels; ++create.levels) {
-        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-        if (!ret) {
-            break;
+
+    ddw_levels = scontainer->levels;
+    if (ddw_levels > 1) {
+        if (bits_total % bits_per_level) {
+            ++create.levels;
         }
+        max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
+        for ( ; create.levels <= max_levels; ++create.levels) {
+            ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+            if (!ret) {
+                break;
+            }
+        }
+    } else { /* ddw_levels == 1 */
+        if (create.levels > ddw_levels) {
+            error_setg_errno(errp, EINVAL, "Host doesn't support multi-level TCE tables"
+                             ". Use larger IO page size. Supported mask is 0x%lx",
+                             bcontainer->pgsizes);
+            return false;
+        }
+        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
     }
+
     if (ret) {
         error_setg_errno(errp, errno, "Failed to create a window, ret = %d", ret);
         return false;
@@ -501,6 +517,8 @@ static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         goto listener_unregister_exit;
     }
 
+    scontainer->levels = info.ddw.levels;
+
     if (v2) {
         bcontainer->pgsizes = info.ddw.pgsizes;
         /*
-- 
2.49.0


