Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DFEC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tG2-0000xm-5i; Wed, 02 Sep 2026 18:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tG0-0000xI-Pv
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFy-0002Ox-Ur
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85CFB1F8D6;
 Wed,  2 Sep 2026 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvOieIH2FqGnbBgCg99F3RW0hBUBq/tNxTru6TqDqy4=;
 b=hCHy6zu5jFuCKkumvp6OzApT2iizVTepo/Bgd+6+ki1xr9lX3C8td6xnQcQi+j8fu9aD/7
 dWJKs4vdLZCpaoArdMlQatBful4khCiyKE9UlG7qHg0hqsCyXv67vOPw9NT2Ws3QCjpzoF
 GKvOjt5XTDJhG+7mEsoqs4i75fo9cmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvOieIH2FqGnbBgCg99F3RW0hBUBq/tNxTru6TqDqy4=;
 b=U5+OkLGyNZoaeQ7UMwL9TVrIRWwT9VJzRl/rx+khLK3OCtER+G0Rk/23ErR6Ln63vzOOO9
 UH6M0kWmX2LwbzAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xaW/rtiv";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6l0NUAFn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvOieIH2FqGnbBgCg99F3RW0hBUBq/tNxTru6TqDqy4=;
 b=xaW/rtiv1qi0ElsKJTQjnhI4Jhj/vg4VJYImUq1WQqnTIUqm0tCNhXeBw2qo6RnNLSFUip
 ImEjmStphQnQj6fO30Ua2sRn//tDqqGV5vzQGicdUVPcExXzEewniuFuHeSsmlWlV89ARK
 DWIqncmi3i5jNQIq7/LgfQQq7bpJb78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvOieIH2FqGnbBgCg99F3RW0hBUBq/tNxTru6TqDqy4=;
 b=6l0NUAFn8C6i6w+bkgvvq+bCwxCXSmpix9XLaCKzcdRa4ReS1ZzA2kk/1b5Jg8xQVD3j0f
 uXq1FR6e0U9nuzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FBDA13515;
 Wed,  2 Sep 2026 22:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GGV6CDigmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 15/18] qapi/migration: Remove MigrationParameter
Date: Wed,  2 Sep 2026 19:15:43 -0300
Message-ID: <20260902221547.1812481-16-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 85CFB1F8D6
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

This enum is convenient in two ways (just how enums work):

1- It provides the number of migration parameters as its __MAX member.

2- It allows iterating over an integer range and get a migration
   parameter name string corresponding to that position in the enum.

The migration code doesn't have the need for (2) anymore.

Balancing the benefit of (1) versus the disadvantage of requiring
migration.json to be updated in two different places whenever a
parameter is added, experience shows that the latter churn is enough
to decide to remove the enum.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c |  6 +-----
 qapi/migration.json | 36 ------------------------------------
 2 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 5d17acdd881..f988b181f0e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1127,7 +1127,6 @@ static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
  */
 static void migrate_mark_all_params_present(MigrationParameters *p)
 {
-    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
     bool *has_fields[] = {
         &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
         &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
@@ -1144,10 +1143,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
     };
 
-    len = ARRAY_SIZE(has_fields);
-    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
-
-    for (int i = 0; i < len; i++) {
+    for (int i = 0; i < ARRAY_SIZE(has_fields); i++) {
         *has_fields[i] = true;
     }
 }
diff --git a/qapi/migration.json b/qapi/migration.json
index b1eaf7b0545..78c6e933cf1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -796,42 +796,6 @@
       'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
   } }
 
-##
-# @MigrationParameter:
-#
-# Migration parameters enumeration.  The enumeration values mirror the
-# members of @MigrationParameters.
-#
-# Features:
-#
-# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-#     @x-vcpu-dirty-limit-period are experimental.
-#
-# Since: 2.4
-##
-{ 'enum': 'MigrationParameter',
-  'data': ['announce-initial', 'announce-max',
-           'announce-rounds', 'announce-step',
-           'throttle-trigger-threshold',
-           'cpu-throttle-initial', 'cpu-throttle-increment',
-           'cpu-throttle-tailslow',
-           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
-           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
-           'multifd-channels',
-           'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level', 'multifd-zstd-level',
-           'multifd-qatzip-level',
-           'block-bitmap-mapping',
-           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
-           'vcpu-dirty-limit',
-           'mode',
-           'zero-page-detection',
-           'direct-io',
-           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
-           'cpr-exec-command'] }
-
 ##
 # @migrate-set-parameters:
 #
-- 
2.53.0


