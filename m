Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4CBFDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdo-0008Mp-NM; Thu, 23 Apr 2026 15:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzdR-0007Qr-Qe
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzdO-0002XA-2o
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B817A6A8A3;
 Thu, 23 Apr 2026 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9h1RGVUintiLczHJ0lwPb10uCyBb8GYOF4K4VgEEz8=;
 b=EdCwKYCgQjR+c33467V+ig3utSpZYmBrd0q/iD96a1C0x/Sj0OT0omZdmIbvcN2MB4RNat
 U54zTVWn01ExSxrB7Gx4AqpV36jmtFUX9mOqr/wzjfQTtOHiFZOxgakPUQTPXKOi7H0d4u
 EUC2d+Zng0Oh7cg0ZwzSP+BOSGzmlXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9h1RGVUintiLczHJ0lwPb10uCyBb8GYOF4K4VgEEz8=;
 b=cverKs2VFUC8JfINeXVaQpIculdj1jx9LVmCnxniTlrIXg8+v5DZC4qUdbVliDSni/di1n
 JmTLnAMS1hx0diCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EdCwKYCg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cverKs2V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9h1RGVUintiLczHJ0lwPb10uCyBb8GYOF4K4VgEEz8=;
 b=EdCwKYCgQjR+c33467V+ig3utSpZYmBrd0q/iD96a1C0x/Sj0OT0omZdmIbvcN2MB4RNat
 U54zTVWn01ExSxrB7Gx4AqpV36jmtFUX9mOqr/wzjfQTtOHiFZOxgakPUQTPXKOi7H0d4u
 EUC2d+Zng0Oh7cg0ZwzSP+BOSGzmlXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9h1RGVUintiLczHJ0lwPb10uCyBb8GYOF4K4VgEEz8=;
 b=cverKs2VFUC8JfINeXVaQpIculdj1jx9LVmCnxniTlrIXg8+v5DZC4qUdbVliDSni/di1n
 JmTLnAMS1hx0diCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79FAA593A3;
 Thu, 23 Apr 2026 19:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJJqERxx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:21:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 39/43] tests/unit: add pread/pwrite _all tests for io channel
 file
Date: Thu, 23 Apr 2026 16:19:53 -0300
Message-ID: <20260423191958.1440-40-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B817A6A8A3
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Junjie Cao <junjie.cao@intel.com>

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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260413214549.926435-5-junjie.cao@intel.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
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
2.51.0


