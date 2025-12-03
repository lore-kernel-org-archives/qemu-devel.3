Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE4D1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpT-0001lD-3t; Wed, 03 Dec 2025 13:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpL-0001hV-57
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:47 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hC-8S
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:46 -0500
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3I6NhR980940
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=QoR6CzW42yFuzK4C/5cibENCPr6ROAzmTT9DkEW4Iy8=; b=cJTr6tVwlxcx
 Ln1CwlcsZyAlbcvxku6XFhF5Utfp+uazm2hXPg+W8Sb414UV0ATns3J4K+TaQzUQ
 Ho29UlSyDcnBcr70oiopYoXv14WoikpxreWH/paSE/5C1L72TVbSx+uESWMm9tDn
 kE3MgbJuQqH+7xLymYYXWTqnICj10AjM9wp4D3Xl0nELIcfsniOejXLakJMIr0AY
 AT4Ux8oXzrCcOHHp8sESF4iZE+vUO64vak/zfluGkp/G+hXfWOSdEcSnaQ9lj/iK
 Crm4Jb97+xozzvef7RxaqdYaEalz2JEoEgkf2wEXiANp37vM6ajSArtWAoQ4Hsge
 4DpFu/V6JA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aswun4u6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FId4q013420
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 13:43:38 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4aqw21kx8e-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 13:43:38 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 49EEC99
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:43:28 -0500
Subject: [PATCH v3 7/8] tap: postload fix for cpr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-7-3cc89e9b19e4@akamai.com>
References: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=3307;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=trjqxlGTjzbMkDT7mRMw3NXMaJd7F2w+gOl7JrhHwFU=;
 b=xiRtR9bMqe91YsEssJiS9eCrb6s34M3UIBl0tEopYQ5oqVqm8+6yBcXqIDKTyQDsdg+TKC/Ww
 U+UqfvGaaElAv4/HnsnFtX5vOfAsF6kqICNI8gto8sbQ5piGA9sTyc8
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX0oeDVIOcog9K
 yiCYVPxwqyAwZl1Q2pnfR+slo194iNA1ioa6T3xLfX+QhOBs0oWqJ1YY8h5oPR+8GF72a+ljBGV
 LHN1Gj9DyVHEWHKXWIHeSn5LqsZka3/P10UNJA9JnIinZd9jgSMtwRMUUMvDWFNGs6qlAsOJNPF
 XXRh0M/RIuAPJvXlLfIWARW4aNaGLuOpgLPvm623p9bvV4Hz3PAAPkBX1CM/wqCw31376QF2H7o
 Q02QYkdlFkBh5TawMGwK9wIGzGV0h6xzcBYgk3dWW2HulKtYU5p7IAP8kvwjD+ogbfW9ZcjhZ+/
 BZgINKQzHfh+YFyDSnEMw81STLzxXM4w2yfnlRZILmOt5EDfN4cYjUmBMrcJRdMHYemKYMjUjOE
 OnNk2ZRIiO3PpTXDsOAzfGf1MVS7nA==
X-Proofpoint-ORIG-GUID: XrZv3EPl5W0bwQHO6dOg25Tvm8yO-n85
X-Authority-Analysis: v=2.4 cv=O+o0fR9W c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=h1OFwVCXqnWUJWdIchYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XrZv3EPl5W0bwQHO6dOg25Tvm8yO-n85
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


