Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF52C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAi-0004sC-6Y; Tue, 20 Aug 2024 10:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAg-0004qu-8z
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAe-0006Kt-JW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so47468635e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165354; x=1724770154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5Xnpwm/2BcL3d4m231YwlBL4X22xMDqaWfh+yoj+U0=;
 b=slTLsnkTkCH0hIHiqg9xzNB2Oiq9Y4FmDW1LbZ7vnugW58LbnY0qOZBmKbgKUMFIb8
 fE6JT1Vme48Ko67zcoIVoosvY0l0Zwr/5yMjGhXQO1wkXvz5Cr5cHsaebB71femvVHoE
 DA0zxdKpshgb7PpYWOrVBO0nyIs4Jdi0qVTpRcDpB1FCChlv3Zw6/fMXDPLCXrDDE1La
 cY1tX5yewjQel6K/44b2OPP7Mgh5T2WKRhRFDYJwgG9MEpCBpdpiepxe4jVEQ7mBYWTE
 vaKlj6Iu1Z0MUHDLGc9OrEhJ5N4kNKoif+6XufRaqPLjFYiExI8deGLlot+UeSQZLxxU
 tbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165354; x=1724770154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5Xnpwm/2BcL3d4m231YwlBL4X22xMDqaWfh+yoj+U0=;
 b=nTBepKbQ1AxjXPXnhINkQhZTxpsXDDY5Ry6q9SG5182P7qGCmnGLQYG8H41HSnylXQ
 uZ4cC8xVHxBCt8L4CITbECTERmYK1462LGERJE44japueSP1NJqCb6cAgAydSIayHjNQ
 HbeGudYMJ3DT+SYLstPp2qgAm3akwtfTOliGN6M0ep2/x2s6KubjqIYQQUVraRw0mOAO
 fNQzDOPpfPjBz6F32sxZPUQiq77cZ1p15aN9YoEHvTo8ELxIbaoAjNOsAJ/f0Iw+gcez
 ukgigt3QBIN6/lw3SWfZgSlrUMPxdT7NKEoZVQv4l50Rhb0eMIK81r37J0i8Ctrs4X8P
 bJ8g==
X-Gm-Message-State: AOJu0Yz85c4EVCUQAVKExSaq6HtcK+5C6EUjzBnU7bVixq2d6I3G2BUH
 AQJVQMQ868oBWENd+cWJ0qyBIQLRq8R3k7zG+a6NAlOcI+sCIyDEW7duOtACgBfNSJl41PHfPs5
 Q
X-Google-Smtp-Source: AGHT+IHkvYzRz0RzdI3KyfVGbO0HJTwceWyNwtenMvo+lUyHBppZj99TqUV0cFOZMxiHeaGUSvdIlw==
X-Received: by 2002:a5d:608c:0:b0:371:7e1b:871b with SMTP id
 ffacd0b85a97d-371c5fd0571mr1356984f8f.29.1724165354491; 
 Tue, 20 Aug 2024 07:49:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 1/9] tests/qtest/migration-test: Fix bootfile cleanup
 handling
Date: Tue, 20 Aug 2024 15:49:04 +0100
Message-Id: <20240820144912.320744-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If you invoke the migration-test binary in such a way that it doesn't run
any tests, then we never call bootfile_create(), and at the end of
main() bootfile_delete() will try to unlink(NULL), which is not valid.
This can happen if for instance you tell the test binary to run a
subset of tests that turns out to be empty, like this:

 (cd build/asan && QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --tap -k -p bang)
 # random seed: R02S6501b289ff8ced4231ba452c3a87bc6f
 # Skipping test: userfaultfd not available
 1..0
 ../../tests/qtest/migration-test.c:182:12: runtime error: null pointer passed as argument 1, which is declared to never be null
 /usr/include/unistd.h:858:48: note: nonnull attribute specified here

Conversely, because we call bootfile_create() once per test
but only call bootfile_delete() at the end of the whole test
run, we will leak the memory we used for bootpath when we
overwrite it.

Handle these by:
 * making bootfile_delete() handle not needing to do anything
   because bootfile_create() was never called
 * making bootfile_create() call bootfile_delete() first to
   tidy up any previous bootfile before it creates a fresh one

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I spotted this because I was trying to run a single subtest and
messed up the test name so it didn't match anything :-)
The second part was noticed by LeakSanitizer.
---
 tests/qtest/migration-test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b8886..5cf238a4f05 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -144,12 +144,23 @@ static char *bootpath;
 #include "tests/migration/ppc64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
+static void bootfile_delete(void)
+{
+    if (!bootpath) {
+        return;
+    }
+    unlink(bootpath);
+    g_free(bootpath);
+    bootpath = NULL;
+}
+
 static void bootfile_create(char *dir, bool suspend_me)
 {
     const char *arch = qtest_get_arch();
     unsigned char *content;
     size_t len;
 
+    bootfile_delete();
     bootpath = g_strdup_printf("%s/bootsect", dir);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -177,13 +188,6 @@ static void bootfile_create(char *dir, bool suspend_me)
     fclose(bootfile);
 }
 
-static void bootfile_delete(void)
-{
-    unlink(bootpath);
-    g_free(bootpath);
-    bootpath = NULL;
-}
-
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
-- 
2.34.1


