Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE009CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdMA-0006vY-OC; Fri, 21 Nov 2025 21:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdM6-0006pQ-LZ; Fri, 21 Nov 2025 21:28:06 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdLD-0006XF-F7; Fri, 21 Nov 2025 21:28:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A25FE16C6DA;
 Fri, 21 Nov 2025 16:51:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0357D321951;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 02/76] tests/tcg/multiarch/linux/linux-test: Don't try
 to test atime update
Date: Fri, 21 Nov 2025 16:50:40 +0300
Message-ID: <20251121135201.1114964-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251016150357.876415-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 77dc9d662f80b9f4eb450df27f60a0a9b3c97785)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index 64f57cb287..bf6e0fda26 100644
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
2.47.3


