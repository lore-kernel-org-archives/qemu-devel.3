Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE0FC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Q6u-0000WH-FV; Wed, 09 Sep 2026 17:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6t-0000Vf-1A
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6r-0005No-Gk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28CDF1FCC7;
 Wed,  9 Sep 2026 21:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dY5+HgwRq14PZGFtzaraOrbMTxf8qkyzrJDWfhP64Sk=;
 b=cTmG88ggsNUXYCtSzrhZw30+T/1zuILhzMW7c7bHcTZwNPrLt83KxwcMUvCuiCR7eMT8Ad
 dlHZzyv0K1nFCAsJGQOtmV5bf0g8VTVfL/j2tuc14x5hQJIqunqPtbsqkfKivrtfhskjZP
 7zWRcYR9Q3T+wN1pr4ZYrCQZ3/5KynE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990332;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dY5+HgwRq14PZGFtzaraOrbMTxf8qkyzrJDWfhP64Sk=;
 b=7Ddh9qXd1Ixsc+h6C7JYyb6apwubQ6Rx8RPWYc0nURJn2QkQ7JQIoeEv5Dy0WUhVJglQ8/
 iwWPr1Agm9R57NAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ohLDTqGA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TkwpsOOF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dY5+HgwRq14PZGFtzaraOrbMTxf8qkyzrJDWfhP64Sk=;
 b=ohLDTqGAICiJhJOp5NFwz7e8PGB6da9LII5a7QTemN6aUzaau5SfbH7jVDp2359AXREIhL
 zvo/+ucBCxaLD7KpwEw8M9vWG+Ns0WObjE40kioZEv927xKA4Wh4freDSZJAiZ7RGi1irv
 57I0FYFJCGgHy7hwcA2C1Z8XlGKtlq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dY5+HgwRq14PZGFtzaraOrbMTxf8qkyzrJDWfhP64Sk=;
 b=TkwpsOOF7CVGubgOlstL/zoH2uVrGTnJV6AosZskvCcD3orm2i9iPgNFbaH5QsLuHpHYoH
 f4ZR0fxKWin2MhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87A3E13223;
 Wed,  9 Sep 2026 21:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gBtzFHbToWqzawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 21:45:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 06/18] migration: Open code migrate_params_apply
Date: Wed,  9 Sep 2026 18:44:56 -0300
Message-ID: <20260909214509.237309-7-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909214509.237309-1-farosas@suse.de>
References: <20260909214509.237309-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28CDF1FCC7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Remove migrate_params_apply so the logic of setting migration
parameters is all in one spot.

Suggested-by: Prasad Pandit <ppandit@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 143710815a..24799eba96 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1385,21 +1385,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-/*
- * Caller must ensure the has_* fields of @params are true so they all
- * get copied and the pointer members don't dangle.
- */
-static void migrate_params_apply(MigrationParameters *params)
-{
-    MigrationState *s = migrate_get_current();
-    MigrationParameters *cur = &s->parameters;
-
-    migrate_tls_opts_free(cur);
-    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
-    qapi_free_strList(cur->cpr_exec_command);
-    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
-}
-
 void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
 {
     MigrationParameters *cur = &migrate_get_current()->parameters;
@@ -1422,8 +1407,15 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
         return;
     }
 
-    if (migrate_params_check(new, errp)) {
-        migrate_params_apply(new);
-        migrate_post_update_params(input, errp);
+    if (!migrate_params_check(new, errp)) {
+        return;
     }
+
+    migrate_tls_opts_free(cur);
+    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
+    qapi_free_strList(cur->cpr_exec_command);
+
+    QAPI_CLONE_MEMBERS(MigrationParameters, cur, new);
+
+    migrate_post_update_params(input, errp);
 }
-- 
2.53.0


