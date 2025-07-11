Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DBEC83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEa6-0004Km-Fq; Fri, 11 Jul 2025 10:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETB-0001WO-6r
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET8-0006fV-NR
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A1BF21190;
 Fri, 11 Jul 2025 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCqEvWe9GNRh7oYXCD6PB4Slj9Qc/7F7uIcxx9tkTxo=;
 b=gl6LQsa9V5iopGV5WIbhQJ62IeAiRbJqypzd40RrPutwpeeVk6Sy5yyOvvnIleKO4X7Dy+
 Nlwyscrqs+AtgQES22SgD+CR0VDz5wsyGJRXUDzHZUgzi6OYzXb7C0QskYxRTSI/hVKztH
 Tmmr4vL19+e6+2WgpU/Vq3qQElYb9mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCqEvWe9GNRh7oYXCD6PB4Slj9Qc/7F7uIcxx9tkTxo=;
 b=4Rz4U+uVexoF9qq5FpX1mf99hQzfqHfL34So0Go5qNc/uQn/1PqDciHFuj/tp0F50Hldsc
 tIh4chM1eB53hVCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gl6LQsa9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4Rz4U+uV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCqEvWe9GNRh7oYXCD6PB4Slj9Qc/7F7uIcxx9tkTxo=;
 b=gl6LQsa9V5iopGV5WIbhQJ62IeAiRbJqypzd40RrPutwpeeVk6Sy5yyOvvnIleKO4X7Dy+
 Nlwyscrqs+AtgQES22SgD+CR0VDz5wsyGJRXUDzHZUgzi6OYzXb7C0QskYxRTSI/hVKztH
 Tmmr4vL19+e6+2WgpU/Vq3qQElYb9mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCqEvWe9GNRh7oYXCD6PB4Slj9Qc/7F7uIcxx9tkTxo=;
 b=4Rz4U+uVexoF9qq5FpX1mf99hQzfqHfL34So0Go5qNc/uQn/1PqDciHFuj/tp0F50Hldsc
 tIh4chM1eB53hVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 262061388B;
 Fri, 11 Jul 2025 14:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CEVQNWwbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 09/26] migration/ram: Add tracepoints for ram_save_complete()
Date: Fri, 11 Jul 2025 11:10:14 -0300
Message-Id: <20250711141031.423-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 7A1BF21190
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Take notes on start/end state of dirty pages for the whole system.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250613140801.474264-10-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c        | 5 +++++
 migration/trace-events | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index aa76f0a53f..e4871b4c17 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3290,6 +3290,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     RAMState *rs = *temp;
     int ret = 0;
 
+    trace_ram_save_complete(rs->migration_dirty_pages, 0);
+
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
@@ -3353,6 +3355,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+
+    trace_ram_save_complete(rs->migration_dirty_pages, 1);
+
     return qemu_fflush(f);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index c506e11a2e..dcd8fe9a0c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -105,6 +105,7 @@ ram_load_postcopy_loop(int channel, uint64_t addr, int flags) "chan=%d addr=0x%"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+ram_save_complete(uint64_t dirty_pages, int done) "dirty=%" PRIu64 ", done=%d"
 ram_dirty_bitmap_request(char *str) "%s"
 ram_dirty_bitmap_reload_begin(char *str) "%s"
 ram_dirty_bitmap_reload_complete(char *str) "%s"
-- 
2.35.3


