Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C23CEB2CA
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 09:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKCKq-00058o-DD; Sat, 15 Nov 2025 04:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKCKj-0004tT-Nw
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 04:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKCKi-0005VR-8p
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 04:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763197955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=puRzXfg+J7NKyJ7yKSVGHp7VlYWRBRXQdELDHyqoYQ4=;
 b=irZ7/TpXEE/+slrDMpw/KzsRvsC2XUP5hiTw0XHDeEUWc3LNdWO3FyKwpfmDpBQtmZrGmT
 cMNpwJoTTS14DApzzvcKLCxFRkbgizAFA/3MvEAvNGAxUHI9I8IW7tnf3YYUhPDO+XExOV
 I8nY37fv0ps9Sn3v+zaZcln+e1cf8YU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-MIvM-qklNDm1Z10JP1KV4w-1; Sat,
 15 Nov 2025 04:12:32 -0500
X-MC-Unique: MIvM-qklNDm1Z10JP1KV4w-1
X-Mimecast-MFC-AGG-ID: MIvM-qklNDm1Z10JP1KV4w_1763197951
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C349180064E; Sat, 15 Nov 2025 08:35:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1450219540DF; Sat, 15 Nov 2025 08:35:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C08221E6617; Sat, 15 Nov 2025 09:35:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 3/3] migration/postcopy-ram: Improve error reporting after
 loadvm failure
Date: Sat, 15 Nov 2025 09:35:00 +0100
Message-ID: <20251115083500.2753895-4-armbru@redhat.com>
In-Reply-To: <20251115083500.2753895-1-armbru@redhat.com>
References: <20251115083500.2753895-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

One of two error messages show __func__.  Drop it; it doesn't help
users, and developers can grep for the message.  This also permits
de-duplicating the code to prepend to the error message.

Both error messages show a numeric error code.  I doubt that's
helpful, but I'm leaving it alone.

Use error_append_hint() for explaining that some dirty bitmaps may be
lost.  Polish the prose.

Don't faff around with g_clear_pointer(), it's not worth its keep
here.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/postcopy-ram.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3f98dcb6fd..7c9fe61041 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2146,25 +2146,24 @@ static void *postcopy_listen_thread(void *opaque)
     if (load_res < 0) {
         qemu_file_set_error(f, load_res);
         dirty_bitmap_mig_cancel_incoming();
+        error_prepend(&local_err,
+                      "loadvm failed during postcopy: %d: ", load_res);
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
             !migrate_postcopy_ram() && migrate_dirty_bitmaps())
         {
-            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
-                         "are migrated except dirty bitmaps. Some dirty "
-                         "bitmaps may be lost, and present migrated dirty "
-                         "bitmaps are correctly migrated and valid.",
-                         __func__, load_res, error_get_pretty(local_err));
-            g_clear_pointer(&local_err, error_free);
+            error_append_hint(&local_err,
+                              "All state is migrated except dirty bitmaps."
+                              " Some dirty bitmaps may be lost, but any"
+                              " migrated dirty bitmaps are valid.");
+            error_report_err(local_err);
         } else {
             /*
              * Something went fatally wrong and we have a bad state, QEMU will
              * exit depending on if postcopy-exit-on-error is true, but the
              * migration cannot be recovered.
              */
-            error_prepend(&local_err,
-                          "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
-            g_clear_pointer(&local_err, error_report_err);
+            error_report_err(local_err);
             migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
             goto out;
         }
-- 
2.49.0


