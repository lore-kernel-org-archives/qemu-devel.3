Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EADD5B873
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGe7-0004Ll-J1; Mon, 15 Dec 2025 17:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGe1-0004H6-Sb
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:17 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdz-0002qT-26
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6AA985BDDC;
 Mon, 15 Dec 2025 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3SKjC4+BiHTxLnD651fTkVFSrHjqHq6jFO/JjVfTHw=;
 b=K4gFWGcggH6meby2tS//wSVgMCY7TD285Vii57rQ5nEaAFzDx/pOS/6mEDKytfizPQUiB1
 xXIhBpIqGZZiAQGPUAp99czselopA+CSddAl4w6EpkI3uwcpdrjqdYxfKrZtiLXV0qSfot
 7if408TCGjqOsZ8niAErma7SDf/1isY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3SKjC4+BiHTxLnD651fTkVFSrHjqHq6jFO/JjVfTHw=;
 b=6nrLTn0PmZqZbL+cxXOZTNMgCsinlG/jXclq16ZUa3J+BQn4snAYiU21jHSRalCGo6srge
 VnkHb2TuqoTXGABw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3SKjC4+BiHTxLnD651fTkVFSrHjqHq6jFO/JjVfTHw=;
 b=K4gFWGcggH6meby2tS//wSVgMCY7TD285Vii57rQ5nEaAFzDx/pOS/6mEDKytfizPQUiB1
 xXIhBpIqGZZiAQGPUAp99czselopA+CSddAl4w6EpkI3uwcpdrjqdYxfKrZtiLXV0qSfot
 7if408TCGjqOsZ8niAErma7SDf/1isY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3SKjC4+BiHTxLnD651fTkVFSrHjqHq6jFO/JjVfTHw=;
 b=6nrLTn0PmZqZbL+cxXOZTNMgCsinlG/jXclq16ZUa3J+BQn4snAYiU21jHSRalCGo6srge
 VnkHb2TuqoTXGABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C733EA63;
 Mon, 15 Dec 2025 22:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UE4/GD+FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 19/51] migration: Add capabilities into MigrationParameters
Date: Mon, 15 Dec 2025 19:00:05 -0300
Message-ID: <20251215220041.12657-20-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
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

Add capabilities to MigrationParameters. This structure will hold all
migration options. Capabilities will go away in the next patch.

Also add capabilities to MigrationParameter as the enum needs to be
kept in sync with MigrationParameters. This affects the parsing of
migration HMP commands so make the necessary additions there too.

(while here, also ensure MigrationParameter has their members in the
same order relative to MigrationParameters)

From this point on, both QMP and HMP versions of
migrate-set-parameters and query-migrate-parameters gain the ability
to work with capabilities.

With MigrationParameters now having members for each capability, the
migration capabilities commands (query-migrate-capabilities,
migrate-set-capabilities) will soon be deprecated. Add a set of
helpers to convert between the old MigrationCapability representation
and the new representation as members of MigrationParameters.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 198 +++++++++++++++++++++++++++++++++
 migration/migration.c          |   8 ++
 migration/options.c            | 130 +++++++++++++++++++++-
 migration/options.h            |   5 +
 qapi/migration.json            | 140 ++++++++++++++++++++++-
 5 files changed, 474 insertions(+), 7 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 670ddb047b..28b48c34bf 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -492,6 +492,116 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     assert(params->has_cpr_exec_command);
     monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
 
+    PARAM_INFO(params->has_xbzrle,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_XBZRLE,
+               params->xbzrle ? "on" : "off");
+
+    PARAM_INFO(params->has_rdma_pin_all,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_RDMA_PIN_ALL,
+               params->rdma_pin_all ? "on" : "off");
+
+    PARAM_INFO(params->has_auto_converge,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_AUTO_CONVERGE,
+               params->auto_converge ? "on" : "off");
+
+    PARAM_INFO(params->has_zero_blocks,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_ZERO_BLOCKS,
+               params->zero_blocks ? "on" : "off");
+
+    PARAM_INFO(params->has_events,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_EVENTS,
+               params->events ? "on" : "off");
+
+    PARAM_INFO(params->has_postcopy_ram,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_POSTCOPY_RAM,
+               params->postcopy_ram ? "on" : "off");
+
+    PARAM_INFO(params->has_x_colo,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_X_COLO,
+               params->x_colo ? "on" : "off");
+
+    PARAM_INFO(params->has_release_ram,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_RELEASE_RAM,
+               params->release_ram ? "on" : "off");
+
+    PARAM_INFO(params->has_return_path,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_RETURN_PATH,
+               params->return_path ? "on" : "off");
+
+    PARAM_INFO(params->has_pause_before_switchover,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_PAUSE_BEFORE_SWITCHOVER,
+               params->pause_before_switchover ? "on" : "off");
+
+    PARAM_INFO(params->has_multifd,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_MULTIFD,
+               params->multifd ? "on" : "off");
+
+    PARAM_INFO(params->has_dirty_bitmaps,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_DIRTY_BITMAPS,
+               params->dirty_bitmaps ? "on" : "off");
+
+    PARAM_INFO(params->has_postcopy_blocktime,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_POSTCOPY_BLOCKTIME,
+               params->postcopy_blocktime ? "on" : "off");
+
+    PARAM_INFO(params->has_late_block_activate,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_LATE_BLOCK_ACTIVATE,
+               params->late_block_activate ? "on" : "off");
+
+    PARAM_INFO(params->has_x_ignore_shared,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_X_IGNORE_SHARED,
+               params->x_ignore_shared ? "on" : "off");
+
+    PARAM_INFO(params->has_validate_uuid,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_VALIDATE_UUID,
+               params->validate_uuid ? "on" : "off");
+
+    PARAM_INFO(params->has_background_snapshot,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_BACKGROUND_SNAPSHOT,
+               params->background_snapshot ? "on" : "off");
+
+    PARAM_INFO(params->has_zero_copy_send,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_ZERO_COPY_SEND,
+               params->zero_copy_send ? "on" : "off");
+
+    PARAM_INFO(params->has_postcopy_preempt,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_POSTCOPY_PREEMPT,
+               params->postcopy_preempt ? "on" : "off");
+
+    PARAM_INFO(params->has_switchover_ack,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_SWITCHOVER_ACK,
+               params->switchover_ack ? "on" : "off");
+
+    PARAM_INFO(params->has_dirty_limit,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_DIRTY_LIMIT,
+               params->dirty_limit ? "on" : "off");
+
+    PARAM_INFO(params->has_mapped_ram,
+               "%s: %s\n",
+               MIGRATION_PARAMETER_MAPPED_RAM,
+               params->mapped_ram ? "on" : "off");
+
     qapi_free_MigrationParameters(params);
 }
 
@@ -792,6 +902,94 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_cpr_exec_command = true;
         break;
     }
+    case MIGRATION_PARAMETER_XBZRLE:
+        p->has_xbzrle = true;
+        visit_type_bool(v, param, &p->xbzrle, &err);
+        break;
+    case MIGRATION_PARAMETER_RDMA_PIN_ALL:
+        p->has_rdma_pin_all = true;
+        visit_type_bool(v, param, &p->rdma_pin_all, &err);
+        break;
+    case MIGRATION_PARAMETER_AUTO_CONVERGE:
+        p->has_auto_converge = true;
+        visit_type_bool(v, param, &p->auto_converge, &err);
+        break;
+    case MIGRATION_PARAMETER_ZERO_BLOCKS:
+        p->has_zero_blocks = true;
+        visit_type_bool(v, param, &p->zero_blocks, &err);
+        break;
+    case MIGRATION_PARAMETER_EVENTS:
+        p->has_events = true;
+        visit_type_bool(v, param, &p->events, &err);
+        break;
+    case MIGRATION_PARAMETER_POSTCOPY_RAM:
+        p->has_postcopy_ram = true;
+        visit_type_bool(v, param, &p->postcopy_ram, &err);
+        break;
+    case MIGRATION_PARAMETER_X_COLO:
+        p->has_x_colo = true;
+        visit_type_bool(v, param, &p->x_colo, &err);
+        break;
+    case MIGRATION_PARAMETER_RELEASE_RAM:
+        p->has_release_ram = true;
+        visit_type_bool(v, param, &p->release_ram, &err);
+        break;
+    case MIGRATION_PARAMETER_RETURN_PATH:
+        p->has_return_path = true;
+        visit_type_bool(v, param, &p->return_path, &err);
+        break;
+    case MIGRATION_PARAMETER_PAUSE_BEFORE_SWITCHOVER:
+        p->has_pause_before_switchover = true;
+        visit_type_bool(v, param, &p->pause_before_switchover, &err);
+        break;
+    case MIGRATION_PARAMETER_MULTIFD:
+        p->has_multifd = true;
+        visit_type_bool(v, param, &p->multifd, &err);
+        break;
+    case MIGRATION_PARAMETER_DIRTY_BITMAPS:
+        p->has_dirty_bitmaps = true;
+        visit_type_bool(v, param, &p->dirty_bitmaps, &err);
+        break;
+    case MIGRATION_PARAMETER_POSTCOPY_BLOCKTIME:
+        p->has_postcopy_blocktime = true;
+        visit_type_bool(v, param, &p->postcopy_blocktime, &err);
+        break;
+    case MIGRATION_PARAMETER_LATE_BLOCK_ACTIVATE:
+        p->has_late_block_activate = true;
+        visit_type_bool(v, param, &p->late_block_activate, &err);
+        break;
+    case MIGRATION_PARAMETER_X_IGNORE_SHARED:
+        p->has_x_ignore_shared = true;
+        visit_type_bool(v, param, &p->x_ignore_shared, &err);
+        break;
+    case MIGRATION_PARAMETER_VALIDATE_UUID:
+        p->has_validate_uuid = true;
+        visit_type_bool(v, param, &p->validate_uuid, &err);
+        break;
+    case MIGRATION_PARAMETER_BACKGROUND_SNAPSHOT:
+        p->has_background_snapshot = true;
+        visit_type_bool(v, param, &p->background_snapshot, &err);
+        break;
+    case MIGRATION_PARAMETER_ZERO_COPY_SEND:
+        p->has_zero_copy_send = true;
+        visit_type_bool(v, param, &p->zero_copy_send, &err);
+        break;
+    case MIGRATION_PARAMETER_POSTCOPY_PREEMPT:
+        p->has_postcopy_preempt = true;
+        visit_type_bool(v, param, &p->postcopy_preempt, &err);
+        break;
+    case MIGRATION_PARAMETER_SWITCHOVER_ACK:
+        p->has_switchover_ack = true;
+        visit_type_bool(v, param, &p->switchover_ack, &err);
+        break;
+    case MIGRATION_PARAMETER_DIRTY_LIMIT:
+        p->has_dirty_limit = true;
+        visit_type_bool(v, param, &p->dirty_limit, &err);
+        break;
+    case MIGRATION_PARAMETER_MAPPED_RAM:
+        p->has_mapped_ram = true;
+        visit_type_bool(v, param, &p->mapped_ram, &err);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/migration/migration.c b/migration/migration.c
index 2c8acd2ee1..f0e74cbf4b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4196,6 +4196,14 @@ static bool migration_object_check(MigrationState *ms, Error **errp)
         return false;
     }
 
+    /*
+     * FIXME: Temporarily while -global capabilties are still using
+     * s->capabilities. Will be gone by the end of the series.
+     */
+    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        migrate_capability_set_compat(&ms->parameters, i, ms->capabilities[i]);
+    }
+
     return migrate_caps_check(old_caps, ms->capabilities, errp);
 }
 
diff --git a/migration/options.c b/migration/options.c
index 36feaa5fe6..b23dcc15f9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -730,6 +730,111 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     return true;
 }
 
+static bool *migrate_capability_get_addr(MigrationParameters *params, int i)
+{
+    bool *cap_addr = NULL;
+
+    switch (i) {
+    case MIGRATION_CAPABILITY_XBZRLE:
+        cap_addr = &params->xbzrle;
+        break;
+    case MIGRATION_CAPABILITY_RDMA_PIN_ALL:
+        cap_addr = &params->rdma_pin_all;
+        break;
+    case MIGRATION_CAPABILITY_AUTO_CONVERGE:
+        cap_addr = &params->auto_converge;
+        break;
+    case MIGRATION_CAPABILITY_ZERO_BLOCKS:
+        cap_addr = &params->zero_blocks;
+        break;
+    case MIGRATION_CAPABILITY_EVENTS:
+        cap_addr = &params->events;
+        break;
+    case MIGRATION_CAPABILITY_POSTCOPY_RAM:
+        cap_addr = &params->postcopy_ram;
+        break;
+    case MIGRATION_CAPABILITY_X_COLO:
+        cap_addr = &params->x_colo;
+        break;
+    case MIGRATION_CAPABILITY_RELEASE_RAM:
+        cap_addr = &params->release_ram;
+        break;
+    case MIGRATION_CAPABILITY_RETURN_PATH:
+        cap_addr = &params->return_path;
+        break;
+    case MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER:
+        cap_addr = &params->pause_before_switchover;
+        break;
+    case MIGRATION_CAPABILITY_MULTIFD:
+        cap_addr = &params->multifd;
+        break;
+    case MIGRATION_CAPABILITY_DIRTY_BITMAPS:
+        cap_addr = &params->dirty_bitmaps;
+        break;
+    case MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME:
+        cap_addr = &params->postcopy_blocktime;
+        break;
+    case MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE:
+        cap_addr = &params->late_block_activate;
+        break;
+    case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
+        cap_addr = &params->x_ignore_shared;
+        break;
+    case MIGRATION_CAPABILITY_VALIDATE_UUID:
+        cap_addr = &params->validate_uuid;
+        break;
+    case MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT:
+        cap_addr = &params->background_snapshot;
+        break;
+    case MIGRATION_CAPABILITY_ZERO_COPY_SEND:
+        cap_addr = &params->zero_copy_send;
+        break;
+    case MIGRATION_CAPABILITY_POSTCOPY_PREEMPT:
+        cap_addr = &params->postcopy_preempt;
+        break;
+    case MIGRATION_CAPABILITY_SWITCHOVER_ACK:
+        cap_addr = &params->switchover_ack;
+        break;
+    case MIGRATION_CAPABILITY_DIRTY_LIMIT:
+        cap_addr = &params->dirty_limit;
+        break;
+    case MIGRATION_CAPABILITY_MAPPED_RAM:
+        cap_addr = &params->mapped_ram;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return cap_addr;
+}
+
+/* Compatibility for code that reads capabilities in a loop */
+bool migrate_capability_get_compat(MigrationParameters *params, int i)
+{
+    return *(migrate_capability_get_addr(params, i));
+}
+
+/* Compatibility for code that writes capabilities in a loop */
+void migrate_capability_set_compat(MigrationParameters *params, int i, bool val)
+{
+    *(migrate_capability_get_addr(params, i)) = val;
+}
+
+/*
+ * Set capabilities for compatibility with the old
+ * migrate-set-capabilities command.
+ */
+void migrate_capabilities_set_compat(MigrationParameters *params,
+                                     MigrationCapabilityStatusList *caps)
+{
+    MigrationCapabilityStatusList *cap;
+
+    for (cap = caps; cap; cap = cap->next) {
+        migrate_capability_set_compat(params, cap->value->capability,
+                                      cap->value->state);
+    }
+}
+
 MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 {
     MigrationCapabilityStatusList *head = NULL, **tail = &head;
@@ -771,6 +876,8 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     for (cap = params; cap; cap = cap->next) {
         s->capabilities[cap->value->capability] = cap->value->state;
     }
+
+    migrate_capabilities_set_compat(&s->parameters, params);
 }
 
 /* parameters */
@@ -1047,7 +1154,15 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_cpr_exec_command,
+        &p->has_cpr_exec_command, &p->has_xbzrle, &p->has_rdma_pin_all,
+        &p->has_auto_converge, &p->has_zero_blocks, &p->has_events,
+        &p->has_postcopy_ram, &p->has_x_colo, &p->has_release_ram,
+        &p->has_return_path, &p->has_pause_before_switchover, &p->has_multifd,
+        &p->has_dirty_bitmaps, &p->has_postcopy_blocktime,
+        &p->has_late_block_activate, &p->has_x_ignore_shared,
+        &p->has_validate_uuid, &p->has_background_snapshot,
+        &p->has_zero_copy_send, &p->has_postcopy_preempt,
+        &p->has_switchover_ack, &p->has_dirty_limit, &p->has_mapped_ram,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1320,6 +1435,19 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     tls_opt_to_str(params->tls_hostname);
     tls_opt_to_str(params->tls_authz);
 
+    /*
+     * FIXME: Temporarily while migrate_caps_check is not
+     * converted to look at s->parameters. Will be gone the end of
+     * the series.
+     */
+    bool new_caps[MIGRATION_CAPABILITY__MAX] = { 0 };
+    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        new_caps[i] = migrate_capability_get_compat(&s->parameters, i);
+    }
+    if (!migrate_caps_check(s->capabilities, new_caps, errp)) {
+        return;
+    }
+
     migrate_params_merge(tmp, params);
 
     /*
diff --git a/migration/options.h b/migration/options.h
index 25fb316420..794cf23870 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -93,4 +93,9 @@ ZeroPageDetection migrate_zero_page_detection(void);
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
 void migrate_tls_opts_free(MigrationParameters *params);
+bool migrate_capability_get_compat(MigrationParameters *params, int i);
+void migrate_capability_set_compat(MigrationParameters *params, int i,
+                                   bool val);
+void migrate_capabilities_set_compat(MigrationParameters *params,
+                                     MigrationCapabilityStatusList *caps);
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index 201dedd982..fcbb699a47 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -832,15 +832,22 @@
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level', 'multifd-zstd-level',
-           'multifd-qatzip-level',
+           'multifd-zlib-level', 'multifd-qatzip-level', 'multifd-zstd-level',
            'block-bitmap-mapping',
            { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
            'direct-io',
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           'xbzrle', 'rdma-pin-all', 'auto-converge',
+           'zero-blocks', 'events', 'postcopy-ram', 'x-colo',
+           'release-ram', 'return-path', 'pause-before-switchover',
+           'multifd', 'dirty-bitmaps', 'postcopy-blocktime',
+           'late-block-activate', 'x-ignore-shared',
+           'validate-uuid', 'background-snapshot',
+           'zero-copy-send', 'postcopy-preempt',
+           'switchover-ack', 'dirty-limit', 'mapped-ram' ] }
 
 ##
 # @migrate-set-parameters:
@@ -1016,10 +1023,109 @@
 #     is @cpr-exec.  The first list element is the program's filename,
 #     the remainder its arguments.  (Since 10.2)
 #
+# @xbzrle: Migration supports xbzrle (Xor Based Zero Run Length
+#     Encoding).  This feature allows us to minimize migration traffic
+#     for certain work loads, by sending compressed difference of the
+#     pages
+#
+# @rdma-pin-all: Controls whether or not the entire VM memory
+#     footprint is mlock()'d on demand or all at once.  Refer to
+#     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
+#
+# @zero-blocks: During storage migration encode blocks of zeroes
+#     efficiently.  This essentially saves 1MB of zeroes per block on
+#     the wire.  Enabling requires source and target VM to support
+#     this feature.  To enable it is sufficient to enable the
+#     capability on the source VM.  The feature is disabled by
+#     default.  (since 1.6)
+#
+# @events: Generate events for each migration state change.
+#     (since 2.4)
+#
+# @auto-converge: If enabled, QEMU will automatically throttle down
+#     the guest to speed up convergence of RAM migration.  (since 1.6)
+#
+# @postcopy-ram: Start executing on the migration target before all of
+#     RAM has been migrated, pulling the remaining pages along as
+#     needed.  The capacity must have the same setting on both source
+#     and target or migration will not even start.  **Note:** If the
+#     migration fails during postcopy the VM will fail.  (since 2.6)
+#
+# @x-colo: If enabled, migration will never end, and the state of the
+#     VM on the primary side will be migrated continuously to the VM
+#     on secondary side, this process is called COarse-Grain LOck
+#     Stepping (COLO) for Non-stop Service.  (since 2.8)
+#
+# @release-ram: If enabled, QEMU will free the migrated ram pages on
+#     the source during postcopy-ram migration.  (since 2.9)
+#
+# @return-path: If enabled, migration will use the return path even
+#     for precopy.  (since 2.10)
+#
+# @pause-before-switchover: Pause outgoing migration before
+#     serialising device state and before disabling block IO.
+#     (since 2.11)
+#
+# @multifd: Use more than one fd for migration.  (since 4.0)
+#
+# @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
+#     (since 2.12)
+#
+# @postcopy-blocktime: Calculate downtime for postcopy live migration.
+#     (since 3.0)
+#
+# @late-block-activate: If enabled, the destination will not activate
+#     block devices (and thus take locks) immediately at the end of
+#     migration.  (since 3.0)
+#
+# @x-ignore-shared: If enabled, QEMU will not migrate shared memory
+#     that is accessible on the destination machine.  (since 4.0)
+#
+# @validate-uuid: Send the UUID of the source to allow the destination
+#     to ensure it is the same.  (since 4.2)
+#
+# @background-snapshot: If enabled, the migration stream will be a
+#     snapshot of the VM exactly at the point when the migration
+#     procedure starts.  The VM RAM is saved with running VM.
+#     (since 6.0)
+#
+# @zero-copy-send: Controls behavior on sending memory pages on
+#     migration.  When true, enables a zero-copy mechanism for sending
+#     memory pages, if host supports it.  Requires that QEMU be
+#     permitted to use locked memory for guest RAM pages.  (since 7.1)
+#
+# @postcopy-preempt: If enabled, the migration process will allow
+#     postcopy requests to preempt precopy stream, so postcopy
+#     requests will be handled faster.  This is a performance feature
+#     and should not affect the correctness of postcopy migration.
+#     (since 7.1)
+#
+# @switchover-ack: If enabled, migration will not stop the source VM
+#     and complete the migration until an ACK is received from the
+#     destination that it's OK to do so.  Exactly when this ACK is
+#     sent depends on the migrated devices that use this feature.  For
+#     example, a device can use it to make sure some of its data is
+#     sent and loaded in the destination before doing switchover.
+#     This can reduce downtime if devices that support this capability
+#     are present.  'return-path' capability must be enabled to use
+#     it.  (since 8.1)
+#
+# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
+#     keep their dirty page rate within @vcpu-dirty-limit.  This can
+#     improve responsiveness of large guests during live migration,
+#     and can result in more stable read performance.  Requires KVM
+#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
+#
+# @mapped-ram: Migrate using fixed offsets in the migration file for
+#     each RAM page.  Requires a migration URI that supports seeking,
+#     such as a file.  (since 9.0)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @x-checkpoint-delay, @x-vcpu-dirty-limit-period,
+#     @x-colo and @x-ignore-shared are experimental.
+# @deprecated: Member @zero-blocks is deprecated as being part of
+#     block migration which was already removed.
 #
 # Since: 2.4
 ##
@@ -1055,7 +1161,29 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*xbzrle': 'bool',
+            '*rdma-pin-all': 'bool',
+            '*auto-converge': 'bool',
+            '*zero-blocks': { 'type': 'bool', 'features': [ 'deprecated' ] },
+            '*events': 'bool',
+            '*postcopy-ram': 'bool',
+            '*x-colo': { 'type': 'bool', 'features': [ 'unstable' ] },
+            '*release-ram': 'bool',
+            '*return-path': 'bool',
+            '*pause-before-switchover': 'bool',
+            '*multifd': 'bool',
+            '*dirty-bitmaps': 'bool',
+            '*postcopy-blocktime': 'bool',
+            '*late-block-activate': 'bool',
+            '*x-ignore-shared': { 'type': 'bool', 'features': [ 'unstable' ] },
+            '*validate-uuid': 'bool',
+            '*background-snapshot': 'bool',
+            '*zero-copy-send': 'bool',
+            '*postcopy-preempt': 'bool',
+            '*switchover-ack': 'bool',
+            '*dirty-limit': 'bool',
+            '*mapped-ram': 'bool' } }
 
 ##
 # @query-migrate-parameters:
-- 
2.51.0


