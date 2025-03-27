Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8828C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoOl-0006Vr-An; Thu, 27 Mar 2025 10:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOa-0006UR-FC
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOY-0005ZI-M3
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 962331F79D;
 Thu, 27 Mar 2025 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JoqtdTugN+FwCPJW4PNptDGkquwWXj5Pm61EHfGRf4=;
 b=y92ZJafVtCMkACwY+SY7DVXPm+KcUyPlcD+aG1ftZZPVtHShKcxUPu1Lus8vizWWEG8uHb
 uYGC5MHB/QM2bkNLp1cOmffxJLhZrwk9Gch5fCK8yGeyNsygrSNMiSRnFFQbLE7vSXHKGk
 LDPReZme76weGNzCmnK71DqrXsKCtYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JoqtdTugN+FwCPJW4PNptDGkquwWXj5Pm61EHfGRf4=;
 b=GTzm0oQafmhBu6heaOXi6vSdU8aglkWCp5Zm1MpRixe/fBmenaugQPDlcgmjtk/DZIPHgo
 OWcQFi45fqAbQHDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JoqtdTugN+FwCPJW4PNptDGkquwWXj5Pm61EHfGRf4=;
 b=y92ZJafVtCMkACwY+SY7DVXPm+KcUyPlcD+aG1ftZZPVtHShKcxUPu1Lus8vizWWEG8uHb
 uYGC5MHB/QM2bkNLp1cOmffxJLhZrwk9Gch5fCK8yGeyNsygrSNMiSRnFFQbLE7vSXHKGk
 LDPReZme76weGNzCmnK71DqrXsKCtYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JoqtdTugN+FwCPJW4PNptDGkquwWXj5Pm61EHfGRf4=;
 b=GTzm0oQafmhBu6heaOXi6vSdU8aglkWCp5Zm1MpRixe/fBmenaugQPDlcgmjtk/DZIPHgo
 OWcQFi45fqAbQHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BC6D139D4;
 Thu, 27 Mar 2025 14:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJseEytj5WcVZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:39:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, berrange@redhat.com,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 1/4] migration/savevm: Add a compatibility check for
 capabilities
Date: Thu, 27 Mar 2025 11:39:31 -0300
Message-Id: <20250327143934.7935-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327143934.7935-1-farosas@suse.de>
References: <20250327143934.7935-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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
 migration/options.c | 26 ++++++++++++++++++++++++++
 migration/options.h |  1 +
 migration/savevm.c  |  8 ++++++++
 3 files changed, 35 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index b0ac2ea408..8772b98dca 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -443,11 +443,37 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
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
 /**
  * @migration_caps_check - check capability compatibility
  *
diff --git a/migration/options.h b/migration/options.h
index 762be4e641..20b71b6f2a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -58,6 +58,7 @@ bool migrate_tls(void);
 /* capabilities helpers */
 
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
+bool migrate_can_snapshot(Error **errp);
 
 /* parameters */
 
diff --git a/migration/savevm.c b/migration/savevm.c
index ce158c3512..3be13bcfe8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3229,6 +3229,10 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
 
     GLOBAL_STATE_CODE();
 
+    if (!migrate_can_snapshot(errp)) {
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
@@ -3413,6 +3417,10 @@ bool load_snapshot(const char *name, const char *vmstate,
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


