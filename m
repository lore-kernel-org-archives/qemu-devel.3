Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B47C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Qi-00088F-C3; Tue, 27 Aug 2024 13:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QS-0007Rc-CT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:18 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QH-0001cY-AE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:16 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Q3-0002OX-3d; Tue, 27 Aug 2024 19:55:51 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 11/17] migration/multifd: Add an explicit MultiFDSendData
 destructor
Date: Tue, 27 Aug 2024 19:54:30 +0200
Message-ID: <59483d382d5453e69c6c762eb0a006a1f7ac228f.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This way if there are fields there that needs explicit disposal (like, for
example, some attached buffers) they will be handled appropriately.

Add a related assert to multifd_set_payload_type() in order to make sure
that this function is only used to fill a previously empty MultiFDSendData
with some payload, not the other way around.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd-nocomp.c |  3 +--
 migration/multifd.c        | 31 ++++++++++++++++++++++++++++---
 migration/multifd.h        |  5 +++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 53ea9f9c8371..39eb77c9b3b7 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -40,8 +40,7 @@ void multifd_ram_save_setup(void)
 
 void multifd_ram_save_cleanup(void)
 {
-    g_free(multifd_ram_send);
-    multifd_ram_send = NULL;
+    g_clear_pointer(&multifd_ram_send, multifd_send_data_free);
 }
 
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index b25789dde0b3..a74e8a5cc891 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -119,6 +119,32 @@ MultiFDSendData *multifd_send_data_alloc(void)
     return g_malloc0(size_minus_payload + max_payload_size);
 }
 
+void multifd_send_data_clear(MultiFDSendData *data)
+{
+    if (multifd_payload_empty(data)) {
+        return;
+    }
+
+    switch (data->type) {
+    default:
+        /* Nothing to do */
+        break;
+    }
+
+    data->type = MULTIFD_PAYLOAD_NONE;
+}
+
+void multifd_send_data_free(MultiFDSendData *data)
+{
+    if (!data) {
+        return;
+    }
+
+    multifd_send_data_clear(data);
+
+    g_free(data);
+}
+
 static bool multifd_use_packets(void)
 {
     return !migrate_mapped_ram();
@@ -506,8 +532,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
     p->name = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_clear_pointer(&p->data, multifd_send_data_free);
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
@@ -671,7 +696,7 @@ static void *multifd_send_thread(void *opaque)
                        p->next_packet_size + p->packet_len);
 
             p->next_packet_size = 0;
-            multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
+            multifd_send_data_clear(p->data);
 
             /*
              * Making sure p->data is published before saying "we're
diff --git a/migration/multifd.h b/migration/multifd.h
index a8f3e4838c01..a0853622153e 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -139,6 +139,9 @@ static inline bool multifd_payload_empty(MultiFDSendData *data)
 static inline void multifd_set_payload_type(MultiFDSendData *data,
                                             MultiFDPayloadType type)
 {
+    assert(multifd_payload_empty(data));
+    assert(type != MULTIFD_PAYLOAD_NONE);
+
     data->type = type;
 }
 
@@ -288,6 +291,8 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 bool multifd_send(MultiFDSendData **send_data);
 MultiFDSendData *multifd_send_data_alloc(void);
+void multifd_send_data_clear(MultiFDSendData *data);
+void multifd_send_data_free(MultiFDSendData *data);
 
 static inline uint32_t multifd_ram_page_size(void)
 {

