Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BB8E73158
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 12:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtF5-0003jL-Rp; Mon, 02 Feb 2026 07:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmtF3-0003gl-VX
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 07:41:21 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmtF1-0008Eg-L8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 07:41:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A4725BD71;
 Mon,  2 Feb 2026 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770036076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUy9P9cz2iAraAOw/O9urk50Wc9IlGU8QXqpKAjvnXE=;
 b=yfXc+u2wYy7BRE1xSJeYek7d1GqdyLQkevu79g6DwSDjODVG4NFLx7z851ZIfQFA2Vidd2
 n/Le1Wwl+fq6B1FwTtV/leL7VaLBZla59+vbu+gvGx/4+PdKX1EspFJ0+VavjxEqaZdc4Y
 uENd1F1L3116fOpCuVc2h1hdH1W/pa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770036076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUy9P9cz2iAraAOw/O9urk50Wc9IlGU8QXqpKAjvnXE=;
 b=sETIDtDu9pFy9iCCjNu6f5ItQrZLBAvddIjrylPbc1IT0CyhtsgtdEsGZBLMys8XzwM7HC
 iatU1WN8r3q4hnBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yfXc+u2w;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sETIDtDu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770036076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUy9P9cz2iAraAOw/O9urk50Wc9IlGU8QXqpKAjvnXE=;
 b=yfXc+u2wYy7BRE1xSJeYek7d1GqdyLQkevu79g6DwSDjODVG4NFLx7z851ZIfQFA2Vidd2
 n/Le1Wwl+fq6B1FwTtV/leL7VaLBZla59+vbu+gvGx/4+PdKX1EspFJ0+VavjxEqaZdc4Y
 uENd1F1L3116fOpCuVc2h1hdH1W/pa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770036076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZUy9P9cz2iAraAOw/O9urk50Wc9IlGU8QXqpKAjvnXE=;
 b=sETIDtDu9pFy9iCCjNu6f5ItQrZLBAvddIjrylPbc1IT0CyhtsgtdEsGZBLMys8XzwM7HC
 iatU1WN8r3q4hnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC9933EA62;
 Mon,  2 Feb 2026 12:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yZ7cKmqbgGlFMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 12:41:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH] migration: Update comments mentioning qmp_migrate_finish
Date: Mon,  2 Feb 2026 09:41:12 -0300
Message-ID: <20260202124112.30684-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0A4725BD71
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

The qmp_migrate_finish function was recently removed in commit
2379a04e60 ("migration: Remove qmp_migrate_finish"), update comments
that mention it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0..1f5c289d68 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1469,8 +1469,8 @@ void migration_cancel(void)
     }
 
     /*
-     * If qmp_migrate_finish has not been called, then there is no path that
-     * will complete the cancellation.  Do it now.
+     * If migration_connect_outgoing has not been called, then there
+     * is no path that will complete the cancellation. Do it now.
      */
     if (setup && !s->to_dst_file) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
@@ -2051,11 +2051,12 @@ void qmp_migrate(const char *uri, bool has_channels,
      * For cpr-transfer, the target may not be listening yet on the migration
      * channel, because first it must finish cpr_load_state.  The target tells
      * us it is listening by closing the cpr-state socket.  Wait for that HUP
-     * event before connecting in qmp_migrate_finish.
+     * event before connecting in migration_connect_outgoing.
      *
      * The HUP could occur because the target fails while reading CPR state,
      * in which case the target will not listen for the incoming migration
-     * connection, so qmp_migrate_finish will fail to connect, and then recover.
+     * connection, so migration_connect_outgoing will fail to connect,
+     * and then recover.
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         cpr_transfer_add_hup_watch(s, migration_connect_outgoing_cb,
-- 
2.51.0


