Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CFAD10F26
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqf-0002sn-5h; Sun, 17 Nov 2024 14:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqd-0002s3-RC
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:15 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqc-0005vQ-BS
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:15 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqY-00000002GUm-2BI8; Sun, 17 Nov 2024 20:22:10 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 12/24] migration/multifd: Add an explicit MultiFDSendData
 destructor
Date: Sun, 17 Nov 2024 20:20:07 +0100
Message-ID: <55c9769a2961d621f5843e04ce995e6c226b1432.1731773021.git.maciej.szmigiero@oracle.com>
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

This way if there are fields there that needs explicit disposal (like, for
example, some attached buffers) they will be handled appropriately.

Add a related assert to multifd_set_payload_type() in order to make sure
that this function is only used to fill a previously empty MultiFDSendData
with some payload, not the other way around.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd-nocomp.c |  3 +--
 migration/multifd.c        | 31 ++++++++++++++++++++++++++++---
 migration/multifd.h        |  5 +++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 55191152f9cb..fa0fd0289eca 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -41,8 +41,7 @@ void multifd_ram_save_setup(void)
 
 void multifd_ram_save_cleanup(void)
 {
-    g_free(multifd_ram_send);
-    multifd_ram_send = NULL;
+    g_clear_pointer(&multifd_ram_send, multifd_send_data_free);
 }
 
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index 4575495c8816..730acf55cfad 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -123,6 +123,32 @@ MultiFDSendData *multifd_send_data_alloc(void)
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
@@ -496,8 +522,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
     p->name = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_clear_pointer(&p->data, multifd_send_data_free);
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
@@ -663,7 +688,7 @@ static void *multifd_send_thread(void *opaque)
                        (uint64_t)p->next_packet_size + p->packet_len);
 
             p->next_packet_size = 0;
-            multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
+            multifd_send_data_clear(p->data);
 
             /*
              * Making sure p->data is published before saying "we're
diff --git a/migration/multifd.h b/migration/multifd.h
index 026b653057e2..d2f1d0d74da7 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -140,6 +140,9 @@ static inline bool multifd_payload_empty(MultiFDSendData *data)
 static inline void multifd_set_payload_type(MultiFDSendData *data,
                                             MultiFDPayloadType type)
 {
+    assert(multifd_payload_empty(data));
+    assert(type != MULTIFD_PAYLOAD_NONE);
+
     data->type = type;
 }
 
@@ -353,6 +356,8 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 bool multifd_send(MultiFDSendData **send_data);
 MultiFDSendData *multifd_send_data_alloc(void);
+void multifd_send_data_clear(MultiFDSendData *data);
+void multifd_send_data_free(MultiFDSendData *data);
 
 static inline uint32_t multifd_ram_page_size(void)
 {

