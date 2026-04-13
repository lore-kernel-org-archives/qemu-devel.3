Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310D0F34C4E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHci-0005Qw-Mq; Mon, 13 Apr 2026 09:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHcg-0005OI-Tb
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:42 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHce-0002Hd-Vl
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776088001; x=1807624001;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ApqyZHZa9fhGJ2xZs56EjVo0twC5/V/7fNPCkKeWwQs=;
 b=PaRSvuviHw0X4pwDubkC0GkYmbE8eR0ywl4Np2Pt3mzY1DZz8AKhPTIB
 dNKx9w+G7AW8KSZTxkgdIwDYNX5rIOUVWfltJ0OhpN8IkzcVdAoKFA7uI
 wHlMT7f1G+9yK9lL/2DT3hfFz69opN2iFqKyW9Wa2nm8vK+6p/wdRO4Lw
 MzorLheRfnfhiZ0ZMlWNLJN/aWorq0RsmLHxNb0fSFtMTYeaemTDZeiJ6
 BM2ubyrsJSoj3zfIRXWC1Navo7EXS0gy/j8c2tC2ZW73bUcjkIHWMkCFc
 8m02ekDSbbZZk3R0zrchPEzr3tybbk4Aw7n2B62VgDfVwBFlzcAYBdNWm g==;
X-CSE-ConnectionGUID: xf0GMaG+RhS7+7lKbvVNpg==
X-CSE-MsgGUID: jDYVNDPJRUuj4dl+b32flw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80885702"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="80885702"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:46:40 -0700
X-CSE-ConnectionGUID: bTHnEagBRkGVRw0IeTHWIA==
X-CSE-MsgGUID: 07XdndmdTya6AiJ2a+osWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="234770444"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 06:46:38 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 junjie.cao@intel.com
Subject: [PATCH v3 4/4] tests/unit: add pread/pwrite _all tests for io channel
 file
Date: Tue, 14 Apr 2026 05:45:49 +0800
Message-ID: <20260413214549.926435-5-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413214549.926435-1-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add unit tests for the new qio_channel_pread{v,}_all{,_eof}() and
qio_channel_pwrite{v,}_all() APIs.

The basic tests write data to a file channel, then read it back at
various offsets using both the single-buffer and iovec variants to
make sure the round-trip produces identical content.  The _eof tests
verify all three return cases -- full read (1), clean EOF (0), and
partial-then-EOF (-1 with error set) -- and check that the strict
wrappers (preadv_all / pread_all) treat a clean EOF as an error.

All tests are guarded by CONFIG_PREADV since the underlying channel
methods require preadv(2).

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/unit/test-io-channel-file.c | 207 ++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/tests/unit/test-io-channel-file.c b/tests/unit/test-io-channel-file.c
index 1977006ce9..b597350dca 100644
--- a/tests/unit/test-io-channel-file.c
+++ b/tests/unit/test-io-channel-file.c
@@ -102,6 +102,203 @@ static void test_io_channel_fd(void)
 }
 
 
+#ifdef CONFIG_PREADV
+static void test_io_channel_pread_all(void)
+{
+    QIOChannel *ioc;
+    char write_buf[] = "Hello World, pread_all";
+    char read_buf[sizeof(write_buf)] = {0};
+    int ret;
+
+    unlink(TEST_FILE);
+    ioc = QIO_CHANNEL(qio_channel_file_new_path(
+                          TEST_FILE,
+                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+                          TEST_MASK,
+                          &error_abort));
+
+    ret = qio_channel_pwrite_all(ioc, write_buf, sizeof(write_buf),
+                                 0, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+
+    /* Read back at offset 0 */
+    ret = qio_channel_pread_all(ioc, read_buf, sizeof(read_buf),
+                                0, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpmem(write_buf, sizeof(write_buf),
+                    read_buf, sizeof(read_buf));
+
+    /* Read at a non-zero offset */
+    memset(read_buf, 0, sizeof(read_buf));
+    ret = qio_channel_pread_all(ioc, read_buf, sizeof(write_buf) - 7,
+                                7, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpmem(write_buf + 7, sizeof(write_buf) - 7,
+                    read_buf, sizeof(write_buf) - 7);
+
+    unlink(TEST_FILE);
+    object_unref(OBJECT(ioc));
+}
+
+static void test_io_channel_preadv_all(void)
+{
+    QIOChannel *ioc;
+    char write_buf[256];
+    char read_buf[256] = {0};
+    struct iovec write_iov[2];
+    struct iovec read_iov[2];
+    int ret;
+    size_t i;
+
+    for (i = 0; i < sizeof(write_buf); i++) {
+        write_buf[i] = i & 0xff;
+    }
+
+    unlink(TEST_FILE);
+    ioc = QIO_CHANNEL(qio_channel_file_new_path(
+                          TEST_FILE,
+                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+                          TEST_MASK,
+                          &error_abort));
+
+    /* Write using pwritev_all with 2 iovecs */
+    write_iov[0].iov_base = write_buf;
+    write_iov[0].iov_len = 128;
+    write_iov[1].iov_base = write_buf + 128;
+    write_iov[1].iov_len = 128;
+    ret = qio_channel_pwritev_all(ioc, write_iov, 2, 0, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+
+    /* Read back using preadv_all with 2 iovecs */
+    read_iov[0].iov_base = read_buf;
+    read_iov[0].iov_len = 128;
+    read_iov[1].iov_base = read_buf + 128;
+    read_iov[1].iov_len = 128;
+    ret = qio_channel_preadv_all(ioc, read_iov, 2, 0, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+
+    g_assert_cmpmem(write_buf, sizeof(write_buf),
+                    read_buf, sizeof(read_buf));
+
+    /* Read at non-zero offset with preadv_all */
+    memset(read_buf, 0, sizeof(read_buf));
+    read_iov[0].iov_base = read_buf;
+    read_iov[0].iov_len = 64;
+    read_iov[1].iov_base = read_buf + 64;
+    read_iov[1].iov_len = 64;
+    ret = qio_channel_preadv_all(ioc, read_iov, 2, 128, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+
+    g_assert_cmpmem(write_buf + 128, 128,
+                    read_buf, 128);
+
+    unlink(TEST_FILE);
+    object_unref(OBJECT(ioc));
+}
+
+static void test_io_channel_preadv_all_eof(void)
+{
+    QIOChannel *ioc;
+    char write_buf[] = "Hello World, preadv_all_eof";
+    char read_buf[sizeof(write_buf)] = {0};
+    struct iovec iov;
+    int ret;
+    Error *err = NULL;
+
+    unlink(TEST_FILE);
+    ioc = QIO_CHANNEL(qio_channel_file_new_path(
+                          TEST_FILE,
+                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+                          TEST_MASK,
+                          &error_abort));
+
+    ret = qio_channel_pwrite_all(ioc, write_buf, sizeof(write_buf),
+                                 0, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+
+    /* Full read succeeds: should return 1 */
+    iov.iov_base = read_buf;
+    iov.iov_len = sizeof(read_buf);
+    ret = qio_channel_preadv_all_eof(ioc, &iov, 1, 0, &error_abort);
+    g_assert_cmpint(ret, ==, 1);
+    g_assert_cmpmem(write_buf, sizeof(write_buf),
+                    read_buf, sizeof(read_buf));
+
+    /* Clean EOF: offset at file end, should return 0 */
+    iov.iov_base = read_buf;
+    iov.iov_len = 1;
+    ret = qio_channel_preadv_all_eof(ioc, &iov, 1,
+                                     sizeof(write_buf), &err);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_null(err);
+
+    /* Partial EOF: start before end, request extends past */
+    iov.iov_base = read_buf;
+    iov.iov_len = 8;
+    ret = qio_channel_preadv_all_eof(ioc, &iov, 1,
+                                     sizeof(write_buf) - 4, &err);
+    g_assert_cmpint(ret, ==, -1);
+    g_assert_nonnull(err);
+    error_free(err);
+    err = NULL;
+
+    /* Strict wrapper (preadv_all) treats clean EOF as error */
+    iov.iov_base = read_buf;
+    iov.iov_len = 1;
+    ret = qio_channel_preadv_all(ioc, &iov, 1,
+                                 sizeof(write_buf), &err);
+    g_assert_cmpint(ret, ==, -1);
+    g_assert_nonnull(err);
+    error_free(err);
+
+    unlink(TEST_FILE);
+    object_unref(OBJECT(ioc));
+}
+
+static void test_io_channel_pread_all_eof(void)
+{
+    QIOChannel *ioc;
+    char write_buf[] = "Hello World, pread_all_eof";
+    char read_buf[sizeof(write_buf)] = {0};
+    int ret;
+    Error *err = NULL;
+
+    unlink(TEST_FILE);
+    ioc = QIO_CHANNEL(qio_channel_file_new_path(
+                          TEST_FILE,
+                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+                          TEST_MASK,
+                          &error_abort));
+
+    ret = qio_channel_pwrite_all(ioc, write_buf, sizeof(write_buf),
+                                 0, &error_abort);
+    g_assert_cmpint(ret, ==, 0);
+
+    /* Full read succeeds: should return 1 */
+    ret = qio_channel_pread_all_eof(ioc, read_buf, sizeof(read_buf),
+                                    0, &error_abort);
+    g_assert_cmpint(ret, ==, 1);
+    g_assert_cmpmem(write_buf, sizeof(write_buf),
+                    read_buf, sizeof(read_buf));
+
+    /* Clean EOF: should return 0 */
+    ret = qio_channel_pread_all_eof(ioc, read_buf, 1,
+                                    sizeof(write_buf), &err);
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_null(err);
+
+    /* Partial EOF: should return -1 */
+    ret = qio_channel_pread_all_eof(ioc, read_buf, 8,
+                                    sizeof(write_buf) - 4, &err);
+    g_assert_cmpint(ret, ==, -1);
+    g_assert_nonnull(err);
+    error_free(err);
+
+    unlink(TEST_FILE);
+    object_unref(OBJECT(ioc));
+}
+#endif /* CONFIG_PREADV */
+
 #ifndef _WIN32
 static void test_io_channel_pipe(bool async)
 {
@@ -147,6 +344,16 @@ int main(int argc, char **argv)
     g_test_add_func("/io/channel/file", test_io_channel_file);
     g_test_add_func("/io/channel/file/rdwr", test_io_channel_file_rdwr);
     g_test_add_func("/io/channel/file/fd", test_io_channel_fd);
+#ifdef CONFIG_PREADV
+    g_test_add_func("/io/channel/file/pread-all",
+                    test_io_channel_pread_all);
+    g_test_add_func("/io/channel/file/preadv-all",
+                    test_io_channel_preadv_all);
+    g_test_add_func("/io/channel/file/preadv-all-eof",
+                    test_io_channel_preadv_all_eof);
+    g_test_add_func("/io/channel/file/pread-all-eof",
+                    test_io_channel_pread_all_eof);
+#endif
 #ifndef _WIN32
     g_test_add_func("/io/channel/pipe/sync", test_io_channel_pipe_sync);
     g_test_add_func("/io/channel/pipe/async", test_io_channel_pipe_async);
-- 
2.43.0


