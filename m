Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A753FC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tG1-0000xQ-0l; Wed, 02 Sep 2026 18:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFy-0000wO-TX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:34 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFx-0002On-DD
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05A0C1F8C1;
 Wed,  2 Sep 2026 22:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxsVlcQ9sD392huGe4djQLqhh3SePbOim0/nA4pkSic=;
 b=TY/vB23+Rv5j/QrmgucW6SGMyPQ/2cReir7ME1Qtx9mHUhBDvskedeWm/yn9FEjQR66PEX
 8CnZt/4x1TQkGdS+EEMkl3KXUMMhypw0/k7WtSkjcwBPUQvh+qmqh7yKfFTbBDP2EwO0mm
 VqRXBXZUM1eBe1VfF33iBTGewS9yIyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxsVlcQ9sD392huGe4djQLqhh3SePbOim0/nA4pkSic=;
 b=tPexCqb16EKnArNuGw2YbJKK3GDYPy9YR547RFPcfEvSeiv0IwNFXPnRUe8qj5Xmtgh4L5
 GezcOtoNSG0JxVAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hYCr9ppt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H8YZCTi8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxsVlcQ9sD392huGe4djQLqhh3SePbOim0/nA4pkSic=;
 b=hYCr9ppt7RtJzY+H8JoUb6J9x+Hx/czW4RLvcv2zF29jcYlwjymYaAl8X1WCBIkCebDaEM
 gjHTpmHyleV6kQ2ZQmI27b02lNuaEteSHDfThvLzRpzU+RGR/J0EfB3aMnBCVmuwC/i4KL
 zGi47Aj6vON8dEahaKwSl0HML6VMYYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxsVlcQ9sD392huGe4djQLqhh3SePbOim0/nA4pkSic=;
 b=H8YZCTi8fJ/AjV9m9/+idyjg7L5i8d4I/5pztEJBU5bs9PHBHxe3fYaxNtDCpJ+fcHfyuE
 u0AaR9Phvf8QpRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28FD213888;
 Wed,  2 Sep 2026 22:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDaaOjagmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 14/18] migration: Rewrite migrate_set_parameter_completion
 using QDict
Date: Wed,  2 Sep 2026 19:15:42 -0300
Message-ID: <20260902221547.1812481-15-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 05A0C1F8C1
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
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

The migrate_set_parameter_completion function is the last user of the
MigrationParameter enum. Write the code using an output visitor and
QDict instead so we can remove the enum in a future patch.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index dff69650a0c..d0adda25090 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -791,14 +791,19 @@ void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
 void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
                                       const char *str)
 {
+    g_autoptr(MigrationParameters) params = g_new0(MigrationParameters, 1);
+    g_autoptr(QDict) d = migrate_params_to_dict(params, NULL);
+    const QDictEntry *e;
     size_t len;
 
     len = strlen(str);
     readline_set_completion_index(rs, len);
     if (nb_args == 2) {
-        int i;
-        for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
-            readline_add_completion_of(rs, str, MigrationParameter_str(i));
+        for (e = qdict_first(d); e; e = qdict_next(d, e)) {
+            const char *key = qdict_entry_key(e);
+            if (!g_str_has_prefix(key, "has-")) {
+                readline_add_completion_of(rs, str, key);
+            }
         }
     }
 }
-- 
2.53.0


