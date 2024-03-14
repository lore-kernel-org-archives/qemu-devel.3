Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476B9C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 21:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rksn0-00022a-4d; Thu, 14 Mar 2024 17:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rksmv-00022E-6R
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:38:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rksmt-00080G-C9
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 17:38:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42ELDcH6016463; Thu, 14 Mar 2024 21:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=DRPeOZwl5bh4BbTJ0f2bcJMuEm96QltP56PMEsm+Ing=;
 b=gHIvqKFhe2Yr2Xdsq1f3wWS7QBKNYszqbs9h0URkhLz0rhKlcxfX8smRbDwh1gNqvaAk
 XvQ7IDWjorZpA8r/434r9CzdpREh3Ev06Qr3vKS2XfnySpxr7sEaLTzpC+jykx9Hs5Rv
 ZobqCo0NbcSHokQJeY25JIwIpSLGexl+c6svx8kfeYr3c8meURzQyuOpIceSNTaOP0RH
 P3kDGqAYe46ixFnIoT+UquOMf2QY7TCyw4Jt6c6NA77FO/5dndEm/HCMV80exY+lwH+N
 k/InoQxnX8jaoo4AfJT78nxWqrQVMEQE9oFkcrQ7eToIiAZC0puBkbpQJ//uwyBJOQhU Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0absaur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 21:38:51 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42EJmWac019716; Thu, 14 Mar 2024 21:38:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7ayv25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 21:38:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42ELco1c002045;
 Thu, 14 Mar 2024 21:38:50 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3wre7ayv1k-1; Thu, 14 Mar 2024 21:38:50 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com, si-wei.liu@oracle.com
Subject: [PATCH v4 1/2] vhost: dirty log should be per backend type
Date: Thu, 14 Mar 2024 13:27:34 -0700
Message-Id: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140166
X-Proofpoint-ORIG-GUID: vJH8_WzYjlUADPob9HPOJGNz8KSwRKUN
X-Proofpoint-GUID: vJH8_WzYjlUADPob9HPOJGNz8KSwRKUN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
v3->v4:
  - remove checking NULL return value from vhost_log_get

v2->v3:
  - remove non-effective assertion that never be reached
  - do not return NULL from vhost_log_get()
  - add neccessary assertions to vhost_log_get()
---
 hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac79..612f4db 100644
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
@@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
         r = -1;
     }
 
+    if (r == 0) {
+        assert(dev->vhost_ops->backend_type == backend_type);
+    }
+
     return r;
 }
 
@@ -319,16 +323,22 @@ static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
     return log;
 }
 
-static struct vhost_log *vhost_log_get(uint64_t size, bool share)
+static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
+                                       uint64_t size, bool share)
 {
-    struct vhost_log *log = share ? vhost_log_shm : vhost_log;
+    struct vhost_log *log;
+
+    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
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
@@ -340,11 +350,20 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
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
@@ -352,13 +371,13 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
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
@@ -376,7 +395,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
 
 static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 {
-    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
+    struct vhost_log *log = vhost_log_get(dev->vhost_ops->backend_type,
+                                          size, vhost_dev_log_is_shared(dev));
     uint64_t log_base = (uintptr_t)log->log;
     int r;
 
@@ -2037,7 +2057,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         uint64_t log_base;
 
         hdev->log_size = vhost_get_log_size(hdev);
-        hdev->log = vhost_log_get(hdev->log_size,
+        hdev->log = vhost_log_get(hdev->vhost_ops->backend_type,
+                                  hdev->log_size,
                                   vhost_dev_log_is_shared(hdev));
         log_base = (uintptr_t)hdev->log->log;
         r = hdev->vhost_ops->vhost_set_log_base(hdev,
-- 
1.8.3.1


