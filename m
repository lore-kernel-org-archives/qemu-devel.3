Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F704C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFx-0000vy-23; Wed, 02 Sep 2026 18:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFv-0000va-PP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFt-0002O5-Af
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5C5A21CCC;
 Wed,  2 Sep 2026 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcoUpKgYIlBLsctoD0QWUa07MN/yO31xDC/RQk74F60=;
 b=rKl/i4TM5BmKhG9EXOoIVP6U4x8k4L7TcQzkZY99g0GpUeKx+OGqSdppl2isyga5fUbvgq
 FdLLiOb+BU+ot3m8DEershdovS04WFEcITmcOGyl8zaJXZDcbcu6JQOj1nlK/rRkRz2b0G
 IbSxRV4T/2P2/Ub5lC9yJXOSC09Ym+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcoUpKgYIlBLsctoD0QWUa07MN/yO31xDC/RQk74F60=;
 b=rhmTqw5m5hJnpODzYXdlysbaNZ4JlwiBHXzxek7SzZwWjNpoCbiQyOZG+WyQB6Eqj7ktBR
 f1mrbHJw1CNQG3Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcoUpKgYIlBLsctoD0QWUa07MN/yO31xDC/RQk74F60=;
 b=HlFla339vP4h9/u9SM8+sWKOq/FiOthLmXgfbCRU6m6wNQO2RwocYnvnY3kl6v8YPFz67x
 mrBkTD6QvzRA2aa4y4C9SGO4m/ntXr3rJPujtVldJTRavX4hVJKfnZ8qvOxVqBIKlP75tw
 in1JJS8+JocGODgFOGwuRU8v2zCuvXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcoUpKgYIlBLsctoD0QWUa07MN/yO31xDC/RQk74F60=;
 b=z0GqMwhyRHhRBSyUEOeH1pf2Dpq9L/q+w5UBwV8nafNmJ3Bdg1pnCaJ2P+82YUUckhP2hv
 A/S6BqGFzWwNi6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9024913869;
 Wed,  2 Sep 2026 22:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EBguGDKgmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 11/18] migration: Use keyval input visitor in HMP set command
Date: Wed,  2 Sep 2026 19:15:39 -0300
Message-ID: <20260902221547.1812481-12-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
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

Change the hmp_migrate_set_parameter command to use a keyval input
visitor.

Currently a string visitor is used and due to limitations of that
particular visitor's implementation it's necessary to consult the QAPI
type enum (MigrationParameter_lookup) and call each visit_type_*
function individually. Which makes using a visitor pointless.

Since there are other visitors implemented properly and generated code
to iterate the QAPI object, prefer using one of those. The keyval
input visitor is adequate because HMP provides basically one key and
one value for each migrate_set_parameter command.

To switch from string_input_visitor to keyval_input_visitor simply put
the parameter name and value into a dict and invoke
visit_type_MigrationParameters().

Note that it's not necessary to go through any of the keyval_* code
because due to the nature of HMP, there's no parsing to do (no '=', no
',', etc).

With this the migrate_set_parameters HMP commands will be
automatically updated anytime a new migration parameter is added.

The bad part:

Some parameters accept a non-standard data format, I moved them to a
"legacy" suffixed function in this patch as there's only 3 of them:

- "max-bandwidth" and "avail-switchover-bandwidth" take MiB instead of B for
   a size parameter;

- "cpr-exec-command" takes the strList type which needs to be built
  manually.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c     | 203 +++++++++--------------------
 tests/qtest/migration/misc-tests.c |   2 +-
 2 files changed, 59 insertions(+), 146 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index ad68fa23aa4..220ac28b5e3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -24,7 +24,9 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/cutils.h"
@@ -589,59 +591,16 @@ end:
     hmp_handle_error(mon, err);
 }
 
-void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
+static void hmp_migrate_set_parameter_legacy(Monitor *mon, const QDict *qdict)
 {
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
-    Visitor *v = string_input_visitor_new(valuestr);
     MigrationParameters *p = g_new0(MigrationParameters, 1);
     uint64_t valuebw = 0;
-    uint64_t cache_size;
     Error *err = NULL;
-    int val, ret;
+    int ret;
 
-    val = qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err);
-    if (val < 0) {
-        goto cleanup;
-    }
-
-    switch (val) {
-    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
-        p->has_throttle_trigger_threshold = true;
-        visit_type_uint8(v, param, &p->throttle_trigger_threshold, &err);
-        break;
-    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
-        p->has_cpu_throttle_initial = true;
-        visit_type_uint8(v, param, &p->cpu_throttle_initial, &err);
-        break;
-    case MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT:
-        p->has_cpu_throttle_increment = true;
-        visit_type_uint8(v, param, &p->cpu_throttle_increment, &err);
-        break;
-    case MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW:
-        p->has_cpu_throttle_tailslow = true;
-        visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
-        break;
-    case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
-        p->has_max_cpu_throttle = true;
-        visit_type_uint8(v, param, &p->max_cpu_throttle, &err);
-        break;
-    case MIGRATION_PARAMETER_TLS_CREDS:
-        p->tls_creds = g_new0(StrOrNull, 1);
-        p->tls_creds->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_creds->u.s, &err);
-        break;
-    case MIGRATION_PARAMETER_TLS_HOSTNAME:
-        p->tls_hostname = g_new0(StrOrNull, 1);
-        p->tls_hostname->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_hostname->u.s, &err);
-        break;
-    case MIGRATION_PARAMETER_TLS_AUTHZ:
-        p->tls_authz = g_new0(StrOrNull, 1);
-        p->tls_authz->type = QTYPE_QSTRING;
-        visit_type_str(v, param, &p->tls_authz->u.s, &err);
-        break;
-    case MIGRATION_PARAMETER_MAX_BANDWIDTH:
+    if (g_str_equal(param, "max-bandwidth")) {
         p->has_max_bandwidth = true;
         /*
          * Can't use visit_type_size() here, because it
@@ -651,109 +610,21 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         if (ret < 0 || valuebw > INT64_MAX
             || (size_t)valuebw != valuebw) {
             error_setg(&err, "Invalid size %s", valuestr);
-            break;
+            return;
         }
         p->max_bandwidth = valuebw;
-        break;
-    case MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH:
+
+    } else if (g_str_equal(param, "avail-switchover-bandwidth")) {
         p->has_avail_switchover_bandwidth = true;
         ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
         if (ret < 0 || valuebw > INT64_MAX
             || (size_t)valuebw != valuebw) {
             error_setg(&err, "Invalid size %s", valuestr);
-            break;
+            return;
         }
         p->avail_switchover_bandwidth = valuebw;
-        break;
-    case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
-        p->has_downtime_limit = true;
-        visit_type_size(v, param, &p->downtime_limit, &err);
-        break;
-    case MIGRATION_PARAMETER_X_CHECKPOINT_DELAY:
-        p->has_x_checkpoint_delay = true;
-        visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
-        break;
-    case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
-        p->has_multifd_channels = true;
-        visit_type_uint8(v, param, &p->multifd_channels, &err);
-        break;
-    case MIGRATION_PARAMETER_MULTIFD_COMPRESSION:
-        p->has_multifd_compression = true;
-        visit_type_MultiFDCompression(v, param, &p->multifd_compression,
-                                      &err);
-        break;
-    case MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL:
-        p->has_multifd_zlib_level = true;
-        visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
-        break;
-    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
-        p->has_multifd_qatzip_level = true;
-        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
-        break;
-    case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
-        p->has_multifd_zstd_level = true;
-        visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
-        break;
-    case MIGRATION_PARAMETER_ZERO_PAGE_DETECTION:
-        p->has_zero_page_detection = true;
-        visit_type_ZeroPageDetection(v, param, &p->zero_page_detection, &err);
-        break;
-    case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
-        p->has_xbzrle_cache_size = true;
-        if (!visit_type_size(v, param, &cache_size, &err)) {
-            break;
-        }
-        if (cache_size > INT64_MAX || (size_t)cache_size != cache_size) {
-            error_setg(&err, "Invalid size %s", valuestr);
-            break;
-        }
-        p->xbzrle_cache_size = cache_size;
-        break;
-    case MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH:
-        p->has_max_postcopy_bandwidth = true;
-        visit_type_size(v, param, &p->max_postcopy_bandwidth, &err);
-        break;
-    case MIGRATION_PARAMETER_ANNOUNCE_INITIAL:
-        p->has_announce_initial = true;
-        visit_type_size(v, param, &p->announce_initial, &err);
-        break;
-    case MIGRATION_PARAMETER_ANNOUNCE_MAX:
-        p->has_announce_max = true;
-        visit_type_size(v, param, &p->announce_max, &err);
-        break;
-    case MIGRATION_PARAMETER_ANNOUNCE_ROUNDS:
-        p->has_announce_rounds = true;
-        visit_type_size(v, param, &p->announce_rounds, &err);
-        break;
-    case MIGRATION_PARAMETER_ANNOUNCE_STEP:
-        p->has_announce_step = true;
-        visit_type_size(v, param, &p->announce_step, &err);
-        break;
-    case MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING:
-        error_setg(&err, "The block-bitmap-mapping parameter can only be set "
-                   "through QMP");
-        break;
-    case MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD:
-        p->has_x_vcpu_dirty_limit_period = true;
-        visit_type_size(v, param, &p->x_vcpu_dirty_limit_period, &err);
-        break;
-    case MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT:
-        p->has_vcpu_dirty_limit = true;
-        visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
-        break;
-    case MIGRATION_PARAMETER_MODE:
-        p->has_mode = true;
-        visit_type_MigMode(v, param, &p->mode, &err);
-        break;
-    case MIGRATION_PARAMETER_DIRECT_IO:
-        p->has_direct_io = true;
-        visit_type_bool(v, param, &p->direct_io, &err);
-        break;
-    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
-        p->has_x_rdma_chunk_size = true;
-        visit_type_size(v, param, &p->x_rdma_chunk_size, &err);
-        break;
-    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
+
+    } else if (g_str_equal(param, "cpr-exec-command")) {
         /*
          * NOTE: g_autofree will only auto g_free() the strv array when
          * needed, it will not free the strings within the array. It's
@@ -766,15 +637,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
 
         if (!g_shell_parse_argv(valuestr, NULL, &strv, &gerr)) {
             error_setg(&err, "%s", gerr->message);
-            break;
+            return;
         }
         for (int i = 0; strv[i]; i++) {
             QAPI_LIST_APPEND(tail, strv[i]);
         }
         p->has_cpr_exec_command = true;
-        break;
-    }
-    default:
+
+    } else {
         g_assert_not_reached();
     }
 
@@ -784,12 +654,55 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
 
     qmp_migrate_set_parameters(p, &err);
 
- cleanup:
+cleanup:
     qapi_free_MigrationParameters(p);
+    hmp_handle_error(mon, err);
+}
+
+static void hmp_migrate_set_parameter_qapi(Monitor *mon, const QDict *qdict)
+{
+    const char *param = qdict_get_str(qdict, "parameter");
+    const char *valuestr = qdict_get_str(qdict, "value");
+    g_autoptr(QDict) input = qdict_new();
+    g_autoptr(MigrationParameters) p = NULL;
+    Visitor *v;
+    Error *err = NULL;
+
+    /* the same as keyval_parse(), but here there's no need to parse */
+    qdict_put_obj(input, param, QOBJECT(qstring_from_str(valuestr)));
+
+    v = qobject_input_visitor_new_keyval(QOBJECT(input));
+    if (visit_type_MigrationParameters(v, NULL, &p, &err)) {
+        qmp_migrate_set_parameters(p, &err);
+    }
+
     visit_free(v);
     hmp_handle_error(mon, err);
 }
 
+void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
+{
+    const char *param = qdict_get_str(qdict, "parameter");
+
+    if (g_str_equal(param, "block-bitmap-mapping")) {
+        Error *err = NULL;
+
+        error_setg(&err, "The %s parameter can only be set through QMP", param);
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    /* these have non-standard setters */
+    if (g_str_equal(param, "max-bandwidth") ||
+        g_str_equal(param, "avail-switchover-bandwidth") ||
+        g_str_equal(param, "cpr-exec-command")) {
+
+        return hmp_migrate_set_parameter_legacy(mon, qdict);
+    }
+
+    hmp_migrate_set_parameter_qapi(mon, qdict);
+}
+
 void hmp_migrate_start_postcopy(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 3554900b758..ba8183978b3 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -48,7 +48,7 @@ typedef struct HMPTestData {
 HMPTestData test_cases[] = {
     TEST("", "", "migrate_set_parameter: string expected"),
     TEST("foo", "", "migrate_set_parameter: string expected"),
-    TEST("foo", "on", "Error: invalid parameter value: foo"),
+    TEST("foo", "on", "Error: Parameter 'foo' is unexpected"),
 
     /* bool */
     TEST("cpu-throttle-tailslow", "on", "on"),
-- 
2.53.0


