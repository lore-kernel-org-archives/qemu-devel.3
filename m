Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869A3C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBA-00078b-7Y; Mon, 12 May 2025 11:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9p-0004pD-PW
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9m-0006iK-66
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9epU017588;
 Mon, 12 May 2025 15:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=xD851tFbIu6/FigOsz3RBUEYuTHzt1g8S7vY2ew/DOI=; b=
 FECEfR7qM2LxDivtvek0MG55gllpGYcrr1Aa8E9rO0sKlym/HzbImsIOiGY4sL91
 KtOqqqM8Iwk4A7WZCRAPxIXVnlHVJg7FclQcQAsxnLPdETHLvyaQ39IBybzz1bRr
 eCDQTBgXsv5y/QbyKaetC28bfHAAQp/45JifN2WR22hlHgP6Se/3ioBW6QRlmEf0
 qpLFWfjRdd2Y4dWbIarUYb6ZPX2Zur9fnjXpR0LbXFDi8cBzeudPHWjRO3N4UG80
 ytRmdEbSMn4BHcCUQW7PdBzHUt3vccaTWHYnywC4XkWvH/U5Ar7OwhE8gL2Prjtm
 GDFMO0ySB7EmjiTZ4yCVAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059tvg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEDNtV002472; Mon, 12 May 2025 15:33:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5a030605;
 Mon, 12 May 2025 15:33:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-30; Mon, 12 May 2025 15:33:16 +0000
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
Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
Date: Mon, 12 May 2025 08:32:40 -0700
Message-Id: <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXwWkXg8JTfN/b
 ua7WXzmPlL5F1XfNBXeVc9Vpfoia46JuQGIUb0MBQK8LSOLvxDqWzQHDL8o+LoPNzBp4pYECbiV
 Vw1FfcHk1jeEkPGRVxw5hb0D2J5WjV+hs4vb/ZihMi+bHZN74lm/DRMDkqivUHkO2tjpVjN0ogs
 1SvtadkMvrdBJ7kCnIlMvWnyTOLrB3Fm1SmRvV80mmpZutgzPbWe0mZ8uUERLkQSFKypiXcilJp
 u6otgzn6yyotGWJGaUZVZqQP8DBJ/839GvRLKwuhl8jyX7ZEI2y89XcTla9UotN6RnVBftm6V+z
 H8dTngKe9gcIL52DdKB87v6iLrYCim3kl1kqY9LLOxJgXnf4CYEgcs4dgK1OBRiLsC+uedKg69I
 rmcWFbz0LDzjHL369cT+x93OIglJjai3Zw+Uu7z9/tEHppMVg49BbesRZ/ixQ4tWqYnUeBIW
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682214bd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=FVaVBuMrEvrw9pPjr9AA:9
X-Proofpoint-ORIG-GUID: axt1GeHNinzKLtx9jhq2Mr0_XYiq0WDN
X-Proofpoint-GUID: axt1GeHNinzKLtx9jhq2Mr0_XYiq0WDN
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

Define the change process ioctl

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c       | 20 ++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 5c1958f..6fed1c1 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
 
+bool iommufd_change_process_capable(IOMMUFDBackend *be)
+{
+    struct iommu_ioas_change_process args = {.size = sizeof(args)};
+
+    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
+}
+
+bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
+{
+    struct iommu_ioas_change_process args = {.size = sizeof(args)};
+    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
+
+    if (!ret) {
+        error_setg_errno(errp, errno, "IOMMU_IOAS_CHANGE_PROCESS fd %d failed",
+                         be->fd);
+    }
+    trace_iommufd_change_process(be->fd, ret);
+    return ret;
+}
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 {
     int fd;
diff --git a/backends/trace-events b/backends/trace-events
index f478e18..5ccdf90 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
 dbus_vmstate_saving(const char *id) "id: %s"
 
 # iommufd.c
+iommufd_change_process(int fd, bool ret) "fd=%d (%d)"
 iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
 iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
 iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index ac700b8..db9ed53 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -64,6 +64,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       uint64_t iova, ram_addr_t size,
                                       uint64_t page_size, uint64_t *data,
                                       Error **errp);
+bool iommufd_change_process_capable(IOMMUFDBackend *be);
+bool iommufd_change_process(IOMMUFDBackend *be, Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
-- 
1.8.3.1


