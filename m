Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA570C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKg4-0004qp-Lh; Mon, 30 Jun 2025 16:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKg2-0004kE-R5
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:30 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKg0-0007l3-Rk
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5601121162;
 Mon, 30 Jun 2025 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJJsmpW1sZIFywpnT0/jHjGMLIPBN6TL6FzL6t1T5Bo=;
 b=ei2Z56aA781IEohqSXqpVFyhtor4HOteFeIOATMHMn435LfLp9KKXt4CFiBYP7BS2bjzD5
 6Xr7qJxwJZVyQwIG73NaS4sM6FLo+w2mLwOLpQOZAJAmOtFtXXTt37ZBmoIL1Rs4GfmPof
 u1j/smJncwwjmFgY3Aladw6ss14eBdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJJsmpW1sZIFywpnT0/jHjGMLIPBN6TL6FzL6t1T5Bo=;
 b=dgK+D/yFREuBwLfFxJvGZGy7E3KlYiDW1qsLYj+zXiwJ0p1m5OHpoLAdHxiQAK8LVvbDX3
 XdmnBqf3ATt416Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ei2Z56aA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="dgK+D/yF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJJsmpW1sZIFywpnT0/jHjGMLIPBN6TL6FzL6t1T5Bo=;
 b=ei2Z56aA781IEohqSXqpVFyhtor4HOteFeIOATMHMn435LfLp9KKXt4CFiBYP7BS2bjzD5
 6Xr7qJxwJZVyQwIG73NaS4sM6FLo+w2mLwOLpQOZAJAmOtFtXXTt37ZBmoIL1Rs4GfmPof
 u1j/smJncwwjmFgY3Aladw6ss14eBdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJJsmpW1sZIFywpnT0/jHjGMLIPBN6TL6FzL6t1T5Bo=;
 b=dgK+D/yFREuBwLfFxJvGZGy7E3KlYiDW1qsLYj+zXiwJ0p1m5OHpoLAdHxiQAK8LVvbDX3
 XdmnBqf3ATt416Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F4901399F;
 Mon, 30 Jun 2025 19:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJ6WALvsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 devel@lists.libvirt.org, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 18/24] qapi/migration: Deprecate capabilities commands
Date: Mon, 30 Jun 2025 16:59:07 -0300
Message-Id: <20250630195913.28033-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 5601121162
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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
index 8615340a6b..7f234d5aa8 100644
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
@@ -616,6 +619,9 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
     MigrationCapabilityStatus *value;
     int val;
 
+    warn_report("migrate_set_capability is deprecated;"
+                " use migrate_set_parameter instead");
+
     val = qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
     if (val < 0) {
         goto end;
diff --git a/qapi/migration.json b/qapi/migration.json
index 3d3f5624c5..c5e6ea1a2d 100644
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


