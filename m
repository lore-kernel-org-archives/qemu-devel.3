Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB109C5DF7F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4Kn-0006jb-5I; Mon, 17 Aug 2026 16:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KP-0006ZU-QQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KL-0006jD-PW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-499840a2575so29443925e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999980; x=1787604780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ih6WBmLbxMIFAynHL/+kBFl+c1Otlb088ghzMEF0/zk=;
 b=jqjtm98pa6ffER54ulPp7UEcn9AxJX/9FCCRls5MKmXTrduCL42adBhrsAPV036Ctg
 g89BKAHEaIoMg8IoLbojdcXU9c/laZtJ/4NbTciQcIVezk0Gz/zWc6FUhwXgWpXwQjjK
 g3pUAzYL2FM2KsvYo4yi9QcZiDVKBJaEFPsvGcI1hOspNu7AuycU7OoLW9YccfKI9nyx
 IWPk/gBA2d+ucyT/k65a7jipf3o894hf64kvuv0OTnKzFiTDLupeyT/48DHWdPTOzqFf
 0+6VG7yxoaLUrbzEHEseGdv5BpT6i/TtWdbGFtmlTz1KGQXTR/MBj5hOjQXhaRNMpzrz
 NPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999980; x=1787604780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ih6WBmLbxMIFAynHL/+kBFl+c1Otlb088ghzMEF0/zk=;
 b=etdDg9j4CBHhmjRxnVlmzr9n4oCdFIqkPHyfxieqzXfPyT29X6V2pY9mpmAKlccftW
 3GECdKuSvGbgYDMSSEtWQU6837zQH7I5FaMIVeD45zeAcW0u1miAmFCT+kSfe9PW6x1c
 fI9D8OJCbmNt3fO/vBFDr32UbDJWXDnH7dCKwiz/WNJXSVgf2JKrBKk6iS8GftmpBaOx
 Xqmh/cDL7U+gYS26oIoYbbvBEDKlMuM/eMUIWnAd6TizOJrAkkclKglwMQ717GyfnVJt
 76IADjVVovtv+aEoB7wPUUdBV2R34v0xUpXhlDDG3DyNqMXECpBEGQsKfYBe1unt+Yr5
 mmNQ==
X-Gm-Message-State: AOJu0Yy6CAunaB/Zc86f5ciFbrfyS10xV9wK9mVCrRAOuexCEt04rPPx
 en8JY627K/Rfx+c/g+pfiF73kEz2W7XPg/SpxUwxOoZ559Ry0nP2q0Z+mE3ILBNlZikJNqdhMZ2
 XC4Lv
X-Gm-Gg: AR+sD10zd5/EU7+cFPb00Hibu0Ei4g/MTa7aCkcQisihoaPGbpO1dB1fROM9PWteOl6
 Lp5P4M7el/uuHKinSUVPNQG9SI4nVyrT5dFdRbWgknpHgZUwo0uJQ0qP0fa2DPh4jgwUSvqw9Mf
 VXv2nWlW8ySHL1s1fIqDNcDFqwa+mQ5IxstTcmOe3ovWzvL64te6HbnEqZ++TaMvlZEyr2eao2f
 fmKK+wFDWbz4lopaocm2TeF1yZJQYl15r66URgVHKr61hySWHGLAm+DXldsCbxbx34g2i63Za32
 wtkUV2gkjxotZ4zzFSwi7N52xyU3gWCYdkiupk9Bfckx1Nqx9JNtbJ5VATrB/u+6x8k/dlUOnud
 Qk4cm6ejdolnBoP+tarA+XTh0yI2BV92ACUOO9ElhWbaRsF0JlYryAvnhfh3U+KrOST69q0qgTy
 JHz/b+7C/9y4CfVVx2zna384HFjh2Bs0XrDroNcwe3hdevyyMU0w==
X-Received: by 2002:a05:600c:608a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-499a202cb4cmr8589945e9.6.1786999980385; 
 Mon, 17 Aug 2026 13:53:00 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:59 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 11/15] tests/qtest/ide-test: cover a rejected CHS translation
 in the stream
Date: Mon, 17 Aug 2026 22:52:38 +0200
Message-ID: <20260817205242.1199851-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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

ide_drive_post_load() refuses a logical CHS translation that no command
could have selected, as the fields are a divisor in ide_set_sector() and a
factor in ide_get_sector(). Nothing exercised that, a fixed QEMU having no
way to produce such a stream.

Migrate a guest that selected a translation to a file, replace the number
of sectors per logical track in the subsection with a zero, and let a
destination read the result back. The load has to fail rather than take
the value, so the destination is asked not to exit on a failed incoming
migration and its migration status is what the test looks at.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 19e9734d3c..4fa58ac525 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1483,6 +1483,86 @@ static void test_migrate_chs_snapshot(void)
     unlink(img);
 }
 
+/* A migration stream holds NUL bytes, so this cannot be a string search */
+static char *ide_stream_find(char *stream, gsize len, const char *name)
+{
+    gsize name_len = strlen(name);
+    gsize i;
+
+    if (len < name_len) {
+        return NULL;
+    }
+    for (i = 0; i <= len - name_len; i++) {
+        if (memcmp(stream + i, name, name_len) == 0) {
+            return stream + i;
+        }
+    }
+
+    return NULL;
+}
+
+/* A translation no command could have selected has to be refused on load */
+static void test_migrate_chs_rejected(void)
+{
+    const char *name = "ide_drive/chs_translation";
+    QTestState *src, *dst;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    g_autofree char *path = NULL;
+    g_autofree char *uri = NULL;
+    g_autofree char *dst_args = NULL;
+    g_autofree char *stream = NULL;
+    char *subsection;
+    gsize len;
+    int fd;
+
+    fd = g_file_open_tmp("qtest-ide-stream.XXXXXX", &path, NULL);
+    g_assert(fd >= 0);
+    close(fd);
+    uri = g_strdup_printf("file:%s", path);
+
+    src = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(src, &bmdma_bar, &ide_bar);
+
+    ide_set_translation(dev, ide_bar, 8, 32);
+    qtest_qmp_assert_success(src, "{ 'execute': 'migrate',"
+                             " 'arguments': { 'uri': %s } }", uri);
+    qtest_qmp_eventwait(src, "STOP");
+    ide_migration_wait(src, "completed");
+    free_pci_device(dev);
+    ide_test_quit(src);
+
+    /*
+     * Behind the name come version, heads and sectors, each big endian 32 bit.
+     * The name recurs in the description at the end of the stream, so the
+     * first match is the one carrying data.
+     */
+    g_assert(g_file_get_contents(path, &stream, &len, NULL));
+    subsection = ide_stream_find(stream, len, name);
+    g_assert(subsection);
+    g_assert_cmpint(subsection - stream + strlen(name) + 12, <=, len);
+    memset(subsection + strlen(name) + 8, 0, 4);
+    g_assert(g_file_set_contents(path, stream, len, NULL));
+
+    dst_args = g_strdup_printf(
+        "-machine pc "
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 -incoming defer",
+        tmp_path[0]);
+    dst = qtest_init(dst_args);
+
+    qtest_qmp_assert_success(dst, "{ 'execute': 'migrate-incoming',"
+                             " 'arguments': { 'uri': %s,"
+                             " 'exit-on-error': false } }", uri);
+    ide_migration_wait(dst, "failed");
+
+    qtest_quit(dst);
+    unlink(path);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1558,6 +1638,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/migration/chs_translation",
                    test_migrate_chs_translation);
     qtest_add_func("/ide/migration/chs_snapshot", test_migrate_chs_snapshot);
+    qtest_add_func("/ide/migration/chs_rejected", test_migrate_chs_rejected);
 
     qtest_add_func("/ide/identify", test_identify);
 
-- 
2.53.0


