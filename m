Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DBEC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GdH-0003Mp-KP; Mon, 14 Sep 2026 20:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdF-0003MQ-9n
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:41 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdC-0004nQ-D0
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0325521E1B;
 Tue, 15 Sep 2026 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=nf7wQNyq3UqBF6m9Pie/kZdfFrsyG6KlPorL/bivEKpJYc6JHKjzh8+dLSdhfMHCDFGEcR
 LEb/aV/4OE66lN6wiD6f8ojDdnj6mYdvZo93pV/3V5S7/NCKw6f2SLL+rGHvwhBpHDdk9B
 oyqqdMOUede0lR45ISx9TspQRM/MNi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=GRyOJ+wjlJHGu+vKxWsq3Y8JdolzkMtW2Abz4WeEOownJcrqKUY/w49L5t1WsH5yTZyoy4
 D7lHUEGfUyUkHXAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CZq2GGQK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4OS7TYoH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=CZq2GGQKV1vcyQwDdfrDZLJGVHGwXFAYkcZ8SCCqGUw1i3QjQ8ZiUw3+bI91B85i/afAbh
 Ufy75tKqBcreAWBRZwFf3rfkAL+BpN5kelXK/RFMsmq6mi6kNSUBnJRgCfcBUnkV1utZ+7
 9H7Vxd3tkDTRzBXr3Y1l8DktmO61f+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=4OS7TYoHUsa11P4ecXBVZmtO9bBL/yVz2VVxZFApYixsmSuk4s7+CdjqAOd4qorY0HSr2B
 4MWR/uJoYz0Z73Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE75E136D9;
 Tue, 15 Sep 2026 00:02:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T8
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 07/20] migration: Stop freeing s->parameters members
 individually
Date: Mon, 14 Sep 2026 21:01:55 -0300
Message-ID: <20260915000209.3692668-8-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0325521E1B
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
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Expecting every pointer member from s->parameters to be freed
individually is prone to leave some fields forgotten when the code is
eventually updated. Use a dealloc visitor to free them all at once.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 12f884caa4..bdcff002db 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -17,6 +17,7 @@
 #include "qapi/util.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/dealloc-visitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
@@ -1066,11 +1067,21 @@ AnnounceParameters *migrate_announce_params(void)
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
@@ -1419,9 +1430,9 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
         return;
     }
 
-    migrate_tls_opts_free(cur);
-    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
-    qapi_free_strList(cur->cpr_exec_command);
+    if (!migrate_params_free(cur, errp)) {
+        return;
+    }
 
     QAPI_CLONE_MEMBERS(MigrationParameters, cur, new);
 
-- 
2.53.0


