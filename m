Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5857D637CF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 22:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBLyK-0005sJ-C3; Wed, 13 Nov 2024 17:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBLyI-0005rw-5s
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:36:22 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBLyG-0006cg-9N
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:36:21 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E28D521238;
 Wed, 13 Nov 2024 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731537378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBDMvLhftaVPChbXkp1LCEnwGIlYnI8/+zTfXd3j7dE=;
 b=HdZ0yQts1QTppqXA6bDPBqYrvIv7Yo6UrPBqdIAE+bl+I6lgA+Gg/gySMAQ+NiJ1RuGSjT
 m/Ii6IQDlP01wLXYXu/SszfW6ZeixPIs0nNaC7toP0NJ/m0DecCyRYgQrIyq9pur7lhgsL
 znVS4c0h69/LMjDnPO/0wwmk1+NIanU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731537378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBDMvLhftaVPChbXkp1LCEnwGIlYnI8/+zTfXd3j7dE=;
 b=JJ33b8cwb9LLj7vTCpIX5TxkGrvbKW3P7DxROhSjggIpv67leZb5c84sOYsrjvwpKG73Mx
 D/irjW6IM60ZE9Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731537377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBDMvLhftaVPChbXkp1LCEnwGIlYnI8/+zTfXd3j7dE=;
 b=IwTWNIy+pbbrtKY2KjqiNKEXmm3ReX+F/Ros1E0Spspqtw632gX7rN7iT1uneMHTD64wm5
 EWqD24VT/WULMAkoO2Ifh9Ah6CWlO7O/3eKyUSKMwWCXVtsuXVpANZDJozIh1c1BBnfAKk
 f22qPWeFSSGAIcGnUXqIgBT9cneTzHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731537377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBDMvLhftaVPChbXkp1LCEnwGIlYnI8/+zTfXd3j7dE=;
 b=kQFfNg4Sn4z0eHURy5O6Oy+Vc/70RyiG5zoFAAVdxZvagJWmV2H/fQIG1fLw3HaE5FqtEl
 Fw0P4zPt8ynZOMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FB8D13A6E;
 Wed, 13 Nov 2024 22:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Nf2uCeEpNWe0IgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 22:36:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V3 13/16] tests/qtest: defer connection
In-Reply-To: <1730468875-249970-14-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-14-git-send-email-steven.sistare@oracle.com>
Date: Wed, 13 Nov 2024 19:36:03 -0300
Message-ID: <87v7wqhics.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Add an option to defer making the connecting to the monitor and qtest
> sockets when calling qtest_init_with_env.  The client makes the connection
> later by calling qtest_connect_deferred and qtest_qmp_handshake.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/libqtest.c       | 69 +++++++++++++++++++++++++++++---------------
>  tests/qtest/libqtest.h       | 19 +++++++++++-
>  tests/qtest/migration-test.c |  4 +--
>  3 files changed, 65 insertions(+), 27 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 9d07de1..95408fb 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -75,6 +75,8 @@ struct QTestState
>  {
>      int fd;
>      int qmp_fd;
> +    int sock;
> +    int qmpsock;
>      pid_t qemu_pid;  /* our child QEMU process */
>      int wstatus;
>  #ifdef _WIN32
> @@ -443,7 +445,8 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
>  }
>  
>  static QTestState *qtest_init_internal(const char *qemu_bin,
> -                                       const char *extra_args)
> +                                       const char *extra_args,
> +                                       bool defer_connect)
>  {
>      QTestState *s;
>      int sock, qmpsock, i;
> @@ -485,22 +488,17 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>      qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
>      qtest_client_set_tx_handler(s, qtest_client_socket_send);
>  
> -    s->fd = socket_accept(sock);
> -    if (s->fd >= 0) {
> -        s->qmp_fd = socket_accept(qmpsock);
> -    }
> -    unlink(socket_path);
> -    unlink(qmp_socket_path);
> -    g_free(socket_path);
> -    g_free(qmp_socket_path);
> -
> -    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
> -
>      s->rx = g_string_new("");
>      for (i = 0; i < MAX_IRQ; i++) {
>          s->irq_level[i] = false;
>      }
>  
> +    s->sock = sock;
> +    s->qmpsock = qmpsock;
> +    if (!defer_connect) {
> +        qtest_connect_deferred(s);
> +    }

It might be cleaner to just leave qtest_connect_deferred() to the
callers and not plumb defer_connect through.

> +
>      /*
>       * Stopping QEMU for debugging is not supported on Windows.
>       *
> @@ -515,34 +513,57 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>      }
>  #endif
>  
> +   return s;
> +}
> +
> +void qtest_connect_deferred(QTestState *s)
> +{
> +    g_autofree gchar *socket_path = NULL;
> +    g_autofree gchar *qmp_socket_path = NULL;
> +
> +    socket_path = g_strdup_printf("%s/qtest-%d.sock",
> +                                  g_get_tmp_dir(), getpid());
> +    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
> +                                      g_get_tmp_dir(), getpid());
> +
> +    s->fd = socket_accept(s->sock);
> +    if (s->fd >= 0) {
> +        s->qmp_fd = socket_accept(s->qmpsock);
> +    }
> +    unlink(socket_path);
> +    unlink(qmp_socket_path);
> +    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
>      /* ask endianness of the target */
> -
>      s->big_endian = qtest_query_target_endianness(s);
> -
> -   return s;
>  }
>  
>  QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>  {
> -    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
> +    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, false);
>  }
>  
> -QTestState *qtest_init_with_env(const char *var, const char *extra_args)
> +void qtest_qmp_handshake(QTestState *s)
>  {
> -    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
> -    QDict *greeting;
> -
>      /* Read the QMP greeting and then do the handshake */
> -    greeting = qtest_qmp_receive(s);
> +    QDict *greeting = qtest_qmp_receive(s);
>      qobject_unref(greeting);
>      qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
> +}
>  
> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
> +                                bool defer_connect)
> +{
> +    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
> +                                        defer_connect);
> +    if (!defer_connect) {
> +        qtest_qmp_handshake(s);
> +    }
>      return s;
>  }
>  
>  QTestState *qtest_init(const char *extra_args)
>  {
> -    return qtest_init_with_env(NULL, extra_args);
> +    return qtest_init_with_env(NULL, extra_args, false);
>  }
>  
>  QTestState *qtest_vinitf(const char *fmt, va_list ap)
> @@ -1523,7 +1544,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
>  
>      silence_spawn_log = !g_test_verbose();
>  
> -    qts = qtest_init_with_env(qemu_var, "-machine none");
> +    qts = qtest_init_with_env(qemu_var, "-machine none", false);
>      response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
>      g_assert(response);
>      list = qdict_get_qlist(response, "return");
> @@ -1578,7 +1599,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
>  
>      silence_spawn_log = !g_test_verbose();
>  
> -    qts = qtest_init_with_env(NULL, "-machine none");
> +    qts = qtest_init_with_env(NULL, "-machine none", false);
>      response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
>      g_assert(response);
>      list = qdict_get_qlist(response, "return");
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index beb96b1..db76f2c 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -60,13 +60,15 @@ QTestState *qtest_init(const char *extra_args);
>   * @var: Environment variable from where to take the QEMU binary
>   * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
>   * arguments are subject to word splitting and shell evaluation.
> + * @defer_connect: do not connect to qemu monitor and qtest socket.
>   *
>   * Like qtest_init(), but use a different environment variable for the
>   * QEMU binary.
>   *
>   * Returns: #QTestState instance.
>   */
> -QTestState *qtest_init_with_env(const char *var, const char *extra_args);
> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
> +                                bool defer_connect);
>  
>  /**
>   * qtest_init_without_qmp_handshake:
> @@ -78,6 +80,21 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
>  QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>  
>  /**
> + * qtest_connect_deferred:
> + * @s: #QTestState instance to connect
> + * Connect to qemu monitor and qtest socket, after deferring them in
> + * qtest_init_with_env.  Does not handshake with the monitor.
> + */
> +void qtest_connect_deferred(QTestState *s);
> +
> +/**
> + * qtest_qmp_handshake:
> + * @s: #QTestState instance to operate on.
> + * Perform handshake after connecting to qemu monitor.
> + */
> +void qtest_qmp_handshake(QTestState *s);
> +
> +/**
>   * qtest_init_with_serial:
>   * @extra_args: other arguments to pass to QEMU.  CAUTION: these
>   * arguments are subject to word splitting and shell evaluation.
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index a008316..d359b10 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -844,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   args->opts_source ? args->opts_source : "",
>                                   ignore_stderr);
>      if (!args->only_target) {
> -        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
> +        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source, false);
>          qtest_qmp_set_event_callback(*from,
>                                       migrate_watch_for_events,
>                                       &src_state);
> @@ -865,7 +865,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   shmem_opts ? shmem_opts : "",
>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr);
> -    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
> +    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, false);
>      qtest_qmp_set_event_callback(*to,
>                                   migrate_watch_for_events,
>                                   &dst_state);

