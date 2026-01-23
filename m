Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99DED778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEh-00022Z-9D; Fri, 23 Jan 2026 14:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEf-0001zf-HC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:25 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEd-0003Uh-Mo
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23BD75BCCF;
 Fri, 23 Jan 2026 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMTf0uhPWrpw0qFSweSfrNMabonCrvDY5bWvqbymo7w=;
 b=Umz8XOMJ5KJK7QUVvPoLMtYlkwHYzmFNL8Vt6SOi+NoIsKgn12wDt6v1C75l1bnhs0h+od
 OA+Y0m6zXNlx6nEVQf5Iqyho3FdvruZqK7UIgFJL7fMmOmwvbej2W+mXj7RVnKBsHeJbjc
 sCSmWYzHN7onWkAKctopGWUMo6XE8Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMTf0uhPWrpw0qFSweSfrNMabonCrvDY5bWvqbymo7w=;
 b=sl2TdwB/ITuC/5/A/UxebuwdkNWWMNlR4Vey8z+HCE/1blgpPI+8HdIiPA0qWsGrXX332+
 mIv6I2VZH3hwF8CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Umz8XOMJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="sl2TdwB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMTf0uhPWrpw0qFSweSfrNMabonCrvDY5bWvqbymo7w=;
 b=Umz8XOMJ5KJK7QUVvPoLMtYlkwHYzmFNL8Vt6SOi+NoIsKgn12wDt6v1C75l1bnhs0h+od
 OA+Y0m6zXNlx6nEVQf5Iqyho3FdvruZqK7UIgFJL7fMmOmwvbej2W+mXj7RVnKBsHeJbjc
 sCSmWYzHN7onWkAKctopGWUMo6XE8Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMTf0uhPWrpw0qFSweSfrNMabonCrvDY5bWvqbymo7w=;
 b=sl2TdwB/ITuC/5/A/UxebuwdkNWWMNlR4Vey8z+HCE/1blgpPI+8HdIiPA0qWsGrXX332+
 mIv6I2VZH3hwF8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1B041395E;
 Fri, 23 Jan 2026 19:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEYPIOTRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/36] migration: Remove zero-blocks capability
Date: Fri, 23 Jan 2026 16:53:25 -0300
Message-ID: <20260123195352.12850-11-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 23BD75BCCF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

From: Peter Xu <peterx@redhat.com>

It was declared deprecated since 9.2.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260115225503.3083355-2-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  7 +++++++
 migration/options.c             |  5 -----
 qapi/migration.json             | 12 ------------
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4595cc2db5..ae9a3b8aea 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -532,9 +532,3 @@ usage of providing a file descriptor to a plain file has been
 deprecated in favor of explicitly using the ``file:`` URI with the
 file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
 command documentation for details on the ``fdset`` usage.
-
-``zero-blocks`` capability (since 9.2)
-''''''''''''''''''''''''''''''''''''''
-
-The ``zero-blocks`` capability was part of the block migration which
-doesn't exist anymore since it was removed in QEMU v9.1.
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index ebdfb696ed..92f80a32e4 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -723,6 +723,13 @@ Block migration has been removed. For a replacement, see "QMP
 invocation for live storage migration with ``blockdev-mirror`` + NBD"
 in docs/interop/live-block-operations.rst.
 
+``migrate-set-capabilities`` ``zero-blocks`` option (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``zero-blocks`` capability was accidentally left behind when
+block migration capability got removed in 9.1.  Removed with no
+replacement.
+
 ``migrate-set-parameter`` ``compress-level`` option (removed in 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/migration/options.c b/migration/options.c
index 9a5a39c886..68a4536150 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -188,7 +188,6 @@ const Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
     DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
     DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
-    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
     DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
     DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
     DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
@@ -576,10 +575,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
-        warn_report("zero-blocks capability is deprecated");
-    }
-
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
diff --git a/qapi/migration.json b/qapi/migration.json
index c99ae433e0..f925e5541b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -440,13 +440,6 @@
 #     footprint is mlock()'d on demand or all at once.  Refer to
 #     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
 #
-# @zero-blocks: During storage migration encode blocks of zeroes
-#     efficiently.  This essentially saves 1MB of zeroes per block on
-#     the wire.  Enabling requires source and target VM to support
-#     this feature.  To enable it is sufficient to enable the
-#     capability on the source VM.  The feature is disabled by
-#     default.  (since 1.6)
-#
 # @events: generate events for each migration state change (since 2.4)
 #
 # @auto-converge: If enabled, QEMU will automatically throttle down
@@ -531,14 +524,10 @@
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
-# @deprecated: Member @zero-blocks is deprecated as being part of
-#     block migration which was already removed.
-#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
-           { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
@@ -595,7 +584,6 @@
 #           {"state": false, "capability": "xbzrle"},
 #           {"state": false, "capability": "rdma-pin-all"},
 #           {"state": false, "capability": "auto-converge"},
-#           {"state": false, "capability": "zero-blocks"},
 #           {"state": true, "capability": "events"},
 #           {"state": false, "capability": "postcopy-ram"},
 #           {"state": false, "capability": "x-colo"}
-- 
2.51.0


