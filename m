Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B33E65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfhK-0006DQ-BE; Sun, 01 Feb 2026 17:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfhG-0006Cs-TU
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:13:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfhE-0005Cl-Pf
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:13:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso34397825e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769984010; x=1770588810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i2muGDusqrWiBIG6l++L1ff+SQpmgD2b8FN8pciW0VA=;
 b=A3ObdL1mz/v3P4pZZH7d9LcVus7FTgms3DXQ+0mkadYkGhyddst7n6nEtFiF6KwmQ8
 u9mGGfDAVT6sbdmbp940lONVZU3tnMT3QF20/UGSRdAivWTY7OiO1eGdIhng3Kx10Puk
 dRPHYi5fO7PS9qoUfGpwLy1UB8IA18jNN9Xy17ZFNlHnarXhmxl+pflrOTJG8rffSbZX
 PGYqOnnPC23TnqdTntvp+PXszGaAtRsrOAXL0kch7xqCgKJ6zr1eHRlpFevijI3ls/bm
 qYgizbZN5IBwxSC7BAKe2yluNj219wJnVz4tXHPv0AcFPsSz9A9XQTBeeW1g/m7ZB+tV
 T2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769984010; x=1770588810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2muGDusqrWiBIG6l++L1ff+SQpmgD2b8FN8pciW0VA=;
 b=TVFuw0VeiCOvXi7rCDThG6Z2wcKURO3AYNrV+kl6lx0zjcxQiLShu1d6r29VnEh2aw
 9eVYDiU8T/E8fWQVkklzhOlae9G/HtBgFn8eKLOkVu3ZfHSrxETBc1eGetGmWcPF+3bS
 Nswe1/ZMkz3QrZk1XIayzeE/AQ4UliK/IC1xu5sfdvlWygUFKbeozEauxwdE7PCmqe9l
 EKGODiOyZMmxbSW0KBPs1x46h8Z/ET882qido2nXmpgrZa38B3wftsgDWJjuNHKbtyFk
 TsX+z4RCSiquUaAGhnNXnLcsFDzIlo3ujIjvvN7GGfw3eheDyHR5xnfaOCQEbDQ38CR0
 G0sg==
X-Gm-Message-State: AOJu0YwnUmodwFPmvFQyyq+8Dil9T11PgXi5FHhVFXD8qt5ZhF8+tf/n
 F6fclDBIZ17fcLgp0l3kMotZjvxZmcpjNsyahVBubR9ocNLSAyl7yPjSB35HTG7M9WIrPEYaH+I
 Jf1rLiM4=
X-Gm-Gg: AZuq6aLYLpk/PGZ2OcQsnZSNijlAhQRpR6lBUlsRFeOEaZZXFwFwZLsDGEgxbr2a6RJ
 lzgfSoKve6zIVvUjoqilBOqgm9Z2YvTOWAap0WjAznK56VolJpxHI4Q1i0b0JsJB21jnhdzKEkH
 prf1jA2xqhg1WvsS37+ii/lw6KsCMjQKZ4zrR6U8jjtgLxaN7r1kW8CmcPnS9M+LCYzi2M3SIcD
 CoFrXkZeJ9nu1TApAalHgMGgktuihPHrVbR4WYByCoL6qxhn5vA789INTqMcxqZXI+bX+E/5P+e
 R5MlqtGmCUr1kIDszHP8Bb234abhTSt61MFBHfXm3NoPezeYvpAt4leHyDXWQ57mDMnaX7ali7H
 NPFw5LQg2RxCZqrWwHpdZ4CeuCd85iN2QJT/GFUvG5XEr1rABx0x0+reAUqa10ZHMs/hzJLF9S7
 LZI1Pjgzm5Agqmv5oiifVg3DdmbI6PLGD0Gf588HPwx+0bD5dme2iPLSgtlMmKLkqZ0zuSx14=
X-Received: by 2002:a05:600c:a00e:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-482db481bffmr132247215e9.17.1769984010535; 
 Sun, 01 Feb 2026 14:13:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56068sm342289455e9.13.2026.02.01.14.13.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 14:13:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6] tests/unit: add unit test for qemu_hexdump()
Date: Sun,  1 Feb 2026 23:13:28 +0100
Message-ID: <20260201221328.72111-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Test that the fix in commit 20aa05edc2c ("util/hexdump: fix
QEMU_HEXDUMP_LINE_WIDTH logic") make sense.

To not break compilation when we build without 'block', move
hexdump.c out of "if have_block" in meson.build.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v6:
- mention commit 20aa05edc2c in desc
- wrap long lines for checkpatch.pl
- use g_file_open_tmp()
---
 tests/unit/test-cutils.c | 67 ++++++++++++++++++++++++++++++++++++++++
 util/meson.build         |  2 +-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 75fae29003a..d70218ad1c1 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3626,6 +3626,68 @@ static void test_si_prefix(void)
     g_assert_cmpstr(si_prefix(18), ==, "E");
 }
 
+static void test_qemu_hexdump_alignment(void)
+{
+    /*
+     * Test that ASCII part is properly aligned for incomplete lines.
+     * This test catches the bug that was fixed in previous commit
+     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
+     *
+     * We use data that is not aligned to 16 bytes, so last line
+     * is incomplete.
+     */
+    static const uint8_t data[] = {
+        /* First line: 16 bytes */
+        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
+        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
+        /* Second line: 5 bytes (incomplete) */
+        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
+    };
+    char *fname = NULL;
+    int fd;
+    g_autofree char *output = NULL;
+    size_t size, bytes_read;
+    FILE *f;
+
+    fd = g_file_open_tmp("test-qemu-hexdump-alignment-XXXXXX", &fname, NULL);
+    g_assert(fd >= 0);
+    g_assert_nonnull(fname);
+    f = fdopen(fd, "w+");
+
+    g_assert_nonnull(f);
+
+    qemu_hexdump(f, "test", data, sizeof(data));
+
+    size = ftell(f);
+    fseek(f, 0, SEEK_SET);
+
+    output = g_malloc(size + 1);
+    bytes_read = 0;
+    while (bytes_read < size) {
+        size_t chunk = fread(output + bytes_read, 1, size - bytes_read, f);
+        if (chunk == 0) {
+            break;
+        }
+        bytes_read += chunk;
+    }
+    g_assert_cmpuint(bytes_read, ==, size);
+    output[size] = '\0';
+
+    fclose(f);
+    close(fd);
+    unlink(fname);
+    g_free(fname);
+
+    /* We expect proper alignment of "s is" part on the second line */
+    static const char *expected =
+        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   "
+            "Hello World! Thi\n"
+        "test: 0010: 73 20 69 73  20                                      "
+            "s is \n";
+
+    g_assert_cmpstr(output, ==, expected);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -3995,5 +4057,10 @@ int main(int argc, char **argv)
                     test_iec_binary_prefix);
     g_test_add_func("/cutils/si_prefix",
                     test_si_prefix);
+
+    /* qemu_hexdump() test */
+    g_test_add_func("/cutils/qemu_hexdump/alignment",
+                    test_qemu_hexdump_alignment);
+
     return g_test_run();
 }
diff --git a/util/meson.build b/util/meson.build
index a0cfdc30ba6..7c9445615d7 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -33,6 +33,7 @@ endif
 util_ss.add(files('defer-call.c'))
 util_ss.add(files('envlist.c', 'path.c', 'module.c'))
 util_ss.add(files('event.c'))
+util_ss.add(files('hexdump.c'))
 util_ss.add(files('host-utils.c'))
 util_ss.add(files('bitmap.c', 'bitops.c'))
 util_ss.add(files('fifo8.c'))
@@ -90,7 +91,6 @@ if have_block
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-  util_ss.add(files('hexdump.c'))
   util_ss.add(files('iova-tree.c'))
   util_ss.add(files('iov.c'))
   util_ss.add(files('nvdimm-utils.c'))
-- 
2.52.0


