Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC2103E17A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rT7-0002sU-Qj; Wed, 18 Mar 2026 10:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rT5-0002sE-FW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:52 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rT3-0005oH-IS
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773842510; x=1805378510;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JuzEqzQ9/Twxxz2HhTp1rJeEyxn7vmJTdJXw53AO258=;
 b=DjWCpRFbDMFTbQbB+lligdfxLDCH9EaZWFSVuduzpT+Ec2bO8RisrRU7
 FLuLlEEf6OvfVJ1iRzaH4yhYXu33v6+wHMIAMeHW7tUjYrOx6b4VwlUOA
 aIsUEcPbTJoHXVnp5GImA5axjmZ5BDck26jOG7cXzkpuN7ML1ZKiKLPXB
 5CrHIwpChgGE0YjyNQMH2Tc5b3u7A7Aw0cfAEzuO9oRCmlmozO3Pr5l+e
 ZWFNW2DDw2kint+0LgKhIczI3B5ka0RIudC3jNfcHU6aTX4cbl6QLae69
 8QLTbn8m6rMXWbCgJeIor7pIXUdk6do90IVoYa5qSa93h665wkWgHuPnG w==;
X-CSE-ConnectionGUID: wLB16NDXQHCShp62k8410Q==
X-CSE-MsgGUID: Bce6eUlVR8CILliYCbVkcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74925805"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74925805"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:49 -0700
X-CSE-ConnectionGUID: sEtlEFF8T4yTnDIJK8sh8A==
X-CSE-MsgGUID: 3HHZG44bQYuARUvykB1X3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218205246"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:47 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 junjie.cao@intel.com
Subject: [PATCH v2 3/3] tests/unit: add pread_all and preadv_all tests for io
 channel file
Date: Wed, 18 Mar 2026 22:01:13 +0800
Message-ID: <20260318140113.434-4-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260318140113.434-1-junjie.cao@intel.com>
References: <20260318140113.434-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Add five targeted test cases for the new qio_channel_pread{v,}_all()
and preadv_all_eof() helpers introduced earlier in this series:

  preadv_all:          read from a non-zero offset into two iovecs
  pread_all:           single-buffer wrapper smoke test
  preadv_all_eof/clean:   clean EOF (offset == file length) returns 0
  preadv_all_eof/partial: partial data then EOF returns -1
  preadv_all/eof-is-error: strict wrapper turns clean EOF into -1

All tests create a 16-byte file with known content and exercise the
read helpers against it, verifying return values, error state, and
(where applicable) buffer contents.  The tests are guarded by
CONFIG_PREADV since the underlying preadv support is optional.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/unit/test-io-channel-file.c | 137 ++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tests/unit/test-io-channel-file.c b/tests/unit/test-io-channel-file.c
index 1977006ce9..97a2a5b5cb 100644
--- a/tests/unit/test-io-channel-file.c
+++ b/tests/unit/test-io-channel-file.c
@@ -102,6 +102,131 @@ static void test_io_channel_fd(void)
 }
 
 
+#ifdef CONFIG_PREADV
+#define TEST_PREAD_FILE "tests/test-io-channel-pread.txt"
+#define TEST_PREAD_PATTERN "ABCDEFGHIJKLMNOP"  /* 16 bytes */
+#define TEST_PREAD_LEN 16
+
+static QIOChannel *create_pread_test_file(void)
+{
+    int fd;
+
+    fd = open(TEST_PREAD_FILE, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(write(fd, TEST_PREAD_PATTERN, TEST_PREAD_LEN),
+                    ==, TEST_PREAD_LEN);
+    close(fd);
+
+    return QIO_CHANNEL(qio_channel_file_new_path(
+                           TEST_PREAD_FILE, O_RDONLY, 0,
+                           &error_abort));
+}
+
+static void test_io_channel_preadv_all(void)
+{
+    QIOChannel *ioc;
+    char buf1[4], buf2[4];
+    struct iovec iov[2] = {
+        { .iov_base = buf1, .iov_len = sizeof(buf1) },
+        { .iov_base = buf2, .iov_len = sizeof(buf2) },
+    };
+    int ret;
+
+    ioc = create_pread_test_file();
+
+    /* Read 8 bytes from offset 4 into two iovecs: "EFGH" + "IJKL" */
+    ret = qio_channel_preadv_all(ioc, iov, 2, 4, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpmem(buf1, 4, "EFGH", 4);
+    g_assert_cmpmem(buf2, 4, "IJKL", 4);
+
+    unlink(TEST_PREAD_FILE);
+    object_unref(OBJECT(ioc));
+}
+
+static void test_io_channel_pread_all(void)
+{
+    QIOChannel *ioc;
+    char buf[8];
+    int ret;
+
+    ioc = create_pread_test_file();
+
+    /* Read 8 bytes from offset 8: "IJKLMNOP" */
+    ret = qio_channel_pread_all(ioc, buf, sizeof(buf), 8, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpmem(buf, 8, "IJKLMNOP", 8);
+
+    unlink(TEST_PREAD_FILE);
+    object_unref(OBJECT(ioc));
+}
+
+static void test_io_channel_preadv_all_eof_clean(void)
+{
+    QIOChannel *ioc;
+    Error *err = NULL;
+    char buf[8];
+    struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
+    int ret;
+
+    ioc = create_pread_test_file();
+
+    /* Read from offset == file length: clean EOF, expect 0 and no error */
+    ret = qio_channel_preadv_all_eof(ioc, &iov, 1, TEST_PREAD_LEN, &err);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_null(err);
+
+    unlink(TEST_PREAD_FILE);
+    object_unref(OBJECT(ioc));
+}
+
+static void test_io_channel_preadv_all_eof_partial(void)
+{
+    QIOChannel *ioc;
+    Error *err = NULL;
+    char buf[8];
+    struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
+    int ret;
+
+    ioc = create_pread_test_file();
+
+    /*
+     * Read 8 bytes from offset 12: only 4 bytes available before EOF.
+     * Expect -1 (partial data then EOF is an error) and err set.
+     */
+    ret = qio_channel_preadv_all_eof(ioc, &iov, 1, 12, &err);
+    g_assert_cmpint(ret, ==, -1);
+    g_assert_nonnull(err);
+    error_free(err);
+
+    unlink(TEST_PREAD_FILE);
+    object_unref(OBJECT(ioc));
+}
+
+static void test_io_channel_preadv_all_eof_is_error(void)
+{
+    QIOChannel *ioc;
+    Error *err = NULL;
+    char buf[8];
+    struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
+    int ret;
+
+    ioc = create_pread_test_file();
+
+    /*
+     * Clean EOF through the strict wrapper: should be translated to -1.
+     */
+    ret = qio_channel_preadv_all(ioc, &iov, 1, TEST_PREAD_LEN, &err);
+    g_assert_cmpint(ret, ==, -1);
+    g_assert_nonnull(err);
+    error_free(err);
+
+    unlink(TEST_PREAD_FILE);
+    object_unref(OBJECT(ioc));
+}
+#endif /* CONFIG_PREADV */
+
+
 #ifndef _WIN32
 static void test_io_channel_pipe(bool async)
 {
@@ -147,6 +272,18 @@ int main(int argc, char **argv)
     g_test_add_func("/io/channel/file", test_io_channel_file);
     g_test_add_func("/io/channel/file/rdwr", test_io_channel_file_rdwr);
     g_test_add_func("/io/channel/file/fd", test_io_channel_fd);
+#ifdef CONFIG_PREADV
+    g_test_add_func("/io/channel/file/preadv-all",
+                    test_io_channel_preadv_all);
+    g_test_add_func("/io/channel/file/pread-all",
+                    test_io_channel_pread_all);
+    g_test_add_func("/io/channel/file/preadv-all-eof/clean",
+                    test_io_channel_preadv_all_eof_clean);
+    g_test_add_func("/io/channel/file/preadv-all-eof/partial",
+                    test_io_channel_preadv_all_eof_partial);
+    g_test_add_func("/io/channel/file/preadv-all/eof-is-error",
+                    test_io_channel_preadv_all_eof_is_error);
+#endif
 #ifndef _WIN32
     g_test_add_func("/io/channel/pipe/sync", test_io_channel_pipe_sync);
     g_test_add_func("/io/channel/pipe/async", test_io_channel_pipe_async);
-- 
2.43.0


