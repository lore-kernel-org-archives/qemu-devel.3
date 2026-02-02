Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0A0E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2bx-0007c4-4j; Mon, 02 Feb 2026 17:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bu-0007bM-VH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:34 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bt-0000r6-I8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A9485BCC3;
 Mon,  2 Feb 2026 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0Aca5JhzPeivpyWT6R9I7tKBlES4Z2z+7/wZ0kxo7E=;
 b=RmLhdx4EAcpED2NSsdP4gz7Btogywu2f3HxbPELQECeRNjDVJIyM6TRXvGhpGscAEWvecH
 8jJcJvNwrKx7h64ogYOGaCXy5/zCVahZ6T5QG8+OKFg0YgxRyz06WxplJ+dm0dlvXkVXM1
 0TvU7FEMd8X7887nwZMeqUPBhgXKxQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0Aca5JhzPeivpyWT6R9I7tKBlES4Z2z+7/wZ0kxo7E=;
 b=+K+/1mSRmR5OgrColEhPmLoeCWJdYk916yOczPUF1t4VIZYgj2z0aGye+hgGoBrxIucrNn
 O4wHD07fBz07xCDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RmLhdx4E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="+K+/1mSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0Aca5JhzPeivpyWT6R9I7tKBlES4Z2z+7/wZ0kxo7E=;
 b=RmLhdx4EAcpED2NSsdP4gz7Btogywu2f3HxbPELQECeRNjDVJIyM6TRXvGhpGscAEWvecH
 8jJcJvNwrKx7h64ogYOGaCXy5/zCVahZ6T5QG8+OKFg0YgxRyz06WxplJ+dm0dlvXkVXM1
 0TvU7FEMd8X7887nwZMeqUPBhgXKxQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0Aca5JhzPeivpyWT6R9I7tKBlES4Z2z+7/wZ0kxo7E=;
 b=+K+/1mSRmR5OgrColEhPmLoeCWJdYk916yOczPUF1t4VIZYgj2z0aGye+hgGoBrxIucrNn
 O4wHD07fBz07xCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E350B3EA62;
 Mon,  2 Feb 2026 22:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cC+DKBEogWl8XgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 22:41:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com,
	ppandit@redhat.com
Subject: [PATCH v2 8/9] migration/options: Stop freeing s->parameters members
 individually
Date: Mon,  2 Feb 2026 19:41:00 -0300
Message-ID: <20260202224101.20568-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202224101.20568-1-farosas@suse.de>
References: <20260202224101.20568-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 7A9485BCC3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Expecting every pointer member from s->parameters to be freed
individually is prone to leave some fields forgotten when the code is
eventually updated. Use a dealloc visitor to free them all at once.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 733aae51a8..cc5a66750c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1002,11 +1002,21 @@ AnnounceParameters *migrate_announce_params(void)
     return &ap;
 }
 
-static void migrate_tls_opts_free(MigrationParameters *params)
+static bool migrate_params_free(MigrationParameters *params, Error **errp)
 {
-    qapi_free_StrOrNull(params->tls_creds);
-    qapi_free_StrOrNull(params->tls_hostname);
-    qapi_free_StrOrNull(params->tls_authz);
+    Visitor *v = qapi_dealloc_visitor_new();
+    bool ret;
+
+    /*
+     * qapi_free_MigrationParameters can't be used here because
+     * MigrationParameters is embedded in MigrationState due to qdev
+     * needing to access the offset of the migration properties inside
+     * the migration object.
+     */
+    ret = visit_type_MigrationParameters_members(v, params, errp);
+    visit_free(v);
+
+    return ret;
 }
 
 /* normalize QTYPE_QNULL to QTYPE_QSTRING "" */
@@ -1290,9 +1300,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
         return;
     }
 
-    migrate_tls_opts_free(cur);
-    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
-    qapi_free_strList(cur->cpr_exec_command);
+    if (!migrate_params_free(cur, errp)) {
+        return;
+    }
 
     /* mark all present, so they're all copied */
     migrate_mark_all_params_present(tmp);
-- 
2.51.0


