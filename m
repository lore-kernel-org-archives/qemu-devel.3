Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3A6CFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmwa-00039H-4F; Tue, 25 Nov 2025 01:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vNmwS-000334-LC
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:54:25 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vNmwQ-0007K0-Ox
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:54:24 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4edb6e678ddso63032761cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764053661; x=1764658461; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZLQL2bA8jn9Qduuiac1hxh0vAa9HJ2dKsvIUUF9UcE=;
 b=KOZUlm9eQJ4wVDtdjYHr8lhyCnIfJHFDTVJIgRp4NfBgs+UAbr1ICg4AtvhR+aw6la
 JhKbZNORd/T+0QAt4IKrAJ5rJl2CLOfy7/1Ttf+uBikfm0vB31TWI4gXOrKXmXSDQUcG
 Qs6oZoYI6uP8mvCQ3HScRfQ8ByShmEyQZV55s5eKPfLEZ3d+PeXSq2ypM3AFo9ykzLC6
 vwOBpAT+JcBOX97f3ATUyyxAISo9FvDoGLDETUlwj3B8pbXAPkf5dBSVQb130806YSm1
 hdP1VobgsnRmp7R1l/DFof6R/oSTzyRB7YiUguAZZ1WPM5NNI5JmeHB+wInYh8jxwjmg
 7iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764053661; x=1764658461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OZLQL2bA8jn9Qduuiac1hxh0vAa9HJ2dKsvIUUF9UcE=;
 b=lz8zCNbaoeH/KsGOXMhWnyMkdPUWboaEqp5w1l0YqC3SffVn4c0Zhot7w1WX7ScGpO
 a3a1X+RWUw7RckXhVGqNk/MSkMloJIkUs7uwO9lPQce8jw7rjHVv11f3RhP0P2ZwgyqZ
 tre/RtKCx2s3HZOBktiYjxv8tId4PMRUFScdK09zj2ONP6uKKr3Z69OqgaEPgsVXqGst
 ECviuNeUGomx1SZxQZYvjAjsml9pL73LFrP6yU9j4oMDzrc0qBFa2TmhSijUlS4QY8aq
 XoTRaUwOpZuOQIbG+iVULzg8v5zYOfcIhOjEijmXONbYm8KeEZZPI53uZoD1A8gYrEIL
 vnfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/7XgNGZgw00GLNxyXOX5lplbQCfRcVRABSzcQmvBwg7AbV6/zmFwB58Tx/5lDA4qpRKNC9lOXTRgC@nongnu.org
X-Gm-Message-State: AOJu0Yw/MeAWwK4oP0rwEynwSH+zgYhVN9tEsLRL/KE+eMax5gnGZl4M
 W0yiEu9PhMaq2umSLjqeo2FTInOpcyOWMQ0Xa24JHkDLh5pEsuZ4Ti1KU0Rq8j/Oi81o53RgnB6
 HQwHtz9FfLskiG5uuKk1joLogq/B+5bg=
X-Gm-Gg: ASbGncuI13VP6q1Br0fhR5SO2a4x0fmRMo2lRsSL/edLVYH/VUP8msOhUT26Y+tNH9V
 s4k9t0QVOC1drkgHZFkxK5rNyjRX2Sz6Ejwf39GDhVGStJct6ev9j3FLsoeARtw2/Sv0WmRs5FE
 hfk7jH6lPro5rnyS3JhRqUnTsmVt9OqFvzEt7xjPtSJP0fThVZS2A8GoEnZzeJgK6iC7NAPUMeb
 07j8r2rWjV+V8nwrtlpGObGGnaw8nvij+dqmUPpn63opp3gLM/7DnlGifHwvPcaFcMsFJAGYM42
 eme0XOx67ab8
X-Google-Smtp-Source: AGHT+IFZQBUWoANL2UauASwBpdcOaANBtVQa9ULDAjh88sx/OOMEiyRQ8BKPUK7NSkMzjxUippcHJrO0CgWncNKEUnA=
X-Received: by 2002:a05:622a:1386:b0:4ed:542:bb38 with SMTP id
 d75a77b69052e-4ee58af89e4mr218402131cf.74.1764053660688; Mon, 24 Nov 2025
 22:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20251122014656.297693-1-mail@jiesong.me>
In-Reply-To: <20251122014656.297693-1-mail@jiesong.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Nov 2025 10:54:09 +0400
X-Gm-Features: AWmQ_bn8VIo6VFx8Xqb8Fq5xT6zQy4pFQKNXfKFiAE-EG6uRvvUPIDlczItHZpY
Message-ID: <CAJ+F1CLhRbqLzaXcm9XizpJgNgwX2Dy0L34aKLSRUrxCOHQSgA@mail.gmail.com>
Subject: Re: [PATCH v3] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
To: Jie Song <mail@jiesong.me>
Cc: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, songjie_yewu@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

Hi

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

Ok, but do you have a backtrace of a hang to share?

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
> +{
> +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +    if (cc->chr_listener_cleanup) {
> +        cc->chr_listener_cleanup(chr);
> +    }
> +}

I wonder if this code shouldn't just be added to remove_fd_in_watch()
instead. It would need careful review of all existing users,
nevermind.

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

Add braces

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

otherwise, looks ok to me
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

