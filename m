Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A6AC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWC-000405-BB; Wed, 29 Jan 2025 11:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVT-0003H1-Li
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVR-0005HO-Ta
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEAF0210F3;
 Wed, 29 Jan 2025 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uy4hgmfN5vGrY2cpQdOG8KFL5MAiz+JVZWyxkqK9XgY=;
 b=e9FSWlHF8M/Lpx2BtjVjw72OA1xQbQnyB/yM6P7bpwaKvJXMiVE5EmOzHrI91jtAmfJwIM
 Fx8dEW9ZMdvK8nb7iaxOYT4bDaCesQ0TgnQ1AoacRbWUw8U7PHZK0waygFO0D814EKH0CB
 GUXMGuPHIC9NCUu1N1QU9GHwcpLWEcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uy4hgmfN5vGrY2cpQdOG8KFL5MAiz+JVZWyxkqK9XgY=;
 b=VlP95H8Uvb6NTMUHGJZyN13Yk2e4fG+0GQkI2Ml+jgIMlw1iWWdeTtrDxCKYzqRiScrFlG
 uBKJCUvw6xwvb9BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e9FSWlHF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VlP95H8U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uy4hgmfN5vGrY2cpQdOG8KFL5MAiz+JVZWyxkqK9XgY=;
 b=e9FSWlHF8M/Lpx2BtjVjw72OA1xQbQnyB/yM6P7bpwaKvJXMiVE5EmOzHrI91jtAmfJwIM
 Fx8dEW9ZMdvK8nb7iaxOYT4bDaCesQ0TgnQ1AoacRbWUw8U7PHZK0waygFO0D814EKH0CB
 GUXMGuPHIC9NCUu1N1QU9GHwcpLWEcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uy4hgmfN5vGrY2cpQdOG8KFL5MAiz+JVZWyxkqK9XgY=;
 b=VlP95H8Uvb6NTMUHGJZyN13Yk2e4fG+0GQkI2Ml+jgIMlw1iWWdeTtrDxCKYzqRiScrFlG
 uBKJCUvw6xwvb9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 759F2137DB;
 Wed, 29 Jan 2025 16:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cHecDdpQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 12/42] migration: enhance migrate_uri_parse
Date: Wed, 29 Jan 2025 13:00:29 -0300
Message-Id: <20250129160059.6987-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEAF0210F3
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Export migrate_uri_parse for use outside migration internals, and define
a method migrate_is_uri that indicates when migrate_uri_parse should
be used.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-12-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/misc.h |  7 +++++++
 migration/migration.c    | 11 +++++++++++
 migration/migration.h    |  2 --
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 67f7ef7a0e..c660be8095 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -108,4 +108,11 @@ bool migration_in_bg_snapshot(void);
 bool migration_block_activate(Error **errp);
 bool migration_block_inactivate(void);
 
+/* True if @uri starts with a syntactically valid URI prefix */
+bool migrate_is_uri(const char *uri);
+
+/* Parse @uri and return @channel, returning true on success */
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index fce7b22ae8..b5ee98e691 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -587,6 +588,16 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+bool migrate_is_uri(const char *uri)
+{
+    while (*uri && *uri != ':') {
+        if (!qemu_isalpha(*uri++)) {
+            return false;
+        }
+    }
+    return *uri == ':';
+}
+
 bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                        Error **errp)
 {
diff --git a/migration/migration.h b/migration/migration.h
index 0df2a187af..1d4d4e910d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -519,8 +519,6 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
-                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
-- 
2.35.3


