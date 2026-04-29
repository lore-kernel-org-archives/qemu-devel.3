Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B13FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEf-0001wc-Tb; Wed, 29 Apr 2026 15:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEf-0001uN-23
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:13 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEc-0000Rs-Ru
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D65926A81C;
 Wed, 29 Apr 2026 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7W+LG/e4N84hX6vct4e3E6sskFPEJKhlBBC5LD9xxeI=;
 b=wXD1NvKKOa6nwk1FEdsR9VXb4sxy95k2w4iBSh4ox6N5vaOVvOZfusKXe8dzon42pmTCeJ
 QTPTonDhclVFyKJNUHXAqWMQzXqNUAzp2dZDsRJu9Kp0w45zjDSkRnTguICavHHRImGpno
 ncY0MgVXr99jaS6+to0sGa+a6oWNGsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7W+LG/e4N84hX6vct4e3E6sskFPEJKhlBBC5LD9xxeI=;
 b=rpjVOoXpYhgqDWOru3XggElXVsaR3Kn+FpIGjy1XQDZPHECKi60i8sr+jn+hhKHFvzTD/L
 QBvQNVpJUQhASeBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7W+LG/e4N84hX6vct4e3E6sskFPEJKhlBBC5LD9xxeI=;
 b=wXD1NvKKOa6nwk1FEdsR9VXb4sxy95k2w4iBSh4ox6N5vaOVvOZfusKXe8dzon42pmTCeJ
 QTPTonDhclVFyKJNUHXAqWMQzXqNUAzp2dZDsRJu9Kp0w45zjDSkRnTguICavHHRImGpno
 ncY0MgVXr99jaS6+to0sGa+a6oWNGsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7W+LG/e4N84hX6vct4e3E6sskFPEJKhlBBC5LD9xxeI=;
 b=rpjVOoXpYhgqDWOru3XggElXVsaR3Kn+FpIGjy1XQDZPHECKi60i8sr+jn+hhKHFvzTD/L
 QBvQNVpJUQhASeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D44B593B0;
 Wed, 29 Apr 2026 19:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8NEgE5VW8mm/eQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 19:05:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, marcandre.lureau@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 3/5] tests/qtest/dbus-vmstate: Honor QTEST_LOG env variable
Date: Wed, 29 Apr 2026 16:05:48 -0300
Message-ID: <20260429190550.20122-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429190550.20122-1-farosas@suse.de>
References: <20260429190550.20122-1-farosas@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

Don't hide QEMU error messages unconditionally, make the tests that
expect to fail honor QTEST_LOG and show every output if the variable
is set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/dbus-vmstate-test.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 51c5fdb995..05e598a3e3 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -324,17 +324,18 @@ test_dbus_vmstate_missing_src(char *name, MigrateCommon *args)
 {
     Test test = { .id_list = "idA,idC",
         .result = MIG_TEST_FAIL };
+    bool silent = !getenv("QTEST_LOG");
 
     /* run in subprocess to silence QEMU error reporting */
-    if (g_test_subprocess()) {
-        test_dbus_vmstate(&test);
-        check_not_migrated(&test.srcA, &test.dstA);
-        check_not_migrated(&test.srcB, &test.dstB);
+    if (silent && !g_test_subprocess()) {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_passed();
         return;
     }
 
-    g_test_trap_subprocess(NULL, 0, 0);
-    g_test_trap_assert_passed();
+    test_dbus_vmstate(&test);
+    check_not_migrated(&test.srcA, &test.dstA);
+    check_not_migrated(&test.srcB, &test.dstB);
 }
 
 static void
@@ -343,18 +344,19 @@ test_dbus_vmstate_missing_dst(char *name, MigrateCommon *args)
     Test test = { .id_list = "idA,idB",
                   .without_dst_b = true,
                   .result = MIG_TEST_FAIL };
+    bool silent = !getenv("QTEST_LOG");
 
     /* run in subprocess to silence QEMU error reporting */
-    if (g_test_subprocess()) {
-        test_dbus_vmstate(&test);
-        assert(test.srcA.save_called);
-        assert(test.srcB.save_called);
-        assert(!test.dstB.save_called);
+    if (silent && !g_test_subprocess()) {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_passed();
         return;
     }
 
-    g_test_trap_subprocess(NULL, 0, 0);
-    g_test_trap_assert_passed();
+    test_dbus_vmstate(&test);
+    assert(test.srcA.save_called);
+    assert(test.srcB.save_called);
+    assert(!test.dstB.save_called);
 }
 
 static void log_func(const gchar *log_domain, GLogLevelFlags log_level,
-- 
2.51.0


