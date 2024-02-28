Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2079C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLkb-0006UW-BQ; Wed, 28 Feb 2024 10:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkZ-0006Ts-GQ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:39 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkW-0004iz-Jb
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 527C5225C1;
 Wed, 28 Feb 2024 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWKpk5kFTB0ffXq3RmhN1pMtAuvGuWn1icA+c5Gyk5s=;
 b=dWJMLAdYlPHYfIHOyd+t52IV386+vEZWi+7OuH/yikaVuW2f65ntPI4JTih93nUzwytY4p
 MEj9xJmD8dR1mWqAn3IC5UDrRF27+RR3pglFZrYQrkEeXVCNwQVXYqjslWJcjYlQrZtcoB
 SjHIf2viOkBfwC2ovingCgs2eZG0V6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWKpk5kFTB0ffXq3RmhN1pMtAuvGuWn1icA+c5Gyk5s=;
 b=TOHyE0Od0wW6mzwLM9BGPIg9aA/5ZXoVPNoPwd7G5Ryh3BnZdtuoA9KqDjzCqPc2hZRASy
 nH/zS33zmquBGVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWKpk5kFTB0ffXq3RmhN1pMtAuvGuWn1icA+c5Gyk5s=;
 b=dWJMLAdYlPHYfIHOyd+t52IV386+vEZWi+7OuH/yikaVuW2f65ntPI4JTih93nUzwytY4p
 MEj9xJmD8dR1mWqAn3IC5UDrRF27+RR3pglFZrYQrkEeXVCNwQVXYqjslWJcjYlQrZtcoB
 SjHIf2viOkBfwC2ovingCgs2eZG0V6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWKpk5kFTB0ffXq3RmhN1pMtAuvGuWn1icA+c5Gyk5s=;
 b=TOHyE0Od0wW6mzwLM9BGPIg9aA/5ZXoVPNoPwd7G5Ryh3BnZdtuoA9KqDjzCqPc2hZRASy
 nH/zS33zmquBGVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1CC113A5D;
 Wed, 28 Feb 2024 15:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kJIAHnxP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:21:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 01/23] migration/multifd: Cleanup multifd_recv_sync_main
Date: Wed, 28 Feb 2024 12:21:05 -0300
Message-Id: <20240228152127.18769-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Some minor cleanups and documentation for multifd_recv_sync_main.

Use thread_count as done in other parts of the code. Remove p->id from
the multifd_recv_state sync, since that is global and not tied to a
channel. Add documentation for the sync steps.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c    | 17 +++++++++++++----
 migration/trace-events |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 6c07f19af1..c7389bf833 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1182,18 +1182,27 @@ void multifd_recv_cleanup(void)
 
 void multifd_recv_sync_main(void)
 {
+    int thread_count = migrate_multifd_channels();
     int i;
 
     if (!migrate_multifd()) {
         return;
     }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        trace_multifd_recv_sync_main_wait(p->id);
+    /*
+     * Initiate the synchronization by waiting for all channels.
+     * For socket-based migration this means each channel has received
+     * the SYNC packet on the stream.
+     */
+    for (i = 0; i < thread_count; i++) {
+        trace_multifd_recv_sync_main_wait(i);
         qemu_sem_wait(&multifd_recv_state->sem_sync);
     }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+
+    /*
+     * Sync done. Release the channels for the next iteration.
+     */
+    for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         WITH_QEMU_LOCK_GUARD(&p->mutex) {
diff --git a/migration/trace-events b/migration/trace-events
index 298ad2b0dd..bf1a069632 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -132,7 +132,7 @@ multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uin
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
-multifd_recv_sync_main_wait(uint8_t id) "channel %u"
+multifd_recv_sync_main_wait(uint8_t id) "iter %u"
 multifd_recv_terminate_threads(bool error) "error %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %u packets %" PRIu64 " pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%u"
-- 
2.35.3


