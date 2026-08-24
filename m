Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A3BC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawQ-0000ML-E2; Mon, 24 Aug 2026 16:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawO-0000Kt-Jj
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawM-0004aM-9J
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a3fda88184so6175435a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787602001; x=1788206801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vgZZhvbU4Cbo8ry1+snhPPTLSFgEIZHO3pUsmTEMJYs=;
 b=e+Susn+ro0Hbpvrr3bc6bFdjW5S3rfNormViphbD7kke3RnDwDtQ2xMJuuJJs8XWAp
 lxE04xrz+JoyF4V3fSPvMpiJyUrzl2nDv1RKnCPqhnGb0ITkj7lfHW3HkD/L6IQOk8C0
 2aDnQwOUkPEYHq1jshRKK13x23sJBKqYbK2WJieguzQ5wegyFKQfKV0LFyBM+dqhGlOd
 vT9nR5psvcavK2U5qwylgyFY7amPe2rl17agzTesJoiYzasNL7MAbX4gI6wJI2jUmrok
 0SPlHoNSzbwmmcaAHK9Tiq9/k7RGpYQM1zqLnSrVLu9y/Yjo5rkIIRZgks7cIfD2s/tP
 pPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787602001; x=1788206801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vgZZhvbU4Cbo8ry1+snhPPTLSFgEIZHO3pUsmTEMJYs=;
 b=Xr2WdEL5KVqJ5c5Wg9j2kEVlkAL/Hpd7OPlOkbtSFMR3OZ/3WlkiHGJsj7gy2UipYd
 EivllFNP57Yhj6nUHrxL+rAgjcYr289ZQ81EkEUq4HtZdbSfyPie5k4BrrsvxJhL2e3Q
 yJX/wUKroNwH6IHCOLJfjae23n8u0AzbyU8eaopMkctffO5NaiVXhZ2RnMdr0imzCltH
 8RxjQg4PPCZWXT6nVAA9k1KGitLf/6IqHmGeUdKsiB9EUWpnBz5BkDDPcf9R6YsD9cVD
 oxT7CjlXb+xDrrhfKkE2h3kyh/6eRmj7iUw7zAHMqRra7aDbpHJhm2W1eFcdt2bCP4uh
 r9ig==
X-Gm-Message-State: AFuF++lJpu8PX3Hf9yGg/YhBHo/ByvwDxlr9baIk9ubwdURBp+STJM06
 1berDRnYPSWK174Ww1WdnVL3oTONg5LmKAl1lPWBiAvqqMQy2pIbHj2R7Mnm0f1cK5K0sk33M5O
 qhoTM
X-Gm-Gg: AR+sD12Q5rLM9tIDniBp1D0hMz0nOo0GQVzf5q1pY5qHkv1r+B57irv/FIO4aEzy++5
 8+uDXLRldLUcAKd3B+uz4O8QKU52pKwP7bBPLsFglj2cUs6zaOrFdzqqhoUAkSSrIzWNLxdfwp9
 oUU7CJSF00MqRiDgGvh1EjSxVynvP39inNCbDcyvB4niRRDn0Pv5PEYmeE8FI4zZGeC2JOKcEAs
 qqm6luRE3xb5NqX37I2GyRLW2/s9dPBdsqXTX/mish32zEPXCVbvl9fPGqigliC5X3GweqgXMJI
 9UIuU28r8oB0OLy/FQVTjWnDKKqCj7EOUD3T4UvN5fqqF+xGqk0xBagqzLu4WKXZBuZfrq7epF0
 WycFB31ULd4g3UBUuY2oFKlxDl97KU0K1DPiF96XSBq6lVx2ppbpSLGM7VAAcrDQQG5hYb3B2lg
 jYtaRMQ2rTTUexgldlTOl1mQjPWCQyiohvIJsULt1cwTdWQD4MG2YtZzFlwQ==
X-Received: by 2002:a05:6402:4546:b0:6a1:2400:baea with SMTP id
 4fb4d7f45d1cf-6a5c4147e44mr884938a12.10.1787602000857; 
 Mon, 24 Aug 2026 13:06:40 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:40 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 6/7] tests/qtest/ide-test: build the shared disks with qemu-img
Date: Mon, 24 Aug 2026 22:06:26 +0200
Message-ID: <20260824200627.2180635-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
MIME-Version: 1.0
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

The two 64 MiB disks are raw and are grown with ftruncate(), which is
free only where a sparse file is free. Build them as qcow2 when
qemu-img is available, the way ahci-test and hd-geo-test do, keeping
the raw ftruncate() as the fallback. Only the virtual size matters to
their users: the CHS geometry READ NATIVE MAX ADDRESS reports and the
end-of-disk sector the TRIM range check refuses.

Three tests do care what sits below the guest and get a raw 1 MiB
image of their own:

  - the CD-ROM tests write their ATAPI pattern in with fopen()
  - bmdma/trim_reset needs the guest TRIM to reach blkdebug, where a
    1 ms delay lets the reset catch the request in flight. qcow2 stops
    the discard at the format layer, the clusters never having been
    allocated, and the test would pass while racing nothing
  - the two flush tests trip a blkdebug event. Both pass over qcow2,
    but on raw the event reported is the flush the guest issued

Peak scratch space drops from 129 MiB to 1.6 MiB.

Cc: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 69 +++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 805afb9461..89590e66cc 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -37,6 +37,12 @@
 /* Specified by ATA (physical) CHS geometry for ~64 MiB device.  */
 #define TEST_IMAGE_SIZE ((130 * 16 * 63) * 512)
 
+/*
+ * The tests that reach the image behind QEMU's back, or that need an
+ * event to reach blkdebug, get a raw one of their own.
+ */
+#define RAW_IMAGE_SIZE (1 * 1024 * 1024)
+
 #define IDE_PCI_DEV     1
 #define IDE_PCI_FUNC    1
 
@@ -131,7 +137,9 @@ static QPCIBus *pcibus = NULL;
 static QGuestAllocator guest_malloc;
 
 static char *tmp_path[2];
+static char *raw_path;
 static char *debug_path;
+static const char *imgfmt = "raw";
 
 G_GNUC_PRINTF(1, 2)
 static QTestState *ide_test_start(const char *cmdline_fmt, ...)
@@ -348,9 +356,9 @@ static QTestState *test_bmdma_setup(void)
     QTestState *qts;
 
     qts = ide_test_start(
-        "-drive file=%s,if=ide,cache=writeback,format=raw "
+        "-drive file=%s,if=ide,cache=writeback,format=%s "
         "-global ide-hd.serial=%s -global ide-hd.ver=%s",
-        tmp_path[0], "testdisk", "version");
+        tmp_path[0], imgfmt, "testdisk", "version");
     qtest_irq_intercept_in(qts, "ioapic");
 
     return qts;
@@ -506,7 +514,7 @@ static void test_bmdma_trim_reset(void)
         "inject-error.0.event=none,inject-error.0.iotype=discard,"
         "inject-error.0.errno=0,inject-error.0.delay-ns=1000000 "
         "-device ide-hd,drive=dbg,bus=ide.0",
-        tmp_path[0]);
+        raw_path);
     qtest_irq_intercept_in(qts, "ioapic");
 
     guest_buf = guest_alloc(&guest_malloc, len);
@@ -664,9 +672,9 @@ static void test_specify(void)
     uint8_t heads, spt;
 
     qts = ide_test_start(
-        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-drive if=none,id=hda,format=%s,file=%s "
         "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
-        tmp_path[0]);
+        imgfmt, tmp_path[0]);
 
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
 
@@ -706,9 +714,9 @@ static void test_identify(void)
     int ret;
 
     qts = ide_test_start(
-        "-drive file=%s,if=ide,cache=writeback,format=raw "
+        "-drive file=%s,if=ide,cache=writeback,format=%s "
         "-global ide-hd.serial=%s -global ide-hd.ver=%s",
-        tmp_path[0], "testdisk", "version");
+        tmp_path[0], imgfmt, "testdisk", "version");
 
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
 
@@ -756,11 +764,11 @@ static void test_diagnostic(void)
     uint8_t data;
 
     qts = ide_test_start(
-        "-blockdev driver=file,node-name=hda,filename=%s "
-        "-blockdev driver=file,node-name=hdb,filename=%s "
+        "-drive if=none,id=hda,format=%s,file=%s "
+        "-drive if=none,id=hdb,format=%s,file=%s "
         "-device ide-hd,drive=hda,bus=ide.0,unit=0 "
         "-device ide-hd,drive=hdb,bus=ide.0,unit=1 ",
-        tmp_path[0], tmp_path[1]);
+        imgfmt, tmp_path[0], imgfmt, tmp_path[1]);
 
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
 
@@ -826,7 +834,7 @@ static void test_flush(void)
 
     qts = ide_test_start(
         "-drive file=blkdebug::%s,if=ide,cache=writeback,format=raw",
-        tmp_path[0]);
+        raw_path);
 
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
 
@@ -877,7 +885,7 @@ static void test_pci_retry_flush(void)
     qts = ide_test_start(
         "-drive file=blkdebug:%s:%s,if=ide,cache=writeback,format=raw,"
         "rerror=stop,werror=stop",
-        debug_path, tmp_path[0]);
+        debug_path, raw_path);
 
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
 
@@ -1100,14 +1108,14 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
 
     /* Prepopulate the CDROM with an interesting pattern */
     generate_pattern(pattern, patt_len, ATAPI_BLOCK_SIZE);
-    fh = fopen(tmp_path[0], "wb+");
+    fh = fopen(raw_path, "wb+");
     ret = fwrite(pattern, ATAPI_BLOCK_SIZE, patt_blocks, fh);
     g_assert_cmpint(ret, ==, patt_blocks);
     fclose(fh);
 
     qts = ide_test_start(
             "-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
-            "-device ide-cd,drive=sr0,bus=ide.0", tmp_path[0]);
+            "-device ide-cd,drive=sr0,bus=ide.0", raw_path);
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
     qtest_irq_intercept_in(qts, "ioapic");
 
@@ -1258,7 +1266,11 @@ int main(int argc, char **argv)
     }
     close(fd);
 
-    /* Create a temporary raw image */
+    if (have_qemu_img()) {
+        imgfmt = "qcow2";
+    }
+
+    /* Create the disks the tests share */
     for (i = 0; i < 2; ++i) {
         tmp_path[i] = g_strdup_printf("%s/qtest.XXXXXX", base);
         fd = g_mkstemp(tmp_path[i]);
@@ -1267,6 +1279,15 @@ int main(int argc, char **argv)
                            strerror(errno));
             goto test_add_done;
         }
+        if (!strcmp(imgfmt, "qcow2")) {
+            close(fd);
+            if (!mkimg_bytes(tmp_path[i], imgfmt, TEST_IMAGE_SIZE)) {
+                g_test_message("Could not create %s with qemu-img",
+                               tmp_path[i]);
+                goto test_add_done;
+            }
+            continue;
+        }
         ret = ftruncate(fd, TEST_IMAGE_SIZE);
         err = errno;
         close(fd);
@@ -1277,6 +1298,20 @@ int main(int argc, char **argv)
         }
     }
 
+    raw_path = g_strdup_printf("%s/qtest.XXXXXX", base);
+    fd = g_mkstemp(raw_path);
+    if (fd < 0) {
+        g_test_message("Could not create %s: %s", raw_path, strerror(errno));
+        goto test_add_done;
+    }
+    ret = ftruncate(fd, RAW_IMAGE_SIZE);
+    err = errno;
+    close(fd);
+    if (ret < 0) {
+        g_test_message("Could not size %s: %s", raw_path, strerror(err));
+        goto test_add_done;
+    }
+
     qtest_add_func("/ide/read_native", test_specify);
 
     qtest_add_func("/ide/identify", test_identify);
@@ -1312,6 +1347,10 @@ test_add_done:
         unlink(tmp_path[i]);
         g_free(tmp_path[i]);
     }
+    if (raw_path) {
+        unlink(raw_path);
+        g_free(raw_path);
+    }
     unlink(debug_path);
     g_free(debug_path);
 
-- 
2.53.0


