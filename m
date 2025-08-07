Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F058CA0EC0
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 11:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujz8o-0000sM-If; Thu, 07 Aug 2025 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8i-0000k6-JC
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8h-0002B9-5a
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754567429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3X+kYbpzgtIHvfvg6n9K02H26aiiWgU8LEFGmGE10o=;
 b=a/LvSUqhU8/jTE7XKoX7shHC3MLHv6PDEfeZmDixayoQpKrvUwdNLPS1Eb3I9UQbt2fLGA
 WifdDR8cvSVjD/UOA5+Ly6UP11C9WH6hZ+B+IKJb++xtShpQghJLFivz6ou0uTFvjFUNYE
 375hskYGmmHFG8662n6WjkUdtDU2VEM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-j7iAlGsQP3KjM7Ha432Oyw-1; Thu,
 07 Aug 2025 07:50:28 -0400
X-MC-Unique: j7iAlGsQP3KjM7Ha432Oyw-1
X-Mimecast-MFC-AGG-ID: j7iAlGsQP3KjM7Ha432Oyw_1754567427
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 625FA19560A5; Thu,  7 Aug 2025 11:50:27 +0000 (UTC)
Received: from fedora (unknown [10.43.3.128])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 172EE19560B0; Thu,  7 Aug 2025 11:50:24 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [RFC PATCH 3/4] migration: Make listen thread joinable
Date: Thu,  7 Aug 2025 13:49:11 +0200
Message-ID: <20250807114922.1013286-4-jmarcin@redhat.com>
In-Reply-To: <20250807114922.1013286-1-jmarcin@redhat.com>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

This patch allows joining the migration listen thread. This is done in
preparation for the introduction of "postcopy-setup" state at the
beginning of a postcopy migration, when destination can fail gracefully
and source side then resume to a running state.

In case of such failure, to gracefully perform all cleanup in the main
migration thread, we need to wait for the listen thread to exit, which
can be done by joining it.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c | 1 +
 migration/savevm.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e5ce2940d5..8174e811eb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -901,6 +901,7 @@ process_incoming_migration_co(void *opaque)
              * Postcopy was started, cleanup should happen at the end of the
              * postcopy thread.
              */
+            qemu_thread_detach(&mis->listen_thread);
             trace_process_incoming_migration_co_postcopy_end_main();
             goto out;
         }
diff --git a/migration/savevm.c b/migration/savevm.c
index fabbeb296a..d2360be53c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2217,7 +2217,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     mis->have_listen_thread = true;
     postcopy_thread_create(mis, &mis->listen_thread,
                            MIGRATION_THREAD_DST_LISTEN,
-                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
+                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
     trace_loadvm_postcopy_handle_listen("return");
 
     return 0;
-- 
2.50.1


