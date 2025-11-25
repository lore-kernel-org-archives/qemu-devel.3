Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B9CCFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNn5n-00025K-Sh; Tue, 25 Nov 2025 02:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vNn5l-00024n-5t
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:04:01 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vNn5i-00015m-7N
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:04:00 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4ee13dc0c52so43187851cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 23:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764054220; x=1764659020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=berJkX7Ks7V2R4zpnleMwaSVgi48yUZkj7u3iTGJl98=;
 b=SV5yg+RhVdykT3Ls5WAQrnM6MRFceFdcG0QjiE+I9O6grtl/KmDO4IhMZ1uHKTeGGd
 77K+z3mx9H/nWOCc2JKQlq2Tp8JTuCDoKsl/4VGjTn54l8IhM/POh1K4mY/BvRMHQT9n
 KtPZNlWbnqxf806JvFO5+0jODXQuF08dUiIeHecUCNpocvJRREBrj01HU/J0iyBVgKwl
 HKmDcjiIBN0aoOzM+Lflyer+Ka6lCfjamTZVKRXpqzw5EC0pczbquoH5FcRK7nZyervJ
 Iuht1UXUcmICg4claXwawPkoXFkIIZ/QaBfWFcfb64TT26Jf1iUFQPvJkNfS2MAzmRSE
 N7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764054220; x=1764659020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=berJkX7Ks7V2R4zpnleMwaSVgi48yUZkj7u3iTGJl98=;
 b=VpldAJz/TmA9AAiEaBIfeD99hphRFl6FzR++eR5/+ZZzR+oT+OavqysT0579FoqFIU
 NId4sPfsv8dn+Y8bjELm9qn4NO/PZL44VeTAWCqAWP/J/EyPmnGQ0MIALShnh3iw55I9
 qVdIeA9i4bHaTBs7AwO6/Q1R2kkl5J3ztpzE/erKJ3bMdg8+nEi5MrhDwHhGJWursPm4
 Swe7Gxv+pnmundLnIFvl1Sm2EXhUxify1xSq7fApdSAvmilrfq8h+O/HMhorT0bBKQTI
 mQFPgyB+nm3F4EpT0L9cEdTHVFwsuILKN5eIs8zbsr9C/dTCoZZB69wdVZwHAAfJ/+ej
 D7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwjBiwjU0goubImYYEcF9MKPUKWQblWRf/+ULMZBKzn7D5v1cl9sjYcHuaYfNaaXtu8jTaNmXyy8Oa@nongnu.org
X-Gm-Message-State: AOJu0YxJCrd4LEvQMHS+B66kKCMGk/2KS1CWynBgY/YNk9fpsMGUW7bK
 P/ng8LNYSVFMWh7mVACacEXC+5jDM5pbq3a/fdbqg51rLx/5VBC5VpKQ9aa6KbktjBtJzo5AVHO
 kwYbo6Z9E7vztBwAruu8XHkSe0hGUdcE=
X-Gm-Gg: ASbGncubl7k7W3LXDici1uiX/b2TEcoaiZGCNAUsjj66tsLg5i9T1D38v6HwuvS1ku7
 NK00ngHTkNh62TFAX0cMlgn06cyqTf1+u04qW/zvwAvazGrDJge8qvia46wJZCHzyjpE0HoVleF
 uHM10Voi6M8Hik1yIFlvh7Rz9Ov0EjASjZBMfueYaLhTh19yjorfTzoMAcLoyIYh6mJ7HkS1eG5
 Razs2UWMsd6WUMi+fmVSUAE13/WlBugrT+fq1rSafbA9x2xVeVKTck7AapPJL1Y6mucGifsx4h9
 BQ==
X-Google-Smtp-Source: AGHT+IGDw13c/vpMkhzV5zMmI8jHvQSj+nK8LdxdKUi/+dwpaWrdOgDZ0ggax1ygCrAt1lM3Qsewn3fTorOeaozzhNg=
X-Received: by 2002:a05:622a:315:b0:4ed:eb6:6f29 with SMTP id
 d75a77b69052e-4ee58afffa6mr167199351cf.43.1764054219726; Mon, 24 Nov 2025
 23:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20251122014656.297693-1-mail@jiesong.me>
In-Reply-To: <20251122014656.297693-1-mail@jiesong.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Nov 2025 11:03:28 +0400
X-Gm-Features: AWmQ_bncLCzWw-iA4vTASe-4TQp-zJUOwpW5iKH1GEH7zxGxKXrTcHBaA9g2-iY
Message-ID: <CAJ+F1CK0=wvghRSkQkHQ+EvQ7a6RDU+SNkyqHXpeG8=PFmoDUQ@mail.gmail.com>
Subject: Re: [PATCH v3] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
To: Jie Song <mail@jiesong.me>
Cc: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, songjie_yewu@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Nov 22, 2025 at 7:33=E2=80=AFAM Jie Song <mail@jiesong.me> wrote:
>
> From: Jie Song <songjie_yewu@cmss.chinamobile.com>
>
> When starting a dummy QEMU process with virsh version, monitor_init_qmp()
> enables IOThread monitoring of the QMP fd by default. However, a race
> condition exists during the initialization phase: the IOThread only remov=
es
> the main thread's fd watch when it reaches qio_net_listener_set_client_fu=
nc_full(),
> which may be delayed under high system load.
>
> This creates a window between monitor_qmp_setup_handlers_bh() and
> qio_net_listener_set_client_func_full() where both the main thread and
> IOThread are simultaneously monitoring the same fd and processing events.
> This race can cause either the main thread or the IOThread to hang and
> become unresponsive.
>
> Fix this by proactively cleaning up the listener's IO sources in
> monitor_init_qmp() before the IOThread initializes QMP monitoring,
> ensuring exclusive fd ownership and eliminating the race condition.
>
> Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> ---
> Changes in v3:
> - Use a more general method to fix the problem.
> - Link to v2:
>   https://lore.kernel.org/qemu-devel/20251117150142.131694-1-mail@jiesong=
.me/
> - Link to v1:
>   https://lore.kernel.org/qemu-devel/20251111150144.76751-1-mail@jiesong.=
me/
> ---
>  chardev/char-io.c         | 8 ++++++++
>  chardev/char-socket.c     | 9 +++++++++
>  include/chardev/char-io.h | 2 ++
>  include/chardev/char.h    | 2 ++
>  monitor/qmp.c             | 5 +++++
>  5 files changed, 26 insertions(+)
>
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index 3be17b51ca..998282e526 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -182,3 +182,11 @@ int io_channel_send(QIOChannel *ioc, const void *buf=
, size_t len)
>  {
>      return io_channel_send_full(ioc, buf, len, NULL, 0);
>  }
> +
> +void remove_listaner_fd_in_watch(Chardev *chr)

listaner -> listener

> +{
> +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +    if (cc->chr_listener_cleanup) {
> +        cc->chr_listener_cleanup(chr);
> +    }
> +}
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 26d2f11202..39b3a76638 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1570,6 +1570,14 @@ char_socket_get_connected(Object *obj, Error **err=
p)
>      return s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
>  }
>
> +static void tcp_chr_listener_cleanup(Chardev *chr)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +    if (s->listener)
> +        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
> +                                              NULL, chr->gcontext);
> +}
> +
>  static void char_socket_class_init(ObjectClass *oc, const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> @@ -1587,6 +1595,7 @@ static void char_socket_class_init(ObjectClass *oc,=
 const void *data)
>      cc->chr_add_client =3D tcp_chr_add_client;
>      cc->chr_add_watch =3D tcp_chr_add_watch;
>      cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
> +    cc->chr_listener_cleanup =3D tcp_chr_listener_cleanup;
>
>      object_class_property_add(oc, "addr", "SocketAddress",
>                                char_socket_get_addr, NULL,
> diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
> index ac379ea70e..087a250c70 100644
> --- a/include/chardev/char-io.h
> +++ b/include/chardev/char-io.h
> @@ -43,4 +43,6 @@ int io_channel_send(QIOChannel *ioc, const void *buf, s=
ize_t len);
>  int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
>                           int *fds, size_t nfds);
>
> +void remove_listaner_fd_in_watch(Chardev *chr);
> +
>  #endif /* CHAR_IO_H */
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index b65e9981c1..192cad67d4 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -307,6 +307,8 @@ struct ChardevClass {
>
>      /* handle various events */
>      void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
> +
> +    void (*chr_listener_cleanup)(Chardev *chr);
>  };
>
>  Chardev *qemu_chardev_new(const char *id, const char *typename,
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index cb99a12d94..e2b1c49ed6 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -537,6 +537,11 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Err=
or **errp)
>           * e.g. the chardev is in client mode, with wait=3Don.
>           */
>          remove_fd_in_watch(chr);
> +        /*
> +         * Clean up listener IO sources early to prevent racy fd
> +         * handling between the main thread and the I/O thread.
> +         */
> +        remove_listaner_fd_in_watch(chr);
>          /*
>           * We can't call qemu_chr_fe_set_handlers() directly here
>           * since chardev might be running in the monitor I/O
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

