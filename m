Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD4C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 13:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5340-0005F8-ES; Wed, 16 Apr 2025 09:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u533l-0005Ct-Uo
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:44:15 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u533k-00069R-2R
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:44:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D64831F745;
 Wed, 16 Apr 2025 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744811044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VT7M2iwpTi7wX2zxfXYkAAhTkv8rAUPmL6gfxSYd9I=;
 b=oyJsJa8szgV7YWhVmNTN9f/v96JZKUtDgTzDsSdlImiLiqNBZBCulUwnaVK4Cgekm1iEMe
 vXgNa6OYwnef4k815EF5iM0jKXl7UhFjsZ8NBMFVrPNw3K3tZ0NcVchZv0s8ZKh9NrXYpE
 WtR8S8YnUrdxJYVxDzQwp83H3XkLpB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744811044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VT7M2iwpTi7wX2zxfXYkAAhTkv8rAUPmL6gfxSYd9I=;
 b=XP2nq+bkF5aAR9FVm/z1s9W/qM+BhFGVBhfGM1cGvGITUrW09Xkuq9TdZObAXgetxdOryH
 OekIY5/FoSy1VxDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oyJsJa8s;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XP2nq+bk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744811044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VT7M2iwpTi7wX2zxfXYkAAhTkv8rAUPmL6gfxSYd9I=;
 b=oyJsJa8szgV7YWhVmNTN9f/v96JZKUtDgTzDsSdlImiLiqNBZBCulUwnaVK4Cgekm1iEMe
 vXgNa6OYwnef4k815EF5iM0jKXl7UhFjsZ8NBMFVrPNw3K3tZ0NcVchZv0s8ZKh9NrXYpE
 WtR8S8YnUrdxJYVxDzQwp83H3XkLpB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744811044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VT7M2iwpTi7wX2zxfXYkAAhTkv8rAUPmL6gfxSYd9I=;
 b=XP2nq+bkF5aAR9FVm/z1s9W/qM+BhFGVBhfGM1cGvGITUrW09Xkuq9TdZObAXgetxdOryH
 OekIY5/FoSy1VxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C02D813A39;
 Wed, 16 Apr 2025 13:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6N9FHyO0/2czQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Apr 2025 13:44:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/2] migration/multifd: Fix received packets tracepoint
Date: Wed, 16 Apr 2025 10:43:55 -0300
Message-Id: <20250416134356.29879-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250416134356.29879-1-farosas@suse.de>
References: <20250416134356.29879-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D64831F745
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

When qatomic_fetch_inc() started being used to count the number of
packets sent, the printing of the number of packets received stopped
matching the number of packets sent.

Fix by moving the increment of the number of packets on the recv side
to multifd_recv_unfill_packet().

Also change the tracepoint text because "packet num" is ambiguous for
the sync since the packet number of the actual sync packet will be one
less than the total number of packets seen so far.

Fixes: 98ea497d8b ("migration/multifd: Fix MultiFDSendParams.packet_num race")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c    | 6 +-----
 migration/trace-events | 4 ++--
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index dfb5189f0e..1a16155864 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -310,6 +310,7 @@ static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
+    qatomic_inc(&multifd_recv_state->packet_num);
     p->packets_recved++;
 
     if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
@@ -1222,11 +1223,6 @@ void multifd_recv_sync_main(void)
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        WITH_QEMU_LOCK_GUARD(&p->mutex) {
-            if (multifd_recv_state->packet_num < p->packet_num) {
-                multifd_recv_state->packet_num = p->packet_num;
-            }
-        }
         trace_multifd_recv_sync_main_signal(p->id);
         qemu_sem_post(&p->sem_sync);
     }
diff --git a/migration/trace-events b/migration/trace-events
index c506e11a2e..48acb126f5 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -133,7 +133,7 @@ multifd_new_send_channel_async(uint8_t id) "channel %u"
 multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
 multifd_recv_unfill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
-multifd_recv_sync_main(long packet_num) "packet num %ld"
+multifd_recv_sync_main(long packet_num) "packets before sync %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %u"
 multifd_recv_sync_main_wait(uint8_t id) "iter %u"
 multifd_recv_terminate_threads(bool error) "error %d"
@@ -142,7 +142,7 @@ multifd_recv_thread_start(uint8_t id) "%u"
 multifd_send_fill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
 multifd_send_ram_fill(uint8_t id, uint32_t normal, uint32_t zero) "channel %u normal pages %u zero pages %u"
 multifd_send_error(uint8_t id) "channel %u"
-multifd_send_sync_main(long packet_num) "packet num %ld"
+multifd_send_sync_main(long packet_num) "packets before sync %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(void) ""
-- 
2.35.3


