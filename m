Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC71DCD4849
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNP-0004JL-Bs; Wed, 04 Sep 2024 08:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNL-00045r-8Z
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNJ-0005Vc-Ld
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 456692191F;
 Wed,  4 Sep 2024 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBCOf/JUetC7ZUytRZGZMdkk3yEjJLBkIUqiPgUQdVY=;
 b=ITlBQOMmQzY+C+7L5D4BTNfGCQ08+MEmTt+Qr5dSSrlSa3wk3AW42TF6MquuxxAEEiff8K
 JQNxDX4kJI41NZ3fPpgGuExEfPfdK4Yetskq43ZDGIoaIKpu/sv6AJNIu7EQiuL7Da0bqx
 jMRonMWmaQzNR3NengHTAlVF0V3+2Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBCOf/JUetC7ZUytRZGZMdkk3yEjJLBkIUqiPgUQdVY=;
 b=b+V6By0CsCcwmQ9BzGUYlzYJGZm2T4k3xr9aS1C6v4eeS7UTN02T/pCTDx4vGObPqkl1K4
 Ky2QT+ZMyJtrNtDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBCOf/JUetC7ZUytRZGZMdkk3yEjJLBkIUqiPgUQdVY=;
 b=ITlBQOMmQzY+C+7L5D4BTNfGCQ08+MEmTt+Qr5dSSrlSa3wk3AW42TF6MquuxxAEEiff8K
 JQNxDX4kJI41NZ3fPpgGuExEfPfdK4Yetskq43ZDGIoaIKpu/sv6AJNIu7EQiuL7Da0bqx
 jMRonMWmaQzNR3NengHTAlVF0V3+2Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBCOf/JUetC7ZUytRZGZMdkk3yEjJLBkIUqiPgUQdVY=;
 b=b+V6By0CsCcwmQ9BzGUYlzYJGZm2T4k3xr9aS1C6v4eeS7UTN02T/pCTDx4vGObPqkl1K4
 Ky2QT+ZMyJtrNtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6ACC139D2;
 Wed,  4 Sep 2024 12:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gIjaJjVW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/34] tests/qtest/migration-test: Don't strdup in
 get_dirty_rate()
Date: Wed,  4 Sep 2024 09:43:53 -0300
Message-Id: <20240904124417.14565-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.925];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

We g_strdup() the "status" string we get out of the qdict in
get_dirty_rate(), but we never free it.  Since we only use this
string while the dictionary is still valid, we don't need to strdup
at all; drop the unnecessary call to avoid this leak:

Direct leak of 18 byte(s) in 2 object(s) allocated from:
    #0 0x564b3e01913e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: d6403a811332fcc846f93c45e23abfd06d1e67c4)
    #1 0x7f2f278ff738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7f2f27914583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x564b3e14bb5b in get_dirty_rate tests/qtest/migration-test.c:3447:14
    #4 0x564b3e138e00 in test_vcpu_dirty_limit tests/qtest/migration-test.c:3565:16
    #5 0x564b3e14f417 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f0f0335c6b..3818595040 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3355,7 +3355,7 @@ static void wait_for_calc_dirtyrate_complete(QTestState *who,
 static int64_t get_dirty_rate(QTestState *who)
 {
     QDict *rsp_return;
-    gchar *status;
+    const char *status;
     QList *rates;
     const QListEntry *entry;
     QDict *rate;
@@ -3364,7 +3364,7 @@ static int64_t get_dirty_rate(QTestState *who)
     rsp_return = query_dirty_rate(who);
     g_assert(rsp_return);
 
-    status = g_strdup(qdict_get_str(rsp_return, "status"));
+    status = qdict_get_str(rsp_return, "status");
     g_assert(status);
     g_assert_cmpstr(status, ==, "measured");
 
-- 
2.35.3


