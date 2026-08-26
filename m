Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6780C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfc-0005NP-AS; Wed, 26 Aug 2026 07:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfX-00059s-TK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:47 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfU-0005rI-7d
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a3819e8be8so1947053a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743183; x=1788347983; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JkvYru+AQEGMlynpUI5Ee0eR/pHZUMGShiT/2sIrv9g=;
 b=EPDk8Cr52WdJYIwiKqgzEv1D3zh8hrpYcCyYO8fnicHtv7eIQ5SPie25aGW11N461E
 eYieNY8lLjXQvFQC5Jd1TS2b383b3xwm3QiiCfKTqfTF6QVU4s2XlzKZL2tbMnksVV2q
 SsngHs679ftDNKyhgkWqU4ROF7RqnRYzZgzAR1eY0VLChIvMUj+6+DGlFAAf+TjjQuIF
 xbfbf6UiAxmO91Y0u48vgVdC03sMmrh6FHQG/JDjAlkL90iz+snO/l4X9LzKKD61UDLI
 fsGZAIVgIZAP0vwpXcUsrX+jwDJRGWWwRoJU2ZO19gNfPAolrFxNYupcLvNL4UaiBYTD
 n/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743183; x=1788347983;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JkvYru+AQEGMlynpUI5Ee0eR/pHZUMGShiT/2sIrv9g=;
 b=Kfws3cYuSrQY+klQSIH3k6DnCohuwNp3p28+Iky/YFcOCL2TD2DRVxR7dDu2HZiG2l
 P++XC69Df0jBHBbNdcEWnOQKJkx5z8eeehGIro3GH+sTI3UbzkFsLg0KnPZXn0K0Dtaj
 namcjs+EgssKyGdrFf7b0iVSxuAulcRxM1M4J+P0zeqyM6PuVntZHqcRrWCcSNvilxzM
 yFSyfaAtaOr4JYWFtbBfBTcg+Tfr/iVjzaVRV/L5SWlE2W21rFvswU3Que9R5DN0FpPK
 SpdWnzQp3IZMXmMMMCby2E0pO3sLRaR1Ctxbf9zRsxt8aDqh5YYE+kgTxmniHqCKzrc4
 ppEg==
X-Gm-Message-State: AFuF++lmZjsdD5azUYiYrqODvyS1AAuHB6tsh1GtfyJKW4BeiFTlyEMX
 R0hnsnETs7LDMc8hurlpnctC0IVG6AcftX6wXlA+fJNRyYFwODzyYypKDZdPF/FFPSyqG6+9vzi
 vAZIi
X-Gm-Gg: AR+sD10WEmID8luXblNT0tILtRaX9qBIB+riffcWYzcbNq6lykxpEzq6FqrMAnFZ53E
 nGHL/odY/Yj1oJUyqlH5EEhbvu5I2DV3oyzdiC3FuDbzhpATbCjONySNaiMVBNrz4c7zWtH78Vc
 6gabLp8oE9XecGOn4pKHtLP6D0C/7yJsV2AA62YAT3xnTff8ARQp2gIiqgbr4ZRlWV96ydIBBZP
 h8pPd/Yb27YYHIKOw5D4X9UrAtpWr7JH05JNPW/rCMEG7mN12gydMADZAFRYfNrZmR/WtcKX7E7
 3PZdtNYHP2QxFE5GQlW0HThGcwM/S4Gng4S53sqR4eud+lA8D0qs84Ydxj7uZDFW5cCyhOCbiKf
 k9SVt6e0iu9lcsSvfmBklIbl8oOXV73oLP4rTVZl64j8ETnMj/bAws/kYEo6P4jxDf15G04rByJ
 CTAV2rQxkn1I9afwMGTpaX/z0/AtRhi0SRopqWnAHbXP4Q59au
X-Received: by 2002:a05:6402:325a:b0:6a5:ccbd:c661 with SMTP id
 4fb4d7f45d1cf-6a5df1cafc7mr6170597a12.4.1787743182602; 
 Wed, 26 Aug 2026 04:19:42 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:42 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 28/28] tests/qtest/ide-test: cover the UDMA5 identify words
Date: Wed, 26 Aug 2026 13:19:15 +0200
Message-ID: <20260826111915.3387926-19-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


