Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C91C624D7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFp-0000si-5B; Wed, 02 Sep 2026 18:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFm-0000rT-OE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:22 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFj-0002MR-S5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:22 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 902C71F8D6;
 Wed,  2 Sep 2026 22:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7tPatPQuvMWp3JNW+Ezh3UH4BRhZlwseZ8/UCcImzw=;
 b=jr3Uwuo9+Fr/2ojDSwRxtJE6rnbfAHeyfTIeizA9CBf1lCQ1QphRysRm6Y9LNIB22BfPO8
 apJE3ln4k8Pxhvj6Q6Wtsufed5xe0BD5CTyY6sT/+21Kz3+FOell9Oy1oCDFNDouGppyii
 UDSBVysSQ/MTFYbpnxd2gMSpCseWxvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7tPatPQuvMWp3JNW+Ezh3UH4BRhZlwseZ8/UCcImzw=;
 b=P54MAn5l+Afa5tJx8AZuloSWh+9v+/NRFR9sSKlC17B+XSNoULtPkT4O6zYUQyxIYNZkds
 GhYVAFMa0xUIAqCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7tPatPQuvMWp3JNW+Ezh3UH4BRhZlwseZ8/UCcImzw=;
 b=wlQLraxOU0czanQFTWJsoxTe9bGYOx7suwL+clXaOlOSJ/0rFCfsYTODuvUpADBIhKIg5t
 GFLFwIjr31aDmoHqrQqXDsdO4Q2jtW2ZLtZyWV4BPp7Pu090u83i/6DVv+Wpq6F5ISH2f7
 +8sxVPWMnMbfI7IkXDqG4909EIPwVoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7tPatPQuvMWp3JNW+Ezh3UH4BRhZlwseZ8/UCcImzw=;
 b=uxZ/QKjGV0T3YAYMRwjv1I3jMlHcF88fIuEMc0XqeJ1yAa2Pdpeyo3T3hysuM+K2Oscy8T
 B/sfTw8nal8Wf8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90F7113869;
 Wed,  2 Sep 2026 22:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0ORaGCigmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 03/18] migration: Rename variables in
 qmp_migrate_set_parameters
Date: Wed,  2 Sep 2026 19:15:31 -0300
Message-ID: <20260902221547.1812481-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Give the variables in qmp_migrate_set_parameters more semantic
names.

s/params/input/
this is the user input from qapi

s/tmp/new/
this is the combination of the current parameters and the input

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 79a61ac60d6..388cb07dd0f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1583,9 +1583,9 @@ static void migrate_params_apply(MigrationParameters *params)
     }
 }
 
-void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
+void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
 {
-    MigrationParameters tmp;
+    MigrationParameters new;
 
     /*
      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
@@ -1595,18 +1595,18 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
      * the options to the rest of the migration code already use
      * return NULL when the empty string is found.
      */
-    tls_opt_to_str(params->tls_creds);
-    tls_opt_to_str(params->tls_hostname);
-    tls_opt_to_str(params->tls_authz);
+    tls_opt_to_str(input->tls_creds);
+    tls_opt_to_str(input->tls_hostname);
+    tls_opt_to_str(input->tls_authz);
 
-    migrate_params_test_apply(params, &tmp);
+    migrate_params_test_apply(input, &new);
 
-    if (migrate_params_check(&tmp, errp)) {
-        migrate_params_apply(params);
-        migrate_post_update_params(params, errp);
+    if (migrate_params_check(&new, errp)) {
+        migrate_params_apply(input);
+        migrate_post_update_params(input, errp);
     }
 
-    migrate_tls_opts_free(&tmp);
-    qapi_free_BitmapMigrationNodeAliasList(tmp.block_bitmap_mapping);
-    qapi_free_strList(tmp.cpr_exec_command);
+    migrate_tls_opts_free(&new);
+    qapi_free_BitmapMigrationNodeAliasList(new.block_bitmap_mapping);
+    qapi_free_strList(new.cpr_exec_command);
 }
-- 
2.53.0


