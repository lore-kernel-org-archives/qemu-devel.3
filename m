Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7617D46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKc-0007sA-Tk; Wed, 28 Jan 2026 15:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKM-0007dR-Fx
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKI-00084i-ET
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:49 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 60SAGYUs3466844; Wed, 28 Jan 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=teugPjqMDJr8JyTbcm4vnko9lD40Pv8XxkQ2AbWwh6A=; b=axZdJz8iDqkM
 QVQH6zQ5auqMRY5svW6qjLM1kAG2pAZKCu9jj0f6ojzMGXQuGVrtf/I2Td1ZrXiB
 fngQfm5Du+zMiUjUwcBowB8RJn5dqNnqi6VmXE+sEjCP5QDg/obED62pJXT8HDFM
 fwyiJTrIVDq382DhyvKsx8qgzYUGV+kQlyBd/2l3fXRwdCkjwk6/vW7S3g71NqhS
 XSpiNjYP1hGJu6ryyKRfrQJleHZC2kVN0TGWFLpkb8TU8x4aakfjpMJr0sLs6zNc
 JlsIiKpm8CsgSNHhYlui/c5LPpXiVcR6qdqUfijZxUAbiHeXnnV8r6XLN2UTmOai
 LIe593aKFw==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4by2u0y6ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:41 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SKJfQg004968; Wed, 28 Jan 2026 12:39:40 -0800
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4bvvxfyxxa-1;
 Wed, 28 Jan 2026 12:39:40 -0800
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 1D54DB7;
 Wed, 28 Jan 2026 20:39:39 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 28 Jan 2026 15:39:36 -0500
Subject: [PATCH v4 8/8] tap: cpr fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-cpr-tap-v4-8-48e334d4216b@akamai.com>
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
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Steve Sistare <steven.sistare@oracle.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=2369;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=Djgy+EkuKwl5Gk26qxzLKrDHhSTEbF4DP7c/wKdSHmU=;
 b=kl4zKJ6j86X4W/S2mGC06hzt4uc85hEp1D2fjlS0fb0nQb9XXvRdj2Hm9WJP7NzCivODc4cK8
 +28IljZQ/EsBLKtziEi7PiGdIyatPeXkqhx42j4C6Dg35HGJ6sVddT7
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280169
X-Authority-Analysis: v=2.4 cv=OOkqHCaB c=1 sm=1 tr=0 ts=697a740d cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=X7Ea-ya5AAAA:8 a=6R7veym_AAAA:8 a=yPCof4ZbAAAA:8 a=C-eOVxJW3LoQiB8EbVoA:9
 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: TTCwjWyAjwpsfMyA88YcCWbxPj4vqv02
X-Proofpoint-GUID: TTCwjWyAjwpsfMyA88YcCWbxPj4vqv02
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfX9v5Pet6DO2ON
 1skJhqImtiQDhG6+QWdSrrgb39mlOkcfbhQlD1av129h2fLUr1Oh9aEk5qriLFGCBjomaeCDxCJ
 9zpK4Zhh0rj9Qh7rXMhl00JxJ1jVNHRrvAfe/tmMYhukQ63bBWCW7mA/GpTTVEZUQZaf83RJ7FI
 Tlh215XhU8J2+X57pcGtLJK/Ws0H2td9+C0xOhVgiyTxD+MeQsTXBWVyWBfNR0DpCQLxxBZZ5EA
 5IjAhui//3PP6KUZwPKsxruJQ9iCDinOk4WTFDF4pl3m6OwxUxc7bsUyyDiQm5yq5bE3hiPbEM5
 RJN+uawqVXAqMTETaHRXR0T0zFVrw1pyoG2t8nJcQ2Xv/EoUlsKR7UcaYmkctImJ7Y0zdUig2BK
 8hTGJnERKOXnhdrjAKk+zQhoehuedz07bh/oKsVjnVeNBYvhrbI4+OTDMUGj/eV/GyfFB1jVVcK
 EULrVlsPmwgKpIp9EDA==
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

Fix "virtio_net_set_queue_pairs: Assertion `!r' failed."
Fix "virtio-net: saved image requires vnet_hdr=on"

Reported-by: Ben Chaney <bchaney@akamai.com>
Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 hw/net/virtio-net.c | 6 ++++++
 net/tap.c           | 2 ++
 stubs/cpr.c         | 8 ++++++++
 stubs/meson.build   | 1 +
 4 files changed, 17 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index bb7c8d9b78..7e809c37fc 100644
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
diff --git a/net/tap.c b/net/tap.c
index 2961607cda..b58072db99 100644
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
index 2b5fd8a88a..19c1932bbf 100644
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


