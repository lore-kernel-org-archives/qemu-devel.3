Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFB4C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCHJ-0006ce-3r; Wed, 28 Feb 2024 00:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHH-0006Z3-IC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCH5-0006d0-Qu
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfy7kxCg3orBGddHhphJ6WF0fxLiKSCCVijlA5ohHsM=;
 b=hX7Fu/sc7Zkk4alaqXlOtbheyQhACNPFShmjb4eYxOHcvVMsNsgFEhcbW+5/VyADhunt3d
 J9/v2UdmXP4LCgrct0BSqVbkw5nlTzn/yRfdtbTWQj02PjK9q15fdz5u7lbrpSyTye7GR0
 8RX1OLG/cx7wHSX5yh3FAQAPT2AyUZE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-xsJrgnSlPl2VmFw8hneq9A-1; Wed,
 28 Feb 2024 00:14:30 -0500
X-MC-Unique: xsJrgnSlPl2VmFw8hneq9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7946138212C6;
 Wed, 28 Feb 2024 05:14:30 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BEEF1C060AF;
 Wed, 28 Feb 2024 05:14:21 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 07/25] migration/multifd: Drop registered_yank
Date: Wed, 28 Feb 2024 13:12:57 +0800
Message-ID: <20240228051315.400759-8-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

With a clear definition of p->c protocol, where we only set it up if the
channel is fully established (TLS or non-TLS), registered_yank boolean will
have equal meaning of "p->c != NULL".

Drop registered_yank by checking p->c instead.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240222095301.171137-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 2 --
 migration/multifd.c | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 8a1cad0996..b3fe27ae93 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -78,8 +78,6 @@ typedef struct {
     bool tls_thread_created;
     /* communication channel */
     QIOChannel *c;
-    /* is the yank function registered */
-    bool registered_yank;
     /* packet allocated len */
     uint32_t packet_len;
     /* guest page size */
diff --git a/migration/multifd.c b/migration/multifd.c
index 84a6b9e58f..1d039a4840 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -666,11 +666,11 @@ static int multifd_send_channel_destroy(QIOChannel *send)
 
 static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
-    if (p->registered_yank) {
+    if (p->c) {
         migration_ioc_unregister_yank(p->c);
+        multifd_send_channel_destroy(p->c);
+        p->c = NULL;
     }
-    multifd_send_channel_destroy(p->c);
-    p->c = NULL;
     qemu_sem_destroy(&p->sem);
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
@@ -950,7 +950,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     qio_channel_set_delay(ioc, false);
 
     migration_ioc_register_yank(ioc);
-    p->registered_yank = true;
     /* Setup p->c only if the channel is completely setup */
     p->c = ioc;
 
-- 
2.43.0


