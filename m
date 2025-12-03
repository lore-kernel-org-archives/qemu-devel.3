Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689EDD1BDD0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrwu-0007Vg-Ql; Wed, 03 Dec 2025 13:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwr-0007TB-7l
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:33 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwo-0000zh-CM
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:33 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B35lAR22445836; Wed, 3 Dec 2025 18:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=QoR6CzW42yFuzK4C/5cibENCPr6ROAzmTT9DkEW4Iy8=; b=J/TL4B/XdrCh
 mIXXuUu8/k5TcGNg38c3pbGb+5z2sdBGoW4nZcKpH/ti0xaRcDN7iF3pGJ2aj+z0
 Dn6tsyXl/28GB7bg66oKPLZV0aFXK+7kSvapOJWT+PGxE5jEXLNZGwWn9CbQdpmi
 /NpZIwOMWdNXnX1bdD0qoN02Mv0MIGiWYJ9by7z+0ZUW48PBLykxpWTDX3j25Xf0
 3aV9izqj5sJnfObHGNuAO1ap1BEm1qH7c6xWkAsiBEJ0PEnRHFQblD0k4B38zcdB
 epHYf9dgUnzMF+ZGe3FSI9zqmINpaizCjGXP7PRYU8FyedzDMI7ZxodHWOcLlHvt
 qT1xyeBI3w==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4at0bcqtuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 18:51:28 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FSw37013454; Wed, 3 Dec 2025 13:51:27 -0500
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4aqw21kxw4-1;
 Wed, 03 Dec 2025 13:51:27 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id C5108AD;
 Wed,  3 Dec 2025 18:51:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:51:24 -0500
Subject: [PATCH v3 7/8] tap: postload fix for cpr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-7-3c12e0a61f8e@akamai.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787886; l=3307;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=trjqxlGTjzbMkDT7mRMw3NXMaJd7F2w+gOl7JrhHwFU=;
 b=KASaKdIYRViwhLCPvoDl/4aura5SsKK/BZNj31N/hBE561HUCpLeNJeLCwgPNXoTRiVtXjvEX
 dbVbbFNRxZiBydr31kfBj6DJK1sZ4/Nqq74psOVaLl9fGGbwG/Lb3rq
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030148
X-Authority-Analysis: v=2.4 cv=AvfjHe9P c=1 sm=1 tr=0 ts=693086b0 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=h1OFwVCXqnWUJWdIchYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX7DDURGHGMDVc
 +fFyxPMaeFVcw5bL0e3AeOVVnqXl9VqAL/QECLBngotcgvv6SeY0ErUqp/gYTUrpKosW6A2UXS9
 2j2Nx7rsmc1vjfbWV0VhtdmV0gbUIlJDw7oKK8gqKrQdp83Bfx+NqfKrz9X+lCzOeZWQUdPWS2O
 HbPHVkFDKwV0lGh++bJgxbKQuzPuNuboyxRm42+4eY9qLjolf7Wuq6iXH8WY/PMGNuYIIheYNJ2
 4Alu2KhNKGWbKgSOSyV3ZNIqocGMrjO+TqUH+kk5TmUxqaCwBwsN0/A5hQXQhdgUgamrEfel723
 BxT++Nipv2eeoBlcgMUDsQ6V2zSTiVoeErF+F6140UlJP1nFf168WEIxGg4LlKoaypge3IvfBvj
 j8THIC6+rx1+3pgshE11oZu1ChDgmA==
X-Proofpoint-ORIG-GUID: mvYb3buKW0Na5AehXPWbGpI8XwXmzzb_
X-Proofpoint-GUID: mvYb3buKW0Na5AehXPWbGpI8XwXmzzb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

After cpr of a multi-queue NIC, if any queues are unused, then the
corresponding tap is marked enabled in userland, but it is disabled in the
kernel for the fd that was preserved.  One cannot call tap_disable() during
postload, because that eventually calls IFF_DETACH_QUEUE, which fails
because the queue is already detached.  Define tap_disable_postload to
avoid IFF_DETACH_QUEUE.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 hw/net/virtio-net.c | 20 ++++++++++++++++++++
 include/net/tap.h   |  1 +
 net/tap-win32.c     |  5 +++++
 net/tap.c           | 17 +++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3b85560f6f..38ec7ac109 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -765,6 +765,25 @@ static int peer_detach(VirtIONet *n, int index)
     return tap_disable(nc->peer);
 }
 
+/*
+ * Set the disabled flag on unused queue pairs after vmstate load, without
+ * calling IFF_DETACH_QUEUE, which fails because the queue is already detached.
+ */
+static void virtio_net_postload_queue_pairs(VirtIONet *n)
+{
+    int i;
+    MigMode mode = migrate_mode();
+
+    if (mode == MIG_MODE_CPR_TRANSFER) {
+        for (i = n->curr_queue_pairs; i < n->max_queue_pairs; i++) {
+            NetClientState *nc = qemu_get_subqueue(n->nic, i);
+            if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_TAP) {
+                tap_disable_postload(nc->peer);
+            }
+        }
+    }
+}
+
 static void virtio_net_set_queue_pairs(VirtIONet *n)
 {
     int i;
@@ -3212,6 +3231,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
      */
     n->saved_guest_offloads = n->curr_guest_offloads;
 
+    virtio_net_postload_queue_pairs(n);
     virtio_net_set_queue_pairs(n);
 
     /* Find the first multicast entry in the saved MAC filter */
diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae..934131f551 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -30,6 +30,7 @@
 
 int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
+void tap_disable_postload(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b..efe81c54ee 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -766,3 +766,8 @@ int tap_disable(NetClientState *nc)
 {
     abort();
 }
+
+void tap_disable_postload(NetClientState *nc)
+{
+    abort();
+}
diff --git a/net/tap.c b/net/tap.c
index 79e29addd1..5acda81146 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -1121,3 +1121,20 @@ int tap_disable(NetClientState *nc)
         return ret;
     }
 }
+
+/*
+ * On cpr restart, the tap is marked enabled in userland, but it might be
+ * disabled in the kernel, and IFF_DETACH_QUEUE will fail because it is
+ * already detached.  This function disables without calling IFF_DETACH_QUEUE.
+ */
+void tap_disable_postload(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    if (!s->cpr || s->enabled == 0) {
+        return;
+    } else {
+        s->enabled = false;
+        tap_update_fd_handler(s);
+    }
+}

-- 
2.34.1


