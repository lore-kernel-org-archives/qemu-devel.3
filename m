Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F9DD10F28
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqV-0002jm-MA; Sun, 17 Nov 2024 14:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqT-0002je-US
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:05 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqR-0005uh-Ut
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:05 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqO-00000002GUP-0z9c; Sun, 17 Nov 2024 20:22:00 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 10/24] migration/multifd: Device state transfer support -
 receive side
Date: Sun, 17 Nov 2024 20:20:05 +0100
Message-ID: <8679a04fda669b0e8f0e3b8c598aa4a58a67de40.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 87 +++++++++++++++++++++++++++++++++++++++++----
 migration/multifd.h | 26 +++++++++++++-
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 999b88b7ebcb..9578a985449b 100644
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
 
     if (!(p->flags & MULTIFD_FLAG_SYNC)) {
         ret = multifd_ram_unfill_packet(p, errp);
@@ -271,6 +282,17 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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
@@ -1023,6 +1045,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
+    g_clear_pointer(&p->packet_dev_state, g_free);
     g_free(p->normal);
     p->normal = NULL;
     g_free(p->zero);
@@ -1124,6 +1147,28 @@ void multifd_recv_sync_main(void)
     trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
 }
 
+static int multifd_device_state_recv(MultiFDRecvParams *p, Error **errp)
+{
+    g_autofree char *idstr = NULL;
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
+    idstr = g_strndup(p->packet_dev_state->idstr,
+                      sizeof(p->packet_dev_state->idstr));
+
+    return qemu_loadvm_load_state_buffer(idstr,
+                                         p->packet_dev_state->instance_id,
+                                         dev_state_buf, p->next_packet_size,
+                                         errp);
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
@@ -1137,6 +1182,7 @@ static void *multifd_recv_thread(void *opaque)
     while (true) {
         MultiFDPacketHdr_t hdr;
         uint32_t flags = 0;
+        bool is_device_state = false;
         bool has_data = false;
         uint8_t *pkt_buf;
         size_t pkt_len;
@@ -1159,8 +1205,14 @@ static void *multifd_recv_thread(void *opaque)
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
@@ -1178,9 +1230,14 @@ static void *multifd_recv_thread(void *opaque)
             flags = p->flags;
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
-            if (!(flags & MULTIFD_FLAG_SYNC)) {
-                has_data = p->normal_num || p->zero_num;
+
+            if (is_device_state) {
+                has_data = p->next_packet_size > 0;
+            } else {
+                has_data = !(flags & MULTIFD_FLAG_SYNC) &&
+                    (p->normal_num || p->zero_num);
             }
+
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*
@@ -1209,14 +1266,29 @@ static void *multifd_recv_thread(void *opaque)
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
@@ -1285,6 +1357,7 @@ int multifd_recv_setup(Error **errp)
             p->packet_len = sizeof(MultiFDPacket_t)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
+            p->packet_dev_state = g_malloc0(sizeof(*p->packet_dev_state));
         }
         p->name = g_strdup_printf(MIGRATION_THREAD_DST_MULTIFD, i);
         p->normal = g_new0(ram_addr_t, page_count);
diff --git a/migration/multifd.h b/migration/multifd.h
index 106a48496dc6..026b653057e2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -46,6 +46,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
 #define MULTIFD_FLAG_UADK (8 << 1)
 #define MULTIFD_FLAG_QATZIP (16 << 1)
 
+/*
+ * If set it means that this packet contains device state
+ * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
+ */
+#define MULTIFD_FLAG_DEVICE_STATE (1 << 6)
+
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
 
@@ -78,6 +84,16 @@ typedef struct {
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
 
+typedef struct {
+    MultiFDPacketHdr_t hdr;
+
+    char idstr[256] QEMU_NONSTRING;
+    uint32_t instance_id;
+
+    /* size of the next packet that contains the actual data */
+    uint32_t next_packet_size;
+} __attribute__((packed)) MultiFDPacketDeviceState_t;
+
 typedef struct {
     /* number of used pages */
     uint32_t num;
@@ -95,6 +111,13 @@ struct MultiFDRecvData {
     off_t file_offset;
 };
 
+typedef struct {
+    char *idstr;
+    uint32_t instance_id;
+    char *buf;
+    size_t buf_len;
+} MultiFDDeviceState_t;
+
 typedef enum {
     MULTIFD_PAYLOAD_NONE,
     MULTIFD_PAYLOAD_RAM,
@@ -210,8 +233,9 @@ typedef struct {
 
     /* thread local variables. No locking required */
 
-    /* pointer to the packet */
+    /* pointers to the possible packet types */
     MultiFDPacket_t *packet;
+    MultiFDPacketDeviceState_t *packet_dev_state;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets received through this channel */

