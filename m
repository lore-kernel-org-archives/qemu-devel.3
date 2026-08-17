Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6864C5DF7E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KL-0006YE-JN; Mon, 17 Aug 2026 16:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KE-0006Vo-9Z
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4K9-0006eO-Hi
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so3538015e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999968; x=1787604768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=naDIb4FK/KvbgaMRnDaVmLTTTNzOICwYxY4JYTI+MY4=;
 b=Fw9v/Bqk/wgjvtZfPzDjCQbtQsyE9kc06XB5Hc4R5DEGkIKvh8bpEHDS6jk6QU7Cx2
 dmcW8nLuiQyTj+HRdmTvzC/HgHWPSXy/XPyiV9WybjvVvImMu0cPXNlvtNkphBCLEt0y
 471wI3vCTk3PBiBI+iOS+e6np8+b1IkCm+NqN5HiOIYesQkJwu/5kTKn6INTS6SiFIiV
 i4CGjlwwnGbR5E/EZcyPIJpBzcW4MTUi+P9B5uq375gAWcx58/Npx/VtXP9gpmkHYaUr
 QFnDWjTpsTO4TSGSABID/7wTr5I9ejQSM31R9rJA8aeUK1x4qum3dN3fqIaCdDN5NtHO
 od7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999968; x=1787604768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=naDIb4FK/KvbgaMRnDaVmLTTTNzOICwYxY4JYTI+MY4=;
 b=IFLAclJaGrD7ePPaJF5mvJcw8hPJTsDk6MZsIzIQ85W/Ci5tZPAzf0JGSWm9oZPdm2
 16qhcVFxQycLEbPMvqetZ8jfxpWHSj2t2zOa4X++zS+FiXosHH+xab4hWAN8n5l01zUz
 AyA3ZrXFagasMQ5I7f1daTupI5k8HTMC46I5Dthz9qGn0hT90VMVgolD+i6/vSX424BJ
 uC5aim/uatu0z/MWvXYsgsVVDR5tQpWXBI16dY9+aTcSec6YEEpdV7YfvM6P+JTb44EC
 tXihy8tecpLz8TGLFKBjlEnlsaEaUwT5I2kFzUpnRlyTpuPPGuiCGlxK5uJYwklSFiUg
 iQWg==
X-Gm-Message-State: AOJu0Ywwvbaa4ipWPznWiksat7EfAIIQmelsIEvVdEpbGBpANVo0Y0ok
 7WkbV7P/NiA2qGnuoFbyeC9KRQ4w1HzrM2Bv2YJcgDIZ1yL9avOlnFHD0KZMJiN0zGJ0rtLOesY
 A8n7E
X-Gm-Gg: AR+sD12ifgZzQ2E3cG4ZeriKequuhz6JTYBGvRZM+38vLieaTlZElkzvCBX1L7Cyp83
 8P9W6AS43SePrpYdnzdRFimEzbzb3m1SmTVzu2pBjEmI/+X4dIZgy9IfUOuNBT5hGsgxDPmDfKJ
 j5jF14a1mEuJ/j13gsbyf8O9p1o2eV/wPCSIZdugkpcJPfJvzSebbbHf77dTJvxJ+viFA+f5r/J
 kpfbUYm/K2tyVERCDOKEAtWtOEXUGiW08aVOCY2C/HVa0VQVJEOvtSsTVGeZx0DMq3zY6sUA2Mr
 IgCnjzHEoh2vq3MmytST2yCJDDdIAcc7AWa2V1QUFJmpUtrIimj14cLp7IybSQpp6CslmU28ddT
 d+geCTv2DeQkGonkNzP8WoYp6XtGCptZDQ4Hrq6ArKbFCCbd+6EO8npq1vwlChAgV2Fy5HUpIO8
 BnVZZJXNGuNTwAlT6VOl/ZVSJB9vjTsLGl8f3vTsogHiKE57lVog==
X-Received: by 2002:a05:600c:468a:b0:499:596b:2e91 with SMTP id
 5b1f17b1804b1-499a205b082mr5811025e9.3.1786999968146; 
 Mon, 17 Aug 2026 13:52:48 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:47 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 02/15] tests/qtest/ide-test: cover a CHS translation with zero
 sectors
Date: Mon, 17 Aug 2026 22:52:29 +0200
Message-ID: <20260817205242.1199851-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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

Ask for zero sectors per logical track via INITIALIZE DEVICE PARAMETERS
and check that the command is aborted, that IDENTIFY DEVICE still reports
the translation that was in effect before, and that a CHS read then
completes normally rather than killing QEMU with SIGFPE.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index b36b0f8875..99aa5e039c 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -95,6 +95,7 @@ enum {
 
 enum {
     CMD_DSM         = 0x06,
+    CMD_READ        = 0x20,  /* READ SECTOR(S) */
     CMD_DIAGNOSE    = 0x90,
     CMD_INIT_DP     = 0x91,  /* INITIALIZE DEVICE PARAMETERS */
     CMD_READ_DMA    = 0xc8,
@@ -1194,6 +1195,66 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
     free_pci_device(dev);
 }
 
+/* Zero sectors per track has to abort (ATA-5 8.16.6), not divide by zero */
+static void test_specify_zero_sectors(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint16_t buf[256];
+    uint8_t data;
+    int i;
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 0);
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_INIT_DP);
+
+    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), ERR);
+    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_error), ABRT);
+
+    /* The refused request has to leave the default translation in effect */
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_IDENTIFY);
+    for (i = 0; i < 256; i++) {
+        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
+    }
+    g_assert_cmpint(buf[55], ==, 16);
+    g_assert_cmpint(buf[56], ==, 63);
+
+    /* READ SECTOR(S) of CHS 0/0/1, which used to crash QEMU */
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 1);
+    qpci_io_writeb(dev, ide_bar, reg_lba_low, 1);
+    qpci_io_writeb(dev, ide_bar, reg_lba_middle, 0);
+    qpci_io_writeb(dev, ide_bar, reg_lba_high, 0);
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_READ);
+
+    data = ide_wait_clear(qts, BSY);
+    assert_bit_set(data, DRQ);
+    assert_bit_clear(data, ERR | DF);
+    for (i = 0; i < 256; i++) {
+        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
+    }
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), ERR | DF | DRQ);
+
+    /* A supported translation is still accepted */
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 32);
+    qpci_io_writeb(dev, ide_bar, reg_device, 7);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_INIT_DP);
+
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), ERR);
+
+    ide_test_quit(qts);
+    free_pci_device(dev);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1265,6 +1326,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/ide/read_native", test_specify);
+    qtest_add_func("/ide/specify/zero_sectors", test_specify_zero_sectors);
 
     qtest_add_func("/ide/identify", test_identify);
 
-- 
2.53.0


