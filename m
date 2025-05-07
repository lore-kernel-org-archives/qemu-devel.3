Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBCBC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjnq-00020b-Lq; Wed, 07 May 2025 14:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnm-000201-7k
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnj-0004t1-Dt
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547IeVvr025473;
 Wed, 7 May 2025 18:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=eDFDHUqAjFCL04udO/G2fse0c6xX/zUkm9hxNtYER7E=; b=
 M5GR0SZwDHubKnkuHb4v/JOO++TgGuqUPEIWXyzTIoa2DkAI89G9ZdFWXU6+TNDL
 JiD3ErV0HluKq0pjaOGX/cjPJ5pdV7KZwffAFyRz7AWNxjCMY0I97C0VH13t977B
 aFEJ+6457S6xVG0lEFVf1Sl7FMqjkJOyoEZ/S6desXxSw3rQNxzPdBJxFf9c+t2L
 +IZ6QtsSfQjjRLRqES5WhXE8HkZjDZD8d85p9j/xSoJGSTJGlwnVDXlr9XbbxCuC
 z3jwMLF2YP1AF0RmNKGj/Iu+c3uj7/XIWLVGu++FCF2UhVS/qhAmt1fGCNt9UK6Y
 ZDCiQYBvuaxvmxf1RhCZBg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcgn029x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 547HVBuM036071; Wed, 7 May 2025 18:47:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kbhdgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547Il3j9029452;
 Wed, 7 May 2025 18:47:23 GMT
Received: from dhcp-10-43-71-250.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-250.usdhcp.oraclecorp.com [10.43.71.250])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46d9kbhd41-8; Wed, 07 May 2025 18:47:22 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
Subject: [PATCH v4 7/7] vdpa: move memory listener register to vhost_vdpa_init
Date: Wed,  7 May 2025 14:46:47 -0400
Message-ID: <20250507184647.15580-8-jonah.palmer@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfX82NvrhVbEZnF
 frrXDF46lvUWWLZQUwifEn1TsgpqtXosfUgDwg2veROpzvHCD49EpS+jJtUuQQtzaIqRwdqieav
 rfywtw00MPENxhu92yUuX52S2SddUAdhJ0BxeRd5yHHsrK0nbREMCiiDdZO0m2cqTbRjl6PLGz2
 zG1wdEivD18lNKMVtfEbHP+4pRTX31Pudfs6M6E8v/QQxGGXxgUdoW0ssxJSHTwtMTnbmnCFjhR
 K4pHfOARL8Jy3rhINk5RzLVKhgYF4Q8gkPqr5ZRJu6ADEjZUOF4iDWNrXemEl0DsmI4LGhKN3R5
 km0ot6Z008mqSfpU6dxZNtl++feayf1O7ZqxDRghZzqpV+7ohlKSl60do2mm5MSKl8e5WwcOJzn
 qmRZsI0qm4e0MgO6ZLVjfWZGnNFMdtnSDo4NctCddzv1INP3EZhqcAjcQl0DAEar+CiTgBem
X-Proofpoint-ORIG-GUID: 0vp6MPvZFzXebBq-65pjCY_UTEOxaPuh
X-Authority-Analysis: v=2.4 cv=GKcIEvNK c=1 sm=1 tr=0 ts=681baabc cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=okN2-_bYi-jDPBqWON8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0vp6MPvZFzXebBq-65pjCY_UTEOxaPuh
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

Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The downtime is measured as checking the trace timestamp from the moment
the source suspend the device to the moment the destination starts the
eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
secs to 2.0949.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

v3:
---
Move memory listener unregistration from vhost_vdpa_reset_status to
vhost_vdpa_reset_device. By unregistering the listener here, we can
guarantee that every reset leaves the device in an expected state.
Also remove the duplicate call in vhost_vdpa_reset_status.

Reported-by: Lei Yang <leiyang@redhat.com>
Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>

--
v2:
Move the memory listener registration to vhost_vdpa_set_owner function.
In case of hotplug the vdpa device, the memory is already set up, and
leaving memory listener register call in the init function made maps
occur before set owner call.

To be 100% safe, let's put it right after set_owner call.

Reported-by: Lei Yang <leiyang@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index de834f2ebd..e20da95f30 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -894,8 +894,14 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 
     ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
     trace_vhost_vdpa_reset_device(dev);
+    if (ret) {
+        return ret;
+    }
+
+    memory_listener_unregister(&v->shared->listener);
+    v->shared->listener_registered = false;
     v->suspended = false;
-    return ret;
+    return 0;
 }
 
 static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
@@ -1379,6 +1385,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
+        if (v->shared->listener_registered &&
+            dev->vdev->dma_as != v->shared->listener.address_space) {
+            memory_listener_unregister(&v->shared->listener);
+            v->shared->listener_registered = false;
+        }
         if (!v->shared->listener_registered) {
             memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
             v->shared->listener_registered = true;
@@ -1392,8 +1403,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
 
 static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
-    struct vhost_vdpa *v = dev->opaque;
-
     if (!vhost_vdpa_last_dev(dev)) {
         return;
     }
@@ -1401,9 +1410,6 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_reset_device(dev);
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
-    memory_listener_unregister(&v->shared->listener);
-    v->shared->listener_registered = false;
-
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
@@ -1537,12 +1543,27 @@ static int vhost_vdpa_get_features(struct vhost_dev *dev,
 
 static int vhost_vdpa_set_owner(struct vhost_dev *dev)
 {
+    int r;
+    struct vhost_vdpa *v;
+
     if (!vhost_vdpa_first_dev(dev)) {
         return 0;
     }
 
     trace_vhost_vdpa_set_owner(dev);
-    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
+    r = vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
+    /*
+     * Being optimistic and listening address space memory. If the device
+     * uses vIOMMU, it is changed at vhost_vdpa_dev_start.
+     */
+    v = dev->opaque;
+    memory_listener_register(&v->shared->listener, &address_space_memory);
+    v->shared->listener_registered = true;
+    return 0;
 }
 
 static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
-- 
2.43.5


