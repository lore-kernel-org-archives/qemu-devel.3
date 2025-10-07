Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D2ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 18:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Cdq-0002aJ-H2; Tue, 07 Oct 2025 14:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v6Cdm-0002Zu-Th
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:42:27 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v6Cdk-0003cc-DV
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:42:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 702D91F7EF;
 Tue,  7 Oct 2025 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759862537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4xy2rq8k0KPm7HUAY4Gz4yN1sW557wyEG99y0avL/Vs=;
 b=g5ePCysUHshKqSUpiZeVXmhuxdN1YtcTbKDidsPtYfObY0qhD3aX01/9qD1AUc1DcgGt0Z
 IIvDXn4kNuWoS2Z3u+9a3e6i4cZ02mSb78259eOklyfhP4D7YlrTeqqpe2yCAxYtLjO4A+
 n6081SfE2S6b1FMCz5ABIC/2I6XPPlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759862537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4xy2rq8k0KPm7HUAY4Gz4yN1sW557wyEG99y0avL/Vs=;
 b=TTg9qghx7swBp+EqBF6sWjlhGhdOU3+f6lOnngbVYF1GVg0vVa3vrHaJbEkdsy1U+WRliU
 sKIzXPsMRIaI2LDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=g5ePCysU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TTg9qghx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759862537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4xy2rq8k0KPm7HUAY4Gz4yN1sW557wyEG99y0avL/Vs=;
 b=g5ePCysUHshKqSUpiZeVXmhuxdN1YtcTbKDidsPtYfObY0qhD3aX01/9qD1AUc1DcgGt0Z
 IIvDXn4kNuWoS2Z3u+9a3e6i4cZ02mSb78259eOklyfhP4D7YlrTeqqpe2yCAxYtLjO4A+
 n6081SfE2S6b1FMCz5ABIC/2I6XPPlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759862537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4xy2rq8k0KPm7HUAY4Gz4yN1sW557wyEG99y0avL/Vs=;
 b=TTg9qghx7swBp+EqBF6sWjlhGhdOU3+f6lOnngbVYF1GVg0vVa3vrHaJbEkdsy1U+WRliU
 sKIzXPsMRIaI2LDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2180313AAC;
 Tue,  7 Oct 2025 18:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KBHeMwdf5WjGCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 Oct 2025 18:42:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [RESEND] migration/savevm: Add a compatibility check for capabilities
Date: Tue,  7 Oct 2025 15:42:13 -0300
Message-Id: <20251007184213.5990-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 702D91F7EF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

It has always been possible to enable arbitrary migration capabilities
and attempt to take a snapshot of the VM with the savevm/loadvm
commands as well as their QMP counterparts
snapshot-save/snapshot-load.

Most migration capabilities are not meant to be used with snapshots
and there's a risk of crashing QEMU or producing incorrect
behavior. Ideally, every migration capability would either be
implemented for savevm or explicitly rejected.

Add a compatibility check routine and reject the snapshot command if
an incompatible capability is enabled. For now only act on the the two
that actually cause a crash: multifd and mapped-ram.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2881
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 27 +++++++++++++++++++++++++++
 migration/options.h |  1 +
 migration/savevm.c  |  8 ++++++++
 3 files changed, 36 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 5183112775..d9227809d7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -445,11 +445,38 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_VALIDATE_UUID,
     MIGRATION_CAPABILITY_ZERO_COPY_SEND);
 
+/* Snapshot compatibility check list */
+static const
+INITIALIZE_MIGRATE_CAPS_SET(check_caps_savevm,
+                            MIGRATION_CAPABILITY_MULTIFD,
+                            MIGRATION_CAPABILITY_MAPPED_RAM,
+);
+
 static bool migrate_incoming_started(void)
 {
     return !!migration_incoming_get_current()->transport_data;
 }
 
+bool migrate_can_snapshot(Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    int i;
+
+    for (i = 0; i < check_caps_savevm.size; i++) {
+        int incomp_cap = check_caps_savevm.caps[i];
+
+        if (s->capabilities[incomp_cap]) {
+            error_setg(errp,
+                       "Snapshots are not compatible with %s",
+                       MigrationCapability_str(incomp_cap));
+            return false;
+        }
+    }
+
+    return true;
+}
+
+
 bool migrate_rdma_caps_check(bool *caps, Error **errp)
 {
     if (caps[MIGRATION_CAPABILITY_XBZRLE]) {
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..a7b3262d1e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -59,6 +59,7 @@ bool migrate_tls(void);
 
 bool migrate_rdma_caps_check(bool *caps, Error **errp);
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
+bool migrate_can_snapshot(Error **errp);
 
 /* parameters */
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 7b35ec4dd0..aafa40d779 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3322,6 +3322,10 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
 
     GLOBAL_STATE_CODE();
 
+    if (!migrate_can_snapshot(errp)) {
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
@@ -3507,6 +3511,10 @@ bool load_snapshot(const char *name, const char *vmstate,
     int ret;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (!migrate_can_snapshot(errp)) {
+        return false;
+    }
+
     if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
         return false;
     }
-- 
2.35.3


