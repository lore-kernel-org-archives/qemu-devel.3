Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0AA1061B1B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hwd-0004nk-7I; Mon, 30 Mar 2026 15:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7Hvf-0003qi-Sz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:42 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7Hvc-0005GP-Mn
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 112144D26D;
 Mon, 30 Mar 2026 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAdxWJq9wsA0mzm41Hj6XyPkybBNhxV73lDqleIqwPA=;
 b=TYn4AZMmFUXa/YhJhKVrrbR1ploA6t1RXEZKw4BZxhqYeHR5smHYW3ArlQ8N+c3FgBgRIZ
 1AK25CuXOFnZHP5Skz4/HCBAgl1v71N9Gs3NycFOOhFKEAeNdtqdAV+mh8FSV+8bOocMw4
 QDUhVt8C3MU4e7zdL60bCWMFIRivW7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAdxWJq9wsA0mzm41Hj6XyPkybBNhxV73lDqleIqwPA=;
 b=gW8wYwKAyOLPL1f/BikkoBBPRvlducqOJnxNKm+Any1Z1XH6q06w2vUggTGktZPj7SWgXN
 7dSpLe0O1k/8iZCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAdxWJq9wsA0mzm41Hj6XyPkybBNhxV73lDqleIqwPA=;
 b=TYn4AZMmFUXa/YhJhKVrrbR1ploA6t1RXEZKw4BZxhqYeHR5smHYW3ArlQ8N+c3FgBgRIZ
 1AK25CuXOFnZHP5Skz4/HCBAgl1v71N9Gs3NycFOOhFKEAeNdtqdAV+mh8FSV+8bOocMw4
 QDUhVt8C3MU4e7zdL60bCWMFIRivW7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAdxWJq9wsA0mzm41Hj6XyPkybBNhxV73lDqleIqwPA=;
 b=gW8wYwKAyOLPL1f/BikkoBBPRvlducqOJnxNKm+Any1Z1XH6q06w2vUggTGktZPj7SWgXN
 7dSpLe0O1k/8iZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 189EF4A0A2;
 Mon, 30 Mar 2026 19:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCdPNmnJymlGdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Mar 2026 19:05:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/3] tests/qtest/migration: Fix slow test dirty_limit
Date: Mon, 30 Mar 2026 16:05:08 -0300
Message-ID: <20260330190508.8634-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330190508.8634-1-farosas@suse.de>
References: <20260330190508.8634-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
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

After the referenced commit, the incoming side doesn't exit
automatically after a failure. Tests that expect the destination to
fail should use -incoming defer, issue QMP migrate-incoming, wait for
the failure event and issue QMP quit.

Fix the dirty_limit test which wasn't updated properly.

Fixes: 4e8c4dda97 ("tests/qtest/migration: Force exit-on-error=false")
Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260326164405.1626-1-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/precopy-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index c6c8ae3004..a0e3ff0547 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -1070,11 +1070,10 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->start.hide_stderr = true;
     args->start.use_dirty_ring = true;
 
-    args->listen_uri = uri;
     args->connect_uri = uri;
 
     /* Start src, dst vm */
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
@@ -1082,6 +1081,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
+    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
     migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
-- 
2.51.0


