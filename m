Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70FDCA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0FI-0007Qh-QX; Fri, 30 Aug 2024 07:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FE-0007JW-1f
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FB-0002re-UQ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7tZTx031532;
 Fri, 30 Aug 2024 11:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=d4mw0GEC9DP1mJClU2NH6S671GGFTg7HXk6f9Xqv14U=; b=
 I7PFEvV8LBORqheIVl2qhpzT1K0KSyLQG6g0e66XkVhZpAq5LjyWHGQbMepi/5Aj
 mXV9gLEZUapmSkQ5UuovVbnHjCuXUCNRcWmbm/+AKQgfDEo1XqP1nsouaGrcIzb/
 Ok80cohlSttf2cKHjgxizJNZPYt7iDTC+sDbx5AlmTAyA+4eHcPC8YlYo2KlWINW
 7aYnIvhLJ5MHa55MEWS1PP2hoDiECImiljVU7iWX4b26ipJtNgsP45biVzn0DjWE
 J3/OKeGarwUNcKTQltsrLaXIEoAPItszCQP2GnuPWaIjIH1LWTqybug8r4Uealxi
 WhWp+U/J55DHUGzeguiHJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b9v7gdmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UBJONJ036495; Fri, 30 Aug 2024 11:56:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4189jpg9ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47UBucxQ028887;
 Fri, 30 Aug 2024 11:56:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4189jpg9ae-6; Fri, 30 Aug 2024 11:56:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Euan Turner <euan.turner@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 5/6] tap: cpr support
Date: Fri, 30 Aug 2024 04:56:36 -0700
Message-Id: <1725018997-363706-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
References: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300090
X-Proofpoint-GUID: OZFRBhtBQkQFOj3enZpoMkMc6d7wGoAj
X-Proofpoint-ORIG-GUID: OZFRBhtBQkQFOj3enZpoMkMc6d7wGoAj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Save all tap fd's in canonical order, leveraging the index argument of
cpr_save_fd.  For the i'th queue, the tap device fd is saved at index 2*i,
and the vhostfd (if any) at index 2*i+1.

tap and vhost fd's are passed by name to the monitor when a NIC is hot
plugged, but the name is not known to qemu after cpr-exec.  Allow the
manager to pass -1 for the fd "name" in the new qemu args to indicate that
qemu should search for a saved value.  Example:

  -netdev tap,id=hostnet2,fds=-1:-1,vhostfds=-1:-1

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 net/tap.c | 55 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 20e4dae..4d57a53 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -35,6 +35,7 @@
 #include "net/eth.h"
 #include "net/net.h"
 #include "clients.h"
+#include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
@@ -290,6 +291,8 @@ static void tap_cleanup(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
+    cpr_delete_fd_all(nc->name);
+
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
         g_free(s->vhost_net);
@@ -636,13 +639,17 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
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
@@ -682,7 +689,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
 
         if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
+            vhostfd = cpr_get_fd_param(name, vhostfdname, index, &err);
             if (vhostfd == -1) {
                 error_propagate(errp, err);
                 goto failed;
@@ -693,7 +700,10 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 goto failed;
             }
         } else {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
+            vhostfd = cpr_find_fd(name, index);
+            if (vhostfd < 0) {
+                vhostfd = open("/dev/vhost-net", O_RDWR);
+            }
             if (vhostfd < 0) {
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
@@ -703,6 +713,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 error_setg_errno(errp, errno, "Failed to set FD nonblocking");
                 goto failed;
             }
+            cpr_resave_fd(name, index, vhostfd);
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
         options.nvqs = 2;
@@ -721,6 +732,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     return;
 
 failed:
+    cpr_delete_fd_all(name);
     qemu_del_net_client(&s->nc);
 }
 
@@ -789,7 +801,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto out;
         }
 
-        fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
+        fd = cpr_get_fd_param(name, tap->fd, TAP_FD_INDEX(0), errp);
         if (fd == -1) {
             ret = -1;
             goto out;
@@ -812,13 +824,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
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
@@ -849,7 +862,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(monitor_cur(), fds[i], errp);
+            fd = cpr_get_fd_param(name, fds[i], TAP_FD_INDEX(i), errp);
             if (fd == -1) {
                 ret = -1;
                 goto free_fail;
@@ -878,7 +891,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              script, downscript,
                              tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
+                             vnet_hdr, fd, TAP_VHOSTFD_INDEX(i), &err);
             if (err) {
                 error_propagate(errp, err);
                 ret = -1;
@@ -906,9 +919,12 @@ free_fail:
             goto out;
         }
 
-        fd = net_bridge_run_helper(tap->helper,
-                                   tap->br ?: DEFAULT_BRIDGE_INTERFACE,
-                                   errp);
+        fd = cpr_find_fd(name, TAP_FD_INDEX(0));
+        if (fd < 0) {
+            fd = net_bridge_run_helper(tap->helper,
+                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
+                                    errp);
+        }
         if (fd == -1) {
             ret = -1;
             goto out;
@@ -928,13 +944,15 @@ free_fail:
 
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
+        cpr_resave_fd(name, TAP_FD_INDEX(0), fd);
+
     } else {
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
@@ -959,8 +977,11 @@ free_fail:
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
-                              ifname, sizeof ifname, queues > 1, errp);
+            fd = cpr_find_fd(name, TAP_FD_INDEX(i));
+            if (fd < 0) {
+                fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
+                                ifname, sizeof ifname, queues > 1, errp);
+            }
             if (fd == -1) {
                 ret = -1;
                 goto out;
@@ -978,17 +999,23 @@ free_fail:
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
                 ret = -1;
                 goto out;
             }
+            cpr_resave_fd(name, TAP_FD_INDEX(i), fd);
         }
     }
 
 out:
+    if (ret) {
+        cpr_delete_fd_all(name);
+    }
     return ret;
 }
 
-- 
1.8.3.1


