Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE92D46BFB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKW-0007qQ-0B; Wed, 28 Jan 2026 15:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKK-0007bC-W1
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKH-00084j-4m
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:48 -0500
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60SIKVkG2170402; Wed, 28 Jan 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=yCpZ8OZEmhEYyDVc2aUaUkfZJVu/yc0ND2O/fefPaaY=; b=elNTkOJP7ZFV
 H3rhDlMBsykNOiyXMblQuDg/31TyGtyG0r6fvu7G0A5dG5QeOGreswYn6NygFfwt
 ChKpEOZlNSROUIfd3g4hV52AHfp/bLEfGG0895g76TyHIeGGb+wXQ8LEV5IqSFbT
 pvSHCypvbSMVPtx0fzsu7BP5+/4yVfUTLGrAtFK9NzJ28vH578V+CVvP2xuPcuYd
 Z6GGCg/vxZAxOgVkHfjueSu9F9EZpbaO98ZMO6KO8YFSdVHpyQbebjfslWov3rJQ
 s7PgWVodomURPKELwA5ZesyK5ncfjd48mS5Y3bdn1azBst4X65wf2RMhbxdVaB3F
 /jy9zhNwug==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4byqnat9w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:41 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SI7e9a010430; Wed, 28 Jan 2026 15:39:40 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4bvta3g7y3-1;
 Wed, 28 Jan 2026 15:39:40 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 16240AF;
 Wed, 28 Jan 2026 20:39:39 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 28 Jan 2026 15:39:34 -0500
Subject: [PATCH v4 6/8] tap: cpr support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-cpr-tap-v4-6-48e334d4216b@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
In-Reply-To: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=12558;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=nZna5y7cU4VKMsyHpma5ytnBgdVdvkrBCymbsuiNGLM=;
 b=6LaIMH4kyy453SwG4R59fbcpzFp4wd/aAcBvm4m42zFCe7incJ3zOGMFOk8foTuoqSZWPtSWf
 h1ajAqzuZ1gCH2NCL/m6VsNmDpO4rqeFMZfyO1cJBSxKVY8SDbfIkW5
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280169
X-Proofpoint-GUID: 0uXiCZrp8Xg6MkAt04ifTF8vnPOcUyq1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfXxTgyfnctfS0S
 BJk0tN0FnUi8rgpkWj4XujGqVsSKpG6Pll099TBP0MdX4/JB/cKPKYISK5iPvsA27JT7izRiPkz
 U0iv0xO4loSk+WeX+weo9M47a5MflVYfEPQBNCMBAlxbToYOYJ5tIu1rIWFmBDCciv7wiWuFNy8
 LgXViM2ItXTtiJwKhBjLWSlyuOnAeos6u1numrUIe/73bY2MZScOoGxcdfUyGGDA4haV8uAvzNM
 oiSEmFZ1oDlXM5ZFH2BCMNc+7WiRPvPkDrqxEbuQVWbCv1+jA4WkJYOC+bIfbD2+y1TKGg2WKO9
 3RsryKQzpMQ8LOAbNgz42psorsHMA2GYqfc4+oQn54hbwCikd60OTpyR9xSNEuQ5g9qOOD3ladp
 mdFMLpbMRaY3OpFupasasOlDyjf9H3vlT6k+v4q+xNNy3VfGzdKh/8RPf8qF+2jokkFxIx4vU6V
 F64wmF2q/XuQg4BdZ8A==
X-Authority-Analysis: v=2.4 cv=AtTjHe9P c=1 sm=1 tr=0 ts=697a740d cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=MnPoHshHpnJFf7yz6EoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0uXiCZrp8Xg6MkAt04ifTF8vnPOcUyq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280170
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Provide the cpr=on option to preserve TAP and vhost descriptors during
cpr-transfer, so the management layer does not need to create a new
device for the target.

Save all tap fd's in order with the tap device fds saved first,
and the vhostfd saved after.

Example:

-netdev tap,id=hostnet2,cpr=on

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 hw/vfio/device.c        |  2 +-
 include/migration/cpr.h |  4 +--
 migration/cpr.c         | 19 +++++++------
 net/tap.c               | 74 +++++++++++++++++++++++++++++++++++++++----------
 qapi/net.json           |  6 +++-
 5 files changed, 77 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 086f20f676..cbc8db6a67 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -363,7 +363,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
-    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
+    vbasedev->fd = get_fd_param(vbasedev->dev->id, str, 0, true, errp);
 }
 
 static VFIODeviceIOOps vfio_device_io_ops_ioctl;
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index d585fadc5b..ded6ceff7c 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -48,8 +48,8 @@ void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_incoming_needed(void *opaque);
-int cpr_get_fd_param(const char *name, const char *fdname, int index,
-                     Error **errp);
+int get_fd_param(const char *cpr_name, const char *fdname, int index, bool cpr,
+                 Error **errp);
 
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index c0bf93a7ba..f2c40eeba5 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -311,11 +311,12 @@ bool cpr_incoming_needed(void *opaque)
 }
 
 /*
- * cpr_get_fd_param: find a descriptor and return its value.
+ * get_fd_param: find a descriptor and return its value.
  *
- * @name: CPR name for the descriptor
+ * @cpr_name: CPR name for the descriptor
  * @fdname: An integer-valued string, or a name passed to a getfd command
  * @index: CPR index of the descriptor
+ * @cpr: cpr is enabled on the associated device
  * @errp: returned error message
  *
  * If CPR is not being performed, then use @fdname to find the fd.
@@ -324,23 +325,23 @@ bool cpr_incoming_needed(void *opaque)
  *
  * On success returns the fd value, else returns -1.
  */
-int cpr_get_fd_param(const char *name, const char *fdname, int index,
-                     Error **errp)
+int get_fd_param(const char *cpr_name, const char *fdname, int index,
+                     bool cpr, Error **errp)
 {
     ERRP_GUARD();
     int fd;
 
-    if (cpr_is_incoming()) {
-        fd = cpr_find_fd(name, index);
+    if (cpr && cpr_is_incoming()) {
+        fd = cpr_find_fd(cpr_name, index);
         if (fd < 0) {
             error_setg(errp, "cannot find saved value for fd %s", fdname);
         }
     } else {
         fd = monitor_fd_param(monitor_cur(), fdname, errp);
-        if (fd >= 0) {
-            cpr_save_fd(name, index, fd);
-        } else {
+        if (fd < 0) {
             error_prepend(errp, "Could not parse object fd %s:", fdname);
+        } else if (cpr) {
+            cpr_save_fd(cpr_name, index, fd);
         }
     }
     return fd;
diff --git a/net/tap.c b/net/tap.c
index 1847167e4f..8875498434 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -35,6 +35,7 @@
 #include "net/eth.h"
 #include "net/net.h"
 #include "clients.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "system/system.h"
 #include "qapi/error.h"
@@ -80,6 +81,7 @@ typedef struct TAPState {
     bool has_uso;
     bool has_tunnel;
     bool enabled;
+    bool cpr;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
@@ -323,6 +325,9 @@ static void tap_cleanup(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
+    if (s->cpr) {
+        cpr_delete_fd_all(nc->name);
+    }
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
         g_free(s->vhost_net);
@@ -690,18 +695,24 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
     return fd;
 }
 
+/* CPR fd's for each queue are saved at these indices */
+#define TAP_FD_INDEX(queue)                   ((queue))
+#define TAP_VHOSTFD_INDEX(queue, total_fds)   ((queue) + (total_fds))
+
 #define MAX_TAP_QUEUES 1024
 
 static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, const char *vhostfdname,
-                             int vnet_hdr, int fd, Error **errp)
+                             int vnet_hdr, int fd, int index, Error **errp)
 {
     Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
+    bool cpr = tap->has_cpr ? tap->cpr : false;
     int vhostfd;
 
+    s->cpr = cpr;
     tap_set_sndbuf(s->fd, tap, &err);
     if (err) {
         error_propagate(errp, err);
@@ -736,7 +747,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
 
         if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
+            vhostfd = get_fd_param(name, vhostfdname, index, cpr, &err);
             if (vhostfd == -1) {
                 error_propagate(errp, err);
                 goto failed;
@@ -745,12 +756,21 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 goto failed;
             }
         } else {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
+            vhostfd = cpr ? cpr_find_fd(name, index) : -1;
+            if (vhostfd < 0) {
+                vhostfd = open("/dev/vhost-net", O_RDWR);
+                if (cpr && vhostfd >= 0) {
+                    cpr_save_fd(name, index, vhostfd);
+                }
+            }
             if (vhostfd < 0) {
                 error_setg_file_open(errp, errno, "/dev/vhost-net");
                 goto failed;
             }
             if (!qemu_set_blocking(vhostfd, false, errp)) {
+                if (!cpr) {
+                    close(vhostfd);
+                }
                 goto failed;
             }
         }
@@ -776,6 +796,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     return;
 
 failed:
+    if (cpr) {
+        cpr_delete_fd_all(name);
+    }
     qemu_del_net_client(&s->nc);
 }
 
@@ -808,7 +831,8 @@ static int get_fds(char *str, char *fds[], int max)
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
-    const NetdevTapOptions *tap;
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    bool cpr = tap->has_cpr ? tap->cpr : false;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     const char *script;
@@ -844,7 +868,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto out;
         }
 
-        fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
+        fd = get_fd_param(name, tap->fd, TAP_FD_INDEX(0), cpr, errp);
         if (fd == -1) {
             ret = -1;
             goto out;
@@ -865,13 +889,15 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
                          script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
+                         vhostfdname, vnet_hdr, fd,
+                         TAP_VHOSTFD_INDEX(0, 1), &err);
         if (err) {
             error_propagate(errp, err);
             close(fd);
             ret = -1;
             goto out;
         }
+
     } else if (tap->fds) {
         char **fds;
         char **vhost_fds;
@@ -902,7 +928,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(monitor_cur(), fds[i], errp);
+            fd = get_fd_param(name, fds[i], TAP_FD_INDEX(i), cpr, errp);
             if (fd == -1) {
                 ret = -1;
                 goto free_fail;
@@ -929,7 +955,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              script, downscript,
                              tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
+                             vnet_hdr, fd, TAP_VHOSTFD_INDEX(i, nfds), &err);
             if (err) {
                 error_propagate(errp, err);
                 ret = -1;
@@ -957,9 +983,15 @@ free_fail:
             goto out;
         }
 
-        fd = net_bridge_run_helper(tap->helper,
-                                   tap->br ?: DEFAULT_BRIDGE_INTERFACE,
-                                   errp);
+        fd = cpr ? cpr_find_fd(name, TAP_FD_INDEX(0)) : -1;
+        if (fd < 0) {
+            fd = net_bridge_run_helper(tap->helper,
+                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
+                                    errp);
+            if (cpr && fd >= 0) {
+                cpr_save_fd(name, TAP_FD_INDEX(0), fd);
+            }
+        }
         if (fd == -1) {
             ret = -1;
             goto out;
@@ -979,13 +1011,14 @@ free_fail:
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
                          script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
+                         vnet_hdr, fd, TAP_VHOSTFD_INDEX(0, 1), &err);
         if (err) {
             error_propagate(errp, err);
             close(fd);
             ret = -1;
             goto out;
         }
+
     } else {
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
@@ -1010,8 +1043,14 @@ free_fail:
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
-                              ifname, sizeof ifname, queues > 1, errp);
+            fd = cpr ? cpr_find_fd(name, TAP_FD_INDEX(i)) : -1;
+            if (fd < 0) {
+                fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
+                                ifname, sizeof ifname, queues > 1, errp);
+                if (cpr && fd >= 0) {
+                    cpr_save_fd(name, TAP_FD_INDEX(i), fd);
+                }
+            }
             if (fd == -1) {
                 ret = -1;
                 goto out;
@@ -1029,7 +1068,9 @@ free_fail:
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              i >= 1 ? "no" : script,
                              i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
+                             vhostfdname, vnet_hdr,
+                             fd, TAP_VHOSTFD_INDEX(i, queues),
+                             &err);
             if (err) {
                 error_propagate(errp, err);
                 close(fd);
@@ -1040,6 +1081,9 @@ free_fail:
     }
 
 out:
+    if (ret && cpr) {
+        cpr_delete_fd_all(name);
+    }
     return ret;
 }
 
diff --git a/qapi/net.json b/qapi/net.json
index 118bd34965..4b12fca94b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -355,6 +355,9 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @cpr: preserve the state of this device and its associated file
+#     descriptors during cpr-transfer for reduced migration downtime
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -373,7 +376,8 @@
     '*vhostfds':   'str',
     '*vhostforce': 'bool',
     '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
+    '*poll-us':    'uint32',
+    '*cpr':        'bool'} }
 
 ##
 # @NetdevSocketOptions:

-- 
2.34.1


