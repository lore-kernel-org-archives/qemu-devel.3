Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6FDC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGrF-000293-JH; Fri, 12 Jul 2024 10:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGrE-00023F-1S
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGrC-0005vD-5P
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIN2Y025663;
 Fri, 12 Jul 2024 14:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=dTbJwlJt4IPxvPC5MtqUjG7iInlfl4OVlAOz98Jk/dg=; b=
 iWTLo1sz4YI7aTl5St1+X1mpFFFsAs5fXVJqH3FPKzubm8ubXTHam0qc7K+UUYqa
 5ldYgcSSOr6NhzSiSUlHcdrsIVb1LdRtdEd+iHmEV4LeiUPTs14B3enS48eRg5Oz
 4DrV4YmsCTzOVbZ/Tdov3spWYfi6AkqSC9bwWNmCAvH7zZcUykFGEbKA0//4qwS+
 2rN+kj13bhwuA1+esdlM5zcTLzIoM2nQkRiwt5RHCHx2eukpO+06Ih3jEbjw4RPB
 cT5PCrv44WCL+v61+0FQiTNcYF37ry886ota4H+ZwNETOAt9KCfShLsB03PzYWj3
 7s0An1MpacIWzp7pHC13kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknuxvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CDmDel010418; Fri, 12 Jul 2024 14:02:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74jv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DPs020438;
 Fri, 12 Jul 2024 14:02:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-4; Fri, 12 Jul 2024 14:02:17 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 3/7] vdpa/cpr: preserve device fd
Date: Fri, 12 Jul 2024 07:02:07 -0700
Message-Id: <1720792931-456433-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: pHxkJgmHEbAxjEwcPvRl3fzpaqj2DqAx
X-Proofpoint-ORIG-GUID: pHxkJgmHEbAxjEwcPvRl3fzpaqj2DqAx
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

Save the vdpa device fd in CPR state when it is created, and fetch the fd
from that state after CPR.  Remember that the fd was reused, for subsequent
patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/virtio/vhost-vdpa.h |  3 +++
 net/vhost-vdpa.c               | 24 ++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 0a9575b469..427458cfed 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -54,6 +54,9 @@ typedef struct vhost_vdpa_shared {
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 
+    /* Device descriptor is being reused after CPR restart */
+    bool reused;
+
     /* SVQ switching is in progress, or already completed? */
     SVQTransitionState svq_switching;
 } VhostVDPAShared;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index daa38428c5..e6010e8900 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "hw/virtio/virtio-net.h"
+#include "migration/cpr.h"
 #include "net/vhost_net.h"
 #include "net/vhost-vdpa.h"
 #include "hw/virtio/vhost-vdpa.h"
@@ -240,8 +241,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     if (s->vhost_vdpa.index != 0) {
         return;
     }
+    cpr_delete_fd(nc->name, 0);
     qemu_close(s->vhost_vdpa.shared->device_fd);
     g_free(s->vhost_vdpa.shared);
+    s->vhost_vdpa.shared = NULL;
 }
 
 /** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
@@ -1675,6 +1678,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                        int nvqs,
                                        bool is_datapath,
                                        bool svq,
+                                       bool reused,
                                        struct vhost_vdpa_iova_range iova_range,
                                        uint64_t features,
                                        VhostVDPAShared *shared,
@@ -1712,6 +1716,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                           &s->vhost_vdpa.migration_blocker);
         s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
         s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
+        s->vhost_vdpa.shared->reused = reused;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
     } else if (!is_datapath) {
@@ -1793,6 +1798,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
     struct vhost_vdpa_iova_range iova_range;
     NetClientState *nc;
     int queue_pairs, r, i = 0, has_cvq = 0;
+    bool reused;
 
     assert(netdev->type == NET_CLIENT_DRIVER_VHOST_VDPA);
     opts = &netdev->u.vhost_vdpa;
@@ -1808,13 +1814,17 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (opts->vhostdev) {
+    vdpa_device_fd = cpr_find_fd(name, 0);
+    reused = (vdpa_device_fd != -1);
+
+    if (opts->vhostdev && vdpa_device_fd == -1) {
         vdpa_device_fd = qemu_open(opts->vhostdev, O_RDWR, errp);
         if (vdpa_device_fd == -1) {
             return -errno;
         }
-    } else {
-        /* has_vhostfd */
+        cpr_save_fd(name, 0, vdpa_device_fd);
+
+    } else if (opts->vhostfd) {
         vdpa_device_fd = monitor_fd_param(monitor_cur(), opts->vhostfd, errp);
         if (vdpa_device_fd == -1) {
             error_prepend(errp, "vhost-vdpa: unable to parse vhostfd: ");
@@ -1855,7 +1865,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
         }
         ncs[i] = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                      vdpa_device_fd, i, 2, true, opts->x_svq,
-                                     iova_range, features, shared, errp);
+                                     reused, iova_range, features, shared,
+                                     errp);
         if (!ncs[i])
             goto err;
     }
@@ -1866,8 +1877,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
 
         nc = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                  vdpa_device_fd, i, 1, false,
-                                 opts->x_svq, iova_range, features, shared,
-                                 errp);
+                                 opts->x_svq, reused, iova_range, features,
+                                 shared, errp);
         if (!nc)
             goto err;
     }
@@ -1882,6 +1893,7 @@ err:
     }
 
     qemu_close(vdpa_device_fd);
+    cpr_delete_fd(name, 0);
 
     return -1;
 }
-- 
2.39.3


