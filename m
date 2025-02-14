Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F5BC021A9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2PD-0001Ba-MJ; Fri, 14 Feb 2025 15:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2Mz-0006er-N7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:08 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2Mx-0002Fg-05
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E5471F395;
 Fri, 14 Feb 2025 20:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jMS6Erz+zBLxX49XMODJ4Sas/Uf3cEfXpntQP6Ber8=;
 b=ddDHfPnw9ssBREw5EPpIglL9RqyBFCdlzBHhfLVNiOj8tBoe0QejsgFBn8uzYuYnP7+Cwq
 YDG0gQKFrI8gWBpEexAhEmFCaTMSadKahf1cR7EHgcirUyJSYOpK0AgzPV6jXG07ODSXWt
 hlnfq7Fd+F3S4QHhD3y8vhGXPpHGY1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jMS6Erz+zBLxX49XMODJ4Sas/Uf3cEfXpntQP6Ber8=;
 b=rsK5QbMUKdQKCc2fRKEkc+FqGhMVGZdlQ9g/C+snJF9ZokKMTueP4e/bso2FcGjWmbGICz
 3fybGHjUYfPnEsAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IAemkKhP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u7FlOXD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jMS6Erz+zBLxX49XMODJ4Sas/Uf3cEfXpntQP6Ber8=;
 b=IAemkKhPvNxZYcxp3eU85xpLSABlcqsXcJgiI0KtT1yUn/u79hmakVVg+YL5EjUjEEfq6b
 IeSeB42Ri18SlV93MahgfdqhNWetO5U+vtaSLXKToEi/9Xf1aP/wWokjHZP0XTJVwxYXaL
 Re5rkfYw77QR2cExUPol9P8xUSiYECo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jMS6Erz+zBLxX49XMODJ4Sas/Uf3cEfXpntQP6Ber8=;
 b=u7FlOXD3Kzqp1HkVSolvswJyTgnqw3N3n/qooud3cHbUzKwILrHzc4WAvdC7pj2APIBA/h
 XKiu+x3ZlKJ+iPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41EAF13AFC;
 Fri, 14 Feb 2025 20:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OMwUAFmor2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 13/22] migration: Reject qmp_migrate_cancel after postcopy
Date: Fri, 14 Feb 2025 17:31:50 -0300
Message-Id: <20250214203159.30168-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E5471F395
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_NIXSPAM_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:server fail];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
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

After postcopy has started, it's not possible to recover the source
machine in case a migration error occurs because the destination has
already been changing the state of the machine. For that same reason,
it doesn't make sense to try to cancel the migration after postcopy
has started. Reject the cancel command during postcopy.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20250213175927.19642-6-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index c39cedef3b..48c9ad3c96 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2251,7 +2251,18 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
 
 void qmp_migrate_cancel(Error **errp)
 {
-    migration_cancel(NULL);
+    /*
+     * After postcopy migration has started, the source machine is not
+     * recoverable in case of a migration error. This also means the
+     * cancel command cannot be used as cancel should allow the
+     * machine to continue operation.
+     */
+    if (migration_in_postcopy()) {
+        error_setg(errp, "Postcopy migration in progress, cannot cancel.");
+        return;
+    }
+
+    migration_cancel();
 }
 
 void qmp_migrate_continue(MigrationStatus state, Error **errp)
-- 
2.35.3


