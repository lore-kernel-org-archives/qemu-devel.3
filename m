Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470D606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpYMfesH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1OI-0001zb-Ts; Fri, 27 Nov 2026 14:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nk-0001oF-Pu; Fri, 27 Nov 2026 14:13:17 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Ni-0006h4-7G; Fri, 27 Nov 2026 14:13:16 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05D0D611E2;
 Fri, 27 Nov 2026 19:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBE91F0089C;
 Fri, 27 Nov 2026 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806792;
 bh=uy9Q7GY0lmCcJqUfxyPIVDl+ko/IhNroj3ddpgWPNb0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IpYMfesHd/91aKGyJH4M2Sa2amXT9Jf3nmNGHPzFMUUWvZLF8cAQQgbp8Nb1I3el3
 mAbBQify0wtBwRWZON5nEuRVE4NxCB/kZhraANrz66ycuutoIHXnaSPoDPjzNO/uzq
 TGcr79VNTk2hzUzg9ko9FQ5V+4ONSNcV49AD3BvHLqBppksDo+qigPm8nMsL9OzwDY
 pry74YPUysGpHESIUUyDayxnUB4x+lSSUBC04f2oBNvR1clAmzG34FyHAFBq2FvbGr
 VIEmKsiJEJgSRoKTY0v6J5RRY7SsM1+PyUMJRmqrAgRTy456V9owzhmTSeMZCJ6YRb
 BacjvqxkyasGg==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 06/13] hw/ide: add the IDENTIFY DEVICE data log
Date: Fri, 27 Nov 2026 20:12:41 +0100
Message-ID: <20261127191250.3298004-7-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the IDENTIFY DEVICE data log (30h).
The IDENTIFY DEVICE data log is a mandatory log in the GPL feature set.

Implement it with pages 00h to 06h and 08h, which are all the pages that
ACS-6 9.11.1 makes mandatory for a SATA device, and list it in the General
Purpose Log Directory.

The Supported Capabilities (03h), Current Settings (04h) and Serial ATA
(08h) pages copy their bits from the IDENTIFY DEVICE data, so that they
cannot disagree with it.

Extend the read log qtests to check the pages, and to read two pages
with one READ LOG DMA EXT.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/core.c           | 195 ++++++++++++++++++++++++++++++++++++++++
 hw/ide/ide-internal.h   |   9 ++
 tests/qtest/ahci-test.c |  70 +++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d09b0fa736..1304202ea2 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1652,6 +1652,192 @@ static bool cmd_write_dma(IDEState *s, uint8_t cmd)
     return false;
 }
 
+/*
+ * An IDENTIFY DEVICE data bit, and the bit of an IDENTIFY DEVICE data log QWord
+ * that holds a copy of it.
+ */
+typedef struct IDEIdentifyBit {
+    uint8_t word;
+    uint8_t bit;
+    uint8_t qword_bit;
+} IDEIdentifyBit;
+
+/* The Supported Capabilities QWord of page 03h, terminated by a zero word */
+static const IDEIdentifyBit ide_supported_capabilities[] = {
+    { 69, 14, 39 },     /* DRAT SUPPORTED */
+    { 69, 5, 31 },      /* RZAT SUPPORTED */
+    { 82, 14, 29 },     /* NOP SUPPORTED */
+    { 82, 5, 24 },      /* VOLATILE WRITE CACHE SUPPORTED */
+    { 82, 0, 23 },      /* SMART */
+    { 83, 13, 22 },     /* FLUSH CACHE EXT SUPPORTED */
+    { 83, 10, 20 },     /* 48-BIT SUPPORTED */
+    { 84, 6, 12 },      /* WRITE FUA EXT SUPPORTED */
+    { 84, 5, 11 },      /* GPL SUPPORTED */
+    { 84, 1, 8 },       /* SMART SELF-TEST SUPPORTED */
+    { 84, 0, 7 },       /* SMART ERROR LOGGING SUPPORTED */
+    { 119, 6, 5 },      /* SENSE DATA SUPPORTED */
+    { 119, 3, 2 },      /* GPL DMA SUPPORTED */
+    { 0 }
+};
+
+/* The SATA Capabilities QWord of page 08h, terminated by a zero word */
+static const IDEIdentifyBit ide_sata_capabilities[] = {
+    { 76, 1, 0 },       /* SATA GEN1 SIGNALING SPEED SUPPORTED */
+    { 76, 2, 1 },       /* SATA GEN2 SIGNALING SPEED SUPPORTED */
+    { 76, 3, 2 },       /* SATA GEN3 SIGNALING SPEED SUPPORTED */
+    { 76, 8, 7 },       /* NCQ FEATURE SET SUPPORTED */
+    { 76, 9, 8 },       /* RECEIPT OF HOST INITIATED POWER MANAGEMENT ... */
+    { 76, 10, 9 },      /* SATA PHY EVENT COUNTERS LOG SUPPORTED */
+    { 76, 11, 10 },     /* UNLOAD WHILE NCQ COMMANDS ARE OUTSTANDING ... */
+    { 76, 12, 11 },     /* NCQ PRIORITY INFORMATION SUPPORTED */
+    { 76, 13, 12 },     /* HOST AUTOMATIC PARTIAL TO SLUMBER ... */
+    { 76, 14, 13 },     /* DEVICE AUTOMATIC PARTIAL TO SLUMBER ... */
+    { 76, 15, 14 },     /* READ LOG DMA EXT AS EQUIVALENT TO READ LOG EXT ... */
+    { 77, 4, 15 },      /* NCQ STREAMING SUPPORTED */
+    { 77, 5, 16 },      /* NCQ QUEUE MANAGEMENT COMMAND SUPPORTED */
+    { 77, 6, 17 },      /* SEND AND RECEIVE QUEUED COMMANDS SUPPORTED */
+    { 78, 1, 18 },      /* NONZERO BUFFER OFFSETS SUPPORTED */
+    { 78, 2, 19 },      /* DMA SETUP AUTO-ACTIVATION SUPPORTED */
+    { 78, 3, 20 },      /* DEVICE INITIATED POWER MANAGEMENT SUPPORTED */
+    { 78, 4, 21 },      /* IN-ORDER DATA DELIVERY SUPPORTED */
+    { 78, 5, 22 },      /* HARDWARE FEATURE CONTROL SUPPORTED */
+    { 78, 6, 23 },      /* SOFTWARE SETTINGS PRESERVATION SUPPORTED */
+    { 78, 7, 24 },      /* NCQ AUTOSENSE SUPPORTED */
+    { 78, 8, 25 },      /* DEVICE SLEEP SUPPORTED */
+    { 0 }
+};
+
+/* The Current Settings QWord of page 04h, terminated by a zero word */
+static const IDEIdentifyBit ide_current_settings[] = {
+    { 85, 5, 13 },      /* VOLATILE WRITE CACHE ENABLED */
+    { 85, 0, 6 },       /* SMART ENABLED */
+    { 0 }
+};
+
+/* A QWord with bit 63 set, and a copy of the IDENTIFY DEVICE data @bits */
+static uint64_t ide_identify_bits(IDEState *s, const IDEIdentifyBit *bits)
+{
+    uint64_t qword = 1ULL << 63;
+
+    for (; bits->word; bits++) {
+        if (lduw_le_p(s->identify_data + 2 * bits->word) & (1 << bits->bit)) {
+            qword |= 1ULL << bits->qword_bit;
+        }
+    }
+    return qword;
+}
+
+/*
+ * Build the IDENTIFY DEVICE data log (log address 30h, ACS-6 9.11) pages
+ * [page, page + count) into the I/O buffer. Page 00h (List of Supported
+ * pages), page 01h (a copy of the IDENTIFY DEVICE data), page 02h (Capacity),
+ * page 03h (Supported Capabilities), page 04h (Current Settings), page 05h
+ * (Strings), page 06h (Security) and page 08h (Serial ATA) are implemented;
+ * any other page is returned as zeros (ACS-6 9.11.1).
+ */
+static void ide_fill_identify_device_log(IDEState *s, uint16_t page,
+                                         uint16_t count)
+{
+    uint16_t i;
+
+    /* Update the cached IDENTIFY DEVICE data; this clobbers io_buffer. */
+    ide_identify(s);
+    memset(s->io_buffer, 0, count * 512);
+
+    for (i = 0; i < count; i++) {
+        uint8_t *buf = s->io_buffer + i * 512;
+
+        switch (page + i) {
+        case 0x00:
+            /*
+             * List of Supported IDENTIFY DEVICE data log pages (ACS-6 9.11.2)
+             */
+            put_le16((uint16_t *)buf, 0x0001); /* REVISION NUMBER field */
+            buf[8] = 8;                        /* number of entries */
+            buf[9] = 0x00;                     /* page 00h is supported */
+            buf[10] = 0x01;                    /* page 01h is supported */
+            buf[11] = 0x02;                    /* page 02h is supported */
+            buf[12] = 0x03;                    /* page 03h is supported */
+            buf[13] = 0x04;                    /* page 04h is supported */
+            buf[14] = 0x05;                    /* page 05h is supported */
+            buf[15] = 0x06;                    /* page 06h is supported */
+            buf[16] = 0x08;                    /* page 08h is supported */
+            break;
+        case 0x01:
+            /* Copy of IDENTIFY DEVICE data, words 0..255 (ACS-6 9.11.3) */
+            memcpy(buf, s->identify_data, sizeof(s->identify_data));
+            break;
+        case 0x02:
+            /* Capacity (ACS-6 9.11.4) */
+            /* header QWord: 63=set to one, PAGE NUMBER=02h, REVISION=0001h */
+            stq_le_p(buf, (1ULL << 63) | (0x02ULL << 16) | 0x0001);
+            /*
+             * Device Capacity QWord: 63=set to one, 47:0=ACCESSIBLE CAPACITY
+             * (one greater than the maximum user-accessible LBA)
+             */
+            stq_le_p(buf + 8, (1ULL << 63) |
+                     ((uint64_t)s->nb_sectors & 0xffffffffffffULL));
+            break;
+        case 0x03:
+            /* Supported Capabilities (ACS-6 9.11.5) */
+            /* header QWord: 63=set to one, PAGE NUMBER=03h, REVISION=0001h */
+            stq_le_p(buf, (1ULL << 63) | (0x03ULL << 16) | 0x0001);
+            /* capabilities QWord: 63=valid, the rest copies IDENTIFY data */
+            stq_le_p(buf + 8, ide_identify_bits(s, ide_supported_capabilities));
+            break;
+        case 0x04:
+            /* Current Settings (ACS-6 9.11.6) */
+            /* header QWord: 63=set to one, PAGE NUMBER=04h, REVISION=0001h */
+            stq_le_p(buf, (1ULL << 63) | (0x04ULL << 16) | 0x0001);
+            /* Current Settings: 63=set to one, rest copies IDENTIFY data */
+            stq_le_p(buf + 8, ide_identify_bits(s, ide_current_settings));
+            break;
+        case 0x05:
+            /* Strings */
+            /* header QWord: 63=set to one, PAGE NUMBER=05h, REVISION=0001h */
+            stq_le_p(buf, (1ULL << 63) | (0x05ULL << 16) | 0x0001);
+            /*
+             * SERIAL NUMBER, FIRMWARE REVISION, MODEL NUMBER and ADDITIONAL
+             * PRODUCT IDENTIFIER: copies of IDENTIFY DEVICE data words 10..19,
+             * 23..26, 27..46 and 170..173
+             */
+            memcpy(buf + 8, s->identify_data + 2 * 10, 20);
+            memcpy(buf + 32, s->identify_data + 2 * 23, 8);
+            memcpy(buf + 48, s->identify_data + 2 * 27, 40);
+            memcpy(buf + 96, s->identify_data + 2 * 170, 8);
+            break;
+        case 0x06:
+            /* Security: the Security feature set is not supported */
+            /* header QWord: 63=set to one, PAGE NUMBER=06h, REVISION=0001h */
+            stq_le_p(buf, (1ULL << 63) | (0x06ULL << 16) | 0x0001);
+            /*
+             * Master Password Identifier, Security Status, the times required
+             * for an Enhanced and a Normal Erase, Trusted Computing feature
+             * set and Security Capabilities: valid, with nothing supported
+             */
+            stq_le_p(buf + 8, 1ULL << 63);
+            stq_le_p(buf + 16, 1ULL << 63);
+            stq_le_p(buf + 24, 1ULL << 63);
+            stq_le_p(buf + 32, 1ULL << 63);
+            stq_le_p(buf + 40, 1ULL << 63);
+            stq_le_p(buf + 48, 1ULL << 63);
+            break;
+        case 0x08:
+            /* Serial ATA */
+            /* header QWord: 63=set to one, PAGE NUMBER=08h, REVISION=0001h */
+            stq_le_p(buf, (1ULL << 63) | (0x08ULL << 16) | 0x0001);
+            /* SATA Capabilities: 63=set to one, rest copies IDENTIFY data */
+            stq_le_p(buf + 8, ide_identify_bits(s, ide_sata_capabilities));
+            /* Current SATA Settings: 63=set to one, nothing enabled */
+            stq_le_p(buf + 16, 1ULL << 63);
+            break;
+        default:
+            /* Unsupported page: returned as all zeros. */
+            break;
+        }
+    }
+}
+
 /*
  * Fill the I/O buffer with the General Purpose Logging data requested by a
  * READ LOG EXT / READ LOG DMA EXT command and return the number of bytes to
@@ -1668,6 +1854,9 @@ static int ide_read_log(IDEState *s)
     case IDE_GPL_LOG_DIRECTORY:
         log_size = 1;
         break;
+    case IDE_GPL_LOG_IDENTIFY_DEVICE:
+        log_size = IDE_GPL_LOG_IDENTIFY_DEVICE_LEN;
+        break;
     default:
         /* Log (or its associated feature set) not supported (ACS-6 7.25.5). */
         return -1;
@@ -1689,6 +1878,12 @@ static int ide_read_log(IDEState *s)
         memset(s->io_buffer, 0, count * 512);
         /* word 0: General Purpose Logging Version */
         put_le16((uint16_t *)s->io_buffer, 0x0001);
+        /* word N: number of log pages at log address N */
+        put_le16((uint16_t *)s->io_buffer + IDE_GPL_LOG_IDENTIFY_DEVICE,
+                 IDE_GPL_LOG_IDENTIFY_DEVICE_LEN);
+        break;
+    case IDE_GPL_LOG_IDENTIFY_DEVICE:
+        ide_fill_identify_device_log(s, page, count);
         break;
     }
 
diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 389e15049e..8da6d72450 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -212,6 +212,15 @@
  * READ LOG EXT / READ LOG DMA EXT (see ACS-6 9.1 table 222).
  */
 #define IDE_GPL_LOG_DIRECTORY           0x00 /* General Purpose Log Directory */
+#define IDE_GPL_LOG_IDENTIFY_DEVICE     0x30 /* IDENTIFY DEVICE data log */
+
+/*
+ * Number of 512-byte pages in the IDENTIFY DEVICE data log. Pages 00h (list
+ * of supported pages), 01h (copy of IDENTIFY DEVICE data), 02h (Capacity),
+ * 03h (Supported Capabilities), 04h (Current Settings), 05h (Strings), 06h
+ * (Security) and 08h (Serial ATA) are implemented.
+ */
+#define IDE_GPL_LOG_IDENTIFY_DEVICE_LEN 9
 
 #if (IDE_DMA_BUF_SECTORS < MAX_MULT_SECTORS)
 #error "IDE_DMA_BUF_SECTORS must be bigger or equal to MAX_MULT_SECTORS"
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 8ff30616d5..ba9ea5c435 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1064,6 +1064,9 @@ static void ahci_test_read_log(AHCIQState *ahci, uint8_t read_log_cmd)
 {
     uint16_t id[256];
     uint16_t dir[256];
+    uint16_t page[256];
+    uint8_t *page8 = (uint8_t *)page;
+    uint64_t nb, cap;
     unsigned px;
 
     px = ahci_port_select(ahci);
@@ -1084,14 +1087,81 @@ static void ahci_test_read_log(AHCIQState *ahci, uint8_t read_log_cmd)
     ahci_io(ahci, px, read_log_cmd, &dir, 512, 0x00);
     /* word 0: General Purpose Logging Version */
     g_assert_cmphex(le16_to_cpu(dir[0]), ==, 0x0001);
+    /* word 30h: number of pages in the IDENTIFY DEVICE data log */
+    g_assert_cmphex(le16_to_cpu(dir[0x30]), ==, 9);
+
+    /* IDENTIFY DEVICE data log (log address 30h), page 0: list of pages. */
+    ahci_io(ahci, px, read_log_cmd, &page, 512, 0x30);
+    g_assert_cmphex(le16_to_cpu(page[0]), ==, 0x0001); /* REVISION NUMBER */
+    g_assert_cmpint(page8[8], ==, 8);                  /* number of entries */
+    g_assert_cmpint(page8[9], ==, 0x00);               /* page 00h supported */
+    g_assert_cmpint(page8[10], ==, 0x01);              /* page 01h supported */
+    g_assert_cmpint(page8[11], ==, 0x02);              /* page 02h supported */
+    g_assert_cmpint(page8[12], ==, 0x03);              /* page 03h supported */
+    g_assert_cmpint(page8[13], ==, 0x04);              /* page 04h supported */
+    g_assert_cmpint(page8[14], ==, 0x05);              /* page 05h supported */
+    g_assert_cmpint(page8[15], ==, 0x06);              /* page 06h supported */
+    g_assert_cmpint(page8[16], ==, 0x08);              /* page 08h supported */
+
+    /* IDENTIFY DEVICE data log page 1: a copy of the IDENTIFY data. */
+    ahci_io(ahci, px, read_log_cmd, &page, 512, 0x30 | (1 << 8));
+    g_assert_cmphex(memcmp(page, id, 512), ==, 0);
+
+    /* IDENTIFY DEVICE data log page 2 (page number 2): Capacity. */
+    ahci_io(ahci, px, read_log_cmd, &page, 512, 0x30 | (2 << 8));
+    g_assert_cmphex(le16_to_cpu(page[0]), ==, 0x0001);   /* REVISION NUMBER */
+    g_assert_cmpint(page8[2], ==, 0x02);                 /* PAGE NUMBER */
+    g_assert_cmpint(page8[7] & (1 << 7), ==, (1 << 7));  /* header bit 63 */
+    g_assert_cmpint(page8[15] & (1 << 7), ==, (1 << 7)); /* capacity valid */
+    /* ACCESSIBLE CAPACITY (bits 47:0) must match IDENTIFY words 100..103 */
+    nb = (uint64_t)le16_to_cpu(id[100]) |
+         ((uint64_t)le16_to_cpu(id[101]) << 16) |
+         ((uint64_t)le16_to_cpu(id[102]) << 32) |
+         ((uint64_t)le16_to_cpu(id[103]) << 48);
+    cap = (uint64_t)page8[8] | ((uint64_t)page8[9] << 8) |
+          ((uint64_t)page8[10] << 16) | ((uint64_t)page8[11] << 24) |
+          ((uint64_t)page8[12] << 32) | ((uint64_t)page8[13] << 40);
+    g_assert_cmpuint(cap, ==, nb);
+
+    /* IDENTIFY DEVICE data log page 3: Supported Capabilities. */
+    ahci_io(ahci, px, read_log_cmd, &page, 512, 0x30 | (3 << 8));
+    g_assert_cmphex(le16_to_cpu(page[0]), ==, 0x0001);   /* REVISION NUMBER */
+    g_assert_cmpint(page8[2], ==, 0x03);                 /* PAGE NUMBER */
+    g_assert_cmpint(page8[7] & (1 << 7), ==, (1 << 7));  /* header bit 63 */
+    g_assert_cmpint(page8[8] & (1 << 2), ==, (1 << 2));  /* GPL DMA supported */
+    g_assert_cmpint(page8[9] & (1 << 3), ==, (1 << 3));  /* GPL (bit 11) */
+    g_assert_cmpint(page8[10] & (1 << 4), ==, (1 << 4)); /* 48-BIT (bit 20) */
+
+    /* IDENTIFY DEVICE data log page 5: Strings, as in the IDENTIFY data. */
+    ahci_io(ahci, px, read_log_cmd, &page, 512, 0x30 | (5 << 8));
+    g_assert_cmpint(page8[2], ==, 0x05);                 /* PAGE NUMBER */
+    g_assert_cmphex(memcmp(page8 + 8, &id[10], 20), ==, 0);  /* SERIAL */
+    g_assert_cmphex(memcmp(page8 + 48, &id[27], 40), ==, 0); /* MODEL */
+
+    /* IDENTIFY DEVICE data log page 8: Serial ATA. */
+    ahci_io(ahci, px, read_log_cmd, &page, 512, 0x30 | (8 << 8));
+    g_assert_cmpint(page8[2], ==, 0x08);                 /* PAGE NUMBER */
+    g_assert_cmpint(page8[8] & (1 << 7), ==, (1 << 7));  /* NCQ supported */
 }
 
 static void test_read_log_dma(void)
 {
     AHCIQState *ahci;
+    uint16_t id[256];
+    uint16_t idlog[512]; /* two consecutive 512-byte log pages */
+    unsigned px;
 
     ahci = ahci_boot_and_enable(NULL);
     ahci_test_read_log(ahci, CMD_READ_LOG_DMA_EXT);
+
+    /* Also exercise a multi-page DMA transfer: both pages of log 30h. */
+    px = ahci_port_select(ahci);
+    ahci_port_clear(ahci, px);
+    ahci_io(ahci, px, CMD_IDENTIFY, &id, 512, 0);
+    ahci_io(ahci, px, CMD_READ_LOG_DMA_EXT, &idlog, 1024, 0x30);
+    g_assert_cmphex(le16_to_cpu(idlog[0]), ==, 0x0001);   /* page 0 header */
+    g_assert_cmphex(memcmp(&idlog[256], id, 512), ==, 0); /* page 1: IDENTIFY */
+
     ahci_shutdown(ahci);
 }
 
-- 
2.56.1


