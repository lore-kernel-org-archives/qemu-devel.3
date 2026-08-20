Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969D1C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzib-0007AH-4Y; Thu, 20 Aug 2026 06:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhv-0006uu-DK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhs-0008Op-Mc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1704806f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220547; x=1787825347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oGUR0cenTpNa60oyZashSxoxcA0EDHIVX1H0+0f+Yow=;
 b=SIMV41uc9noMqW0QP+udSeva6ylPftLcYAAb9CpAW/nfo56dZUVesKAQU1Pw5qZs8r
 LJMGvACyVydzcqL1dnLyWvL9LHWiJanooEcVtIBj39Lomm1XYIpRvw+nRpZTTtcdhn1q
 vdXXstSgSkc1saJhL4Zutmpn8jW0sCPGYrKALYJkS5PzjfHDf/jm6abt6IBUkvLSkvfs
 gMGUl33JT8+EMQJDHQbO8rqqhg6Vcg+VPQZcWi3f8VkUtXdUdzKE3fqr2Hw5XihQZflf
 CuUuCyH/O43VQ8yY73VvCoRAyp9oAr45B2qaXQ3UZGC4JCI7diJi8AF/hpNgTqsyWHvl
 fkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220547; x=1787825347;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oGUR0cenTpNa60oyZashSxoxcA0EDHIVX1H0+0f+Yow=;
 b=rvzVGI3E8EgmopabMzwPkzH7QYpJ6Quv3QZ/Wh7T4Fn0T+97nG90N0+yBGZKwQWWmb
 D9XyrCCkda5eq2gkPmfnUxQpPtxyqMJYB2c0zHZQ9ztTSTcEiWBYEYtmabehTaZWpkjG
 PtkUCG3Kq9zEqJLT/qvk9ahuK0qYPxK4Tv2oq3mb/zIVZlQ95+/gNxOxjZnd6Fa+qRjn
 pwsf67YN/Qu8mfRYT9dP+10TrGkTlrNJ/ShKoSBax5J1wctY796qjvLftnyyyWFXccJr
 17uegNQV6J//ff5yw7keGTUzaExFv1/CPguozh8fMZa7ePMEZctwp6FilvU6IEJ8Zq9f
 Wmtg==
X-Gm-Message-State: AFuF++ntLXWQzMSAPCZA3s0Rk6g9WUGV5ThWyURJrINiGss3aNyK+AO7
 MCxHhPPweKE8Bh69WiceW7hPZGacAYsGZQgByKpFNb2czr0ZtQz2xQF9qFVAO43oDvrRsT1D31I
 bf69X
X-Gm-Gg: AR+sD10+8JQUZ0JDnmB57isbkUzh8bqGryH/wM6C949Lpu3/FB3LmyzPURP+0TRIkB0
 EV1VyCRym8DXPYprMDn/8l4Yun992FrQIWYG343lDC43QmTHWQL0KsHtcD7AhVthXbwJNgKR75Z
 a/ArkMQ90xdLKCo6I20Js1/moTdUdTf02HcVSUKlG6AlvOGYX9+EVZys318K1sZ1xqkx5mrS+bb
 AWMpsYD4Dt1u+99ZOb+aaWf3vNWtuJXpG4Yx5BR/UMxrCSdn/88GDFLuVaMddHwbjC5NCMygXC7
 8T8+yz1AI0jhOjV/2TbbZxghMe4ph7S+BArxctdr6DutAmW174QYeiRUl6+5jGkU1j/pwcxskiH
 4/0JvcxA6v/oTlFTw9eEgB3W3vHlkWBWIkenVlGOevY8FdrIqv3OLwXR58mXDEWJ1S8xSsFwZh5
 nVRmiGDSVCZ7tlBEaGFagxXc5VDq8U3Vx7hOTmILoeVPDx7J1q7k1ttt4cTw==
X-Received: by 2002:a05:6000:26cb:b0:47f:c62e:9cca with SMTP id
 ffacd0b85a97d-482b1fed744mr19145271f8f.22.1787220547001; 
 Thu, 20 Aug 2026 03:09:07 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 12/17] tests/qtest/ide-test: cover the CHS translation
 across migration
Date: Thu, 20 Aug 2026 12:08:39 +0200
Message-ID: <20260820100844.411717-13-den@openvz.org>
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

Both defects here are silent: the guest addresses the disk in the
translation it selected while the device translates with another, so reads
and writes land on a sector nobody asked for. Put a marker in each of the
two candidate sectors and name the one the translation picked. CHS 0/1/1
is LBA 32 under 8 heads and 32 sectors per track and LBA 63 under the
16/63 the test drive is configured with; both markers are written by LBA,
which no translation can influence.

A translation the guest selected has to survive migration, and one it
selected after a snapshot was taken must not outlive loading that snapshot
back. The second needs a qcow2 image, so it is skipped without qemu-img.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 231 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 99aa5e039c..19e9734d3c 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -96,6 +96,7 @@ enum {
 enum {
     CMD_DSM         = 0x06,
     CMD_READ        = 0x20,  /* READ SECTOR(S) */
+    CMD_WRITE       = 0x30,  /* WRITE SECTOR(S) */
     CMD_DIAGNOSE    = 0x90,
     CMD_INIT_DP     = 0x91,  /* INITIALIZE DEVICE PARAMETERS */
     CMD_READ_DMA    = 0xc8,
@@ -1255,6 +1256,233 @@ static void test_specify_zero_sectors(void)
     free_pci_device(dev);
 }
 
+/* Addressed by LBA, so no translation can influence where it lands */
+static void ide_write_marker(QTestState *qts, QPCIDevice *dev, QPCIBar ide_bar,
+                             uint32_t lba, const char *marker)
+{
+    uint16_t buf[256];
+    uint8_t data;
+    int i;
+
+    memset(buf, 0, sizeof(buf));
+    memcpy(buf, marker, strlen(marker));
+
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 1);
+    qpci_io_writeb(dev, ide_bar, reg_lba_low, lba & 0xff);
+    qpci_io_writeb(dev, ide_bar, reg_lba_middle, (lba >> 8) & 0xff);
+    qpci_io_writeb(dev, ide_bar, reg_lba_high, (lba >> 16) & 0xff);
+    qpci_io_writeb(dev, ide_bar, reg_device, LBA | ((lba >> 24) & 0xf));
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_WRITE);
+
+    data = ide_wait_clear(qts, BSY);
+    assert_bit_set(data, DRQ);
+    for (i = 0; i < 256; i++) {
+        qpci_io_writew(dev, ide_bar, reg_data, buf[i]);
+    }
+    data = ide_wait_clear(qts, BSY);
+    assert_bit_clear(data, ERR | DF | DRQ);
+
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_FLUSH_CACHE);
+    data = ide_wait_clear(qts, BSY);
+    assert_bit_clear(data, ERR | DF);
+}
+
+/* The marker read back names the sector the translation selected */
+static void ide_read_chs_marker(QTestState *qts, QPCIDevice *dev,
+                                QPCIBar ide_bar, uint8_t cyl_lo, uint8_t head,
+                                uint8_t sector, char out[9])
+{
+    uint16_t buf[256];
+    uint8_t data;
+    int i;
+
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 1);
+    qpci_io_writeb(dev, ide_bar, reg_lba_low, sector);
+    qpci_io_writeb(dev, ide_bar, reg_lba_middle, cyl_lo);
+    qpci_io_writeb(dev, ide_bar, reg_lba_high, 0);
+    qpci_io_writeb(dev, ide_bar, reg_device, head & 0xf);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_READ);
+
+    data = ide_wait_clear(qts, BSY);
+    assert_bit_set(data, DRQ);
+    assert_bit_clear(data, ERR | DF);
+    for (i = 0; i < 256; i++) {
+        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
+    }
+    data = ide_wait_clear(qts, BSY);
+    assert_bit_clear(data, ERR | DF | DRQ);
+
+    memcpy(out, buf, 8);
+    out[8] = '\0';
+}
+
+static void ide_set_translation(QPCIDevice *dev, QPCIBar ide_bar,
+                                uint8_t heads, uint8_t sectors)
+{
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, sectors);
+    qpci_io_writeb(dev, ide_bar, reg_device, heads - 1);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_INIT_DP);
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), ERR);
+}
+
+/* CHS 0/1/1 is LBA 32 under 8/32, and LBA 63 under the drive's own 16/63 */
+#define CHS_MARKER_CUSTOM  "CUSTOM__"
+#define CHS_MARKER_DEFAULT "DEFAULT_"
+
+static void ide_prepare_markers(QTestState *qts, QPCIDevice *dev,
+                                QPCIBar ide_bar)
+{
+    ide_write_marker(qts, dev, ide_bar, 32, CHS_MARKER_CUSTOM);
+    ide_write_marker(qts, dev, ide_bar, 63, CHS_MARKER_DEFAULT);
+}
+
+static void ide_hmp_quiet(QTestState *qts, const char *command)
+{
+    g_autofree char *out = qtest_hmp(qts, "%s", command);
+
+    g_assert_cmpstr(out, ==, "");
+}
+
+static char *ide_migration_status(QTestState *qts)
+{
+    QDict *ret;
+    char *status;
+
+    ret = qtest_qmp_assert_success_ref(qts, "{ 'execute': 'query-migrate' }");
+    g_assert(qdict_haskey(ret, "status"));
+    status = g_strdup(qdict_get_str(ret, "status"));
+    qobject_unref(ret);
+
+    return status;
+}
+
+/* Waiting for the other side's event would hang if it refuses the stream */
+static void ide_migration_wait(QTestState *qts, const char *expected)
+{
+    while (true) {
+        g_autofree char *status = ide_migration_status(qts);
+
+        if (g_str_equal(status, expected)) {
+            return;
+        }
+        if (!g_str_equal(status, "setup") && !g_str_equal(status, "active") &&
+            !g_str_equal(status, "device")) {
+            fprintf(stderr, "Migration status is %s, expected %s\n",
+                    status, expected);
+            g_assert_not_reached();
+        }
+        g_usleep(5000);
+    }
+}
+
+static void ide_migrate(QTestState *src, QTestState *dst, const char *uri)
+{
+    qtest_qmp_assert_success(src, "{ 'execute': 'migrate',"
+                             " 'arguments': { 'uri': %s } }", uri);
+    qtest_qmp_eventwait(src, "STOP");
+    ide_migration_wait(src, "completed");
+    qtest_qmp_eventwait(dst, "RESUME");
+}
+
+/* A translation the guest selected has to survive migration */
+static void test_migrate_chs_translation(void)
+{
+    QTestState *src, *dst;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    g_autofree char *mig_path = NULL;
+    g_autofree char *uri = NULL;
+    g_autofree char *dst_args = NULL;
+    char marker[9];
+    int fd;
+
+    fd = g_file_open_tmp("qtest-ide-migration.XXXXXX", &mig_path, NULL);
+    g_assert(fd >= 0);
+    close(fd);
+    uri = g_strdup_printf("unix:%s", mig_path);
+
+    src = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s,locking=off "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(src, &bmdma_bar, &ide_bar);
+
+    ide_prepare_markers(src, dev, ide_bar);
+    ide_set_translation(dev, ide_bar, 8, 32);
+    ide_read_chs_marker(src, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    dst_args = g_strdup_printf(
+        "-machine pc "
+        "-blockdev driver=file,node-name=hda,filename=%s,locking=off "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 -incoming %s",
+        tmp_path[0], uri);
+    dst = qtest_init(dst_args);
+
+    ide_migrate(src, dst, uri);
+
+    /* Talk to the destination instead of the source */
+    qpci_free_pc(pcibus);
+    pcibus = NULL;
+    free_pci_device(dev);
+    dev = get_pci_device(dst, &bmdma_bar, &ide_bar);
+
+    ide_read_chs_marker(dst, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    free_pci_device(dev);
+    qtest_quit(dst);
+    ide_test_quit(src);
+    unlink(mig_path);
+}
+
+/* A translation selected after the snapshot must not outlive loading it */
+static void test_migrate_chs_snapshot(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    g_autofree char *img = NULL;
+    char marker[9];
+    int fd;
+
+    if (!have_qemu_img()) {
+        g_test_skip("QTEST_QEMU_IMG not set, snapshots need a qcow2 image");
+        return;
+    }
+
+    fd = g_file_open_tmp("qtest-ide-snapshot.XXXXXX", &img, NULL);
+    g_assert(fd >= 0);
+    close(fd);
+    g_assert(mkimg(img, "qcow2", TEST_IMAGE_SIZE / (1024 * 1024)));
+
+    qts = ide_test_start(
+        "-blockdev driver=qcow2,node-name=hda,file.driver=file,"
+        "file.filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ", img);
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+    ide_prepare_markers(qts, dev, ide_bar);
+
+    /* Snapshot taken while the default translation is in effect */
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_DEFAULT);
+    ide_hmp_quiet(qts, "savevm s0");
+
+    ide_set_translation(dev, ide_bar, 8, 32);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    ide_hmp_quiet(qts, "loadvm s0");
+
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_DEFAULT);
+
+    free_pci_device(dev);
+    ide_test_quit(qts);
+    unlink(img);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1327,6 +1555,9 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ide/read_native", test_specify);
     qtest_add_func("/ide/specify/zero_sectors", test_specify_zero_sectors);
+    qtest_add_func("/ide/migration/chs_translation",
+                   test_migrate_chs_translation);
+    qtest_add_func("/ide/migration/chs_snapshot", test_migrate_chs_snapshot);
 
     qtest_add_func("/ide/identify", test_identify);
 
-- 
2.53.0


