Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D75D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGec-0005en-D9; Mon, 15 Dec 2025 17:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeI-00050q-Qs
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:36 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeD-0002tF-BG
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:33 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC11B5BE04;
 Mon, 15 Dec 2025 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yETfNAilT25BcWaBM8mdKvqxVx/YTqV9EQ8Ncz8MsIA=;
 b=gGnE6wQq7THSMnFCQLb5NncJsh76vczMTOqpNyj7bXjp2nSc6y1GRE5+q5QE0yi2Iu38fl
 2AX4nDK3XIT4UW1NqeShV0okc2iWnDSnwvyh0QWd3uR968sfpqxkn7hAMp6YtvytQZ7bM2
 sQDWCUktey8p/A0UE8nLKfoyxgp41bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yETfNAilT25BcWaBM8mdKvqxVx/YTqV9EQ8Ncz8MsIA=;
 b=IZk2K6vMGl68Y4mjeT2T7Kj3wm67DUjDGZ+LSG2uEjxwewi8v9xBiZUH4IakTr3xa7wPnt
 eV4cN1t/15X3WPDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yETfNAilT25BcWaBM8mdKvqxVx/YTqV9EQ8Ncz8MsIA=;
 b=gGnE6wQq7THSMnFCQLb5NncJsh76vczMTOqpNyj7bXjp2nSc6y1GRE5+q5QE0yi2Iu38fl
 2AX4nDK3XIT4UW1NqeShV0okc2iWnDSnwvyh0QWd3uR968sfpqxkn7hAMp6YtvytQZ7bM2
 sQDWCUktey8p/A0UE8nLKfoyxgp41bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yETfNAilT25BcWaBM8mdKvqxVx/YTqV9EQ8Ncz8MsIA=;
 b=IZk2K6vMGl68Y4mjeT2T7Kj3wm67DUjDGZ+LSG2uEjxwewi8v9xBiZUH4IakTr3xa7wPnt
 eV4cN1t/15X3WPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD7C13EA63;
 Mon, 15 Dec 2025 22:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eElXI0iFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 23/51] migration: Allow migrate commands to provide the
 migration config
Date: Mon, 15 Dec 2025 19:00:09 -0300
Message-ID: <20251215220041.12657-24-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Allow the migrate and migrate_incoming commands to pass the migration
configuration options all at once, dispensing the use of
migrate-set-parameters and migrate-set-capabilities.

The motivation of this is to simplify the interface with the
management layer and avoid the usage of several command invocations to
configure a migration. It also avoids stale parameters from a previous
migration to influence the current migration.

The options that are changed during the migration can still be set
with the existing commands.

The order of precedence is:

'config' argument > migrate-set-parameters > -global migration cmdline
> defaults (migration_properties)

I.e. the config takes precedence over all, values not present in the
config assume the default values. The -global migration command line
option allows the defaults to be overridden for debug.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |  5 +++--
 migration/migration.c          | 28 +++++++++++++++++++++++++---
 migration/options.c            | 19 +++++++++++++++++++
 migration/options.h            |  4 +++-
 qapi/migration.json            | 10 ++++++++++
 system/vl.c                    |  3 ++-
 6 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e5ac57da5..e9c3541352 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -672,7 +672,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
+    qmp_migrate_incoming(NULL, true, caps, NULL, true, false, &err);
     qapi_free_MigrationChannelList(caps);
 
 end:
@@ -1070,7 +1070,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
+    qmp_migrate(NULL, true, caps, NULL, false, false, true, resume,
+                &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 90b381b1fe..d23ab2905a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1930,13 +1930,24 @@ void migrate_del_blocker(Error **reasonp)
 
 void qmp_migrate_incoming(const char *uri, bool has_channels,
                           MigrationChannelList *channels,
-                          bool has_exit_on_error, bool exit_on_error,
-                          Error **errp)
+                          MigrationParameters *config, bool has_exit_on_error,
+                          bool exit_on_error, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (config) {
+        /*
+         * If a config was provided, all options set previously by
+         * migrate-set-parameters get ignored.
+         */
+        if (!migrate_params_override(s, config, errp)) {
+            return;
+        }
+    }
+
     if (!once) {
         error_setg(errp, "The incoming migration has already been started");
         return;
@@ -2208,7 +2219,8 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
 }
 
 void qmp_migrate(const char *uri, bool has_channels,
-                 MigrationChannelList *channels, bool has_detach, bool detach,
+                 MigrationChannelList *channels,
+                 bool has_detach, bool detach, MigrationParameters *config,
                  bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
@@ -2219,6 +2231,16 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
     MigrationChannel *cpr_channel = NULL;
 
+    if (config) {
+        /*
+         * If a config was provided, all options set previously by
+         * migrate-set-parameters get ignored.
+         */
+        if (!migrate_params_override(s, config, errp)) {
+            return;
+        }
+    }
+
     /*
      * Having preliminary checks for uri and channel
      */
diff --git a/migration/options.c b/migration/options.c
index d1d8e5c181..ccc25ad008 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1389,6 +1389,25 @@ void migrate_params_store_defaults(MigrationState *s)
     s->initial_params = QAPI_CLONE(MigrationParameters, &s->parameters);
 }
 
+bool migrate_params_override(MigrationState *s, MigrationParameters *new,
+                             Error **errp)
+{
+    ERRP_GUARD();
+
+    assert(bql_locked());
+
+    /* reset to initial parameters */
+    migrate_params_apply(s->initial_params);
+
+    /* apply the new ones on top */
+    qmp_migrate_set_parameters(new, errp);
+    if (*errp) {
+        return false;
+    }
+
+    return true;
+}
+
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 47f84bf180..29dee6f444 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -84,6 +84,8 @@ void migrate_capability_set_compat(MigrationParameters *params, int i,
                                    bool val);
 void migrate_capabilities_set_compat(MigrationParameters *params,
                                      MigrationCapabilityStatusList *caps);
-bool migrate_caps_check(const MigrationParameters *const new, Error **errp);
+bool migrate_caps_check(const MigrationParameters *new, Error **errp);
 void migrate_params_store_defaults(MigrationState *s);
+bool migrate_params_override(MigrationState *s, MigrationParameters *new,
+                             Error **errp);
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index 76a1e03f2f..bd799d67e4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1546,6 +1546,10 @@
 #     will fail unless migration is in "postcopy-paused" state.
 #     (default: false, since 3.0)
 #
+# @config: migration configuration options.  When present, any
+#     migration configuration previously set with
+#     @migrate-set-parameters is ignored.  (since 11.0)
+#
 # Features:
 #
 # @deprecated: Argument @detach is deprecated.
@@ -1610,6 +1614,7 @@
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
            '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
+           '*config': 'MigrationParameters',
            '*resume': 'bool' } }
 
 ##
@@ -1629,6 +1634,10 @@
 #     :qapi:event:`MIGRATION` event, and error details could be
 #     retrieved with `query-migrate`.  (since 9.1)
 #
+# @config: migration configuration options.  When present, any
+#     migration configuration previously set with
+#     @migrate-set-parameters is ignored.  (since 11.0)
+#
 # Since: 2.3
 #
 # .. admonition:: Notes
@@ -1682,6 +1691,7 @@
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
                       '*channels': [ 'MigrationChannel' ],
+                      '*config': 'MigrationParameters',
                       '*exit-on-error': 'bool' } }
 
 ##
diff --git a/system/vl.c b/system/vl.c
index 5091fe52d9..d09dc9a61c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2829,7 +2829,8 @@ void qmp_x_exit_preconfig(Error **errp)
                 g_new0(MigrationChannelList, 1);
 
             channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
-            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
+            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
+                                 &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.51.0


