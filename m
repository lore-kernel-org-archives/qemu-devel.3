Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93638C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwziI-00071b-3I; Thu, 20 Aug 2026 06:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhv-0006ux-Lr
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzht-0008PN-Hz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so971338f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220548; x=1787825348; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nkj2k6nchMuIJVjh47utAhxnpSusPJpE2MYttsvWBKI=;
 b=qra7BUBruBUQ1qoJNAzV+ejEkB5K+5xmm6nbyl6LAhUjQvNUiUgUb0Rrf6OnMvRXsZ
 ll5D1lFqNiWvoVDqstQusmL1f0DC/0Vykia9A9b7dRWppxsQI/vnOPo6BzbVvuuHVK0G
 bqUDEHzEs4MMmK5TZ56s1lMQSwm3ujnaMY0s+ndcRSuTBVe8Wwt1bJh1rUb1uDszoXQw
 tP97bYG7Fbd03LudWY/wOE4WxhRyJ9CBQQQCpL5huCK0QEPYpy6IaadlYqUs71DfXhxJ
 lXU9WNd/IQ0KSRpjXgYCeKTwTyebyoXZZebIky9HhKDE1qbszfnpP80AQFPP95cs732+
 D+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220548; x=1787825348;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nkj2k6nchMuIJVjh47utAhxnpSusPJpE2MYttsvWBKI=;
 b=O9aGsKwBSG3lPPBHNRC7YGnqsfA7rduJ+hmNbdlGkrzjoEoQsAZD3Qx/ZN7qlt0jTP
 DidIzNNwqAULu3jKVDHn8aZA+iMHNocP8AcBdR/8B15Cpj7hRAga3pbdpbrBPbYXO6eV
 lGFIwFGznuAub+0KWMhGSN8SbwFsAGHYyaI7pxRBJ7yV8xWhBM/OfBjHdo9EcEfQg/bu
 4CkB0gGuTbM9K4eDOhHZAlQYNmqk5FORj8Qz/2FCm2a9OpCiglvv/zUGuxEaIgrkJLDP
 ShmkZDMBlu+iqJ+F5Em21x9E37U6HcjXgxeGkQJc/QmrdXk1cOqQYZcvOqw0H2bBLjaY
 RHhA==
X-Gm-Message-State: AFuF++kvo8lwjWND9fW0+jDvEgk/ATmPoYdFkB+aSVAaiMGZAVCAMOZ1
 tYw1KX8fGyTpweP1Ej4BR4lQnCzuFTHgjn2RJiA1Ei/mQpY62D0L0mTp1Kt6K+lexSJFK1XRp3q
 pHSQp
X-Gm-Gg: AR+sD1042hFY4qRbstZfw42PqxsrUruCN8ok9oU+aOG6NjEcmTG3JO6rNJEMODFnaUH
 kIM0pBYhFz4STsBmTv8uxs/unXDMcR9c0atxMGyI37oAcTWbFwBbA68vMlRg3N0C+E79B0uLWOv
 Y4qYIjgFJOhmfawYRegtJqAsqA/dw5PPNF/1VlrSCNAs3tK5Z/RFF9NC/tjRyfBq6fkOzYdE9LW
 T8yefRxT1QbouCS3Q/k+6t1Mvt4rB9ij8woJ4FZ64QCox1SIsJu6S35aPo7FemUSBGYgB03+0ln
 XeOZK/d3wF4Gi7OfNCApllxjPKX8/TTBC0j9oGx5aWmHy9vJ3cGinBXeGtx5KcfBIPBe7IdAC6m
 q3nj90oFG3SstpJHv2Ui/DVXaJtL4g4LQCWm0jgMVVnIGJWKie4hFkFktAaXT0mL8kqFxyFru2/
 1X/vOJ/4w50Yy/6+R6y21gTB2W9aGWMAEomvvPVGtUQlHXOuycwug8pE1cug==
X-Received: by 2002:a05:6000:4619:b0:47f:5b52:5579 with SMTP id
 ffacd0b85a97d-482b1fe8a4bmr21190909f8f.18.1787220548147; 
 Thu, 20 Aug 2026 03:09:08 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:07 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 13/17] tests/qtest/ide-test: cover a rejected CHS
 translation in the stream
Date: Thu, 20 Aug 2026 12:08:40 +0200
Message-ID: <20260820100844.411717-14-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=den@openvz.org; helo=mail-wr1-x42b.google.com
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
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


