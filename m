Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10651C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GdJ-0003Pd-45; Mon, 14 Sep 2026 20:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdF-0003MR-H7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:41 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdC-0004nY-ST
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FEA021E24;
 Tue, 15 Sep 2026 00:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKs/esBlOFAbBPmBNeIq0MYqcwqzt+NV/Ybw4pONbyc=;
 b=ZODmR7iM7UXcHzCUwSUyCuVZBd7TDQ06H8wvCYAkIPhzIR1fs1S3RYW5bfVwu0A1rA/H5b
 fP/swk2pOFf+eTJe1SS9WgCYRcp6T+XBz2R2k5CKze4000fniK3pCyMl1FU2j534gUd21m
 o63EGWpFOeHOM/u+cw7Oz+rKPQLHRU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKs/esBlOFAbBPmBNeIq0MYqcwqzt+NV/Ybw4pONbyc=;
 b=Fw+6aLNf1SsJZIzPZIU8asbXpeUsnIAjERpuUFJFCe0ggfZGHcLOs7dM/MPpnbhN8Pv/1f
 JoZJhOefPPlmSbDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a6JsQcfa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="g/vgvS74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKs/esBlOFAbBPmBNeIq0MYqcwqzt+NV/Ybw4pONbyc=;
 b=a6JsQcfab4aw9LbBMzajbyVuyu8e8ilbrdr6G4mXdKVB6tbXBnvWUSBvTlRmo/81zYIb9x
 ZeA7ogCUbLEo110d2orJDQeBYIpiYLceRdoX7wlnqRL9+d9yZZ1w24OkTs9R88TajOg0Bv
 Z+RL3gnEf0olaUcjq+wgLa7ASjSVZT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKs/esBlOFAbBPmBNeIq0MYqcwqzt+NV/Ybw4pONbyc=;
 b=g/vgvS74cKjT+xH/TClJPThl/tGijyvNqtGHKFp1JV0qdSDkYrXiKWJjU1ftbdxpaqrMEt
 6t9aOJZh1Baf47CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46D6413710;
 Tue, 15 Sep 2026 00:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T9
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 08/20] migration: Use migrate_params_free during finalize
Date: Mon, 14 Sep 2026 21:01:56 -0300
Message-ID: <20260915000209.3692668-9-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FEA021E24
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
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 3 +--
 migration/options.c   | 7 ++++---
 migration/options.h   | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d14beb5d22..fab7949fe1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4052,8 +4052,7 @@ static void migration_instance_finalize(Object *obj)
 {
     MigrationState *ms = MIGRATION(obj);
 
-    qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
-    qapi_free_strList(ms->parameters.cpr_exec_command);
+    migrate_params_free(&ms->parameters, NULL);
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
diff --git a/migration/options.c b/migration/options.c
index bdcff002db..46d040fc3f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -273,8 +273,9 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
 
 static void release_StrOrNull(Object *obj, const char *name, void *opaque)
 {
-    const Property *prop = opaque;
-    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
+    StrOrNull **ptr = object_field_prop_ptr(obj, opaque);
+
+    g_clear_pointer(ptr, qapi_free_StrOrNull);
 }
 
 static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
@@ -1067,7 +1068,7 @@ AnnounceParameters *migrate_announce_params(void)
     return &ap;
 }
 
-static bool migrate_params_free(MigrationParameters *params, Error **errp)
+bool migrate_params_free(MigrationParameters *params, Error **errp)
 {
     Visitor *v = qapi_dealloc_visitor_new();
     bool ret;
diff --git a/migration/options.h b/migration/options.h
index c272eb6208..c7da2d0b5b 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -93,4 +93,5 @@ uint64_t migrate_rdma_chunk_size(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
+bool migrate_params_free(MigrationParameters *params, Error **errp);
 #endif
-- 
2.53.0


