Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B40C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wollt-00011b-Pe; Tue, 28 Jul 2026 13:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkx-0007uO-Rc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkv-0005zq-JG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSSbUJA1nD6D1kms67T7/JDgEaB+Ppp2quwreNqNISU=;
 b=S7RBDIA+EbGXwJVpFGdDA21Ra1NoaVHfBy0xgz9vNvIewSxwn2vVKB2tOtcUx0QDmIpoRu
 juHuU/TKC45CGn89fS9BvPwJbLHTObiH39YhRxz1kRN25dzhMiz6SDdOogE19ZLWTquUZ1
 lbh9ZBYj1TDfupYwAIt8LtDUnlJTf1Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-tyUnQSZQOM-yu6TwKFIcOg-1; Tue,
 28 Jul 2026 13:38:15 -0400
X-MC-Unique: tyUnQSZQOM-yu6TwKFIcOg-1
X-Mimecast-MFC-AGG-ID: tyUnQSZQOM-yu6TwKFIcOg_1785260294
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31FA21800345; Tue, 28 Jul 2026 17:38:14 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B03AC19560AB; Tue, 28 Jul 2026 17:38:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 16/17] hw/block/fdc: report a missing address mark on an empty
 drive
Date: Tue, 28 Jul 2026 19:37:38 +0200
Message-ID: <20260728173739.352078-17-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

READ ID on a drive with no medium terminates normally and returns the
made-up sector ID left over from the "Pretend we are spinning" emulation.
The only error path is a data rate mismatch, and media_rate is assigned
solely by pick_geometry(); it is never reset when the medium is removed.
A guest that has just ejected a diskette is therefore told that one is
still present.

READ, WRITE and FORMAT have a related problem: fd_seek() answers 2 both
for "track/head out of range" and for "no medium", so the callers report
ST0 = ABNTERM with ST1 = 0x00 either way.  Without ST1.MA the guest cannot
tell an absent diskette from a transient error.  Give fd_seek() a return
code of its own for an absent medium, and let both switch statements
report the missing address mark for it.

The comments on the two switches were swapped: fd_seek() answers 2 for a
bad track or head and 3 for a sector past last_sect, but case 2 read
"sect too big" and case 3 "track too big".  Both now say what they mean.

This is a behaviour change for FORMAT TRACK on an empty drive as well,
which now answers ST1.MA rather than ST1 = 0x00.  None of the guests
tested reaches that path -- DOS gives up during media sensing and never
issues the command -- but it seemed wrong to leave fdctrl_format_sector()
falling through to "default" for a case fd_seek() now reports explicitly.

Failing READ ID does not make guests detect the removal: real hardware
never completes the command on an empty drive, because there are no index
pulses, and OS/2 for one relies on that timeout.  It does stop the
controller from claiming a diskette that is not there.

tests/qtest/fdc-test.c starts QEMU with "-device floppy,id=floppy0" and
no medium, and test_read_id asserts a normal termination with a made-up
cylinder 8 / head 1.  That contradicts its neighbours
test_no_media_on_start and test_media_change, which state that DSKCHG
signals an absent medium.  Insert a medium before READ ID and eject it
afterwards -- the rewritten test passes before and after this change --
and add test_read_id_no_media for the empty drive.

Guests checked, reading and writing, with and without a medium: Linux
2.0.34 and 7.0, PC-DOS 7, IBM DOS 5.02, Windows for Workgroups 3.11 and
OS/2 2.11.  None changes behaviour.  No version of the Linux floppy driver
from 1.2.13 to master issues READ ID at all -- FD_READID is defined in the
uapi header for FDRAWCMD users and the driver never sends it -- so Linux
detects an empty drive by stepping the head and reading DSKCHG instead.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3971
Signed-off-by: Christian Quante <christian@quante.one>
Message-ID: <20260714164031.60551-3-christian@quante.one>
[kwolf: Added fd_seek() comment for new return value 5]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/fdc.c         | 50 +++++++++++++++++++++++++-----
 tests/qtest/fdc-test.c | 70 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 9b2409cfa4c..1178b959a64 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -196,6 +196,12 @@ static void fd_init(FDrive *drv)
 
 #define NUM_SIDES(drv) ((drv)->flags & FDISK_DBL_SIDES ? 2 : 1)
 
+/* Is a diskette present in the drive? */
+static bool fd_media_present(FDrive *drv)
+{
+    return drv->blk != NULL && blk_is_inserted(drv->blk);
+}
+
 static int fd_sector_calc(uint8_t head, uint8_t track, uint8_t sect,
                           uint8_t last_sect, uint8_t num_sides)
 {
@@ -222,6 +228,7 @@ static int fd_offset(FDrive *drv)
  * returns 2 if track is invalid
  * returns 3 if sector is invalid
  * returns 4 if seek is disabled
+ * returns 5 if no floppy is inserted
  */
 static int fd_seek(FDrive *drv, uint8_t head, uint8_t track, uint8_t sect,
                    int enable_seek)
@@ -258,7 +265,7 @@ static int fd_seek(FDrive *drv, uint8_t head, uint8_t track, uint8_t sect,
 #endif
         drv->head = head;
         if (drv->track != track) {
-            if (drv->blk != NULL && blk_is_inserted(drv->blk)) {
+            if (fd_media_present(drv)) {
                 drv->media_changed = 0;
             }
             ret = 1;
@@ -267,8 +274,8 @@ static int fd_seek(FDrive *drv, uint8_t head, uint8_t track, uint8_t sect,
         drv->sect = sect;
     }
 
-    if (drv->blk == NULL || !blk_is_inserted(drv->blk)) {
-        ret = 2;
+    if (!fd_media_present(drv)) {
+        ret = 5;
     }
 
     return ret;
@@ -1476,14 +1483,24 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
                                   NUM_SIDES(cur_drv)));
     switch (fd_seek(cur_drv, kh, kt, ks, fdctrl->config & FD_CONFIG_EIS)) {
     case 2:
-        /* sect too big */
+        /* track/head out of range */
         fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, 0x00, 0x00);
         fdctrl->fifo[3] = kt;
         fdctrl->fifo[4] = kh;
         fdctrl->fifo[5] = ks;
         return;
+    case 5:
+        /*
+         * No medium: there is no address mark to be found.  Guests that tell
+         * an absent diskette from an unreadable one rely on ST1.MA.
+         */
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_MA, 0x00);
+        fdctrl->fifo[3] = kt;
+        fdctrl->fifo[4] = kh;
+        fdctrl->fifo[5] = ks;
+        return;
     case 3:
-        /* track too big */
+        /* sector too big */
         fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
         fdctrl->fifo[3] = kt;
         fdctrl->fifo[4] = kh;
@@ -1791,14 +1808,21 @@ static void fdctrl_format_sector(FDCtrl *fdctrl)
                                   NUM_SIDES(cur_drv)));
     switch (fd_seek(cur_drv, kh, kt, ks, fdctrl->config & FD_CONFIG_EIS)) {
     case 2:
-        /* sect too big */
+        /* track/head out of range */
         fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, 0x00, 0x00);
         fdctrl->fifo[3] = kt;
         fdctrl->fifo[4] = kh;
         fdctrl->fifo[5] = ks;
         return;
+    case 5:
+        /* no medium */
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_MA, 0x00);
+        fdctrl->fifo[3] = kt;
+        fdctrl->fifo[4] = kh;
+        fdctrl->fifo[5] = ks;
+        return;
     case 3:
-        /* track too big */
+        /* sector too big */
         fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
         fdctrl->fifo[3] = kt;
         fdctrl->fifo[4] = kh;
@@ -2306,6 +2330,18 @@ static void fdctrl_result_timer(void *opaque)
     FDCtrl *fdctrl = opaque;
     FDrive *cur_drv = get_cur_drv(fdctrl);
 
+    /*
+     * An empty drive has no address marks to read.  Completing READ ID
+     * successfully, with the made-up sector ID left over from the "spinning"
+     * emulation below, tells the guest that a diskette is still present after
+     * it has been ejected.  The only error path left was a data rate mismatch,
+     * and media_rate is never reset when the medium is removed.
+     */
+    if (!fd_media_present(cur_drv)) {
+        FLOPPY_DPRINTF("read id on empty drive\n");
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_MA, 0x00);
+        return;
+    }
     /* Pretend we are spinning.
      * This is needed for Coherent, which uses READ ID to check for
      * sector interleaving.
diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 1b37a8a4d25..1e1dd8659d0 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -64,6 +64,12 @@ enum {
 
     DSKCHG  = 0x80,
 };
+enum {
+    ST0_IC_MASK  = 0xc0,    /* interrupt code */
+    ST0_IC_ABNTERM = 0x40,  /* abnormal termination */
+
+    ST1_MA       = 0x01,    /* missing address mark */
+};
 
 static char *test_image;
 
@@ -270,6 +276,21 @@ static void test_cmos(void)
     g_assert(cmos == 0x40 || cmos == 0x50);
 }
 
+static void media_insert(void)
+{
+    qtest_qmp_assert_success(global_qtest,
+                             "{'execute':'blockdev-change-medium', 'arguments':{"
+                             " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
+                             test_image);
+}
+
+static void media_eject(void)
+{
+    qtest_qmp_assert_success(global_qtest,
+                             "{'execute':'eject', 'arguments':{"
+                             " 'id':'floppy0' }}");
+}
+
 static void test_no_media_on_start(void)
 {
     uint8_t dir;
@@ -301,10 +322,7 @@ static void test_media_insert(void)
 
     /* Insert media in drive. DSKCHK should not be reset until a step pulse
      * is sent. */
-    qtest_qmp_assert_success(global_qtest,
-                             "{'execute':'blockdev-change-medium', 'arguments':{"
-                             " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
-                             test_image);
+    media_insert();
 
     dir = inb(FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
@@ -333,9 +351,7 @@ static void test_media_change(void)
 
     /* Eject the floppy and check that DSKCHG is set. Reading it out doesn't
      * reset the bit. */
-    qtest_qmp_assert_success(global_qtest,
-                             "{'execute':'eject', 'arguments':{"
-                             " 'id':'floppy0' }}");
+    media_eject();
 
     dir = inb(FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
@@ -414,6 +430,9 @@ static void test_read_id(void)
     uint8_t st0;
     uint8_t msr;
 
+    /* READ ID reads an address mark, so it needs a medium in the drive. */
+    media_insert();
+
     /* Seek to track 0 and check with READ ID */
     send_seek(0);
 
@@ -491,6 +510,42 @@ static void test_read_id(void)
     g_assert_cmpint(cyl, ==, 8);
     g_assert_cmpint(head, ==, 1);
     g_assert_cmpint(st0, ==, head << 2);
+
+    /* Leave the drive empty, the way the machine starts up. */
+    media_eject();
+}
+
+/*
+ * An empty drive spins no diskette, so READ ID finds no address mark and must
+ * terminate abnormally.  Reporting success (with a made-up sector ID) would
+ * tell the guest that a medium is still present after it has been ejected.
+ */
+static void test_read_id_no_media(void)
+{
+    uint8_t drive = 0;
+    uint8_t head = 0;
+    uint8_t st0, st1;
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
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_MA, ==, ST1_MA);
 }
 
 static void test_read_no_dma_1(void)
@@ -625,6 +680,7 @@ int main(int argc, char **argv)
     qtest_add_func("/fdc/sense_interrupt", test_sense_interrupt);
     qtest_add_func("/fdc/relative_seek", test_relative_seek);
     qtest_add_func("/fdc/read_id", test_read_id);
+    qtest_add_func("/fdc/read_id_no_media", test_read_id_no_media);
     qtest_add_func("/fdc/verify", test_verify);
     qtest_add_func("/fdc/media_insert", test_media_insert);
     qtest_add_func("/fdc/read_no_dma_1", test_read_no_dma_1);
-- 
2.55.0


