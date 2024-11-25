Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4AED58D56
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaMa-0007Yu-Cf; Mon, 25 Nov 2024 09:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaMA-0007Tq-Po; Mon, 25 Nov 2024 09:46:34 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaM8-0004A9-D5; Mon, 25 Nov 2024 09:46:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF87D1F442;
 Mon, 25 Nov 2024 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He0ggOrN33vxICdyU0+dW0Ph2ZFeMCjmGAB0LyTvMHM=;
 b=uFzAD8HrKWxR907zURWXuIEbEKb5isLRPX1GGRNgzFA/BeO9lm4CPvTevBw0SLrdkv7NWA
 1yFtN5/JHMfecJo5ppokbbjKhGBK8NEPQXTd1A/VHV/EkZBIO3kec/7uwrPO7m3rQXRL4V
 HBkGDPdLZghf1VbpukhywfL/wTusKJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He0ggOrN33vxICdyU0+dW0Ph2ZFeMCjmGAB0LyTvMHM=;
 b=GLZqDRY9udXeCpLzsm+377t/0ab8mGy7C5TDhMxCutNygn+EyT+7tLuGwHuTc1uGL2YvXZ
 oOryY5kwOrAq2+BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qgsL39c7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QGraiHaL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He0ggOrN33vxICdyU0+dW0Ph2ZFeMCjmGAB0LyTvMHM=;
 b=qgsL39c7VXuLzWPwGxgHpBxKweZ1inmJYnOvX7sk9b8Lp9ZhfkEjliWR1HVQaOghkYvmN+
 mqxpGg8ZTzQ+UJOvtJqwodCm02+eVZY8KzCKvF1PN9i4PrMo/y/LaFUuqa14Yo5u52B8jc
 7S6Cu3ayg3G+XGBgkCq9c/rMBp4+v4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He0ggOrN33vxICdyU0+dW0Ph2ZFeMCjmGAB0LyTvMHM=;
 b=QGraiHaLZh95KsrCzTogRYN/3Mxb/msIheFoWDGf6AXzJ5tjj2ICUYJWGgACJv6QQXYfdw
 KR8Nf8F27TJjzhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7816137D4;
 Mon, 25 Nov 2024 14:46:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kC5eH7+NRGdRTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 14:46:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/5] tests/qtest/migration: Support cleaning up only one side
 of migration
Date: Mon, 25 Nov 2024 11:46:10 -0300
Message-Id: <20241125144612.16194-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241125144612.16194-1-farosas@suse.de>
References: <20241125144612.16194-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF87D1F442
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

We don't always want to cleanup both VMs at the same time. One example
is the multifd cancel test, where there's a second migration reusing
the source VM. The next patches will add another instance, keeping the
destination VM instead.

Extract the cleanup routine from test_migrate_end() into another
function so it can be reused.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f8919a083b..f27dd93835 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -883,13 +883,29 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     return 0;
 }
 
+static void migrate_cleanup(QTestState *from, QTestState *to)
+{
+    if (from) {
+        qtest_quit(from);
+        unlink(src_state.serial);
+        g_free(src_state.serial);
+    }
+
+    if (to) {
+        qtest_quit(to);
+        unlink(dst_state.serial);
+        g_free(dst_state.serial);
+    }
+
+    cleanup("migsocket");
+    cleanup(FILE_TEST_FILENAME);
+}
+
 static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
-    qtest_quit(from);
-
-    if (test_dest) {
+    if (to && test_dest) {
         qtest_memread(to, start_address, &dest_byte_a, 1);
 
         /* Destination still running, wait for a byte to change */
@@ -909,14 +925,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
         check_guests_ram(to);
     }
 
-    qtest_quit(to);
-
-    cleanup("migsocket");
-    unlink(src_state.serial);
-    g_free(src_state.serial);
-    unlink(dst_state.serial);
-    g_free(dst_state.serial);
-    cleanup(FILE_TEST_FILENAME);
+    migrate_cleanup(from, to);
 }
 
 #ifdef CONFIG_GNUTLS
@@ -3305,9 +3314,7 @@ static void test_multifd_tcp_cancel(void)
 
     /* Make sure QEMU process "to" exited */
     qtest_set_expected_status(to, EXIT_FAILURE);
-    qtest_wait_qemu(to);
-    unlink(dst_state.serial);
-    g_free(dst_state.serial);
+    migrate_cleanup(NULL, to);
 
     /*
      * Ensure the source QEMU finishes its cancellation process before we
-- 
2.35.3


