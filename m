Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C889CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44po-00047R-Uu; Wed, 01 Oct 2025 17:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44pj-0003sx-H2
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:58:00 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44pb-0006eK-3W
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:57:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D66AE1F813;
 Wed,  1 Oct 2025 21:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTD6IrInVswIg/acQd3QWkg+B0kPkWKv2bTYHRTXfbs=;
 b=TRoAxeUhb7sWrlvl4svHbZWzAF2UyKa4bEI+j9ybr/RqwLhulLuZJHBYR9W/316vne4NMM
 VdZxlWD/qom5mW8JC1KTbqBMyasyXNgJXs1dYvnJ9XMST8lH+aJzmgseZ7fVOIyaksHG7K
 yYHQ4Ps41IaVIYGZ1JIxItibiZjQVZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTD6IrInVswIg/acQd3QWkg+B0kPkWKv2bTYHRTXfbs=;
 b=1baBsECPttKdZ2aWFU55NrAH3JibtBJSYPRmg3+qHLPYcGXe6I02taml5LlYY6Yw8qASmy
 x2Kw35qgZMWL4uAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TRoAxeUh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1baBsECP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTD6IrInVswIg/acQd3QWkg+B0kPkWKv2bTYHRTXfbs=;
 b=TRoAxeUhb7sWrlvl4svHbZWzAF2UyKa4bEI+j9ybr/RqwLhulLuZJHBYR9W/316vne4NMM
 VdZxlWD/qom5mW8JC1KTbqBMyasyXNgJXs1dYvnJ9XMST8lH+aJzmgseZ7fVOIyaksHG7K
 yYHQ4Ps41IaVIYGZ1JIxItibiZjQVZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTD6IrInVswIg/acQd3QWkg+B0kPkWKv2bTYHRTXfbs=;
 b=1baBsECPttKdZ2aWFU55NrAH3JibtBJSYPRmg3+qHLPYcGXe6I02taml5LlYY6Yw8qASmy
 x2Kw35qgZMWL4uAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 906EA13A3F;
 Wed,  1 Oct 2025 21:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QA9bFMyi3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 11/13] migration-test: misc exports
Date: Wed,  1 Oct 2025 18:52:52 -0300
Message-Id: <20251001215254.2863-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D66AE1F813
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:dkim,suse.de:mid,suse.de:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Export misc definitions needed by the cpr-exec test.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-17-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/bootfile.c  | 5 +++++
 tests/qtest/migration/bootfile.h  | 1 +
 tests/qtest/migration/framework.c | 5 +++++
 tests/qtest/migration/framework.h | 1 +
 4 files changed, 12 insertions(+)

diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index fac059d11d..479c43231d 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -68,3 +68,8 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
 
     return bootpath;
 }
+
+char *bootfile_get(void)
+{
+    return bootpath;
+}
diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index 6d6a67386e..96e784b163 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -35,5 +35,6 @@
 
 void bootfile_delete(void);
 char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
+char *bootfile_get(void);
 
 #endif /* BOOTFILE_H */
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index d20938ccec..89c85cd314 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1007,6 +1007,11 @@ QTestMigrationState *get_src(void)
     return &src_state;
 }
 
+QTestMigrationState *get_dst(void)
+{
+    return &dst_state;
+}
+
 MigrationTestEnv *migration_get_env(void)
 {
     static MigrationTestEnv *env;
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 19d552f78a..cc0d09b6da 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -237,6 +237,7 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
 
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
+QTestMigrationState *get_dst(void);
 
 #ifdef CONFIG_GNUTLS
 void migration_test_add_tls(MigrationTestEnv *env);
-- 
2.35.3


