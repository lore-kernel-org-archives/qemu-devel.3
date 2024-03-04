Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3036C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx6h-0001CX-Tw; Sun, 03 Mar 2024 20:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6g-0001C5-6g
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6d-0002E2-Co
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgpnbF65mZKeFKOf2oI/kGpTOviefU6Ka4ygsHYyZJU=;
 b=fAhdEN4+1x2NpCp0w55VA5Oa4+q/JniherGuEFrAMjpolLz7CDSAq3TdbFmsMQLLcJvXQ/
 xQHiBkitGdXl23qYIYlWelfdF7g9X30KJUTnIEtK+FmYP3gJvA7ep+6GdajbrX6MqACVmW
 t5tkyHyo9Cb1sVpqv/IEiAgnp92MNsg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-EqSfryIkPruSz6qsbf2qFg-1; Sun, 03 Mar 2024 20:27:00 -0500
X-MC-Unique: EqSfryIkPruSz6qsbf2qFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4612185A783;
 Mon,  4 Mar 2024 01:26:59 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EB58403864F;
 Mon,  4 Mar 2024 01:26:56 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 04/27] migration/multifd: Cleanup multifd_recv_sync_main
Date: Mon,  4 Mar 2024 09:26:11 +0800
Message-ID: <20240304012634.95520-5-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Some minor cleanups and documentation for multifd_recv_sync_main.

Use thread_count as done in other parts of the code. Remove p->id from
the multifd_recv_state sync, since that is global and not tied to a
channel. Add documentation for the sync steps.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c    | 17 +++++++++++++----
 migration/trace-events |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 6c07f19af1..c7389bf833 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1182,18 +1182,27 @@ void multifd_recv_cleanup(void)
 
 void multifd_recv_sync_main(void)
 {
+    int thread_count = migrate_multifd_channels();
     int i;
 
     if (!migrate_multifd()) {
         return;
     }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        trace_multifd_recv_sync_main_wait(p->id);
+    /*
+     * Initiate the synchronization by waiting for all channels.
+     * For socket-based migration this means each channel has received
+     * the SYNC packet on the stream.
+     */
+    for (i = 0; i < thread_count; i++) {
+        trace_multifd_recv_sync_main_wait(i);
         qemu_sem_wait(&multifd_recv_state->sem_sync);
     }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+
+    /*
+     * Sync done. Release the channels for the next iteration.
+     */
+    for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         WITH_QEMU_LOCK_GUARD(&p->mutex) {
diff --git a/migration/trace-events b/migration/trace-events
index 298ad2b0dd..bf1a069632 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -132,7 +132,7 @@ multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uin
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
-multifd_recv_sync_main_wait(uint8_t id) "channel %u"
+multifd_recv_sync_main_wait(uint8_t id) "iter %u"
 multifd_recv_terminate_threads(bool error) "error %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %u packets %" PRIu64 " pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-- 
2.44.0


