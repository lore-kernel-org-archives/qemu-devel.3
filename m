Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8061D778B2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNG2-0007LM-6a; Fri, 23 Jan 2026 14:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNG0-0007AE-67
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFy-0003rv-FV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:47 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E80143386F;
 Fri, 23 Jan 2026 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGMsJuJkTUWBRnQ/Za12fkFwl/bcaFJO7KolONxWGS0=;
 b=jyuVrMCjLz327/Xh3KfYNNd/CBjJftUyfBWZFP84fwh0NdHO/TISlkIhv3BD7OfWdzohbc
 KMbJagqToXWz21ia38rdHgkAiNiJzgXod8mBEH0NCzBoJlCRR4JDDx2jj1fNJkNu3nu1GS
 8/u6j1a6gyX5VLl+9a1HIY1cntRdtmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGMsJuJkTUWBRnQ/Za12fkFwl/bcaFJO7KolONxWGS0=;
 b=vEa2NLGamPkfEMcaokaaVTv3dcehsNJcg/V2c9CiZ6Nlhw3l0riFhDUCQhE9Gw3+aPkMhj
 fNQHcQ6oPELwF/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGMsJuJkTUWBRnQ/Za12fkFwl/bcaFJO7KolONxWGS0=;
 b=i6XxuYYD52iU4+BSzkDa+C4kgilzrhBGOCPtybpUtcLorsuqKvlU2c1SUVp0rdY9xBrUhC
 BEZsWM/Ha02FcEk6Z0Af4s8EKBlQRigTcsN4jRyNMkvoKTqvImEECbnjP56rT+gc0CbmyQ
 +CYasGwltwwS+Kae/YPStAJv8OdhGHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198095;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGMsJuJkTUWBRnQ/Za12fkFwl/bcaFJO7KolONxWGS0=;
 b=BcmomRfgbRffnK9ag8x0rCg1vrI4x512qiLFkmL+ULjkxEgxlZg7bItjfWum9xzSURlZKD
 RjQEzkTYvVC9zWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 199561395E;
 Fri, 23 Jan 2026 19:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDMVMQ3Sc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 33/36] migration: Free cpr-transfer MigrationAddress along with
 gsource
Date: Fri, 23 Jan 2026 16:53:48 -0300
Message-ID: <20260123195352.12850-34-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When setting a callback on a Glib source and giving it a data pointer,
it's natural to also provide the destructor for the data in question.

Since migrate_hup_add() already needs to clone the MigrationAddress
when setting the qmp_migrate_finish_cb callback, also pass the
qapi_free_MigrationAddress as the GDestroyNotify callback.

With this the address doesn't need to be freed at the callback body,
making the management of that memory slightly simpler.

Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-23-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 336d5df3b2..785e01c0f3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2004,9 +2004,11 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
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
@@ -2025,7 +2027,6 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
     MigrationAddress *addr = opaque;
 
     qmp_migrate_finish(addr, NULL);
-    qapi_free_MigrationAddress(addr);
     return G_SOURCE_REMOVE;
 }
 
@@ -2075,7 +2076,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
-                        QAPI_CLONE(MigrationAddress, main_ch->addr));
+                        main_ch->addr);
 
     } else {
         qmp_migrate_finish(main_ch->addr, errp);
-- 
2.51.0


