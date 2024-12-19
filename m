Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB369E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGO-0002fA-SX; Thu, 19 Dec 2024 11:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOIjN-0006B6-K9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOIjL-0005lA-OY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734623186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6GP9Ro1LHlKttrwR+XngdjWeXwKXZ3LteRbkU/mCOp8=;
 b=EfQd9/58NpANRXslC3W5Z9G3XBRQA1mqyi7xP3++KBt8BJ901zdb02aPXmqCT8frV8PwSj
 8DzzZgn2l5uqkhI7gYoyMSYVNqYAxRFuEYQVNJsvvWjAzZe/pbjNfGanFLt6ZfA9ClC5yF
 yaQIoFclFDYiBsgO0G6tywvSLmi1J54=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-9i9aju74MJCQNGoONz0ULQ-1; Thu, 19 Dec 2024 10:46:24 -0500
X-MC-Unique: 9i9aju74MJCQNGoONz0ULQ-1
X-Mimecast-MFC-AGG-ID: 9i9aju74MJCQNGoONz0ULQ
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46791423fc9so17816821cf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734623184; x=1735227984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GP9Ro1LHlKttrwR+XngdjWeXwKXZ3LteRbkU/mCOp8=;
 b=rVyFm+uZMX6gIQZ1GP8B+fvIBfB/W2XrfwBaOW8ydIZ3Sp1y6RjTzhH+dVLmqusAvt
 9wsVAUVukBCE/F/woefzeNdlV9jm+Q9PB1UgxoMCnGIxp7rwcOnYjTwC7KNGKdOK2SRz
 2Htbz3LUYFKc1S7uB7cS5pFDBJaZnkDcBrJtLg+0Y5zinAdOCsM0+OAzvo/smQpasqdf
 Nuksn4Dm/zI8V37Msh28PA1iGzhkqlWiQ2O3qfmXVRvI51/wo3580dU6Jw5B8F0FDE5B
 sBDQQBRnskmRroKBS89+7+rmcbvZ2ZocKv1kfkqduqQ6fJYg467lEWOSIbLP9OQUX++E
 yyuA==
X-Gm-Message-State: AOJu0YxDxyN8+TPKN11TC1TLsbGtG0etdjpu+PMg0yvcu92iwrvjgbph
 MKFwkgKgoDQtXvNdubYS8LAfSN2ubEsYL6iy5xow1wUyZ7093pRzLrkjsp4JeH0YxzzhrujpIuf
 xjSxkYwGjBzNb+6W7TDqwCAzxEPH+Kyh0YSvQHSVpMJ3vb1yH8s4r
X-Gm-Gg: ASbGnctUzEb6uX+vKxuPeg5EdyVkiir8A5lIMI0p9qNcHPNkQWOrw+H0INudIL1WwoQ
 lqCzIDSzF/2OTDmRqW8B3KhaDEqHOShlovxCSVLm21b2GFFmChRL3HMhDWgmOzloS0guLfx+G9v
 L1k4AOhz7CcQobs7ME2ZImOisHBgIixOyQNiMFwUVRFTEydd3J+FxojIsbrhe9G9IDXelKix6Fv
 aEyfz68kuKICXlfMMZLBltfAqBLImBqVW1qxd8JH4JebS8FVpvazv1BUR1r6D3F7BkNEnjKX4I4
 4GhCWF4GJnZSiiNvBg==
X-Received: by 2002:ac8:7fcb:0:b0:467:94c9:24e1 with SMTP id
 d75a77b69052e-46908e0461dmr134585371cf.32.1734623184246; 
 Thu, 19 Dec 2024 07:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL9w43C3yKO5Jw/qLP0T7ptxlnSg1OekzeTetttI/x5IwwEieH+UbTMen1Vypizm9P6lbmZg==
X-Received: by 2002:ac8:7fcb:0:b0:467:94c9:24e1 with SMTP id
 d75a77b69052e-46908e0461dmr134584781cf.32.1734623183792; 
 Thu, 19 Dec 2024 07:46:23 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb2ccdcsm7172021cf.78.2024.12.19.07.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:46:23 -0800 (PST)
Date: Thu, 19 Dec 2024 10:46:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 16/19] tests/qtest: defer connection
Message-ID: <Z2Q_zIlZs9CWHL04@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-17-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-17-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 02, 2024 at 05:20:08AM -0800, Steve Sistare wrote:
> Add an option to defer making the connecting to the monitor and qtest
> sockets when calling qtest_init_with_env.  The client makes the connection
> later by calling qtest_connect_deferred and qtest_qmp_handshake.
> 
> A test cannot specify port=0 for a deferred connection, because qmp_migrate
> cannot query for the assigned port, because the monitor is not connected
> yet.  However, even if the test does not specify port=0, qmp_migrate ->
> migrate_set_ports unconditionally queries connection parameters.
> Modify migrate_set_ports to only query when port=0.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Looks mostly good, nitpicks inline..

> ---
>  tests/qtest/libqtest.c          | 80 +++++++++++++++++++++++++----------------
>  tests/qtest/libqtest.h          | 19 +++++++++-
>  tests/qtest/migration-helpers.c | 19 +++++-----
>  tests/qtest/migration-test.c    |  4 +--
>  4 files changed, 80 insertions(+), 42 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 817fd7a..31c4032 100644
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
> @@ -442,18 +444,19 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
>      return s;
>  }
>  
> +static char *qtest_socket_path(const char *suffix)
> +{
> +    return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix);
> +}
> +
>  static QTestState *qtest_init_internal(const char *qemu_bin,
> -                                       const char *extra_args)
> +                                       const char *extra_args,
> +                                       bool defer_connect)

Suggest to stick with positive logic naming.

That is, s/defer_connect/do_connect/ or similar, then invert the values in
callers.

>  {
>      QTestState *s;
>      int sock, qmpsock, i;
> -    gchar *socket_path;
> -    gchar *qmp_socket_path;
> -
> -    socket_path = g_strdup_printf("%s/qtest-%d.sock",
> -                                  g_get_tmp_dir(), getpid());
> -    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
> -                                      g_get_tmp_dir(), getpid());
> +    g_autofree gchar *socket_path = qtest_socket_path("sock");
> +    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
>  
>      /*
>       * It's possible that if an earlier test run crashed it might
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

Now qtest_connect_deferred() itself has nothing to do with the "defer"
concept.. it is the helper to connect the sockets, so maybe better call it
qtest_connect_socks(), or similar.

> +    }
> +
>      /*
>       * Stopping QEMU for debugging is not supported on Windows.
>       *
> @@ -515,34 +513,54 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>      }
>  #endif
>  
> +   return s;
> +}
> +
> +void qtest_connect_deferred(QTestState *s)
> +{
> +    g_autofree gchar *socket_path = qtest_socket_path("sock");
> +    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
> +
> +    g_assert(s->sock >= 0 && s->qmpsock >= 0);
> +    s->fd = socket_accept(s->sock);
> +    if (s->fd >= 0) {
> +        s->qmp_fd = socket_accept(s->qmpsock);
> +    }
> +    unlink(socket_path);
> +    unlink(qmp_socket_path);
> +    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
> +    s->sock = s->qmpsock = -1;
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
> @@ -1523,7 +1541,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
>  
>      silence_spawn_log = !g_test_verbose();
>  
> -    qts = qtest_init_with_env(qemu_var, "-machine none");
> +    qts = qtest_init_with_env(qemu_var, "-machine none", false);
>      response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
>      g_assert(response);
>      list = qdict_get_qlist(response, "return");
> @@ -1578,7 +1596,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
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
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 3f8ba7f..9f39401 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -127,25 +127,28 @@ migrate_get_connect_qdict(QTestState *who)
>  
>  static void migrate_set_ports(QTestState *to, QList *channel_list)
>  {
> -    QDict *addr;
> +    g_autoptr(QDict) addr = NULL;
>      QListEntry *entry;
>      const char *addr_port = NULL;
>  
> -    addr = migrate_get_connect_qdict(to);
> -
>      QLIST_FOREACH_ENTRY(channel_list, entry) {
>          QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>          QDict *addrdict = qdict_get_qdict(channel, "addr");
>  
> -        if (qdict_haskey(addrdict, "port") &&
> -            qdict_haskey(addr, "port") &&
> -            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
> +        if (!qdict_haskey(addrdict, "port") ||
> +            strcmp(qdict_get_str(addrdict, "port"), "0")) {
> +            continue;
> +        }
> +
> +        if (!addr) {
> +            addr = migrate_get_connect_qdict(to);

May be good to add a comment above on why the query was done only lazily.

Meanwhile this chunk of change can be separate; it's relevant to the defer
idea but still pretty standalone change. Can be one small patch prior to
this one, IMHO.

Optional idea, can be for later: if QTestState can have the state showing
whether the QMP is ready, we could already assert making sure the query
happens only if the QMP is available.

> +        }
> +
> +        if (qdict_haskey(addr, "port")) {
>              addr_port = qdict_get_str(addr, "port");
>              qdict_put_str(addrdict, "port", addr_port);
>          }
>      }
> -
> -    qobject_unref(addr);
>  }
>  
>  bool migrate_watch_for_events(QTestState *who, const char *name,
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 64e1c50..b7001b0 100644
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
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


