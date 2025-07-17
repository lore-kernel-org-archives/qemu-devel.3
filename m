Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74402C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVWr-0004Uz-Fs; Thu, 17 Jul 2025 16:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTWC-00009O-Hf
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW5-00008Q-BE
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0i2q018938;
 Thu, 17 Jul 2025 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=g4cQG70O0Kg5s+vb7pr/SM4gt9CRW62U+GGQNlaa3Mw=; b=
 ZPAy147zVqklHm+Sx08fABW1/ERmrBr8u4k5ajxdpjm6BFB5i7RpQ1TePrGdCjSy
 vWGKwIzaelxcrFSZLvPt2g/wzM/4p1Btw5PCdbnNOQz2h+uzzzWISy92dTZbI4Fz
 Je1Lmhp4rBc11CMPmadjbkHMD0kUEV9QaUjV1kqMAoCm8WDF+AmUvHla1lk2ja74
 +1Nyja0zjXGejWZfbYhopin2tzHn477LzNKdamgtu+Q3n+zBxDCyjRrQm3enUgOy
 p+7vQ49UNxS33JrLhqo8k5ocbLjyeYNQc+RFkdlE1Ol7+XftTu2C+0OGNc16h7DQ
 TXnVxjwCI518wv0KIdam7A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83yba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HHnugw023912; Thu, 17 Jul 2025 18:39:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2ta3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoin007425;
 Thu, 17 Jul 2025 18:39:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-4; Thu, 17 Jul 2025 18:39:30 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 3/8] vhost: reset vhost devices for cpr
Date: Thu, 17 Jul 2025 11:39:23 -0700
Message-Id: <1752777568-236368-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170165
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68794364 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=XmC3YHyv0GhogxYF6KIA:9
X-Proofpoint-ORIG-GUID: NXD9eTJ9Zd8U_WCSz2X2NyUmdWBrlTnP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX1XRjisFGRtqG
 EAQeBOr9D6PjH2P/GDlm8t5hvywr51xHib8RrNrPvvs2xBufd9DhcUT95q5u0ofbLHq4uDmrSj5
 KwWffKNel+PEdwZvH6sQEfPatECDYKen1G9O1J1CwFrdYaR0WUAcDnPCNPFnmmZbuZ9N9n8wjZi
 Pa+zjytqUNsD5BmM86UjOUeXjKHlbLROTQSBgfeGbAVzW4NBGp1voEiZaER7BSQMuIzY0feozjz
 8cuXo4Y6ZWZQlhRcDUo88QM2jMmwf+mNxZt/BMzr33Ep5EE3CJsge40l8hN3k91zzTGtNKjizo7
 xHKyZvplU8/kjSrRiT7G9K2kiJ472MkkwKhZYEcAtdR9BLM+9hC9AHcpNZvgbLw08pBxbbdOOtU
 uzkPYCd4wfx4lhzpq2LuB+XjjRIv+ncU7xsHTfeDtv7PHY7/R8HBtiRcB3GUpUSUdUZZF/Bo
X-Proofpoint-GUID: NXD9eTJ9Zd8U_WCSz2X2NyUmdWBrlTnP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When preserving a vhost fd using CPR, call VHOST_RESET_OWNER prior to CPR
in old QEMU.  Otherwise, new QEMU will fail when it calls VHOST_SET_OWNER
during vhost_dev_init.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/virtio/vhost.h |  1 +
 hw/virtio/vhost.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 38800a7..88a4838 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -132,6 +132,7 @@ struct vhost_dev {
     QLIST_ENTRY(vhost_dev) logdev_entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
+    NotifierWithReturn cpr_transfer_notifier;
     const VhostDevConfigOps *config_ops;
 };
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fc43853..a562e0c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -24,6 +24,7 @@
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/mem/memory-device.h"
+#include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
@@ -1506,6 +1507,32 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
+static int vhost_cpr_notifier(NotifierWithReturn *notifier,
+                              MigrationEvent *e, Error **errp)
+{
+    struct vhost_dev *dev;
+    int r;
+
+    dev = container_of(notifier, struct vhost_dev, cpr_transfer_notifier);
+
+    if (dev->vhost_ops->backend_type != VHOST_BACKEND_TYPE_KERNEL) {
+        return 0;
+    }
+
+    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
+        r = dev->vhost_ops->vhost_reset_device(dev);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_reset_device failed");
+        }
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+        r = dev->vhost_ops->vhost_set_owner(dev);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_set_owner failed");
+        }
+    }
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1516,6 +1543,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
+    hdev->cpr_transfer_notifier.notify = NULL;
 
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
@@ -1616,6 +1644,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_mode(&hdev->cpr_transfer_notifier,
+                                vhost_cpr_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1672,6 +1703,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         QLIST_REMOVE(hdev, entry);
     }
     migrate_del_blocker(&hdev->migration_blocker);
+    migration_remove_notifier(&hdev->cpr_transfer_notifier);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
-- 
1.8.3.1


