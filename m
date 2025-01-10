Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85574E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuL-0001Pp-EO; Fri, 10 Jan 2025 07:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuI-0001Od-KC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuG-0003KG-T0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5C1F1F396;
 Fri, 10 Jan 2025 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YILkL8gIZpd2M8zlAaeS2NRxwcKi1GXQ4OHbI20hopE=;
 b=Hko3E7cfT2Upq+WKk7R+Ud+tuhCZyCx3L0j5g80syAkywgImsPTjUZqsCyLUsItcHbmXVC
 dMYtBb6mNzHHladUfTLWGrk5zkjOsaywywYg6/bY5UG8CqXaWpmwG9udjlSjUCq75yFuv+
 lH7n6FA/Mp5hiGhW3ygwVet+GnK+72U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YILkL8gIZpd2M8zlAaeS2NRxwcKi1GXQ4OHbI20hopE=;
 b=nr572TT9nYKU81r2ExXs4BDUnvxrZg0mUajZx1hfeyzjc4r6jvMEN+gDn3Ls8STWdOiO2I
 1JJJ97+YoDvpqhAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hko3E7cf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nr572TT9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YILkL8gIZpd2M8zlAaeS2NRxwcKi1GXQ4OHbI20hopE=;
 b=Hko3E7cfT2Upq+WKk7R+Ud+tuhCZyCx3L0j5g80syAkywgImsPTjUZqsCyLUsItcHbmXVC
 dMYtBb6mNzHHladUfTLWGrk5zkjOsaywywYg6/bY5UG8CqXaWpmwG9udjlSjUCq75yFuv+
 lH7n6FA/Mp5hiGhW3ygwVet+GnK+72U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YILkL8gIZpd2M8zlAaeS2NRxwcKi1GXQ4OHbI20hopE=;
 b=nr572TT9nYKU81r2ExXs4BDUnvxrZg0mUajZx1hfeyzjc4r6jvMEN+gDn3Ls8STWdOiO2I
 1JJJ97+YoDvpqhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADBBD13A86;
 Fri, 10 Jan 2025 12:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cDN3HCIPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 07/25] migration/multifd: Cleanup src flushes on condition check
Date: Fri, 10 Jan 2025 09:13:55 -0300
Message-Id: <20250110121413.12336-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5C1F1F396
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

The src flush condition check is over complicated, and it's getting more
out of control if postcopy will be involved.

In general, we have two modes to do the sync: legacy or modern ways.
Legacy uses per-section flush, modern uses per-round flush.

Mapped-ram always uses the modern, which is per-round.

Introduce two helpers, which can greatly simplify the code, and hopefully
make it readable again.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241206224755.1108686-7-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 42 ++++++++++++++++++++++++++++++++++++++
 migration/multifd.h        |  2 ++
 migration/ram.c            | 10 +++------
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 58372db0f4..c1f686c0ce 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -344,6 +344,48 @@ retry:
     return true;
 }
 
+/*
+ * We have two modes for multifd flushes:
+ *
+ * - Per-section mode: this is the legacy way to flush, it requires one
+ *   MULTIFD_FLAG_SYNC message for each RAM_SAVE_FLAG_EOS.
+ *
+ * - Per-round mode: this is the modern way to flush, it requires one
+ *   MULTIFD_FLAG_SYNC message only for each round of RAM scan.  Normally
+ *   it's paired with a new RAM_SAVE_FLAG_MULTIFD_FLUSH message in network
+ *   based migrations.
+ *
+ * One thing to mention is mapped-ram always use the modern way to sync.
+ */
+
+/* Do we need a per-section multifd flush (legacy way)? */
+bool multifd_ram_sync_per_section(void)
+{
+    if (!migrate_multifd()) {
+        return false;
+    }
+
+    if (migrate_mapped_ram()) {
+        return false;
+    }
+
+    return migrate_multifd_flush_after_each_section();
+}
+
+/* Do we need a per-round multifd flush (modern way)? */
+bool multifd_ram_sync_per_round(void)
+{
+    if (!migrate_multifd()) {
+        return false;
+    }
+
+    if (migrate_mapped_ram()) {
+        return true;
+    }
+
+    return !migrate_multifd_flush_after_each_section();
+}
+
 int multifd_ram_flush_and_sync(QEMUFile *f)
 {
     MultiFDSyncReq req;
diff --git a/migration/multifd.h b/migration/multifd.h
index 0fef431f6b..bd785b9873 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -355,6 +355,8 @@ static inline uint32_t multifd_ram_page_count(void)
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(QEMUFile *f);
+bool multifd_ram_sync_per_round(void);
+bool multifd_ram_sync_per_section(void);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/ram.c b/migration/ram.c
index 9eeb77665b..d9336d8a09 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1302,9 +1302,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (migrate_multifd() &&
-                (!migrate_multifd_flush_after_each_section() ||
-                 migrate_mapped_ram())) {
+            if (multifd_ram_sync_per_round()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
@@ -3178,8 +3176,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
 out:
     if (ret >= 0 && migration_is_running()) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
-            !migrate_mapped_ram()) {
+        if (multifd_ram_sync_per_section()) {
             ret = multifd_ram_flush_and_sync(f);
             if (ret < 0) {
                 return ret;
@@ -3252,8 +3249,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() &&
-        migrate_multifd_flush_after_each_section()) {
+    if (multifd_ram_sync_per_section()) {
         /*
          * Only the old dest QEMU will need this sync, because each EOS
          * will require one SYNC message on each channel.
-- 
2.35.3


