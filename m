Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6E2C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBwZs-00008K-RZ; Mon, 05 May 2025 10:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uBwZq-00007p-Qp
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:13:50 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uBwZn-0008NO-Sc
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:13:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 421FE2117F;
 Mon,  5 May 2025 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746454423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YERdr5J2Q39zYuuXbzjTl7U2XM5u/ImyKuzyjwq26g=;
 b=pv/7yKbltj9ZVTFvCPpTm2uldlkctqsdW5rILMSmF9abPTcqWVsqEsv3BxhXHwrkOkIQZr
 DFD+LXp4PEUkDtCTcMf+YFrUvl0LWoANG3PaKIMs7tQ+0ukZeJp+Hx7FburAF9imyuWPDh
 q1+vLWlv/w5SdIpce8Jh6GIO4H7vX+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746454423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YERdr5J2Q39zYuuXbzjTl7U2XM5u/ImyKuzyjwq26g=;
 b=lJXZGghUN10VwU1rXr665VfwLClMsb2GOyl37umGkRRi4NoKdINpi7zdJJgMB5aVmTGkTO
 GBEJ7jGcRCbNiXCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746454423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YERdr5J2Q39zYuuXbzjTl7U2XM5u/ImyKuzyjwq26g=;
 b=pv/7yKbltj9ZVTFvCPpTm2uldlkctqsdW5rILMSmF9abPTcqWVsqEsv3BxhXHwrkOkIQZr
 DFD+LXp4PEUkDtCTcMf+YFrUvl0LWoANG3PaKIMs7tQ+0ukZeJp+Hx7FburAF9imyuWPDh
 q1+vLWlv/w5SdIpce8Jh6GIO4H7vX+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746454423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YERdr5J2Q39zYuuXbzjTl7U2XM5u/ImyKuzyjwq26g=;
 b=lJXZGghUN10VwU1rXr665VfwLClMsb2GOyl37umGkRRi4NoKdINpi7zdJJgMB5aVmTGkTO
 GBEJ7jGcRCbNiXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1FF513883;
 Mon,  5 May 2025 14:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zIHbHJbHGGgFQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 May 2025 14:13:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, lvivier@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH] [for-10.1] qtest: introduce qtest_init_ext
In-Reply-To: <20250410162250.329941-1-vsementsov@yandex-team.ru>
References: <20250410162250.329941-1-vsementsov@yandex-team.ru>
Date: Mon, 05 May 2025 11:13:39 -0300
Message-ID: <87a57rgn70.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Merge qtest_init_with_env_and_capabilities() and qtest_init_with_env()
> into one qtest_init_ext().
>
> Reasons:
>
> 1. qtest_init_with_env() is just wrong: it gets do_connect parameter
>    but always pass true to qtest_init_with_env_and_capabilities().
>    Happily, all qtest_init_with_env() callers pass true as well.
>
> 2. qtest_init_with_env() is not used outside of libqtest.c, so no
>    reason to keep it as public function
>
> 3. and in libqtest.c it's used not often, so no problem to use
>    more generic function instead.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/qtest/libqtest.c            | 18 +++++-------------
>  tests/qtest/libqtest.h            | 30 +++++++-----------------------
>  tests/qtest/migration/framework.c |  7 +++----
>  3 files changed, 15 insertions(+), 40 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index fad307d125..66ff318201 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -574,10 +574,8 @@ void qtest_qmp_handshake(QTestState *s, QList *capabilities)
>      }
>  }
>  
> -QTestState *qtest_init_with_env_and_capabilities(const char *var,
> -                                                 const char *extra_args,
> -                                                 QList *capabilities,
> -                                                 bool do_connect)
> +QTestState *qtest_init_ext(const char *var, const char *extra_args,
> +                           QList *capabilities, bool do_connect)
>  {
>      QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
>                                          do_connect);
> @@ -594,15 +592,9 @@ QTestState *qtest_init_with_env_and_capabilities(const char *var,
>      return s;
>  }
>  
> -QTestState *qtest_init_with_env(const char *var, const char *extra_args,
> -                                bool do_connect)
> -{
> -    return qtest_init_with_env_and_capabilities(var, extra_args, NULL, true);
> -}
> -
>  QTestState *qtest_init(const char *extra_args)
>  {
> -    return qtest_init_with_env(NULL, extra_args, true);
> +    return qtest_init_ext(NULL, extra_args, NULL, true);
>  }
>  
>  QTestState *qtest_vinitf(const char *fmt, va_list ap)
> @@ -1662,7 +1654,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
>  
>      silence_spawn_log = !g_test_verbose();
>  
> -    qts = qtest_init_with_env(qemu_var, "-machine none", true);
> +    qts = qtest_init_ext(qemu_var, "-machine none", NULL, true);
>      response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
>      g_assert(response);
>      list = qdict_get_qlist(response, "return");
> @@ -1717,7 +1709,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
>  
>      silence_spawn_log = !g_test_verbose();
>  
> -    qts = qtest_init_with_env(NULL, "-machine none", true);
> +    qts = qtest_init_ext(NULL, "-machine none", NULL, true);
>      response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
>      g_assert(response);
>      list = qdict_get_qlist(response, "return");
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 930a91dcb7..b3f2e7fbef 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -57,37 +57,21 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
>  QTestState *qtest_init(const char *extra_args);
>  
>  /**
> - * qtest_init_with_env:
> - * @var: Environment variable from where to take the QEMU binary
> - * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
> - * arguments are subject to word splitting and shell evaluation.
> - * @do_connect: connect to qemu monitor and qtest socket.
> - *
> - * Like qtest_init(), but use a different environment variable for the
> - * QEMU binary.
> - *
> - * Returns: #QTestState instance.
> - */
> -QTestState *qtest_init_with_env(const char *var, const char *extra_args,
> -                                bool do_connect);
> -
> -/**
> - * qtest_init_with_env_and_capabilities:
> + * qtest_init_ext:
>   * @var: Environment variable from where to take the QEMU binary
>   * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
>   * arguments are subject to word splitting and shell evaluation.
>   * @capabilities: list of QMP capabilities (strings) to enable
>   * @do_connect: connect to qemu monitor and qtest socket.
>   *
> - * Like qtest_init_with_env(), but enable specified capabilities during
> - * hadshake.
> + * Like qtest_init(), but use a different environment variable for the
> + * QEMU binary, allow specify capabilities and skip connecting
> + * to QEMU monitor.
>   *
>   * Returns: #QTestState instance.
>   */
> -QTestState *qtest_init_with_env_and_capabilities(const char *var,
> -                                                 const char *extra_args,
> -                                                 QList *capabilities,
> -                                                 bool do_connect);
> +QTestState *qtest_init_ext(const char *var, const char *extra_args,
> +                           QList *capabilities, bool do_connect);
>  
>  /**
>   * qtest_init_without_qmp_handshake:
> @@ -102,7 +86,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>   * qtest_connect
>   * @s: #QTestState instance to connect
>   * Connect to qemu monitor and qtest socket, after skipping them in
> - * qtest_init_with_env.  Does not handshake with the monitor.
> + * qtest_init_ext.  Does not handshake with the monitor.
>   */
>  void qtest_connect(QTestState *s);
>  
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 10e1d04b58..1802304e1d 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -336,8 +336,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                                   args->opts_source ? args->opts_source : "",
>                                   ignore_stderr);
>      if (!args->only_target) {
> -        *from = qtest_init_with_env_and_capabilities(QEMU_ENV_SRC, cmd_source,
> -                                                     capabilities, true);
> +        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
>          qtest_qmp_set_event_callback(*from,
>                                       migrate_watch_for_events,
>                                       &src_state);
> @@ -365,8 +364,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                                   shmem_opts ? shmem_opts : "",
>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr);
> -    *to = qtest_init_with_env_and_capabilities(QEMU_ENV_DST, cmd_target,
> -                                               capabilities, !args->defer_target_connect);
> +    *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
> +                         !args->defer_target_connect);
>      qtest_qmp_set_event_callback(*to,
>                                   migrate_watch_for_events,
>                                   &dst_state);

Queued, thanks.

