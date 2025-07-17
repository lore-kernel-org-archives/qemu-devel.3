Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F3C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVT1-0007Bh-BG; Thu, 17 Jul 2025 16:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW8-0008WF-Be
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW4-00009G-5F
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0iHs027536;
 Thu, 17 Jul 2025 18:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=jEMH++dDedb77qsgBrEOe/ieXuj7ISA+5MLtq4+Sies=; b=
 StY7DoXSnMdbB5velfWadQ1tsyYiP6uP9Ku16hgj9BPW5je3vvpWvTlhkD8SReKl
 wOYuePOOvWcyJ0X6zzGEl2Q82ZipEcpEZDL7EyR9cjymrWa2SLjslxy3M3k9s9fV
 hS0tNj5euUnRPKQh8BMVXCLvwgRtL4ubv1IUHZPfMcZ88SNQktkpUitwzooivTA3
 iWyBzZirFdVXplwpU24AOSegT5xnut79ZHIBfj3xlVt85r2vtQdQHwfEeVqC6I5w
 wnJLhn2djuQNm6KjqtYI7ar8EOIa0/3c0lYyLwp85l94FFM/pUEXQOMC4jMC1lT8
 l+CRDOSEPBwE9UZUgLH9Rg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3s4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HHNQRY023999; Thu, 17 Jul 2025 18:39:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2tba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoiv007425;
 Thu, 17 Jul 2025 18:39:33 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-8; Thu, 17 Jul 2025 18:39:33 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 7/8] tap: cpr support
Date: Thu, 17 Jul 2025 11:39:27 -0700
Message-Id: <1752777568-236368-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX+xFLPmS9IJMl
 jDh6wl3jEYLbxz5n1NHPoe5nZcqo2QpT7qo4wnihhXvvNXxoNaLSoLOgybsZwkRsMeS1QVBvA+C
 7d2QSKZcZNG2qYS4e8agrW/ohFdlE0kZMLNXCP0qx/9RAAC9E2Bas4CFdxY2BhXIi59p/FoNXgN
 Y2oHkuUgEiSZmSMJl0ITKY9u4e2WjixBNEcQHbP/Ybh6ZdCOmpBuZICy08zEHCogW60bmZLgpru
 O2685TuWq2eZCtMFKvVzsTgMK0s4KIcBcZL21uacVKLaHo9wq7zZxoOtGyq8Zmt9HCEwDAA2Y0O
 c/zEusUFH3ecpSyf/+o7eTMnqalBVO6GcHFnexygVhl+oN12eQYM9Pw+W+Yx6XanD0iCvGpnDyR
 7ejSV61A3wergECiIIJK9/FyaGdLvxETu0+OtdF/kB1gq822HM/KUdEUyL3YoHdrOwfEU2a7
X-Proofpoint-GUID: JjMflIiwhoPO3hSA330PDfJC50M978U8
X-Proofpoint-ORIG-GUID: JjMflIiwhoPO3hSA330PDfJC50M978U8
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68794366 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=zKPUYSCetFGJfgUTIKcA:9
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
---
 qapi/net.json           |  5 +++-
 include/migration/cpr.h |  2 +-
 hw/vfio/device.c        |  2 +-
 migration/cpr.c         | 11 ++++----
 net/tap.c               | 70 ++++++++++++++++++++++++++++++++++++++-----------
 5 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 97ea183..5c7422b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -238,6 +238,8 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @cpr: preserve fds and vhostfds during cpr-transfer.
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -256,7 +258,8 @@
     '*vhostfds':   'str',
     '*vhostforce': 'bool',
     '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
+    '*poll-us':    'uint32',
+    '*cpr':        'bool'} }
 
 ##
 # @NetdevSocketOptions:
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 0fa57dd..baff57f 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -45,7 +45,7 @@ void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_incoming_needed(void *opaque);
-int cpr_get_fd_param(const char *name, const char *fdname, int index,
+int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
                      Error **errp);
 
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 96cf214..9eb6699 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -351,7 +351,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
-    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
+    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, true, errp);
 }
 
 static VFIODeviceIOOps vfio_device_io_ops_ioctl;
diff --git a/migration/cpr.c b/migration/cpr.c
index e97be9d..6d01b8c 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -282,6 +282,7 @@ bool cpr_incoming_needed(void *opaque)
  * @name: CPR name for the descriptor
  * @fdname: An integer-valued string, or a name passed to a getfd command
  * @index: CPR index of the descriptor
+ * @cpr: use cpr
  * @errp: returned error message
  *
  * If CPR is not being performed, then use @fdname to find the fd.
@@ -291,22 +292,22 @@ bool cpr_incoming_needed(void *opaque)
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
index 1b239fd..6a12751 100644
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
@@ -59,6 +60,7 @@ typedef struct TAPState {
     bool has_ufo;
     bool has_uso;
     bool enabled;
+    bool cpr;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
@@ -290,6 +292,9 @@ static void tap_cleanup(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
+    if (s->cpr) {
+        cpr_delete_fd_all(nc->name);
+    }
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
         g_free(s->vhost_net);
@@ -642,18 +647,24 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
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
@@ -688,7 +699,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
 
         if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
+            vhostfd = cpr_get_fd_param(name, vhostfdname, index, cpr, &err);
             if (vhostfd == -1) {
                 error_propagate(errp, err);
                 goto failed;
@@ -699,7 +710,13 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
@@ -727,6 +744,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     return;
 
 failed:
+    if (cpr) {
+        cpr_delete_fd_all(name);
+    }
     qemu_del_net_client(&s->nc);
 }
 
@@ -759,7 +779,8 @@ static int get_fds(char *str, char *fds[], int max)
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
-    const NetdevTapOptions *tap;
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    bool cpr = tap->has_cpr ? tap->cpr : false;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     const char *script;
@@ -795,7 +816,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto out;
         }
 
-        fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
+        fd = cpr_get_fd_param(name, tap->fd, TAP_FD_INDEX(0), cpr, errp);
         if (fd == -1) {
             ret = -1;
             goto out;
@@ -818,13 +839,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
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
@@ -855,7 +877,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(monitor_cur(), fds[i], errp);
+            fd = cpr_get_fd_param(name, fds[i], TAP_FD_INDEX(i), cpr, errp);
             if (fd == -1) {
                 ret = -1;
                 goto free_fail;
@@ -884,7 +906,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              script, downscript,
                              tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
+                             vnet_hdr, fd, TAP_VHOSTFD_INDEX(i), &err);
             if (err) {
                 error_propagate(errp, err);
                 ret = -1;
@@ -912,9 +934,15 @@ free_fail:
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
@@ -934,13 +962,14 @@ free_fail:
 
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
@@ -965,8 +994,14 @@ free_fail:
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
@@ -984,7 +1019,9 @@ free_fail:
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
@@ -995,6 +1032,9 @@ free_fail:
     }
 
 out:
+    if (ret && cpr) {
+        cpr_delete_fd_all(name);
+    }
     return ret;
 }
 
-- 
1.8.3.1


