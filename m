Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA08C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nYj-0003P9-KX; Thu, 10 Sep 2026 18:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lN7-0003NY-Un
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lMm-000168-SA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24B7321D97;
 Thu, 10 Sep 2026 20:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4TLleifm53fumqGFqc8qfNxZWFzGu+6SGnfZNiSSfI=;
 b=c+nFBlTAbuuBYA8Qh+fK0VzhTiaTjvHwitXVJYVAcRu55akz2pDAkzDxngO8imcEL4w3Rj
 m+2oZGs7WEuFmDj7EnjzEsTiWrn6Sa5mxjjPrKB227iccVY1HIaOBUwkjYH6X7/46ZA9pL
 R4QmUEgBd8ArMvD+6ZpqfaPYw/9CgAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4TLleifm53fumqGFqc8qfNxZWFzGu+6SGnfZNiSSfI=;
 b=I0FJB6EJQTtnsE3/dylzXp5Lx5D6XoQUKX2XUkZJC6THKH2gYpOOoK8OnB79ri8KzaO/H8
 DhJj3+8XiTCMKiDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4TLleifm53fumqGFqc8qfNxZWFzGu+6SGnfZNiSSfI=;
 b=RXfSfDJYzxAJRAl/aEDUDQIh4W7l+K/kr5F+9hrSekdW6cssNZ/brq09R3naj+8oS22Xv9
 QeQDg58r1BmElTaimfPkWiJ5MYYEEc38QwGkJjcrks+2GyCI2n7tegbzbJkOvrErDFELUH
 9/D1obTaGRvEI/ftKMnqwhrLatysEqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4TLleifm53fumqGFqc8qfNxZWFzGu+6SGnfZNiSSfI=;
 b=Ow2q6WoolqzMOyPXueisMipAs9c4bGd7uR++p4zF8sjRp687QN3HA72+hOBjBDbSKSZOgE
 b1aSc/4WczsHocCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9885137FD;
 Thu, 10 Sep 2026 20:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KG0tLl4So2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:26:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Christian Quante <christian@quante.one>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/7] tests/qtest/fdc-test: give each test case its own QEMU
 instance
Date: Thu, 10 Sep 2026 17:25:53 -0300
Message-ID: <20260910202559.916866-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
References: <20260910202559.916866-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[quante.one:email, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

From: Christian Quante <christian@quante.one>

The test cases share one QEMU instance and, with it, the state of the
floppy controller.  Several of them therefore only pass in the order they
happen to be registered in: test_read_no_dma_1, _18 and _19 read the medium
that test_media_insert leaves in the drive, so running any of them on its
own fails.  fuzz-registers is worse -- it writes 1000 random values to the
eight I/O ports at FLOPPY_BASE and restores none of them, which is harmless
only because it is the last test case to run in the shared instance; the
two registered after it start one of their own.  Moving it anywhere else
leaves an unacknowledged interrupt behind and the next test dies in
send_seek().

Register the test cases from a table instead, through a wrapper that starts
a QEMU instance, runs one test and stops it again.  The test functions are
unchanged: they reach the current instance through global_qtest, which
qtest_start() reassigns for every test.  The three read_no_dma tests now
insert their own medium, and test_read_id no longer ejects at the end -- it
did that only to leave the drive as the next test expected to find it.

The two CVE test cases keep qtest_add_func(); they already run a QEMU
instance of their own and do not use global_qtest.

The same pattern is used by tests/qtest/boot-serial-test.c.

Every test case now passes on its own, and the suite passes with the
registration order reversed.

Signed-off-by: Christian Quante <christian@quante.one>
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/fdc-test.c | 71 ++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 1e1dd8659d..fd38475bf7 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -510,9 +510,6 @@ static void test_read_id(void)
     g_assert_cmpint(cyl, ==, 8);
     g_assert_cmpint(head, ==, 1);
     g_assert_cmpint(st0, ==, head << 2);
-
-    /* Leave the drive empty, the way the machine starts up. */
-    media_eject();
 }
 
 /*
@@ -552,6 +549,7 @@ static void test_read_no_dma_1(void)
 {
     uint8_t ret;
 
+    media_insert();
     outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
     send_seek(0);
     ret = send_read_no_dma_command(1, 0x04);
@@ -562,6 +560,7 @@ static void test_read_no_dma_18(void)
 {
     uint8_t ret;
 
+    media_insert();
     outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
     send_seek(0);
     ret = send_read_no_dma_command(18, 0x04);
@@ -572,6 +571,7 @@ static void test_read_no_dma_19(void)
 {
     uint8_t ret;
 
+    media_insert();
     outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
     send_seek(0);
     ret = send_read_no_dma_command(19, 0x20);
@@ -656,10 +656,53 @@ static void test_cve_2021_3507(void)
     qtest_quit(s);
 }
 
+/*
+ * Each test gets its own QEMU instance, so that none of them depends on the
+ * state another one left behind.  Without this, several tests only pass in
+ * the order they happen to be registered in: the read_no_dma tests need the
+ * medium that test_media_insert leaves in the drive, and fuzz-registers
+ * writes random values to the eight I/O ports at FLOPPY_BASE and restores
+ * none of them.
+ */
+typedef struct {
+    const char *path;
+    void (*fn)(void);
+} FDCTest;
+
+static const FDCTest fdc_tests[] = {
+    { "/fdc/cmos",              test_cmos },
+    { "/fdc/no_media_on_start", test_no_media_on_start },
+    { "/fdc/read_without_media", test_read_without_media },
+    { "/fdc/media_change",      test_media_change },
+    { "/fdc/sense_interrupt",   test_sense_interrupt },
+    { "/fdc/relative_seek",     test_relative_seek },
+    { "/fdc/read_id",           test_read_id },
+    { "/fdc/read_id_no_media",  test_read_id_no_media },
+    { "/fdc/verify",            test_verify },
+    { "/fdc/media_insert",      test_media_insert },
+    { "/fdc/read_no_dma_1",     test_read_no_dma_1 },
+    { "/fdc/read_no_dma_18",    test_read_no_dma_18 },
+    { "/fdc/read_no_dma_19",    test_read_no_dma_19 },
+    { "/fdc/fuzz-registers",    fuzz_registers },
+};
+
+static void run_isolated(const void *data)
+{
+    const FDCTest *test = data;
+
+    qtest_start("-machine pc -device floppy,id=floppy0");
+    qtest_irq_intercept_in(global_qtest, "ioapic");
+
+    test->fn();
+
+    qtest_end();
+}
+
 int main(int argc, char **argv)
 {
     int fd;
     int ret;
+    size_t i;
 
     /* Create a temporary raw image */
     fd = g_file_open_tmp("qtest.XXXXXX", &test_image, NULL);
@@ -671,29 +714,17 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);
 
-    qtest_start("-machine pc -device floppy,id=floppy0");
-    qtest_irq_intercept_in(global_qtest, "ioapic");
-    qtest_add_func("/fdc/cmos", test_cmos);
-    qtest_add_func("/fdc/no_media_on_start", test_no_media_on_start);
-    qtest_add_func("/fdc/read_without_media", test_read_without_media);
-    qtest_add_func("/fdc/media_change", test_media_change);
-    qtest_add_func("/fdc/sense_interrupt", test_sense_interrupt);
-    qtest_add_func("/fdc/relative_seek", test_relative_seek);
-    qtest_add_func("/fdc/read_id", test_read_id);
-    qtest_add_func("/fdc/read_id_no_media", test_read_id_no_media);
-    qtest_add_func("/fdc/verify", test_verify);
-    qtest_add_func("/fdc/media_insert", test_media_insert);
-    qtest_add_func("/fdc/read_no_dma_1", test_read_no_dma_1);
-    qtest_add_func("/fdc/read_no_dma_18", test_read_no_dma_18);
-    qtest_add_func("/fdc/read_no_dma_19", test_read_no_dma_19);
-    qtest_add_func("/fdc/fuzz-registers", fuzz_registers);
+    for (i = 0; i < ARRAY_SIZE(fdc_tests); i++) {
+        qtest_add_data_func(fdc_tests[i].path, &fdc_tests[i], run_isolated);
+    }
+
+    /* These use a QTestState of their own instead of global_qtest */
     qtest_add_func("/fdc/fuzz/cve_2021_20196", test_cve_2021_20196);
     qtest_add_func("/fdc/fuzz/cve_2021_3507", test_cve_2021_3507);
 
     ret = g_test_run();
 
     /* Cleanup */
-    qtest_end();
     unlink(test_image);
     g_free(test_image);
 
-- 
2.53.0


