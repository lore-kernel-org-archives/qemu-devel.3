Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1FCC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 10:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxjD8-0006jI-IW; Sat, 22 Aug 2026 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD6-0006hk-Ox; Sat, 22 Aug 2026 06:44:24 -0400
Received: from nx91.node02.secure-mailgate.com ([192.162.87.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD4-0006Nn-1e; Sat, 22 Aug 2026 06:44:24 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wxjCz-002suc-3s; Sat, 22 Aug 2026 12:44:18 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787395457;
 bh=ff4gQQPTus8rZbhuZPovLC9GQG30KC3o8hXhnvHf/bo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m0baMlGaMUb6s0EFR8TumMYUV9wgSLEb3NBSSfyuXzUHOieZgB6leYVugr0adWGTi
 7TXvObeH+fuCWIWazJtINQeRAI0cP+jKuMQYECt4m1f9Fp5x1J88N1R2A471Mqa69a
 NDIbhRJpuZb1ozmN+GsZoAR4CqDPEsvJzpRNJP54=
Received: from Zeuss.fritz.box (p549f1e64.dip0.t-ipconnect.de [84.159.30.100])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 50693280E03;
 Sat, 22 Aug 2026 12:44:16 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, kwolf@redhat.com,
 Christian Quante <christian@quante.one>
Subject: [PATCH 3/3] tests/qtest/fdc-test: check that READ ID answers for the
 drive it names
Date: Sat, 22 Aug 2026 12:43:29 +0200
Message-ID: <20260822104329.42121-4-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822104329.42121-1-christian@quante.one>
References: <20260822104329.42121-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178739545691.2525845.7908581568760227177@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.000643674709508)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXYbgzBHkrXCc2DSI5wDKNQLKb1KgI9lCI3
 x8s4aZNw5Cu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4Zvy7wsaZoqrn6tJ36sk4ntS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS78HF9DWBc0WhbQl3RlROHMl5OjAPt7LlMbhgG9BOAmXwBM2j5REykHorDckk/GS
 XOeJ+u+yrSHikBnwQI7OhPtOt12UKwWWu0uRyF+HHpfXfr5pxnekR5gKyX+MMXIWKOkgxlD67q1I
 Gx5c0htKd4nZUthSv47vkSPENH+ftmELJxpLJ3Xc+Mv8qa2UQxOJ7ZnRFg37IGw7dk2dYrO1zkmH
 CpwS2oZfMuFqjF2RVWG3hy/E+UX+2HRZAwqk+0mElDSRI7NMK5S50kjVVp4t0URWpqFpLVefeduZ
 N+JHmMpG0x9NEum6+ayztSJ+2CI/y5AKvo1HkBEmDLlSM9m2plnfARM40/5kvSvjPlK9O7dFaIfV
 aCHpEB6cFH6WJxE4ZtnMSo/WKlRNZzf4XVeCGinmRmCJWk4HLhMwFIOYGQXuw5TEVLW2QoqlKh7x
 7G5aV4gWIjAfssmYooOojbMVMkKJo3dG96axRy+iXygDw2+Bm+JDUQg6tT9MLS0x/f6bZfTkD6Gr
 5MDzFdkrr3JxFjrsNjMV9Ofg1ecGMS6f0O9nWShVoZrkssanAkdYnqPukWYYHCxVMyzsJd+YpoKs
 GdJH0Xy50uUJhMQ8Rx8ikSDcETRuEFiEir0QFnm722JxylRDDCpDcm7YHCwN/huo0CERFhzyp4dK
 iG0rpA0WSV5yoHDFJZLqjzsPy9CtBkGhUMOpyKA69LF1Ge2GaGfxmfrvYx9wAiRqmOW8oSbE6cLC
 SuWjiWw7Q/zMGXa1uX3ak8AmaAdePjOfvAeIcA+vxeovAu21kK656rT9uyJ/sjgT/6bByKmsrCbi
 xnqDMpbNOpXQ8IocMdGcSaiMqwNDMscPOKPwWY9jlVwvLaNUlXdN
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.91; envelope-from=christian@quante.one;
 helo=nx91.node02.secure-mailgate.com
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

Commit d00567f7fb ("hw/block/fdc: select the drive named by the READ ID
command") added the missing SET_CUR_DRV() to fdctrl_handle_readid(), but
nothing keeps it there: the suite runs a machine with a single floppy
drive, where answering for the wrong drive cannot be told from answering
for the right one.  Removing the call again leaves every existing test
case green.

Add a test case on a machine with two drives.  Drive 0 holds a medium and
is selected by a SEEK, the way a driver spinning up the motor would select
it; drive 1 is empty.  READ ID is then issued for drive 1, and two
independent properties of the answer have to hold: fdctrl_stop_transfer()
reports the drive in ST0, and an empty drive terminates abnormally with
ST1.MA.  Without the fix the controller answers for drive 0, which
terminates normally with ST0 = 0x00.

Test cases carry their own command line, so that a test can ask for
something other than the default single drive.  Both command lines name
the pc machine, so the check added by the previous patch still covers
every test case.

Signed-off-by: Christian Quante <christian@quante.one>
---
 tests/qtest/fdc-test.c | 81 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index f480f4ba09..33d1b83aeb 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -67,6 +67,7 @@ enum {
 enum {
     ST0_IC_MASK  = 0xc0,    /* interrupt code */
     ST0_IC_ABNTERM = 0x40,  /* abnormal termination */
+    ST0_DS_MASK  = 0x03,    /* drive the answer is about */
 
     ST1_MA       = 0x01,    /* missing address mark */
 };
@@ -545,6 +546,47 @@ static void test_read_id_no_media(void)
     g_assert_cmpint(st1 & ST1_MA, ==, ST1_MA);
 }
 
+/*
+ * READ ID carries the drive number in its command byte and has to latch it.
+ * A controller that fails to do so answers for whichever drive was selected
+ * last.  Here drive 0 holds a medium and is selected by the SEEK; drive 1 is
+ * empty, so answering for the wrong drive terminates normally (ST0 = 0x00)
+ * where the command has to fail, and names drive 0 rather than drive 1.
+ */
+static void test_read_id_other_drive(void)
+{
+    uint8_t drive = 1;
+    uint8_t head = 0;
+    uint8_t st0, st1;
+
+    media_insert();
+
+    /* SEEK latches drive 0, the way a driver spinning up the motor would */
+    send_seek(0);
+
+    floppy_send(CMD_READ_ID);
+    g_assert(!get_irq(FLOPPY_IRQ));
+    floppy_send(head << 2 | drive);
+
+    while (!get_irq(FLOPPY_IRQ)) {
+        clock_step(1000000000LL / 50);
+    }
+
+    st0 = floppy_recv();
+    st1 = floppy_recv();
+    floppy_recv();                  /* ST2 */
+    floppy_recv();                  /* cylinder */
+    floppy_recv();                  /* head */
+    floppy_recv();                  /* sector */
+    g_assert(get_irq(FLOPPY_IRQ));
+    floppy_recv();                  /* sector size */
+    g_assert(!get_irq(FLOPPY_IRQ));
+
+    g_assert_cmpint(st0 & ST0_DS_MASK, ==, drive);
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_MA, ==, ST1_MA);
+}
+
 static void test_read_no_dma_1(void)
 {
     uint8_t ret;
@@ -656,6 +698,11 @@ static void test_cve_2021_3507(void)
     qtest_quit(s);
 }
 
+#define MACHINE_ONE_DRIVE "-machine pc -device floppy,id=floppy0"
+#define MACHINE_TWO_DRIVES \
+    "-machine pc -device floppy,id=floppy0,unit=0" \
+    " -device floppy,id=floppy1,unit=1"
+
 /*
  * Each test gets its own QEMU instance, so that none of them depends on the
  * state another one left behind.  Without this, several tests only pass in
@@ -667,35 +714,39 @@ static void test_cve_2021_3507(void)
 typedef struct {
     const char *path;
     void (*fn)(void);
+    const char *args;
 } FDCTest;
 
 static const FDCTest fdc_tests[] = {
-    { "/fdc/cmos",              test_cmos },
-    { "/fdc/no_media_on_start", test_no_media_on_start },
-    { "/fdc/read_without_media", test_read_without_media },
-    { "/fdc/media_change",      test_media_change },
-    { "/fdc/sense_interrupt",   test_sense_interrupt },
-    { "/fdc/relative_seek",     test_relative_seek },
-    { "/fdc/read_id",           test_read_id },
-    { "/fdc/read_id_no_media",  test_read_id_no_media },
-    { "/fdc/verify",            test_verify },
-    { "/fdc/media_insert",      test_media_insert },
-    { "/fdc/read_no_dma_1",     test_read_no_dma_1 },
-    { "/fdc/read_no_dma_18",    test_read_no_dma_18 },
-    { "/fdc/read_no_dma_19",    test_read_no_dma_19 },
-    { "/fdc/fuzz-registers",    fuzz_registers },
+    { "/fdc/cmos",              test_cmos,              MACHINE_ONE_DRIVE },
+    { "/fdc/no_media_on_start", test_no_media_on_start, MACHINE_ONE_DRIVE },
+    { "/fdc/read_without_media", test_read_without_media, MACHINE_ONE_DRIVE },
+    { "/fdc/media_change",      test_media_change,      MACHINE_ONE_DRIVE },
+    { "/fdc/sense_interrupt",   test_sense_interrupt,   MACHINE_ONE_DRIVE },
+    { "/fdc/relative_seek",     test_relative_seek,     MACHINE_ONE_DRIVE },
+    { "/fdc/read_id",           test_read_id,           MACHINE_ONE_DRIVE },
+    { "/fdc/read_id_no_media",  test_read_id_no_media,  MACHINE_ONE_DRIVE },
+    { "/fdc/read_id_other_drive", test_read_id_other_drive,
+                                                        MACHINE_TWO_DRIVES },
+    { "/fdc/verify",            test_verify,            MACHINE_ONE_DRIVE },
+    { "/fdc/media_insert",      test_media_insert,      MACHINE_ONE_DRIVE },
+    { "/fdc/read_no_dma_1",     test_read_no_dma_1,     MACHINE_ONE_DRIVE },
+    { "/fdc/read_no_dma_18",    test_read_no_dma_18,    MACHINE_ONE_DRIVE },
+    { "/fdc/read_no_dma_19",    test_read_no_dma_19,    MACHINE_ONE_DRIVE },
+    { "/fdc/fuzz-registers",    fuzz_registers,         MACHINE_ONE_DRIVE },
 };
 
 static void run_isolated(const void *data)
 {
     const FDCTest *test = data;
 
+    /* Every command line in fdc_tests[] names the pc machine */
     if (!qtest_has_machine("pc")) {
         g_test_skip("Machine 'pc' is not available");
         return;
     }
 
-    qtest_start("-machine pc -device floppy,id=floppy0");
+    qtest_start(test->args);
     qtest_irq_intercept_in(global_qtest, "ioapic");
 
     test->fn();
-- 
2.53.0


