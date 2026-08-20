Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09340C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhq-0006ri-6Z; Thu, 20 Aug 2026 06:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhi-0006ny-ON
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhe-0008JA-OK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1639982f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220533; x=1787825333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G3bEotXoyZUPJjhBzMNz6MRMIWj1lqgebE/pPqEgtUU=;
 b=mpkFWUsgaZ8rki0Sl8B1N/CPc9/diQoBGTIbwXJ4Lt+3guv0XfhKm9K09+Y8VxbrGu
 +b3jN69z7VJ6+G4De8uDduIykGhTrvXMtHYoyT4dStsLgCQb491VsmQ6lYZdlfVgz20N
 QkqKi+ZXTHROHfEtz1DMibzj/GV+j7ZG0AzDgi1CPGokzGUKOKwRdA5pTfzL0mWJ+ks/
 U9XM35QQMzrNT09EMeANkR4/+dITBU+U0Pv4LsONtzOtkVJtVFkTb+AojanyhgY3cUaa
 4b895BOYFAqzHsLfMO8Z9t+CN/fGYJP8UZPqK3Z197wNKTFtwi/KU4pnq79x2G+Uev6E
 PIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220533; x=1787825333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3bEotXoyZUPJjhBzMNz6MRMIWj1lqgebE/pPqEgtUU=;
 b=en1HIWyH9IfRmpaYsW2QRGZFtCOVUxJ1rpAAOqgcuRhfokvje97Pb7Ajh/friYSa/r
 NykvzAYamm0WEsF3rN2QJrziiQkd+wlQ41WMHIcD3CS2aqEy/uWYPlsBO8kQQg6m92xf
 i49HB7vgtgUUWQ7OSt0J/XIc6UaGyZ28yT/Sw5Az4L/ECnwN+uPyplhXiAkb8GZ485bK
 eFL8ZVGgYDgSLkfqwn5xX9XAP7E/8pe1bp6LjaqM4TfFvYmetWXG99e7y6W9NxzLuP7j
 DWjQLHjtr5/6DnQeIY/ErWraBMgF9Tqbv/T1qwTHc7SulpyrdiibZwM7x2jz2A5s1Idr
 phZQ==
X-Gm-Message-State: AFuF++lJfI6NILKyInv1QTecdB4shUIy58dV6wQCPUVfu/s6JXZyHJsM
 Znynz9mjYsQB3Y/h0MnuVJlhLNSNunsKmHNO09VafkfYgqckOLKzhBNSJBbXnIzYgtJhX8VgynK
 ByQ3u
X-Gm-Gg: AR+sD10JccESlrCMYSssudljNDYodO5g6dGUejAKBiMO0QDGfwZxp/FVjJeu5yxHpgT
 NLpVLT3wI0BsGcsIAAtFEWXLRMb/Z7enMUMD03FnVjgSSddYgxnbw43Blpl5ctUIo8l0MhrKtr3
 Ba9YFOpUKsm9mE9Gc2fIMyuNveB29NovksWZuvXfnawTak3LhVa18tSP5QF1+JCpnWoS6V289ef
 QU7AFxb7XJXsBTEnQzhbA8n/U7elQFiuMqSdq9OyIDVzj1QViarJ0oT+uru9cYKCc0y3hypQ1SW
 g/IOEcIcYAUrtrahapZfZmkiuOQvlWT7TKl9+u5ipjTubn0X0/CL6GLRrNdacYaRMRDQP75Fux2
 9JPvxL8phr3kojHnTV3a5CN7bn13pdugcsQy5zbd1kleFJRD3JOpCAq6xV2XH54X+0MaknSSZmz
 xF1OzfDW419XVVtcrZ+hZqJHUtd0tbmBMKjutz55AUtKQlro60nFGkgMCX6yS23ocig5p5
X-Received: by 2002:a05:6000:41f6:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-482b1fd3b69mr22543004f8f.14.1787220533261; 
 Thu, 20 Aug 2026 03:08:53 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:08:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 02/17] tests/qtest/ide-test: cover a CHS translation with
 zero sectors
Date: Thu, 20 Aug 2026 12:08:29 +0200
Message-ID: <20260820100844.411717-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=den@openvz.org; helo=mail-wr1-x431.google.com
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


