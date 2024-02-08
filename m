Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36CAC4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulF-0007zx-NL; Wed, 07 Feb 2024 22:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukC-0006ZX-MW
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukA-0004Nd-Pt
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8s0tvpWkzV3GQMQJaITUyymUQr64z0Z2GBMc/tUa79g=;
 b=OPQG0+VeeAyRMaFMqb0QCTe6WtlRGGLmLSFX8Ii71r3VzJIevv9X08TErW5VKIKm943UZZ
 cfL9iNaStIREKg0GoffjeAh82pWLaRPv7DYRG6S9QSUW0TQJNpP9jFgV8MXgGkrTbhz0MQ
 yXFwFO+EOnMvhKThJ++d9xcorbjKE3w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-wSZn22o6M9CbEcCaG8y1mg-1; Wed,
 07 Feb 2024 22:06:26 -0500
X-MC-Unique: wSZn22o6M9CbEcCaG8y1mg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB9873806710;
 Thu,  8 Feb 2024 03:06:25 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 781C8492BC7;
 Thu,  8 Feb 2024 03:06:23 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 17/34] migration/multifd: Change retval of multifd_queue_page()
Date: Thu,  8 Feb 2024 11:05:11 +0800
Message-ID: <20240208030528.368214-18-peterx@redhat.com>
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
Link: https://lore.kernel.org/r/20240202102857.110210-17-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 2 +-
 migration/multifd.c | 9 +++++----
 migration/ram.c     | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 34a2ecb9f4..a320c53a6f 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -22,7 +22,7 @@ bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
 int multifd_send_sync_main(void);
-int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
+bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
diff --git a/migration/multifd.c b/migration/multifd.c
index ba86f9dda5..12e587fda8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -505,7 +505,8 @@ static int multifd_send_pages(void)
     return 1;
 }
 
-int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+/* Returns true if enqueue successful, false otherwise */
+bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
 {
     MultiFDPages_t *pages = multifd_send_state->pages;
     bool changed = false;
@@ -519,21 +520,21 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
         pages->num++;
 
         if (pages->num < pages->allocated) {
-            return 1;
+            return true;
         }
     } else {
         changed = true;
     }
 
     if (multifd_send_pages() < 0) {
-        return -1;
+        return false;
     }
 
     if (changed) {
         return multifd_queue_page(block, offset);
     }
 
-    return 1;
+    return true;
 }
 
 /* Multifd send side hit an error; remember it and prepare to quit */
diff --git a/migration/ram.c b/migration/ram.c
index d5b7cd5ac2..4649a81204 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1252,7 +1252,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
 
 static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
 {
-    if (multifd_queue_page(block, offset) < 0) {
+    if (!multifd_queue_page(block, offset)) {
         return -1;
     }
     stat64_add(&mig_stats.normal_pages, 1);
-- 
2.43.0


