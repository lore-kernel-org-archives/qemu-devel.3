Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28EACD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNi-0005YX-Qj; Wed, 04 Sep 2024 08:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNh-0005TK-CA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:05 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNf-0005fC-GR
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 249902119F;
 Wed,  4 Sep 2024 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=XMff969g6afOWmqBsjWeDZFty1xZKxBNkjwTFYtJ0nS6JrpMLfTIijVsEFa5x1F9kfRijy
 G5U3H19pDryumjlaIDh3TshascAva/A8CetXS/Ky6s7UD9SUftjSJVERSM9pyhknj7swJo
 vhFzXUX8DfPVIJYf1dh0CwE1v1k7n30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=rbauHAKQC3L24MXik1jtczOUqdQ5rWJIWRg5RNjCTbJjNTx/+TOQL0oye9k5OV6YHWzqUX
 whctu73vKP48oMAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=XMff969g6afOWmqBsjWeDZFty1xZKxBNkjwTFYtJ0nS6JrpMLfTIijVsEFa5x1F9kfRijy
 G5U3H19pDryumjlaIDh3TshascAva/A8CetXS/Ky6s7UD9SUftjSJVERSM9pyhknj7swJo
 vhFzXUX8DfPVIJYf1dh0CwE1v1k7n30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=rbauHAKQC3L24MXik1jtczOUqdQ5rWJIWRg5RNjCTbJjNTx/+TOQL0oye9k5OV6YHWzqUX
 whctu73vKP48oMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2ED9139D2;
 Wed,  4 Sep 2024 12:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SLnaLUxW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:45:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/34] migration/multifd: Allow multifd sync without flush
Date: Wed,  4 Sep 2024 09:44:07 -0300
Message-Id: <20240904124417.14565-25-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.933];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Separate the multifd sync from flushing the client data to the
channels. These two operations are closely related but not strictly
necessary to be executed together.

The multifd sync is intrinsic to how multifd works. The multiple
channels operate independently and may finish IO out of order in
relation to each other. This applies also between the source and
destination QEMU.

Flushing the data that is left in the client-owned data structures
(e.g. MultiFDPages_t) prior to sync is usually the right thing to do,
but that is particular to how the ram migration is implemented with
several passes over dirty data.

Make these two routines separate, allowing future code to call the
sync by itself if needed. This also allows the usage of
multifd_ram_send to be isolated to ram code.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 13 +++++++++----
 migration/multifd.h |  1 +
 migration/ram.c     |  8 ++++----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index cb7a121eb0..ce08257706 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -914,11 +914,8 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(void)
+int multifd_ram_flush_and_sync(void)
 {
-    int i;
-    bool flush_zero_copy;
-
     if (!migrate_multifd()) {
         return 0;
     }
@@ -930,6 +927,14 @@ int multifd_send_sync_main(void)
         }
     }
 
+    return multifd_send_sync_main();
+}
+
+int multifd_send_sync_main(void)
+{
+    int i;
+    bool flush_zero_copy;
+
     flush_zero_copy = migrate_zero_copy_send();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
diff --git a/migration/multifd.h b/migration/multifd.h
index 5fa384d9af..00c872dfda 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -270,4 +270,5 @@ static inline uint32_t multifd_ram_page_count(void)
 
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
+int multifd_ram_flush_and_sync(void);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 1815b2557b..67ca3d5d51 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1326,7 +1326,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                 (!migrate_multifd_flush_after_each_section() ||
                  migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_send_sync_main();
+                int ret = multifd_ram_flush_and_sync();
                 if (ret < 0) {
                     return ret;
                 }
@@ -3066,7 +3066,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     bql_unlock();
-    ret = multifd_send_sync_main();
+    ret = multifd_ram_flush_and_sync();
     bql_lock();
     if (ret < 0) {
         error_setg(errp, "%s: multifd synchronization failed", __func__);
@@ -3213,7 +3213,7 @@ out:
         && migration_is_setup_or_active()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
-            ret = multifd_send_sync_main();
+            ret = multifd_ram_flush_and_sync();
             if (ret < 0) {
                 return ret;
             }
@@ -3285,7 +3285,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_send_sync_main();
+    ret = multifd_ram_flush_and_sync();
     if (ret < 0) {
         return ret;
     }
-- 
2.35.3


