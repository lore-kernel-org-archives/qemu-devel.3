Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F20AC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhKv-0003hy-AA; Wed, 19 Aug 2026 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKq-0003gY-FP
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:08 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKo-0003HF-Rr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E034784B59;
 Wed, 19 Aug 2026 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FF5kL1FyiD1AooB8mhW4SKAh54+sIPWAsaZd53Ev258=;
 b=Zu4BWku3jYbqVefuF3pU1+RJF6+KzRlqrKxKaAfjbk30WmwNXzs379SwlzhU1G/vpD8tFj
 RJSxRkYV8Y6IIMCRaCn2ZcMZ863GJxTv9AMsVWpeH/Usa2ViNn3Me+tQ6r+eeD18fb8NMA
 uwhq3Z6665LSZt/SBoaqd64EfXDzdeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FF5kL1FyiD1AooB8mhW4SKAh54+sIPWAsaZd53Ev258=;
 b=gSBejkA2see8RBjUzS3830oY/KG9L7PfnEoDhb1wfoFinxYATzo1frw5RZSuE+LCRwiY+2
 U87CaNh9lT3jGaBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PwARcqDz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nJ8oI1cJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FF5kL1FyiD1AooB8mhW4SKAh54+sIPWAsaZd53Ev258=;
 b=PwARcqDzhTtdsRhJ7zlJlZ7tYkgky3/OeaJBbv7RLiY4UsqzuPY6VYod8p3xC1U2sVoogs
 eTEFkNiSYMxFF7vJSef3EfvEAJC7N4wvwKKSivAC9HuBf5tsJA1PbQsjyy1jMxDF8ii3Qs
 WDVSlHX6oe9E4qRlqN+01KZF0LW/Lug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FF5kL1FyiD1AooB8mhW4SKAh54+sIPWAsaZd53Ev258=;
 b=nJ8oI1cJYrrbguS45LEkdR1slQKGMxG1tUKQLL5z16WaSKDckPC+4eXmCY7SABUIsy38yb
 M8Doz2sLuvD7WxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1474362E;
 Wed, 19 Aug 2026 14:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6OQ7JFu+hWqxCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 14:31:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 1/4] tests/qtest/libqtest: Use GLib functions for proper const
 correctness
Date: Wed, 19 Aug 2026 11:31:49 -0300
Message-ID: <20260819143152.1541266-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819143152.1541266-1-farosas@suse.de>
References: <20260819143152.1541266-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E034784B59
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

While commit e68da5b7a2cd ("tests/qtest: fix discarded const qualifier
warning") addressed the immediate strstr() warning by making 'found'
const, there's still a room for improvement: getenv() returns char *, but
environment strings are semantically read-only and should be treated as const
throughout their lifetime.

Replace getenv() with g_getenv() and strstr() with g_strstr_len() to
maintain const correctness from source to use. This approach:

- Uses g_getenv() which returns const gchar *, matching the read-only
  semantics of environment variables
- Employs g_strstr_len() for consistent use of GLib string functions,
  aligning with QEMU conventions
- Eliminates all const-correctness warnings with strict compilers

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c33c799c92d..bec37c71b8c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2151,8 +2151,7 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 
 bool qtest_verbose(const char *domain)
 {
-    const char *log = getenv("QTEST_LOG");
-    const char *found;
+    const gchar *found, *log = g_getenv("QTEST_LOG");
 
     assert(domain);
 
@@ -2178,11 +2177,11 @@ bool qtest_verbose(const char *domain)
          *  QTEST_LOG=<domain1>,-<domain2> (only false for domain2)
          *  allows other separators, except - and +
          */
-        found = strstr(log, domain);
+        found = g_strstr_len(log, -1, domain);
 
         if (found) {
             /* reject options given twice */
-            assert(!strstr(found + strlen(domain), domain));
+            assert(!g_strstr_len(found + strlen(domain), -1, domain));
 
             if (found > log) {
                 ptrdiff_t i = found - log - 1;
@@ -2196,7 +2195,7 @@ bool qtest_verbose(const char *domain)
              * If filtering out a specific domain, all others are
              * enabled.
              */
-            return !!strstr(log, "-");
+            return !!g_strstr_len(log, -1, "-");
         }
     }
 
-- 
2.53.0


