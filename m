Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586F9D46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKk-0008KO-4R; Wed, 28 Jan 2026 15:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKK-0007au-Dg
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKH-00084g-4K
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:48 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 60SCrUB43813605; Wed, 28 Jan 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=EnOnlaaVzC0OpclLnA+dVUJZIShPIfiEyU9wHJb1UAQ=; b=MS7ouQ+LJPia
 w9n6ImcrRS4/W+SKJrSkigEBKibD6F1ozGlJzktjp10j+I12hW+AsbpT7mcUNzuR
 yda4rckwsQAYKMuOT3BzD1+If1WxPnkxpmjeY5KJhUB63DichdaIlGphgEFMiBZw
 Tx2FvfhNeQKqpAlG3LPh23v5II/bgkUrdZ7Mqs6dC2Ts6qdk5rG2I1NzbIlitsMw
 qIclK2U4jHcpGKDkERaaAw+plJnkctXoNbPt8jP8wV1parkwDczZz9jqVWS22mDn
 1gIfnjt41PKcQ9E9J+zYlHt2ipImOt2n5191UwjrVeOJ1txS5aGLKEGKOglJUCVj
 PAfKdlwT0g==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4by2u0y6ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:41 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SGBOwZ009288; Wed, 28 Jan 2026 15:39:40 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4bvta3g7y5-1;
 Wed, 28 Jan 2026 15:39:40 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 11EF5AB;
 Wed, 28 Jan 2026 20:39:39 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 28 Jan 2026 15:39:33 -0500
Subject: [PATCH v4 5/8] tap: common return label
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-cpr-tap-v4-5-48e334d4216b@akamai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=5311;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=2vMdreTfPH40hZnJ0QljVZZ8eyp+SeereXjfUBOb/Xw=;
 b=wQ5rpcj4JeCcEP5BROYcDM6T2/ShIBJlucf1W6QRnM+6tK4yiFTA3WN3f21x5a8fofyqnep8M
 fJLtWxo7ko/BkOGVIybjGhdhX6JQcz4OK3boPil5Ht0aFbNUBukXRUR
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
X-Authority-Analysis: v=2.4 cv=OOkqHCaB c=1 sm=1 tr=0 ts=697a740d cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=zPeY32rCmRbJBjnbAY4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: K-MOrO30px7SrcOBLViwRNo6ZqOV37Ud
X-Proofpoint-GUID: K-MOrO30px7SrcOBLViwRNo6ZqOV37Ud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfX4ikoEm7KZtIM
 T9TodWIa0G2x9jRvAmnaJot/KzQaaEX7ehL5UBVAmLOar7z1FRuJgVOCrHhdL6nW68SpHFfNR+X
 JoHSb5MSsjFj4HdGMqAJL3DGUdoPgVnO0YxKE5C3AXmPH/BVrERwwSE+SAJ8ANBMVhuygz2YiPV
 GFbfMcdeH1p1gLGv+ID1KDMBTHGNS7cL6fD0iDN0T+k8iFRjbilNYb3qUNdrU5xueGPxSbx+Diy
 Um8876s/z350ihCdw/INE8W3/IH9FHq1rSmsV6rU0urQWV5nagRkjWN3yCc0xsP8LIf7E9ez4bb
 Iqzo19xC78uJwXIqiu7PTNIXUxAF0+26XXhYJyUw582CjLIFMgDE0C6wdWcPgFAHhRayfvz6D+0
 JOi8kCPFExHPd4lwFlX3j8d5QqyIYtAdRkbG/9wGo8yC2CJz79i8Ul60ouOdxIJcETHEfFhJ2Ff
 XUoqIXjWZGZWEFC1xrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280170
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Modify net_init_tap so every return branches to a common label, for
common cleanup in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 55 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index bfba3fd7a7..1847167e4f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -829,7 +829,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
      * For -netdev, peer is always NULL. */
     if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
         error_setg(errp, "Multiqueue tap cannot be used with hubs");
-        return -1;
+        ret = -1;
+        goto out;
     }
 
     if (tap->fd) {
@@ -839,23 +840,27 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
 
         if (!qemu_set_blocking(fd, false, errp)) {
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
@@ -864,7 +869,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         if (err) {
             error_propagate(errp, err);
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
     } else if (tap->fds) {
         char **fds;
@@ -877,7 +883,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "helper=, queues=, and vhostfd= "
                        "are invalid with fds=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fds = g_new0(char *, MAX_TAP_QUEUES);
@@ -939,29 +946,35 @@ free_fail:
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
 
         if (!qemu_set_blocking(fd, false, errp)) {
-            return -1;
+            close(fd);
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
@@ -970,14 +983,16 @@ free_fail:
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
@@ -998,14 +1013,16 @@ free_fail:
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
 
@@ -1016,12 +1033,14 @@ free_fail:
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
 
 int tap_enable(NetClientState *nc)

-- 
2.34.1


