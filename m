Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01459C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9W-000401-A1; Mon, 12 May 2025 11:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9Q-0003nm-Bu
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9N-0006f2-FU
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fn8018644;
 Mon, 12 May 2025 15:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=2Nb8bmabzDuslm4J3z3Uoi4G2LWVc8CHTNEG0QfCqT4=; b=
 JjddceXrCbR9ebk6+o2BsFHaQS9dsyfWjApYAjtxwkUkp4Y63MtIngFlIFmWg+Qg
 aVJJUpLozTu0A+3cuCFyO5fO0JsHjjlBtcsI9NO+eizouRSobx0EFsFxuMG4YdP0
 C0FGoRaaIqp5ZUPqULZn8MqT7KvI0Z7yRzMkwdWO/SoBNyds1WS8+UubYNfv4AT+
 FM1oA57x7Zc5Bux+NY8b9lPzQOuaDCB832nOW6V5+6Im5Q+uhpgzVqk1+zTgKQOe
 SHPPAqelahLQU5spxEXicgwwiS/f/4wswmH59gDKzWzQlaRk/10K5xX8nbvFq5D3
 g9qmopr8SZ1zV/2yYyjKVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEDUb1002426; Mon, 12 May 2025 15:33:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3668c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:01 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4u030605;
 Mon, 12 May 2025 15:33:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-10; Mon, 12 May 2025 15:33:01 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 09/42] vfio/container: discard old DMA vaddr
Date: Mon, 12 May 2025 08:32:20 -0700
Message-Id: <1747063973-124548-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX3X9pFBcWVhjV
 NvAjV9/ghRyK9gY7+XADmVXekpm4kC7qEVCH+ve1/xVfQKx9ZHySlHsSw7QlN9Nj8r+8HUiEmRn
 fu52kXoCL1v2xUDgH5JkGTR8AjSmO+QBHmLG3NAJQmvVVecpI3bjGGjlkiSuJllDamVnavB2TT5
 LHwSzzXq4KxHe72V8ZL1dIg2yC7yefmglijNoI+yFfzMtwwKoez1QBuk0IqXYxVa6+IeplKfgEf
 r2xkYBcWsQ8YQM5GsKQf2J4795t4j8PMSCcH9povJzBiv9CxTTJfQnHZOYKvCuPpLHyBF5FPPo/
 jB5bZ87ggPvkygM9h1vfla/mBYaLLjHFG44fHNhku4/r9CDFyQZMAC0Pcwteu/5fD8sR2cH0BW5
 oMCp1zxnOxcRgJdfETBxpbDdWL3BpkmlyR8lnwhCzjHvBNuVcqulkikADHFvvddeOFRrrDS5
X-Proofpoint-GUID: T8MnjLAQowMigMRNS7iiG5L9qec_PL3u
X-Proofpoint-ORIG-GUID: T8MnjLAQowMigMRNS7iiG5L9qec_PL3u
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214ae b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=l9kVofuoYc9qIq1kHw0A:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the container pre_save handler, discard the virtual addresses in DMA
mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest RAM will be
remapped at a different VA after in new QEMU.  DMA to already-mapped
pages continues.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-legacy.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 638a8e0..519d772 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -17,6 +17,22 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
+static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
+{
+    struct vfio_iommu_type1_dma_unmap unmap = {
+        .argsz = sizeof(unmap),
+        .flags = VFIO_DMA_UNMAP_FLAG_VADDR | VFIO_DMA_UNMAP_FLAG_ALL,
+        .iova = 0,
+        .size = 0,
+    };
+    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
+        return false;
+    }
+    return true;
+}
+
+
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -32,6 +48,18 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
     }
 }
 
+static int vfio_container_pre_save(void *opaque)
+{
+    VFIOContainer *container = opaque;
+    Error *err = NULL;
+
+    if (!vfio_dma_unmap_vaddr_all(container, &err)) {
+        error_report_err(err);
+        return -1;
+    }
+    return 0;
+}
+
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
@@ -52,6 +80,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
-- 
1.8.3.1


