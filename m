Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37551C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfJ-0004Lo-MR; Wed, 26 Aug 2026 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfD-0004Gq-Or
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:28 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBf9-0005ef-LO
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so1543566a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743162; x=1788347962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nkj2k6nchMuIJVjh47utAhxnpSusPJpE2MYttsvWBKI=;
 b=bAyNB5f1XfOY7MQUVR+2K24ckb/q0rcLYrDy6MmBuZtBbewL0itpJC8vHRPEwiLtcG
 aayrxfNftfLWdeDbFVe3qaghlx6LsUNWegEAPtkCOK+w29ThGyfIuBnkjzNRintGkF+J
 XMPHK8yUlddXEXcBgYUO5y3iCZSiyboyfXDso8Z6qQFtH3kyCKNENUEf1mfbmIZp5hWK
 QXGA+Lv4jxXegNS4KUrDuERnr3lYc1wJ6ruwUUxmJssQOISW9R2PS9fV1Tb54cp8Sj+v
 DGxropSDqMx8pW1JpamMMtpGeaYYRCPBq3+9ApogNU2Y03fonpBA0hMAgcxug6ZOSpvn
 +4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743162; x=1788347962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nkj2k6nchMuIJVjh47utAhxnpSusPJpE2MYttsvWBKI=;
 b=Crn2ibsVMbWFW2WXcVHcPEsmdMoTMLGXrHFXAT/rBmtkv8oexNKuzMmMIFl0UgSHHF
 Fvmd6vqa6KQ0wZpWhhmqgfFaC38+dfZ6OdS3feLA0J/+pssT272/fsfisAZVu0//titO
 7JpQnv7kfKxn6H1s+Tainq/lgBmvBh4JGG5FpzU06WHKMFqRO86G8alZqmI7BSVOluKl
 Tj4b39XHLuJOjU8BtKri7MHyXQpZwbUyrqsfN3cKwguURj0phmpL0I0riZX5Abrggnwk
 1gcAP4Io+5o2MaygsRdawGGXdrQbLFVAADa49ewiIGM+dLeddC7+ps+yKKmgZI+pG+VN
 PWaQ==
X-Gm-Message-State: AFuF++lP9rjFOSvs0QMKp1cYb0uiIPz1LPw8QEG0JNfrNin6rwPG++VY
 EF/zqcbPrjKj5WtF6UYd661s6NZzVPS1qVDR1PmhYPt29njlGsnVQI5xyPzxvJsvSS1F+4Or61i
 YAjV8
X-Gm-Gg: AR+sD116i1DkcDA2JJapnlyCnpwav/OQEGfTkC3riYNMXpQ9uymeamJ/2oBcn2WJ2cE
 Z+p9+wkU67Up/M/rFGOpXkwoAdOOwBZgcriKjT92jb/rkCyyyIMi3c1QbmRwn6Gbk1SncRkzj6T
 fLv2YnsDZ0+KXKJf/DVL216fnaaXSi9VoMnm/pIe+q0htz+GRSuYiuEBgZKuv4aE6DztlT5JxEZ
 B9DLB/aRqc6wNYzzVAElNHSlg8rKIovboY+8TdF6az+3qIVMuRs4rb15IfNyEOnPeUok1SxFhTD
 ql6dQqIhA6xS8pt1nb0JpCDq8m6s+4kETmjjxBRg+X6hrnGZRH9DS8el8dm+68hPapEgxowI94f
 dB2gY3pzP0o0p82+bjzuk6Tul4geWQubO+89V5tA4mpazResJOomLBDPOT/d4f1OAHRgpfOsdRU
 iM0b3imsiNDOAUJBEAv2dGl+4U8912CZHSysNpva9vQLvEQgCa
X-Received: by 2002:a05:6402:21db:b0:69c:76c6:9bef with SMTP id
 4fb4d7f45d1cf-6a5df63428amr7785954a12.10.1787743162072; 
 Wed, 26 Aug 2026 04:19:22 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:21 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 13/28] tests/qtest/ide-test: cover a rejected CHS translation
 in the stream
Date: Wed, 26 Aug 2026 13:19:00 +0200
Message-ID: <20260826111915.3387926-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=den@openvz.org; helo=mail-ed1-x531.google.com
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


