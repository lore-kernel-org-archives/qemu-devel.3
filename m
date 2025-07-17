Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4756DC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVZq-0000oY-4W; Thu, 17 Jul 2025 16:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTWA-00006u-Im
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW5-000098-7Z
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0kGn019010;
 Thu, 17 Jul 2025 18:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=eSNzcugpJDUELIC5DRj7TTBvV/Xir0IRT2uoMB+BwnI=; b=
 RaEN3CgBQWMDib62Av8EbVIJl++i5vlhMJc7trRJ8F4fWLyxLSi3jyjmHB+J2ta3
 VK20DYQavWoq1dd4hgy0TDsRdTk47ZEBtm0SW1/5sseLhAbCLd1fqbFIWaNhv1mF
 jtZZoxNGPzzf1cvRCqc+4aWarRTRmh3v+NfxDTsAIKkPL6ZDZ/puiQsJzwlD+8vP
 VpYf1hYA9Zky5zIhk5XOFcVE8bhN2EvXMsOlOHdnFAVBT3Mn+SueYQ9FOAciglOC
 J5p+eYorcNxUe7r04B7LYRzPFTq4kb+9CQ11AX2Wgf6Qc373dfyr1n5GiUTPYmpr
 7963Xtn2lVa3F45wIiLKzg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83ybd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HHZgwK023985; Thu, 17 Jul 2025 18:39:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2tay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoit007425;
 Thu, 17 Jul 2025 18:39:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-7; Thu, 17 Jul 2025 18:39:32 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 6/8] tap: common return label
Date: Thu, 17 Jul 2025 11:39:26 -0700
Message-Id: <1752777568-236368-7-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68794366 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=zPeY32rCmRbJBjnbAY4A:9
X-Proofpoint-ORIG-GUID: Zgn7E2gluDKCN_Rwgh-UxEcF0aTfhg5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX3RldsngSgD9N
 0JLhOJxXVI/PKGMDnjpvtDPswtyhSa7abvBkZ9rREN9paTgqheXuXQj6Gxb7hI2XsUVift4VxNl
 Xqw3D4q7oeqyBtAfUHefMKMqLJfczOJCElaBex5tBZhQtDa56Qli/DdH3jb9Zm33Ae1+1p3nfIa
 JA67EQiYW/9aZ/92XjKVcHfwtHZMiyE/Jw7suvKT8fVYpdC79sI+Scg24jY4aCd/jZhD4jRpDYO
 vY/FBFVKVZEkeq89mvLtJgvgg6rWNfmW4x12igOwzjEnxMIxhd5fX9zO79+q4SYSSDHkTo/arB+
 Q4vneTM/xuCioDOPgT1MJ9DnccxU+yXdtzE3y2vf9H7PG+ugaaaQW1sYWKJkEoDOpZa4u+QHE8y
 lOIejllFErdsD1kW4CPv/X3oPAZDzy/vSx9YUghdwBTQQm/vdw1oN6pl2pdlzUXAQanzulTG
X-Proofpoint-GUID: Zgn7E2gluDKCN_Rwgh-UxEcF0aTfhg5L
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

Modify net_init_tap so every return branches to a common label, for
common cleanup in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 net/tap.c | 54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 35552c4..1b239fd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -780,7 +780,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
      * For -netdev, peer is always NULL. */
     if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
         error_setg(errp, "Multiqueue tap cannot be used with hubs");
-        return -1;
+        ret = -1;
+        goto out;
     }
 
     if (tap->fd) {
@@ -790,25 +791,29 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -817,7 +822,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         if (err) {
             error_propagate(errp, err);
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
     } else if (tap->fds) {
         char **fds;
@@ -830,7 +836,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "helper=, queues=, and vhostfd= "
                        "are invalid with fds=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fds = g_new0(char *, MAX_TAP_QUEUES);
@@ -894,30 +901,35 @@ free_fail:
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
@@ -926,14 +938,16 @@ free_fail:
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
@@ -954,14 +968,16 @@ free_fail:
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
 
@@ -972,12 +988,14 @@ free_fail:
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


