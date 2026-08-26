Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DFDC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbW-0007oO-E5; Wed, 26 Aug 2026 07:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbS-0007lm-Aq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:34 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbQ-0004Fp-1F
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:34 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so100488766b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742930; x=1788347730; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G3bEotXoyZUPJjhBzMNz6MRMIWj1lqgebE/pPqEgtUU=;
 b=JvsNYT8jnLre4M3AdnileZEXRGLZtmanSQZPfFwVP4Tz6rxk25dFMYbTAOYV2reskR
 matmHWgLwETczToioo8/AzBdFsN5VKhBcucIW55pcybQgUxorwWwATP/04bDDwG6RDz8
 HRT5Pv+DljPJVe/NC2yIKUCAZKmJszaVaica+R8QJWSn7z3udFnY9w4qmH1kzNoLkAtL
 yiSAsev6kwfJzxwoDwa4amZ3qtUgPEcg5RxvVsPPsoH7yNpzHX8HOqMNsMVsl3srPmKi
 umuR4klzQchpv+sp2oXf4iZryMvNRGIW+hcGicS2dlv9VnMKP8oceS4XKFnfGjiyi+s7
 SXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742930; x=1788347730;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3bEotXoyZUPJjhBzMNz6MRMIWj1lqgebE/pPqEgtUU=;
 b=mKr1LvgCxyv5oP+hKpLNPRnfp1ylpRrCFiRdCDYCir3shx6RL2wKhZIUVOOaKZBxe4
 Qax2qWSU8rjvd8EDp5abL2GQE3cR9pqRE0wZgiJWRYW1vWmw4/s8bfE176KpsppxdLJ1
 fYyZ6G+Dt15T/4OyQHG/xnv9rb93fOaWsYKw5Kd3E6FsAEaWlv5Ck2wORYyMxGJ6sbZh
 OHhvlcOe1crKgw+4TsIOz2IftKtGI7XEATS85VX2HyNOSmUAEuRzBisfNjI/KrmxRCg0
 UoDt4Rs+AdbbctL85Omnx9LgV3WTDArw7lfnVAAnURLg+k7m3fFghbRdcnTTG02xMdui
 Nqgg==
X-Gm-Message-State: AFuF++noDxFTH4DDm4iYAdo93M/7CVLhuTeATyNOJ6/yXgA3th94GlZ0
 9KvKHczBwUX9nnsl+XChEp1Gxjj1KGNAiGgKUVBw5Vfs5ZTNTiIKa7TutglE8XYb4f1FrbDPbCT
 yC4qT
X-Gm-Gg: AR+sD12WZUExhuopvfXCRi6g9DpimSWth32hbXWFHcodCz2HZxOCxMCLmzUIdFG1xL5
 WOTmZV6f6y82luh9T2ljKUfFXwpNBxVbWaQFpBnrzX4/iTPO+zRlFKx+nVsGvscV8h5/mw0t23d
 EkIlJjmAWhX9YaO/MDT3mcLwjgWvd4oVrNhkGcQRErKgQLSHYbyUKsyYSl82vgFKTcxRW9aeGEr
 RoKmkffgAAPhv3m+XqBgc9RcxuBpzl2lCmZAqip/OVGVscAHvqZsjH328mEpXJvlLRZovJP039t
 +v5ic6HnF27Zrb5kHczf8QYenz4IL2VPd8X/7vAVI3BBJHQPSAnSwZn9WZqs/nHPkoHfm+JXxRC
 dTyEn2cDqroGqhBaDjWIKgrSHpRD37C2GrZzQV10kq0jbVaSixWAEdQSl45wlByi6FzmKHKbdVy
 P022irDLpKbAVr1u9X73uaftetGYqHRT85wbofLL1KGWu4ejeu+698HNsm2DY=
X-Received: by 2002:a17:907:e008:20b0:c25:2d27:5648 with SMTP id
 a640c23a62f3a-c252d277702mr204157166b.4.1787742930225; 
 Wed, 26 Aug 2026 04:15:30 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:29 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 02/28] tests/qtest/ide-test: cover a CHS translation with zero
 sectors
Date: Wed, 26 Aug 2026 13:15:17 +0200
Message-ID: <20260826111524.3383479-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=den@openvz.org; helo=mail-ej1-x62a.google.com
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

Ask for zero sectors per logical track via INITIALIZE DEVICE PARAMETERS
and check that the command is aborted, that IDENTIFY DEVICE still reports
the translation that was in effect before, and that a CHS read then
completes normally rather than killing QEMU with SIGFPE.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


