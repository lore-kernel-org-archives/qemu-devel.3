Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5E4CA0FE4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0FH-0007Nh-VI; Fri, 30 Aug 2024 07:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FD-0007JK-JQ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sk0FA-0002rI-Aq
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:56:47 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U8J4QJ024207;
 Fri, 30 Aug 2024 11:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=YykiUFUS3fjKKIu1+BZQB3cUpbX+vd0IQVv6qwmtIgE=; b=
 fH6eIu9dEx6BwCD4cyxN6lO4p+APhwqF/V8i/0v69KoX5FykkPNMsWvMBKQ36Hfh
 7LOBqQAkYPKWwIFXpkAx1Zda3BMRPWQRj5wB341smNaic/YZvSu48lnO4ZhgskgA
 cKpPapkSOJpfxG7eM1huW0d8tcgE5m/y3ir+4gylZ7qZd2tXAmhiu98Ce3dCiC9e
 Vb/zys3UpnCxls84vDFtSImSQWjfvOQk0ntAmDjbssXzBvVmI/JFpL1lnbSo+C+z
 Sz7pNYN9tN+60UzyzfRmWjZK9gJETG6Vhhn8fzEx/yhU1lzt5GSu5Wq3JFXzMXRu
 Hu3/lZEn9fKEaQSJJWhXBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugxg19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UBTMmO036757; Fri, 30 Aug 2024 11:56:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4189jpg9bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47UBucxK028887;
 Fri, 30 Aug 2024 11:56:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4189jpg9ae-3; Fri, 30 Aug 2024 11:56:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Euan Turner <euan.turner@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 2/6] tap: common return label
Date: Fri, 30 Aug 2024 04:56:33 -0700
Message-Id: <1725018997-363706-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Cx-TmqVeJ5LluYpH3yQJxGrHt7HkuqUD
X-Proofpoint-ORIG-GUID: Cx-TmqVeJ5LluYpH3yQJxGrHt7HkuqUD
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

Modify net_init_tap so every return branches to a common label, for
common cleanup in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 net/tap.c | 54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 51f7aec..8deabcb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -774,7 +774,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
      * For -netdev, peer is always NULL. */
     if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
         error_setg(errp, "Multiqueue tap cannot be used with hubs");
-        return -1;
+        ret = -1;
+        goto out;
     }
 
     if (tap->fd) {
@@ -784,25 +785,29 @@ int net_init_tap(const Netdev *netdev, const char *name,
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "helper=, queues=, fds=, and vhostfds= "
                        "are invalid with fd=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
             error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
                              name, fd);
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
@@ -811,7 +816,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         if (err) {
             error_propagate(errp, err);
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
     } else if (tap->fds) {
         char **fds;
@@ -824,7 +830,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "helper=, queues=, and vhostfd= "
                        "are invalid with fds=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fds = g_new0(char *, MAX_TAP_QUEUES);
@@ -888,30 +895,35 @@ free_fail:
         }
         g_free(fds);
         g_free(vhost_fds);
-        return ret;
+        goto out;
+
     } else if (tap->helper) {
         if (tap->ifname || tap->script || tap->downscript ||
             tap->has_vnet_hdr || tap->has_queues || tap->vhostfds) {
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "queues=, and vhostfds= are invalid with helper=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fd = net_bridge_run_helper(tap->helper,
                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
                                    errp);
         if (fd == -1) {
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
             error_setg_errno(errp, errno, "Failed to set FD nonblocking");
-            return -1;
+            ret = -1;
+            goto out;
         }
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
@@ -920,14 +932,16 @@ free_fail:
         if (err) {
             error_propagate(errp, err);
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
     } else {
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         if (!script) {
@@ -948,14 +962,16 @@ free_fail:
             fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
-                return -1;
+                ret = -1;
+                goto out;
             }
 
             if (queues > 1 && i == 0 && !tap->ifname) {
                 if (tap_fd_get_ifname(fd, ifname)) {
                     error_setg(errp, "Fail to get ifname");
                     close(fd);
-                    return -1;
+                    ret = -1;
+                    goto out;
                 }
             }
 
@@ -966,12 +982,14 @@ free_fail:
             if (err) {
                 error_propagate(errp, err);
                 close(fd);
-                return -1;
+                ret = -1;
+                goto out;
             }
         }
     }
 
-    return 0;
+out:
+    return ret;
 }
 
 VHostNetState *tap_get_vhost_net(NetClientState *nc)
-- 
1.8.3.1


