Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41162C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEtL-0003zc-5p; Wed, 14 Feb 2024 08:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEt7-0003kM-0g
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:01:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEt4-0007on-Vg
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:01:20 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EBldRE019239; Wed, 14 Feb 2024 13:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=QujOJQnK38RVKfAYgJUN64pBzB0xoGjuLEIiw2v6vi4=;
 b=HEbiQGM94oU+stDm2ddC/RM6qy5dKXUEh4SVYKcpaYI7zhAJOHg3MMlEPA+U7Vz8/ZrS
 gSvD9nxLBbBJTcTHgoBSFCUq/Xq6W7efgBOUFIqkF3MgA2tEOmgRKBCmoDe1f+xFpeL2
 88+6HnOFvSif9oCLMO+7xTRLnN5ESShCi2FMsOD59DAAo1mGlV21XSoGZOeBY2iol+MI
 YbKG1ifcvbr2Dn4jriQk2guoaKYBHPjGU8Uui8I8XnoYF4cebs6rXXtRWeBKFLvb0eme
 8ZZrbbJ8rr0JWgXHOVihnezuLpHvwMhUt/L6q57tr8TIZTP4rV7mX9qqIsZAj7rq2K4v OQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8varg701-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 13:01:16 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41EBf9ID024633; Wed, 14 Feb 2024 13:01:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykf6ex5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 13:01:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41ED1FUk027943;
 Wed, 14 Feb 2024 13:01:15 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykf6ewh-1; Wed, 14 Feb 2024 13:01:15 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, joao.m.martins@oracle.com,
 si-wei.liu@oracle.com
Subject: [PATCH v2 1/2] vhost: dirty log should be per backend type
Date: Wed, 14 Feb 2024 03:50:18 -0800
Message-Id: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140099
X-Proofpoint-GUID: kHs5Pss36GsPReAIYY3LJQ8NBz_3uV2o
X-Proofpoint-ORIG-GUID: kHs5Pss36GsPReAIYY3LJQ8NBz_3uV2o
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There could be a mix of both vhost-user and vhost-kernel clients
in the same QEMU process, where separate vhost loggers for the
specific vhost type have to be used. Make the vhost logger per
backend type, and have them properly reference counted.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 hw/virtio/vhost.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac79..ef6d9b5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -43,8 +43,8 @@
     do { } while (0)
 #endif
 
-static struct vhost_log *vhost_log;
-static struct vhost_log *vhost_log_shm;
+static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
+static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
 
 /* Memslots used by backends that support private memslots (without an fd). */
 static unsigned int used_memslots;
@@ -287,6 +287,8 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
         r = -1;
     }
 
+    assert(dev->vhost_ops->backend_type == backend_type || r < 0);
+
     return r;
 }
 
@@ -319,16 +321,23 @@ static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
     return log;
 }
 
-static struct vhost_log *vhost_log_get(uint64_t size, bool share)
+static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
+                                       uint64_t size, bool share)
 {
-    struct vhost_log *log = share ? vhost_log_shm : vhost_log;
+    struct vhost_log *log;
+
+    if (backend_type == VHOST_BACKEND_TYPE_NONE ||
+        backend_type >= VHOST_BACKEND_TYPE_MAX)
+        return NULL;
+
+    log = share ? vhost_log_shm[backend_type] : vhost_log[backend_type];
 
     if (!log || log->size != size) {
         log = vhost_log_alloc(size, share);
         if (share) {
-            vhost_log_shm = log;
+            vhost_log_shm[backend_type] = log;
         } else {
-            vhost_log = log;
+            vhost_log[backend_type] = log;
         }
     } else {
         ++log->refcnt;
@@ -340,11 +349,20 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
 static void vhost_log_put(struct vhost_dev *dev, bool sync)
 {
     struct vhost_log *log = dev->log;
+    VhostBackendType backend_type;
 
     if (!log) {
         return;
     }
 
+    assert(dev->vhost_ops);
+    backend_type = dev->vhost_ops->backend_type;
+
+    if (backend_type == VHOST_BACKEND_TYPE_NONE ||
+        backend_type >= VHOST_BACKEND_TYPE_MAX) {
+        return;
+    }
+
     --log->refcnt;
     if (log->refcnt == 0) {
         /* Sync only the range covered by the old log */
@@ -352,13 +370,13 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
             vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
         }
 
-        if (vhost_log == log) {
+        if (vhost_log[backend_type] == log) {
             g_free(log->log);
-            vhost_log = NULL;
-        } else if (vhost_log_shm == log) {
+            vhost_log[backend_type] = NULL;
+        } else if (vhost_log_shm[backend_type] == log) {
             qemu_memfd_free(log->log, log->size * sizeof(*(log->log)),
                             log->fd);
-            vhost_log_shm = NULL;
+            vhost_log_shm[backend_type] = NULL;
         }
 
         g_free(log);
@@ -376,7 +394,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
 
 static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 {
-    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
+    struct vhost_log *log = vhost_log_get(dev->vhost_ops->backend_type,
+                                          size, vhost_dev_log_is_shared(dev));
     uint64_t log_base = (uintptr_t)log->log;
     int r;
 
@@ -2037,8 +2056,14 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         uint64_t log_base;
 
         hdev->log_size = vhost_get_log_size(hdev);
-        hdev->log = vhost_log_get(hdev->log_size,
+        hdev->log = vhost_log_get(hdev->vhost_ops->backend_type,
+                                  hdev->log_size,
                                   vhost_dev_log_is_shared(hdev));
+        if (!hdev->log) {
+            VHOST_OPS_DEBUG(r, "vhost_log_get failed");
+            goto fail_vq;
+        }
+
         log_base = (uintptr_t)hdev->log->log;
         r = hdev->vhost_ops->vhost_set_log_base(hdev,
                                                 hdev->log_size ? log_base : 0,
-- 
1.8.3.1


