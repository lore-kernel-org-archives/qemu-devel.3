Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24C2C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzie-0007FA-Pe; Thu, 20 Aug 2026 06:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhz-0006wB-4G
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhx-0008Qe-7h
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-472326ca506so1398389f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220552; x=1787825352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SUjBnBdV7pNp3OZVe/2+qT9iBjz7Jwd8aflwWQuaeZk=;
 b=raLfQ14K+Z1Z624EcKxcssWR2mVg+Bc4PczaGVAi6l977wh8ePR1eQUSXo8Bwjd1JF
 LDxXW/hMfSv5A4qBGR+0DnHZxfBrTAbWyFENEFFBC4kVCQSYmz9yrKz+zWgvOy6ZvWvD
 gXUSxYt7HfoeZw6f1qhNSU92L9rvoatCH7WeZoF8EW3ubcOBAsuJLbQEZNEjKvmtEmQE
 ROmqw58EH4lq1NJ4tVt2sC88ROak7K25bXl9f37HMExjcE2EJnP19pz4CGW28PIK4CGh
 NHGpTzeT+47wepDVf9iyguJ5CYzhfFc2IDvzW1AQJXDGfIHL+0Lt8v8IaGEUy5Dn7sRE
 iXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220552; x=1787825352;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SUjBnBdV7pNp3OZVe/2+qT9iBjz7Jwd8aflwWQuaeZk=;
 b=kGP1SYnZUP+YId9ek46UlrUwhv8Oa72RGGRbJJAcsk5SOqSo84IVrMX1VMjwIdBpzI
 eJMvTZbMQ3oKPLLTWdovZlZ9kNISkjdXuBi/dMlrHUNCan7jn9FzCqK1/ZAfGvs0F7oN
 1LbRwEs9eAMA4/7YzK4VIOOZ+OLuh05eydyCz8nYA0/rAgESDCltix894jlPo2Y2Op8P
 wLXc+phh4B6vaIpvCb2JoIPf9wb/Hj7lOxDROfJfkXxf61li/wP6EuI8hfrhdyQnOlc/
 x+ol3L8M/L6pXD5MpW9V4ssYVqOQMFRKRXi1JVkvmRHaTLN633tzwP66HOtmj8zwD/mF
 uFWQ==
X-Gm-Message-State: AFuF++kxeqRaW+HdeV7eBukRtAX88/5M+VRkfrNIW0gClSLmRFMwXWg+
 Gag7Sa7QCy6Dv35mfB3br5y3JEYUcr68Pryla07ICwTMs2/b8j28QrzlslF1PQ6kyafqDTbsKqa
 Mhsx/
X-Gm-Gg: AR+sD11s3hCbzvMRWON64rMAiRw9qVA6DBWHfLKQN1Y4jgXD25RfdfSUV5/xYefjnKw
 QjifXCkFiS2DoIrQ3vpGKLvaXTwDKSzn1wtYe2MsDz8wmy+TVslccC6zuLVswigax+Sl5nAJbpr
 YJv4plzfXULX2DCTvHdnbBAvdXiXbF8qIvj132tEQHSCQMzbLAh7/J+tTxYM6bl5rYg6opnqhmF
 pFIjNqsUr1wsqYG9qDvVW9m8TpJ/oUBd9u7M76yngXlnXOgh4xnpN/8AK55vZTrhp3oSYQ8ptp/
 MSJwlo1UcR0YJhDxZyyN5cY4AjXF9gzWaH7k+lI7Feip4sCX4piP+ZnoIGAL5rzqsA5yltH2v0T
 LhEXhpIp6m+4npgrlCNqy+5p2h3eYI2c90hzfQlHnurYrcygzapKzqRR1YHfMaXDlex22Is2xj3
 eHz500gtlDj7s00ipkyy+ie4siOYhwuDWDfuPOvGlxvn3/gUNC53UDDPohOg==
X-Received: by 2002:a05:6000:715:b0:47f:86d5:d1d7 with SMTP id
 ffacd0b85a97d-482b1e957b9mr22728480f8f.6.1787220551767; 
 Thu, 20 Aug 2026 03:09:11 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 16/17] tests/qtest/ide-test: cover the CHS translation
 across resets
Date: Thu, 20 Aug 2026 12:08:43 +0200
Message-ID: <20260820100844.411717-17-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
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

A translation the guest selected has to survive a software reset and not a
hardware one, and the two arrive at the same ide_reset(), so a fix for
either direction can break the other. Select a translation, put the drive
through a software reset and then through a machine reset, and name the
sector each translation picks along the way.

The marker read says which translation the device is addressing the disk
with, while IDENTIFY DEVICE words 55 and 56 say which one it reports. The
machine reset leaves the PCI command register cleared, so the device has
to be enabled again before the ports answer.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index e7a56e0710..f14a0851f0 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1639,6 +1639,51 @@ static void test_specify_identify_default(void)
     ide_test_quit(qts);
 }
 
+/* A hardware reset reverts the translation (ATA-5 9.1), SRST does not (9.2) */
+static void test_specify_reset(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar, ide_bar2;
+    uint16_t buf[256];
+    char marker[9];
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+    ide_bar2 = qpci_legacy_iomap(dev, IDE_BASE2);
+
+    ide_prepare_markers(qts, dev, ide_bar);
+    ide_set_translation(dev, ide_bar, 8, 32);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    qpci_io_writeb(dev, ide_bar2, 0, IDE_CTRL_RESET);
+    qpci_io_writeb(dev, ide_bar2, 0, 0);
+    ide_wait_clear(qts, BSY);
+
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[55], ==, 8);
+    g_assert_cmpint(buf[56], ==, 32);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    qtest_qmp_assert_success(qts, "{ 'execute': 'system_reset' }");
+    qtest_qmp_eventwait(qts, "RESET");
+    qpci_device_enable(dev);
+
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[55], ==, 16);
+    g_assert_cmpint(buf[56], ==, 63);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_DEFAULT);
+
+    free_pci_device(dev);
+    ide_test_quit(qts);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1714,6 +1759,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/specify/identify", test_specify_identify);
     qtest_add_func("/ide/specify/identify_default",
                    test_specify_identify_default);
+    qtest_add_func("/ide/specify/reset", test_specify_reset);
     qtest_add_func("/ide/migration/chs_translation",
                    test_migrate_chs_translation);
     qtest_add_func("/ide/migration/chs_snapshot", test_migrate_chs_snapshot);
-- 
2.53.0


