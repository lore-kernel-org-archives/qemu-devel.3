Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89575C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 19:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4yT-0008Of-4S; Mon, 05 Feb 2024 14:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX4yP-0008NS-0T
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:49:45 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX4yM-0004Nc-DO
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:49:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC23D1FB49;
 Mon,  5 Feb 2024 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707162579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=hcSmgrL7W+ajzP5JMpfX6oR0jHJOh6WQqwy4gH49P8nw9pYNNVcqli78tnx3LpXASvPB/0
 cHt5gE1oArvKwsXTtVgG/zSAGv97kJg3fg+0jWdNGF6os6S3n3XKuy5hdn1GyeJV5kqM7z
 QntsOAGonsiIHSQjBGQYSAb8/NS7Fik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707162579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=9chsRFAAtG7eO2Hgkkq+mlgFFMQ+Ig4JhdIhKXmG/eA9B2Tw+966Ok5gjHdqT1lHEOdvyz
 DTCQjAeUQHlrEKDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707162579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=hcSmgrL7W+ajzP5JMpfX6oR0jHJOh6WQqwy4gH49P8nw9pYNNVcqli78tnx3LpXASvPB/0
 cHt5gE1oArvKwsXTtVgG/zSAGv97kJg3fg+0jWdNGF6os6S3n3XKuy5hdn1GyeJV5kqM7z
 QntsOAGonsiIHSQjBGQYSAb8/NS7Fik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707162579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=9chsRFAAtG7eO2Hgkkq+mlgFFMQ+Ig4JhdIhKXmG/eA9B2Tw+966Ok5gjHdqT1lHEOdvyz
 DTCQjAeUQHlrEKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69C8C13707;
 Mon,  5 Feb 2024 19:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFltDNI7wWWYQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Feb 2024 19:49:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/6] migration/multifd: Move multifd_send_setup error
 handling in to the function
Date: Mon,  5 Feb 2024 16:49:26 -0300
Message-Id: <20240205194929.28963-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240205194929.28963-1-farosas@suse.de>
References: <20240205194929.28963-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hcSmgrL7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9chsRFAA
X-Spamd-Result: default: False [0.69 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC23D1FB49
X-Spamd-Bar: /
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Hide the error handling inside multifd_send_setup to make it cleaner
for the next patch to move the function around.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  6 +-----
 migration/multifd.c   | 24 +++++++++++++++++-------
 migration/multifd.h   |  2 +-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ba99772e76..2942f8cf42 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3623,11 +3623,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (multifd_send_setup(&local_err) != 0) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
+    if (!multifd_send_setup()) {
         migrate_fd_cleanup(s);
         return;
     }
diff --git a/migration/multifd.c b/migration/multifd.c
index 515d88e04b..cc10be2c3f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -985,14 +985,16 @@ static void multifd_new_send_channel_create(gpointer opaque)
     socket_send_channel_create(multifd_new_send_channel_async, opaque);
 }
 
-int multifd_send_setup(Error **errp)
+bool multifd_send_setup(void)
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
@@ -1026,14 +1028,22 @@ int multifd_send_setup(Error **errp)
 
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
index 7881980ee6..8a1cad0996 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
-int multifd_send_setup(Error **errp);
+bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
 int multifd_recv_setup(Error **errp);
 void multifd_recv_cleanup(void);
-- 
2.35.3


