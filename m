Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3224C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTMJ-00005o-Gb; Tue, 06 Feb 2024 16:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLo-0008AC-4i
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:33 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLm-000895-FL
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13C962213C;
 Tue,  6 Feb 2024 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=aVxjtxV3b48IZna+4TtCZDzLJCNxAvA8gyUhht1Lv8JBJM8DkYvMVYnibrjcH2SdA8+7h9
 +TDMjo0B1j9F3dqo5+UcTjtRoDj9HWsfDet+2n34dtGdFmUyRvR+5iF89k5xRM0LScZCl0
 bplSeRaZMyiVKj+HFvpk9EkcRKur9nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=KLnDzsJvuRD8sFOCvAmjOc1OQ6ixxSPsdNazKex/4dlM9Ztkc+VgwcTt12uQ3/RmMcHSGq
 4tgdxUovqDMbmoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=aVxjtxV3b48IZna+4TtCZDzLJCNxAvA8gyUhht1Lv8JBJM8DkYvMVYnibrjcH2SdA8+7h9
 +TDMjo0B1j9F3dqo5+UcTjtRoDj9HWsfDet+2n34dtGdFmUyRvR+5iF89k5xRM0LScZCl0
 bplSeRaZMyiVKj+HFvpk9EkcRKur9nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWRZkasRWJC27qChPngUXVe+bs0BJ/v0zMDY4kUbyKI=;
 b=KLnDzsJvuRD8sFOCvAmjOc1OQ6ixxSPsdNazKex/4dlM9Ztkc+VgwcTt12uQ3/RmMcHSGq
 4tgdxUovqDMbmoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8260132DD;
 Tue,  6 Feb 2024 21:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uJYsG9+pwmWzQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Feb 2024 21:51:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 3/6] migration/multifd: Move multifd_send_setup error
 handling in to the function
Date: Tue,  6 Feb 2024 18:51:15 -0300
Message-Id: <20240206215118.6171-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240206215118.6171-1-farosas@suse.de>
References: <20240206215118.6171-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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


