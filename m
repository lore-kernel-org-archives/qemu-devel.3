Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B4DC79FB7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpxO-0002Gq-5K; Mon, 05 Jan 2026 14:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpwF-0008RS-3o
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:24 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpwD-0005fF-Id
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 811FC3376B;
 Mon,  5 Jan 2026 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjgbcOBfuRqLPGUFxQfqrs1GgBd269095HHC9pJSeLg=;
 b=TSdWNmxEQyWh6z8qjopZWc+JlsaLUaBPQM4ICEjU2aJWT719llJsfflpR+vYwjO1P4vvtc
 Q2syJlRKJEqwIfVUOFxieEx7jjCj1DJBLXuxWs/94tben5WWHLLbFNjg6YLbQqOyu6TJgV
 YEt6ViPuwXPvNSNvBizOdA7GW5+S2XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjgbcOBfuRqLPGUFxQfqrs1GgBd269095HHC9pJSeLg=;
 b=W6DsDZBWM618PHPIfkNAskgyeW+HouNG6cjaaFNdgHOljQy3d2w/TBI4InZzD5Y8pTAU3u
 rGCLFGsNGh9A3+Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjgbcOBfuRqLPGUFxQfqrs1GgBd269095HHC9pJSeLg=;
 b=TSdWNmxEQyWh6z8qjopZWc+JlsaLUaBPQM4ICEjU2aJWT719llJsfflpR+vYwjO1P4vvtc
 Q2syJlRKJEqwIfVUOFxieEx7jjCj1DJBLXuxWs/94tben5WWHLLbFNjg6YLbQqOyu6TJgV
 YEt6ViPuwXPvNSNvBizOdA7GW5+S2XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjgbcOBfuRqLPGUFxQfqrs1GgBd269095HHC9pJSeLg=;
 b=W6DsDZBWM618PHPIfkNAskgyeW+HouNG6cjaaFNdgHOljQy3d2w/TBI4InZzD5Y8pTAU3u
 rGCLFGsNGh9A3+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B699A13964;
 Mon,  5 Jan 2026 19:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ILaOHfILXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v2 22/25] migration: Free cpr-transfer MigrationAddress along
 with gsource
Date: Mon,  5 Jan 2026 16:06:39 -0300
Message-ID: <20260105190644.14072-23-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

When setting a callback on a Glib source and giving it a data pointer,
it's natural to also provide the destructor for the data in question.

Since migrate_hup_add() already needs to clone the MigrationAddress
when setting the qmp_migrate_finish_cb callback, also pass the
qapi_free_MigrationAddress as the GDestroyNotify callback.

With this the address doesn't need to be freed at the callback body,
making the management of that memory slight simpler.

(also fix the indentation of migrate_hup_add)

Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2789a0bd66..044ae2d7a7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2003,9 +2003,11 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
 static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
                             void *opaque)
 {
-        s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
-        g_source_set_callback(s->hup_source, cb, opaque, NULL);
-        g_source_attach(s->hup_source, NULL);
+    s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
+    g_source_set_callback(s->hup_source, cb,
+                          QAPI_CLONE(MigrationAddress, opaque),
+                          (GDestroyNotify)qapi_free_MigrationAddress);
+    g_source_attach(s->hup_source, NULL);
 }
 
 static void migrate_hup_delete(MigrationState *s)
@@ -2024,7 +2026,6 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
     MigrationAddress *addr = opaque;
 
     qmp_migrate_finish(addr, NULL);
-    qapi_free_MigrationAddress(addr);
     return G_SOURCE_REMOVE;
 }
 
@@ -2079,7 +2080,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
-                        QAPI_CLONE(MigrationAddress, main_ch->addr));
+                        main_ch->addr);
 
     } else {
         qmp_migrate_finish(main_ch->addr, errp);
-- 
2.51.0


