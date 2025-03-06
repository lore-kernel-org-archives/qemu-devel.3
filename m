Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3183C28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC2F-0001IP-Sf; Thu, 06 Mar 2025 09:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0m-0007cv-St
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0k-0001q1-Sn
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IiyKTyQI8RufAMjHzPz249f8Jax8j1tG0nyxgwzWL7Y=;
 b=VtCnbiSpHhyIdDCeUfSZSdYrw31OyvPS64R0JYcoGoTfH2g3AtsN2J68q0BUa/4a6v9UTj
 PiFxQEsGKxatnsIzfrHLi+RE/zo4pVUv8gz+lS8q9CZ1szziBmiADZ0gCj9Y3nXDOvPs1A
 C1mW4GmV/Q8Q2vRgAx+aO6mvP6pGhK0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-RcEXq44iMzO8HELNl656VA-1; Thu,
 06 Mar 2025 09:15:36 -0500
X-MC-Unique: RcEXq44iMzO8HELNl656VA-1
X-Mimecast-MFC-AGG-ID: RcEXq44iMzO8HELNl656VA_1741270535
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F4BE1955DB9; Thu,  6 Mar 2025 14:15:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF16218001D3; Thu,  6 Mar 2025 14:15:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/42] migration/multifd: Add an explicit MultiFDSendData
 destructor
Date: Thu,  6 Mar 2025 15:13:58 +0100
Message-ID: <20250306141419.2015340-23-clg@redhat.com>
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

This way if there are fields there that needs explicit disposal (like, for
example, some attached buffers) they will be handled appropriately.

Add a related assert to multifd_set_payload_type() in order to make sure
that this function is only used to fill a previously empty MultiFDSendData
with some payload, not the other way around.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/6755205f2b95abbed251f87061feee1c0e410836.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/multifd.h        |  5 +++++
 migration/multifd-nocomp.c |  3 +--
 migration/multifd.c        | 31 ++++++++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index d682c5a9b74388bca7ea129d76646dc1e5fe1446..8d639eec69fecc4cf393abeb9d987be854db2242 100644
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
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 1325dba97cea876a94082e43107b99f428db7bcb..e46e79d8b272122c210bb895387dfa133d218d46 100644
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
index add6f86175c25c0f7925a919c267240826fab54c..c8508cadab2d00c5c7f3e26766038e9f5a287dcc 100644
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
-- 
2.48.1


