Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A51CC282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaOc-0000oR-9r; Tue, 04 Mar 2025 17:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOW-0000Th-54
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:44 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOU-0000yq-Cf
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:43 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOQ-00000000LXz-2Lms; Tue, 04 Mar 2025 23:05:38 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 10/36] migration/multifd: Split packet into header and RAM
 data
Date: Tue,  4 Mar 2025 23:03:37 +0100
Message-ID: <832ad055fe447561ac1ad565d61658660cb3f63f.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Read packet header first so in the future we will be able to
differentiate between a RAM multifd packet and a device state multifd
packet.

Since these two are of different size we can't read the packet body until
we know which packet type it is.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 55 ++++++++++++++++++++++++++++++++++++---------
 migration/multifd.h |  5 +++++
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 215ad0414a79..3b47e63c2c4a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -209,10 +209,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     memset(packet, 0, p->packet_len);
 
-    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
-    packet->version = cpu_to_be32(MULTIFD_VERSION);
+    packet->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
+    packet->hdr.version = cpu_to_be32(MULTIFD_VERSION);
 
-    packet->flags = cpu_to_be32(p->flags);
+    packet->hdr.flags = cpu_to_be32(p->flags);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
 
     packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
@@ -228,12 +228,12 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
                             p->flags, p->next_packet_size);
 }
 
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
+                                             const MultiFDPacketHdr_t *hdr,
+                                             Error **errp)
 {
-    const MultiFDPacket_t *packet = p->packet;
-    uint32_t magic = be32_to_cpu(packet->magic);
-    uint32_t version = be32_to_cpu(packet->version);
-    int ret = 0;
+    uint32_t magic = be32_to_cpu(hdr->magic);
+    uint32_t version = be32_to_cpu(hdr->version);
 
     if (magic != MULTIFD_MAGIC) {
         error_setg(errp, "multifd: received packet magic %x, expected %x",
@@ -247,7 +247,16 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
-    p->flags = be32_to_cpu(packet->flags);
+    p->flags = be32_to_cpu(hdr->flags);
+
+    return 0;
+}
+
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    const MultiFDPacket_t *packet = p->packet;
+    int ret = 0;
+
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
@@ -1165,14 +1174,18 @@ static void *multifd_recv_thread(void *opaque)
     }
 
     while (true) {
+        MultiFDPacketHdr_t hdr;
         uint32_t flags = 0;
         bool has_data = false;
+        uint8_t *pkt_buf;
+        size_t pkt_len;
+
         p->normal_num = 0;
 
         if (use_packets) {
             struct iovec iov = {
-                .iov_base = (void *)p->packet,
-                .iov_len = p->packet_len
+                .iov_base = (void *)&hdr,
+                .iov_len = sizeof(hdr)
             };
 
             if (multifd_recv_should_exit()) {
@@ -1191,6 +1204,26 @@ static void *multifd_recv_thread(void *opaque)
                 break;
             }
 
+            ret = multifd_recv_unfill_packet_header(p, &hdr, &local_err);
+            if (ret) {
+                break;
+            }
+
+            pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
+            pkt_len = p->packet_len - sizeof(hdr);
+
+            ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
+                                           &local_err);
+            if (!ret) {
+                /* EOF */
+                error_setg(&local_err, "multifd: unexpected EOF after packet header");
+                break;
+            }
+
+            if (ret == -1) {
+                break;
+            }
+
             qemu_mutex_lock(&p->mutex);
             ret = multifd_recv_unfill_packet(p, &local_err);
             if (ret) {
diff --git a/migration/multifd.h b/migration/multifd.h
index cf408ff72140..f7156f66c0f6 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -69,6 +69,11 @@ typedef struct {
     uint32_t magic;
     uint32_t version;
     uint32_t flags;
+} __attribute__((packed)) MultiFDPacketHdr_t;
+
+typedef struct {
+    MultiFDPacketHdr_t hdr;
+
     /* maximum number of allocated pages */
     uint32_t pages_alloc;
     /* non zero pages */

