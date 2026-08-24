Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2452C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawL-0000J6-9A; Mon, 24 Aug 2026 16:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawJ-0000Hu-Hq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:39 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawH-0004ZI-Od
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:39 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so4833528a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787601996; x=1788206796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RWsiP9NsoeO66PWmQGkUTLd4u+rLGEc2S9LNAYWuXiU=;
 b=SKAIArEQKJfI8pGkqpSnFJmNe5rWAPnSZ6zTcpw7tVTdlwUhZec+bIE6jo6zC4atwP
 yoEanGEJ3Ic8CCk3HqFJ7W6kdUGSHoHlXF0gP/yxwWtsQkmFixatbdD7XkOtMrnoqkMI
 dCkiq7TMxC3pkQrVDVctyF/bMaydD7TV5BgHDXOGqnsJWLvZ6VPAIJIpki4S6kQTfrYX
 xQIaC7d3JXB8AoHc+ztCPiG71vomASYa+WURLwpIz6a3lL7H5QuyWEUK2G2VVKXj6eLj
 BFiGdyKg8Ya48znIS/Vmu7PvxhtHA1KdIcvqQTWrboO+TPJQ/jr/Y4W5U38U8cfqieLz
 nglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601996; x=1788206796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RWsiP9NsoeO66PWmQGkUTLd4u+rLGEc2S9LNAYWuXiU=;
 b=mRPzTzmPMQFrACNDW1cuKKwmsj1RWoDqpestJTZRQG6TQG9F0H54mXaqd/qWN6rSC5
 tHEE+Hn9dF9gT+RL3SMEvrDjRRvai2SXb/J4/5cIzz1v6Z2Ag/CIUiYiSnMXVLYrK2fX
 ydQRm8p+DC/el9Mo0ZyZLczg8j4i11zq7tsW7gNhu7U6qsWhp2WlvFukN1YUYvL1TGVx
 ShrFXXPyQw981J3O0c8GepTsKvmC5OaRIfmWQykC4HakMy+51ElqFnHrEPNsXFbjgvfw
 w2UpyV9ynN4Ojuj5zXUgtNWT6kJEhFzIYfyAN0cBs13KN9jogmXPqGRzDBE5P9j3Hqf4
 NVNg==
X-Gm-Message-State: AFuF++mUuk2c7X9lbMQv4uzTS5bnK1UkT9P9Rt1gHWuyEY2EFdMSUz7T
 GmMs6M9lQPzOq3Dm6WyWJ5N+ulekG5/a00z96S7yYQIyyjULo/wpFI/0TMIwbjJgInAMPvcMJRt
 8tMGk
X-Gm-Gg: AR+sD11lRHMeYYxFZFn9NZ1Gdg4KcKmO87S4yYLDmUbr96yncY19fh61g1shY0MTtJb
 tMbH03nyRbX/BZzZBMZO85CNnG33My04Ym4ykqKPlMq6gp3b7R9ZCAXxV4EyM79ewV7iKZFHLBy
 55QxWnYSrjjtG4z0LlKeVgAfxLZmsGtl0HdfIvCjrfhqlh/2HBdcC4A/CRQ38hCjN84yTbb+tm9
 zQRHZ1YGj/DAHgk9CsxTtAMKHOV108yB3NDlaQoIUxV3i+zEGKyqdeAXYgZqVRAfDfLcEYjDac4
 CcMklBAaFU2Q17W55GsfVGoUD5LA28ZgRULprg4mxeNRQh0hdyJBgtJq3fszZknvPLa8NpoBY9R
 wrVzHQ9XXxETakz54FX/Uopa9rZpoIBXojjNovI6bq7XbqLLBnX0TmYYwlArgdP96SgQJwBiMgV
 0d6owN4oBAnUwtWXJmvePTUIv98e9bhkydAjNiGojwfcnMj+8BKrO0eR7hwIUJxZKbC+Pc
X-Received: by 2002:a05:6402:21d4:b0:69a:928:9405 with SMTP id
 4fb4d7f45d1cf-6a582af8853mr20292897a12.1.1787601996276; 
 Mon, 24 Aug 2026 13:06:36 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:35 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/7] tests/qtest/ahci-test: skip when the scratch files cannot
 be created
Date: Mon, 24 Aug 2026 22:06:23 +0200
Message-ID: <20260824200627.2180635-4-den@openvz.org>
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

The fallback ahci-test takes when QTEST_QEMU_IMG is unset extends a
raw image to 64 MiB with ftruncate() and asserts it worked, which is
the assert ide-test just lost. The temporary files are asserted on
too, and a file system with no room left fails g_mkstemp() and
g_file_open_tmp() as surely as the ftruncate().

Report the reason and register no tests instead. The cleanup path has
to cope with the files now created after the point of no return.

Cc: Fabiano Rosas <farosas@suse.de>
Cc: John Snow <jsnow@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 48 +++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 71d23fe56a..d6af5b30a0 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -2110,8 +2110,10 @@ static void create_ahci_io_test(enum IOMode type, enum AddrMode addr,
 
 int main(int argc, char **argv)
 {
+    g_autoptr(GError) error = NULL;
     const char *arch, *base;
     int ret;
+    int err;
     int fd;
     int c;
     int i, j, k, m;
@@ -2164,30 +2166,49 @@ int main(int argc, char **argv)
     /* Create a temporary image */
     tmp_path = g_strdup_printf("%s/qtest.XXXXXX", base);
     fd = g_mkstemp(tmp_path);
-    g_assert(fd >= 0);
+    if (fd < 0) {
+        g_test_message("Could not create %s: %s", tmp_path, strerror(errno));
+        goto test_add_done;
+    }
     if (have_qemu_img()) {
         imgfmt = "qcow2";
         test_image_size_mb = TEST_IMAGE_SIZE_MB_LARGE;
-        mkqcow2(tmp_path, TEST_IMAGE_SIZE_MB_LARGE);
+        close(fd);
+        if (!mkqcow2(tmp_path, TEST_IMAGE_SIZE_MB_LARGE)) {
+            g_test_message("Could not create %s with qemu-img", tmp_path);
+            goto test_add_done;
+        }
     } else {
         g_test_message("QTEST_QEMU_IMG not set or qemu-img missing; "
                        "skipping LBA48 high-sector tests");
         imgfmt = "raw";
         test_image_size_mb = TEST_IMAGE_SIZE_MB_SMALL;
         ret = ftruncate(fd, test_image_size_mb * 1024 * 1024);
-        g_assert(ret == 0);
+        err = errno;
+        close(fd);
+        if (ret < 0) {
+            g_test_message("Could not size %s: %s", tmp_path, strerror(err));
+            goto test_add_done;
+        }
     }
-    close(fd);
 
     /* Create temporary blkdebug instructions */
     debug_path = g_strdup_printf("%s/qtest-blkdebug.XXXXXX", base);
     fd = g_mkstemp(debug_path);
-    g_assert(fd >= 0);
+    if (fd < 0) {
+        g_test_message("Could not create %s: %s", debug_path,
+                       strerror(errno));
+        goto test_add_done;
+    }
     close(fd);
 
     /* Reserve a hollow file to use as a socket for migration tests */
-    fd = g_file_open_tmp("qtest-migration.XXXXXX", &mig_socket, NULL);
-    g_assert(fd >= 0);
+    fd = g_file_open_tmp("qtest-migration.XXXXXX", &mig_socket, &error);
+    if (fd < 0) {
+        g_test_message("Could not create a temporary file: %s",
+                       error->message);
+        goto test_add_done;
+    }
     close(fd);
 
     /* Run the tests */
@@ -2244,15 +2265,20 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/cdrom/drain/pio", test_atapi_drain_pio);
     qtest_add_func("/ahci/cdrom/drain/dma", test_atapi_drain_dma);
 
+test_add_done:
     ret = g_test_run();
 
     /* Cleanup */
     unlink(tmp_path);
     g_free(tmp_path);
-    unlink(debug_path);
-    g_free(debug_path);
-    unlink(mig_socket);
-    g_free(mig_socket);
+    if (debug_path) {
+        unlink(debug_path);
+        g_free(debug_path);
+    }
+    if (mig_socket) {
+        unlink(mig_socket);
+        g_free(mig_socket);
+    }
 
     return ret;
 }
-- 
2.53.0


