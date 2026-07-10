Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501EEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAF2-0007Ap-S1; Fri, 10 Jul 2026 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wi9T0-0001xG-OT; Fri, 10 Jul 2026 07:32:26 -0400
Received: from nx88.node02.secure-mailgate.com ([192.162.87.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wi9Sx-0006wi-Qd; Fri, 10 Jul 2026 07:32:26 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wi9Sq-00HKFm-W4; Fri, 10 Jul 2026 13:32:18 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1783683136;
 bh=6414y4kTtvzrlkqe4Ebi20IA8O49EC/0RSMmnQuEDm4=;
 h=From:To:Cc:Subject:Date:From;
 b=thdIzeCKGeA7DDwqAiKgO6uNVjkgEiE9GvsaylI06/IaUi3DcOsFwy1KHVOW+oDO1
 62XzM4VFt8bygRTyoLcMwRFH3NMA/VkCIwp+2xO+fTdBKd44xZcgeNRpGzYepquJcU
 QCeSVSntLc6/zHJ1X53qHsuNvZ1s/asnkvdS96kY=
Received: from Zeuss.fritz.box (p549f114c.dip0.t-ipconnect.de [84.159.17.76])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id E3F59280E15;
 Fri, 10 Jul 2026 13:32:15 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Christian Quante <christian@quante.one>
Subject: [PATCH] hw/block/fdc: report a missing address mark on an empty drive
Date: Fri, 10 Jul 2026 13:31:34 +0200
Message-ID: <20260710113134.43012-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178368313656.2438225.12674447762201461569@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.000761102268232)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV505QqXA40dScctB9ZkOV/TG4yhwDcAtVj
 auu8FFR/Siu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4aLQUrc2xNuz3Ni+FVmA21TS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RPdEorPfEdXy94XZtjluxSTdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS78HF9DWBc0WhbQl3RlROHMl5OjAPt7LlMbhgG9BOAmXwBM2j5REykHorDckk/GS
 XMyjmcTOVEFl0KPc6uJqilaCXufEjWR3z+AWvVFWQY81MMXgHqsZsdeRNOsJiUZKcSGGNbRtTTvH
 yMh9cHL3rNDiMj+2zmSJ0EBZo1TB2whxtLBO1aW+S0F+BiF484m+iUauTs7xNBSWOfSV8rW4+oS7
 kgROQcn1o6DQM43M2oFjvPWzx4/NwynfOKP1pMr/GL3fQ7Ll39M3jvbVlMF3GbflgTl6fJxyntEf
 hZCKje4ZA5fqC8lYaDTME5ZYBQLe48qxHAe5l0LM6yP4yEoD+uF2BAXUo/rlcH2OyEbAaTJITfD6
 cxsdFKDXY5IAQfIM9dULjz7Syv7lJluPqCYXYmWWWmHQO2Wo0rQo7xg704WPHHASBEtOU1U47BPe
 RqBMKlGsLaSx5tG/qyy343AqAH+guFKt81oxvawsnijMDRoeVLZUqBRpe/hFT1PfAkLAinQTWD1o
 6XfJ7I/Q7aDkG77cE27HYsS1hL9r79a2NbY89Z/P3/GjZxZlVCzQ1iRdPDfTAvgmoB4+6nUbbCPf
 hCLNLn8TFpOGxupnCk+pu3oj3D7LWayTvsTRp+LnpcCLSG9Cy9pUq1qBliwK0eYZU0Hfwfeq0Gs5
 jBUIsbYziyUjPAlbDjazCbhs7qBpykynMuPYa6ShWBbVWiEYkA/rZsO/h+dRP1Xrx4wecMslK13B
 3fC+v8qCaU0Ws+NeAeSstkzQozqPXjg3Y4qLwvtRAtxbzvXYPnYyGSP6kubteNM4KMADmSgTOnv2
 2Aeeug8bgxYUOdLJJ/0EjUkVXcU1fEoiaaZJUo8XgjWJF4llj/IM7DYzFfTn4NXnBjEun9DvZ0bJ
 vJi4ajfmXJh0zN6bM4M=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.88; envelope-from=christian@quante.one;
 helo=nx88.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:33 -0400
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

READ ID on a drive with no medium terminates normally and returns the
made-up sector ID left over from the "Pretend we are spinning" emulation.
The only error path is a data rate mismatch, and media_rate is assigned
solely by pick_geometry(); it is never reset when the medium is removed.
A guest that has just ejected a diskette is therefore told that one is
still present.

READ and WRITE have a related problem: fd_seek() returns 2 both for
"track/head out of range" and for "no medium", and fdctrl_start_transfer()
reports that as ST0 = ABNTERM with ST1 = 0x00.  Without ST1.MA the guest
cannot tell an absent diskette from a transient error.

Fail READ ID with ST0 = ABNTERM and ST1 = MA when the drive is empty, and
set ST1.MA in the fd_seek() case 2 path when no medium is present.  This
does not make guests detect the removal -- real hardware never completes
READ ID on an empty drive, because there are no index pulses, and OS/2 for
one relies on that timeout -- but it stops the controller from claiming a
diskette that is not there.

tests/qtest/fdc-test.c starts QEMU with "-device floppy,id=floppy0" and no
medium, so the drive is empty for the whole run, and test_read_id asserts a
normal termination with a fabricated cylinder 8 / head 1.  That contradicts
its neighbours test_no_media_on_start and test_media_change, which state
that DSKCHG signals an absent medium.  Insert a medium before READ ID and
eject it afterwards -- the rewritten test passes before and after this
change -- and add test_read_id_no_media to cover the empty drive.

Guests checked, reading and writing, with and without a medium: Linux
2.0.34 and 7.0, PC-DOS 7, IBM DOS 5.02, Windows for Workgroups 3.11 and
OS/2 2.11.  None changes behaviour.  No version of the Linux floppy driver
from 1.2.13 to master issues READ ID at all -- FD_READID is defined in the
uapi header for FDRAWCMD users and the driver never sends it -- so Linux
detects an empty drive by stepping the head and reading DSKCHG instead.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3971
Signed-off-by: Christian Quante <christian@quante.one>
---
 hw/block/fdc.c         | 29 +++++++++++++++--
 tests/qtest/fdc-test.c | 73 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2c1681b7d0..8895e39cb6 100644
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
@@ -1476,8 +1482,15 @@ static void fdctrl_start_transfer(FDCtrl *fdctrl, int direction)
                                   NUM_SIDES(cur_drv)));
     switch (fd_seek(cur_drv, kh, kt, ks, fdctrl->config & FD_CONFIG_EIS)) {
     case 2:
-        /* sect too big */
-        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, 0x00, 0x00);
+        /*
+         * Track/head out of range, or no medium at all.  Only the latter can
+         * be told apart by the guest, through ST1.MA: with no diskette in the
+         * drive there is no address mark to be found.  Guests that
+         * distinguish an absent medium from an unreadable one rely on this.
+         */
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM,
+                             fd_media_present(cur_drv) ? 0x00 : FD_SR1_MA,
+                             0x00);
         fdctrl->fifo[3] = kt;
         fdctrl->fifo[4] = kh;
         fdctrl->fifo[5] = ks;
@@ -2303,6 +2316,18 @@ static void fdctrl_result_timer(void *opaque)
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
index 1b37a8a4d2..fa57a8b7cf 100644
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
@@ -414,6 +430,12 @@ static void test_read_id(void)
     uint8_t st0;
     uint8_t msr;
 
+    /*
+     * READ ID reads the address mark of the sector currently under the head,
+     * so it needs a medium.  The preceding tests left the drive empty.
+     */
+    media_insert();
+
     /* Seek to track 0 and check with READ ID */
     send_seek(0);
 
@@ -491,6 +513,42 @@ static void test_read_id(void)
     g_assert_cmpint(cyl, ==, 8);
     g_assert_cmpint(head, ==, 1);
     g_assert_cmpint(st0, ==, head << 2);
+
+    /* Leave the drive as the following tests expect to find it. */
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
@@ -625,6 +683,7 @@ int main(int argc, char **argv)
     qtest_add_func("/fdc/sense_interrupt", test_sense_interrupt);
     qtest_add_func("/fdc/relative_seek", test_relative_seek);
     qtest_add_func("/fdc/read_id", test_read_id);
+    qtest_add_func("/fdc/read_id_no_media", test_read_id_no_media);
     qtest_add_func("/fdc/verify", test_verify);
     qtest_add_func("/fdc/media_insert", test_media_insert);
     qtest_add_func("/fdc/read_no_dma_1", test_read_no_dma_1);
-- 
2.53.0


