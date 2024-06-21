Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35129C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTr-0003Yi-9d; Fri, 21 Jun 2024 13:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTp-0003YI-RD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTn-0003Qn-Lw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 60CE221B41;
 Fri, 21 Jun 2024 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7FeEXGMcDSenWm4U8X664XX4ySenbLtOwTL8HqhioI=;
 b=euxbH9qokLJFtjSf7kZOPZYpj0VFHFyT+S3SZG/8gBmTfQlPAeXOoLgQgKgUukVlYrtcFB
 Tx9rjobCsOFs3YEpDrQyjXyYYqEDsD05CcKrfPzhbrKlNKRgRQvkpx6RFFct+b0Y6cnMO0
 CobR1YwIuP1biOxHLOEajw/lGFCrXtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7FeEXGMcDSenWm4U8X664XX4ySenbLtOwTL8HqhioI=;
 b=QH7jPEJxiQsYfYRe409bEax91AksfeATLk2v/sOnQhOc7KjTKT0r1JPlDV0NtrdI0sxRh1
 DTm8eOrQHPwFk0Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7FeEXGMcDSenWm4U8X664XX4ySenbLtOwTL8HqhioI=;
 b=euxbH9qokLJFtjSf7kZOPZYpj0VFHFyT+S3SZG/8gBmTfQlPAeXOoLgQgKgUukVlYrtcFB
 Tx9rjobCsOFs3YEpDrQyjXyYYqEDsD05CcKrfPzhbrKlNKRgRQvkpx6RFFct+b0Y6cnMO0
 CobR1YwIuP1biOxHLOEajw/lGFCrXtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7FeEXGMcDSenWm4U8X664XX4ySenbLtOwTL8HqhioI=;
 b=QH7jPEJxiQsYfYRe409bEax91AksfeATLk2v/sOnQhOc7KjTKT0r1JPlDV0NtrdI0sxRh1
 DTm8eOrQHPwFk0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3615113AAA;
 Fri, 21 Jun 2024 17:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kLcxO4S+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/28] tests/migration-tests: Drop most WIN32 ifdefs for
 postcopy failure tests
Date: Fri, 21 Jun 2024 14:54:29 -0300
Message-Id: <20240621175434.31180-24-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

From: Peter Xu <peterx@redhat.com>

Most of them are not needed, we can stick with one ifdef inside
postcopy_recover_fail() so as to cover the scm right tricks only.
The tests won't run on windows anyway due to has_uffd always false.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6207305ff8..b7dea1aabb 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1364,9 +1364,9 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
                                                   "completed", NULL });
 }
 
-#ifndef _WIN32
 static void postcopy_recover_fail(QTestState *from, QTestState *to)
 {
+#ifndef _WIN32
     int ret, pair1[2], pair2[2];
     char c;
 
@@ -1428,8 +1428,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     close(pair1[1]);
     close(pair2[0]);
     close(pair2[1]);
+#endif
 }
-#endif /* _WIN32 */
 
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
@@ -1469,7 +1469,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
-#ifndef _WIN32
     if (args->postcopy_recovery_test_fail) {
         /*
          * Test when a wrong socket specified for recover, and then the
@@ -1478,7 +1477,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
         postcopy_recover_fail(from, to);
         /* continue with a good recovery */
     }
-#endif /* _WIN32 */
 
     /*
      * Create a new socket to emulate a new channel that is different
@@ -1507,7 +1505,6 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-#ifndef _WIN32
 static void test_postcopy_recovery_double_fail(void)
 {
     MigrateCommon args = {
@@ -1516,7 +1513,6 @@ static void test_postcopy_recovery_double_fail(void)
 
     test_postcopy_recovery_common(&args);
 }
-#endif /* _WIN32 */
 
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_recovery_tls_psk(void)
@@ -3782,10 +3778,8 @@ int main(int argc, char **argv)
                            test_postcopy_preempt);
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
-#ifndef _WIN32
         migration_test_add("/migration/postcopy/recovery/double-failures",
                            test_postcopy_recovery_double_fail);
-#endif /* _WIN32 */
         if (is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.35.3


