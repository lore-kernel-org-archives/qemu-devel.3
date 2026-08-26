Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B215C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEd6-00015u-NW; Wed, 26 Aug 2026 10:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEd3-00014c-5A
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:25 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEd0-0001Qr-75
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD0921202;
 Wed, 26 Aug 2026 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RWZvgUuba1ly+5mbsdaLDsGlIp3+oJgpWbcXQM0UqA=;
 b=fHJ86Cj7aEXqCKMnjaDdN1Y1JbOVgpYtw4LLhLJaTrxlgRFcHOpSU9qFl18T0Y8FRkafS3
 DxdU4NiYQHRYoCDcWHcsOxxeYvFQlvVUGSDbKoXAx6RKOUkGY7rdjH6sHPu0BBc0jBEOKb
 /LLUHcOGBf/Tpaf0iNpbiuNgysbw8DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RWZvgUuba1ly+5mbsdaLDsGlIp3+oJgpWbcXQM0UqA=;
 b=IxBmaaw7lcYwei83P5dVahzMKjk1mJOdx4mBF3zmGIP0aLoSOxE2IwT84POSrO5r4Kpd8D
 KGj7vl5EVOrYFvAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hq2pOURT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7+ffzkZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RWZvgUuba1ly+5mbsdaLDsGlIp3+oJgpWbcXQM0UqA=;
 b=hq2pOURT+okRaqwlh4wjwTTraboSnFO1EMpmb5fJrh3IdL54tTTdaoTkUzr1kHfjS9XsU9
 fhHXkbmcnYx+gdDp7e4Bsnt7/vV0SZGk4kV6lk6oQN2bAsLqq8mk2LeQ945Ulxz6gMAC8U
 NrmxS3/Qw3e9oEFdqbQmfo7vKJyB1kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RWZvgUuba1ly+5mbsdaLDsGlIp3+oJgpWbcXQM0UqA=;
 b=7+ffzkZ7KpvEXWOEFTxIQ5X9BvPTliomlkWthKscHXiWayJJ+8EvgCxPpL5R3Hl/4Ag31o
 Co2daDGp2Rxb36BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E6E41361C;
 Wed, 26 Aug 2026 14:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EG/5EzX4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 01/30] migration: Propagate error in postcopy setup functions
Date: Wed, 26 Aug 2026 11:28:36 -0300
Message-ID: <20260826142905.2315503-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9AD0921202
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Modernize error handling in postcopy_ram_incoming_setup() and
postcopy_temp_pages_setup() by replacing error_reports and local error
handling with standard Error propagation.

Replace use of strerror() on errno with error_setg_errno() for modular
handling of errors and change return values to -1 on failure as no
caller checks the actual return value.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 43 +++++++++++++++++-----------------------
 migration/postcopy-ram.h |  2 +-
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a3314d3180d..120828a2ead 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1462,10 +1462,9 @@ retry:
     return NULL;
 }
 
-static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
+static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyTmpPage *tmp_page;
-    int err;
     unsigned i, channels;
     void *temp_page;
 
@@ -1485,11 +1484,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
         temp_page = mmap(NULL, mis->largest_page_size, PROT_READ | PROT_WRITE,
                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
         if (temp_page == MAP_FAILED) {
-            err = errno;
-            error_report("%s: Failed to map postcopy_tmp_pages[%d]: %s",
-                         __func__, i, strerror(err));
+            error_setg_errno(errp, errno,
+                             "%s: Failed to map postcopy_tmp_pages[%d]",
+                             __func__, i);
             /* Clean up will be done later */
-            return -err;
+            return -1;
         }
         tmp_page->tmp_huge_page = temp_page;
         /* Initialize default states for each tmp page */
@@ -1503,11 +1502,10 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
                                        PROT_READ | PROT_WRITE,
                                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (mis->postcopy_tmp_zero_page == MAP_FAILED) {
-        err = errno;
         mis->postcopy_tmp_zero_page = NULL;
-        error_report("%s: Failed to map large zero page %s",
-                     __func__, strerror(err));
-        return -err;
+        error_setg_errno(errp, errno, "%s: Failed to map large zero page",
+                         __func__);
+        return -1;
     }
 
     memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
@@ -1515,15 +1513,13 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
     return 0;
 }
 
-int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis, Error **errp)
 {
-    Error *local_err = NULL;
-
     /* Open the fd for the kernel to give us userfaults */
     mis->userfault_fd = uffd_open(O_CLOEXEC | O_NONBLOCK);
     if (mis->userfault_fd == -1) {
-        error_report("%s: Failed to open userfault fd: %s", __func__,
-                     strerror(errno));
+        error_setg_errno(errp, errno, "%s: Failed to open userfault fd",
+                         __func__);
         return -1;
     }
 
@@ -1531,8 +1527,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
      * Although the host check already tested the API, we need to
      * do the check again as an ABI handshake on the new fd.
      */
-    if (!ufd_check_and_apply(mis->userfault_fd, mis, &local_err)) {
-        error_report_err(local_err);
+    if (!ufd_check_and_apply(mis->userfault_fd, mis, errp)) {
         return -1;
     }
 
@@ -1544,8 +1539,8 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
     /* Now an eventfd we use to tell the fault-thread to quit */
     mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
     if (mis->userfault_event_fd == -1) {
-        error_report("%s: Opening userfault_event_fd: %s", __func__,
-                     strerror(errno));
+        error_setg_errno(errp, errno, "%s: Opening userfault_event_fd",
+                         __func__);
         close(mis->userfault_fd);
         return -1;
     }
@@ -1557,12 +1552,11 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
 
     /* Mark so that we get notified of accesses to unwritten areas */
     if (foreach_not_ignored_block(ram_block_enable_notify, mis)) {
-        error_report("ram_block_enable_notify failed");
+        error_setg(errp, "ram_block_enable_notify failed");
         return -1;
     }
 
-    if (postcopy_temp_pages_setup(mis)) {
-        /* Error dumped in the sub-function */
+    if (postcopy_temp_pages_setup(mis, errp)) {
         return -1;
     }
 
@@ -1727,7 +1721,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
     g_assert_not_reached();
 }
 
-int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis, Error **errp)
 {
     g_assert_not_reached();
 }
@@ -2199,9 +2193,8 @@ int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
      * shouldn't be doing anything yet so don't actually expect requests
      */
     if (migrate_postcopy_ram()) {
-        if (postcopy_ram_incoming_setup(mis)) {
+        if (postcopy_ram_incoming_setup(mis, errp)) {
             postcopy_ram_incoming_cleanup(mis);
-            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
             return -1;
         }
     }
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index a080dd65a77..98d918713f5 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -23,7 +23,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
  * Make all of RAM sensitive to accesses to areas that haven't yet been written
  * and wire up anything necessary to deal with it.
  */
-int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis, Error **errp);
 
 /*
  * Initialise postcopy-ram, setting the RAM to a state where we can go into
-- 
2.53.0


