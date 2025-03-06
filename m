Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71A1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC2F-0001Ii-S9; Thu, 06 Mar 2025 09:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0v-0007q3-BA
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0q-0001r1-V5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmvjSK2wG1iCeODaoW8+kT8fos4M/jV8WwkpxI4oRg8=;
 b=Z4gsGyuLSsoCiEss95swSvgYpnfGcMDArzDpKx9fKAIDcuEutYzlx5Vi8ngdcuqV5zD+ty
 h5ibUjSoakPs/J98ewx28K2SE0Ba0zOpayf8PqStoKew6jBQ4XG730jP5libL/LNSVekxX
 cEaR6/grGS8m4bR2woX7iVhkDXcUeTs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-tn0YLadFO-K0cAoSgGuFew-1; Thu,
 06 Mar 2025 09:15:29 -0500
X-MC-Unique: tn0YLadFO-K0cAoSgGuFew-1
X-Mimecast-MFC-AGG-ID: tn0YLadFO-K0cAoSgGuFew_1741270529
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E00D1800349; Thu,  6 Mar 2025 14:15:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3361180174E; Thu,  6 Mar 2025 14:15:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/42] migration/multifd: Device state transfer support -
 receive side
Date: Thu,  6 Mar 2025 15:13:56 +0100
Message-ID: <20250306141419.2015340-21-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Add a basic support for receiving device state via multifd channels -
channels that are shared with RAM transfers.

Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
packet header either device state (MultiFDPacketDeviceState_t) or RAM
data (existing MultiFDPacket_t) is read.

The received device state data is provided to
qemu_loadvm_load_state_buffer() function for processing in the
device's load_state_buffer handler.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/9b86f806c134e7815ecce0eee84f0e0e34aa0146.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/multifd.h |  19 ++++++++-
 migration/multifd.c | 101 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 108 insertions(+), 12 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index f7156f66c0f6b3872c12af7ccdab55806509fac2..d682c5a9b74388bca7ea129d76646dc1e5fe1446 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -62,6 +62,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
 #define MULTIFD_FLAG_UADK (8 << 1)
 #define MULTIFD_FLAG_QATZIP (16 << 1)
 
+/*
+ * If set it means that this packet contains device state
+ * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
+ */
+#define MULTIFD_FLAG_DEVICE_STATE (32 << 1)
+
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
 
@@ -94,6 +100,16 @@ typedef struct {
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
 
+typedef struct {
+    MultiFDPacketHdr_t hdr;
+
+    char idstr[256];
+    uint32_t instance_id;
+
+    /* size of the next packet that contains the actual data */
+    uint32_t next_packet_size;
+} __attribute__((packed)) MultiFDPacketDeviceState_t;
+
 typedef struct {
     /* number of used pages */
     uint32_t num;
@@ -227,8 +243,9 @@ typedef struct {
 
     /* thread local variables. No locking required */
 
-    /* pointer to the packet */
+    /* pointers to the possible packet types */
     MultiFDPacket_t *packet;
+    MultiFDPacketDeviceState_t *packet_dev_state;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets received through this channel */
diff --git a/migration/multifd.c b/migration/multifd.c
index 3b47e63c2c4a6a65751b4eb4e9501a443695ff8f..01f427d8ed036417559a0573d369172f72b508e1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -21,6 +21,7 @@
 #include "file.h"
 #include "migration.h"
 #include "migration-stats.h"
+#include "savevm.h"
 #include "socket.h"
 #include "tls.h"
 #include "qemu-file.h"
@@ -252,14 +253,24 @@ static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
     return 0;
 }
 
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+static int multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
+                                                   Error **errp)
+{
+    MultiFDPacketDeviceState_t *packet = p->packet_dev_state;
+
+    packet->instance_id = be32_to_cpu(packet->instance_id);
+    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
+
+    return 0;
+}
+
+static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
 {
     const MultiFDPacket_t *packet = p->packet;
     int ret = 0;
 
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
-    p->packets_recved++;
 
     /* Always unfill, old QEMUs (<9.0) send data along with SYNC */
     ret = multifd_ram_unfill_packet(p, errp);
@@ -270,6 +281,17 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     return ret;
 }
 
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    p->packets_recved++;
+
+    if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
+        return multifd_recv_unfill_packet_device_state(p, errp);
+    }
+
+    return multifd_recv_unfill_packet_ram(p, errp);
+}
+
 static bool multifd_send_should_exit(void)
 {
     return qatomic_read(&multifd_send_state->exiting);
@@ -1057,6 +1079,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
+    g_clear_pointer(&p->packet_dev_state, g_free);
     g_free(p->normal);
     p->normal = NULL;
     g_free(p->zero);
@@ -1158,6 +1181,34 @@ void multifd_recv_sync_main(void)
     trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
 }
 
+static int multifd_device_state_recv(MultiFDRecvParams *p, Error **errp)
+{
+    g_autofree char *dev_state_buf = NULL;
+    int ret;
+
+    dev_state_buf = g_malloc(p->next_packet_size);
+
+    ret = qio_channel_read_all(p->c, dev_state_buf, p->next_packet_size, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (p->packet_dev_state->idstr[sizeof(p->packet_dev_state->idstr) - 1]
+        != 0) {
+        error_setg(errp, "unterminated multifd device state idstr");
+        return -1;
+    }
+
+    if (!qemu_loadvm_load_state_buffer(p->packet_dev_state->idstr,
+                                       p->packet_dev_state->instance_id,
+                                       dev_state_buf, p->next_packet_size,
+                                       errp)) {
+        ret = -1;
+    }
+
+    return ret;
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MigrationState *s = migrate_get_current();
@@ -1176,6 +1227,7 @@ static void *multifd_recv_thread(void *opaque)
     while (true) {
         MultiFDPacketHdr_t hdr;
         uint32_t flags = 0;
+        bool is_device_state = false;
         bool has_data = false;
         uint8_t *pkt_buf;
         size_t pkt_len;
@@ -1209,8 +1261,14 @@ static void *multifd_recv_thread(void *opaque)
                 break;
             }
 
-            pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
-            pkt_len = p->packet_len - sizeof(hdr);
+            is_device_state = p->flags & MULTIFD_FLAG_DEVICE_STATE;
+            if (is_device_state) {
+                pkt_buf = (uint8_t *)p->packet_dev_state + sizeof(hdr);
+                pkt_len = sizeof(*p->packet_dev_state) - sizeof(hdr);
+            } else {
+                pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
+                pkt_len = p->packet_len - sizeof(hdr);
+            }
 
             ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
                                            &local_err);
@@ -1235,12 +1293,17 @@ static void *multifd_recv_thread(void *opaque)
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
 
-            /*
-             * Even if it's a SYNC packet, this needs to be set
-             * because older QEMUs (<9.0) still send data along with
-             * the SYNC packet.
-             */
-            has_data = p->normal_num || p->zero_num;
+            if (is_device_state) {
+                has_data = p->next_packet_size > 0;
+            } else {
+                /*
+                 * Even if it's a SYNC packet, this needs to be set
+                 * because older QEMUs (<9.0) still send data along with
+                 * the SYNC packet.
+                 */
+                has_data = p->normal_num || p->zero_num;
+            }
+
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*
@@ -1269,14 +1332,29 @@ static void *multifd_recv_thread(void *opaque)
         }
 
         if (has_data) {
-            ret = multifd_recv_state->ops->recv(p, &local_err);
+            if (is_device_state) {
+                assert(use_packets);
+                ret = multifd_device_state_recv(p, &local_err);
+            } else {
+                ret = multifd_recv_state->ops->recv(p, &local_err);
+            }
             if (ret != 0) {
                 break;
             }
+        } else if (is_device_state) {
+            error_setg(&local_err,
+                       "multifd: received empty device state packet");
+            break;
         }
 
         if (use_packets) {
             if (flags & MULTIFD_FLAG_SYNC) {
+                if (is_device_state) {
+                    error_setg(&local_err,
+                               "multifd: received SYNC device state packet");
+                    break;
+                }
+
                 qemu_sem_post(&multifd_recv_state->sem_sync);
                 qemu_sem_wait(&p->sem_sync);
             }
@@ -1345,6 +1423,7 @@ int multifd_recv_setup(Error **errp)
             p->packet_len = sizeof(MultiFDPacket_t)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
+            p->packet_dev_state = g_malloc0(sizeof(*p->packet_dev_state));
         }
         p->name = g_strdup_printf(MIGRATION_THREAD_DST_MULTIFD, i);
         p->normal = g_new0(ram_addr_t, page_count);
-- 
2.48.1


