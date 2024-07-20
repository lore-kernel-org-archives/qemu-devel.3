Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2E5C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZE-0007Qs-DS; Sat, 20 Jul 2024 15:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFZ5-0006vb-Bw
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFZ1-0000rd-Ai
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJA1iN020362;
 Sat, 20 Jul 2024 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=OdD3Vh8VrBj3S8FDaAY/ddgO1Ru7HGoZ8kU+j7nwgqM=; b=
 MkGw3BT8JObh76hShs77BNb2yezr3TSl+Ix0Ox8vLM4MnuvKS+AeuEjRLHk/Q9lS
 PF49nCSodj1HFXx1FHElJc/7dbC9dOxJcWhfio8Po4foLa5vzWTCrtRlUzaqFQJb
 eqgSKguaEIyvw/cEs+gFRs9xWQX4ECKOS2wRB5dWZx7IMVXcV9cCOS20G/CL9aGE
 XHFTrWtDvORNhOxFYK6J/PjFILbz0JMLX9u0Cn7LAUwVJBtgFoxOqNTvDAx7HXef
 9VR6wyEBwBDEeqq3/aLZBfKHqZO8q+/6rgZr+RViXLWHopXX5RFiYlCjjWeyuID6
 zze6xXnQJLAeSgTNWKvycQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5gr05c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KI0Q70027478; Sat, 20 Jul 2024 19:15:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5puwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:55 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdfN028365;
 Sat, 20 Jul 2024 19:15:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-12; Sat, 20 Jul 2024 19:15:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 11/12] iommufd: update DMA virtual addresses
Date: Sat, 20 Jul 2024 12:15:36 -0700
Message-Id: <1721502937-87102-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: ZoasZSdLt6aXDvSLHjc8bEeQB4d9So3o
X-Proofpoint-ORIG-GUID: ZoasZSdLt6aXDvSLHjc8bEeQB4d9So3o
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Register a vmstate post_load handler to call IOMMU_IOAS_CHANGE_PROCESS and
update the virtual address of all DMA mappings after CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 86fd9db..2e72b6f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -17,7 +17,9 @@
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
 #include "migration/cpr.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
+#include "exec/ramblock.h"
 #include "trace.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
@@ -81,6 +83,83 @@ bool iommufd_change_process_capable(IOMMUFDBackend *be)
     return (errno != ENOTTY);
 }
 
+static int iommufd_change_process(IOMMUFDBackend *be,
+                                 struct iommu_ioas_change_process *args)
+{
+    int ret, fd = be->fd;
+
+    ret = ioctl(fd, IOMMU_IOAS_CHANGE_PROCESS, args);
+    if (ret) {
+        ret = -errno;
+        error_report("IOMMU_IOAS_CHANGE_PROCESS failed: %m");
+    }
+    return ret;
+}
+
+static int count_umap(RAMBlock *rb, void *opaque)
+{
+    if (qemu_ram_is_migratable(rb)) {
+        (*(int *)opaque)++;
+    }
+    return 0;
+}
+
+static int fill_umap(RAMBlock *rb, void *opaque)
+{
+    if (qemu_ram_is_migratable(rb)) {
+        struct iommu_ioas_change_process *args = opaque;
+        struct iommu_ioas_userspace_map *umap = (void *)args->umap;
+        int i = args->n_umap++;
+
+        assert(rb->host_old && rb->host);
+        umap[i].addr_old = (__u64)rb->host_old;
+        umap[i].addr_new = (__u64)rb->host;
+        umap[i].size = rb->max_length;
+    }
+    return 0;
+}
+
+static int cmp_umap(const void *elem1, const void *elem2)
+{
+    const struct iommu_ioas_userspace_map *e1 = elem1;
+    const struct iommu_ioas_userspace_map *e2 = elem2;
+
+    return (e1->addr_old < e2->addr_old) ? -1 :
+           (e1->addr_old > e2->addr_old);
+}
+
+static int iommufd_cpr_post_load(void *opaque, int version_id)
+{
+    IOMMUFDBackend *be = opaque;
+    struct iommu_ioas_change_process args = {
+        .size = sizeof(args),
+        .flags = 0,
+        .n_umap = 0,
+        .umap = 0,
+    };
+    int n = 0;
+    g_autofree struct iommu_ioas_userspace_map *umap = NULL;
+
+    RCU_READ_LOCK_GUARD();
+    qemu_ram_foreach_block(count_umap, &n);
+    umap = g_malloc_n(n, sizeof(*umap));
+    args.umap = (__u64)umap;
+    qemu_ram_foreach_block(fill_umap, &args);
+    qsort(umap, args.n_umap, sizeof(*umap), cmp_umap);
+    return iommufd_change_process(be, &args);
+}
+
+static const VMStateDescription iommufd_cpr_vmstate = {
+    .name = "iommufd",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .post_load = iommufd_cpr_post_load,
+    .needed = cpr_needed_for_reuse,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, const char *name, Error **errp)
 {
     int fd;
@@ -100,7 +179,7 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, const char *name, Error **errp)
         be->fd = fd;
     }
     be->users++;
-
+    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
     trace_iommufd_backend_connect(be->fd, be->owned, be->users);
     return true;
 }
-- 
1.8.3.1


