Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B2C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjnf-0001xm-8D; Wed, 07 May 2025 14:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnX-0001u1-Ss
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnW-0004qW-1M
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ILbKY019138;
 Wed, 7 May 2025 18:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=la7j4KwgDDMd6BfOwdeh1vSZ3z06AvboBMXIuIX4Gf4=; b=
 M/4q8sOaEPPv5m1jBDW4iC1EgyMmdp5Bf+MDF4zchwej2+zRkl7VyBFbssH8/Cd6
 0igFQy3nkrDD7HBxSWIBe23JorJW6CgeEOsoTJCfDuZGQH4Dhu4ITNRAef7k+lGp
 TOnlHtypH4rt9dPRZoY8xaXsCbBD5aJcc5Uk7uM+Qw2l5Ifeoq6qm/LMXZLFA0wG
 jJCwC2vSdd9lMLvVe8JohvcAfMYSLca2hHGwLtpQS6/ZeZAkNMy0+D5rBLMt43SV
 PIQUh046w8bn+0A28t/t2ldsjRLnWObvTjbKbATRQM03IU7o74aeCznTgufU63ei
 d7i0+ehvbu+mMgwxhji5sA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcqrg23b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 547IHcm7036209; Wed, 7 May 2025 18:47:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kbhd9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547Il3ix029452;
 Wed, 7 May 2025 18:47:09 GMT
Received: from dhcp-10-43-71-250.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-250.usdhcp.oraclecorp.com [10.43.71.250])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46d9kbhd41-3; Wed, 07 May 2025 18:47:09 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
Subject: [PATCH v4 2/7] vdpa: reorder vhost_vdpa_set_backend_cap
Date: Wed,  7 May 2025 14:46:42 -0400
Message-ID: <20250507184647.15580-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070170
X-Proofpoint-GUID: rlVdG7HUgehbiIcVQwEpOML4dJl-COwi
X-Authority-Analysis: v=2.4 cv=aJHwqa9m c=1 sm=1 tr=0 ts=681baaae cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=klAs07fV39KgZd8pya4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rlVdG7HUgehbiIcVQwEpOML4dJl-COwi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfXyNWqbE674G+0
 N+lVcySD25tgHEe1pk1LHsBsUzFfRLIPCxQ0ef44FrK+WjGFLeKDLgCwCMng736orii52H8vbJT
 KJHajgYHyvKwzSm91R2ZztdzPGEkuy892QiLqB7LGy8fSUIGeuX9QZlFmR9to8FRe4zm7eNNRoh
 MGxYU088+xVXZ/ONBXA0ybo7jab+GgYdVLjkOM0AxLv2rqOhscPOUcvPkOfULJGV9NAe6GwLML5
 kCMh/2e9r78rdS8+P+nFDjEBj5tn0VMCtO5kXFCarZ9yuugZtc59kFGV8lUED3dhPSLT0sN8Jj+
 0wGDXrbTQPKDCg8AEvBGYortAwcu3/bkHSFQYQ3f7KwYhmanqHeUfGrwncsoADiQskQjFwn2HMx
 f8hyweXTVDYKKRPSkLApoaPIe+k0+5Co774qAVjIkACkaYGmVC3eX1cvta+vTPZadz81k4wR
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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

From: Eugenio Pérez <eperezma@redhat.com>

It will be used directly by vhost_vdpa_init.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 60 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11fa8..6b242ca56a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -594,6 +594,36 @@ static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
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
@@ -841,36 +871,6 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
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


