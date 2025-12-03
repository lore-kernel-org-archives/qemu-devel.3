Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78562D1BDD2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpP-0001j8-OX; Wed, 03 Dec 2025 13:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpJ-0001gX-TW
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:45 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hG-9U
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:45 -0500
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
 by m0050102.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B38t2Gb3356703
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=2tqwxUShjbp6xB29PdE2LrVae4u2i8bzJmQKHr4yHxs=; b=aXE+96i1w2SG
 /SFo9fIZwJ63hYM0Tt8g8Fx9zpyZxRogi/N92sObt/TVAiL4uZeH8D9hWZkMFnr9
 osHyMDViSXtw/eLmLUYFdrORxtVpMhtMdel/mdcqzx9wOD2J7T00NvVbNmnsvVDd
 zhf65QKB+duPRyZPN5Nz3gMEFFjTIPqYv3KZLrQ2F/dCSL1SG9wB4LbqYg+ZtnOm
 WrGsdnMyMk7rEOzkvOWNwDnVBd4LqJUy226BXJJBue9ojEiY9SZyFkd/KqQSogdi
 WAzYOXDNW+uYaTaQ1b6GsgiWtY8KEpk5C7nGasSPI7sh+8x3VMzAI3SyKaDE7VbD
 qNk/Op39SQ==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 4at1wwjahr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3F5lqu013415
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 13:43:38 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4aqw21kx8f-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 13:43:38 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 4AB7F9A
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:43:29 -0500
Subject: [PATCH v3 8/8] tap: cpr fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-8-3cc89e9b19e4@akamai.com>
References: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=3243;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=zPYWBDaP+GisG/WA7Z9aDp07+oXAyy1rWdyxkJgQ9vw=;
 b=YLbhfEKTPKOw1E5Wu2f4OfUxksPTaCMFq3bL2uNAsqcaOM9thMj/RYamouWALJHxBhlQ6mY28
 fjxynlxkc6IC+J2J6ly8X/zeLPhV+jDny0Nh26RWdCC7m+gY32PFg2s
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
X-Proofpoint-ORIG-GUID: xjoHhUPw4zGn1QW5jvq_oVp7ie5k0eJb
X-Authority-Analysis: v=2.4 cv=EffFgfmC c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=6R7veym_AAAA:8 a=MOkVEwTOFFmkGxDkLR0A:9
 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: xjoHhUPw4zGn1QW5jvq_oVp7ie5k0eJb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX/iQeGB1ymNbM
 SdeT7yTvIXMvTHbgGIBdVcjH+I8bqVud1Qzxr+zLlQuGYPQT7FIZNI/Su0X0h903hwsFVJa2qPm
 O1g+5ZU8KsfNrt+if6EIhkrYK8r7dDbm8QYeJCQiqECGCJhZ4b9+Ge2rBgfarYmqSctIo6frq6d
 m0DNKKu00MxZuAcf2oUpJOZnHAYYHmD1yhc5Svqa0RFoKbkHxquLazmg5IM1B5ke2OHZVNQIUW6
 IVttY217rJ9CrUEwF2k/jha3VSBWq/rPah+Xubq4Njv/rqln1mpcTm6W3lKkH1OJ6hFC1hoDLLm
 f2ykq5iKYKNVtFn4GqQbLlIB7adERcXtcHSxukMJgCK/D60PPQFpsfyyA7ZtRMWYxsC7SzJh4cr
 Xo+5pqjQ2D7Sxp0S83gWQUzlp/sdJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
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

Fix "virtio_net_set_queue_pairs: Assertion `!r' failed."
Fix "virtio-net: saved image requires vnet_hdr=on"
Do not change blocking mode of incoming cpr fd's.

Reported-by: Ben Chaney <bchaney@akamai.com>
Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 hw/net/virtio-net.c | 6 ++++++
 io/channel-socket.c | 4 +++-
 net/tap.c           | 2 ++
 stubs/cpr.c         | 8 ++++++++
 stubs/meson.build   | 1 +
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38ec7ac109..fd6b30b296 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -37,6 +37,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
@@ -789,6 +790,11 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
     int i;
     int r;
 
+    if (cpr_is_incoming()) {
+        /* peers are already attached, do nothing */
+        return;
+    }
+
     if (n->nic->peer_deleted) {
         return;
     }
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..443ca8cb7c 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -24,6 +24,7 @@
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "io/channel-watch.h"
+#include "migration/cpr.h"
 #include "trace.h"
 #include "qapi/clone-visitor.h"
 #ifdef CONFIG_LINUX
@@ -521,7 +522,8 @@ static bool qio_channel_handle_fds(int *fds, size_t nfds,
 
         if (!preserve_blocking) {
             /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-            if (!qemu_set_blocking(*fd, true, errp)) {
+              if (!cpr_is_incoming() &&
+                  qemu_set_blocking(*fd, true, errp)) {
                 return false;
             }
         }
diff --git a/net/tap.c b/net/tap.c
index 5acda81146..5e04099c87 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -1050,6 +1050,8 @@ free_fail:
                 if (cpr && fd >= 0) {
                     cpr_save_fd(name, TAP_FD_INDEX(i), fd);
                 }
+            } else {
+                vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
             }
             if (fd == -1) {
                 ret = -1;
diff --git a/stubs/cpr.c b/stubs/cpr.c
new file mode 100644
index 0000000000..1a4dbbb2d7
--- /dev/null
+++ b/stubs/cpr.c
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "migration/cpr.h"
+
+bool cpr_is_incoming(void)
+{
+    return false;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 0b2778c568..87af733528 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -10,6 +10,7 @@ stub_ss.add(files('is-daemonized.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('trace-control.c'))
+stub_ss.add(files('cpr.c'))
 
 if have_block
   stub_ss.add(files('bdrv-next-monitor-owned.c'))

-- 
2.34.1


