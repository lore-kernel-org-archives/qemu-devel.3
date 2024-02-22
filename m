Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631E3C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5ld-0007Wj-Hu; Thu, 22 Feb 2024 04:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lZ-0007Vz-D7
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lX-0006mm-7G
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708595598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Z3cYZesheFU8Ptb72/fxhAVHZz9C+CAeZTQZ83R9eo=;
 b=Uw3lLBs26NMUogSlXV5OzDgLbGcHlsctiFzs2+VBY42tjI4iEKN1y+0vy0p5OTBuMMMSmC
 qIgVOhdxaTCVVJih1ppMr8f5f/EN+fleAFcAFgZrhRErfRafF7pa2VYeUpG/noCt5XzxC0
 KpJzl5rGAqt+tQESQaqzyWW/LUcYEGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-g24eAK3MPQKx0-JWvaj8GA-1; Thu, 22 Feb 2024 04:53:15 -0500
X-MC-Unique: g24eAK3MPQKx0-JWvaj8GA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E11EF835346;
 Thu, 22 Feb 2024 09:53:14 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3553E8CE8;
 Thu, 22 Feb 2024 09:53:10 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/5] migration/multifd: Drop registered_yank
Date: Thu, 22 Feb 2024 17:52:58 +0800
Message-ID: <20240222095301.171137-3-peterx@redhat.com>
In-Reply-To: <20240222095301.171137-1-peterx@redhat.com>
References: <20240222095301.171137-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

With a clear definition of p->c protocol, where we only set it up if the
channel is fully established (TLS or non-TLS), registered_yank boolean will
have equal meaning of "p->c != NULL".

Drop registered_yank by checking p->c instead.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index 6b89a6c885..da2e7c1db1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -648,11 +648,11 @@ static int multifd_send_channel_destroy(QIOChannel *send)
 
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
@@ -932,7 +932,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     qio_channel_set_delay(ioc, false);
 
     migration_ioc_register_yank(ioc);
-    p->registered_yank = true;
     /* Setup p->c only if the channel is completely setup */
     p->c = ioc;
 
-- 
2.43.0


