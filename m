Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F39C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oT2-0007BP-12; Tue, 30 Apr 2024 10:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oSy-0007Aq-9e
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oSw-0000AN-Fr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 503A81F7E3;
 Tue, 30 Apr 2024 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xeWvRrVem+NW4iFio/gVtU+erTHZISltcVItqhsXWE=;
 b=lPc6pL6FfWLlr/1bl6ZrnoXxQrGIYzev4rmIVTDjRTjNUb92vqrp6+SveDzXyA3Sgj+Pcx
 e5WTyidcWW8Jv1dVi6/hU79kaNeSEPn9TXCzv83ddGUIrOxb4sNcYoWWvf5Vov1Iyw8P1p
 7iBCkeRnh3LEfzSScRvr/zck0Lz/H+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xeWvRrVem+NW4iFio/gVtU+erTHZISltcVItqhsXWE=;
 b=OfoDaROXSQg1V3Pt4b8CqOQ125GaTE2UHofeM8zc1L5BHMZn31I1imWP54zA1sFYlJmx1a
 YFk8+QqcRCDpxSAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xeWvRrVem+NW4iFio/gVtU+erTHZISltcVItqhsXWE=;
 b=lPc6pL6FfWLlr/1bl6ZrnoXxQrGIYzev4rmIVTDjRTjNUb92vqrp6+SveDzXyA3Sgj+Pcx
 e5WTyidcWW8Jv1dVi6/hU79kaNeSEPn9TXCzv83ddGUIrOxb4sNcYoWWvf5Vov1Iyw8P1p
 7iBCkeRnh3LEfzSScRvr/zck0Lz/H+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xeWvRrVem+NW4iFio/gVtU+erTHZISltcVItqhsXWE=;
 b=OfoDaROXSQg1V3Pt4b8CqOQ125GaTE2UHofeM8zc1L5BHMZn31I1imWP54zA1sFYlJmx1a
 YFk8+QqcRCDpxSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AC08133A7;
 Tue, 30 Apr 2024 14:28:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kKClEP3/MGZjSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Apr 2024 14:28:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 1/6] migration: Remove 'skipped' field from MigrationStats
Date: Tue, 30 Apr 2024 11:27:32 -0300
Message-Id: <20240430142737.29066-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430142737.29066-1-farosas@suse.de>
References: <20240430142737.29066-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The 'skipped' field of the MigrationStats struct has been deprecated
in 8.1. Time to remove it.

Deprecation commit 7b24d32634 ("migration: skipped field is really
obsolete.").

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst       | 6 ------
 docs/about/removed-features.rst | 6 ++++++
 migration/migration-hmp-cmds.c  | 2 --
 migration/migration.c           | 2 --
 qapi/migration.json             | 8 --------
 5 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b8aafa15b..1c03a358d1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -468,12 +468,6 @@ option).
 Migration
 ---------
 
-``skipped`` MigrationStats field (since 8.1)
-''''''''''''''''''''''''''''''''''''''''''''
-
-``skipped`` field in Migration stats has been deprecated.  It hasn't
-been used for more than 10 years.
-
 ``inc`` migrate command option (since 8.2)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 53ca08aba9..c4cb2692d0 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -614,6 +614,12 @@ was superseded by ``sections``.
 Member ``section-size`` in the return value of ``query-sgx-capabilities``
 was superseded by ``sections``.
 
+``query-migrate`` return value member ``skipped`` (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
+for more than 10 years. Removed with no replacement.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e96ae6ffd..28f776d06d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -105,8 +105,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->ram->total >> 10);
         monitor_printf(mon, "duplicate: %" PRIu64 " pages\n",
                        info->ram->duplicate);
-        monitor_printf(mon, "skipped: %" PRIu64 " pages\n",
-                       info->ram->skipped);
         monitor_printf(mon, "normal: %" PRIu64 " pages\n",
                        info->ram->normal);
         monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
diff --git a/migration/migration.c b/migration/migration.c
index b5af6b5105..266652668d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1149,8 +1149,6 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->transferred = migration_transferred_bytes();
     info->ram->total = ram_bytes_total();
     info->ram->duplicate = stat64_get(&mig_stats.zero_pages);
-    /* legacy value.  It is not used anymore */
-    info->ram->skipped = 0;
     info->ram->normal = stat64_get(&mig_stats.normal_pages);
     info->ram->normal_bytes = info->ram->normal * page_size;
     info->ram->mbps = s->mbps;
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90328..401b8e24ac 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -23,9 +23,6 @@
 #
 # @duplicate: number of duplicate (zero) pages (since 1.2)
 #
-# @skipped: number of skipped zero pages.  Always zero, only provided
-#     for compatibility (since 1.5)
-#
 # @normal: number of normal pages (since 1.2)
 #
 # @normal-bytes: number of normal bytes sent (since 1.2)
@@ -63,16 +60,11 @@
 #     between 0 and @dirty-sync-count * @multifd-channels.  (since
 #     7.1)
 #
-# Features:
-#
-# @deprecated: Member @skipped is always zero since 1.5.3
-#
 # Since: 0.14
 ##
 { 'struct': 'MigrationStats',
   'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
            'duplicate': 'int',
-           'skipped': { 'type': 'int', 'features': [ 'deprecated' ] },
            'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate': 'int',
            'mbps': 'number', 'dirty-sync-count': 'int',
-- 
2.35.3


