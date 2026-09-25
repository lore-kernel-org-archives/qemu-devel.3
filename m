Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7F9C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82X-0006l1-J1; Fri, 25 Sep 2026 11:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82V-0006k7-Pn
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:44 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82U-0004d4-9l
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBDF21FF6D;
 Fri, 25 Sep 2026 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64Xq9U2HGefS91lpIZP3cCz+meKL3Vo4eC1IGiTJXI8=;
 b=0UI23bxF23XOHdTu0ZF7D+BOWDttX3WJhoUNhpkFkwJyAJe1ywqWuG6umNJkflSucSqSc3
 2FHFeukMA1R7nibxNlH6137JMWdhlzdshAd85wqo9/zCQUujWyWKDyCojpSiTzTxm1AP7R
 ROj3rHpoCLfIhntg83lOj8opdnZj7+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64Xq9U2HGefS91lpIZP3cCz+meKL3Vo4eC1IGiTJXI8=;
 b=ZTXb7uL9J/U6iO5pq1u//HpjcR12cRj+aYELbLU43J6QCZME+MuaoBWU0F2876cpbNoaqg
 M/42t3tbuOIeONAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="IP/MBTE+";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wfY9dBbe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64Xq9U2HGefS91lpIZP3cCz+meKL3Vo4eC1IGiTJXI8=;
 b=IP/MBTE+k8maFwcPvpV7WmQXqkkBcmzJwM4jxNHwle/jD3H+m5gMSkatIbnDv3Xz0kaOB9
 a3faacR4r+zI9GXOepXE/bBSqo11iCspiI1Besmq3sLLydxweFd7ZLPjoY+Nhb9agU2T2s
 /NaI50wXlFiwoWlNBZE8C/kCPaGZacg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64Xq9U2HGefS91lpIZP3cCz+meKL3Vo4eC1IGiTJXI8=;
 b=wfY9dBbedKWrVdlKxhNs0AmzXNhRHXJNpfzmbCDvL6j8Xa/pNkPsam/Tn1Us0UxKrD7rzq
 wo1Vxk5N5a9fI6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11CB41333E;
 Fri, 25 Sep 2026 15:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T14
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 13/19] migration: Rename variables in qmp_migrate_set_parameters
Date: Fri, 25 Sep 2026 12:40:04 -0300
Message-ID: <20260925154010.599247-14-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EBDF21FF6D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index f4bba8ca26..3ce15497f8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1599,9 +1599,9 @@ static void migrate_params_apply(MigrationParameters *params)
     }
 }
 
-void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
+void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
 {
-    MigrationParameters tmp;
+    MigrationParameters new;
 
     /*
      * Convert QTYPE_QNULL and NULL to the empty string (""). Even
@@ -1611,18 +1611,18 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
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


