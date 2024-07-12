Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9151AC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGqw-0000xU-M9; Fri, 12 Jul 2024 10:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqu-0000ra-EZ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqs-0005va-KU
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDILPG023667;
 Fri, 12 Jul 2024 14:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=GNCx5dMy+PRyGVvp4jQJTfzVCcno1ZP9aVCm4n9/+/o=; b=
 IpHgFPM/faqX6xcrG8wBngp+z4ZmvBS/oHRS2AImo8xKlqXGW6vWPULIZxqfMvmy
 REegDku6ej/3Ba9UvuPZdTDAmfIZttcIqZGLXmd7+T12vmflWLxHTOWe9W9dskSW
 OlJjrYlvvr/8biWyhIDnheF41SVIbTT5KNtzYAfQSPD+u+zKPKgOazMJjzNYGz/q
 vr2R7HktJNJkFt+txgpLoSgC34CznTIVlkBhmyZkuj82Z/MkAMTMCccGK9eKIy2B
 4DsOrL6sMFrLUzbRcIR37zTdQrcQiQh4KAbvNr77X9q5MI3GZYJwW8EQlr4RD/sz
 0IQfWMZSSmj/NOVV9smqFA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt37un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CCDrL7010884; Fri, 12 Jul 2024 14:02:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74jxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DPw020438;
 Fri, 12 Jul 2024 14:02:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-6; Fri, 12 Jul 2024 14:02:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 5/7] vdpa/cpr: use VHOST_NEW_OWNER
Date: Fri, 12 Jul 2024 07:02:09 -0700
Message-Id: <1720792931-456433-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120094
X-Proofpoint-GUID: iNwx8GbM7VUm9GG7-ZReGUduC8NUMrsi
X-Proofpoint-ORIG-GUID: iNwx8GbM7VUm9GG7-ZReGUduC8NUMrsi
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

Block CPR if the kernel does not support VHOST_NEW_OWNER.
After CPR, call VHOST_NEW_OWNER in new QEMU.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/virtio/trace-events    |  1 +
 hw/virtio/vhost-vdpa.c    | 24 ++++++++++++++++++++++--
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3cf84e04a7..990c61be79 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -64,6 +64,7 @@ vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %p index:
 vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
 vhost_vdpa_get_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRIx64
 vhost_vdpa_set_owner(void *dev) "dev: %p"
+vhost_vdpa_new_owner(void *dev) "dev: %p"
 vhost_vdpa_vq_get_addr(void *dev, void *vq, uint64_t desc_user_addr, uint64_t avail_user_addr, uint64_t used_user_addr) "dev: %p vq: %p desc_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64
 vhost_vdpa_get_iova_range(void *dev, uint64_t first, uint64_t last) "dev: %p first: 0x%"PRIx64" last: 0x%"PRIx64
 vhost_vdpa_set_config_call(void *dev, int fd)"dev: %p fd: %d"
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..9e3f414ac2 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -769,6 +769,7 @@ static int vhost_vdpa_cleanup(struct vhost_dev *dev)
     vhost_vdpa_svq_cleanup(dev);
 
     dev->opaque = NULL;
+    migrate_del_blocker(&dev->cpr_blocker);
 
     return 0;
 }
@@ -848,13 +849,13 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
     uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
         0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
         0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
-        0x1ULL << VHOST_BACKEND_F_SUSPEND;
+        0x1ULL << VHOST_BACKEND_F_SUSPEND |
+        0x1ULL << VHOST_BACKEND_F_NEW_OWNER;
     int r;
 
     if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
         return -EFAULT;
     }
-
     features &= f;
 
     if (vhost_vdpa_first_dev(dev)) {
@@ -1360,6 +1361,18 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
     }
 
     if (started) {
+        /*
+         * Register a blocker the first time device is started (when we know
+         * its capabilities).
+         */
+        if (!dev->cpr_blocker &&
+            !(dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_NEW_OWNER))) {
+            error_setg(&dev->cpr_blocker, "vhost-vdpa: device does not support "
+                                          "VHOST_BACKEND_F_NEW_OWNER");
+            migrate_add_blocker_modes(&dev->cpr_blocker, &error_abort,
+                                      MIG_MODE_CPR_EXEC, -1);
+        }
+
         if (vhost_dev_has_iommu(dev) && (v->shadow_vqs_enabled)) {
             error_report("SVQ can not work while IOMMU enable, please disable"
                          "IOMMU and try again");
@@ -1518,10 +1531,17 @@ static int vhost_vdpa_get_features(struct vhost_dev *dev,
 
 static int vhost_vdpa_set_owner(struct vhost_dev *dev)
 {
+    struct vhost_vdpa *v = dev->opaque;
+
     if (!vhost_vdpa_first_dev(dev)) {
         return 0;
     }
 
+    if (v->shared->reused) {
+        trace_vhost_vdpa_new_owner(dev);
+        return vhost_vdpa_call(dev, VHOST_NEW_OWNER, NULL);
+    }
+
     trace_vhost_vdpa_set_owner(dev);
     return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
 }
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index d75faf46e9..3f1b802f85 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -133,6 +133,7 @@ struct vhost_dev {
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
+    Error *cpr_blocker;
 };
 
 extern const VhostOps kernel_ops;
-- 
2.39.3


