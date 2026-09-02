Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E0C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tG7-0000z7-Fr; Wed, 02 Sep 2026 18:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tG5-0000yX-JZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:41 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tG3-0002PU-Rl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C1BA1F8B0;
 Wed,  2 Sep 2026 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAv6LkJHJx033JkMMqCstqmpybVhPzeKa8QpAH7d8gg=;
 b=QOAXu7wIy6MQTEwnNIQlcORw5m2Nazmbi7AWOmKvd9Jmdb2Eol9r3MzRdqG0zq5CuDTBjo
 40CSCSywNPLeE7dDR9t3kiDE9AagrC37AFF2rjLzE6de/tfcVFZUxF+pmpFIYXucnGjNl8
 IA/Uwe5FZrAlQdK+xzOEIp5ybOMRElg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAv6LkJHJx033JkMMqCstqmpybVhPzeKa8QpAH7d8gg=;
 b=P39HbhFhH2SKzhgnbmk6XF5SK9OwXpXbTYGsEQh4Qlo0UJgRRidDLcNujmVpDGvna2dd/p
 zeH9468KGlVSZ0Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAv6LkJHJx033JkMMqCstqmpybVhPzeKa8QpAH7d8gg=;
 b=TFX+qD5X//xOnoxAh/rjsArYkzgqyIolX3isbM2z8ZqtdA13ZQhcKjRmFcEAvYo+FpIJW/
 7sCj9bSBBn9nSfOArkOeo98QCO1sVyyPbxLffjS/o+09palThejj/wKIRgLQtaT8G4b6lG
 yN+V5mVaAbczZe5LS93m3ZPtpJj36M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAv6LkJHJx033JkMMqCstqmpybVhPzeKa8QpAH7d8gg=;
 b=BxOaIJkumjpP+hxv7E4bxsq3kUdh6SNrPIEXvD8rxL/wb6FtDGMs+95UGwBY1kYgPhVGsz
 1dfMewo9ZS9go9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2879613869;
 Wed,  2 Sep 2026 22:16:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cI+EOjygmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 18/18] qapi/migration: Deprecate capabilities commands
Date: Wed,  2 Sep 2026 19:15:46 -0300
Message-ID: <20260902221547.1812481-19-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

The concept of capabilities is being merged into the concept of
parameters. From now on, the commands that handle capabilities are
deprecated in favor of the commands that handle parameters.

Affected commands:

- migrate-set-capabilities
- query-migrate-capabilities

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst      | 13 +++++++++++++
 migration/migration-hmp-cmds.c |  6 ++++++
 qapi/migration.json            | 16 ++++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 05e4ce8cf16..a28211a98b7 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -477,3 +477,16 @@ If the user requests a modern x86 CPU model (i.e. not one of ``486``,
 ``athlon``, ``kvm32``, ``pentium``, ``pentium2``, ``pentium3``or ``qemu32``)
 a warning will be displayed until a future QEMU version when such CPUs will
 be rejected.
+
+Migration
+---------
+
+``migrate-set-capabilities`` command (since 11.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``migrate-set-parameters`` instead.
+
+``query-migrate-capabilities`` command (since 11.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``query-migrate-parameters`` instead.
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index d0adda25090..d7a8902da01 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -308,6 +308,9 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
 {
     MigrationCapabilityStatusList *caps, *cap;
 
+    warn_report("info migrate_capabilities is deprecated;"
+                " use info migrate_parameters instead");
+
     caps = qmp_query_migrate_capabilities(NULL);
 
     if (caps) {
@@ -542,6 +545,9 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
     MigrationCapabilityStatus *value;
     int val;
 
+    warn_report("migrate_set_capability is deprecated;"
+                " use migrate_set_parameter instead");
+
     val = qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
     if (val < 0) {
         goto end;
diff --git a/qapi/migration.json b/qapi/migration.json
index 7952ef44db9..19fcc7e6072 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -564,6 +564,11 @@
 #
 # @capabilities: json array of capability modifications to make
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use migrate-set-parameters
+# instead.
+#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -573,13 +578,19 @@
 #     <- { "return": {} }
 ##
 { 'command': 'migrate-set-capabilities',
-  'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
+  'data': { 'capabilities': ['MigrationCapabilityStatus'] },
+  'features': ['deprecated'] }
 
 ##
 # @query-migrate-capabilities:
 #
 # Return information about the current migration capabilities status
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use
+# query-migrate-parameters instead.
+#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -594,7 +605,8 @@
 #           {"state": false, "capability": "x-colo"}
 #        ]}
 ##
-{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
+{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus'],
+  'features': ['deprecated'] }
 
 ##
 # @MultiFDCompression:
-- 
2.53.0


