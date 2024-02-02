Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E43C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVyx0-00021e-4U; Fri, 02 Feb 2024 14:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVyww-00020m-WC
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:43 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVywv-0001vp-63
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3D291F79A;
 Fri,  2 Feb 2024 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bFbNsiqRzuD5JCYVR0z5Z8cOAqseAA0ZutzGeWC6ho=;
 b=Azvm8FHeioDMPCus3CUSpfAL3uPf9ZfUBRdRnUAa/jmHFkBbU0xuODdE4NTwsLtIJJxu6B
 U/+jK2QLaLtiYx1hA6VnpLzfnX4tbZi+hzRlctrw7Rkdqwe+u2hYStDaBYQkygTxUBWbq7
 eJ5nX0vIn4pv68YEKHNgm+ccRCjLHtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bFbNsiqRzuD5JCYVR0z5Z8cOAqseAA0ZutzGeWC6ho=;
 b=v/QWBo8KDdwDq+V/1Lb+dCoDPq1v2Atv0UG6Kml09uXWYmC81UGVjDwQH5TlgCCEUsfdc3
 IEX27Ixans2XOmCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bFbNsiqRzuD5JCYVR0z5Z8cOAqseAA0ZutzGeWC6ho=;
 b=Azvm8FHeioDMPCus3CUSpfAL3uPf9ZfUBRdRnUAa/jmHFkBbU0xuODdE4NTwsLtIJJxu6B
 U/+jK2QLaLtiYx1hA6VnpLzfnX4tbZi+hzRlctrw7Rkdqwe+u2hYStDaBYQkygTxUBWbq7
 eJ5nX0vIn4pv68YEKHNgm+ccRCjLHtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bFbNsiqRzuD5JCYVR0z5Z8cOAqseAA0ZutzGeWC6ho=;
 b=v/QWBo8KDdwDq+V/1Lb+dCoDPq1v2Atv0UG6Kml09uXWYmC81UGVjDwQH5TlgCCEUsfdc3
 IEX27Ixans2XOmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D8F713A5F;
 Fri,  2 Feb 2024 19:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iDQgGWg+vWWlZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:11:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 3/5] migration/multifd: Move multifd_save_setup error handling
 in to the function
Date: Fri,  2 Feb 2024 16:11:26 -0300
Message-Id: <20240202191128.1901-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240202191128.1901-1-farosas@suse.de>
References: <20240202191128.1901-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Azvm8FHe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="v/QWBo8K"
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C3D291F79A
X-Spamd-Bar: +
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hide the error handling inside multifd_save_setup to make it cleaner
for the next patch to move the function around.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  6 +-----
 migration/multifd.c   | 24 +++++++++++++++++-------
 migration/multifd.h   |  2 +-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d5f705ceef..55abb175cc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3623,11 +3623,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (multifd_save_setup(&local_err) != 0) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
+    if (!multifd_save_setup()) {
         migrate_fd_cleanup(s);
         return;
     }
diff --git a/migration/multifd.c b/migration/multifd.c
index 402b7fd776..1851206352 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -902,14 +902,16 @@ static void multifd_new_send_channel_create(gpointer opaque)
     socket_send_channel_create(multifd_new_send_channel_async, opaque);
 }
 
-int multifd_save_setup(Error **errp)
+bool multifd_save_setup(void)
 {
-    int thread_count;
+    MigrationState *s = migrate_get_current();
+    Error *local_err = NULL;
+    int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
 
     if (!migrate_multifd()) {
-        return 0;
+        return true;
     }
 
     thread_count = migrate_multifd_channels();
@@ -953,14 +955,22 @@ int multifd_save_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        int ret;
 
-        ret = multifd_send_state->ops->send_setup(p, errp);
+        ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
-            return ret;
+            break;
         }
     }
-    return 0;
+
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_report_err(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_FAILED);
+        return false;
+    }
+
+    return true;
 }
 
 struct {
diff --git a/migration/multifd.h b/migration/multifd.h
index 917833c309..4acbd65e91 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
-int multifd_save_setup(Error **errp);
+bool multifd_save_setup(void);
 void multifd_save_cleanup(void);
 int multifd_load_setup(Error **errp);
 void multifd_load_cleanup(void);
-- 
2.35.3


