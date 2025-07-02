Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6575EC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U2-0003Qw-23; Wed, 02 Jul 2025 17:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tx-0003Nh-TL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tv-0003f8-UL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQf1O014606;
 Wed, 2 Jul 2025 21:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ehCcTDGAG4j8kMpCcv3xI8gmUfFjPYOpVSgaQEk9CUM=; b=
 ry6lIBuBQ54c7gPR3XUik9w95ZPgcu1lGpGN/qTXjwAz8sUSmm1lQoDA30RXvoop
 kMW4JfhpI58QuYScHIsHMAwa/DY4aGWqyV15V+VNlT0NHLt2do1vbRE9K94QrPRC
 PHiY+nmUT+nDKxOertwmgQiAqeExnBC5zb67Ufy0a4IbYrmsClAlfImHJ4z4UgDJ
 T4KqboLkzTXj4Kjm1OYGAyD8AyUCMhjVAXpvaeYIKLHH5uD4rH5cO/H/nnGcdUz4
 J4TEkskQPONpdG2T14i3wEUUCDEeYVkJvHWZwNX5EOQUHZjrlJTEgm999jtoMb/9
 I4EDQf0eWFHpqA1da2lrsQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx7vcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562KdmBR034387; Wed, 2 Jul 2025 21:59:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:04 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxg6020012;
 Wed, 2 Jul 2025 21:59:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-7; Wed, 02 Jul 2025 21:59:03 +0000
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
Subject: [PATCH V6 06/21] backends/iommufd: change process ioctl
Date: Wed,  2 Jul 2025 14:58:43 -0700
Message-Id: <1751493538-202042-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX8cXd7tmNrAhW
 wyUvRPyrB0MPFB7hQ9P0kjmBHcEaJptT/5gkvjL21IZY2rtD3qMdB7Yc5JDm1XS3KwJBP1S78Hc
 ecvgVauFuOLu1hLdnfu9ZpsR4b0fPBJhNqHk03XazQkO16yoGmDtxnCXTla2Ys04zSjOPhC7G7k
 XX24YtLlFULMkYdL8IlbF2142qreZkHDCozr7pyLepf3IQ3IV9iCy9F6X/F6VlfjI7A5A9/AL5B
 0Rv5xoEnd7mFXhMJxWBGixqUUtbyGzHECoPc5WBsEWaOUYbzlnkj3hacW4LuNT8XpQVAheCirKG
 KiCVZWFKcxJyXOzMbAKPgwk6Ur93sa7DZJHMMQrUrVWZ/YzVyfbyucVg8Z/nRVDzSJ9QlayEuNd
 tYTAJ+ohJym96dT1aED/xyt27eO7SFLkV06k4I0z7Js904Kos4QptErJuDdmmuStd5Vt4g9O
X-Proofpoint-ORIG-GUID: jO_WGt1Ti3Jgf6BkzY_XUjaMju_pHgfQ
X-Proofpoint-GUID: jO_WGt1Ti3Jgf6BkzY_XUjaMju_pHgfQ
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6865aba9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=SRdfyBftnUHxAk-46XYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h |  3 +++
 backends/iommufd.c       | 24 ++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 28 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 2d24d93..db5f2c7 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -69,6 +69,9 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       uint32_t *entry_num, void *data,
                                       Error **errp);
 
+bool iommufd_change_process_capable(IOMMUFDBackend *be);
+bool iommufd_change_process(IOMMUFDBackend *be, Error **errp);
+
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
                     HOST_IOMMU_DEVICE_IOMMUFD)
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 3a2ecc7..87f81a0 100644
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
index e5f3e70..56132d3 100644
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


