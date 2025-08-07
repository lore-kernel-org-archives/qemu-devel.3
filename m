Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC3C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 11:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujz8l-0000ny-IY; Thu, 07 Aug 2025 07:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8e-0000NL-9o
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8c-0002Ak-T9
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754567426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjhKSd2bPXmxFYO8y7Iix8bHBCmgJAtI5MqoyQljSgE=;
 b=JAsEx5v/VbbQaTIognMI7quWI8S1PpGx0p31MhqBHsnYgiFU+wVtsadZe/9AtmHs/gAVmK
 /VJ4KcD8M5qA6wkI2Re1zTGdt8HJBZMjw0R+kphXcMxvROYWaN4o2TitKTq5F9riBjD+xl
 2V0RErkaIpDWIEeUi5MMlfQK7R27/J4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-_dcsKkmkNPe7B4QakQwn9Q-1; Thu,
 07 Aug 2025 07:50:22 -0400
X-MC-Unique: _dcsKkmkNPe7B4QakQwn9Q-1
X-Mimecast-MFC-AGG-ID: _dcsKkmkNPe7B4QakQwn9Q_1754567422
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7FE71956059; Thu,  7 Aug 2025 11:50:21 +0000 (UTC)
Received: from fedora (unknown [10.43.3.128])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4468219560AD; Thu,  7 Aug 2025 11:50:18 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [RFC PATCH 2/4] migration: Fix state transition in postcopy_start()
 error handling
Date: Thu,  7 Aug 2025 13:49:10 +0200
Message-ID: <20250807114922.1013286-3-jmarcin@redhat.com>
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

Depending on where an error during postcopy_start() happens, the state
can be either "active", "device" or "cancelling", but never
"postcopy-active". Migration state is transitioned to "postcopy-active"
only just before a successful return from the function.

Accept any state except "cancelling" when transitioning to "failed"
state.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..e5ce2940d5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 fail_closefb:
     qemu_fclose(fb);
 fail:
-    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+    if ( ms->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+    }
     migration_block_activate(NULL);
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
-- 
2.50.1


