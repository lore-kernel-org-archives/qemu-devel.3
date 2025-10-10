Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF11ACCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7C1Q-00089H-V7; Fri, 10 Oct 2025 08:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7C1N-00088V-Ih
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:14:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7C1D-00049b-GF
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:14:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so19048485e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760098478; x=1760703278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=99QTQsT/X3kKgANc7QxAgqQpSYhzCiePxxa+8tWhc7g=;
 b=ykh42IFbNYLDUT4C1hYycJPhJ3pqbn3HwYjPyLQirDa+RizzaiUWFS38Q0dh0y3C/U
 aVd7JiHR80d8AAjQTf2szBJ5f4xVI2xN1h/bRVICWj3YTRBYE4tMPaLdz08QMZXbw+yJ
 +vvz/R5AglIwCrYdySZmxobLeoH3iyM46EyiPbG6Tz9msxmjkiXXdgrszphAROMsspi+
 o4qO8AJgoVvIqVF5YeXInNK4gOrBEHFEBDbeCpmSfmF0gAP7UEy2vWmNs18P+rtpwMMR
 hz/59Yq4IyfWCEmC8JoQ+FOJfeZBFGFtZo/8eTJP01f+4s/2UmjNwFKzn5kWAxZI1Y6t
 5WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760098478; x=1760703278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99QTQsT/X3kKgANc7QxAgqQpSYhzCiePxxa+8tWhc7g=;
 b=tCXUzS5YMgqrwHVS9A7aCqhg45xINuerIU8c4Sw2po3b8QKumWSHPWRlUsXmQttI6V
 q2CDIqCqrVtGLNk5nWJgYbey+thqDwgA7nj54b6NuCEIXtCu4L+VPwdSWMWnkZuPMBLh
 INQHhetgb9Kx9Bs5K72yfrcN6akU8tmWJ4DvNYjbAtKGgeoejY0P5V57I9y/vztdDgJ8
 ueU5eTD1zjXY3mMEI/68WDL4t2pcRM6FyBrNywsP9hvYZzbZxfIb4VDy5lNu0OstFc6X
 YK3exvQkRwYPh0EUQxFA7oUYBxNTfVsXeLyrgd32qtHm1FddHB7nezsUETj+aZPWltfM
 JnAQ==
X-Gm-Message-State: AOJu0YwrB5Uv6VKlsP5o7vHOkJj1TkIVyS77XREW1g+ypQb7TG1L3iUm
 F2hYfZ9gs4iUwXiPcTXHKHmqwKIRW5tY0zd+Mbzm/+CiIdB476x3VZ4SIbPvLJbAYxm9rFPivVm
 79Q9p
X-Gm-Gg: ASbGncvkN8wYYtHedTfXRd9x637CJ7YegpY3XpR5MjDuGH95eaxW15gpNfLedWq8qjp
 fdl08L3DaNpJHCPXSpDuDlcOiW4Gp6gG2jKXgKoYTEXCj0JvD7AqP5eOQgCe6chwSd3wq3GUFv1
 XCuGNvxEXBYGSN0cHxBtgYloUFsg7bNHuIb4sIfKVIFkwoIZHi7HK1tOP3GyTFD3hpj8Kwj3gq+
 WPTxj8cxOC7BAPzGjRr2pYsO7br9kxO4T7W0Nfyyy4+jZGm36f3yinRxH3s3hhB4/MS8pEvluP5
 61pb68c/FIu9Bey49gEwoQDF8tao4VJgG+5CIDFSz45+Um21MLSo1U5r0Woncxci6X9V63y/Lqb
 KXX+kpLMUdJ5e13UddpvqX6kjUzoxolOa5y7Y1zda21+Wah5KG2w=
X-Google-Smtp-Source: AGHT+IGJGkmfOqstO3NChPXxNbqrukNe7v6e+GPfHmcst2CPZjB6uxEHfz4wqqoYVuH/ojGTc8KGpw==
X-Received: by 2002:a05:600c:502c:b0:46e:45d3:82fa with SMTP id
 5b1f17b1804b1-46fa9aa0eacmr77684495e9.10.1760098477640; 
 Fri, 10 Oct 2025 05:14:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582b39sm3901637f8f.15.2025.10.10.05.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 05:14:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/tcg/multiarch/linux/linux-test: Don't try to test atime
 update
Date: Fri, 10 Oct 2025 13:14:35 +0100
Message-ID: <20251010121435.3885228-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The linux-test test includes an attempt to check the utime and stat
syscalls by setting the atime and mtime of a file to specific values,
and then calling stat() to check that the values read back correctly.

Unfortunately this is flaky, as it will fail if some other process
(for instance a virus scanner, backup program, etc) gets in and reads
the file between the utime() and stat() call, resulting in a host
syscall sequence like this:

utimensat(AT_FDCWD, "file2",
  [{tv_sec=1001, tv_nsec=0} /* 1970-01-01T01:16:41+0100 */,
   {tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */], 0) = 0
# successfully set atime to 1001 and mtime to 1000
statx(AT_FDCWD, "file2", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,
  STATX_BASIC_STATS,
  {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
   stx_blksize=4096, stx_attributes=0, stx_nlink=1, stx_uid=32808,
   stx_gid=32808, stx_mode=S_IFREG|0600, stx_ino=21659016,
   stx_size=100, stx_blocks=8,
   stx_attributes_mask=STATX_ATTR_COMPRESSED|STATX_ATTR_IMMUTABLE|
         STATX_ATTR_APPEND|STATX_ATTR_NODUMP|STATX_ATTR_ENCRYPTED|
         STATX_ATTR_AUTOMOUNT|STATX_ATTR_MOUNT_ROOT|STATX_ATTR_VERITY|
         STATX_ATTR_DAX,
   stx_atime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
   stx_ctime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
   stx_mtime={tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */,
   stx_rdev_major=0, stx_rdev_minor=0, stx_dev_major=252,
   stx_dev_minor=0, stx_mnt_id=0x1f}) = 0
# but when we statx the file, we get back an mtime of 1000
# but an atime corresponding to when the other process read it

and which will cause the test program to fail with the error
message "stat time".

In theory we could defend against this by e.g.  operating on files in
a dummy loopback mount filesystem which we mounted as 'noatime', but
this isn't worth the hassle.  Just drop the check on atime.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The failure happens to me occasionally on my local system.
---
 tests/tcg/multiarch/linux/linux-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index 64f57cb287e..bf6e0fda262 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -155,9 +155,14 @@ static void test_file(void)
         error("stat mode");
     if ((st.st_mode & 0777) != 0600)
         error("stat mode2");
-    if (st.st_atime != 1001 ||
-        st.st_mtime != 1000)
+    /*
+     * Only check mtime, not atime: other processes such as
+     * virus scanners might race with this test program and get
+     * in and update the atime, causing random failures.
+     */
+    if (st.st_mtime != 1000) {
         error("stat time");
+    }
 
     chk_error(stat(tmpdir, &st));
     if (!S_ISDIR(st.st_mode))
-- 
2.43.0


