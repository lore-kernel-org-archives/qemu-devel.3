Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843A7C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4Ko-0006kN-K8; Mon, 17 Aug 2026 16:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KR-0006Zk-R7
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KN-0006je-Kf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so31683665e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999981; x=1787604781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSm5NQKqDy0ps9/xCTmRAIukRHsQCl6pvMOawl5AhM8=;
 b=l+CWZ5DbqKzZ8v1xnNxqt9QmQwWC1byFrCFd005VI/5QSbCoHj61Xl0ltH2GoPw7PT
 IqWWQCtHIjJXKtkBnzAaOj3CF9cUiuJqdJ1qzN2wTf8XIPthx1eFOdJ9knf8K5fBcVIA
 U/pScDoTsVCDBR2z2jsCXXN6Q3a4rTuLl+o0wXfGpc/qe5r0NaMdIv3SuloKO58kKtt4
 uBWc4Ld6wWTF8V+EkopzkFY9F9wtC8LYm4JZbMRNkCLRiNXvRgwDCApTNFxGblNEhU0k
 JfCYzNXpjTaqywNMSMOy1Ba7DPgeRgBz0vrL4yZXRiSWiwx47Z2ZR0GMFPRdSPcZ08cM
 2PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999981; x=1787604781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lSm5NQKqDy0ps9/xCTmRAIukRHsQCl6pvMOawl5AhM8=;
 b=Bi+U03bo+/QISHgPmd7hMjf6W6twX6yemP+j7CCWje3ovDYLSyyEQ6c4x+rI2oUJYr
 g/pY0tBmnnZ5Ss4fhtn6uLYeyg+zjJsE3Wu8kHcpDNtiMaYwQnTJOHkLjSo1Pfyhm5lS
 ywCQy4ac051gddtx2hrcXcN2rZy8LLie7SGGmsq1vdKrmb+Et39C2sFfylO7IMB/0Tp6
 XvjDs6cpUPo6hjOiaSTIc8OrR0R8eHVL5jFevGzcDBDV4kGT+AJf1ARYp/Uc2kukO2hU
 smStprdXlLwF45TZ9AO7VfXfgZX8K9Xbt5Njs+y9rk8Tdvbg24QZMvJdaO2j84Cu33ma
 tvBQ==
X-Gm-Message-State: AOJu0YwxiDumZNIfkjwO/mzSfHsGSi2UG9PNn0fQMRUqdxVCfRGx/9Et
 kFYS6NLWVLqP9lmSPh1ziwt6RuaZ1Tj/sEg9ve/dQyX/0jUB63b7scaAS2TTlokqYe6nFzTUxSn
 0tFgZ
X-Gm-Gg: AR+sD10DQzWw8NKDEBf3he6SnZ6s36gHh9oizM9gIwKJTaQdauA/G8CPR7EkJhPd0aP
 tQLXghTInvwM0tXUUWwbfAoIzg32VFDztD8vmKjbx9HIboA9y2qPrCEYdDBjvg+lHeu03JpFdZY
 kmwRKaE1oJv7DyRp8sj7galHwppGH51RKu9aKmPfTw/9x1vzmE6fNla7huttPYmq4gH37jhT2Sc
 3u2xcV5bgCC3XZ27rMU8aAdPedpcAxfq5wpThkkQYbS8bKPGThrmdfRo59h8Zh9QaqOjF7fWWGl
 uJwbT0H+ePHSIHnEJrLGnd0ctCYBrSxH29fxF/gSXEWd2oBCX4kcK0/PuqPyzgBxyJtP97PnEFv
 sQxTCZFmKoVA+CQKvsg1dzfttV8aawSGZRcsEusiMSzfBuXWoBGMewuFA29R39BQiHkRvuxJvIu
 P6x7VbpMTRIsP0mkm+WhJQ4R6JHR4BHTZSI5g5eHDPtK/afEs46w==
X-Received: by 2002:a05:600c:3491:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-4999fb3be75mr54853995e9.11.1786999981567; 
 Mon, 17 Aug 2026 13:53:01 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:53:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 12/15] tests/qtest/ide-test: cover the IDENTIFY DEVICE
 geometry words
Date: Mon, 17 Aug 2026 22:52:39 +0200
Message-ID: <20260817205242.1199851-13-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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


