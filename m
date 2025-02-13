Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF29C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidV3-00062B-PQ; Thu, 13 Feb 2025 12:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidV1-00061L-Lw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:43 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidUz-00067Q-SI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:43 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77C0B1F795;
 Thu, 13 Feb 2025 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WtTCdWQ3RLhMOAI001oK+Yqb7IUQiMTElSxXwZmj4k=;
 b=kqLFwunXorl7kw3kCjT582ftG+rXV9xZ3Ves+W6lV8+GJXxQUjtzKMP3UY9polMLWdK3xo
 MxwJ0W4q7c6SIMLq+jX0YDrNtWW72lo1yTAw6/1vYuEHyyvnDBknAgXvHmg7VM5aP/JxQJ
 rklMa+gyh7ouUOsTBd781Fx9exs7mvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WtTCdWQ3RLhMOAI001oK+Yqb7IUQiMTElSxXwZmj4k=;
 b=vjFqGB7L7YMxKdprKdni2o7kiFVTYTD/d8dRkAQM2oQUnX2ZcYjU74DhLFiXLb7v/Unc5k
 nTCoNVGvCCaGp9Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WtTCdWQ3RLhMOAI001oK+Yqb7IUQiMTElSxXwZmj4k=;
 b=kqLFwunXorl7kw3kCjT582ftG+rXV9xZ3Ves+W6lV8+GJXxQUjtzKMP3UY9polMLWdK3xo
 MxwJ0W4q7c6SIMLq+jX0YDrNtWW72lo1yTAw6/1vYuEHyyvnDBknAgXvHmg7VM5aP/JxQJ
 rklMa+gyh7ouUOsTBd781Fx9exs7mvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WtTCdWQ3RLhMOAI001oK+Yqb7IUQiMTElSxXwZmj4k=;
 b=vjFqGB7L7YMxKdprKdni2o7kiFVTYTD/d8dRkAQM2oQUnX2ZcYjU74DhLFiXLb7v/Unc5k
 nTCoNVGvCCaGp9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 249BC13874;
 Thu, 13 Feb 2025 17:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gPrwNAkzrmfqMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 17:59:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 4/9] migration: Fix hang after error in destination setup
 phase
Date: Thu, 13 Feb 2025 14:59:22 -0300
Message-Id: <20250213175927.19642-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250213175927.19642-1-farosas@suse.de>
References: <20250213175927.19642-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

If the destination side fails at migration_ioc_process_incoming()
before starting the coroutine, it will report the error but QEMU will
not exit.

Set the migration state to FAILED and exit the process if
exit-on-error allows.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2633
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index 24a91ef911..a547b1fbfe 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -33,6 +33,7 @@
 void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationState *s = migrate_get_current();
+    MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
 
     trace_migration_set_incoming_channel(
@@ -47,6 +48,10 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 
     if (local_err) {
         error_report_err(local_err);
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        if (mis->exit_on_error) {
+            exit(EXIT_FAILURE);
+        }
     }
 }
 
-- 
2.35.3


