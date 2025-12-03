Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B831D1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrws-0007U2-C9; Wed, 03 Dec 2025 13:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwp-0007R4-Ka
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:31 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwn-0000zV-6M
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:31 -0500
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B33Ma8C3199729; Wed, 3 Dec 2025 18:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=2tqwxUShjbp6xB29PdE2LrVae4u2i8bzJmQKHr4yHxs=; b=FZMpFX+iioNV
 Rg45FYoki05zTp5henKbiAIpGCw5BcyXNWDzpX/5CTAO2xNY3UsPhWEgdmI0nyC2
 yzC/szCm5p6anXvyfXAy+VZmxnL+m432x9lbdf15AxJBEj5syv8SHAfPqQdPFbKM
 uy1VRSnpPAKo4B8UCadAwDBBB0uQLV0/90yJeBM2BUGi/ZopiLg2HFFzZn0FHC1d
 8wX1O6FhEeoE5dfrq3zRrA6cjwfHlmWRh3Qnoo2leWbdMUCtMHujwMFmuJfiakBl
 kNrIs88IGsrFTlzx6pFWyKeNQhdCOstgQ+qXT4cHeMN1nedTPnkeJh/8xkU8PN7f
 1QkgP3TSFw==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aswun4wr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 18:51:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FlNNc025617; Wed, 3 Dec 2025 13:51:27 -0500
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4aqw21kuh9-1;
 Wed, 03 Dec 2025 13:51:26 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id C885EB1;
 Wed,  3 Dec 2025 18:51:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:51:25 -0500
Subject: [PATCH v3 8/8] tap: cpr fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-8-3c12e0a61f8e@akamai.com>
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
 Steve Sistare <steven.sistare@oracle.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787886; l=3243;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=zPYWBDaP+GisG/WA7Z9aDp07+oXAyy1rWdyxkJgQ9vw=;
 b=sBJh/idUqjxmDyH9Pr7QzvSgVio9NhZuQGQeVDKCNcACRT+mG5c5YzFhYxDlufOU/KEKILuXA
 sRe+xn5pkJUBiJrzjX3ij6kFG9YyITMukBLNRFRd7QMtCYzQ//FK1OQ
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX4As9gSnRRMUa
 XKqWC5ZRt8vwsQXf+rhRK5OW2lMtLGPrp3eZ88dCSXhC4UJOe51Oax74+gs8LlyODxjtS4oMfvT
 /DClhltHM3LBc0yVn6V5M0uO15KHPtd7Vv6E7nKT6S/lHBZncUpLIfi/Jf8mDGRW4mFOpS2NwyR
 1tTLyaNQzfAd0vhnYYlL0TbT/JNfmCXrjhr1umQW3FT5jHwpGyxLlboKkghUebuR6UzXTwCxXg2
 wejQikXhtCzjCgrxX9rE4RpOW4Tdl+qVKlaktlyXjjwkds403oNgOFTxI2ChELrhEz2ms1K9iJu
 wglZhx8+TzfU8+Vxi8qY3a24qM0yd3KJ6QK3BJV39RTOih7AIW+v9tBqc7vLgWs4CJvlkCFDOev
 5LXRTFAYlRIV18IAGVX8pczyYXtwiA==
X-Proofpoint-ORIG-GUID: avPUBhxORbzDmo4WerdgI9EGyKQVXxFF
X-Authority-Analysis: v=2.4 cv=O+o0fR9W c=1 sm=1 tr=0 ts=693086af cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=6R7veym_AAAA:8 a=MOkVEwTOFFmkGxDkLR0A:9
 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: avPUBhxORbzDmo4WerdgI9EGyKQVXxFF
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
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


