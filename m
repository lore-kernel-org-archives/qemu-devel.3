Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B893FE7FDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2bl-0007Xp-1Q; Mon, 02 Feb 2026 17:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bj-0007XB-16
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:23 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bh-0000nz-HL
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78A713E6CA;
 Mon,  2 Feb 2026 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DY+2W53egeqkeThQ0vISQVGT1GdVd3dzarPpL4KIM2o=;
 b=wEAzdK6CBwL7xMxGl7jD0R8NdTEPe+LiIZ8JzrzCrKO5iuH7+I3XDgDMHNKZbpteCFgmRw
 DL8m8jvVN5zHZkIevPr8AkitHSqMRnc1bKsuAaWC6vpCc/Qv6b9QaficLaWQXAQWQrIJH/
 KbpPUwwFbaNhE4Ix/DEV99nlJteSGv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DY+2W53egeqkeThQ0vISQVGT1GdVd3dzarPpL4KIM2o=;
 b=EYjh4qkhd2luIDE04PG2/TqFE8vKnCOgpNZC0/9+kQrSfvKwcqdIQtnt21P+PvjsJ0nfMd
 0FfMdOqBHZQaOBDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wEAzdK6C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EYjh4qkh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DY+2W53egeqkeThQ0vISQVGT1GdVd3dzarPpL4KIM2o=;
 b=wEAzdK6CBwL7xMxGl7jD0R8NdTEPe+LiIZ8JzrzCrKO5iuH7+I3XDgDMHNKZbpteCFgmRw
 DL8m8jvVN5zHZkIevPr8AkitHSqMRnc1bKsuAaWC6vpCc/Qv6b9QaficLaWQXAQWQrIJH/
 KbpPUwwFbaNhE4Ix/DEV99nlJteSGv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DY+2W53egeqkeThQ0vISQVGT1GdVd3dzarPpL4KIM2o=;
 b=EYjh4qkhd2luIDE04PG2/TqFE8vKnCOgpNZC0/9+kQrSfvKwcqdIQtnt21P+PvjsJ0nfMd
 0FfMdOqBHZQaOBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFC013EA62;
 Mon,  2 Feb 2026 22:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oGGpJwQogWl8XgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 22:41:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com,
	ppandit@redhat.com
Subject: [PATCH v2 2/9] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Date: Mon,  2 Feb 2026 19:40:54 -0300
Message-ID: <20260202224101.20568-3-farosas@suse.de>
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
X-Rspamd-Queue-Id: 78A713E6CA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
method makes the handling of the TLS strings more intuitive because it
clones them as well.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index dcd5e07504..4161648268 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1264,9 +1264,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 static void migrate_params_test_apply(MigrationParameters *params,
                                       MigrationParameters *dest)
 {
-    *dest = migrate_get_current()->parameters;
+    MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
+    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
 
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
@@ -1285,24 +1285,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->tls_creds) {
+        qapi_free_StrOrNull(dest->tls_creds);
         dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
+        qapi_free_StrOrNull(dest->tls_hostname);
         dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
+        qapi_free_StrOrNull(dest->tls_authz);
         dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1359,8 +1353,9 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_block_bitmap_mapping) {
-        dest->has_block_bitmap_mapping = true;
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
+        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
+        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
+                                                params->block_bitmap_mapping);
     }
 
     if (params->has_x_vcpu_dirty_limit_period) {
@@ -1384,7 +1379,8 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_cpr_exec_command) {
-        dest->cpr_exec_command = params->cpr_exec_command;
+        qapi_free_strList(dest->cpr_exec_command);
+        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
 }
 
@@ -1540,4 +1536,6 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     }
 
     migrate_tls_opts_free(&tmp);
+    qapi_free_BitmapMigrationNodeAliasList(tmp.block_bitmap_mapping);
+    qapi_free_strList(tmp.cpr_exec_command);
 }
-- 
2.51.0


