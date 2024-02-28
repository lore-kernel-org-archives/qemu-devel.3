Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBE1C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJU-0001SU-R6; Wed, 28 Feb 2024 00:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIO-0000hV-K9
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIJ-0006wN-Uf
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwqL+RGq+hFNR5LKcItZK6P97VIqtguuwPKFrYGwNfY=;
 b=bG155ei5ygtQ+czgntt9jP4rcBwddW7KVZREt7wwvn5bYg73lAIOIgmZzqzIV7ud89lug3
 Y/CDoj5WCgbrsNaKiejAvqXyn0BPcHjeDBkm7aDp1SSuUQeyGOtrtdJ1jqHOmAjUsS4ZNq
 ZLPaXLGCJAcIK+OBandZdCdeUDAK4No=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-EVs-krNhPGWUvG2oj19gJA-1; Wed,
 28 Feb 2024 00:15:47 -0500
X-MC-Unique: EVs-krNhPGWUvG2oj19gJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5BC038212C6;
 Wed, 28 Feb 2024 05:15:46 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D07911C06532;
 Wed, 28 Feb 2024 05:15:37 +0000 (UTC)
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
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 15/25] migration: remove postcopy_after_devices
Date: Wed, 28 Feb 2024 13:13:05 +0800
Message-ID: <20240228051315.400759-16-peterx@redhat.com>
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

From: Steve Sistare <steven.sistare@oracle.com>

postcopy_after_devices and migration_in_postcopy_after_devices are no
longer used, so delete them.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-6-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/migration.h    | 2 --
 migration/migration.c    | 7 -------
 3 files changed, 10 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 9e4abae97f..e6150009e0 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -89,7 +89,6 @@ bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
-bool migration_in_postcopy_after_devices(MigrationState *);
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
diff --git a/migration/migration.h b/migration/migration.h
index f2c8b8f286..aef8afbe1f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -348,8 +348,6 @@ struct MigrationState {
 
     /* Flag set once the migration has been asked to enter postcopy */
     bool start_postcopy;
-    /* Flag set after postcopy has sent the device state */
-    bool postcopy_after_devices;
 
     /* Flag set once the migration thread is running (and needs joining) */
     bool migration_thread_running;
diff --git a/migration/migration.c b/migration/migration.c
index 4650c21f67..8f7f2d92f4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1527,11 +1527,6 @@ bool migration_postcopy_is_alive(int state)
     }
 }
 
-bool migration_in_postcopy_after_devices(MigrationState *s)
-{
-    return migration_in_postcopy() && s->postcopy_after_devices;
-}
-
 bool migration_in_incoming_postcopy(void)
 {
     PostcopyState ps = postcopy_state_get();
@@ -1613,7 +1608,6 @@ int migrate_init(MigrationState *s, Error **errp)
     s->expected_downtime = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
-    s->postcopy_after_devices = false;
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
@@ -2543,7 +2537,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    ms->postcopy_after_devices = true;
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
 
     migration_downtime_end(ms);
-- 
2.43.0


