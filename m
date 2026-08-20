Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBD0C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zY-0000gV-H2; Thu, 20 Aug 2026 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zN-0000bh-Bv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zL-0005CX-4f
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso20259005e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787237006; x=1787841806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JkvYru+AQEGMlynpUI5Ee0eR/pHZUMGShiT/2sIrv9g=;
 b=YBBEHcsd1fKtFOslb5emliU64yWH1AcY/5yQgTlM4YL0IRGZIHYbp/3ZucGyCk1cqg
 3ASIjY7C49Hm73lgzOOHYQW6QIRVmnkPmKsKfkTQvGYSTAH9yO7BmA1ehNbv9+7eURWw
 woWI14pP1BTXOGWei3Q/392K/d4KrqMnZyeBiOwuszKrYyc3NJQTwHDUHmqTipvkBL6k
 /3QwxDJsODQDq5KlpiKTG5rHNPLgojocTni41deaUD20i0gMypESOXE8XROJTnaBdWqu
 A/5U83zf6XOK+MX+pBjZda74XqQ6m5rwCmZ6sTX/9fztgKV+EgMIqSeKxaVCytQXojEo
 aBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237006; x=1787841806;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JkvYru+AQEGMlynpUI5Ee0eR/pHZUMGShiT/2sIrv9g=;
 b=oSzTCUStkmKgBcCK/zyJTz0UA0PQ4hhNGlXQegv4QcHgTEQYMe07RCNs2lReOIaoRa
 ysMTvKTtlP76HVDNWkp5MRxqDnLu2CXefsq8mKrYSDqt91f0R008WifBJmyy4HixJUW8
 6J5hE/DE6poUYprIDtXhApuiIvV4dLmwgg8kbbLaWGnfK+mc/Si4keoEQWf49oBvn6Qh
 NAuik2a3dZV7+eHucBcMLMnL/6YmHt02yy/SOlW5lLYJYztszVHkmGEBYRPPFMpUtiWX
 6qIx7fxevGt6Q4qa6KyTEfRBY3xTum0yG5awrWyAdRzk/4iiKoWj75J23wMjl0Mmai20
 sXgw==
X-Gm-Message-State: AOJu0YzS0btzy6qpQrKimZuvdtM9q4ox6Sp/UFT4VRsLTFFwBMS7Cl3K
 OJj4IYoPbGdajSMkNKrsxIJVRlvGUPntiN6DPC1rAYBDxRwxJ76cdi8Nmji2KQsgb8rqtu85QnK
 LR8KD
X-Gm-Gg: AR+sD12QkaV6d4HTKynDKaq4vsDBLliketqORKr0AGfhXZQA+gLQG6RB44Db2JuoDqi
 cB8EJOnKe+2Td3ukQY1Yk++Mx0IeJIiD9PLrnokr1XFvGnCsaaQZTcVYaobwqDsDMxSK7iC0ZVy
 2w6j2Inn6yTxWNPQ5jSiXMspmLTTAYFqHFrXuP0qHv0/tuu5BDtvzX5VX7vrmKFo8bek6NyI1EC
 vkYN6zB7L/BdWQHg67kJGprWdGyJBa7KphtjP+Eggy8jVp4E/a3ttvtcX6lBNTQqpXdAAkiIVvu
 Fmww/InizhfQrZd2MCNvj1gKdP7H/7THexeNIpCw2PqRRMWC16POfloCfhwgPjkP0v+BYVLcIto
 K+zAcQZBkx14LARRKCWSSun1tH5akSb5gp5KzxE576QbHr8rTZOns5weDAVbjLnI9rKOxhBEbLR
 7YSHjcTHdL18BGJIcjyug0WJ9vEwrEEJt4WgF5SKMyBoCNAoyrvwvvGZqVtQ==
X-Received: by 2002:a05:600c:6308:b0:499:80d0:8b73 with SMTP id
 5b1f17b1804b1-499aa171fd8mr240538595e9.4.1787237005754; 
 Thu, 20 Aug 2026 07:43:25 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:25 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 11/11] tests/qtest/ide-test: cover the UDMA5 identify words
Date: Thu, 20 Aug 2026 16:43:09 +0200
Message-ID: <20260820144309.835173-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
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

From: Denis V. Lunev <den@openvz.org>

/ide/identify/udma and /ide/identify/udma_atapi check that a device
advertising UDMA mode 5 claims a standard that defines it and reports the
hardware reset result, on the disk and on the CD-ROM. The ATAPI case also
checks that the words obsolete in IDENTIFY PACKET DEVICE data stay
clear, and that the reset result reports a passed diagnostic, which
only the packet path does so far.

Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index a3109da908..92e3d9b343 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -104,6 +104,7 @@ enum {
     CMD_FLUSH_CACHE = 0xe7,
     CMD_IDENTIFY    = 0xec,
     CMD_PACKET      = 0xa0,
+    CMD_IDENTIFY_PACKET = 0xa1,
     CMD_READ_NATIVE = 0xf8,  /* READ NATIVE MAX ADDRESS */
 
     CMDF_ABORT      = 0x100,
@@ -1571,6 +1572,72 @@ static void test_migrate_chs_rejected(void)
     unlink(path);
 }
 
+/*
+ * A device advertising UDMA5 has to claim a standard that defines it, and a
+ * parallel attachment has to report the cable word (ACS-3 7.12.7.47).
+ */
+static void test_identify_udma(bool packet)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint16_t buf[256];
+    int i;
+
+    if (packet) {
+        qts = ide_test_start("-device ide-cd,bus=ide.0");
+    } else {
+        qts = ide_test_start(
+            "-blockdev driver=file,node-name=hda,filename=%s "
+            "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+            tmp_path[0]);
+    }
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command,
+                   packet ? CMD_IDENTIFY_PACKET : CMD_IDENTIFY);
+    for (i = 0; i < 256; i++) {
+        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
+    }
+
+    /* UDMA5 supported and selected */
+    assert_bit_set(buf[88], 1 << 5);
+    assert_bit_set(buf[88], 1 << 13);
+
+    /* UDMA5 arrived in ATA/ATAPI-6, so word 80 has to reach bit 6 */
+    assert_bit_set(buf[80], 1 << 6);
+    if (packet) {
+        /* Bits 3:1 are obsolete in IDENTIFY PACKET DEVICE data */
+        assert_bit_clear(buf[80], 0x0e);
+    }
+
+    /* Word 93: reserved bit clear, fixed bit set, 80-conductor cable */
+    assert_bit_clear(buf[93], 1 << 15);
+    assert_bit_set(buf[93], 1 << 14);
+    assert_bit_set(buf[93], 1 << 13);
+    assert_bit_set(buf[93], 1 << 0);
+    /* Device 0 clears the device 1 result */
+    assert_bit_clear(buf[93], 0x1f00);
+    if (packet) {
+        /* the disk path has yet to gain this */
+        assert_bit_set(buf[93], 1 << 3);
+    }
+
+    free_pci_device(dev);
+    ide_test_quit(qts);
+}
+
+static void test_identify_udma_ata(void)
+{
+    test_identify_udma(false);
+}
+
+static void test_identify_udma_atapi(void)
+{
+    test_identify_udma(true);
+}
+
 /* A PIO transfer window reaching past the io_buffer has to be refused */
 static void test_migrate_pio_state_rejected(void)
 {
@@ -1843,6 +1910,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/migration/chs_rejected", test_migrate_chs_rejected);
     qtest_add_func("/ide/migration/pio_state_rejected",
                    test_migrate_pio_state_rejected);
+    qtest_add_func("/ide/identify/udma", test_identify_udma_ata);
+    qtest_add_func("/ide/identify/udma_atapi", test_identify_udma_atapi);
 
     qtest_add_func("/ide/identify", test_identify);
 
-- 
2.53.0


