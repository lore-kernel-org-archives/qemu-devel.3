Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03996C55838
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIVI-0008W9-KJ; Tue, 04 Aug 2026 13:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIVA-0008Ul-5Y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:34 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIV8-0000hS-58
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so7601f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785862825; x=1786467625; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wLakvxnIRFSxCYZO4hGDcvxqjxdPRortIqu6+A1Fb4I=;
 b=rZJvEpcfI9W7C2dOrVYMmtYY3w8lINRNz8omdAVtVyduqskbtPF0eQi+sBkJSlcc3M
 9wUSFt69LEQqO7unN3bOwDI9Cq5QNP6rKegf8Lm45RM7jVjN77KFB60hKPOE7CoR2qwL
 fwD1ktDHYK1Iv8lRV///VZiES1RuIFPO9OpP6KUDkuN/rv/9cKvUBsS6DvhofjbqQh+H
 XK1byp1gdKGdmiWne6T2yPcxFUYXgkwIS9TOgAEaCZlOKelLxTSJfQ18SGuXgTfCOEuf
 100iwc1wiaNQyTrQp+g2vxK7k+bbv8OaR1AivAb9EIriZ6oaKxn90tOD0Vf6O0++CQRH
 MTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785862825; x=1786467625;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wLakvxnIRFSxCYZO4hGDcvxqjxdPRortIqu6+A1Fb4I=;
 b=m1VPfTkH1WFWvKpDe1Ue43TzAKwF6jw1uARbkuZy63nYG35BH148UAWhr1I5S4d2p7
 eTfI/tnu+fj/7sYxzdS3NFBWocNxu7dblg9qf7uCdj0BO2/bmIEyyI2ujXOLHGNX3PGj
 4nQXUanAoSsln5wuZdltl3bxiKmWIBdnYGO777OTTsUyiRYSkeIMfOrYq4OAOA36IY+r
 RvDFbGQqEWhG7rlVd9Ylmc13alwskbIhIfeiFNE5KF/bpsGSu+1OBm10VuYEkeknyq4U
 pY4EY8UJA2GxzaX0Cm1oIdRT3AhjAGwjjDemCApVF2Y9JRnoEOsshCpN3kAxFCZEm4VU
 xZ+w==
X-Gm-Message-State: AOJu0Yw7B9TnyuqDL6K50ATFq3S6nwkjjWdI9bg9vz2D8BG4uMytkc85
 SP7O78L/FyOitpl4dtO/vTbkDkO1+gjMhq9uJenewqSYh2dqanylwLKrOvL2RVq97kT5bPbYtYd
 U3YQx
X-Gm-Gg: AR+sD12/KtIWfe8mv4tZrsM0HIXLspur7elkAgXf2pTAMm8IHHJfDx93efDeGheoVWR
 ZgMZtq9UAkZn0vWLOvcpf9PVn3ElQ6DPOqNuCt9GaqHKoTARd3iSaKfSUQGwhITdZt+gt1W8LSB
 v8sb1NopYEv8++kKrLvvgup9iqWyMByGp9JySAbHPV3jpWa9HS1ZqT4zR+ZhNHcl3v8ZlcY7ONl
 hxfimp3GSipe/qw9ALc50lccZhJVbzOMjyH68o9sTw1HyN0a6x1X615k/OlPhoyeZmwJYNGxCA+
 3ix/NQJKo53jkPlAs/qCZ3hXhK3RjPt7ToWyx3WhkiHTdpQQbko+jJPsbdtDVVqFmQf9yQjp3YV
 Uwa+jRqW5/BznfN4y2bX53EjepIff/DybAEok9IBdLLLcAgWLUHYczZF7yc0J26HKDITj9dV2hi
 pcjH/UbPxBr8U9EcMUgGJbbqX8KZzkI9GnDkOxPDAEhWmVrQ==
X-Received: by 2002:a05:6000:290a:b0:47f:9283:1fb3 with SMTP id
 ffacd0b85a97d-47fec478c10mr1211134f8f.0.1785862822974; 
 Tue, 04 Aug 2026 10:00:22 -0700 (PDT)
Received: from athena ([213.133.28.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23ec3asm1234116f8f.31.2026.08.04.10.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:00:22 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 3/7] tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD
 reads
Date: Tue,  4 Aug 2026 19:00:10 +0200
Message-ID: <20260804170015.3128363-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804170015.3128363-1-den@openvz.org>
References: <20260804170015.3128363-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

READ CD with the field-selector set to 0xf8 returns full 2352-byte
raw sectors (sync + header + 2048 data + EDC/ECC), driving the ATAPI
raw read path that READ10 never touches. Add a send_scsi_cdb_read_cd()
helper and a CDROM_RAW flag to cdrom_read_impl(), then exercise both
PIO and DMA. The PIO case uses a byte-count limit spanning several
raw sectors so the device must rebuffer mid-burst, and each sector's
2048-byte payload is verified at its in-sector offset.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ide-test.c | 76 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 6e59197566..b36b0f8875 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -48,6 +48,10 @@
 
 #define ATAPI_BLOCK_SIZE 2048
 
+/* Raw READ CD sector: 12 sync + 4 header + 2048 data + 288 EDC/ECC. */
+#define ATAPI_RAW_SIZE   2352
+#define ATAPI_RAW_DATA   16
+
 /* How many bytes to receive via ATAPI PIO at one time.
  * Must be less than 0xFFFF. */
 #define BYTE_COUNT_LIMIT 5120
@@ -982,6 +986,41 @@ static void send_scsi_cdb_read10(QPCIDevice *dev, QPCIBar ide_bar,
     }
 }
 
+typedef struct ReadCDCDB {
+    uint8_t opcode;
+    uint8_t sector_type;
+    uint32_t lba;
+    uint8_t length[3];
+    uint8_t main_channel;
+    uint8_t sub_channel;
+    uint8_t control;
+} __attribute__((__packed__)) ReadCDCDB;
+
+static void send_scsi_cdb_read_cd(QPCIDevice *dev, QPCIBar ide_bar,
+                                  uint64_t lba, int nblocks)
+{
+    ReadCDCDB pkt = { };
+    int i;
+
+    g_assert_cmpint(lba, <=, UINT32_MAX);
+    g_assert_cmpint(nblocks, >=, 0);
+    g_assert_cmpint(nblocks, <=, 0xffffff);
+
+    /* Construct SCSI CDB packet */
+    pkt.opcode = 0xbe;
+    pkt.lba = cpu_to_be32(lba);
+    pkt.length[0] = (nblocks >> 16) & 0xff;
+    pkt.length[1] = (nblocks >> 8) & 0xff;
+    pkt.length[2] = nblocks & 0xff;
+    pkt.main_channel = 0xf8; /* sync + headers + user data + EDC/ECC: 2352 */
+
+    /* Send Packet */
+    for (i = 0; i < sizeof(ReadCDCDB) / 2; i++) {
+        qpci_io_writew(dev, ide_bar, reg_data,
+                       le16_to_cpu(((uint16_t *)&pkt)[i]));
+    }
+}
+
 static void nsleep(QTestState *qts, int64_t nsecs)
 {
     const struct timespec val = { .tv_nsec = nsecs };
@@ -1036,10 +1075,12 @@ static void ide_wait_intr(QTestState *qts, int irq)
 
 #define CDROM_PIO 0
 #define CDROM_DMA (1 << 0)
+#define CDROM_RAW (1 << 1)
 
 static void cdrom_read_impl(int nblocks, unsigned flags)
 {
     bool dma = flags & CDROM_DMA;
+    bool raw = flags & CDROM_RAW;
     QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
@@ -1047,8 +1088,11 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
     int patt_blocks = MAX(16, nblocks);
     size_t patt_len = ATAPI_BLOCK_SIZE * patt_blocks;
     char *pattern = g_malloc(patt_len);
-    size_t rxsize = ATAPI_BLOCK_SIZE * nblocks;
+    unsigned xfer = raw ? ATAPI_RAW_SIZE : ATAPI_BLOCK_SIZE;
+    size_t rxsize = xfer * nblocks;
     uint16_t *rx = g_malloc0(rxsize);
+    void (*send_cdb)(QPCIDevice *, QPCIBar, uint64_t, int) =
+        raw ? send_scsi_cdb_read_cd : send_scsi_cdb_read10;
     int i, j;
     uint8_t data;
     uint16_t limit;
@@ -1075,8 +1119,7 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         prdt[0].size = cpu_to_le32(rxsize | PRDT_EOT);
 
         send_dma_request_dev(qts, dev, bmdma_bar, ide_bar, CMD_PACKET, 0,
-                             nblocks, prdt, ARRAY_SIZE(prdt),
-                             send_scsi_cdb_read10);
+                             nblocks, prdt, ARRAY_SIZE(prdt), send_cdb);
 
         qtest_memread(qts, guest_buf, rx, rxsize);
     } else {
@@ -1093,8 +1136,7 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         assert_bit_set(data, DRQ | DRDY);
         assert_bit_clear(data, ERR | DF | BSY);
 
-        /* SCSI CDB (READ10) -- read n*2048 bytes from block 0 */
-        send_scsi_cdb_read10(dev, ide_bar, 0, nblocks);
+        send_cdb(dev, ide_bar, 0, nblocks);
 
         /*
          * Read data back: occurs in bursts of 'BYTE_COUNT_LIMIT' bytes.
@@ -1134,7 +1176,17 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         assert_bit_clear(data, DRQ | ERR | DF | BSY);
     }
 
-    g_assert_cmpint(memcmp(pattern, rx, rxsize), ==, 0);
+    if (raw) {
+        /* The 2048-byte payload of each raw sector sits past its header. */
+        for (i = 0; i < nblocks; i++) {
+            uint8_t *sec = (uint8_t *)rx + i * ATAPI_RAW_SIZE + ATAPI_RAW_DATA;
+
+            g_assert_cmpint(memcmp(sec, pattern + i * ATAPI_BLOCK_SIZE,
+                                   ATAPI_BLOCK_SIZE), ==, 0);
+        }
+    } else {
+        g_assert_cmpint(memcmp(pattern, rx, rxsize), ==, 0);
+    }
 
     g_free(pattern);
     g_free(rx);
@@ -1163,6 +1215,16 @@ static void test_cdrom_dma_large(void)
     cdrom_read_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE, CDROM_DMA);
 }
 
+static void test_cdrom_pio_raw(void)
+{
+    cdrom_read_impl(4, CDROM_RAW);
+}
+
+static void test_cdrom_dma_raw(void)
+{
+    cdrom_read_impl(4, CDROM_DMA | CDROM_RAW);
+}
+
 int main(int argc, char **argv)
 {
     const char *base;
@@ -1223,6 +1285,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio_large", test_cdrom_pio_large);
     qtest_add_func("/ide/cdrom/dma", test_cdrom_dma);
     qtest_add_func("/ide/cdrom/dma_large", test_cdrom_dma_large);
+    qtest_add_func("/ide/cdrom/pio_raw", test_cdrom_pio_raw);
+    qtest_add_func("/ide/cdrom/dma_raw", test_cdrom_dma_raw);
 
     ret = g_test_run();
 
-- 
2.53.0


