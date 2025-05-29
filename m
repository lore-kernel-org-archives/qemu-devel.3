Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5D1C5B554
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisp-0004KW-8X; Thu, 29 May 2025 15:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisS-0004EQ-JP
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisQ-0000Qe-O5
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:20 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsP7028790;
 Thu, 29 May 2025 19:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=Ezs8pFU7u6mr9HKi+doQ8IAJEXnM/7B2bHtkYuLKJdI=; b=
 lrqZddy5ario+pn76iEJJgJOu8OfbWEtGA452fvuAmhUVixrnIZe/VplWY2p8Ndn
 tdTDL/5Ydy496dxb12rplvwFTyDEND8ageR2abRALf+g0N2bEGdmjreqlVai5dXA
 a9KctQdahHzi8lExykwU2KCHmvf5y2g0yEHwgpYIVhm3pkZr1qR69Hk4/eW1qbh1
 D+47oBI4LBfBRNa7zytWlmUQw1RK3zAQw0a0IsNtLLWRZVBeKUAIgVTnwafi/1GS
 Du2+yOK7DTjykR2RW2lkZl2AybYsmGOgZbryPcdcR0ErHAA8XHSGeLMBF2mhfP97
 WOND1HKw73fRqPLjr6BndA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd8qxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJKdNj020323; Thu, 29 May 2025 19:25:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRj022158;
 Thu, 29 May 2025 19:25:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-30; Thu, 29 May 2025 19:25:04 +0000
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
Subject: [PATCH V4 29/43] backends/iommufd: change process ioctl
Date: Thu, 29 May 2025 12:24:25 -0700
Message-Id: <1748546679-154091-30-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-ORIG-GUID: lZWJ1WuxxSeHlzCIrFj_rr9glU8uokZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX7cJ6HsLwyWdF
 NcqAhZ69IzcgDntF9PzL3yVoOHHgejaYfnS+eHG7iUXlBkqQr+3u/FBc93bhDTtulMiuBJACSi6
 BgCjQidfvzzAMO7sWasTrDh8n1xuje4VE2XaBGTq9DPBv1hMhL0yPIm21BvcNUgSCXcVIqAQsdA
 moQY+ufSFySUJE4WB4wab1Bjdbz1slPhjynOKtj7Xa6zgp6PZtmL7nqqDVCiK6uH/9cqZjK6etz
 JauFpVQJodd9scnYBvIzUj2e5X39lyG7q0Ht+zyX5xpfY+Zrs1LWdxfVkCHErkF9tp+nLWT+09p
 ps9aTYLD/0n/QxL/EuMtPBhIMMIsHgPqKj4yiBPqfU1a2bds6k0pyFpY+zouNS1ytopWfNxKGBB
 9t7syF69kXsBn71ugqDc5mkI0ABzBwOOVemRJ8oL5gZSKtsdOFfNOZLFePp5gMiPMB9pBH/O
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6838b491 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=t_67vrCysMhZ9VwvyEoA:9
X-Proofpoint-GUID: lZWJ1WuxxSeHlzCIrFj_rr9glU8uokZW
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
 include/system/iommufd.h |  2 ++
 backends/iommufd.c       | 24 ++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 27 insertions(+)

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
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 4f97b2c..ed8bb4c 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -73,6 +73,30 @@ static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
 
+bool iommufd_change_process_capable(IOMMUFDBackend *be)
+{
+    struct iommu_ioas_change_process args = {.size = sizeof(args)};
+
+    /*
+     * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
+     * This is a no-op if the process has not changed since DMA was mapped.
+     */
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
-- 
1.8.3.1


