Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32327D46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKh-0007zL-Ac; Wed, 28 Jan 2026 15:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKK-0007at-C9
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKG-00084f-UX
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:48 -0500
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 60SIs2g12689064; Wed, 28 Jan 2026 20:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=69oowmfGBBkxto45rQliLKa5kUPav6LIeURmLosLpL4=; b=lrC6kS2ZHR9t
 rkpmePePKzSm95WAVJgOm9/rbJncemzoHU+c+AsGVhw+bBP4CNVQyjo7ZQ3+A9hY
 7TWisVvmf6H5gITjcxLjRA6yjCQfettnvmbUOy095+/jgz2eK290Ku3GAA+jdknl
 kdNK3dDripK2spMPtYO7RFV+Yq9pd7MAanz5kKk2rYvDehz4COVJO+XMxlHS5XxB
 xvmTfrEYwTWH6JoBcDUeb7oQbSWtHSMcoXLSeSCjE9+fDHIF3j2RjVennyZTfvyL
 TDusvwTwTe0gVm8ffb86DUvlK2oVi6/Yp7PXYg1yfMH61/Qz98oJ9B5QjjDD58CL
 OV44EzRbcg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4bypguk8pt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:41 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SIYCkX028880; Wed, 28 Jan 2026 15:39:40 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4bvta3g7y4-1;
 Wed, 28 Jan 2026 15:39:40 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 19F3FB3;
 Wed, 28 Jan 2026 20:39:39 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 28 Jan 2026 15:39:35 -0500
Subject: [PATCH v4 7/8] tap: postload fix for cpr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-cpr-tap-v4-7-48e334d4216b@akamai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=3307;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=y3Xxt4dRCKG5jHG1T2Jwbz9e9N+8cAe17JOL6mau9ac=;
 b=xs2C1EDZtANvhWWwZN0TkQtY/feQ6x80qIQlJgXcpAo/ckR8Va0Y1ePgL3bLUmrzV03cZwDsO
 megkj0AbKksBmeR/FMcAgy9SJbpXWOiJCaUOEDdy+R2CNzAfdh2ZVFR
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
X-Proofpoint-GUID: hpNE29YmUXVp6nHI3lXGrEFtCqkL-oZJ
X-Authority-Analysis: v=2.4 cv=bfVmkePB c=1 sm=1 tr=0 ts=697a740d cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=h1OFwVCXqnWUJWdIchYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hpNE29YmUXVp6nHI3lXGrEFtCqkL-oZJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfXyLbgko4ZpUKp
 lHm38TGmI/oYYtTLhGFykhPhsgkUujtkb6yT1nX9nuG4hxW73iJ4nC6FrgwGIBjlVZ3Vk8XHsA5
 NU9amzMvavnc9oTrcW9ER4J60Ha0SpC37EjCfQ64P6RXeOa/BIx5/ZB08+bB4corRHybTUb0fA2
 IvmzXzjfTrhn3nc6lWq6Qxxy/jXQzC+mFAHq98Wp7i2WnoUXSTtFUVMJC3ZqYO8xQbXj5sWAIiN
 IVg16Y3i17m8PtwA3ou9G2+r5wKBLl84Z68D5FrmNna2yUd2Yfk3XwY3bVPYXO1QsnRCvLtlKBd
 V597FCm5j/pWB8D0fLdzaGzHjxcrALpSjXE9xZ4FwXho0A/O58oRB/EraT3dQXiiPD4EQQyqCHh
 v5X9zHS5cjnpkfZjK/I2lL/OVcRvq0oqJlQt7STr8zDvcTNY09J/ZC237uCXtC4bNbYnWrQaFY8
 +e+B2r+99k3YA209rXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280170
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 317f1ad23b..bb7c8d9b78 100644
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
@@ -3210,6 +3229,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
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
index 8875498434..2961607cda 100644
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


