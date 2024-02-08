Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11284C4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulH-0008C3-0C; Wed, 07 Feb 2024 22:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukF-0006bV-41
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukD-0004Ny-GF
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDKyUbSmLP6Qcr0DTtmBT55sngUFPePIR6zJW4JRhd0=;
 b=K2//3/Zy6/uP+NGA1FMRGVsdzNXS98BCUzZ95rWoPqEETiakHPTrnIQw78AAE5VocVQ0C+
 PEqzP3rT1FsM2Y193dragglsJPnndyxM/uPzmsZkiVy5/qbcrbTRD6Bjf2uvNaOYtuGnKw
 VDLNbH81ULv+BgNM03vN4sf4VDr0LoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-KTfRADHdNPWZY86ykG-oVw-1; Wed, 07 Feb 2024 22:06:29 -0500
X-MC-Unique: KTfRADHdNPWZY86ykG-oVw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4D6D811E81;
 Thu,  8 Feb 2024 03:06:28 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC1E6492BC7;
 Thu,  8 Feb 2024 03:06:26 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 18/34] migration/multifd: Change retval of multifd_send_pages()
Date: Thu,  8 Feb 2024 11:05:12 +0800
Message-ID: <20240208030528.368214-19-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Using int is an overkill when there're only two options.  Change it to a
boolean.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-18-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 12e587fda8..35d4e8ad1f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -449,9 +449,10 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
  * thread is using the channel mutex when changing it, and the channel
  * have to had finish with its own, otherwise pending_job can't be
  * false.
+ *
+ * Returns true if succeed, false otherwise.
  */
-
-static int multifd_send_pages(void)
+static bool multifd_send_pages(void)
 {
     int i;
     static int next_channel;
@@ -459,7 +460,7 @@ static int multifd_send_pages(void)
     MultiFDPages_t *pages = multifd_send_state->pages;
 
     if (multifd_send_should_exit()) {
-        return -1;
+        return false;
     }
 
     /* We wait here, until at least one channel is ready */
@@ -473,7 +474,7 @@ static int multifd_send_pages(void)
     next_channel %= migrate_multifd_channels();
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
         if (multifd_send_should_exit()) {
-            return -1;
+            return false;
         }
         p = &multifd_send_state->params[i];
         /*
@@ -502,7 +503,7 @@ static int multifd_send_pages(void)
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-    return 1;
+    return true;
 }
 
 /* Returns true if enqueue successful, false otherwise */
@@ -526,7 +527,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
         changed = true;
     }
 
-    if (multifd_send_pages() < 0) {
+    if (!multifd_send_pages()) {
         return false;
     }
 
@@ -666,7 +667,7 @@ int multifd_send_sync_main(void)
         return 0;
     }
     if (multifd_send_state->pages->num) {
-        if (multifd_send_pages() < 0) {
+        if (!multifd_send_pages()) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
         }
-- 
2.43.0


