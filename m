Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E01C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7Nq-0003Xp-RO; Thu, 22 May 2025 10:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Np-0003WB-71
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:58:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nm-0004gP-DX
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:58:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEuXQl008753;
 Thu, 22 May 2025 14:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=9NTsKDdk0NbWu2D+ldb9e9+9idlkeDoHsxuccsCLv0g=; b=
 JPYWk5TpKlMdO0uYy4ndWk4PQzKrG2B2UdthKpOuYN05STsGvrXMSw2pJKXVlSAU
 is8mDUpKpMN4DSceDibgp9kzNx5LjJxSKn8D1LVvZp3q/8fIBxHVKHFr5Im3BctR
 yKMbgvUDwTn7qRw9x9adN74WpiWyIeiQQSwWm1Mt/x2Aq4ZYdGfRlwrAApCzIjCT
 K+giag1j64L5XzN9tBc9FWpupDzCNvo11KTT/taIlQ3u0FHAXGNEfDii7AMAZOyT
 QQBEHkEvU15vhoS5LLvygHCmM4nMNk9JAKHZELzHy86O55nv/pXY29/xQkjgXodp
 zHd6LXUEPK3nuVtFc7N2sA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5fug5h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MEV3Iw034614; Thu, 22 May 2025 14:58:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwer990u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54MEwiTx010227;
 Thu, 22 May 2025 14:58:46 GMT
Received: from dhcp-10-43-71-124.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-124.usdhcp.oraclecorp.com [10.43.71.124])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46rwer98yj-3; Thu, 22 May 2025 14:58:46 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
Subject: [PATCH v5 2/7] vdpa: reorder vhost_vdpa_set_backend_cap
Date: Thu, 22 May 2025 10:58:34 -0400
Message-ID: <20250522145839.59974-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522145839.59974-1-jonah.palmer@oracle.com>
References: <20250522145839.59974-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505220152
X-Proofpoint-GUID: 6ovEj7H4NwvZZhoFFEixpWdC0sE4krro
X-Proofpoint-ORIG-GUID: 6ovEj7H4NwvZZhoFFEixpWdC0sE4krro
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1MiBTYWx0ZWRfX55hT2mQHKGOL
 6wQvW34iVztQGr7l4L80xaITqDj9TpMe1JWpax8eLqJDesKh39jBdwmsgNZT8W475A6X5zTxAfZ
 +EUnZJp3ArN1BDIPANM9rX7qoEYe1hLihogM8bn078ITeWo4ExMEdBtivH3OmCHvCeLR12838TT
 4HrdB4DArALMZT3PtyPfVovFb94Td6ENF/GgeB1MzP6Tj154NKKlem/pz6KB368+9fKcKQILVf1
 L1/wLq6rORKcqJCaxvjY2Uce5IrPLuLUTT+Ii2voBEfU1AjrGtwWHgmBFmGt5ZsIn0ntsIvNbqe
 ffPkRaYs6xSMWB14reCtbOIcUzIg27EIVBn9NEt55Vqm0Tdqeg8HX8ZZTPGaci5VTbNW82Ni6wm
 cKbzdZn5ClT1FJK5UAAvybQ7n2/Jn4ponOFHBMowoCvRLUnt7O+ZDnQUiI3/H6rQ5DqLSqMy
X-Authority-Analysis: v=2.4 cv=CMQqXQrD c=1 sm=1 tr=0 ts=682f3ba8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=9uU6UdUwUmv73zic5QwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
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

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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


