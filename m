Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5970AC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawK-0000Ix-Go; Mon, 24 Aug 2026 16:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawI-0000HP-9G
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawG-0004Yy-MN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso6711392a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787601995; x=1788206795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uogh8hf2r9Tq7ainZGJPB/le1S4UMkn5pbnOVL2Yy30=;
 b=TPFUEVbwep3OijFxFcr4resZdkFEbPMnhfOr2OSw1qTBHeCzxaSNgJpeBDmL48ahuc
 DbD+6eVDSzbAyaLI9anRMUvk6s6/lBCw25X1ZQ55shQmDwk8HX9+BWAHGHGnONVYkDc6
 QnF5vzH2OO/BPU519RICthKDUlsvjbZYt6YaLHK6mDijLqG7pRye98ps8Tdht9R4ZiPA
 BtNDwYbX35ayGeNYRKm8fk4T/yypk5juLUvJjScm0/mzyC77WjGR1abyhhwpNzh7bQJp
 EqOHONnjKQgZWTZrvatfLkAol3zI7LcdrKhla5aY8Mz4fQU0EEoBa5SH8Ax7jMdRnNJ5
 ViGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601995; x=1788206795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uogh8hf2r9Tq7ainZGJPB/le1S4UMkn5pbnOVL2Yy30=;
 b=KyAwvk5BG6rZh8zKsx3MMfj8Sv+g+ibu6FtHIz3WkqYf6VyMlaqFJf8F18kvuW7Gi3
 XBpTvcBcI6aZAMoEfHV/H5W5DNF2n2ty2z3+gtaWOkqcwMpq2YEbUDp94HPy5/GmcstR
 SFmQiBsr8kfquc6Gc3/2k3Hfi8uSbJuh0pbm4UvElRTtbWoH/RR5Q6yoSCoQRIxr9XI2
 Qsl+F25bUITWcl/dtQIAyW4mMeRlYvtzta58QdN3khCH34I5reBcIccLPeaJEJLdrUfA
 HX90WBjDrpks/WXU+5Umm8gCZFfAnCOu0yTU/T3XgMQ1lYlQivqoiYUEdTHECHLHc1Jv
 0nKQ==
X-Gm-Message-State: AFuF++lSp4PRdYSTql1u/H+jklscCYTksfGi9C+vgt699pwHvE9e7Mav
 O532bm3PJREIdWeiMRUQXMYbaJnZyhsDXA4zauQK2t8bbrYU2uiB/2X7VrEzRi9YlCSlLaD/gPB
 EBTnT
X-Gm-Gg: AR+sD136zw8knqRwf1fmi/06yU7cD0FxNNG6TTX4SxpktReae/nETeRtsOhRyrGdJVO
 n6t7R6AoUKL9pLxgp30EedoV+LfTTvkVx6mLgLoQa6+V9olinxIIbNZ3pG8+AuZ/zByCNHdhopf
 wdHP4JB9KdSDmjttRxNcJsVXr57/8XGKaGoopsVPj2PD1zEmSJlQpzETjHn8l5YadxXV1PmQjqW
 SyAuny9T6ywwjQU9qRxFGcVEmp9QYY2apPMPzkJFlxI4l1/Ni23SyJYxG2BN351k2KnW9MTNtnR
 wKjwY4Zf6ks0u3WB1svNEvBH5uIqo7cTuyARdNCa8Jxp4SRjQEf8XwoSlRH7gIcMiDD+X9r0CrX
 BxlPOfDAhf8oDyDRUBnr1OvBStu1jWEnVmc9FDTfgwpYvj9dGG2wU+kgIV3D07DX4/MQ0hrla6S
 C5yEdHEKb6bxS9xrZubEmBVCCfWX7NeCgpM/GF3SD28eT8QmA6GxWnCxFsoA==
X-Received: by 2002:a05:6402:1f0d:b0:6a1:bff4:645d with SMTP id
 4fb4d7f45d1cf-6a5c409f22cmr1016451a12.2.1787601995096; 
 Mon, 24 Aug 2026 13:06:35 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/7] tests/qtest/ide-test: skip when the scratch files cannot
 be created
Date: Mon, 24 Aug 2026 22:06:22 +0200
Message-ID: <20260824200627.2180635-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=den@openvz.org; helo=mail-ed1-x531.google.com
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

main() creates a blkdebug script and two 64 MiB images and asserts
that every step worked. The images are sparse, which is free on Linux
but not everywhere: NetBSD mounts /tmp as a tmpfs sized at 25% of RAM
and charges a file its full length the moment it is extended, so the
ftruncate() returns ENOSPC and the binary dies before a test has run:

  ERROR:../src/tests/qtest/ide-test.c:1260:main: assertion failed:
  (ret == 0)

A file system with no room left fails the g_mkstemp() calls too, the
blkdebug script first of all.

Skip instead, as hd-geo-test does since commit a0d6d7454a
("tests/hd-geo-test: Skip test when images can not be created"): move
g_test_init() ahead of the setup, report the errno and register no
tests. The cleanup loop has to cope with a path never filled in.

Cc: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index b36b0f8875..805afb9461 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1231,6 +1231,7 @@ int main(int argc, char **argv)
     int i;
     int fd;
     int ret;
+    int err;
 
     /*
      * "base" stores the starting point where we create temporary files.
@@ -1245,25 +1246,37 @@ int main(int argc, char **argv)
     base = ".";
 #endif
 
+    g_test_init(&argc, &argv, NULL);
+
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
 
     /* Create a temporary raw image */
     for (i = 0; i < 2; ++i) {
         tmp_path[i] = g_strdup_printf("%s/qtest.XXXXXX", base);
         fd = g_mkstemp(tmp_path[i]);
-        g_assert(fd >= 0);
+        if (fd < 0) {
+            g_test_message("Could not create %s: %s", tmp_path[i],
+                           strerror(errno));
+            goto test_add_done;
+        }
         ret = ftruncate(fd, TEST_IMAGE_SIZE);
-        g_assert(ret == 0);
+        err = errno;
         close(fd);
+        if (ret < 0) {
+            g_test_message("Could not size %s: %s", tmp_path[i],
+                           strerror(err));
+            goto test_add_done;
+        }
     }
 
-    /* Run the tests */
-    g_test_init(&argc, &argv, NULL);
-
     qtest_add_func("/ide/read_native", test_specify);
 
     qtest_add_func("/ide/identify", test_identify);
@@ -1288,10 +1301,14 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio_raw", test_cdrom_pio_raw);
     qtest_add_func("/ide/cdrom/dma_raw", test_cdrom_dma_raw);
 
+test_add_done:
     ret = g_test_run();
 
     /* Cleanup */
     for (i = 0; i < 2; ++i) {
+        if (!tmp_path[i]) {
+            continue;
+        }
         unlink(tmp_path[i]);
         g_free(tmp_path[i]);
     }
-- 
2.53.0


