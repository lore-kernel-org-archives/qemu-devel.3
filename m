Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D997CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44pt-0004IO-DB; Wed, 01 Oct 2025 17:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44pn-00041q-O4
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:58:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44ph-0006gR-8E
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:58:03 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5362F33782;
 Wed,  1 Oct 2025 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFAkAmJ1LMMnRGo0ojzgq/0tPk7u2Ujbw57PT17rmis=;
 b=Rosj84H9bMcidhCxV9lGzodce88sGUNw8WBhaxA/DmKXpDKmRSPNwZlWxOObHqVFINDXlX
 jCDxEEcg/ZkBCpl8uIyW7EvsKbhCsTgfc02t0Z1lF70XPynwlENBh2sH46dXWxlx0UEZg2
 3yowzdbMSaYPj7wmYmSoGYM79HFCne0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFAkAmJ1LMMnRGo0ojzgq/0tPk7u2Ujbw57PT17rmis=;
 b=TawLZBfKPIybBDelih1lNPWhqtU3D9VAFB0caygNRbaq4AH3mFAMnk63BMQZsjzgvxYju0
 86Ti83nWwF2VfIBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFAkAmJ1LMMnRGo0ojzgq/0tPk7u2Ujbw57PT17rmis=;
 b=mUQNS2xVghwtOiv1u8OiQHMYcGG9a+DCeyyBv+G0FCa2h1m2U8TAmkYXkaCU6ive9UgoGR
 QRaiq1cg9El6tTXVbLj+Fz6XdRAMgyi4RN/WbjB+fbsltrCImNZitbzjQ93G8+7d4u1qoq
 CMMmmloOUL8Wv0G1t20YWCetyGam8+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFAkAmJ1LMMnRGo0ojzgq/0tPk7u2Ujbw57PT17rmis=;
 b=0FqOObv27heLeb4bn79whKVAyhWW724MlH03AiHayqAJs8SXJacMyEYWY2PgAsgc0Q946+
 Ovaeiat8U+kQzqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E70413A3F;
 Wed,  1 Oct 2025 21:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GORaMMii3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 09/13] migration-test: only_source option
Date: Wed,  1 Oct 2025 18:52:50 -0300
Message-Id: <20251001215254.2863-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,oracle.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Steve Sistare <steven.sistare@oracle.com>

Add the only_source option, analogous to only_target.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-15-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 24 +++++++++++++++---------
 tests/qtest/migration/framework.h |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a044b35465..2c13fd1688 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -234,7 +234,7 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
      * to mimic as closer as that.
      */
     migrate_set_capability(from, "events", true);
-    if (!args->defer_target_connect) {
+    if (!args->defer_target_connect && to) {
         migrate_set_capability(to, "events", true);
     }
 
@@ -246,8 +246,10 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
     if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
         migrate_set_parameter_int(from, "multifd-channels",
                                   MULTIFD_TEST_CHANNELS);
-        migrate_set_parameter_int(to, "multifd-channels",
-                                  MULTIFD_TEST_CHANNELS);
+        if (to) {
+            migrate_set_parameter_int(to, "multifd-channels",
+                                      MULTIFD_TEST_CHANNELS);
+        }
     }
 
     return;
@@ -410,11 +412,13 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
-                         !args->defer_target_connect);
-    qtest_qmp_set_event_callback(*to,
-                                 migrate_watch_for_events,
-                                 &dst_state);
+    if (!args->only_source) {
+        *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
+                             !args->defer_target_connect);
+        qtest_qmp_set_event_callback(*to,
+                                     migrate_watch_for_events,
+                                     &dst_state);
+    }
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
@@ -424,7 +428,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         unlink(shmem_path);
     }
 
-    migrate_start_set_capabilities(*from, *to, args);
+    migrate_start_set_capabilities(*from,
+                                   args->only_source ? NULL : *to,
+                                   args);
 
     return 0;
 }
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 744040d53a..19d552f78a 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -103,6 +103,8 @@ typedef struct {
      */
     bool hide_stderr;
     bool use_shmem;
+    /* only launch the source process */
+    bool only_source;
     /* only launch the target process */
     bool only_target;
     /* Use dirty ring if true; dirty logging otherwise */
-- 
2.35.3


