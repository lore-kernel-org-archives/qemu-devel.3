Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC57C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82e-0006o0-Qa; Fri, 25 Sep 2026 11:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82b-0006ma-G6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82Z-0004dw-E0
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B9E1521FBE;
 Fri, 25 Sep 2026 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=FaqsKy/9FiwEEXDeMitizaRgLa7sUrgvmFifXUVPUy1uK4YB58pDmhCvCZgFMh0Wmfabuj
 qhaF0NF6jNW8GM5+uREGbyygJLLcoCr73AvqVUT9xV/gNOwYXH8gvpdPtNPIUh+OmfEE9l
 8cP5QdDI+Ez87imManl9viqGHkK666k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=OQfs7VhwP/cwvDT0nCQfRlcl5kQx6iTnMYvLC8JLnZC44iYGhOtlH2XB36ZzqrH0kOGwGu
 A9V0eWSc4jMfbyDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=W+6mt2ydGk9g9xZEx00KuxOoBqRaQNO4hVqhDvzh4qzp2w2c6HoD4OVbtjfpYSHnc9EaVT
 l8O3BnhvbVK6vhX1cpaOJDueCkaDykfVJVkStt9WNti+YhhjG6QCzfGsTSpLEDTSjzDazP
 EQm75iSnUPJtiCl9JeWlHiCbtPxbyo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hTM0ZCY7OaihXhzw/hVe+idx+ErDM+z3nHvYLW4FaQ=;
 b=mbY7Gi/vWSXsBoSGZnny+8xSIZxhMuU4onzzGKDHVYhhUI8i6twg/Q0WmV/5MneIOkH5zr
 rfxTzQWtXmd61tAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D051A13310;
 Fri, 25 Sep 2026 15:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T18
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 17/19] migration: Stop freeing s->parameters members
 individually
Date: Fri, 25 Sep 2026 12:40:08 -0300
Message-ID: <20260925154010.599247-18-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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


