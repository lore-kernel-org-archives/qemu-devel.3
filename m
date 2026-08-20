Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DA6C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzif-0007GN-Q9; Thu, 20 Aug 2026 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhx-0006w2-9O
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhv-0008Pl-5n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso737748f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220549; x=1787825349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fDm9ZpUciP0grPAB9hW7JUEStxBgYv9yYQDvW3aVEbQ=;
 b=EN5MzEWsOWSoFHzDdmkU6oUyFXFLoU4oTHiWr1rMZRogXDyyB/IH9c8ssJctN6sJIR
 Vqf9Bs2P9kL1jm+c272fZeeT7PxT/hRyBewbM2RgQWrOwCVKaNOYjmwi9eSuEqaVO8ku
 PoIjy2o+Uh7Sa5B98ArzcJiIYhWfsqGIw4pZvpBrWAM9UtyDLT2fNsdwHHKGSDsm84Dy
 9LjeP9xhmcpld+/OQt9/J7fmrlF5iXw1zh9UCvdc0JXyOgZmJ/+2OD/0pGAmGI10SrrY
 WXsb448IYJX1irX94HBE0AVNJyxsAHLIPNcIgApCBBOYAno9mPlDpUkZYCgecwIKDOpx
 miYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220549; x=1787825349;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fDm9ZpUciP0grPAB9hW7JUEStxBgYv9yYQDvW3aVEbQ=;
 b=pFPgpmBNGSDbWPh+NAqVES0kCATyB8lz9KLAUAitKJSlFZ+vtrIFkCXeMtcvLE3n0d
 s0KfXdfnDwugul5SYWKguEmdz+G280PzedshltkOfNiAYFg1QQVWB2nAzQ2voHOS9ZTB
 PPeMKJZ3EnixSV4GC4cEECt1Vm9QtMZy+8TdHDPuCjSRVvCUFUbtE5J/ppcgg7D+l+/H
 GxWQ4Q1G5o26PGZt2G0iLbNvFrmaQPMwbrQzqXVDsrY5UQgHE6qL4J0TzzujciMPLHEo
 gXni2zpDNL3k/Tt2B5Dx2lqE8HjbEs6YS+Qt+DcNYKz8JhtYLEsWBEIz5lS3WUnnHumY
 HNYA==
X-Gm-Message-State: AFuF++lXD0AEr8OFuLf8FkwjKehRwIiQee4K4KzWfwjW54Bgs5J8mMX7
 CtMVGiu7MDg+cvbOirHJ1D8Qt00Iax1ZKT1HXfFAjSNm0AwPWlXXISu1qpmkG7lK2/+XOCNkR5h
 58j2u
X-Gm-Gg: AR+sD13mKVDwRn4sLlwWpQ7ksc2TSFZqbW60gaW8/yv/fK93R9rBUOdL4YuzuiWB+Hc
 2u/LgPLRA4mCSJqkdq0sS8+xkv7nfr8j5NophSxSypVrwBl2FO48MmOZoJrociWy4Ydp9SOV0Z1
 7nD4aFuRr3FIpjQDmetaPD7y6NjnJ8Jh0ZmryLh6xBwPsDqDZbORdWVHX+NwB1A0RyrN9wFHCH0
 ftvs9prm2m+Gm6kMiEmWi5fxW+zR1l+95ADV6ipi6Hj3+NF+Vg7aX72UNTCPUXj9vFuACOZFG28
 vGhexh6J3vS9WaUhXsQGxxjeI76gBR9U/A8NoohdQLhXC5R4QNOCNFaqkqhogELz91FvEPz/gGI
 Qy99++rusMV0sKQS12LCSB8MmpKj+M3CUdHTKHp6rG37sG3EWbXwSSWaGMoP/uv9rLWDHZBWGFm
 azwIsbl8ASaLB+7y1Cr1hXwHGWxekf8+hJEckRZnmLY5pkEUsjTPB7KJe+hg==
X-Received: by 2002:a05:6000:144d:b0:47f:8fc9:6eaa with SMTP id
 ffacd0b85a97d-482b1ea2c22mr18216319f8f.8.1787220549244; 
 Thu, 20 Aug 2026 03:09:09 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 14/17] tests/qtest/ide-test: cover the IDENTIFY DEVICE
 geometry words
Date: Thu, 20 Aug 2026 12:08:41 +0200
Message-ID: <20260820100844.411717-15-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
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

INITIALIZE DEVICE PARAMETERS has to leave the geometry the drive came with
in words 3 and 6 and describe the translation it selected in words 54 to
58, and the data is cached, so which of the two a guest is told depends on
when it first asked. Cover both orders, as each alone leaves half of it
untested: one test has the data built while the default is in effect and
then replaces the translation, which the cached copy has to follow, the
other replaces it before the first IDENTIFY DEVICE, where the words
describing the default have to keep doing so.

Factor the reading of the data out of test_specify_zero_sectors() for the
three of them to share.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 89 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 4fa58ac525..e7a56e0710 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1196,6 +1196,18 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
     free_pci_device(dev);
 }
 
+static void ide_identify_words(QPCIDevice *dev, QPCIBar ide_bar,
+                               uint16_t buf[256])
+{
+    int i;
+
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_IDENTIFY);
+    for (i = 0; i < 256; i++) {
+        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
+    }
+}
+
 /* Zero sectors per track has to abort (ATA-5 8.16.6), not divide by zero */
 static void test_specify_zero_sectors(void)
 {
@@ -1221,11 +1233,7 @@ static void test_specify_zero_sectors(void)
     assert_bit_set(qpci_io_readb(dev, ide_bar, reg_error), ABRT);
 
     /* The refused request has to leave the default translation in effect */
-    qpci_io_writeb(dev, ide_bar, reg_device, 0);
-    qpci_io_writeb(dev, ide_bar, reg_command, CMD_IDENTIFY);
-    for (i = 0; i < 256; i++) {
-        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
-    }
+    ide_identify_words(dev, ide_bar, buf);
     g_assert_cmpint(buf[55], ==, 16);
     g_assert_cmpint(buf[56], ==, 63);
 
@@ -1563,6 +1571,74 @@ static void test_migrate_chs_rejected(void)
     unlink(path);
 }
 
+/* Words 54 to 58 follow the translation even when the data was cached first */
+static void test_specify_identify(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint16_t buf[256];
+    unsigned int cyls;
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+    /* Have the data built while the default translation is still in effect */
+    ide_identify_words(dev, ide_bar, buf);
+    cyls = buf[1];
+    g_assert_cmpint(buf[3], ==, 16);
+    g_assert_cmpint(buf[6], ==, 63);
+    g_assert_cmpint(buf[53] & 1, ==, 1);
+    g_assert_cmpint(buf[55], ==, 16);
+    g_assert_cmpint(buf[56], ==, 63);
+    g_assert_cmpint(buf[57] | (buf[58] << 16), ==, cyls * 16 * 63);
+
+    ide_set_translation(dev, ide_bar, 8, 32);
+
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[1], ==, cyls);
+    g_assert_cmpint(buf[3], ==, 16);
+    g_assert_cmpint(buf[4], ==, 512 * 63);
+    g_assert_cmpint(buf[6], ==, 63);
+    g_assert_cmpint(buf[55], ==, 8);
+    g_assert_cmpint(buf[56], ==, 32);
+    g_assert_cmpint(buf[57] | (buf[58] << 16), ==, cyls * 8 * 32);
+
+    free_pci_device(dev);
+    ide_test_quit(qts);
+}
+
+/* Words 3 and 6 keep the drive's own geometry even if built after a change */
+static void test_specify_identify_default(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint16_t buf[256];
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+    /* No IDENTIFY DEVICE before this one, so nothing was cached yet */
+    ide_set_translation(dev, ide_bar, 8, 32);
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[3], ==, 16);
+    g_assert_cmpint(buf[4], ==, 512 * 63);
+    g_assert_cmpint(buf[6], ==, 63);
+    g_assert_cmpint(buf[55], ==, 8);
+    g_assert_cmpint(buf[56], ==, 32);
+    g_assert_cmpint(buf[57] | (buf[58] << 16), ==, buf[1] * 8 * 32);
+
+    free_pci_device(dev);
+    ide_test_quit(qts);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1635,6 +1711,9 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ide/read_native", test_specify);
     qtest_add_func("/ide/specify/zero_sectors", test_specify_zero_sectors);
+    qtest_add_func("/ide/specify/identify", test_specify_identify);
+    qtest_add_func("/ide/specify/identify_default",
+                   test_specify_identify_default);
     qtest_add_func("/ide/migration/chs_translation",
                    test_migrate_chs_translation);
     qtest_add_func("/ide/migration/chs_snapshot", test_migrate_chs_snapshot);
-- 
2.53.0


