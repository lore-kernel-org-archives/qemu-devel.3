Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF07EFD4F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w03Fx-0004YU-45; Tue, 10 Mar 2026 16:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w03Fu-0004Y6-9z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:00:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w03Fs-0004VG-CK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:00:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FDD84D2DF;
 Tue, 10 Mar 2026 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773172834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dt/w+PlQe+ZwEbun/0ou2Nl2z4Fz6f2TzTC4sUZI+MQ=;
 b=E4wwITjvHxtmef/UQFyVU0NsZlxQgjhOSONQmZuPtTzKRbqVOviq3Z4BDS0KPsJLcSPFLu
 jxaqbzXVe0nd+Zg280aZPYsgWoM7oRiS8HsTyK6c7JtkJTm54HJwQLvRIa62GaOniQ9c7Z
 75Bl6vYOgOc4XsKRKpvmBkaZQsGiRE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773172834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dt/w+PlQe+ZwEbun/0ou2Nl2z4Fz6f2TzTC4sUZI+MQ=;
 b=KtgKcd1VjQ93DlA3T6dbZPEIdth3zGYW9iUGcEuXc3NCefFnjpWeohn3Ph8ZKgx7Z3Sylg
 A1HMn5hBj7sVjBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773172833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dt/w+PlQe+ZwEbun/0ou2Nl2z4Fz6f2TzTC4sUZI+MQ=;
 b=uDVIJ+t9jvHC6MZjguh03dTYRQzPunb4mZ5rD2JckbquUiq2GgPoSaFp+Ux9IscIZnvyjl
 9JYq+DD4WGc+H5xYDu5sLu24N56hTyx5F8BvG40OFsmh6wU9Fft5x6K/sfCWtr27f3NsmW
 +p7KUg+pqTj5X/qfZtStRm2yBi5S1nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773172833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dt/w+PlQe+ZwEbun/0ou2Nl2z4Fz6f2TzTC4sUZI+MQ=;
 b=Hj1u5Ipvj3MBy/HcbtbcxTA9f9PX9FnrM0a43OCuWu3blCE6ER5epArkLcw8yrkJ3z8cNB
 0k65UZ2Lq/HQclAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDE6C3F620;
 Tue, 10 Mar 2026 20:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BjeUKGB4sGmpcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 20:00:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] tests/qtest/vhost-user-test: Use g_timeout_add() to
 schedule connect
In-Reply-To: <20260306170129.2475815-1-peter.maydell@linaro.org>
References: <20260306170129.2475815-1-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 17:00:30 -0300
Message-ID: <87wlzjzc81.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In vhost-user-test, we currently create a new g_thread to run the
> connect_thread() function.  This function sleeps for 1 second, and
> then calls test_server_create_chr() to create and configure a
> chardev:
>
>     chr = qemu_chr_new(server->chr_name, chr_path, server->context);
>     g_assert(chr);
>
>     qemu_chr_fe_init(&server->chr, chr, &error_abort);
>     qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
>                              chr_event, NULL, server, server->context, true);
>
> This has a race condition, because when we set the
> 'reconnect-ms=1000' option on the chardev the socket chardev's
> implementation handles the connect asynchronously, via a background
> thread and a callback invoked in the main-loop thread.  This means
> that that callback and the test_server_create_chr() call to
> qemu_chr_fe_set_handlers() can both enter the char-socket code
> simultaneously.  The result is random assertion failures and memory
> leaks reported by the clang address-sanitizer.
>
> Fix this by using g_timeout_source_new() to set up a GSource that
> will run test_server_connect() on the main-loop thread.  This ensures
> it can't execute in parallel with the callback that the socket
> chardev sets up.  This is similar to how we already handle the
> reconnect_cb() in test_reconnect().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Having finally tracked down the root cause of the leak reports in
> the vhost-user-tests, this seems to me a fairly straightforward
> way to deal with it.
>
>  tests/qtest/vhost-user-test.c | 36 ++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index d2bb21d5b9..c8b5f8ff71 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -930,26 +930,42 @@ reconnect_cb(gpointer user_data)
>      return FALSE;
>  }
>  
> -static gpointer
> -connect_thread(gpointer data)
> +static gboolean connect_cb(gpointer user_data)
>  {
> -    TestServer *s = data;
> +    TestServer *s = user_data;
>  
> -    /* wait for qemu to start before first try, to avoid extra warnings */
> -    g_usleep(G_USEC_PER_SEC);
>      test_server_connect(s);
>  
> -    return NULL;
> +    /* We only need to be called once */
> +    return G_SOURCE_REMOVE;
> +}
> +
> +/* Initial delay before connect, in milliseconds (1 second) */
> +#define INITIAL_CONNECT_DELAY_MS (1 * 1000)
> +
> +static void test_schedule_connect(TestServer *s)
> +{
> +    /*
> +     * Wait for a bit for QEMU to start before we first try to connect,
> +     * to avoid extra warnings. We must run the "connect" on the
> +     * main-loop thread so it doesn't race with a callback that
> +     * the socket-chardev sets up on the main-loop.
> +     */
> +    GSource *src = g_timeout_source_new(INITIAL_CONNECT_DELAY_MS);
> +    g_source_set_callback(src, connect_cb, s, NULL);
> +    g_source_attach(src, s->context);
> +    g_source_unref(src);
>  }
>  
>  static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
>  {
>      TestServer *s = test_server_new("reconnect", arg);
>  
> -    g_thread_unref(g_thread_new("connect", connect_thread, s));
>      append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
>      s->vu_ops->append_opts(s, cmd_line, ",server=on");
>  
> +    test_schedule_connect(s);
> +
>      g_test_queue_destroy(vhost_user_test_cleanup, s);
>  
>      return s;
> @@ -983,10 +999,11 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
>  
>      s->test_fail = true;
>  
> -    g_thread_unref(g_thread_new("connect", connect_thread, s));
>      append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
>      s->vu_ops->append_opts(s, cmd_line, ",server=on");
>  
> +    test_schedule_connect(s);
> +
>      g_test_queue_destroy(vhost_user_test_cleanup, s);
>  
>      return s;
> @@ -998,10 +1015,11 @@ static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
>  
>      s->test_flags = TEST_FLAGS_DISCONNECT;
>  
> -    g_thread_unref(g_thread_new("connect", connect_thread, s));
>      append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
>      s->vu_ops->append_opts(s, cmd_line, ",server=on");
>  
> +    test_schedule_connect(s);
> +
>      g_test_queue_destroy(vhost_user_test_cleanup, s);
>  
>      return s;

Thanks!

Reviewed-by: Fabiano Rosas <farosas@suse.de>

