Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74057D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNET-0001wF-Pi; Fri, 23 Jan 2026 14:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNER-0001w2-Th
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:11 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEQ-0003Sy-3V
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF29F33865;
 Fri, 23 Jan 2026 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I14XogeA5iS6CKeQVezAAXOBDrCfcPJnQiPBr+MMK9Q=;
 b=aeYjNQFXQWT/C65ZN0Q6fXWji/eCOwrklgbLj3jAklH1BkPDfU+Qk5zrOWrzmE9SOUG3n4
 v57iAIEJWwkT4xhdJaYebE1V0qejCZM+uvex4QJZ6UAK9louxaxkQFktiJWNa9kROHD1uF
 uxD83vpcW1J+ISjf0G8kXbgrOCrfgro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I14XogeA5iS6CKeQVezAAXOBDrCfcPJnQiPBr+MMK9Q=;
 b=9rd2QAsuz9TV1bj6zyVEPThdkwu6QNaugcCOvoBy2CgqWpMENIlJwB67F96Lq5jGH4tYsA
 MGg+y7aRDWTc4PDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I14XogeA5iS6CKeQVezAAXOBDrCfcPJnQiPBr+MMK9Q=;
 b=aeYjNQFXQWT/C65ZN0Q6fXWji/eCOwrklgbLj3jAklH1BkPDfU+Qk5zrOWrzmE9SOUG3n4
 v57iAIEJWwkT4xhdJaYebE1V0qejCZM+uvex4QJZ6UAK9louxaxkQFktiJWNa9kROHD1uF
 uxD83vpcW1J+ISjf0G8kXbgrOCrfgro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I14XogeA5iS6CKeQVezAAXOBDrCfcPJnQiPBr+MMK9Q=;
 b=9rd2QAsuz9TV1bj6zyVEPThdkwu6QNaugcCOvoBy2CgqWpMENIlJwB67F96Lq5jGH4tYsA
 MGg+y7aRDWTc4PDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C2D81395E;
 Fri, 23 Jan 2026 19:53:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2P5qCdbRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:53:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/36] migration: Drop deprecated QMP migrate argument @detach
Date: Fri, 23 Jan 2026 16:53:17 -0300
Message-ID: <20260123195352.12850-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Markus Armbruster <armbru@redhat.com>

Deprecated in commit c2fb6eaeb9d4 (qapi/migration: Deprecate migrate
argument @detach), v10.1.0.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260108125512.2234147-3-armbru@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst       | 5 -----
 docs/about/removed-features.rst | 5 +++++
 migration/migration-hmp-cmds.c  | 2 +-
 migration/migration.c           | 2 +-
 qapi/migration.json             | 8 --------
 5 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f57422d378..4595cc2db5 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -142,11 +142,6 @@ Use ``job-dismiss`` instead.
 
 Use ``job-finalize`` instead.
 
-``migrate`` argument ``detach`` (since 10.1)
-''''''''''''''''''''''''''''''''''''''''''''
-
-This argument has always been ignored.
-
 Human Machine Protocol (HMP) commands
 -------------------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 4e0775dbc0..ebdfb696ed 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -766,6 +766,11 @@ without reporting any destination threads, or non-multifd source
 threads).  For debugging purpose, please use ``-name
 $VM,debug-threads=on`` instead.
 
+``migrate`` argument ``detach`` (since 11.0)
+''''''''''''''''''''''''''''''''''''''''''''
+
+This argument has always been ignored.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a2863e6a2f..0a193b8f54 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -829,7 +829,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
+    qmp_migrate(NULL, true, caps, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 9c6aa6f98a..4062c12d33 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2201,7 +2201,7 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
 }
 
 void qmp_migrate(const char *uri, bool has_channels,
-                 MigrationChannelList *channels, bool has_detach, bool detach,
+                 MigrationChannelList *channels,
                  bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
diff --git a/qapi/migration.json b/qapi/migration.json
index 7bd24e66e9..c99ae433e0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1397,19 +1397,12 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
-# @detach: this argument exists only for compatibility reasons and is
-#     ignored by QEMU
-#
 # @resume: when set, use the new uri/channels specified to resume
 #     paused postcopy migration.  This flag should only be used if
 #     the previous postcopy migration was interrupted.  The command
 #     will fail unless migration is in "postcopy-paused" state.
 #     (default: false, since 3.0)
 #
-# Features:
-#
-# @deprecated: Argument @detach is deprecated.
-#
 # Since: 0.14
 #
 # .. admonition:: Notes
@@ -1469,7 +1462,6 @@
 { 'command': 'migrate',
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
-           '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*resume': 'bool' } }
 
 ##
-- 
2.51.0


