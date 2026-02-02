Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEAAE7FDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2c0-0007d3-Ql; Mon, 02 Feb 2026 17:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bz-0007cW-6L
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:39 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bx-0000s4-Kd
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C0C13E6CA;
 Mon,  2 Feb 2026 22:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndFxx01WeyvmjNVnmB0MnBffvWrdktmIdW9Eby8Lyow=;
 b=XVmmYfAEgP93eMNzwfMMvN9gAOBNrniwnamz0Pi1JW72R/mRWUaMvCOG3I7Du830shSN0U
 obgnjZX+A30FabbMqn6v2WcvmCs69dvgKeiQuzawT21+Y6C8wtgmt+qqeuvw51baQEMJGd
 ptzlNmu5eDqA+pNn7mt+sYmemF3WolI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndFxx01WeyvmjNVnmB0MnBffvWrdktmIdW9Eby8Lyow=;
 b=Jqsq+yQi8N1PQMATShz9v2I4CtdnBJ+Zfq1LzNmr1p3s9cJgHSQs2m4C81x2uNBwqS2Xmy
 wqqlrAFzEyMY5IBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XVmmYfAE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jqsq+yQi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndFxx01WeyvmjNVnmB0MnBffvWrdktmIdW9Eby8Lyow=;
 b=XVmmYfAEgP93eMNzwfMMvN9gAOBNrniwnamz0Pi1JW72R/mRWUaMvCOG3I7Du830shSN0U
 obgnjZX+A30FabbMqn6v2WcvmCs69dvgKeiQuzawT21+Y6C8wtgmt+qqeuvw51baQEMJGd
 ptzlNmu5eDqA+pNn7mt+sYmemF3WolI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndFxx01WeyvmjNVnmB0MnBffvWrdktmIdW9Eby8Lyow=;
 b=Jqsq+yQi8N1PQMATShz9v2I4CtdnBJ+Zfq1LzNmr1p3s9cJgHSQs2m4C81x2uNBwqS2Xmy
 wqqlrAFzEyMY5IBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F12763EA62;
 Mon,  2 Feb 2026 22:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qGHyKxMogWl8XgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 22:41:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com,
	ppandit@redhat.com
Subject: [PATCH v2 9/9] migration: Use migrate_params_free during finalize
Date: Mon,  2 Feb 2026 19:41:01 -0300
Message-ID: <20260202224101.20568-10-farosas@suse.de>
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
X-Rspamd-Queue-Id: 8C0C13E6CA
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

Use the recently introduced migrate_params_free routine at
migration_instance_finalize() so that newly added pointers are already
freed by default.

Special case: The TLS options are currently the only pointers that
also have a qdev property implementation, so they will be freed by
qdev using the .release method. Update the method so that a second
invocation of qapi_free_StrOrNull doesn't assert.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 3 +--
 migration/options.c   | 7 ++++---
 migration/options.h   | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0..303626c2a9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3840,8 +3840,7 @@ static void migration_instance_finalize(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
-    qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
-    qapi_free_strList(ms->parameters.cpr_exec_command);
+    migrate_params_free(&ms->parameters, NULL);
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
diff --git a/migration/options.c b/migration/options.c
index cc5a66750c..2fc86933be 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -254,8 +254,9 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
 
 static void release_StrOrNull(Object *obj, const char *name, void *opaque)
 {
-    const Property *prop = opaque;
-    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
+    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
+
+    g_clear_pointer(ptr, qapi_free_StrOrNull);
 }
 
 static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
@@ -1002,7 +1003,7 @@ AnnounceParameters *migrate_announce_params(void)
     return &ap;
 }
 
-static bool migrate_params_free(MigrationParameters *params, Error **errp)
+bool migrate_params_free(MigrationParameters *params, Error **errp)
 {
     Visitor *v = qapi_dealloc_visitor_new();
     bool ret;
diff --git a/migration/options.h b/migration/options.h
index 0c3043f1ff..314cdba8d1 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -92,4 +92,5 @@ ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
+bool migrate_params_free(MigrationParameters *params, Error **errp);
 #endif
-- 
2.51.0


