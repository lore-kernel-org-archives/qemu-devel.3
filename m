Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C109C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mhD-00063y-46; Thu, 10 Sep 2026 17:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lN8-0003Nc-0N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lMw-00016g-Gn
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B41E121E64;
 Thu, 10 Sep 2026 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHOUSNPgHp+ou5TCOsUhOhq0vr6Hn9TKw3iNsrm+f10=;
 b=sd0TsHydb25gLHrCBJh296ZVF505wXimyL7J6VXTUAnPOPDaMXR51/R26qKTLkHMNsuagf
 WuRQmkyBxEvl/xkxMpc4DQ2qCayuQqqa6EfaYinAcD2QhDuYctJ0hnWkV5Ynpd+4Bsp2aa
 WXSXSVLsO0UnYh/ni1mLnR0f3SeR9Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHOUSNPgHp+ou5TCOsUhOhq0vr6Hn9TKw3iNsrm+f10=;
 b=aWHL341hyaXBGdVQB926jiPS0QOY6LNLnVbGS3L0UoC2yoSmvxC83iN+wJkw7mt5n+gtHf
 xnjXYVnjwcY8YeBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mXeSFvom;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bppyYIvV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHOUSNPgHp+ou5TCOsUhOhq0vr6Hn9TKw3iNsrm+f10=;
 b=mXeSFvomQswIXp2dPKXlN0QeyObLBbEOqHa8L7vWPmRhWg/XvFaSMJfiVEKXq4ASJLvMQZ
 iSt+98jcqtccusVVW+4r+pP4AHvRNnNFYBY/8dey+NvX68rv/Jzsu1CnNChoqZbxgobuQ/
 rWmXx61V2aRt//2WvstejQGyEPJhPcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHOUSNPgHp+ou5TCOsUhOhq0vr6Hn9TKw3iNsrm+f10=;
 b=bppyYIvVCP7BDkYRvVLcMeA89dHoKCXsODxezVHb+GwvbVUmVwbhCD5GLh+le3DiTW6qu0
 DAnUfuoPEFeUmDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CD1213A5A;
 Thu, 10 Sep 2026 20:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +MmsE2ESo2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:26:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Christian Quante <christian@quante.one>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 3/7] tests/qtest/fdc-test: check that READ ID answers for the
 drive it names
Date: Thu, 10 Sep 2026 17:25:55 -0300
Message-ID: <20260910202559.916866-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
References: <20260910202559.916866-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B41E121E64
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,quante.one:email,st1.ma:url];
 DKIM_TRACE(0.00)[suse.de:+]
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
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
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


