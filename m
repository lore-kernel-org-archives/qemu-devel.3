Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C627DCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YVW-0003Cn-Li; Tue, 30 Sep 2025 07:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v3YVU-0003CS-Kp
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:26:56 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v3YVM-00069H-Tn
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:26:56 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-826311c1774so667920285a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759231603; x=1759836403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZOTJT4Sy4kcLwZ1nP2Dvjx7wPb7TEHnm6hx3fXOR4k=;
 b=QbCijv8WBpcRBVgvaYPpEVEnd3IR5sFMJfY1mz1JVTDfNsyxxAKu2642f5RHk8IGBI
 dSzrakCeWhAHGwANTYB1nJyRs/Y9bP2ctCnKGzfntEhtwr6Jkduk7Hr6eyvM5L3BJYpF
 AgQBaMPrMBwL1MDg0hpOJgbhu1cwDCjaAzYdxLETtNEBl1VrG6+3l1XlcN41WybuTQy5
 oi8MvuAMUsHUdPEWWuLWE9VG5TFOOvvX5x8nSUaJiDRLoLVTWO+dalGXnwcTZ/FENsVf
 eFwG5RdyJfvVQ9kIMX/Lf16bkYOdYA8825JvGmuKUngN64CX8eKKke6IOiCiLfVWI3rH
 VfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759231603; x=1759836403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZOTJT4Sy4kcLwZ1nP2Dvjx7wPb7TEHnm6hx3fXOR4k=;
 b=tuWitY/OkoBziGCmDC/MTtA/KCXmblGyXPfdurzFQpqsdcomdrBXcclGhyjn6/H3+u
 Bs4dHx4g8ySeh3TQD57cStHCZIzQGUo/VH2IApQ5fzRzOi7y9TvbeMM5lQsObl+7Cb/P
 icR3iUCkWCgYAIKuI8k43b4hnm7SsXcXvZx8AvbHkOmJ0CNdCes975QV5TAVkeDaNMDI
 T8EVIs68a4i4tk9ddxSFt23ogXaP1mVIio3fboFNpXM3Mk+5GSRlXCl6Be/GnqjPflK0
 LcJJpxfoJs/K0il4CjuzIKRC6gGSBKUoAINtvHq5I0JGXd9O4722PBA1LGcLnj/CdOSr
 nYNA==
X-Gm-Message-State: AOJu0YwtrmjkYRBsf2wSYNd+HfkEUNYxXR20ai9P1X0srKJkX3dKA7Zo
 GkaCMoe+mgB9qHQ/ME9M6D6BbJt6iJ10crYKnQHB53b3G0d9snH8T+btcM2dUdb6tYEf6+sq4Os
 U5l2mAewWYdq4D5O5A5rgzayaOmrzw9w=
X-Gm-Gg: ASbGncvFVz/3xi4HV0fFZNqqID0WUD4rFR3KI+bxuWo9QSmkhDVqSMNG1O0y6VVm5Gf
 4XkeE3OD+V+BPGk6fsh7BHnNo4zpKo+/6o16VHHxORXPtD3MrIIYGTrqMQIvIYe/YJLT+6REz8J
 3Usq4JF2aAT8NswuB7/IiJ41C2h6DrNxL7p/oGWmAusDxqzZBsS99xzYtRBiRKKKfoMzUsLxb1g
 W4eG/3F74J8SuNDW+y/r5V15wIWknyqT+zsOGh/gAw4JQQGOXjJwSL2J7FPwCf9NMVSvQGDGtE=
X-Google-Smtp-Source: AGHT+IEy2rMSmOsjKVMOnDrJtls25MsSnDa74GM8cniq8a3fmHTN4zKI78ow6P6/FvyP/CQ2k1UMed41Q1N1wrd+hyQ=
X-Received: by 2002:a05:620a:2902:b0:850:8afd:f715 with SMTP id
 af79cd13be357-85aeacb0648mr1876412485a.72.1759231603019; Tue, 30 Sep 2025
 04:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250930110834.2551757-1-berrange@redhat.com>
 <20250930110834.2551757-3-berrange@redhat.com>
In-Reply-To: <20250930110834.2551757-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Sep 2025 15:26:30 +0400
X-Gm-Features: AS18NWCVRgCBYF7MWa_mqcBp9bX4CWwQsf-BOzLwvINwVP5b810cKmPG5178054
Message-ID: <CAJ+F1CJsoevDyvzpfSpcTop06aUT_HQ9CFzdHAy0wKyMFuhbrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] io: fix use after free in websocket handshake code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Grant Millar | Cylo" <rid@cylo.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Tue, Sep 30, 2025 at 3:08=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> If the QIOChannelWebsock object is freed while it is waiting to
> complete a handshake, a GSource is leaked. This can lead to the
> callback firing later on and triggering a use-after-free in the
> use of the channel. This was observed in the VNC server with the
> following trace from valgrind:
>
> =3D=3D2523108=3D=3D Invalid read of size 4
> =3D=3D2523108=3D=3D    at 0x4054A24: vnc_disconnect_start (vnc.c:1296)
> =3D=3D2523108=3D=3D    by 0x4054A24: vnc_client_error (vnc.c:1392)
> =3D=3D2523108=3D=3D    by 0x4068A09: vncws_handshake_done (vnc-ws.c:105)
> =3D=3D2523108=3D=3D    by 0x44863B4: qio_task_complete (task.c:197)
> =3D=3D2523108=3D=3D    by 0x448343D: qio_channel_websock_handshake_io (ch=
annel-websock.c:588)
> =3D=3D2523108=3D=3D    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
> =3D=3D2523108=3D=3D    by 0x6EDB862: g_main_context_dispatch_unlocked.lto=
_priv.0 (gmain.c:4249)
> =3D=3D2523108=3D=3D    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:423=
7)
> =3D=3D2523108=3D=3D    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
> =3D=3D2523108=3D=3D    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:=
310)
> =3D=3D2523108=3D=3D    by 0x45EC79F: main_loop_wait (main-loop.c:589)
> =3D=3D2523108=3D=3D    by 0x423A56D: qemu_main_loop (runstate.c:835)
> =3D=3D2523108=3D=3D    by 0x454F300: qemu_default_main (main.c:37)
> =3D=3D2523108=3D=3D    by 0x73D6574: (below main) (libc_start_call_main.h=
:58)
> =3D=3D2523108=3D=3D  Address 0x57a6e0dc is 28 bytes inside a block of siz=
e 103,608 free'd
> =3D=3D2523108=3D=3D    at 0x5F2FE43: free (vg_replace_malloc.c:989)
> =3D=3D2523108=3D=3D    by 0x6EDC444: g_free (gmem.c:208)
> =3D=3D2523108=3D=3D    by 0x4053F23: vnc_update_client (vnc.c:1153)
> =3D=3D2523108=3D=3D    by 0x4053F23: vnc_refresh (vnc.c:3225)
> =3D=3D2523108=3D=3D    by 0x4042881: dpy_refresh (console.c:880)
> =3D=3D2523108=3D=3D    by 0x4042881: gui_update (console.c:90)
> =3D=3D2523108=3D=3D    by 0x45EFA1B: timerlist_run_timers.part.0 (qemu-ti=
mer.c:562)
> =3D=3D2523108=3D=3D    by 0x45EFC8F: timerlist_run_timers (qemu-timer.c:4=
95)
> =3D=3D2523108=3D=3D    by 0x45EFC8F: qemu_clock_run_timers (qemu-timer.c:=
576)
> =3D=3D2523108=3D=3D    by 0x45EFC8F: qemu_clock_run_all_timers (qemu-time=
r.c:663)
> =3D=3D2523108=3D=3D    by 0x45EC765: main_loop_wait (main-loop.c:600)
> =3D=3D2523108=3D=3D    by 0x423A56D: qemu_main_loop (runstate.c:835)
> =3D=3D2523108=3D=3D    by 0x454F300: qemu_default_main (main.c:37)
> =3D=3D2523108=3D=3D    by 0x73D6574: (below main) (libc_start_call_main.h=
:58)
> =3D=3D2523108=3D=3D  Block was alloc'd at
> =3D=3D2523108=3D=3D    at 0x5F343F3: calloc (vg_replace_malloc.c:1675)
> =3D=3D2523108=3D=3D    by 0x6EE2F81: g_malloc0 (gmem.c:133)
> =3D=3D2523108=3D=3D    by 0x4057DA3: vnc_connect (vnc.c:3245)
> =3D=3D2523108=3D=3D    by 0x448591B: qio_net_listener_channel_func (net-l=
istener.c:54)
> =3D=3D2523108=3D=3D    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
> =3D=3D2523108=3D=3D    by 0x6EDB862: g_main_context_dispatch_unlocked.lto=
_priv.0 (gmain.c:4249)
> =3D=3D2523108=3D=3D    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:423=
7)
> =3D=3D2523108=3D=3D    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
> =3D=3D2523108=3D=3D    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:=
310)
> =3D=3D2523108=3D=3D    by 0x45EC79F: main_loop_wait (main-loop.c:589)
> =3D=3D2523108=3D=3D    by 0x423A56D: qemu_main_loop (runstate.c:835)
> =3D=3D2523108=3D=3D    by 0x454F300: qemu_default_main (main.c:37)
> =3D=3D2523108=3D=3D    by 0x73D6574: (below main) (libc_start_call_main.h=
:58)
> =3D=3D2523108=3D=3D
>
> The above can be reproduced by launching QEMU with
>
>   $ qemu-system-x86_64 -vnc localhost:0,websocket=3D5700
>
> and then repeatedly running:
>
>   for i in {1..100}; do
>      (echo -n "GET / HTTP/1.1" && sleep 0.05) | nc -w 1 localhost 5700 &
>   done
>
> Reported-by: Grant Millar | Cylo <rid@cylo.io>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/io/channel-websock.h |  1 +
>  io/channel-websock.c         | 16 ++++++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
> index e180827c57..d1e760e449 100644
> --- a/include/io/channel-websock.h
> +++ b/include/io/channel-websock.h
> @@ -61,6 +61,7 @@ struct QIOChannelWebsock {
>      size_t payload_remain;
>      size_t pong_remain;
>      QIOChannelWebsockMask mask;
> +    guint hs_io_tag;
>      guint io_tag;

I think it's worth a comment on why it needs two tags, and how they
relate to each other.

>      Error *io_err;
>      gboolean io_eof;
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 56d53355d5..588c313dfb 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -597,7 +597,7 @@ static gboolean qio_channel_websock_handshake_io(QIOC=
hannel *ioc,
>      error_propagate(&wioc->io_err, err);
>
>      trace_qio_channel_websock_handshake_reply(ioc);
> -    qio_channel_add_watch(
> +    wioc->hs_io_tag =3D qio_channel_add_watch(
>          wioc->master,
>          G_IO_OUT,
>          qio_channel_websock_handshake_send,
> @@ -907,11 +907,12 @@ void qio_channel_websock_handshake(QIOChannelWebsoc=
k *ioc,
>
>      trace_qio_channel_websock_handshake_start(ioc);
>      trace_qio_channel_websock_handshake_pending(ioc, G_IO_IN);
> -    qio_channel_add_watch(ioc->master,
> -                          G_IO_IN,
> -                          qio_channel_websock_handshake_io,
> -                          task,
> -                          NULL);
> +    ioc->hs_io_tag =3D qio_channel_add_watch(
> +        ioc->master,
> +        G_IO_IN,
> +        qio_channel_websock_handshake_io,
> +        task,
> +        NULL);

There is still an untracked qio_channel_add_watch(). I suppose you
checked that, it could use a comment explaining why it's left.

>  }
>
>
> @@ -1212,6 +1213,9 @@ static int qio_channel_websock_close(QIOChannel *io=
c,
>      buffer_free(&wioc->encinput);
>      buffer_free(&wioc->encoutput);
>      buffer_free(&wioc->rawinput);
> +    if (wioc->hs_io_tag) {
> +        g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
> +    }
>      if (wioc->io_tag) {
>          g_clear_handle_id(&wioc->io_tag, g_source_remove);
>      }
> --
> 2.50.1
>


--=20
Marc-Andr=C3=A9 Lureau

