Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CACC35FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4gH-0005g0-3Q; Fri, 14 Mar 2025 09:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g7-0005cI-DK
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g4-0005vT-GY
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBlst4009830;
 Fri, 14 Mar 2025 13:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=3aMLsbbFjV3BiCrGzjIAQWwtGbk1T5xubdE17SUMzcQ=; b=
 Q8JxCjqTjP/oijKGTW4OzoT11OqiWftl1PSZs36XIp00lliIPhTLghTDigyX+xI/
 FEsfbbvfqhIwgnNzswQjUZVbJkuzEM1ZCg02aiqNaG7iokVPnze/Y8HYABhjfYCt
 /s1OG6Z7hOkg7p3SdQh7FXsVDge/IZaar9i1VvS9MxQ95L3TUmP7bcOWSx9mflCy
 Vz63HcEZbMF7VO7NzwjLowqdB1ReWTH4WjS5ZkPOxYZ8CcTAk4rS2zNHeSkStubl
 PQhBZZuT/f3n5VFo1SP26A3HWqizNO0rmmAHvdmmq47VKEMpKmB3WOQdMiUYJ50K
 OhcL9jUEOCzyXK6UM0mChA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dxcam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52ECLnQV012115; Fri, 14 Mar 2025 13:02:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn41d2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52ED27RB015104;
 Fri, 14 Mar 2025 13:02:09 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-73-135.usdhcp.oraclecorp.com [10.43.73.135])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 45atn41d05-3; Fri, 14 Mar 2025 13:02:09 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 jasowant@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v3 2/7] vdpa: reorder vhost_vdpa_set_backend_cap
Date: Fri, 14 Mar 2025 09:01:49 -0400
Message-ID: <20250314130204.11380-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314130204.11380-1-jonah.palmer@oracle.com>
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140103
X-Proofpoint-GUID: U3AAx-mbgu7jFyieS11i7CMNAFd7q9Z_
X-Proofpoint-ORIG-GUID: U3AAx-mbgu7jFyieS11i7CMNAFd7q9Z_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

It will be used directly by vhost_vdpa_init.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 60 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7efbde3d4c..79224d18d8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -596,6 +596,36 @@ static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
     v->shadow_vqs = g_steal_pointer(&shadow_vqs);
 }
 
+static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
+{
+    struct vhost_vdpa *v = dev->opaque;
+
+    uint64_t features;
+    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
+        0x1ULL << VHOST_BACKEND_F_SUSPEND;
+    int r;
+
+    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
+        return -EFAULT;
+    }
+
+    features &= f;
+
+    if (vhost_vdpa_first_dev(dev)) {
+        r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
+        if (r) {
+            return -EFAULT;
+        }
+    }
+
+    dev->backend_cap = features;
+    v->shared->backend_cap = features;
+
+    return 0;
+}
+
 static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 {
     struct vhost_vdpa *v = opaque;
@@ -843,36 +873,6 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
     return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 }
 
-static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
-{
-    struct vhost_vdpa *v = dev->opaque;
-
-    uint64_t features;
-    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
-        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
-        0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
-        0x1ULL << VHOST_BACKEND_F_SUSPEND;
-    int r;
-
-    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
-        return -EFAULT;
-    }
-
-    features &= f;
-
-    if (vhost_vdpa_first_dev(dev)) {
-        r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
-        if (r) {
-            return -EFAULT;
-        }
-    }
-
-    dev->backend_cap = features;
-    v->shared->backend_cap = features;
-
-    return 0;
-}
-
 static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
                                     uint32_t *device_id)
 {
-- 
2.43.5


