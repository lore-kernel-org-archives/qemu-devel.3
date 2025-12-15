Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79C6D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGeK-0004tl-Gy; Mon, 15 Dec 2025 17:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGe9-0004cG-84
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:25 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGe5-0002rL-Qr
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:24 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EDE85BDF9;
 Mon, 15 Dec 2025 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuhQx5/pDZGDURCayIe/N6ZNncQIvyQGjL2IIkfbcH0=;
 b=O62IW4KPr/+zeCHRuzGx8UmpkqheXbKyAX5DqLCwcgxnArSW+8yT1jsuB4i7tjC5IwuP+e
 a3MA5SwcMorIoZybNzE7td4HK1yy3rjug0iU4PVZuQOx1jHvDHlr04VS2xX9IxsA4Xwdyh
 o76SgX6UVjbDpZ0RltLvfXgTo+LmrwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuhQx5/pDZGDURCayIe/N6ZNncQIvyQGjL2IIkfbcH0=;
 b=8RPDqKAU0jIYAN3DhcNe4HtRp+jlhGZ9IKn8DjdlH+PiL36tU3lmzlu3FXoTU1Fjsyo27K
 pMpjJXt6jgD9C7DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuhQx5/pDZGDURCayIe/N6ZNncQIvyQGjL2IIkfbcH0=;
 b=O62IW4KPr/+zeCHRuzGx8UmpkqheXbKyAX5DqLCwcgxnArSW+8yT1jsuB4i7tjC5IwuP+e
 a3MA5SwcMorIoZybNzE7td4HK1yy3rjug0iU4PVZuQOx1jHvDHlr04VS2xX9IxsA4Xwdyh
 o76SgX6UVjbDpZ0RltLvfXgTo+LmrwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuhQx5/pDZGDURCayIe/N6ZNncQIvyQGjL2IIkfbcH0=;
 b=8RPDqKAU0jIYAN3DhcNe4HtRp+jlhGZ9IKn8DjdlH+PiL36tU3lmzlu3FXoTU1Fjsyo27K
 pMpjJXt6jgD9C7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C2BD3EA63;
 Mon, 15 Dec 2025 22:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qEPHM0OFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 devel@lists.libvirt.org, Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 21/51] qapi/migration: Deprecate capabilities commands
Date: Mon, 15 Dec 2025 19:00:07 -0300
Message-ID: <20251215220041.12657-22-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.988];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst      | 10 ++++++++++
 migration/migration-hmp-cmds.c |  6 ++++++
 qapi/migration.json            | 16 ++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ac31a2bce4..1949508efa 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -588,3 +588,13 @@ command documentation for details on the ``fdset`` usage.
 
 The ``zero-blocks`` capability was part of the block migration which
 doesn't exist anymore since it was removed in QEMU v9.1.
+
+``migrate-set-capabilities`` command (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``migrate-set-parameters`` instead.
+
+``query-migrate-capabilities`` command (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``query-migrate-parameters`` instead.
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 28b48c34bf..7e5ac57da5 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -298,6 +298,9 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
 {
     MigrationCapabilityStatusList *caps, *cap;
 
+    warn_report("info migrate_capabilities is deprecated;"
+                " use info migrate_parameters instead");
+
     caps = qmp_query_migrate_capabilities(NULL);
 
     if (caps) {
@@ -705,6 +708,9 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
     MigrationCapabilityStatus *value;
     int val;
 
+    warn_report("migrate_set_capability is deprecated;"
+                " use migrate_set_parameter instead");
+
     val = qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
     if (val < 0) {
         goto end;
diff --git a/qapi/migration.json b/qapi/migration.json
index fcbb699a47..76a1e03f2f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -570,6 +570,11 @@
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
@@ -579,13 +584,19 @@
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
@@ -601,7 +612,8 @@
 #           {"state": false, "capability": "x-colo"}
 #        ]}
 ##
-{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
+{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus'],
+  'features': ['deprecated'] }
 
 ##
 # @MultiFDCompression:
-- 
2.51.0


