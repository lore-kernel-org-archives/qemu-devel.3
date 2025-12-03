Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BD5D1BDD2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpQ-0001jQ-5Q; Wed, 03 Dec 2025 13:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpK-0001hJ-GU
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:46 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hI-9X
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:46 -0500
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B39qPfF4058597
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=sxAo1uqskNqifb7qfIk7I5/SJimHpVVq96+8uOmNsQM=; b=ltEA9PEO5/qt
 LCUIrDZcgM95xsmgRC9V5wwro3ObNpBWfVZMKKzJgMD53KMj+F47XNdsQRP6f+b8
 SXE2RNSOr77m0RfEJijeFvcw63kACayVtfNpTe+6REAFVuhJzjcZ5/VSIbyQznVZ
 RaUauRqRY6Rrith5lrkZBUNHbBwAQnMWN9eRzrGhK/KrYnvx6P/LSsnovPivOTWN
 Ymin09UNME4ybFePGzIJuO8MjLdyeObaqEZwp8PrS8B0P60yErve5SEK12PbjJOk
 2kxh+AgzKfdpnP7mkMT+y7atkr5P5TTL414kV+iYYHUW2qHO3DxIAamuBVndhi9T
 gT7AFpes0w==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aswun4u6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FaPLB031233
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 10:43:38 -0800
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4aqypdkkhj-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 10:43:38 -0800
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 4912798
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:43:27 -0500
Subject: [PATCH v3 6/8] tap: cpr support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-6-3cc89e9b19e4@akamai.com>
References: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=12397;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=3xg4N8thwWZW4UJ8SY9X2DDt88vnbdrhVb/PFvVwcXA=;
 b=mZtZY5WaC2FMieofVA+JPJIkWaKodIk6GRm0uofX//N6DTGHUS8espqPrb5tZU8gBLQsYaYaB
 Fdc23KYzyATCIo2HkZgxfKIsF3NpVxI7dFux8sytrg+osKhiH6NQ5L0
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512030146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX1VIUVH+lsKbe
 /4+pfMEi8c6YC0OXfyy0J4TbLI8lX45ZaHeWpPuFnW+zmSlfxRFWRBD5/Xk6NYMqa4HrhfL6i3d
 4TaajrR26uDduFb9aFf418+rYG9QBtjDrutkR4Udi4aIlBaDmePxGM+FfLSYcy/7PkrdY2RhgKP
 d5PHo1zNmw2floq1pgA2d/s+ljOdoNS2q4koyTyQ04r+gA7kvULNk4nqW9T2taqqzci/8VRIgXu
 LLD7/HlDjITd0xFZJgx8qQlnX4IptIBvkZ7L/ijBG6Fmb4vQFlP9mIRLKT1l9UEImavoyppp5QA
 clbO5dYr5L3jsE96xxS9gsRGLadwMN36r50r+YGnx0SSxysjkNDScqdsrQuHmTwHi3eujgzVvv/
 +Ii2k6v5YrFXCJBO15HhCO1YVOFgqA==
X-Proofpoint-ORIG-GUID: SDyxIOgquO1ZV6yKDxZ_vUGat8IyIVoj
X-Authority-Analysis: v=2.4 cv=O+o0fR9W c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=DrAZhfO-21Mt0ZXRAbIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SDyxIOgquO1ZV6yKDxZ_vUGat8IyIVoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Provide the cpr=on option to preserve TAP and vhost descriptors during
cpr-transfer, so the management layer does not need to create a new
device for the target.

Save all tap fd's in canonical order, leveraging the index argument of
cpr_save_fd.  For the i'th queue, the tap device fd is saved at index 2*i,
and the vhostfd (if any) at index 2*i+1.

tap and vhost fd's are passed by name to the monitor when a NIC is hot
plugged, but the name is not known to qemu after cpr.  Allow the manager
to pass -1 for the fd "name" in the new qemu args to indicate that QEMU
should search for a saved value.  Example:

  -netdev tap,id=hostnet2,fds=-1:-1,vhostfds=-1:-1,cpr=on

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 hw/vfio/device.c        |  2 +-
 include/migration/cpr.h |  2 +-
 migration/cpr.c         | 11 ++++----
 net/tap.c               | 73 +++++++++++++++++++++++++++++++++++++++----------
 qapi/net.json           |  5 +++-
 5 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 76869828fc..73e622f7b5 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -362,7 +362,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
-    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
+    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, true, errp);
 }
 
 static VFIODeviceIOOps vfio_device_io_ops_ioctl;
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index d585fadc5b..68424b4b03 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -48,7 +48,7 @@ void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_incoming_needed(void *opaque);
-int cpr_get_fd_param(const char *name, const char *fdname, int index,
+int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
                      Error **errp);
 
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index c0bf93a7ba..19bd56339d 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -316,6 +316,7 @@ bool cpr_incoming_needed(void *opaque)
  * @name: CPR name for the descriptor
  * @fdname: An integer-valued string, or a name passed to a getfd command
  * @index: CPR index of the descriptor
+ * @cpr: use cpr
  * @errp: returned error message
  *
  * If CPR is not being performed, then use @fdname to find the fd.
@@ -325,22 +326,22 @@ bool cpr_incoming_needed(void *opaque)
  * On success returns the fd value, else returns -1.
  */
 int cpr_get_fd_param(const char *name, const char *fdname, int index,
-                     Error **errp)
+                     bool cpr, Error **errp)
 {
     ERRP_GUARD();
     int fd;
 
-    if (cpr_is_incoming()) {
+    if (cpr && cpr_is_incoming()) {
         fd = cpr_find_fd(name, index);
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
+            cpr_save_fd(name, index, fd);
         }
     }
     return fd;
diff --git a/net/tap.c b/net/tap.c
index 9d480574c3..79e29addd1 100644
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
+#define TAP_FD_INDEX(queue)         (2 * (queue) + 0)
+#define TAP_VHOSTFD_INDEX(queue)    (2 * (queue) + 1)
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
+            vhostfd = cpr_get_fd_param(name, vhostfdname, index, cpr, &err);
             if (vhostfd == -1) {
                 error_propagate(errp, err);
                 goto failed;
@@ -745,13 +756,22 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
                 goto failed;
             }
             if (!qemu_set_blocking(vhostfd, false, errp)) {
+                if (!cpr) {
+                    close(vhostfd);
+                }
                 goto failed;
             }
         }
@@ -777,6 +797,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     return;
 
 failed:
+    if (cpr) {
+        cpr_delete_fd_all(name);
+    }
     qemu_del_net_client(&s->nc);
 }
 
@@ -809,7 +832,8 @@ static int get_fds(char *str, char *fds[], int max)
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
-    const NetdevTapOptions *tap;
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    bool cpr = tap->has_cpr ? tap->cpr : false;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     const char *script;
@@ -845,7 +869,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto out;
         }
 
-        fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
+        fd = cpr_get_fd_param(name, tap->fd, TAP_FD_INDEX(0), cpr, errp);
         if (fd == -1) {
             ret = -1;
             goto out;
@@ -866,13 +890,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
                          script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
+                         vhostfdname, vnet_hdr, fd, TAP_VHOSTFD_INDEX(0), &err);
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
@@ -903,7 +928,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(monitor_cur(), fds[i], errp);
+            fd = cpr_get_fd_param(name, fds[i], TAP_FD_INDEX(i), cpr, errp);
             if (fd == -1) {
                 ret = -1;
                 goto free_fail;
@@ -930,7 +955,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              script, downscript,
                              tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
+                             vnet_hdr, fd, TAP_VHOSTFD_INDEX(i), &err);
             if (err) {
                 error_propagate(errp, err);
                 ret = -1;
@@ -958,9 +983,15 @@ free_fail:
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
@@ -980,13 +1011,14 @@ free_fail:
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
                          script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
+                         vnet_hdr, fd, TAP_VHOSTFD_INDEX(0), &err);
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
@@ -1011,8 +1043,14 @@ free_fail:
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
@@ -1030,7 +1068,9 @@ free_fail:
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              i >= 1 ? "no" : script,
                              i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
+                             vhostfdname, vnet_hdr,
+                             fd, TAP_VHOSTFD_INDEX(i),
+                             &err);
             if (err) {
                 error_propagate(errp, err);
                 close(fd);
@@ -1041,6 +1081,9 @@ free_fail:
     }
 
 out:
+    if (ret && cpr) {
+        cpr_delete_fd_all(name);
+    }
     return ret;
 }
 
diff --git a/qapi/net.json b/qapi/net.json
index 118bd34965..264213b5d9 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -355,6 +355,8 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @cpr: preserve fds and vhostfds during cpr-transfer.
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -373,7 +375,8 @@
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


