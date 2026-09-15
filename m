Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349BBC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GdH-0003Mi-HT; Mon, 14 Sep 2026 20:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdE-0003MF-Kf
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdC-0004nB-C8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C1401FF5B;
 Tue, 15 Sep 2026 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoTZXTyVtqGz0iA556+8eviVAzDVcXsSW1coLubitAE=;
 b=IlPRW35LtFJOu1PkikyahOUN/vW2smn4gUnnLJy4LSRSR50twzPtroJP3iCMIJ4slbUF/1
 NMyLUJ8BY7ygyW3gtw+6keWv94eQEWrFrVIG4FcKQ/HxPLdy4d+hbSbwDRb3JLAjGIE2l0
 SwUlf7YK+1tKfkht5rm+6Qrynx5Rx28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoTZXTyVtqGz0iA556+8eviVAzDVcXsSW1coLubitAE=;
 b=NyXbT0rbgoA+4+5erdb8EF7gUmTgareENfZdnA/yXzaNIC0OKIfV4ZsH7BV58E+Dm3APbx
 /xgiavjRfVm1stAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoTZXTyVtqGz0iA556+8eviVAzDVcXsSW1coLubitAE=;
 b=2XktEpYfu4+OIPCnBEKARfSKZ0N5CDsHFNWsYJzRefXI17FgWFm5RN0ZS0oDee3xNI8DQj
 VXnJMujtbkQ73MFGqGV6rZJIt/u5UWcADIJZaKiNYMqEXSQC/WqkwKxV0C+qzIWVzvnrJF
 m5NeLOf/XW6jLJa4lbpqYdIIHJt4AB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoTZXTyVtqGz0iA556+8eviVAzDVcXsSW1coLubitAE=;
 b=Jrmo2UsHP/Gcl29IO6k177oTKI2elA6Ni7UlE+fed4v6SVRwpOx4GYNJUtr8vU+kzrLD+P
 gDNYd4gj73Zai6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9161B1388C;
 Tue, 15 Sep 2026 00:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T6
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 05/20] migration: Merge parameter structs instead of
 assigning one by one
Date: Mon, 14 Sep 2026 21:01:53 -0300
Message-ID: <20260915000209.3692668-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Convert the code in migrate_params_test_apply() from an open-coded
copy of every migration parameter to a merge operation using QAPI
visitors and QDict.

The purpose of that routine is to update a temporary structure
(pre-populated with the current migration parameters), with the values
received from the user via QAPI. As a result, the temporary structure
will then contain the "to be applied" parameters and it's validated
before being used to overwrite the parameters currently in use.

The update is currently done as follows:

where 'params' is the user input from QAPI,
for each parameter:

  a) check if the option is present
     params->has_<name> == true
     params-><name> != NULL // for strings

  b) if the parameter is a pointer, free the to-be-assigned member and
     allocate memory for the copy from params

  c) assign the user provided value to the temporary structure.

Step (a) is the same in principle as what the QAPI visitors do at
visit_type_MigrationParameters_members().

Steps (b) and (c) are roughly the same as what the QDict
implementation does when qdict_del() and qdict_put_obj() are combined.

Therefore, replace the open-coded function with
migrate_params_merge(), which achieves the same goal, but uses
visitors and QDict. This hides the details of QAPI (has_*) from the
migration code and avoids the need to update
migrate_params_test_apply() every time a new migration parameter is
added.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 204 ++++++++++++++------------------------------
 1 file changed, 65 insertions(+), 139 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index ac7e94ed62..0f7478aa6a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -21,6 +21,9 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qobject/qdict.h"
 #include "qobject/qnull.h"
 #include "system/runstate.h"
 #include "migration/colo.h"
@@ -1082,6 +1085,28 @@ static void tls_opt_to_str(StrOrNull *opt)
     opt->u.s = g_strdup("");
 }
 
+static QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
+{
+    QObject *obj = NULL;
+    Visitor *v = qobject_output_visitor_new(&obj);
+
+    if (visit_type_MigrationParameters(v, NULL, &p, errp)) {
+        visit_complete(v, &obj);
+    }
+    visit_free(v);
+    return qobject_to(QDict, obj);
+}
+
+static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
+{
+    Visitor *v = qobject_input_visitor_new(QOBJECT(d));
+    MigrationParameters *tmp = NULL;
+
+    visit_type_MigrationParameters(v, NULL, &tmp, errp);
+    visit_free(v);
+    return tmp;
+}
+
 /*
  * query-migrate-parameters expects all members of MigrationParameters
  * to be present, but we cannot mark them non-optional in QAPI because
@@ -1174,6 +1199,38 @@ static void migrate_post_update_params(MigrationParameters *new, Error **errp)
     }
 }
 
+static bool migrate_params_merge(MigrationParameters *base,
+                                 MigrationParameters *updates,
+                                 MigrationParameters **new,
+                                 Error **errp)
+{
+    g_autoptr(QDict) d_base = NULL;
+    g_autoptr(QDict) d_upd = NULL;
+    const QDictEntry *e;
+
+    d_base = migrate_params_to_dict(base, errp);
+    if (!d_base) {
+        return false;
+    }
+
+    d_upd = migrate_params_to_dict(updates, errp);
+    if (!d_upd) {
+        return false;
+    }
+
+    for (e = qdict_first(d_upd); e; e = qdict_next(d_upd, e)) {
+        const char *key = qdict_entry_key(e);
+        QObject *value = qdict_entry_value(e);
+
+        qobject_ref(value);
+        qdict_put_obj(d_base, key, value);
+    }
+
+    *new = migrate_params_from_dict(d_base, errp);
+
+    return !!*new;
+}
+
 /*
  * Check whether the parameters are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
@@ -1336,137 +1393,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrationParameters *params,
-                                      MigrationParameters *dest)
-{
-    MigrationState *s = migrate_get_current();
-
-    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
-
-    if (params->has_throttle_trigger_threshold) {
-        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
-    }
-
-    if (params->has_cpu_throttle_initial) {
-        dest->cpu_throttle_initial = params->cpu_throttle_initial;
-    }
-
-    if (params->has_cpu_throttle_increment) {
-        dest->cpu_throttle_increment = params->cpu_throttle_increment;
-    }
-
-    if (params->has_cpu_throttle_tailslow) {
-        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
-    }
-
-    if (params->tls_creds) {
-        qapi_free_StrOrNull(dest->tls_creds);
-        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    }
-
-    if (params->tls_hostname) {
-        qapi_free_StrOrNull(dest->tls_hostname);
-        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
-    }
-
-    if (params->tls_authz) {
-        qapi_free_StrOrNull(dest->tls_authz);
-        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    }
-
-    if (params->has_max_bandwidth) {
-        dest->max_bandwidth = params->max_bandwidth;
-    }
-
-    if (params->has_avail_switchover_bandwidth) {
-        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
-    }
-
-    if (params->has_downtime_limit) {
-        dest->downtime_limit = params->downtime_limit;
-    }
-
-    if (params->has_x_checkpoint_delay) {
-        dest->x_checkpoint_delay = params->x_checkpoint_delay;
-    }
-
-    if (params->has_multifd_channels) {
-        dest->multifd_channels = params->multifd_channels;
-    }
-    if (params->has_multifd_compression) {
-        dest->multifd_compression = params->multifd_compression;
-    }
-    if (params->has_multifd_qatzip_level) {
-        dest->multifd_qatzip_level = params->multifd_qatzip_level;
-    }
-    if (params->has_multifd_zlib_level) {
-        dest->multifd_zlib_level = params->multifd_zlib_level;
-    }
-    if (params->has_multifd_zstd_level) {
-        dest->multifd_zstd_level = params->multifd_zstd_level;
-    }
-    if (params->has_xbzrle_cache_size) {
-        dest->xbzrle_cache_size = params->xbzrle_cache_size;
-    }
-    if (params->has_max_postcopy_bandwidth) {
-        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
-    }
-    if (params->has_max_cpu_throttle) {
-        dest->max_cpu_throttle = params->max_cpu_throttle;
-    }
-    if (params->has_announce_initial) {
-        dest->announce_initial = params->announce_initial;
-    }
-    if (params->has_announce_max) {
-        dest->announce_max = params->announce_max;
-    }
-    if (params->has_announce_rounds) {
-        dest->announce_rounds = params->announce_rounds;
-    }
-    if (params->has_announce_step) {
-        dest->announce_step = params->announce_step;
-    }
-
-    if (params->has_block_bitmap_mapping) {
-        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
-        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
-                                                params->block_bitmap_mapping);
-    }
-
-    if (params->has_x_vcpu_dirty_limit_period) {
-        dest->x_vcpu_dirty_limit_period =
-            params->x_vcpu_dirty_limit_period;
-    }
-    if (params->has_vcpu_dirty_limit) {
-        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
-    }
-
-    if (params->has_mode) {
-        dest->mode = params->mode;
-    }
-
-    if (params->has_zero_page_detection) {
-        dest->zero_page_detection = params->zero_page_detection;
-    }
-
-    if (params->has_direct_io) {
-        dest->direct_io = params->direct_io;
-    }
-
-    if (params->has_x_rdma_chunk_size) {
-        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
-    }
-
-    if (params->has_cpr_exec_command) {
-        qapi_free_strList(dest->cpr_exec_command);
-        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
-    }
-
-    if (params->has_local) {
-        dest->local = params->local;
-    }
-}
-
 /*
  * Caller must ensure the has_* fields of @params are true so they all
  * get copied and the pointer members don't dangle.
@@ -1484,7 +1410,8 @@ static void migrate_params_apply(MigrationParameters *params)
 
 void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
 {
-    MigrationParameters new;
+    MigrationParameters *cur = &migrate_get_current()->parameters;
+    g_autoptr(MigrationParameters) new = NULL;
 
     /*
      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
@@ -1498,14 +1425,13 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
     tls_opt_to_str(input->tls_hostname);
     tls_opt_to_str(input->tls_authz);
 
-    migrate_params_test_apply(input, &new);
+    /* merge input on top of current */
+    if (!migrate_params_merge(cur, input, &new, errp)) {
+        return;
+    }
 
-    if (migrate_params_check(&new, errp)) {
-        migrate_params_apply(&new);
+    if (migrate_params_check(new, errp)) {
+        migrate_params_apply(new);
         migrate_post_update_params(input, errp);
     }
-
-    migrate_tls_opts_free(&new);
-    qapi_free_BitmapMigrationNodeAliasList(new.block_bitmap_mapping);
-    qapi_free_strList(new.cpr_exec_command);
 }
-- 
2.53.0


