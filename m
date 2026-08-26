Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59D7C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfI-0004LE-EM; Wed, 26 Aug 2026 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfD-0004Gp-Om
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:28 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfA-0005fc-Gc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:26 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a051904222so722594a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743163; x=1788347963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fDm9ZpUciP0grPAB9hW7JUEStxBgYv9yYQDvW3aVEbQ=;
 b=QrVEjn5m79pFVD3TBjbAY8BcgyLCwViFobJ1B+Kbrv0MLm2CPgoD7iHAf1fOk5zwUr
 6dsNybBv50+Lr0tZBGw1fHwyyJ4a5EROdF2h+7YaXgor5P/J8XanukwhUuQpuCubaqkC
 rPR0pd8HgNWIvxq9YQW6e6+JthMz/dD8u17LtjYBcSsOGf2rUYeZc2PAKG9WIVWxuZaq
 PcLlYSrhRfE53X35w8kvQH9zgRf+40/UWWD6zoDWNC1s21zz0TxaPwjCzssTKJnmHGap
 idjxdlwVlP0TrgqHxkIwZyT9hlxs478nCftGciiopIAiw77lpeXMQkUAOOsjWY0Y4QDz
 H+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743163; x=1788347963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fDm9ZpUciP0grPAB9hW7JUEStxBgYv9yYQDvW3aVEbQ=;
 b=FtSt0wRmPt67tTyur5A/5Y5BnYpXfXuu91g/su4XUkLsxZlVXz2PGaGQoG6xMSuEaz
 X6gqJ3KdymIZzxbMWAw2m4lKnWXjDw4JvR8zWJDd8xbqFQ+PiCd3U9AqwMilxDo8+2bv
 D3bGfh1rAxF52IMIF38GJLc9QgX6ahwXLYV5FTFuVegz9St0b2q5UFApip6n9kWCbrDe
 /mNFx+pqrGufc89lYpllN2BGI/ZCuR/GpWgOg1+f5c9aW5YcG7cPXCafNDnNdbIgR9HS
 atp6k3tGX5kDW14gX/rTDz+wo5GYEe3kvM7BUz1K1441OXdSL25NXqdO5VyK9Bi/RAyH
 Vnow==
X-Gm-Message-State: AFuF++mDCzUUwIpNQWIlxeFtkPCURssHrEKD6ASsLSdlQ/3x89iIgnB/
 tWsnLxb8ReaeWK6h8dltkSp+vYRnYNiz9Mtrs5jO1vxQ5x8VfEYOMVZTIzOyqyJD3WvBHtHVeCE
 LWP/+
X-Gm-Gg: AR+sD11jaPhW4NmMTOXRVes7O3hyqrVf1XHuA+LN6hiYHYCxFrlhTFtedo5uO3lViYK
 cuut+ED1U1GscqrDG/pAUNe8/c9wa8WEHCsc+pV0wmADmQLbsCxg/5f0CX6ZcZsvB/WN5Ao6oKq
 +kh7PKE86IRuAu63EuaqgKMhd89yZ7H4JGB3g3zic10fQeoREHMjmMXGXrbA4AdMA3UljWc7we0
 zkK9On0tRzXb/xhVjUnmNOatHymtNogifp3jQgv70PQYPXaih+IKyISev21U9xnfzEB2eAFjoF/
 OX1kulf23slh0lvTsQj0Jz8gDAWP1XmKwiS7tv6Pst+/bQRxV9jDyYZxsG7eLhOAJZNvOELJj8c
 bAJO4jyVuxM77N73s59LSKJRft98d76FMQGtNRvObvPwpQMP/Fswc/HFkoFwZ0v6PtO+3PJ1Hgb
 jTrjY5zw3ty/UBZWSbOuEiP8G24VfTZV/zYfqnC5aOe06ufwYQ
X-Received: by 2002:a05:6402:910:b0:6a5:d401:b575 with SMTP id
 4fb4d7f45d1cf-6a5df61e129mr8428385a12.7.1787743163183; 
 Wed, 26 Aug 2026 04:19:23 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:22 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 14/28] tests/qtest/ide-test: cover the IDENTIFY DEVICE geometry
 words
Date: Wed, 26 Aug 2026 13:19:01 +0200
Message-ID: <20260826111915.3387926-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=den@openvz.org; helo=mail-ed1-x532.google.com
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


