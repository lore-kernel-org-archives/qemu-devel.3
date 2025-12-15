Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2006D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdd-0002rn-ME; Mon, 15 Dec 2025 17:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdc-0002rJ-04
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:52 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGda-0002j2-1F
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:51 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A83833779;
 Mon, 15 Dec 2025 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUsESkiBYJnoJz6SpMr59J6WRnxFY4FVJgC6WV2y+mI=;
 b=i8yQhwy55NUW9g/m2XR0XPu7neOdHyhjlOrLSW6Wj2EjaBoU7wuC4/5xhWmlk40bsHmmtD
 pFHDEUwQ3ZmxyioJZjL82wIHQ89i6tSzhULFGohiRy5aP9wO2bext7O6y3Fat20bAcvyHI
 m+WiL707BWiC7x++8CDTOyDSErcAJUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUsESkiBYJnoJz6SpMr59J6WRnxFY4FVJgC6WV2y+mI=;
 b=2vpC/rwPptAhq9lbvX7CwmqXg4fi/eHl9rzWh+5/Eya46SuSvWGP+9QgRVRR3fWntBvFCL
 Bw4Q5KA3EhidNtCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUsESkiBYJnoJz6SpMr59J6WRnxFY4FVJgC6WV2y+mI=;
 b=i8yQhwy55NUW9g/m2XR0XPu7neOdHyhjlOrLSW6Wj2EjaBoU7wuC4/5xhWmlk40bsHmmtD
 pFHDEUwQ3ZmxyioJZjL82wIHQ89i6tSzhULFGohiRy5aP9wO2bext7O6y3Fat20bAcvyHI
 m+WiL707BWiC7x++8CDTOyDSErcAJUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUsESkiBYJnoJz6SpMr59J6WRnxFY4FVJgC6WV2y+mI=;
 b=2vpC/rwPptAhq9lbvX7CwmqXg4fi/eHl9rzWh+5/Eya46SuSvWGP+9QgRVRR3fWntBvFCL
 Bw4Q5KA3EhidNtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB4693EA63;
 Mon, 15 Dec 2025 22:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8KsgG0aFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 22/51] migration: Store the initial values used for
 s->parameters
Date: Mon, 15 Dec 2025 19:00:08 -0300
Message-ID: <20251215220041.12657-23-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.986];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Each migration parameter has a default value, store them for later
use in resetting s->parameters. Values overridden via the command line
with the debugging option -global migration.<param> will be included.

Make the structure const and change the appropriate signatures to make
sure its values are not changed by accident. Some functions take two
MigrationParameters pointers and it's easy to confuse them.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  3 +++
 migration/migration.h |  6 ++++++
 migration/options.c   | 21 +++++++++++++++++----
 migration/options.h   |  7 ++++---
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 182dccd579..90b381b1fe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -331,6 +331,7 @@ void migration_object_init(void)
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
 
     migration_object_check(current_migration, &error_fatal);
+    migrate_params_store_defaults(current_migration);
 
     ram_mig_init();
     dirty_bitmap_mig_init();
@@ -4149,6 +4150,8 @@ static void migration_instance_finalize(Object *obj)
 
     qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
     qapi_free_strList(ms->parameters.cpr_exec_command);
+    /* drop const */
+    qapi_free_MigrationParameters((MigrationParameters *)ms->initial_params);
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
diff --git a/migration/migration.h b/migration/migration.h
index 5fe5f8a23e..a4b5dbb09b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -320,6 +320,12 @@ struct MigrationState {
 
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
+    /*
+     * This holds the values initially set in the 'parameters' struct
+     * above. Any values overriden by -global migration.<parameter>
+     * will be reflected here as well.
+     */
+    const MigrationParameters *initial_params;
 
     MigrationStatus state;
 
diff --git a/migration/options.c b/migration/options.c
index d3bb65513b..d1d8e5c181 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -505,7 +505,7 @@ bool migrate_can_snapshot(Error **errp)
     return true;
 }
 
-bool migrate_rdma_caps_check(MigrationParameters *params, Error **errp)
+bool migrate_rdma_caps_check(const MigrationParameters *params, Error **errp)
 {
     if (params->xbzrle) {
         error_setg(errp, "RDMA and XBZRLE can't be used together");
@@ -523,7 +523,7 @@ bool migrate_rdma_caps_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-bool migrate_caps_check(MigrationParameters *new, Error **errp)
+bool migrate_caps_check(const MigrationParameters *new, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -1182,7 +1182,7 @@ static void migrate_post_update_params(MigrationParameters *new, Error **errp)
  * Check whether the parameters are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
  */
-bool migrate_params_check(MigrationParameters *params, Error **errp)
+bool migrate_params_check(const MigrationParameters *params, Error **errp)
 {
     ERRP_GUARD();
 
@@ -1363,7 +1363,7 @@ static void migrate_params_merge(MigrationParameters *dst,
  * Caller must ensure all has_* fields of @params are true to ensure
  * all fields get copied and the pointer members don't dangle.
  */
-static void migrate_params_apply(MigrationParameters *params)
+static void migrate_params_apply(const MigrationParameters *params)
 {
     MigrationState *s = migrate_get_current();
     MigrationParameters *cur = &s->parameters;
@@ -1376,6 +1376,19 @@ static void migrate_params_apply(MigrationParameters *params)
     QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
 }
 
+void migrate_params_store_defaults(MigrationState *s)
+{
+    assert(!s->initial_params);
+
+    /*
+     * The defaults set for each qdev property in migration_properties
+     * will be stored as the default values for each migration
+     * parameter. For debugging, using -global can override the
+     * defaults.
+     */
+    s->initial_params = QAPI_CLONE(MigrationParameters, &s->parameters);
+}
+
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index ceb12b0ff0..47f84bf180 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -46,7 +46,7 @@ bool migrate_postcopy(void);
 bool migrate_rdma(void);
 bool migrate_tls(void);
 
-bool migrate_rdma_caps_check(MigrationParameters *config, Error **errp);
+bool migrate_rdma_caps_check(const MigrationParameters *config, Error **errp);
 bool migrate_can_snapshot(Error **errp);
 
 /* parameters */
@@ -76,7 +76,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 
-bool migrate_params_check(MigrationParameters *params, Error **errp);
+bool migrate_params_check(const MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
 void migrate_tls_opts_free(MigrationParameters *params);
 bool migrate_capability_get_compat(MigrationParameters *params, int i);
@@ -84,5 +84,6 @@ void migrate_capability_set_compat(MigrationParameters *params, int i,
                                    bool val);
 void migrate_capabilities_set_compat(MigrationParameters *params,
                                      MigrationCapabilityStatusList *caps);
-bool migrate_caps_check(MigrationParameters *new, Error **errp);
+bool migrate_caps_check(const MigrationParameters *const new, Error **errp);
+void migrate_params_store_defaults(MigrationState *s);
 #endif
-- 
2.51.0


