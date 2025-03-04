Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66383C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaOx-0001cx-Gg; Tue, 04 Mar 2025 17:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOl-0001L2-L7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:59 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOj-00015G-Ob
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:59 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOf-00000000LYV-3sQP; Tue, 04 Mar 2025 23:05:53 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 13/36] migration/multifd: Add an explicit MultiFDSendData
 destructor
Date: Tue,  4 Mar 2025 23:03:40 +0100
Message-ID: <6755205f2b95abbed251f87061feee1c0e410836.1741124640.git.maciej.szmigiero@oracle.com>
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

This way if there are fields there that needs explicit disposal (like, for
example, some attached buffers) they will be handled appropriately.

Add a related assert to multifd_set_payload_type() in order to make sure
that this function is only used to fill a previously empty MultiFDSendData
with some payload, not the other way around.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd-nocomp.c |  3 +--
 migration/multifd.c        | 31 ++++++++++++++++++++++++++++---
 migration/multifd.h        |  5 +++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 1325dba97cea..e46e79d8b272 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -42,8 +42,7 @@ void multifd_ram_save_setup(void)
 
 void multifd_ram_save_cleanup(void)
 {
-    g_free(multifd_ram_send);
-    multifd_ram_send = NULL;
+    g_clear_pointer(&multifd_ram_send, multifd_send_data_free);
 }
 
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index add6f86175c2..c8508cadab2d 100644
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
@@ -695,7 +720,7 @@ static void *multifd_send_thread(void *opaque)
                        (uint64_t)p->next_packet_size + p->packet_len);
 
             p->next_packet_size = 0;
-            multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
+            multifd_send_data_clear(p->data);
 
             /*
              * Making sure p->data is published before saying "we're
diff --git a/migration/multifd.h b/migration/multifd.h
index d682c5a9b743..8d639eec69fe 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -149,6 +149,9 @@ static inline bool multifd_payload_empty(MultiFDSendData *data)
 static inline void multifd_set_payload_type(MultiFDSendData *data,
                                             MultiFDPayloadType type)
 {
+    assert(multifd_payload_empty(data));
+    assert(type != MULTIFD_PAYLOAD_NONE);
+
     data->type = type;
 }
 
@@ -365,6 +368,8 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 bool multifd_send(MultiFDSendData **send_data);
 MultiFDSendData *multifd_send_data_alloc(void);
+void multifd_send_data_clear(MultiFDSendData *data);
+void multifd_send_data_free(MultiFDSendData *data);
 
 static inline uint32_t multifd_ram_page_size(void)
 {

