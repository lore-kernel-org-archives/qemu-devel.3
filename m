Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D535C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkNCE-0001xY-HP; Wed, 13 Mar 2024 07:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkNCB-0001wG-Mi; Wed, 13 Mar 2024 07:54:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkNBz-0004WN-Js; Wed, 13 Mar 2024 07:54:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42D8hgBa019478; Wed, 13 Mar 2024 11:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=EIDYMlwIMoHaK4Gv4uv2prmUGg9t7Se9GucAI94F2So=;
 b=fCP6+GJcw1QvP9gHP6VrJPNhsHxIh7zUNfG4JVL4BfjugKofXawHnXCD8AA3AwfwExQJ
 P39FLEqJ0p2IKnexYJ5NbXqQncWci+/IErOrbxRHcCT+eoc2+5gKBos2MUN6WLde8fIc
 B9aMB7nj5YwIp7Qkgvi73tkM9k74R4Pw81U0AXS4mPpP+FDR+yiGpgUYx0UZJNjLydra
 ocT6oFnZueRpkmsPhMcZHHhd0RRCRDCP4f/wxNjnlZAIU7mPjUj752tXYK368JSZzwJD
 +s7RxZMM9+cqJ0xDgdqNNabGRcSBwTr1XLIsd3SNZEL3ernIfXFlhGoHTBE7QWAb6DNg bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej40u26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 11:54:27 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42DB7iIE028530; Wed, 13 Mar 2024 11:54:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre78pehx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 11:54:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DBsMLd035677;
 Wed, 13 Mar 2024 11:54:26 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-201-251.vpn.oracle.com
 [10.39.201.251])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3wre78peed-3; Wed, 13 Mar 2024 11:54:26 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 jonah.palmer@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, cohuck@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, leiyang@redhat.com,
 schalla@marvell.com, vattunuru@marvell.com, jerinj@marvell.com,
 dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Subject: [PATCH v2 2/6] virtio: Prevent creation of device using
 notification-data with ioeventfd
Date: Wed, 13 Mar 2024 07:54:08 -0400
Message-Id: <20240313115412.3334962-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240313115412.3334962-1-jonah.palmer@oracle.com>
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130089
X-Proofpoint-GUID: -75nrkIcw_Nu-W81dCIIZ0uwkE8DIRmJ
X-Proofpoint-ORIG-GUID: -75nrkIcw_Nu-W81dCIIZ0uwkE8DIRmJ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Prevent the realization of a virtio device that attempts to use the
VIRTIO_F_NOTIFICATION_DATA transport feature without disabling
ioeventfd.

Due to ioeventfd not being able to carry the extra data associated with
this feature, having both enabled is a functional mismatch and therefore
Qemu should not continue the device's realization process.

Although the device does not yet know if the feature will be
successfully negotiated, many devices using this feature wont actually
work without this extra data and would fail FEATURES_OK anyway.

If ioeventfd is able to work with the extra notification data in the
future, this compatibility check can be removed.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/virtio.c         | 22 ++++++++++++++++++++++
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index bcb9e09df0..d0a433b465 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2971,6 +2971,20 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return ret;
 }
 
+void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
+                                                    Error **errp)
+{
+    VirtioBusState *bus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
+    DeviceState *proxy = DEVICE(BUS(bus)->parent);
+
+    if (virtio_host_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) &&
+        k->ioeventfd_enabled(proxy)) {
+        error_setg(errp,
+                   "notification_data=on without ioeventfd=off is not supported");
+    }
+}
+
 size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
                               uint64_t host_features)
 {
@@ -3731,6 +3745,14 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* Devices should not use both ioeventfd and notification data feature */
+    virtio_device_check_notification_compatibility(vdev, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        vdc->unrealize(dev);
+        return;
+    }
+
     virtio_bus_device_plugged(vdev, &err);
     if (err != NULL) {
         error_propagate(errp, err);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 53915947a7..e0325d84d0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -346,6 +346,8 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
 int virtio_set_features(VirtIODevice *vdev, uint64_t val);
+void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
+                                                    Error **errp);
 
 /* Base devices.  */
 typedef struct VirtIOBlkConf VirtIOBlkConf;
-- 
2.39.3


