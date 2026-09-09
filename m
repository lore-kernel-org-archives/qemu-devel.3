Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26E2C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Q7D-0000co-3o; Wed, 09 Sep 2026 17:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q7B-0000cH-AI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:57 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q79-0005RS-PH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 743FF1FCC6;
 Wed,  9 Sep 2026 21:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaRzMp7umhOhqpj5IY2MK30mm3oEcApxL1Io5d+plmY=;
 b=j2TXwUK81VuJlrc0qmrHcbnuxUfWo6B8WURiwcTJIn1gHj43T2T0uI82wjZ5QPONbUqIGx
 dhozczCx97ka53osANiTJi7/HkTsz9EVCVxOHS3c2KG7f5OvpXohfo0yo2q13aG5UOQlYt
 T3lfp+jJjttkp+CoEtNV+4BKNzX1smQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaRzMp7umhOhqpj5IY2MK30mm3oEcApxL1Io5d+plmY=;
 b=9y9VpERuCo0bIWyNUeq5hGP50IC3s20LuL9Z8ex9cNIWFdCP3WIKUkc+7R/Qri+71YSQp7
 EsQw3WeRLfG2GICQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaRzMp7umhOhqpj5IY2MK30mm3oEcApxL1Io5d+plmY=;
 b=Dzyr9PGdsT9N2kWAR26jAMwjU/XUBLW7eY/4d48fQUy9eSu70kFb13iWwjfWL7tMtua0BH
 aJTIiUKVi+wHJwNVfohHnR0cKlg+DHCHxDXWQHKeJ8Y7ADs+7uZBAhJ3OuTsrO8bhMCkow
 fY3FUHXJCbBoIuPbDileSTBAV1hAinc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaRzMp7umhOhqpj5IY2MK30mm3oEcApxL1Io5d+plmY=;
 b=qzQCFLS1aN74HI6ot8AU4g8FWJzLvmz07XnGAhepCr6Znf7XztFbD1qr+2/nwJnHLXSOZc
 I+RA2//MlWXVVqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12CA413770;
 Wed,  9 Sep 2026 21:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0PpbM4jToWqzawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 21:45:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 15/18] migration: Rewrite migrate_set_parameter_completion
 using QDict
Date: Wed,  9 Sep 2026 18:45:05 -0300
Message-ID: <20260909214509.237309-16-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909214509.237309-1-farosas@suse.de>
References: <20260909214509.237309-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

The migrate_set_parameter_completion function is the last user of the
MigrationParameter enum. Write the code using an output visitor and
QDict instead so we can remove the enum in a future patch.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 5dfbb69390..720913255f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -736,14 +736,19 @@ void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
 void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
                                       const char *str)
 {
+    g_autoptr(QDict) d = NULL;
+    const QDictEntry *e;
     size_t len;
 
+    /* Temporarily borrow the global parameters */
+    d = migrate_params_to_dict(&migrate_get_current()->parameters,
+                               &error_abort);
     len = strlen(str);
     readline_set_completion_index(rs, len);
     if (nb_args == 2) {
-        int i;
-        for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
-            readline_add_completion_of(rs, str, MigrationParameter_str(i));
+        for (e = qdict_first(d); e; e = qdict_next(d, e)) {
+            const char *key = qdict_entry_key(e);
+            readline_add_completion_of(rs, str, key);
         }
     }
 }
-- 
2.53.0


