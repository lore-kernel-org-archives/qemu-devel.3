Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC40C5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGcN-0006xy-T8; Mon, 02 Jun 2025 21:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcK-0006lI-Kk
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGcI-0001YO-VK
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:39:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F906218EA;
 Tue,  3 Jun 2025 01:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOnlFEdh0OGscX7l0ES+lXHZIhYryPoLD1a5aM71qLU=;
 b=w/l+amL4zNrF2AxxYIBzYll6Q8M8IiSInuYEPNIehRTLydYdhjj+byGUGPneJyHfw5lER1
 tPd26JWJIlcw6DPExop3XS243rDWvXp4/8qiKnYFY2D5v2NLGmDery7k6Z4vhIOeQoIGRL
 j5pc65FFNFA/pPO2Lz2WOmM4+X/OsCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOnlFEdh0OGscX7l0ES+lXHZIhYryPoLD1a5aM71qLU=;
 b=pdq3UprJJSUK4xXiXf59eY2UoyGtDjPBUBFIH3Vu9RIMi2b5mvN+uyVhd8K1YeAwe7UiJU
 EYlP/c5YpAVfxCAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOnlFEdh0OGscX7l0ES+lXHZIhYryPoLD1a5aM71qLU=;
 b=w/l+amL4zNrF2AxxYIBzYll6Q8M8IiSInuYEPNIehRTLydYdhjj+byGUGPneJyHfw5lER1
 tPd26JWJIlcw6DPExop3XS243rDWvXp4/8qiKnYFY2D5v2NLGmDery7k6Z4vhIOeQoIGRL
 j5pc65FFNFA/pPO2Lz2WOmM4+X/OsCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOnlFEdh0OGscX7l0ES+lXHZIhYryPoLD1a5aM71qLU=;
 b=pdq3UprJJSUK4xXiXf59eY2UoyGtDjPBUBFIH3Vu9RIMi2b5mvN+uyVhd8K1YeAwe7UiJU
 EYlP/c5YpAVfxCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E7B013700;
 Tue,  3 Jun 2025 01:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wLExNClSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 18/21] qapi/migration: Deprecate capabilities commands
Date: Mon,  2 Jun 2025 22:38:07 -0300
Message-Id: <20250603013810.4772-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The concept of capabilities is being merged into the concept of
parameters. From now on, the commands that handle capabilities are
deprecated in favor of the commands that handle parameters.

Affected commands:

- migrate-set-capabilities
- query-migrate-capabilities

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst      | 12 ++++++++++++
 migration/migration-hmp-cmds.c |  6 ++++++
 qapi/migration.json            | 16 ++++++++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 42037131de..15474833ea 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -605,3 +605,15 @@ command documentation for details on the ``fdset`` usage.
 
 The ``zero-blocks`` capability was part of the block migration which
 doesn't exist anymore since it was removed in QEMU v9.1.
+
+``migrate-set-capabilities`` command (since 10.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+This command was deprecated. Use ``migrate-set-parameters`` instead
+which now supports setting capabilities.
+
+``query-migrate-capabilities`` command (since 10.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+This command was deprecated. Use ``query-migrate-parameters`` instead
+which now supports querying capabilities.
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 6d8d189b81..a8c3515e9d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -229,6 +229,9 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
 {
     MigrationCapabilityStatusList *caps, *cap;
 
+    warn_report("info migrate_capabilities is deprecated;"
+                " use info migrate_parameters instead");
+
     caps = qmp_query_migrate_capabilities(NULL);
 
     if (caps) {
@@ -608,6 +611,9 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
     MigrationCapabilityStatus *value;
     int val;
 
+    warn_report("migrate_set_capability is deprecated;"
+                " use migrate_set_parameter instead");
+
     val = qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
     if (val < 0) {
         goto end;
diff --git a/qapi/migration.json b/qapi/migration.json
index 557a9c523e..7282e4b9eb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -521,6 +521,11 @@
 #
 # @capabilities: json array of capability modifications to make
 #
+# Features:
+#
+# @deprecated: This command is deprecated in favor of
+# migrate-set-parameters.
+#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -530,7 +535,8 @@
 #     <- { "return": {} }
 ##
 { 'command': 'migrate-set-capabilities',
-  'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
+  'data': { 'capabilities': ['MigrationCapabilityStatus'] },
+  'features': ['deprecated'] }
 
 ##
 # @query-migrate-capabilities:
@@ -539,6 +545,11 @@
 #
 # Returns: @MigrationCapabilityStatus
 #
+# Features:
+#
+# @deprecated: This command is deprecated in favor of
+# query-migrate-parameters.
+#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -554,7 +565,8 @@
 #           {"state": false, "capability": "x-colo"}
 #        ]}
 ##
-{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
+{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus'],
+  'features': ['deprecated'] }
 
 ##
 # @MultiFDCompression:
-- 
2.35.3


