Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ABCC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYp8-00052q-FJ; Tue, 20 Feb 2024 17:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYp7-0004zM-3U
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:49 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYp5-0006Pe-Dx
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:48 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C4391FB40;
 Tue, 20 Feb 2024 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEMp533j+rVmmPUsPXVwKF9cSEceWEIkMA6JpwQJszU=;
 b=S2+U/ZJxjeJLSIbTNTM7IR7xdT49Uhii/ngb6SML/TfY853uID1MnqnEiUa2h38+gx3giG
 TE9vnnoDarwlgiEUxs0E5UFnfssw4DGQE3/QM3hhh+dSBroYThGsntJMSHsTi5UjvgGerj
 x39RCr1hBU5FUu+G6iwDKdiSZDlJxZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEMp533j+rVmmPUsPXVwKF9cSEceWEIkMA6JpwQJszU=;
 b=mnQgrmHLfk+z+h98f7hXJsragas9HP+Hp1x7PKZ4m2a3W+5NDoKa9ekjwiaTHhda7uhErf
 LnTGtTvNsfBf6VBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEMp533j+rVmmPUsPXVwKF9cSEceWEIkMA6JpwQJszU=;
 b=S2+U/ZJxjeJLSIbTNTM7IR7xdT49Uhii/ngb6SML/TfY853uID1MnqnEiUa2h38+gx3giG
 TE9vnnoDarwlgiEUxs0E5UFnfssw4DGQE3/QM3hhh+dSBroYThGsntJMSHsTi5UjvgGerj
 x39RCr1hBU5FUu+G6iwDKdiSZDlJxZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEMp533j+rVmmPUsPXVwKF9cSEceWEIkMA6JpwQJszU=;
 b=mnQgrmHLfk+z+h98f7hXJsragas9HP+Hp1x7PKZ4m2a3W+5NDoKa9ekjwiaTHhda7uhErf
 LnTGtTvNsfBf6VBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F591139D0;
 Tue, 20 Feb 2024 22:42:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YEcXGeQq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 28/34] migration/multifd: Add direct-io support
Date: Tue, 20 Feb 2024 19:41:32 -0300
Message-Id: <20240220224138.24759-29-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 18 +++++++++++++++++-
 migration/migration.c | 24 ++++++++++++++++++++++++
 migration/options.h   |  1 +
 util/osdep.c          |  9 +++++++++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/migration/file.c b/migration/file.c
index 27ccfc6a1d..f1c7615fb6 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -57,10 +57,26 @@ int file_send_channel_destroy(QIOChannel *ioc)
 
 bool file_send_channel_create(gpointer opaque, Error **errp)
 {
-    QIOChannelFile *ioc;
+    QIOChannelFile *ioc = NULL;
     int flags = O_WRONLY;
     int fd = fd_args_get_fd();
 
+    if (migrate_direct_io()) {
+#ifdef O_DIRECT
+        /*
+         * Enable O_DIRECT for the secondary channels. These are used
+         * for sending ram pages and writes should be guaranteed to be
+         * aligned to at least page size.
+         */
+        flags |= O_DIRECT;
+#else
+        error_setg(errp, "System does not support O_DIRECT");
+        error_append_hint(errp,
+                          "Try disabling direct-io migration capability\n");
+        return false;
+#endif
+    }
+
     if (fd && fd != -1) {
         ioc = qio_channel_file_new_fd(fd);
     } else {
diff --git a/migration/migration.c b/migration/migration.c
index ce7e6f5065..ecc07c4847 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -153,6 +153,16 @@ static bool migration_needs_seekable_channel(void)
     return migrate_fixed_ram();
 }
 
+static bool migration_needs_multiple_fds(void)
+{
+    /*
+     * When doing direct-io, multifd requires two different,
+     * non-duplicated file descriptors so we can use one of them for
+     * unaligned IO.
+     */
+    return migrate_multifd() && migrate_direct_io();
+}
+
 static bool transport_supports_seeking(MigrationAddress *addr)
 {
     if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
@@ -171,6 +181,12 @@ static bool transport_supports_seeking(MigrationAddress *addr)
     return false;
 }
 
+static bool transport_supports_multiple_fds(MigrationAddress *addr)
+{
+    /* file: works because QEMU can open it multiple times */
+    return addr->transport == MIGRATION_ADDRESS_TYPE_FILE;
+}
+
 static bool
 migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
@@ -187,6 +203,14 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
         return false;
     }
 
+    if (migration_needs_multiple_fds() &&
+        !transport_supports_multiple_fds(addr)) {
+        error_setg(errp,
+                   "Migration with direct-io is incompatible with the fd: URI,"
+                   " use file: instead");
+        return false;
+    }
+
     return true;
 }
 
diff --git a/migration/options.h b/migration/options.h
index 8680a10b79..39cbc171f7 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -79,6 +79,7 @@ uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 bool migrate_cpu_throttle_tailslow(void);
 int migrate_decompress_threads(void);
+bool migrate_direct_io(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..d0227a60ab 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -277,6 +277,15 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 }
 #endif
 
+bool qemu_has_direct_io(void)
+{
+#ifdef O_DIRECT
+    return true;
+#else
+    return false;
+#endif
+}
+
 static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
 {
     int ret;
-- 
2.35.3


