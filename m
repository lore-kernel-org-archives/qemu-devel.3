Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D1D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nqt-0006Y4-9m; Tue, 29 Oct 2024 11:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqr-0006XR-6W
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nql-0007LC-Nn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730214578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnKvSAGsXn7wVbU9jG9Lh0cUI9aeI16g1oxT5Kl0Gq8=;
 b=OogzQWEU5Dw3T2nEvuqPWxdQkkqSgP96lscRcJN5yNVLFXbCsQ8GiGURHv11hJj2hVfUm+
 p+enFbX1uN1FF+CbWefKR6p/KBfxLQxXvumlqo4bSPC4h8fVBhNQrf4vEh039qMKhkei8S
 yrvEJ0XF+r52Gha1v5zlwQTa9sMvnOA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-X9M4qPLePCKOWphul-yhjw-1; Tue,
 29 Oct 2024 11:09:33 -0400
X-MC-Unique: X9M4qPLePCKOWphul-yhjw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28201955F42; Tue, 29 Oct 2024 15:09:32 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.130])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3AB61956086; Tue, 29 Oct 2024 15:09:28 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 3/5] migration: remove multifd check with postcopy
Date: Tue, 29 Oct 2024 20:39:06 +0530
Message-ID: <20241029150908.1136894-4-ppandit@redhat.com>
In-Reply-To: <20241029150908.1136894-1-ppandit@redhat.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Remove multifd capability check with Postcopy mode.
This helps to enable both multifd and postcopy together.

Update migrate_multifd() to return false when migration
reaches Postcopy phase. In Postcopy phase, source guest
is paused, so the migration threads on the source stop
sending/pushing data on the channels. The destination
guest starts running and Postcopy threads there begin
to request/pull data from the source side.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/options.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index ad8d6989a8..47c5137d5f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -266,7 +266,8 @@ bool migrate_multifd(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
+    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD]
+            && !migration_in_postcopy();
 }
 
 bool migrate_pause_before_switchover(void)
@@ -479,11 +480,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not compatible with ignore-shared");
             return false;
         }
-
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp, "Postcopy is not yet compatible with multifd");
-            return false;
-        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
-- 
2.47.0


