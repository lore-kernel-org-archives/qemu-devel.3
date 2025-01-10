Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DDCE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuL-0001Pq-FL; Fri, 10 Jan 2025 07:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuJ-0001PV-Qs
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:31 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuI-0003KQ-8P
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:31 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21D581F455;
 Fri, 10 Jan 2025 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzxe/xMDN/y6wv++kyYa7dpuPHVGC0cKdT011hdJdO8=;
 b=LE5/ebdDeMKgWHQ4mlf7K77UATjX8DHXToPpyvZVt7O2x1AWnUoFJLRcGJvCsE1FHBbEo4
 86gf2/F5WYQOaRvl62uUPT4ztPVYY6zglnTOfZRBnmOr9fRt7c8YJAyglYMiEE0aaYkvtt
 +iVnnNcPGABsxT2e9smZoKqLelVZmkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzxe/xMDN/y6wv++kyYa7dpuPHVGC0cKdT011hdJdO8=;
 b=B3L5kuKiankEajhqp5rygY3j5XYs8TvrEQKR/uQHRupbx7s8X2rEemRVqkyMwCY8KBSFwE
 M3FThZlnQG5NFDBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzxe/xMDN/y6wv++kyYa7dpuPHVGC0cKdT011hdJdO8=;
 b=LE5/ebdDeMKgWHQ4mlf7K77UATjX8DHXToPpyvZVt7O2x1AWnUoFJLRcGJvCsE1FHBbEo4
 86gf2/F5WYQOaRvl62uUPT4ztPVYY6zglnTOfZRBnmOr9fRt7c8YJAyglYMiEE0aaYkvtt
 +iVnnNcPGABsxT2e9smZoKqLelVZmkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzxe/xMDN/y6wv++kyYa7dpuPHVGC0cKdT011hdJdO8=;
 b=B3L5kuKiankEajhqp5rygY3j5XYs8TvrEQKR/uQHRupbx7s8X2rEemRVqkyMwCY8KBSFwE
 M3FThZlnQG5NFDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2019613A86;
 Fri, 10 Jan 2025 12:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YPN2NSMPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 08/25] migration/multifd: Document the reason to sync for
 save_setup()
Date: Fri, 10 Jan 2025 09:13:56 -0300
Message-Id: <20250110121413.12336-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

It's not straightforward to see why src QEMU needs to sync multifd during
setup() phase.  After all, there's no page queued at that point.

For old QEMUs, there's a solid reason: EOS requires it to work.  While it's
clueless on the new QEMUs which do not take EOS message as sync requests.

One will figure that out only when this is conditionally removed.  In fact,
the author did try it out.  Logically we could still avoid doing this on
new machine types, however that needs a separate compat field and that can
be an overkill in some trivial overhead in setup() phase.

Let's instead document it completely, to avoid someone else tries this
again and do the debug one more time, or anyone confused on why this ever
existed.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241206224755.1108686-8-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index d9336d8a09..ce28328141 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3036,6 +3036,31 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
         migration_ops->ram_save_target_page = ram_save_target_page_legacy;
     }
 
+    /*
+     * This operation is unfortunate..
+     *
+     * For legacy QEMUs using per-section sync
+     * =======================================
+     *
+     * This must exist because the EOS below requires the SYNC messages
+     * per-channel to work.
+     *
+     * For modern QEMUs using per-round sync
+     * =====================================
+     *
+     * Logically such sync is not needed, and recv threads should not run
+     * until setup ready (using things like channels_ready on src).  Then
+     * we should be all fine.
+     *
+     * However even if we add channels_ready to recv side in new QEMUs, old
+     * QEMU won't have them so this sync will still be needed to make sure
+     * multifd recv threads won't start processing guest pages early before
+     * ram_load_setup() is properly done.
+     *
+     * Let's stick with this.  Fortunately the overhead is low to sync
+     * during setup because the VM is running, so at least it's not
+     * accounted as part of downtime.
+     */
     bql_unlock();
     ret = multifd_ram_flush_and_sync(f);
     bql_lock();
-- 
2.35.3


