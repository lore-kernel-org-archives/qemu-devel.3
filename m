Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCE606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=r+2AonWy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp3C-0004l6-5H; Fri, 27 Nov 2026 01:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1g-0003F1-6G; Fri, 27 Nov 2026 01:01:42 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1J-0005bh-Bw; Fri, 27 Nov 2026 01:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=iL4EHur2Q6OFxkmdlJipLn7VnN7tPLH4nHzV+RCdWNk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=r+2AonWyeC5T7MwDqcwzFCPFmb6eIaqj35Mk+uExDHouYnPkcjZw02hyyKA0eevlX
 20P52U/Fa0uvi+p0uSfpctaRTPNelgRdtYhm6qpLMXoQpLvLVvlpf7rI/gZzyTnsMl
 SZWHuXNccyKy9BeM5whd1bhHa6n5b+c8fIc61zw//8lAdgyVH9ywS6DDgF0hG43yHX
 YEXilP/NPKVSfkgspTg3+YfNhG/p5X5MFlSmxq85uaXL56pCNESQnwpd+N+YXOilJD
 JL2mLd2G+VnOzZSa+zxyC9XCHyy6LHgvmVOUCc++4gvu/W/FOiPuxFg2czaoLXQUx4
 Oi+2CeFa4aNaw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C7AAF1EA30E;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C551E46994E;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A0794CF29C; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 131/140] hw/ide/atapi: fix abort on CD-ROM reads
 past LBA 2^31
Date: Fri, 27 Nov 2026 08:53:57 +0300
Message-ID: <20261127055421.39015-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

cmd_read() and cmd_read_cd() check the 32-bit LBA from the CDB against
the medium size, then pass it to ide_atapi_cmd_read() as an int. On a
medium larger than 4 TiB, a read at LBA 2^31 or above passes the range
check, turns negative and trips the assertion:

  hw/ide/atapi.c:315: ide_atapi_cmd_read_pio: Assertion
  `0 <= lba && lba < (s->nb_sectors >> 2)' failed.

Reading the last sector is enough, e.g. a UDF anchor probe, so the
guest aborts QEMU just by looking at the disc.

Pass the LBA as uint32_t, which is what the CDB carries, and widen
IDEState.lba to int64_t so it holds every valid LBA and keeps -1 as
the "not a sector read" marker. The field is not migrated.

Fixes: b8d7f1bc5927 ("ide: atapi: check logical block address and read size (CVE-2020-29443)")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261112133455.604657-1-den@openvz.org>
[PMD: Avoid wrapping at 2^32 in range check]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Message-ID: <20261112133455.604657-1-den@openvz.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit f2a3eb6bcf80f0c02635be67177ed10547d16f30)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 0ea149ad8c6..aec20f968da 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -47,7 +47,7 @@ static void padstr8(uint8_t *buf, int buf_size, const char *src)
     }
 }
 
-static void lba_to_msf(uint8_t *buf, int lba)
+static void lba_to_msf(uint8_t *buf, int64_t lba)
 {
     lba += 150;
     buf[0] = (lba / 75) / 60;
@@ -71,7 +71,7 @@ static inline int media_is_cd(IDEState *s)
     return (media_present(s) && s->nb_sectors <= CD_MAX_SECTORS);
 }
 
-static void cd_data_to_raw(uint8_t *buf, int lba)
+static void cd_data_to_raw(uint8_t *buf, int64_t lba)
 {
     /* sync bytes */
     buf[0] = 0x00;
@@ -309,10 +309,10 @@ static void ide_atapi_cmd_reply(IDEState *s, int size, int max_size)
 }
 
 /* start a CD-ROM read command */
-static void ide_atapi_cmd_read_pio(IDEState *s, int lba, int nb_sectors,
-                                   int sector_size)
+static void ide_atapi_cmd_read_pio(IDEState *s, uint32_t lba,
+                                   int nb_sectors, int sector_size)
 {
-    assert(0 <= lba && lba < (s->nb_sectors >> 2));
+    assert(lba < (s->nb_sectors >> 2));
 
     s->lba = lba;
     s->packet_transfer_size = nb_sectors * sector_size;
@@ -409,10 +409,10 @@ eot:
 
 /* start a CD-ROM read command with DMA */
 /* XXX: test if DMA is available */
-static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
-                                   int sector_size)
+static void ide_atapi_cmd_read_dma(IDEState *s, uint32_t lba,
+                                   int nb_sectors, int sector_size)
 {
-    assert(0 <= lba && lba < (s->nb_sectors >> 2));
+    assert(lba < (s->nb_sectors >> 2));
 
     s->lba = lba;
     s->packet_transfer_size = nb_sectors * sector_size;
@@ -427,7 +427,7 @@ static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
     ide_start_dma(s, ide_atapi_cmd_read_dma_cb);
 }
 
-static void ide_atapi_cmd_read(IDEState *s, int lba, int nb_sectors,
+static void ide_atapi_cmd_read(IDEState *s, uint32_t lba, int nb_sectors,
                                int sector_size)
 {
     trace_ide_atapi_cmd_read(s, s->atapi_dma ? "dma" : "pio",
@@ -983,7 +983,7 @@ static void cmd_read(IDEState *s, uint8_t* buf)
     }
 
     lba = ldl_be_p(buf + 2);
-    if (lba >= total_sectors || lba + nb_sectors - 1 >= total_sectors) {
+    if (lba >= total_sectors || nb_sectors > total_sectors - lba) {
         ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR);
         return;
     }
@@ -1005,7 +1005,7 @@ static void cmd_read_cd(IDEState *s, uint8_t* buf)
     }
 
     lba = ldl_be_p(buf + 2);
-    if (lba >= total_sectors || lba + nb_sectors - 1 >= total_sectors) {
+    if (lba >= total_sectors || nb_sectors > total_sectors - lba) {
         ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR);
         return;
     }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index c8e8e44cc9a..f1e8eca7ec0 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -396,7 +396,7 @@ static void ide_dbdma_start(const IDEDMA *dma, IDEState *s,
     MACIO_DPRINTF("\n\n------------ IDE transfer\n");
     MACIO_DPRINTF("buffer_size: %x   buffer_index: %x\n",
                   s->io_buffer_size, s->io_buffer_index);
-    MACIO_DPRINTF("lba: %x    size: %x\n", s->lba, s->io_buffer_size);
+    MACIO_DPRINTF("lba: %" PRIx64 "    size: %x\n", s->lba, s->io_buffer_size);
     MACIO_DPRINTF("-------------------------\n");
 
     m->dma_active = true;
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 57042cafddc..b38ac7a2edd 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -48,17 +48,17 @@ bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"
 
 # atapi.c
 cd_read_sector_sync(int lba) "lba=%d"
-cd_read_sector_cb(int lba, int ret) "lba=%d ret=%d"
-cd_read_sector(int lba) "lba=%d"
+cd_read_sector_cb(int64_t lba, int ret) "lba=%"PRId64" ret=%d"
+cd_read_sector(int64_t lba) "lba=%"PRId64
 ide_atapi_cmd_error(void *s, int sense_key, int asc) "IDEState: %p; sense=0x%x asc=0x%x"
 ide_atapi_cmd_reply_end(void *s, int tx_size, int elem_tx_size, int32_t index) "IDEState %p; reply: tx_size=%d elem_tx_size=%d index=%"PRId32
 ide_atapi_cmd_reply_end_eot(void *s, int status) "IDEState: %p; end of transfer, status=0x%x"
 ide_atapi_cmd_reply_end_bcl(void *s, int bcl) "IDEState: %p; byte_count_limit=%d"
 ide_atapi_cmd_reply_end_new(void *s, int status) "IDEState: %p; new transfer started, status=0x%x"
 ide_atapi_cmd_check_status(void *s) "IDEState: %p"
-ide_atapi_cmd_read(void *s, const char *method, int lba, int nb_sectors) "IDEState: %p; read %s: LBA=%d nb_sectors=%d"
+ide_atapi_cmd_read(void *s, const char *method, uint32_t lba, int nb_sectors) "IDEState: %p; read %s: LBA=%"PRIu32" nb_sectors=%d"
 ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
-ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p; aio read: lba=%d n=%d"
+ide_atapi_cmd_read_dma_cb_aio(void *s, int64_t lba, int n) "IDEState: %p; aio read: lba=%"PRId64" n=%d"
 # Warning: Verbose
 ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDEState: %p; limit=0x%x packet: %s"
 
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 92e88687800..d6f646528aa 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -101,7 +101,7 @@ struct IDEState {
     int packet_transfer_size;
     int elementary_transfer_size;
     int32_t io_buffer_index;
-    int lba;
+    int64_t lba;
     int cd_sector_size;
     int atapi_dma; /* true if dma is requested for the packet cmd */
     BlockAcctCookie acct;
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 0daa6c6d369..bea9f050a62 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1691,6 +1691,40 @@ static void test_cdrom_pio_raw(void)
     ahci_test_cdrom_raw(3, false);
 }
 
+/* Regression test: read the last sector of a medium over 4 TiB. */
+static void ahci_test_cdrom_high_lba(bool dma)
+{
+    AHCIQState *ahci;
+    g_autofree unsigned char *tx = g_malloc0(ATAPI_SECTOR_SIZE);
+    uint64_t lba = (uint64_t)INT32_MAX + 1;
+    AHCIOpts opts = {
+        .size = ATAPI_SECTOR_SIZE,
+        .lba = lba,
+        .atapi = true,
+        .atapi_dma = dma,
+        .post_cb = ahci_cb_cmp_buff,
+        .opaque = tx,
+    };
+
+    ahci = ahci_boot_and_enable("-blockdev driver=null-co,node-name=cd0,"
+                                "read-only=on,read-zeroes=on,size=%" PRIu64 " "
+                                "-M q35 "
+                                "-device ide-cd,drive=cd0 ",
+                                (lba + 1) * ATAPI_SECTOR_SIZE);
+    ahci_exec(ahci, ahci_port_select(ahci), CMD_ATAPI_READ_10, &opts);
+    ahci_shutdown(ahci);
+}
+
+static void test_cdrom_dma_high_lba(void)
+{
+    ahci_test_cdrom_high_lba(true);
+}
+
+static void test_cdrom_pio_high_lba(void)
+{
+    ahci_test_cdrom_high_lba(false);
+}
+
 /*
  * Regression test: a buffered ATAPI read completing after a command
  * engine restart must not dereference the cleared cur_cmd. Cover both
@@ -2235,6 +2269,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/cdrom/pio/single", test_cdrom_pio);
     qtest_add_func("/ahci/cdrom/pio/multi", test_cdrom_pio_multi);
     qtest_add_func("/ahci/cdrom/pio/raw", test_cdrom_pio_raw);
+    qtest_add_func("/ahci/cdrom/dma/high_lba", test_cdrom_dma_high_lba);
+    qtest_add_func("/ahci/cdrom/pio/high_lba", test_cdrom_pio_high_lba);
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
-- 
2.47.3


