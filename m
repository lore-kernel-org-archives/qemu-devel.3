Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2EEC54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLtb-00076A-Tk; Thu, 30 Jul 2026 04:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtZ-000742-NF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:38 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtW-000184-De
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:37 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69ffb48d599so2922812a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399212; x=1786004012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fpQgSBzrn5OM98BFEFDTyUmHy0CoJsRx+U07A91OmgI=;
 b=hwlqlwAI49aWbVV8C7fTtkk1VWImiYPf5xTpSIcFcgvnNqMBjAOfneSUUTqnNJN4Y9
 hJh5dFi6ciGzmFlWxAIA8wcVKwAUSAw9clUyyW1/6f7r6vqfqxsEXcYX6BoEMjYQw/Qx
 B5tofjcFDofWMKfbjelBDj4pFkAcytvidjZbtNT9aSw5TKE3uf3lC8XYntrb9ZmC0Em+
 F09oYGuv9YxhYsaA2Z8UV5gzh0Fu/ZYfXTZRQVsN4WyxG47BXzMGWgtVI8feU9R+dWnT
 44fx3zJ3yplq47PBADd1q5cY0T7DfRI4asddLP2mciuaEueTE73xtvjp3xdecO85l9Um
 g4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399212; x=1786004012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fpQgSBzrn5OM98BFEFDTyUmHy0CoJsRx+U07A91OmgI=;
 b=a8kdThOX4dcRX+V3CA2LHAW8XWkV0DaT14bV9oJtbGHiKODNuN2nX4hqAAhMeKkLFI
 WMHD0Huw2sF9wX/IvrwRHXUsxPeRpDcq8/fULzSnm24dkURg6IDO4wB8l3DETgYv5OcZ
 UKbunJNwv9+RpstuI26a6LcuVfjysszz4J+GKbO999aCMZ9Y0T807umwd+RBm2+SD7qM
 b7gtftPRYwOjUKwJMYBRsPAcnIfLW8M0+7xGNtiG+xgCvR+HVHwGlgw9Vrfco4Uhq/fe
 7wXa4u4bELl1WIqxFKc95/KFDJ/eVoNT0MHXWANOrNfu0CWqLXcJQlJkRyNm8khmKQk9
 HanA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRvszMH8JFUKuuvXEYj5HvuOkyChotWJxfEp+hhhlTar3m40TX5moichM9nglCLN4JQ1fHMb5XQvMH@nongnu.org
X-Gm-Message-State: AOJu0YzJmkvGARzRhCLFk3tu9+n904HAAy7yn3BBn5zFXvKnip43dXGO
 jFgbnMBsaCayax1XZqhph+lDmWz4lA23pQm9SA/1MQPEJQfvqiotA+/UA7/8AzAj3Ek=
X-Gm-Gg: AR+sD11Wf7rWCtODglJYQF4tQQUSr18faSy3xRfJ6v4Nr8VxOdu/CjFjmEZ9bxRRg3l
 hCmmSxkyCdDHe65frhqdKyI1u3G12HWrGKiAXulvJP/p3h2axBLHeEL9RyIAIAAtt2zdPFO7plU
 2ljb2Ofm8swfpDji4tUAFvimamtqLM76ozl1BQChTyKfYoiiZ9nQFPxAkYN9R1gEgmd5Yza1Hg8
 MOek5/YBhNZTG0z1fdE2RQlOGgy2y+cwl7ccUWRO849cpH3QyjMD1XKVOnYrzzwqOV6TnTflGSH
 qtAhoB90FgueeMSmDmC4aHIg9auJfO7KkxUjZM5/DfhztPTMBGqf+x/EmaG/deaX9BThV2UR8Jy
 lTsDEIsISlTYsU71rRLPoigwCm3LK14EecScKAEb4gq6k8sfPGfZ02i/QoxkL2QnXgr/B0wfODH
 QqhUl3oBb5NHUsZWZN6rGgVaxvcyCiaPha2IfACdoLPPQFQ53xDA==
X-Received: by 2002:a05:6938:a08c:10b0:c12:40c2:9d09 with SMTP id
 a640c23a62f3a-c1fa55be9d5mr55349166b.12.1785399211979; 
 Thu, 30 Jul 2026 01:13:31 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 4/8] tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
Date: Thu, 30 Jul 2026 10:13:20 +0200
Message-ID: <20260730081325.1816193-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730081325.1816193-1-den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=den@openvz.org; helo=mail-ed1-x533.google.com
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
 tests/qtest/ide-test.c | 75 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 2c674edf15..b36b0f8875 100644
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
@@ -982,6 +986,40 @@ static void send_scsi_cdb_read10(QPCIDevice *dev, QPCIBar ide_bar,
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
 
 static void nsleep(QTestState *qts, int64_t nsecs)
 {
@@ -1037,10 +1075,12 @@ static void ide_wait_intr(QTestState *qts, int irq)
 
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
@@ -1048,8 +1088,11 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
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
@@ -1076,8 +1119,7 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         prdt[0].size = cpu_to_le32(rxsize | PRDT_EOT);
 
         send_dma_request_dev(qts, dev, bmdma_bar, ide_bar, CMD_PACKET, 0,
-                             nblocks, prdt, ARRAY_SIZE(prdt),
-                             send_scsi_cdb_read10);
+                             nblocks, prdt, ARRAY_SIZE(prdt), send_cdb);
 
         qtest_memread(qts, guest_buf, rx, rxsize);
     } else {
@@ -1094,8 +1136,7 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         assert_bit_set(data, DRQ | DRDY);
         assert_bit_clear(data, ERR | DF | BSY);
 
-        /* SCSI CDB (READ10) -- read n*2048 bytes from block 0 */
-        send_scsi_cdb_read10(dev, ide_bar, 0, nblocks);
+        send_cdb(dev, ide_bar, 0, nblocks);
 
         /*
          * Read data back: occurs in bursts of 'BYTE_COUNT_LIMIT' bytes.
@@ -1135,7 +1176,17 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
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
@@ -1164,6 +1215,16 @@ static void test_cdrom_dma_large(void)
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
@@ -1224,6 +1285,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio_large", test_cdrom_pio_large);
     qtest_add_func("/ide/cdrom/dma", test_cdrom_dma);
     qtest_add_func("/ide/cdrom/dma_large", test_cdrom_dma_large);
+    qtest_add_func("/ide/cdrom/pio_raw", test_cdrom_pio_raw);
+    qtest_add_func("/ide/cdrom/dma_raw", test_cdrom_dma_raw);
 
     ret = g_test_run();
 
-- 
2.53.0


