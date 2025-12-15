Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D2CD5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdT-0002nC-87; Mon, 15 Dec 2025 17:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdR-0002ml-DR
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:41 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdP-0002hF-KQ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:41 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4EC6F5BDF9;
 Mon, 15 Dec 2025 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyI3anxAzJoPsMnvfbHyVnv/o6qXg6b9/huSOQgQJJg=;
 b=qwovlhaw68T139HMefrkp7lYBUywAyM7DtbySus/+BSdGF2/WVXy5xK94I7auOLiYP3wdS
 Jve4QP6ENvSUXohRn941dSDQ2XKWEbO+cV1RgA+Ih6P/zmX2O5meAFsZCfvgBePBb0OqFv
 eGC/8hEzjljiI7aDR3vRcdLUf9E5pKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyI3anxAzJoPsMnvfbHyVnv/o6qXg6b9/huSOQgQJJg=;
 b=cqnVu59FLUK7YmnF3RhnnEv5h7ogQ3XAVBxaihprxDXBjitN9OCuMXWXFqRlqFyfHrxEfy
 mXgX3dClWeT6fDBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyI3anxAzJoPsMnvfbHyVnv/o6qXg6b9/huSOQgQJJg=;
 b=qwovlhaw68T139HMefrkp7lYBUywAyM7DtbySus/+BSdGF2/WVXy5xK94I7auOLiYP3wdS
 Jve4QP6ENvSUXohRn941dSDQ2XKWEbO+cV1RgA+Ih6P/zmX2O5meAFsZCfvgBePBb0OqFv
 eGC/8hEzjljiI7aDR3vRcdLUf9E5pKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyI3anxAzJoPsMnvfbHyVnv/o6qXg6b9/huSOQgQJJg=;
 b=cqnVu59FLUK7YmnF3RhnnEv5h7ogQ3XAVBxaihprxDXBjitN9OCuMXWXFqRlqFyfHrxEfy
 mXgX3dClWeT6fDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 776603EA65;
 Mon, 15 Dec 2025 22:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8G4QDjCFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v3 12/51] migration: Extract code to mark all parameters as
 present
Date: Mon, 15 Dec 2025 18:59:58 -0300
Message-ID: <20251215220041.12657-13-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

MigrationParameters needs to have all of its has_* fields marked as
true when used as the return of query_migrate_parameters because the
corresponding QMP command has all of its members non-optional by
design, despite them being marked as optional in migration.json.

Extract this code into a function and make it assert if any field is
missing. With this we ensure future changes will not inadvertently
leave any parameters missing.

Note that the block-bitmap-mapping is a special case because the empty
list is considered a valid value, so it has historically not been
present in the command's output if it has never been set.

CC: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 89 ++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index c72e63015c..aafd688f5c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1018,6 +1018,44 @@ static void tls_opt_to_str(StrOrNull *opt)
     opt->u.s = g_strdup("");
 }
 
+/*
+ * query-migrate-parameters expects all members of MigrationParameters
+ * to be present, but we cannot mark them non-optional in QAPI because
+ * the structure is also used for migrate-set-parameters, which needs
+ * the optionality. Force all parameters to be seen as present
+ * now. Note that this depends on some form of default being set for
+ * every member of MigrationParameters, currently done during qdev
+ * init using migration_properties defined in this file. The TLS
+ * options are a special case because they don't have a default and
+ * need to be normalized before use.
+ */
+static void migrate_mark_all_params_present(MigrationParameters *p)
+{
+    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
+    bool *has_fields[] = {
+        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
+        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
+        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
+        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
+        &p->has_multifd_channels, &p->has_multifd_compression,
+        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
+        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
+        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
+        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
+        &p->has_announce_step, &p->has_block_bitmap_mapping,
+        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
+        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
+        &p->has_cpr_exec_command,
+    };
+
+    len = ARRAY_SIZE(has_fields);
+    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
+
+    for (int i = 0; i < len; i++) {
+        *has_fields[i] = true;
+    }
+}
+
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationParameters *params;
@@ -1025,70 +1063,53 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
-    params->has_throttle_trigger_threshold = true;
+
     params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
-    params->has_cpu_throttle_initial = true;
     params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
-    params->has_cpu_throttle_increment = true;
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
     params->tls_creds = QAPI_CLONE(StrOrNull, s->parameters.tls_creds);
     params->tls_hostname = QAPI_CLONE(StrOrNull, s->parameters.tls_hostname);
     params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
-    params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
-    params->has_avail_switchover_bandwidth = true;
     params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
-    params->has_downtime_limit = true;
     params->downtime_limit = s->parameters.downtime_limit;
-    params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
-    params->has_multifd_compression = true;
     params->multifd_compression = s->parameters.multifd_compression;
-    params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
-    params->has_multifd_qatzip_level = true;
     params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
-    params->has_multifd_zstd_level = true;
     params->multifd_zstd_level = s->parameters.multifd_zstd_level;
-    params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
-    params->has_max_postcopy_bandwidth = true;
     params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
-    params->has_max_cpu_throttle = true;
     params->max_cpu_throttle = s->parameters.max_cpu_throttle;
-    params->has_announce_initial = true;
     params->announce_initial = s->parameters.announce_initial;
-    params->has_announce_max = true;
     params->announce_max = s->parameters.announce_max;
-    params->has_announce_rounds = true;
     params->announce_rounds = s->parameters.announce_rounds;
-    params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
-
-    if (s->has_block_bitmap_mapping) {
-        params->has_block_bitmap_mapping = true;
-        params->block_bitmap_mapping =
-            QAPI_CLONE(BitmapMigrationNodeAliasList,
-                       s->parameters.block_bitmap_mapping);
-    }
-
-    params->has_x_vcpu_dirty_limit_period = true;
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-    params->has_vcpu_dirty_limit = true;
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
-    params->has_mode = true;
     params->mode = s->parameters.mode;
-    params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
-    params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
-    params->has_cpr_exec_command = true;
     params->cpr_exec_command = QAPI_CLONE(strList,
                                           s->parameters.cpr_exec_command);
+    params->block_bitmap_mapping =
+        QAPI_CLONE(BitmapMigrationNodeAliasList,
+                   s->parameters.block_bitmap_mapping);
+
+    migrate_mark_all_params_present(params);
+
+    /*
+     * The block-bitmap-mapping breaks the expected API of
+     * query-migrate-parameters of having all members present. To keep
+     * compatibility, only emit this field if it's actually been
+     * set. The empty list is a valid value.
+     */
+    if (!s->has_block_bitmap_mapping) {
+        params->has_block_bitmap_mapping = false;
+        qapi_free_BitmapMigrationNodeAliasList(params->block_bitmap_mapping);
+    }
 
     return params;
 }
-- 
2.51.0


