Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F22C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuxY-00036x-HP; Wed, 06 Mar 2024 12:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1rhuxS-0002vX-KH
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:21:36 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1rhuxO-0002J8-G5
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:21:33 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so6045644a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1709745682; x=1710350482; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsKaXF6T5lctqg+Z+tqPG0l0FMUSQCzD4kDFkhOcA1c=;
 b=EXS2hI+HgYgWA2No8ishCRxRSN4SybPZ3JwGeB+G02F6SCAKJxF4LpzG09HaTHLCbc
 KvZiGIwVgIfEVJ+i7gW6RhBuvt6Z4jXLcdyAojoV4c24ks6SeqPrkJCDM/EIH2RLeKKx
 VjqXexSv5OzpjHFXT8Cf2gSQri4Dy+pUidqhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745682; x=1710350482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsKaXF6T5lctqg+Z+tqPG0l0FMUSQCzD4kDFkhOcA1c=;
 b=hqv08xz1gj8slXLh8IMrHJr/yzvF+KY/500a9o7MobmnePXVbosjvKEGvISfnwqLFK
 1rdIZa+Udd8QAoN5duS1tll2j/2oP6LDCdE/05TcK/seCwj7UHUwbYaolsO/lE5Wm8DW
 DK/kO64j1uqxoOuyw1vgs+KkC3Rg1ElwDooVMqoLenr+ZUDW9qgtM9Z8a7H5unL3JESi
 JPpEujJ+iZe4S+2VvswSxMIlCMPtykiClmhrJhHYsD4rLpdaTAM7mqPJILUXihr0fFaz
 GGwUi/2E0qkT93TU+3r2pQF/TT0nziP2nOxAtEBu9ZIDp0tGFAqKboFpNq0YydCTOlgV
 bpBw==
X-Gm-Message-State: AOJu0YzSP/3Pqge92WALK8huGP2l+5RVMf4gzpXGek/CNdi/msWKmtGt
 ew0CNCsr5hbetBCiJYf9DEf1doe4s7MPS34otV+CXr8wQMVsTov1PPL16sbkQmbf5RWAxGT06oe
 Eb9C26/BJrJsR9w7CZEfigxjWIYDgGIERCq3pFuWfyxpCc7S3XQ==
X-Google-Smtp-Source: AGHT+IG0Fe6HcRJ5aDPmKh9ZZHK23qhHejwA4K8v5I++vsoJWhUGwTXQZCEGevBFM5VgKdkFSSC2EmDT0tnkXZwoR4M=
X-Received: by 2002:a17:90a:7563:b0:299:41de:9fea with SMTP id
 q90-20020a17090a756300b0029941de9feamr12825105pjk.15.1709745682441; Wed, 06
 Mar 2024 09:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20240212114541.1440728-1-ross.lagerwall@citrix.com>
In-Reply-To: <20240212114541.1440728-1-ross.lagerwall@citrix.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 6 Mar 2024 17:21:10 +0000
Message-ID: <CAG7k0EprxAGBY6BA3oanN=THCsT-SYZmFNURnFeDbYTcJOXTEQ@mail.gmail.com>
Subject: Re: [PATCH] main-loop: Avoid some unnecessary poll calls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=ross.lagerwall@cloud.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 12, 2024 at 11:45=E2=80=AFAM Ross Lagerwall
<ross.lagerwall@citrix.com> wrote:
>
> A common pattern is seen where a timer fires, the callback does some
> work, then rearms the timer which implicitly calls qemu_notify_event().
>
> qemu_notify_event() is supposed to interrupt the main loop's poll() by
> calling qemu_bh_schedule(). In the case that this is being called from a
> main loop callback, the main loop is already not waiting on poll() and
> instead it means the main loop does an addition iteration with a timeout
> of 0 to handle the bottom half wakeup, before once again polling with
> the expected timeout value.
>
> Detect this situation by skipping the qemu_bh_schedule() call if the
> default main context is currently owned by the caller. i.e. it is being
> called as part of a poll / timer callback. Adjust the scope of the main
> context acquire / release to cover the timer callbacks in
> qemu_clock_run_all_timers().
>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  util/main-loop.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/util/main-loop.c b/util/main-loop.c
> index a0386cfeb60c..a2afbb7d0e13 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -145,10 +145,16 @@ AioContext *qemu_get_aio_context(void)
>
>  void qemu_notify_event(void)
>  {
> +    GMainContext *context;
> +
>      if (!qemu_aio_context) {
>          return;
>      }
> -    qemu_bh_schedule(qemu_notify_bh);
> +
> +    context =3D g_main_context_default();
> +    if (!g_main_context_is_owner(context)) {
> +        qemu_bh_schedule(qemu_notify_bh);
> +    }
>  }
>
>  static GArray *gpollfds;
> @@ -292,11 +298,8 @@ static void glib_pollfds_poll(void)
>
>  static int os_host_main_loop_wait(int64_t timeout)
>  {
> -    GMainContext *context =3D g_main_context_default();
>      int ret;
>
> -    g_main_context_acquire(context);
> -
>      glib_pollfds_fill(&timeout);
>
>      bql_unlock();
> @@ -309,8 +312,6 @@ static int os_host_main_loop_wait(int64_t timeout)
>
>      glib_pollfds_poll();
>
> -    g_main_context_release(context);
> -
>      return ret;
>  }
>  #else
> @@ -470,15 +471,12 @@ static int os_host_main_loop_wait(int64_t timeout)
>      fd_set rfds, wfds, xfds;
>      int nfds;
>
> -    g_main_context_acquire(context);
> -
>      /* XXX: need to suppress polling by better using win32 events */
>      ret =3D 0;
>      for (pe =3D first_polling_entry; pe !=3D NULL; pe =3D pe->next) {
>          ret |=3D pe->func(pe->opaque);
>      }
>      if (ret !=3D 0) {
> -        g_main_context_release(context);
>          return ret;
>      }
>
> @@ -538,8 +536,6 @@ static int os_host_main_loop_wait(int64_t timeout)
>          g_main_context_dispatch(context);
>      }
>
> -    g_main_context_release(context);
> -
>      return select_ret || g_poll_ret;
>  }
>  #endif
> @@ -559,6 +555,7 @@ void main_loop_poll_remove_notifier(Notifier *notify)
>
>  void main_loop_wait(int nonblocking)
>  {
> +    GMainContext *context =3D g_main_context_default();
>      MainLoopPoll mlpoll =3D {
>          .state =3D MAIN_LOOP_POLL_FILL,
>          .timeout =3D UINT32_MAX,
> @@ -586,7 +583,10 @@ void main_loop_wait(int nonblocking)
>                                        timerlistgroup_deadline_ns(
>                                            &main_loop_tlg));
>
> +    g_main_context_acquire(context);
> +
>      ret =3D os_host_main_loop_wait(timeout_ns);
> +
>      mlpoll.state =3D ret < 0 ? MAIN_LOOP_POLL_ERR : MAIN_LOOP_POLL_OK;
>      notifier_list_notify(&main_loop_poll_notifiers, &mlpoll);
>
> @@ -598,6 +598,8 @@ void main_loop_wait(int nonblocking)
>          icount_start_warp_timer();
>      }
>      qemu_clock_run_all_timers();
> +
> +    g_main_context_release(context);
>  }
>
>  /* Functions to operate on the main QEMU AioContext.  */
> --
> 2.43.0
>

Ping?

Ross

