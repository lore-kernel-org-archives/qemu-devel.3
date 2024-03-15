Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F640C54E60
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rky80-0003zF-IQ; Thu, 14 Mar 2024 23:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7u-0003yO-G1
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:20:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7m-0004IF-9y
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:20:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25ED021D44;
 Fri, 15 Mar 2024 03:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niLMWk+PhaKVhiINpnrFIJE7tK7ZrL4Zx8VBbFS5GxA=;
 b=edrMNs18Xa6uB38d9MqhEnj7SaNgTqq7kjHyA0vBP9HnAUv3Qg1L4ZLMw05iNSBwVhXuYw
 jHIBm02E/mYezNYf2TmyhLCxbSFPCd7wvbciZWaqaRl4Q1ErIlJUl393ogEAcxtAYGWzC2
 /65u2C4zjwuW3YOlNGEWJyyIwWk6sak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niLMWk+PhaKVhiINpnrFIJE7tK7ZrL4Zx8VBbFS5GxA=;
 b=aAxkkDEXxZ67eSDUTnDQmDfRsY6ycn2TtkE/RFETtLSgSN4y03t8AaKbh9RL0EGvoDGWGO
 T3cJ1YhXnTNXqkDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niLMWk+PhaKVhiINpnrFIJE7tK7ZrL4Zx8VBbFS5GxA=;
 b=edrMNs18Xa6uB38d9MqhEnj7SaNgTqq7kjHyA0vBP9HnAUv3Qg1L4ZLMw05iNSBwVhXuYw
 jHIBm02E/mYezNYf2TmyhLCxbSFPCd7wvbciZWaqaRl4Q1ErIlJUl393ogEAcxtAYGWzC2
 /65u2C4zjwuW3YOlNGEWJyyIwWk6sak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niLMWk+PhaKVhiINpnrFIJE7tK7ZrL4Zx8VBbFS5GxA=;
 b=aAxkkDEXxZ67eSDUTnDQmDfRsY6ycn2TtkE/RFETtLSgSN4y03t8AaKbh9RL0EGvoDGWGO
 T3cJ1YhXnTNXqkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F271A1368C;
 Fri, 15 Mar 2024 03:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eMaYLYy+82XZcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Mar 2024 03:20:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 1/3] migration/multifd: Ensure we're not given a socket for
 file migration
Date: Fri, 15 Mar 2024 00:20:38 -0300
Message-Id: <20240315032040.7974-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240315032040.7974-1-farosas@suse.de>
References: <20240315032040.7974-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.987]; MID_CONTAINS_FROM(1.00)[];
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

When doing migration using the fd: URI, QEMU will fetch the file
descriptor passed in via the monitor at
fd_start_outgoing|incoming_migration(), which means the checks at
migration_channels_and_transport_compatible() happen too soon and we
don't know at that point whether the FD refers to a plain file or a
socket.

For this reason, we've been allowing a migration channel of type
SOCKET_ADDRESS_TYPE_FD to pass the initial verifications in scenarios
where the socket migration is not supported, such as with fd + multifd.

The commit decdc76772 ("migration/multifd: Add mapped-ram support to
fd: URI") was supposed to add a second check prior to starting
migration to make sure a socket fd is not passed instead of a file fd,
but failed to do so.

Add the missing verification and update the comment explaining this
situation which is currently incorrect.

Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/fd.c        | 8 ++++++++
 migration/file.c      | 7 +++++++
 migration/migration.c | 6 +++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 39a52e5c90..c07030f715 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -22,6 +22,7 @@
 #include "migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-file.h"
+#include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "options.h"
 #include "trace.h"
@@ -95,6 +96,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
     }
 
     if (migrate_multifd()) {
+        if (fd_is_socket(fd)) {
+            error_setg(errp,
+                       "Multifd migration to a socket FD is not supported");
+            object_unref(ioc);
+            return;
+        }
+
         file_create_incoming_channels(ioc, errp);
     } else {
         qio_channel_set_name(ioc, "migration-fd-incoming");
diff --git a/migration/file.c b/migration/file.c
index ddde0ca818..b6e8ba13f2 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -15,6 +15,7 @@
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
+#include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "options.h"
 #include "trace.h"
@@ -58,6 +59,12 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
     int fd = fd_args_get_fd();
 
     if (fd && fd != -1) {
+        if (fd_is_socket(fd)) {
+            error_setg(errp,
+                       "Multifd migration to a socket FD is not supported");
+            goto out;
+        }
+
         ioc = qio_channel_file_new_dupfd(fd, errp);
     } else {
         ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
diff --git a/migration/migration.c b/migration/migration.c
index 644e073b7d..f60bd371e3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -166,9 +166,9 @@ static bool transport_supports_seeking(MigrationAddress *addr)
     }
 
     /*
-     * At this point, the user might not yet have passed the file
-     * descriptor to QEMU, so we cannot know for sure whether it
-     * refers to a plain file or a socket. Let it through anyway.
+     * At this point QEMU has not yet fetched the fd passed in by the
+     * user, so we cannot know for sure whether it refers to a plain
+     * file or a socket. Let it through anyway and check at fd.c.
      */
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         return addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD;
-- 
2.35.3


