Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26BFF9D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCgE1-0002G0-QE; Tue, 14 Apr 2026 12:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCgCt-0001qo-5k
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:01:49 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCgCq-0002A4-TB
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 12:01:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 32EC76A923;
 Tue, 14 Apr 2026 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776182497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5epeZS7gQeyZI3GRPRjJA/MQs5JuJpdcBe4fP0KydaA=;
 b=SCQ84fmY2pQp+p2UhL1viBq43aUKiJBjf5IIkUkHbCN/MFuSX2Fg6oZ+MRAsvS6bKnzt5H
 cK1CklwTI4oK2fDOffGJGbuReZy/8+wnEdFgtJGQMohocL4kF0mcsYNHW3Kb1IHII382mK
 FqHbM8RtArN5rciuXBJJrI9MJFf+Mbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776182497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5epeZS7gQeyZI3GRPRjJA/MQs5JuJpdcBe4fP0KydaA=;
 b=eXEbFRIsAjTKAtbYDDeyZ1MxkrewT3gNAEiGojXVh0Q77Ib3GEyM2nlwaimAbh04HuPz8b
 E52unbQDOmRWnsDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776182492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5epeZS7gQeyZI3GRPRjJA/MQs5JuJpdcBe4fP0KydaA=;
 b=0BBrL6eH11YKW7GLzh/FYm9hZZ9NE/svCjEJCJo3YJDlPCv3PrvnaHJ4lEjK3IYs4ujCSG
 H6R+nP1C9yi1I9SytO/F/TJjMlSVXhL+C27vmESa0+sBX7JpYAIWMYbGF+O9947nXgGbJx
 dk8PYA70GJm8WnS4pBTYfj0TP0TbSEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776182492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5epeZS7gQeyZI3GRPRjJA/MQs5JuJpdcBe4fP0KydaA=;
 b=5vrE03RIuhRkB3ybv7T2SZ3hCDK0HZhbOJ8CgTCO6MrZol5oZqSQOxI2mN3HMhMmm3GHCx
 Hbd1yr3QThHk/4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C70DA4B517;
 Tue, 14 Apr 2026 16:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ztKmJdtk3mnwWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 16:01:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, junjie.cao@intel.com
Subject: Re: [PATCH v3 4/4] tests/unit: add pread/pwrite _all tests for io
 channel file
In-Reply-To: <20260413214549.926435-5-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <20260413214549.926435-5-junjie.cao@intel.com>
Date: Tue, 14 Apr 2026 13:01:25 -0300
Message-ID: <878qapzg2y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, intel.com:email,
 imap1.dmz-prg2.suse.org:helo]
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

Junjie Cao <junjie.cao@intel.com> writes:

> Add unit tests for the new qio_channel_pread{v,}_all{,_eof}() and
> qio_channel_pwrite{v,}_all() APIs.
>
> The basic tests write data to a file channel, then read it back at
> various offsets using both the single-buffer and iovec variants to
> make sure the round-trip produces identical content.  The _eof tests
> verify all three return cases -- full read (1), clean EOF (0), and
> partial-then-EOF (-1 with error set) -- and check that the strict
> wrappers (preadv_all / pread_all) treat a clean EOF as an error.
>
> All tests are guarded by CONFIG_PREADV since the underlying channel
> methods require preadv(2).
>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  tests/unit/test-io-channel-file.c | 207 ++++++++++++++++++++++++++++++
>  1 file changed, 207 insertions(+)
>
> diff --git a/tests/unit/test-io-channel-file.c b/tests/unit/test-io-channel-file.c
> index 1977006ce9..b597350dca 100644
> --- a/tests/unit/test-io-channel-file.c
> +++ b/tests/unit/test-io-channel-file.c
> @@ -102,6 +102,203 @@ static void test_io_channel_fd(void)
>  }
>  
>  
> +#ifdef CONFIG_PREADV
> +static void test_io_channel_pread_all(void)
> +{
> +    QIOChannel *ioc;
> +    char write_buf[] = "Hello World, pread_all";
> +    char read_buf[sizeof(write_buf)] = {0};
> +    int ret;
> +
> +    unlink(TEST_FILE);
> +    ioc = QIO_CHANNEL(qio_channel_file_new_path(
> +                          TEST_FILE,
> +                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> +                          TEST_MASK,
> +                          &error_abort));
> +
> +    ret = qio_channel_pwrite_all(ioc, write_buf, sizeof(write_buf),
> +                                 0, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    /* Read back at offset 0 */
> +    ret = qio_channel_pread_all(ioc, read_buf, sizeof(read_buf),
> +                                0, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +    g_assert_cmpmem(write_buf, sizeof(write_buf),
> +                    read_buf, sizeof(read_buf));
> +
> +    /* Read at a non-zero offset */
> +    memset(read_buf, 0, sizeof(read_buf));
> +    ret = qio_channel_pread_all(ioc, read_buf, sizeof(write_buf) - 7,
> +                                7, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +    g_assert_cmpmem(write_buf + 7, sizeof(write_buf) - 7,
> +                    read_buf, sizeof(write_buf) - 7);
> +
> +    unlink(TEST_FILE);
> +    object_unref(OBJECT(ioc));
> +}
> +
> +static void test_io_channel_preadv_all(void)
> +{
> +    QIOChannel *ioc;
> +    char write_buf[256];
> +    char read_buf[256] = {0};
> +    struct iovec write_iov[2];
> +    struct iovec read_iov[2];
> +    int ret;
> +    size_t i;
> +
> +    for (i = 0; i < sizeof(write_buf); i++) {
> +        write_buf[i] = i & 0xff;
> +    }
> +
> +    unlink(TEST_FILE);
> +    ioc = QIO_CHANNEL(qio_channel_file_new_path(
> +                          TEST_FILE,
> +                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> +                          TEST_MASK,
> +                          &error_abort));
> +
> +    /* Write using pwritev_all with 2 iovecs */
> +    write_iov[0].iov_base = write_buf;
> +    write_iov[0].iov_len = 128;
> +    write_iov[1].iov_base = write_buf + 128;
> +    write_iov[1].iov_len = 128;
> +    ret = qio_channel_pwritev_all(ioc, write_iov, 2, 0, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    /* Read back using preadv_all with 2 iovecs */
> +    read_iov[0].iov_base = read_buf;
> +    read_iov[0].iov_len = 128;
> +    read_iov[1].iov_base = read_buf + 128;
> +    read_iov[1].iov_len = 128;
> +    ret = qio_channel_preadv_all(ioc, read_iov, 2, 0, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    g_assert_cmpmem(write_buf, sizeof(write_buf),
> +                    read_buf, sizeof(read_buf));
> +
> +    /* Read at non-zero offset with preadv_all */
> +    memset(read_buf, 0, sizeof(read_buf));
> +    read_iov[0].iov_base = read_buf;
> +    read_iov[0].iov_len = 64;
> +    read_iov[1].iov_base = read_buf + 64;
> +    read_iov[1].iov_len = 64;
> +    ret = qio_channel_preadv_all(ioc, read_iov, 2, 128, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    g_assert_cmpmem(write_buf + 128, 128,
> +                    read_buf, 128);
> +
> +    unlink(TEST_FILE);
> +    object_unref(OBJECT(ioc));
> +}
> +
> +static void test_io_channel_preadv_all_eof(void)
> +{
> +    QIOChannel *ioc;
> +    char write_buf[] = "Hello World, preadv_all_eof";
> +    char read_buf[sizeof(write_buf)] = {0};
> +    struct iovec iov;
> +    int ret;
> +    Error *err = NULL;
> +
> +    unlink(TEST_FILE);
> +    ioc = QIO_CHANNEL(qio_channel_file_new_path(
> +                          TEST_FILE,
> +                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> +                          TEST_MASK,
> +                          &error_abort));
> +
> +    ret = qio_channel_pwrite_all(ioc, write_buf, sizeof(write_buf),
> +                                 0, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    /* Full read succeeds: should return 1 */
> +    iov.iov_base = read_buf;
> +    iov.iov_len = sizeof(read_buf);
> +    ret = qio_channel_preadv_all_eof(ioc, &iov, 1, 0, &error_abort);
> +    g_assert_cmpint(ret, ==, 1);
> +    g_assert_cmpmem(write_buf, sizeof(write_buf),
> +                    read_buf, sizeof(read_buf));
> +
> +    /* Clean EOF: offset at file end, should return 0 */
> +    iov.iov_base = read_buf;
> +    iov.iov_len = 1;
> +    ret = qio_channel_preadv_all_eof(ioc, &iov, 1,
> +                                     sizeof(write_buf), &err);
> +    g_assert_cmpint(ret, ==, 0);
> +    g_assert_null(err);
> +
> +    /* Partial EOF: start before end, request extends past */
> +    iov.iov_base = read_buf;
> +    iov.iov_len = 8;
> +    ret = qio_channel_preadv_all_eof(ioc, &iov, 1,
> +                                     sizeof(write_buf) - 4, &err);
> +    g_assert_cmpint(ret, ==, -1);
> +    g_assert_nonnull(err);
> +    error_free(err);
> +    err = NULL;
> +
> +    /* Strict wrapper (preadv_all) treats clean EOF as error */
> +    iov.iov_base = read_buf;
> +    iov.iov_len = 1;
> +    ret = qio_channel_preadv_all(ioc, &iov, 1,
> +                                 sizeof(write_buf), &err);
> +    g_assert_cmpint(ret, ==, -1);
> +    g_assert_nonnull(err);
> +    error_free(err);
> +
> +    unlink(TEST_FILE);
> +    object_unref(OBJECT(ioc));
> +}
> +
> +static void test_io_channel_pread_all_eof(void)
> +{
> +    QIOChannel *ioc;
> +    char write_buf[] = "Hello World, pread_all_eof";
> +    char read_buf[sizeof(write_buf)] = {0};
> +    int ret;
> +    Error *err = NULL;
> +
> +    unlink(TEST_FILE);
> +    ioc = QIO_CHANNEL(qio_channel_file_new_path(
> +                          TEST_FILE,
> +                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> +                          TEST_MASK,
> +                          &error_abort));
> +
> +    ret = qio_channel_pwrite_all(ioc, write_buf, sizeof(write_buf),
> +                                 0, &error_abort);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    /* Full read succeeds: should return 1 */
> +    ret = qio_channel_pread_all_eof(ioc, read_buf, sizeof(read_buf),
> +                                    0, &error_abort);
> +    g_assert_cmpint(ret, ==, 1);
> +    g_assert_cmpmem(write_buf, sizeof(write_buf),
> +                    read_buf, sizeof(read_buf));
> +
> +    /* Clean EOF: should return 0 */
> +    ret = qio_channel_pread_all_eof(ioc, read_buf, 1,
> +                                    sizeof(write_buf), &err);
> +    g_assert_cmpint(ret, ==, 0);
> +    g_assert_null(err);
> +
> +    /* Partial EOF: should return -1 */
> +    ret = qio_channel_pread_all_eof(ioc, read_buf, 8,
> +                                    sizeof(write_buf) - 4, &err);
> +    g_assert_cmpint(ret, ==, -1);
> +    g_assert_nonnull(err);
> +    error_free(err);
> +
> +    unlink(TEST_FILE);
> +    object_unref(OBJECT(ioc));
> +}
> +#endif /* CONFIG_PREADV */
> +
>  #ifndef _WIN32
>  static void test_io_channel_pipe(bool async)
>  {
> @@ -147,6 +344,16 @@ int main(int argc, char **argv)
>      g_test_add_func("/io/channel/file", test_io_channel_file);
>      g_test_add_func("/io/channel/file/rdwr", test_io_channel_file_rdwr);
>      g_test_add_func("/io/channel/file/fd", test_io_channel_fd);
> +#ifdef CONFIG_PREADV
> +    g_test_add_func("/io/channel/file/pread-all",
> +                    test_io_channel_pread_all);
> +    g_test_add_func("/io/channel/file/preadv-all",
> +                    test_io_channel_preadv_all);
> +    g_test_add_func("/io/channel/file/preadv-all-eof",
> +                    test_io_channel_preadv_all_eof);
> +    g_test_add_func("/io/channel/file/pread-all-eof",
> +                    test_io_channel_pread_all_eof);
> +#endif
>  #ifndef _WIN32
>      g_test_add_func("/io/channel/pipe/sync", test_io_channel_pipe_sync);
>      g_test_add_func("/io/channel/pipe/async", test_io_channel_pipe_async);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

