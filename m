Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4939EFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHktz-0003vB-CY; Tue, 28 Apr 2026 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHksW-0003AK-MP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHksS-0003le-Uh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 543A05BD3F;
 Tue, 28 Apr 2026 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777392093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5QS08LdqDUIEpDxve/9nBXhEGDIUiWJTjDQzQQnp94I=;
 b=rP8B2Rrw0cBwBNdvw0CnGuBrqJGon6EScfFnKqOk9j++Hyifv4TlA5ryGgC2z414nUfYXo
 7XZnHoMhtQ8JtZjOKVCvhmaGTx3a7O0cKIcGey2DH3tsJXj1Vk3w1jNIB+mP1GKMs9TGlj
 9hfAquQGgDUpQP8zBpZ6GksUppiOa9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777392093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5QS08LdqDUIEpDxve/9nBXhEGDIUiWJTjDQzQQnp94I=;
 b=/SFVwytbZF8OT+bxqqQnfRGvBk49eQqaufNFbJUXV+xvVQX5e9MwQS3rz4uU8m1uNlV/9r
 LuXmj5jP24GPSIAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777392088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5QS08LdqDUIEpDxve/9nBXhEGDIUiWJTjDQzQQnp94I=;
 b=pdVDzyw2A/qWj/MlGPCMH5noioGFViowyqzesj/gqZE/EYSQ70JpqLeiIFa92i6aGetXoY
 uLZzbnGy/4084IgDreljAJtGA4r2f/hsvl649hLQy38k/xn+dN/9LMOBQ2UGdsPmt6W3zT
 5WLyJmmLaxqGVUGJCLFGCoz8YSAPibk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777392088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5QS08LdqDUIEpDxve/9nBXhEGDIUiWJTjDQzQQnp94I=;
 b=pDtaWcMFGW2kGrfV7NQBMTYWeXGAewvdwDnTq7NPM0lsBW3Viv8bnOyk005ejJTWyQ8ljq
 LuizQyZcnIEK7YDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D434593B0;
 Tue, 28 Apr 2026 16:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ducXF9bZ8Gm8CQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Apr 2026 16:01:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1] tests/qtest: Avoid timers from default devices
Date: Tue, 28 Apr 2026 13:01:20 -0300
Message-ID: <20260428160120.12130-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email, linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Having default devices enabled while testing timers leads to
non-deterministic behavior on the usage of the QTest
qtest_clock_step_next() command as the implicit devices can have
timers of their own that may have a deadline more recent than the
tested device.

In the particular case of npcm7xx-timer-test, having SLIRP enabled in
the QEMU binary may cause the net_slirp_timer to shadow the clock
advance that was expected to trigger the NPCM7xx timer:

npcm7xx_timer-test.c:475:test_periodic_interrupt:
  assertion failed (tim_read(td, TISR) == tim_timer_bit(td)): (0x00000000 == 0x00000010)
npcm7xx_timer-test.c:476:test_periodic_interrupt:
'qtest_get_irq(global_qtest, tim_timer_irq(td))' should be TRUE

Add the -nodefaults command line option to all tests that invoke
qtest_clock_step_next.

CC: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/npcm7xx_timer-test.c | 2 +-
 tests/qtest/pflash-cfi02-test.c  | 4 ++--
 tests/qtest/rtc-test.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 43711049ca..0e2284669d 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -551,7 +551,7 @@ int main(int argc, char **argv)
         }
     }
 
-    qtest_start("-machine npcm750-evb");
+    qtest_start("-machine npcm750-evb -nodefaults");
     qtest_irq_intercept_in(global_qtest, "/machine/soc/a9mpcore/gic");
     ret = g_test_run();
     qtest_end();
diff --git a/tests/qtest/pflash-cfi02-test.c b/tests/qtest/pflash-cfi02-test.c
index 8c073efcb4..65b35811fa 100644
--- a/tests/qtest/pflash-cfi02-test.c
+++ b/tests/qtest/pflash-cfi02-test.c
@@ -260,7 +260,7 @@ static void test_geometry(const void *opaque)
 {
     const FlashConfig *config = opaque;
     QTestState *qtest;
-    qtest = qtest_initf("-M musicpal"
+    qtest = qtest_initf("-M musicpal -nodefaults"
                         " -drive if=pflash,file=%s,format=raw,copy-on-read=on"
                         /* Device geometry properties. */
                         " -global driver=cfi.pflash02,"
@@ -580,7 +580,7 @@ static void test_cfi_in_autoselect(const void *opaque)
 {
     const FlashConfig *config = opaque;
     QTestState *qtest;
-    qtest = qtest_initf("-M musicpal"
+    qtest = qtest_initf("-M musicpal -nodefaults"
                         " -drive if=pflash,file=%s,format=raw,copy-on-read=on",
                         image_path);
     FlashConfig explicit_config = expand_config_defaults(config);
diff --git a/tests/qtest/rtc-test.c b/tests/qtest/rtc-test.c
index 02ed4e1238..09b6de9166 100644
--- a/tests/qtest/rtc-test.c
+++ b/tests/qtest/rtc-test.c
@@ -691,7 +691,7 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_start("-rtc clock=vm");
+    s = qtest_start("-rtc clock=vm -nodefaults");
     qtest_irq_intercept_in(s, "ioapic");
 
     qtest_add_func("/rtc/check-time/bcd", bcd_check_time);
-- 
2.51.0


