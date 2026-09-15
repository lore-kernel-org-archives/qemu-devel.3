Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E8CC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Gdb-00049Y-BJ; Mon, 14 Sep 2026 20:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdZ-00043f-BU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:03:01 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdX-0004qQ-5m
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:03:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E34B21E23;
 Tue, 15 Sep 2026 00:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPvwycNyQs2pn88XuN23N7lSvba6kB/+ocG2WCqZdu4=;
 b=yfHxRgHRYHMhXGmBQpPAZ0W7WvfsTdAukWXXeUh8ZxV4/m/Q3oDhzDnDQVeCeHYIe6W5v2
 +j3njbP7ZiM/6qz7lnuc6SJcCRjEa2RwZ0b8LNLgyqb6tNjB3OXUaZOZF5KGjJpf1j/05o
 Xjs3uQV28aq38C2yUJ+P4fbkGz1ylcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPvwycNyQs2pn88XuN23N7lSvba6kB/+ocG2WCqZdu4=;
 b=c7PTCtFa9+/nY1fOHBOIbdnxvwBnvfK4kU3xRSY8ii3hAtjDpuMaEbJLdl1VAFNcFSNdUT
 fRABsfw1vHUd1+CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GBu2Vrqd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dupHrCj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPvwycNyQs2pn88XuN23N7lSvba6kB/+ocG2WCqZdu4=;
 b=GBu2VrqdX6W//vqCeJXCwvCVwPFmA4VmLB/RMeSvEbvef6YF87R6b4sA9j6IA77HaU1hYp
 NQshAYVX0HGjxEyYSXlo6taJ06ixKO9BCWKv6P+85krY+If6LKceCUZmrLYT8QH8GYkPyC
 s7z80OOj/fieUIJ6SaZsMYPVmCWNjM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPvwycNyQs2pn88XuN23N7lSvba6kB/+ocG2WCqZdu4=;
 b=dupHrCj0ePDeAF7rXlqbCmLOZo7S29BPjiR4Ks/TLPIxUI4RvasFews+20B+b2BhvjDNV0
 wvzWmkToYGnXwGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36F30136D9;
 Tue, 15 Sep 2026 00:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T20
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 19/20] migration: Set the parameters present flag with a
 clone visitor
Date: Mon, 14 Sep 2026 21:02:07 -0300
Message-ID: <20260915000209.3692668-20-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E34B21E23
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

The MigrationParameters object is defined by the QAPI. It is also used
by the migration code as its internal store of parameters.

Due to a historic coupling of the migration code with qdev properties,
when a migration parameter has its initial value set by qdev, the QAPI
present flag for that parameter is kept unset. This is fine as long as
the MigrationParameters object is not used to interact with the QAPI
(e.g. as input to query-migrate) or the visitors infrastructure
(e.g. using QAPI_CLONE to duplicate an object).

Recent changes have removed code duplication and complexity in the
aforementioned interactions by adding a helper that attempts to ensure
consistency by setting all of the present flags for a (manually kept)
list of parameters. See commit f55f4ef632 ("migration: Extract code to
mark all parameters as present").

There are still some drawbacks to this scheme such as the need to keep
the list of parameters updated.

Replace the logic with a walk from a custom visitor that force sets
each present flag and dispenses with all manual updates as it uses the
QAPI generated code and will not become out of sync with
MigrationParameters.

This also allows the removal in the next patch of the
MigrationParameter enum which is the last place where migration
parameter names need to be replicated.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qapi/clone-visitor.h |  1 +
 migration/migration.c        |  2 +-
 migration/options.c          | 77 ++++++++++++------------------------
 migration/options.h          |  2 +-
 qapi/qapi-clone-visitor.c    | 13 ++++++
 5 files changed, 41 insertions(+), 54 deletions(-)

diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
index ebc182b034..04cd1a88d1 100644
--- a/include/qapi/clone-visitor.h
+++ b/include/qapi/clone-visitor.h
@@ -22,6 +22,7 @@
 typedef struct QapiCloneVisitor QapiCloneVisitor;
 
 Visitor *qapi_clone_visitor_new(void);
+Visitor *qapi_clone_visitor_new_all(void);
 Visitor *qapi_clone_members_visitor_new(void);
 
 /*
diff --git a/migration/migration.c b/migration/migration.c
index fcfb82ad57..f92d13234f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4076,7 +4076,7 @@ static void migration_instance_init(Object *obj)
     qemu_event_init(&ms->pause_event, false);
     qemu_mutex_init(&ms->error_mutex);
 
-    migrate_params_init(&ms->parameters);
+    migrate_params_init(ms);
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
diff --git a/migration/options.c b/migration/options.c
index 02b9c64ae6..8d869209ee 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -233,6 +233,31 @@ const Property migration_properties[] = {
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
+/*
+ * After qdev sets the defaults for the migration parameters using the
+ * migration_properties above, s->parameters is left inconsistent from
+ * QAPI point of view because the parameters' present flag is not
+ * set. Use the custom-built qapi_clone_visitor_all() to copy
+ * s->parameters back to itself while setting all present flags. The
+ * resulting object is fit to be used with QAPI and the visitor
+ * infrastructure.
+ *
+ * WARNING: missing entries in the migration_properties array in
+ * respect to MigrationParameters will still have their corresponding
+ * struct member marked as present.
+ */
+void migrate_params_init(MigrationState *s)
+{
+    Visitor *v = qapi_clone_visitor_new_all();
+    g_autoptr(MigrationParameters) p = &s->parameters;
+
+    visit_type_MigrationParameters(v, NULL, &p, &error_abort);
+    visit_free(v);
+    migrate_params_free(&s->parameters, &error_abort);
+    QAPI_CLONE_MEMBERS(MigrationParameters, &s->parameters, p);
+}
+
+
 static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
@@ -1121,53 +1146,6 @@ static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
     return tmp;
 }
 
-/*
- * query-migrate-parameters expects all members of MigrationParameters
- * to be present, but we cannot mark them non-optional in QAPI because
- * the structure is also used for migrate-set-parameters, which needs
- * the optionality. Force all parameters to be seen as present
- * now. Note that this depends on some form of default being set for
- * every member of MigrationParameters, currently done during qdev
- * init using migration_properties defined in this file. The TLS
- * options are a special case because they don't have a default and
- * need to be normalized before use.
- */
-static void migrate_mark_all_params_present(MigrationParameters *p)
-{
-    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
-    bool *has_fields[] = {
-        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
-        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
-        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
-        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
-        &p->has_multifd_channels, &p->has_multifd_compression,
-        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
-        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
-        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
-        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
-        &p->has_announce_step, &p->has_block_bitmap_mapping,
-        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
-        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command, &p->has_local,
-        &p->has_xbzrle, &p->has_rdma_pin_all,
-        &p->has_auto_converge, &p->has_events,
-        &p->has_postcopy_ram, &p->has_x_colo, &p->has_release_ram,
-        &p->has_return_path, &p->has_pause_before_switchover, &p->has_multifd,
-        &p->has_dirty_bitmaps, &p->has_postcopy_blocktime,
-        &p->has_late_block_activate, &p->has_x_ignore_shared,
-        &p->has_validate_uuid, &p->has_background_snapshot,
-        &p->has_zero_copy_send, &p->has_postcopy_preempt,
-        &p->has_switchover_ack, &p->has_dirty_limit, &p->has_mapped_ram,
-    };
-
-    len = ARRAY_SIZE(has_fields);
-    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
-
-    for (int i = 0; i < len; i++) {
-        *has_fields[i] = true;
-    }
-}
-
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationState *s = migrate_get_current();
@@ -1188,11 +1166,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     return params;
 }
 
-void migrate_params_init(MigrationParameters *params)
-{
-    migrate_mark_all_params_present(params);
-}
-
 static void migrate_post_update_params(MigrationParameters *new, Error **errp)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 28cf762ace..7abd527610 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -78,7 +78,7 @@ ZeroPageDetection migrate_zero_page_detection(void);
 uint64_t migrate_rdma_chunk_size(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
-void migrate_params_init(MigrationParameters *params);
+void migrate_params_init(MigrationState *s);
 bool migrate_params_free(MigrationParameters *params, Error **errp);
 QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp);
 bool migrate_capability_get_compat(MigrationParameters *params, int i);
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index 30997638de..8e2135b78e 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -174,6 +174,19 @@ Visitor *qapi_clone_visitor_new(void)
     return &v->visitor;
 }
 
+static void qapi_clone_optional_all(Visitor *v, const char *name, bool *present)
+{
+    *present = true;
+}
+
+Visitor *qapi_clone_visitor_new_all(void)
+{
+   Visitor *v = qapi_clone_visitor_new();
+
+   v->optional = qapi_clone_optional_all;
+   return v;
+}
+
 Visitor *qapi_clone_members_visitor_new(void)
 {
     Visitor *v = qapi_clone_visitor_new();
-- 
2.53.0


