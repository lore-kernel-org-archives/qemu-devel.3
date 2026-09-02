Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E358CC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFt-0000u7-6v; Wed, 02 Sep 2026 18:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFq-0000tH-VT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFo-0002NK-W5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8818E1FAA0;
 Wed,  2 Sep 2026 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rGk1nT0vkk2bDXEEWz1WOpRQavZ9e8ic5mdHS6qWjA=;
 b=00ufZaTxakvRaCrPYnHEx66kMmg7wVWmBRSP+v8rI1WNETjvk1z6kK5101KYvruU+ayXHY
 j0iUCJ7V1lXZaHUKD5S+HlYeEXBTYS3Yn6GLYlGPq/Hn2bF5nWCeOV61yW1KpitBeBK+J5
 QDEc8Kg6MRp56NCGW8f2/LMGJU8F/PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rGk1nT0vkk2bDXEEWz1WOpRQavZ9e8ic5mdHS6qWjA=;
 b=7dEO2cdR2KLb8h6srdbZOEG4mEi5nykxlmvUgq4NFLh1cG6ogALzgypSTm3UHKt7MOZ3vW
 wC0mhwMAg79rUSDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mSwedDFr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+DxNBwbK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rGk1nT0vkk2bDXEEWz1WOpRQavZ9e8ic5mdHS6qWjA=;
 b=mSwedDFreCZpDP4TNwoWUZrmPRMajLcJSpQymLHkz5uM+8qyRRl+J8gI4Qgsk7oH5ydtwP
 QbA3giPAW3pAnezQew6IdFn1g35m6+UwLWRIF9NBV+U8/pFN33i91h9WxrJuZmul48/dEP
 wbdrBa4+il720p20SA8KCuXcw54Tj0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rGk1nT0vkk2bDXEEWz1WOpRQavZ9e8ic5mdHS6qWjA=;
 b=+DxNBwbKhQM/gb3s6TblDpTmunjZpHO3omaiNLa9utr36VGWdoB3HE5JXP/rHu0zwhTPWN
 C6iXH2GXdDcXRoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DC1D1393C;
 Wed,  2 Sep 2026 22:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cIybFy2gmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 07/18] migration: Stop freeing s->parameters members
 individually
Date: Wed,  2 Sep 2026 19:15:35 -0300
Message-ID: <20260902221547.1812481-8-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8818E1FAA0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
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

Expecting every pointer member from s->parameters to be freed
individually is prone to leave some fields forgotten when the code is
eventually updated. Use a dealloc visitor to free them all at once.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index f7c154079bd..6d7ef2df986 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -16,6 +16,7 @@
 #include "qemu/units.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/dealloc-visitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
@@ -1058,11 +1059,21 @@ AnnounceParameters *migrate_announce_params(void)
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
@@ -1412,9 +1423,9 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
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


