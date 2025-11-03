Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB627CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzNa-00065Z-Ku; Mon, 03 Nov 2025 13:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzNX-00065G-R5
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzNH-00076D-CP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762194828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwOLooqjrQgvrxWbQhGQsWKmFK2ppIjlU+Vt120JKEI=;
 b=T4wwpCObmIcBTDW4L2H+6yOqVikizh/g6IkQKEXua/vJzlC77ajglBnLiyNvGmvO1CR/oE
 CP9RNuTID6ekxNvVwqDxLx6jq8OcgW+UiKNQkpIn1jZgVq8KrOPfnXK+07U024ILEsF2Zr
 wjjKzI8u0ZBichsEIgqm905fkVljeBI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-Jmfcj8j8PzeziUBKxf3kKQ-1; Mon,
 03 Nov 2025 13:33:46 -0500
X-MC-Unique: Jmfcj8j8PzeziUBKxf3kKQ-1
X-Mimecast-MFC-AGG-ID: Jmfcj8j8PzeziUBKxf3kKQ_1762194825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9971D1954B1B; Mon,  3 Nov 2025 18:33:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.249])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DE90180058D; Mon,  3 Nov 2025 18:33:27 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v4 6/8] migration: Respect exit-on-error when migration fails
 before resuming
Date: Mon,  3 Nov 2025 19:32:55 +0100
Message-ID: <20251103183301.3840862-7-jmarcin@redhat.com>
In-Reply-To: <20251103183301.3840862-1-jmarcin@redhat.com>
References: <20251103183301.3840862-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

When exit-on-error was added to migration, it wasn't added to postcopy.
Even though postcopy migration will usually pause and not fail, in cases
it does unrecoverably fail before destination side has been started,
exit-on-error will allow management to query the error.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 48cbb46c27..91431f02a4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2080,11 +2080,16 @@ bool postcopy_is_paused(MigrationStatus status)
 
 static void postcopy_listen_thread_bh(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     migration_incoming_state_destroy();
 
-    if (mis->state == MIGRATION_STATUS_FAILED) {
+    if (mis->state == MIGRATION_STATUS_FAILED && mis->exit_on_error) {
+        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+            error_report_err(s->error);
+            s->error = NULL;
+        }
         /*
          * If something went wrong then we have a bad state so exit;
          * we only could have gotten here if something failed before
-- 
2.51.0


