Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D735E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2br-0007Zn-To; Mon, 02 Feb 2026 17:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bp-0007ZD-V3
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bo-0000ph-EL
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD4D5BCC7;
 Mon,  2 Feb 2026 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLMEjTWFupYh/uII/IPnXh1gkX9mRWuYujdX2vbuxhg=;
 b=H/3MUdVGf/1ihuTbtVe5Wrz6E4bPQN/4aZUXXLywPW+o4K5IkzalJ9VCkMhrfyZZk1mWAX
 NI12tMjzVKskvP+oSMlPrhGwU9pU8TZ4eNDOlxQBcCEcmnqDNPC/igpppVEYbaC4p2e+nd
 9Xw39wiJQ0E+q/WUrrRaVzDdLMsuJ8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLMEjTWFupYh/uII/IPnXh1gkX9mRWuYujdX2vbuxhg=;
 b=1TMTWsfDzNUtM80XlLejGtF7KtUYt1ZQBgnKNAuNtduZgTxSQdNPaWfkFgehd1yXQ0fUYU
 oXlZmsv1GoDqncBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="H/3MUdVG";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1TMTWsfD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLMEjTWFupYh/uII/IPnXh1gkX9mRWuYujdX2vbuxhg=;
 b=H/3MUdVGf/1ihuTbtVe5Wrz6E4bPQN/4aZUXXLywPW+o4K5IkzalJ9VCkMhrfyZZk1mWAX
 NI12tMjzVKskvP+oSMlPrhGwU9pU8TZ4eNDOlxQBcCEcmnqDNPC/igpppVEYbaC4p2e+nd
 9Xw39wiJQ0E+q/WUrrRaVzDdLMsuJ8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLMEjTWFupYh/uII/IPnXh1gkX9mRWuYujdX2vbuxhg=;
 b=1TMTWsfDzNUtM80XlLejGtF7KtUYt1ZQBgnKNAuNtduZgTxSQdNPaWfkFgehd1yXQ0fUYU
 oXlZmsv1GoDqncBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8BCC3EA62;
 Mon,  2 Feb 2026 22:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4IPzJQ8ogWl8XgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 22:41:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com,
	ppandit@redhat.com
Subject: [PATCH v2 7/9] migration/options: Open code migrate_params_apply
Date: Mon,  2 Feb 2026 19:40:59 -0300
Message-ID: <20260202224101.20568-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202224101.20568-1-farosas@suse.de>
References: <20260202224101.20568-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6FD4D5BCC7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 180ebed51c..733aae51a8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1266,25 +1266,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_apply(MigrationParameters *params)
-{
-    MigrationState *s = migrate_get_current();
-    MigrationParameters *cur = &s->parameters;
-
-    migrate_tls_opts_free(cur);
-    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
-    qapi_free_strList(cur->cpr_exec_command);
-
-    /* mark all present, so they're all copied */
-    migrate_mark_all_params_present(params);
-    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
-}
-
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
-                                                    &s->parameters);
+    MigrationParameters *cur = &s->parameters;
+    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters, cur);
 
     /*
      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
@@ -1300,8 +1286,17 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 
     QAPI_MERGE(MigrationParameters, tmp, params);
 
-    if (migrate_params_check(tmp, errp)) {
-        migrate_params_apply(tmp);
-        migrate_post_update_params(params, errp);
+    if (!migrate_params_check(tmp, errp)) {
+        return;
     }
+
+    migrate_tls_opts_free(cur);
+    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
+    qapi_free_strList(cur->cpr_exec_command);
+
+    /* mark all present, so they're all copied */
+    migrate_mark_all_params_present(tmp);
+    QAPI_CLONE_MEMBERS(MigrationParameters, cur, tmp);
+
+    migrate_post_update_params(params, errp);
 }
-- 
2.51.0


