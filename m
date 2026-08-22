Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5B9C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 10:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxjD8-0006jB-5b; Sat, 22 Aug 2026 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD6-0006hi-Lt; Sat, 22 Aug 2026 06:44:24 -0400
Received: from nx119.node01.secure-mailgate.com ([89.22.108.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD3-0006Nb-AD; Sat, 22 Aug 2026 06:44:24 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wxjCx-001C7D-NY; Sat, 22 Aug 2026 12:44:16 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787395455;
 bh=8CUxlAnPB47hAsfraP5hfTpMeHjzKrOxAjlbJXLHrn4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A8PL1qoo9DlZl/sJOq/u5HoSOaX7zXAy6aRK1Fkefg1/ceQxrHsGBTvA0n7RyLA38
 eo/nH4vgvFWHt5MxXYish/drSIVx9GfA9ucCTTz+2Q1k0ad32JcPDeReyDwdN9yIJZ
 Df1LEMMKOuHgh0F4Qt9N9/VB6sBlaSGv5TgZayyQ=
Received: from Zeuss.fritz.box (p549f1e64.dip0.t-ipconnect.de [84.159.30.100])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id A45A4281B0E;
 Sat, 22 Aug 2026 12:44:14 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, kwolf@redhat.com,
 Christian Quante <christian@quante.one>
Subject: [PATCH 1/3] tests/qtest/fdc-test: give each test case its own QEMU
 instance
Date: Sat, 22 Aug 2026 12:43:27 +0200
Message-ID: <20260822104329.42121-2-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822104329.42121-1-christian@quante.one>
References: <20260822104329.42121-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178739545524.2525745.12066465853828930368@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.000230866402771)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVjvM7kvtM6EIuMk754uvuyFmG1VqY3LKzl
 Ron6D/5esiu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4ZyUoFWSg2XRLx9TxWU55AmS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS78HF9DWBc0WhbQl3RlROHMl5OjAPt7LlMbhgG9BOAmXwBM2j5REykHorDckk/GS
 XOeJ+u+yrSHikBnwQI7OhPtOt12UKwWWu0uRyF+HHpfXfr5pxnekR5gKyX+MMXIWKOkgxlD67q1I
 Gx5c0htKd4nZUthSv47vkSPENH+ftmELJxpLJ3Xc+Mv8qa2UQxOJ7ZnRFg37IGw7dk2dYrO1zkmH
 CpwS2oZfMuFqjF2RVWG3hy/E+UX+2HRZAwqk+0mElDSRI7NMK5S50kjVVp4t0URWpqFpLVefeduZ
 N+JHmMpG0x9NEum6+ayztSJ+2CI/y5AKvo1HkBEmDLlSM9m2plnfARM40/5kvSvjPlK9O7dFaIfV
 aCHpEB6cFH6WJxE4ZtnMSo/WKlRNZzf4XVeCGimUHxj/pwGJViNmCoZa3RMN1DUsv5YmscDnaRNJ
 o0LVnogWIjAfssmYooOojbMVMkKJo3dG96axRy+iXygDw2+Bm+JDUQg6tT9MLS0x/f6bZfTkD6Gr
 5MDzFdkrr3JxFjrsNjMV9Ofg1ecGMS6f0O9nWShVoZrkssanAkdYnqPukWYYHCxVMyzsJd+YpoKs
 GdJH0Xy50uUJhMQ8Rx8ikSDci2z5PZC+7IhbNAp5pzxxYs9n5ew7JoabIXIkiO0B3a0RFhzyp4dK
 iG0rpA0WSV5yoHDFJZLqjzsPy9CtBkGhUMOpyKA69LF1Ge2GaGfxmfrvYx9wAiRqmOW8oSbE6cLC
 SuWjiWw7Q/zMGXa1uX3ak8AmaAdePjOfvAeIcA+vxeovAu21kK656rT9uyJ/sjgT/6bByKmsrCbi
 xnqDMpbNOpXQ8IocMdGcSaiMqwNDMscPOKPwWY9jlVwvLaNUlXdN
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.119; envelope-from=christian@quante.one;
 helo=nx119.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


