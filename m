Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF86C624DB
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFr-0000tS-DF; Wed, 02 Sep 2026 18:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFp-0000sv-Ly
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:25 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFo-0002N9-4N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6270F1FA9A;
 Wed,  2 Sep 2026 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3OytNN0qIsfTEtxTlsxiaPkakfwsHemkEXqKysUj5M=;
 b=kAVWVdeX06OsCBg7ULhK7K397IvP361FUoWPIaRMuaH+602BHtHwMtqTdNiy45nnlM3fau
 FioHkyxXlBwFDHvsoKUeK5Rhy7bcqRXf0s8QYPu1jEDpOsdepiZUfLniWe/dJaW0R5Js+Q
 Pabfaiv/qEfm6mDpc/t17IajnSqnHXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3OytNN0qIsfTEtxTlsxiaPkakfwsHemkEXqKysUj5M=;
 b=2sADHfe4iRBHl02sLhzPx/A8b0Engnm7eafs4WYzeMorOMzgRYBO77zAP83Me6Rj/7exsE
 ck9fB8GSX8srAeAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3OytNN0qIsfTEtxTlsxiaPkakfwsHemkEXqKysUj5M=;
 b=Ss7Rx8IhVapVNNjdzhPpDNIsgj+WCMIPnNcWVe2gBP7zevgIdVz4DGOzNxHpbpDtRHUmUs
 eAJ4BKschRp1iPzI3ouxZOonIW/e/6QRLFkRmt7zmlf4CgqvxdTIZmZ4cIXus584q2naZO
 rGlDkX2ZoifCEaKMYDYocFbn6oMURmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3OytNN0qIsfTEtxTlsxiaPkakfwsHemkEXqKysUj5M=;
 b=JsGd6vUoRaiIFpCrYynsgtv9nETwBk2kN1IbSnlmnQ/t9enWa9lrJKY7yUVL6IYVzkchmC
 cSPXoMfP4HRGYJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B7C513918;
 Wed,  2 Sep 2026 22:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WKN+AyygmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH 06/18] migration: Open code migrate_params_apply
Date: Wed,  2 Sep 2026 19:15:34 -0300
Message-ID: <20260902221547.1812481-7-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Remove migrate_params_apply so the logic of setting migration
parameters is all in one spot.

Suggested-by: Prasad Pandit <ppandit@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index de091d2eee3..f7c154079bd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1386,21 +1386,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-/*
- * Caller must ensure the has_* fields of @params are true so they all
- * get copied and the pointer members don't dangle.
- */
-static void migrate_params_apply(MigrationParameters *params)
-{
-    MigrationState *s = migrate_get_current();
-    MigrationParameters *cur = &s->parameters;
-
-    migrate_tls_opts_free(cur);
-    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
-    qapi_free_strList(cur->cpr_exec_command);
-    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
-}
-
 void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
 {
     MigrationParameters *cur = &migrate_get_current()->parameters;
@@ -1423,8 +1408,15 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
         return;
     }
 
-    if (migrate_params_check(new, errp)) {
-        migrate_params_apply(new);
-        migrate_post_update_params(input, errp);
+    if (!migrate_params_check(new, errp)) {
+        return;
     }
+
+    migrate_tls_opts_free(cur);
+    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
+    qapi_free_strList(cur->cpr_exec_command);
+
+    QAPI_CLONE_MEMBERS(MigrationParameters, cur, new);
+
+    migrate_post_update_params(input, errp);
 }
-- 
2.53.0


