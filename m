Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6B3C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXp-0007b9-V0; Wed, 29 Jan 2025 11:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVw-0003Qw-9E
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:05 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVu-0005MN-BJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:04 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 205011F383;
 Wed, 29 Jan 2025 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkLRBWg3YrGoafoXsDrdDnxqVpvLNtr3gGvjeMZFke0=;
 b=lsf4dUakeC1Gsx2lzxgPvJbr5O2UPQTeq1ydAHoCbpstRRYj4b2tuv3HXTiMcCb00kRPLT
 Xlb3IrUZRIHMdpGf+50JvJt+MM6rPN3QzNiRrtruLlXLxki1k4Ms+JMWqLDZSJq0ukcEEz
 R9kOgLoCaL3K66aNiCcWkmT4DxzwWQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkLRBWg3YrGoafoXsDrdDnxqVpvLNtr3gGvjeMZFke0=;
 b=app/RW9S2OBiGt/G6apS8sD1QT1xmlGhunB2RN/Pgt8izkZFh+THV5peNTqHm8uF3cjumZ
 QScUuSbuQ5y++3Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkLRBWg3YrGoafoXsDrdDnxqVpvLNtr3gGvjeMZFke0=;
 b=lsf4dUakeC1Gsx2lzxgPvJbr5O2UPQTeq1ydAHoCbpstRRYj4b2tuv3HXTiMcCb00kRPLT
 Xlb3IrUZRIHMdpGf+50JvJt+MM6rPN3QzNiRrtruLlXLxki1k4Ms+JMWqLDZSJq0ukcEEz
 R9kOgLoCaL3K66aNiCcWkmT4DxzwWQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkLRBWg3YrGoafoXsDrdDnxqVpvLNtr3gGvjeMZFke0=;
 b=app/RW9S2OBiGt/G6apS8sD1QT1xmlGhunB2RN/Pgt8izkZFh+THV5peNTqHm8uF3cjumZ
 QScUuSbuQ5y++3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 955E1137DB;
 Wed, 29 Jan 2025 16:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WKmOFfdQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 28/42] migration: Optimize postcopy on downtime by avoiding
 JSON writer
Date: Wed, 29 Jan 2025 13:00:45 -0300
Message-Id: <20250129160059.6987-29-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

postcopy_start() is the entry function that postcopy is destined to start.
It also means QEMU source will not dump VM description, aka, the JSON
writer is garbage now.

We can leave that to be cleaned up when migration completes, however when
with the JSON writer object being present, vmstate_save() will still try to
construct the JSON objects for the VM descriptions, even though it'll never
be used later if it's postcopy.

To save those cycles, release the JSON writer earlier for postcopy. Then
vmstate_save() later will be smart enough to skip the JSON object
constructions completely.  It can logically reduce downtime because all
such JSON constructions happen during postcopy blackout.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-4-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5c335cc30b..a9fe9c2821 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1422,6 +1422,11 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
     }
 }
 
+static void migration_cleanup_json_writer(MigrationState *s)
+{
+    g_clear_pointer(&s->vmdesc, json_writer_free);
+}
+
 static void migrate_fd_cleanup(MigrationState *s)
 {
     MigrationEventType type;
@@ -1429,11 +1434,11 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     trace_migrate_fd_cleanup();
 
+    migration_cleanup_json_writer(s);
+
     g_free(s->hostname);
     s->hostname = NULL;
 
-    g_clear_pointer(&s->vmdesc, json_writer_free);
-
     qemu_savevm_state_cleanup();
     cpr_state_close();
     migrate_hup_delete(s);
@@ -2628,6 +2633,14 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     uint64_t bandwidth = migrate_max_postcopy_bandwidth();
     int cur_state = MIGRATION_STATUS_ACTIVE;
 
+    /*
+     * Now we're 100% sure to switch to postcopy, so JSON writer won't be
+     * useful anymore.  Free the resources early if it is there.  Clearing
+     * the vmdesc also means any follow up vmstate_save()s will start to
+     * skip all JSON operations, which can shrink postcopy downtime.
+     */
+    migration_cleanup_json_writer(ms);
+
     if (migrate_postcopy_preempt()) {
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
-- 
2.35.3


