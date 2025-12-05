Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169E4D32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXVt-0007HU-MF; Fri, 05 Dec 2025 10:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXVr-0007GV-Nj
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXVm-0001kz-Vp
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764947662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kEHcnNaCRrzFKeWFky3wDC6u8Oa45qpcMvfxjvQtDH8=;
 b=ECfFjRpLCg13tlXwaCfC4Op7BHEhsxiZqMFU5znS6O7XVz5yrwYT7KIbVSfak5kuv+74Vu
 kIJEQ4sbgmKzCF3m5OmgpCzbG94W9vmWPmWF2uFEjmQu4f2dwpDnXPdDM650RtvRXhdwIc
 xsSILblhEekMPP/7LcSjJN4T/cUUDN0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-_SQQoA5NNeCNiphu2opwZg-1; Fri, 05 Dec 2025 10:14:18 -0500
X-MC-Unique: _SQQoA5NNeCNiphu2opwZg-1
X-Mimecast-MFC-AGG-ID: _SQQoA5NNeCNiphu2opwZg_1764947657
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-343bf6ded5cso3948995a91.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764947657; x=1765552457; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kEHcnNaCRrzFKeWFky3wDC6u8Oa45qpcMvfxjvQtDH8=;
 b=btK9DCe/YsvYLBa/9z2GqTJ1O1h/Yao8IORpnMa5Ztci5RzxWEC++ScAkW11Ws+DFu
 2KWEd18KKdRaEMZ8/Lx+WEXLLl5LoKqKNQVqieo0N93t8SZmuwnYbaEewhx91jdAirbo
 aai9dmeQH9vuTyL5PG0dCjB/v4iNwLKyO6CtI2qDtl86SzqVhdW0hKVjo/3CjZ95F4KD
 OwSaLJ4DZml6bx0Wvmi14R4A4/IJjgMlubpA75OGeD61wbPWjaH8N1IHEzmoTBIVzCrt
 kW0BQ3Bp50E/7ugcrBRqr1WHI4+xJpRTQnjQlSHx12Erw96axHqL6c0ptU6TfVNgEeHs
 hMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947657; x=1765552457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEHcnNaCRrzFKeWFky3wDC6u8Oa45qpcMvfxjvQtDH8=;
 b=ACCmeGPoyAbW2T1X6qJBQOasdKwdYSLI40dET4a951pWeUU0ew6v8h+F0Sn48ENa2r
 7UaLKxWsA2hlwh3xNI0IJQiFpwykvRfe5yIMVvbyb6ON3vkMxZr0og5WoALrISwKk0dv
 WjF/ljAlHEyZecXo7ofXjNAaZlFOk8qFZu9vGpzjcvUZkdZq+xvASrkTtQ+YF3m6r1J+
 r7yMCrDOlvj1YXa50Yxxwa68GD3En2K0aXFDfSQESY2iYGQ2rgLJSNgu03VSe+G2VIH0
 KHdd/BhgFjNDavtv96Nl/0zAYQtkN8ZT1Ko1h9E9baY6TsDmetHPV5zfwmzhauzZZ0Vk
 0m9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmP9cGJuIf/UQG/6/2Ym62v3zdumANJ2cdu3LmFj7RpnuaRr+TlTO3JIv/l6GLf7PPbqEyB+qvcudP@nongnu.org
X-Gm-Message-State: AOJu0YyUcUknUHBP3x5YAwRvst4ljS6iSHoy3vCbO0uHU1R09QmFGKDe
 Cz8kQ6KrPSNI/xxO3EAFfZJGLQya233c4xftTL7ciOFa4XSommkb8jfOImeSLU6FZsEol+1l+VD
 dtAoZEqDYqgDZHmh8Elds55nzvdimeiP9htOtQJqlJASI3D+zzbnhIjB2sWSLPvaal1h5aevUZu
 weskPGU8ltY8tOOijoe3mEIBAVwJ8U6iw=
X-Gm-Gg: ASbGncuN00Qd9tlFr3UrSfs4rN+GTL89SUx54thmxrfdA/yuinMoMSHxZT9gnRHdaNU
 2HhABCQ6NHiW1aGjhxQeSe4nJ0GD5u1FWNipsTAicDWN9BCgKriSZIEVfcwMvbqsHxd5JnFVoOv
 2xnSWc+HlzGw2nI3mmuJ1xJjwu8wpQr/UceVuV+PIIemPNeWbFb5rdXwUUt8dcWQuq0UqxaPlfD
 zLNIHavv/qxGtlNmiQhr/tsQw==
X-Received: by 2002:a17:90b:3851:b0:341:8b42:309e with SMTP id
 98e67ed59e1d1-349127febeemr11912718a91.31.1764947656859; 
 Fri, 05 Dec 2025 07:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgooPxuaZfRDbKbw4qp2W7jK4NX7+6Lt2lhKY8hIZ8WJpaF1XGykklWbFQ4ZMAsjYBNXHljvcaBJbbdGAsNRQ=
X-Received: by 2002:a17:90b:3851:b0:341:8b42:309e with SMTP id
 98e67ed59e1d1-349127febeemr11912692a91.31.1764947656373; Fri, 05 Dec 2025
 07:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-6-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-6-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:14:04 +0400
X-Gm-Features: AWmQ_bnNlG8L7jK6ucTFt6XTP0QfV9a9IoR_bR0rgLnt9Dl1kWre5IUxKAwd6L0
Message-ID: <CAMxuvayJ2149Ep8RZ07GMjtWwYKg9h6vwpGNUJVPmtwRQduJ3A@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] chardev: .chr_open(): drop be_opened parameter
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001b0c4e064535e6dd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000001b0c4e064535e6dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> The logic around the parameter is rather tricky. Let's instead
> explicitly send CHR_EVENT_OPENED in all backends where needed.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/baum.c           |  7 +++----
>  chardev/char-console.c   |  5 ++---
>  chardev/char-file.c      |  7 +++----
>  chardev/char-hub.c       | 11 +++++------
>  chardev/char-mux.c       | 19 +++++++++++--------
>  chardev/char-null.c      |  7 ++-----
>  chardev/char-parallel.c  | 15 ++++-----------
>  chardev/char-pipe.c      | 14 ++++++--------
>  chardev/char-pty.c       |  6 +-----
>  chardev/char-ringbuf.c   |  3 ++-
>  chardev/char-serial.c    | 18 +++++++++---------
>  chardev/char-socket.c    | 10 +++-------
>  chardev/char-stdio.c     |  7 +++----
>  chardev/char-udp.c       |  6 +-----
>  chardev/char-win-stdio.c |  2 +-
>  chardev/char.c           | 11 +++--------
>  chardev/msmouse.c        |  4 ++--
>  chardev/spice.c          | 10 ++--------
>  chardev/wctablet.c       |  5 ++---
>  gdbstub/system.c         |  5 ++---
>  include/chardev/char.h   |  3 +--
>  ui/console-vc.c          |  7 ++-----
>  ui/dbus-chardev.c        |  6 ++----
>  ui/gtk.c                 |  9 +++------
>  ui/spice-app.c           | 10 +++-------
>  ui/vdagent.c             |  3 +--
>  26 files changed, 79 insertions(+), 131 deletions(-)
>
> diff --git a/chardev/baum.c b/chardev/baum.c
> index 6b81c97d10..58b74dc98d 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -642,10 +642,7 @@ static void char_braille_finalize(Object *obj)
>      }
>  }
>
> -static void baum_chr_open(Chardev *chr,
> -                          ChardevBackend *backend,
> -                          bool *be_opened,
> -                          Error **errp)
> +static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      BaumChardev *baum =3D BAUM_CHARDEV(chr);
>      brlapi_handle_t *handle;
> @@ -670,6 +667,8 @@ static void baum_chr_open(Chardev *chr,
>       * as an integer, but in practice it seems to work
>       */
>      qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void char_braille_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-console.c b/chardev/char-console.c
> index f3ef1a7748..423f0f4cc4 100644
> --- a/chardev/char-console.c
> +++ b/chardev/char-console.c
> @@ -26,12 +26,11 @@
>  #include "chardev/char-win.h"
>  #include "qemu/module.h"
>
> -static void console_chr_open(Chardev *chr,
> -                             ChardevBackend *backend,
> -                             bool *be_opened,
> +static void console_chr_open(Chardev *chr, ChardevBackend *backend,
>                               Error **errp)
>  {
>      win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void char_console_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 568600bb7c..34ef386abc 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -34,10 +34,7 @@
>  #include "chardev/char-fd.h"
>  #endif
>
> -static void file_chr_open(Chardev *chr,
> -                          ChardevBackend *backend,
> -                          bool *be_opened,
> -                          Error **errp)
> +static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevFile *file =3D backend->u.file.data;
>  #ifdef _WIN32
> @@ -100,6 +97,8 @@ static void file_chr_open(Chardev *chr,
>          return;
>      }
>  #endif
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void file_chr_parse(QemuOpts *opts, ChardevBackend *backend,
> diff --git a/chardev/char-hub.c b/chardev/char-hub.c
> index 11556dfa72..aa6058c2f6 100644
> --- a/chardev/char-hub.c
> +++ b/chardev/char-hub.c
> @@ -203,10 +203,7 @@ static void hub_chr_update_read_handlers(Chardev *ch=
r)
>      }
>  }
>
> -static void hub_chr_open(Chardev *chr,
> -                         ChardevBackend *backend,
> -                         bool *be_opened,
> -                         Error **errp)
> +static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHub *hub =3D backend->u.hub.data;
>      HubChardev *d =3D HUB_CHARDEV(chr);
> @@ -241,8 +238,10 @@ static void hub_chr_open(Chardev *chr,
>          list =3D list->next;
>      }
>
> -    /* Closed until an explicit event from backend */
> -    *be_opened =3D false;
> +    /*
> +     * Closed until an explicit event from backend, so we don't
> +     * send CHR_EVENT_OPENED now.
> +     */
>  }
>
>  static void hub_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index f38d66b21f..7210df431f 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -361,10 +361,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
>      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
>  }
>
> -static void mux_chr_open(Chardev *chr,
> -                         ChardevBackend *backend,
> -                         bool *be_opened,
> -                         Error **errp)
> +static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevMux *mux =3D backend->u.mux.data;
>      Chardev *drv;
> @@ -377,11 +374,17 @@ static void mux_chr_open(Chardev *chr,
>      }
>
>      d->focus =3D -1;
> -    /* only default to opened state if we've realized the initial
> -     * set of muxes
> +    if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
> +        return;
> +    }
> +
> +    /*
> +     * Only move to opened state if we've realized
> +     * the initial set of muxes:
>       */
> -    *be_opened =3D muxes_opened;
> -    qemu_chr_fe_init(&d->chr, drv, errp);
> +    if (muxes_opened) {
> +        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    }
>  }
>
>  static void mux_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/chardev/char-null.c b/chardev/char-null.c
> index 674603b380..900b5febb6 100644
> --- a/chardev/char-null.c
> +++ b/chardev/char-null.c
> @@ -26,12 +26,9 @@
>  #include "chardev/char.h"
>  #include "qemu/module.h"
>
> -static void null_chr_open(Chardev *chr,
> -                          ChardevBackend *backend,
> -                          bool *be_opened,
> -                          Error **errp)
> +static void null_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
> -    *be_opened =3D false;
> +    /* do not send CHR_EVENT_OPENED */
>  }
>
>  static void char_null_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
> index 1be1ef4629..359efa3c9c 100644
> --- a/chardev/char-parallel.c
> +++ b/chardev/char-parallel.c
> @@ -157,10 +157,7 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd,
> void *arg)
>      return 0;
>  }
>
> -static void parallel_chr_open_fd(Chardev *chr,
> -                                int fd,
> -                                bool *be_opened,
> -                                Error **errp)
> +static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
>  {
>      ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
>
> @@ -172,6 +169,7 @@ static void parallel_chr_open_fd(Chardev *chr,
>      }
>
>      drv->mode =3D IEEE1284_MODE_COMPAT;
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>  #endif /* __linux__ */
>
> @@ -227,21 +225,16 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd=
,
> void *arg)
>      return 0;
>  }
>
> -static void parallel_chr_open_fd(Chardev *chr,
> -                                int fd,
> -                                bool *be_opened,
> -                                Error **errp)
> +static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
>  {
>      ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
>      drv->fd =3D fd;
> -    *be_opened =3D false;
>  }
>  #endif
>
>  #ifdef HAVE_CHARDEV_PARALLEL
>  static void parallel_chr_open(Chardev *chr,
>                                ChardevBackend *backend,
> -                              bool *be_opened,
>                                Error **errp)
>  {
>      ChardevHostdev *parallel =3D backend->u.parallel.data;
> @@ -251,7 +244,7 @@ static void parallel_chr_open(Chardev *chr,
>      if (fd < 0) {
>          return;
>      }
> -    parallel_chr_open_fd(chr, fd, be_opened, errp);
> +    parallel_chr_open_fd(chr, fd, errp);
>  }
>
>  static void parallel_chr_parse(QemuOpts *opts, ChardevBackend *backend,
> diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
> index e84492d42b..2f26372dfc 100644
> --- a/chardev/char-pipe.c
> +++ b/chardev/char-pipe.c
> @@ -103,10 +103,7 @@ static int win_chr_pipe_init(Chardev *chr, const cha=
r
> *filename,
>      return -1;
>  }
>
> -static void pipe_chr_open(Chardev *chr,
> -                          ChardevBackend *backend,
> -                          bool *be_opened,
> -                          Error **errp)
> +static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *opts =3D backend->u.pipe.data;
>      const char *filename =3D opts->device;
> @@ -114,14 +111,13 @@ static void pipe_chr_open(Chardev *chr,
>      if (win_chr_pipe_init(chr, filename, errp) < 0) {
>          return;
>      }
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  #else
>
> -static void pipe_chr_open(Chardev *chr,
> -                          ChardevBackend *backend,
> -                          bool *be_opened,
> -                          Error **errp)
> +static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *opts =3D backend->u.pipe.data;
>      int fd_in, fd_out;
> @@ -158,6 +154,8 @@ static void pipe_chr_open(Chardev *chr,
>          }
>          return;
>      }
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  #endif /* !_WIN32 */
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 909ab01f5f..d4d69a29a9 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -331,10 +331,7 @@ static int qemu_openpty_raw(int *aslave, char
> *pty_name)
>      return amaster;
>  }
>
> -static void pty_chr_open(Chardev *chr,
> -                         ChardevBackend *backend,
> -                         bool *be_opened,
> -                         Error **errp)
> +static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      PtyChardev *s;
>      int master_fd, slave_fd;
> @@ -364,7 +361,6 @@ static void pty_chr_open(Chardev *chr,
>      qio_channel_set_name(s->ioc, name);
>      g_free(name);
>      s->timer_src =3D NULL;
> -    *be_opened =3D false;
>
>      /* create symbolic link */
>      if (path) {
> diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
> index 19652fe2b3..30b17a96d3 100644
> --- a/chardev/char-ringbuf.c
> +++ b/chardev/char-ringbuf.c
> @@ -94,7 +94,6 @@ static void char_ringbuf_finalize(Object *obj)
>
>  static void ringbuf_chr_open(Chardev *chr,
>                               ChardevBackend *backend,
> -                             bool *be_opened,
>                               Error **errp)
>  {
>      ChardevRingbuf *opts =3D backend->u.ringbuf.data;
> @@ -111,6 +110,8 @@ static void ringbuf_chr_open(Chardev *chr,
>      d->prod =3D 0;
>      d->cons =3D 0;
>      d->cbuf =3D g_malloc0(d->size);
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  void qmp_ringbuf_write(const char *device, const char *data,
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 54c2b3935c..9995f18425 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -41,14 +41,15 @@
>
>  #ifdef _WIN32
>
> -static void serial_chr_open(Chardev *chr,
> -                            ChardevBackend *backend,
> -                            bool *be_opened,
> -                            Error **errp)
> +static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *serial =3D backend->u.serial.data;
> +    int ret =3D win_chr_serial_init(chr, serial->device, errp);
> +    if (ret < 0) {
> +        return;
> +    }
>
> -    win_chr_serial_init(chr, serial->device, errp);
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)
> \
> @@ -258,10 +259,7 @@ static int serial_chr_ioctl(Chardev *chr, int cmd,
> void *arg)
>      return 0;
>  }
>
> -static void serial_chr_open(Chardev *chr,
> -                            ChardevBackend *backend,
> -                            bool *be_opened,
> -                            Error **errp)
> +static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *serial =3D backend->u.serial.data;
>      int fd;
> @@ -281,6 +279,8 @@ static void serial_chr_open(Chardev *chr,
>          close(fd);
>          return;
>      }
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>  #endif /* __linux__ || __sun__ */
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 329cd9f0a8..3f57ef4016 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1365,10 +1365,7 @@ static bool
> qmp_chardev_validate_socket(ChardevSocket *sock,
>  }
>
>
> -static void tcp_chr_open(Chardev *chr,
> -                         ChardevBackend *backend,
> -                         bool *be_opened,
> -                         Error **errp)
> +static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      ChardevSocket *sock =3D backend->u.socket.data;
> @@ -1439,9 +1436,6 @@ static void tcp_chr_open(Chardev *chr,
>      }
>      s->registered_yank =3D true;
>
> -    /* be isn't opened until we get a connection */
> -    *be_opened =3D false;
> -
>      update_disconnected_filename(s);
>
>      if (s->is_listen) {
> @@ -1454,6 +1448,8 @@ static void tcp_chr_open(Chardev *chr,
>              return;
>          }
>      }
> +
> +    /* be isn't opened until we get a connection */
>  }
>
>  static void tcp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index f0920a23fa..534f6ed565 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -85,10 +85,7 @@ static void term_stdio_handler(int sig)
>      stdio_chr_set_echo(NULL, stdio_echo_state);
>  }
>
> -static void stdio_chr_open(Chardev *chr,
> -                           ChardevBackend *backend,
> -                           bool *be_opened,
> -                           Error **errp)
> +static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevStdio *opts =3D backend->u.stdio.data;
>      struct sigaction act;
> @@ -123,6 +120,8 @@ static void stdio_chr_open(Chardev *chr,
>
>      stdio_allow_signal =3D !opts->has_signal || opts->signal;
>      stdio_chr_set_echo(chr, false);
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>  #endif
>
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 099f76b8c2..b835a967e1 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -188,10 +188,7 @@ static void udp_chr_parse(QemuOpts *opts,
> ChardevBackend *backend, Error **errp)
>      }
>  }
>
> -static void upd_chr_open(Chardev *chr,
> -                         ChardevBackend *backend,
> -                         bool *be_opened,
> -                         Error **errp)
> +static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevUdp *udp =3D backend->u.udp.data;
>      SocketAddress *local_addr =3D socket_address_flatten(udp->local);
> @@ -215,7 +212,6 @@ static void upd_chr_open(Chardev *chr,
>
>      s->ioc =3D QIO_CHANNEL(sioc);
>      /* be isn't opened until we get a connection */
> -    *be_opened =3D false;
>  }
>
>  static void char_udp_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index 866f3a2039..0535960ff1 100644
> --- a/chardev/char-win-stdio.c
> +++ b/chardev/char-win-stdio.c
> @@ -144,7 +144,6 @@ static void win_stiod_chr_set_echo(Chardev *chr, bool
> echo)
>
>  static void win_stdio_chr_open(Chardev *chr,
>                                 ChardevBackend *backend,
> -                               bool *be_opened,
>                                 Error **errp)
>  {
>      ChardevStdio *opts =3D backend->u.stdio.data;
> @@ -208,6 +207,7 @@ static void win_stdio_chr_open(Chardev *chr,
>
>      win_stiod_chr_set_echo(chr, false);
>
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>      return;
>
>  err3:
> diff --git a/chardev/char.c b/chardev/char.c
> index df37d1df16..44bfed3627 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -246,8 +246,7 @@ int qemu_chr_add_client(Chardev *s, int fd)
>          CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
>  }
>
> -static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
> -                           bool *be_opened, Error **errp)
> +static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
>      /* Any ChardevCommon member would work */
> @@ -268,7 +267,7 @@ static void qemu_char_open(Chardev *chr,
> ChardevBackend *backend,
>      }
>
>      if (cc->chr_open) {
> -        cc->chr_open(chr, backend, be_opened, errp);
> +        cc->chr_open(chr, backend, errp);
>      }
>  }
>
> @@ -1009,7 +1008,6 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>      Object *obj;
>      Chardev *chr =3D NULL;
>      Error *local_err =3D NULL;
> -    bool be_opened =3D true;
>
>      assert(g_str_has_prefix(typename, "chardev-"));
>      assert(id);
> @@ -1020,7 +1018,7 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>      chr->label =3D g_strdup(id);
>      chr->gcontext =3D gcontext;
>
> -    qemu_char_open(chr, backend, &be_opened, &local_err);
> +    qemu_char_open(chr, backend, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          object_unref(obj);
> @@ -1030,9 +1028,6 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>      if (!chr->filename) {
>          chr->filename =3D g_strdup(typename + 8);
>      }
> -    if (be_opened) {
> -        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> -    }
>
>      return chr;
>  }
> diff --git a/chardev/msmouse.c b/chardev/msmouse.c
> index d07cd998cb..9dc04e3b3e 100644
> --- a/chardev/msmouse.c
> +++ b/chardev/msmouse.c
> @@ -255,16 +255,16 @@ static void char_msmouse_finalize(Object *obj)
>
>  static void msmouse_chr_open(Chardev *chr,
>                               ChardevBackend *backend,
> -                             bool *be_opened,
>                               Error **errp)
>  {
>      MouseChardev *mouse =3D MOUSE_CHARDEV(chr);
>
> -    *be_opened =3D false;
>      mouse->hs =3D qemu_input_handler_register((DeviceState *)mouse,
>                                              &msmouse_handler);
>      mouse->tiocm =3D 0;
>      fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
> +
> +    /* Never send CHR_EVENT_OPENED */
>  }
>
>  static void char_msmouse_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/spice.c b/chardev/spice.c
> index 3ea2570665..f5b1f585eb 100644
> --- a/chardev/spice.c
> +++ b/chardev/spice.c
> @@ -251,9 +251,7 @@ static void chr_open(Chardev *chr, const char *subtyp=
e)
>      s->sin.subtype =3D g_strdup(subtype);
>  }
>
> -static void spice_vmc_chr_open(Chardev *chr,
> -                               ChardevBackend *backend,
> -                               bool *be_opened,
> +static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
>                                 Error **errp)
>  {
>      ChardevSpiceChannel *spicevmc =3D backend->u.spicevmc.data;
> @@ -277,13 +275,10 @@ static void spice_vmc_chr_open(Chardev *chr,
>          return;
>      }
>
> -    *be_opened =3D false;
>      chr_open(chr, type);
>  }
>
> -static void spice_port_chr_open(Chardev *chr,
> -                                ChardevBackend *backend,
> -                                bool *be_opened,
> +static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
>                                  Error **errp)
>  {
>      ChardevSpicePort *spiceport =3D backend->u.spiceport.data;
> @@ -302,7 +297,6 @@ static void spice_port_chr_open(Chardev *chr,
>
>      chr_open(chr, "port");
>
> -    *be_opened =3D false;
>      s =3D SPICE_CHARDEV(chr);
>      s->sin.portname =3D g_strdup(name);
>
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 8285a56e7b..65b2ceb58c 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -326,13 +326,10 @@ static void wctablet_chr_finalize(Object *obj)
>
>  static void wctablet_chr_open(Chardev *chr,
>                                ChardevBackend *backend,
> -                              bool *be_opened,
>                                Error **errp)
>  {
>      TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
>
> -    *be_opened =3D true;
> -
>      /* init state machine */
>      memcpy(tablet->outbuf, WC_FULL_CONFIG_STRING,
> WC_FULL_CONFIG_STRING_LENGTH);
>      tablet->outlen =3D WC_FULL_CONFIG_STRING_LENGTH;
> @@ -340,6 +337,8 @@ static void wctablet_chr_open(Chardev *chr,
>
>      tablet->hs =3D qemu_input_handler_register((DeviceState *)tablet,
>                                               &wctablet_handler);
> +
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void wctablet_chr_class_init(ObjectClass *oc, const void *data)
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 61b2b4b8da..49da1f73cc 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -233,10 +233,9 @@ static int gdb_chr_write(Chardev *chr, const uint8_t
> *buf, int len)
>      return len;
>  }
>
> -static void gdb_chr_open(Chardev *chr, ChardevBackend *backend,
> -                             bool *be_opened, Error **errp)
> +static void gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
> -    *be_opened =3D false;
> +    /* Never send CHR_EVENT_OPENED */
>  }
>
>  static void char_gdb_class_init(ObjectClass *oc, const void *data)
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 2baf2a8a1a..47c75c3582 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -260,8 +260,7 @@ struct ChardevClass {
>      void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error
> **errp);
>
>      /* called after construction, open/starts the backend */
> -    void (*chr_open)(Chardev *chr, ChardevBackend *backend,
> -                 bool *be_opened, Error **errp);
> +    void (*chr_open)(Chardev *chr, ChardevBackend *backend, Error **errp=
);
>
>      /* write buf to the backend */
>      int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 931068d43a..4c8ea4c148 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -1093,10 +1093,7 @@ void qemu_text_console_update_size(QemuTextConsole
> *c)
>      dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
>  }
>
> -static void vc_chr_open(Chardev *chr,
> -                        ChardevBackend *backend,
> -                        bool *be_opened,
> -                        Error **errp)
> +static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevVC *vc =3D backend->u.vc.data;
>      VCChardev *drv =3D VC_CHARDEV(chr);
> @@ -1144,7 +1141,7 @@ static void vc_chr_open(Chardev *chr,
>          drv->t_attrib =3D TEXT_ATTRIBUTES_DEFAULT;
>      }
>
> -    *be_opened =3D true;
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
> index f6c426e220..3e471f84cd 100644
> --- a/ui/dbus-chardev.c
> +++ b/ui/dbus-chardev.c
> @@ -176,9 +176,7 @@ dbus_chr_send_break(
>      return DBUS_METHOD_INVOCATION_HANDLED;
>  }
>
> -static void
> -dbus_chr_open(Chardev *chr, ChardevBackend *backend,
> -              bool *be_opened, Error **errp)
> +static void dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ERRP_GUARD();
>
> @@ -211,7 +209,7 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
>          return;
>      }
>      CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
> -        chr, be, be_opened, errp);
> +        chr, be, errp);
>  }
>
>  static void
> diff --git a/ui/gtk.c b/ui/gtk.c
> index b5498a7ce3..3eeb5baa11 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1963,10 +1963,7 @@ static void gd_vc_chr_set_echo(Chardev *chr, bool
> echo)
>
>  static int nb_vcs;
>  static Chardev *vcs[MAX_VCS];
> -static void gd_vc_chr_open(Chardev *chr,
> -                       ChardevBackend *backend,
> -                       bool *be_opened,
> -                       Error **errp)
> +static void gd_vc_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      if (nb_vcs =3D=3D MAX_VCS) {
>          error_setg(errp, "Maximum number of consoles reached");
> @@ -1975,10 +1972,10 @@ static void gd_vc_chr_open(Chardev *chr,
>
>      vcs[nb_vcs++] =3D chr;
>
> -    /* console/chardev init sometimes completes elsewhere in a 2nd
> +    /*
> +     * console/chardev init sometimes completes elsewhere in a 2nd
>       * stage, so defer OPENED events until they are fully initialized
>       */
> -    *be_opened =3D false;
>  }
>
>  static void char_gd_vc_class_init(ObjectClass *oc, const void *data)
> diff --git a/ui/spice-app.c b/ui/spice-app.c
> index ea0b62a22b..7ac9ae4e78 100644
> --- a/ui/spice-app.c
> +++ b/ui/spice-app.c
> @@ -49,8 +49,7 @@ struct VCChardev {
>
>  struct VCChardevClass {
>      ChardevClass parent;
> -    void (*parent_open)(Chardev *chr, ChardevBackend *backend,
> -                        bool *be_opened, Error **errp);
> +    void (*parent_open)(Chardev *chr, ChardevBackend *backend, Error
> **errp);
>  };
>
>  #define TYPE_CHARDEV_VC "chardev-vc"
> @@ -67,10 +66,7 @@ chr_spice_backend_new(void)
>      return be;
>  }
>
> -static void vc_chr_open(Chardev *chr,
> -                        ChardevBackend *backend,
> -                        bool *be_opened,
> -                        Error **errp)
> +static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      VCChardevClass *vc =3D CHARDEV_VC_GET_CLASS(chr);
>      ChardevBackend *be;
> @@ -87,7 +83,7 @@ static void vc_chr_open(Chardev *chr,
>      be =3D chr_spice_backend_new();
>      be->u.spiceport.data->fqdn =3D fqdn ?
>          g_strdup(fqdn) : g_strdup_printf("org.qemu.console.%s",
> chr->label);
> -    vc->parent_open(chr, be, be_opened, errp);
> +    vc->parent_open(chr, be, errp);
>      qapi_free_ChardevBackend(be);
>  }
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 9972a9c476..3becc6c076 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -662,7 +662,6 @@ static void vdagent_chr_recv_clipboard(VDAgentChardev
> *vd, VDAgentMessage *msg)
>
>  static void vdagent_chr_open(Chardev *chr,
>                               ChardevBackend *backend,
> -                             bool *be_opened,
>                               Error **errp)
>  {
>      VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(chr);
> @@ -692,7 +691,7 @@ static void vdagent_chr_open(Chardev *chr,
>
> &vdagent_mouse_handler);
>      }
>
> -    *be_opened =3D true;
> +    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
>  static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
> --
> 2.48.1
>
>

--0000000000001b0c4e064535e6dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 20=
25 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vs=
ementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">The logic around the para=
meter is rather tricky. Let&#39;s instead<br>
explicitly send CHR_EVENT_OPENED in all backends where needed.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br></=
blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
---<br>
=C2=A0chardev/baum.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++-=
---<br>
=C2=A0chardev/char-console.c=C2=A0 =C2=A0|=C2=A0 5 ++---<br>
=C2=A0chardev/char-file.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +++----<br>
=C2=A0chardev/char-hub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++++------<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 +++++++++++--------=
<br>
=C2=A0chardev/char-null.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++-----<br>
=C2=A0chardev/char-parallel.c=C2=A0 | 15 ++++-----------<br>
=C2=A0chardev/char-pipe.c=C2=A0 =C2=A0 =C2=A0 | 14 ++++++--------<br>
=C2=A0chardev/char-pty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +-----<br>
=C2=A0chardev/char-ringbuf.c=C2=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0chardev/char-serial.c=C2=A0 =C2=A0 | 18 +++++++++---------<br>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 | 10 +++-------<br>
=C2=A0chardev/char-stdio.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++----<br>
=C2=A0chardev/char-udp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +-----<br>
=C2=A0chardev/char-win-stdio.c |=C2=A0 2 +-<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++------=
--<br>
=C2=A0chardev/msmouse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0chardev/spice.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++--------<br>
=C2=A0chardev/wctablet.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++---<br>
=C2=A0gdbstub/system.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++---<br>
=C2=A0include/chardev/char.h=C2=A0 =C2=A0|=C2=A0 3 +--<br>
=C2=A0ui/console-vc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++-----<b=
r>
=C2=A0ui/dbus-chardev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++----<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 9 +++------<br>
=C2=A0ui/spice-app.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++------=
-<br>
=C2=A0ui/vdagent.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3=
 +--<br>
=C2=A026 files changed, 79 insertions(+), 131 deletions(-)<br>
<br>
diff --git a/chardev/baum.c b/chardev/baum.c<br>
index 6b81c97d10..58b74dc98d 100644<br>
--- a/chardev/baum.c<br>
+++ b/chardev/baum.c<br>
@@ -642,10 +642,7 @@ static void char_braille_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void baum_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0BaumChardev *baum =3D BAUM_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0brlapi_handle_t *handle;<br>
@@ -670,6 +667,8 @@ static void baum_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 * as an integer, but in practice it seems to work<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0qemu_set_fd_handler(baum-&gt;brlapi_fd, baum_chr_read, =
NULL, baum);<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0static void char_braille_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/chardev/char-console.c b/chardev/char-console.c<br>
index f3ef1a7748..423f0f4cc4 100644<br>
--- a/chardev/char-console.c<br>
+++ b/chardev/char-console.c<br>
@@ -26,12 +26,11 @@<br>
=C2=A0#include &quot;chardev/char-win.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
<br>
-static void console_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
+static void console_chr_open(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), =
true);<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0static void char_console_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/chardev/char-file.c b/chardev/char-file.c<br>
index 568600bb7c..34ef386abc 100644<br>
--- a/chardev/char-file.c<br>
+++ b/chardev/char-file.c<br>
@@ -34,10 +34,7 @@<br>
=C2=A0#include &quot;chardev/char-fd.h&quot;<br>
=C2=A0#endif<br>
<br>
-static void file_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevFile *file =3D backend-&gt;u.file.data;<br>
=C2=A0#ifdef _WIN32<br>
@@ -100,6 +97,8 @@ static void file_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0static void file_chr_parse(QemuOpts *opts, ChardevBackend *backend,<b=
r>
diff --git a/chardev/char-hub.c b/chardev/char-hub.c<br>
index 11556dfa72..aa6058c2f6 100644<br>
--- a/chardev/char-hub.c<br>
+++ b/chardev/char-hub.c<br>
@@ -203,10 +203,7 @@ static void hub_chr_update_read_handlers(Chardev *chr)=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void hub_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
+static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHub *hub =3D backend-&gt;u.hub.data;<br>
=C2=A0 =C2=A0 =C2=A0HubChardev *d =3D HUB_CHARDEV(chr);<br>
@@ -241,8 +238,10 @@ static void hub_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list =3D list-&gt;next;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* Closed until an explicit event from backend */<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Closed until an explicit event from backend, so we d=
on&#39;t<br>
+=C2=A0 =C2=A0 =C2=A0* send CHR_EVENT_OPENED now.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0}<br>
<br>
=C2=A0static void hub_chr_parse(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
index f38d66b21f..7210df431f 100644<br>
--- a/chardev/char-mux.c<br>
+++ b/chardev/char-mux.c<br>
@@ -361,10 +361,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)<b=
r>
=C2=A0 =C2=A0 =C2=A0mux_chr_send_event(d, d-&gt;focus, CHR_EVENT_MUX_IN);<b=
r>
=C2=A0}<br>
<br>
-static void mux_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
+static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevMux *mux =3D backend-&gt;u.mux.data;<br>
=C2=A0 =C2=A0 =C2=A0Chardev *drv;<br>
@@ -377,11 +374,17 @@ static void mux_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;focus =3D -1;<br>
-=C2=A0 =C2=A0 /* only default to opened state if we&#39;ve realized the in=
itial<br>
-=C2=A0 =C2=A0 =C2=A0* set of muxes<br>
+=C2=A0 =C2=A0 if (!qemu_chr_fe_init(&amp;d-&gt;chr, drv, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Only move to opened state if we&#39;ve realized<br>
+=C2=A0 =C2=A0 =C2=A0* the initial set of muxes:<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 *be_opened =3D muxes_opened;<br>
-=C2=A0 =C2=A0 qemu_chr_fe_init(&amp;d-&gt;chr, drv, errp);<br>
+=C2=A0 =C2=A0 if (muxes_opened) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void mux_chr_parse(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)<br>
diff --git a/chardev/char-null.c b/chardev/char-null.c<br>
index 674603b380..900b5febb6 100644<br>
--- a/chardev/char-null.c<br>
+++ b/chardev/char-null.c<br>
@@ -26,12 +26,9 @@<br>
=C2=A0#include &quot;chardev/char.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
<br>
-static void null_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void null_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
+=C2=A0 =C2=A0 /* do not send CHR_EVENT_OPENED */<br>
=C2=A0}<br>
<br>
=C2=A0static void char_null_class_init(ObjectClass *oc, const void *data)<b=
r>
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c<br>
index 1be1ef4629..359efa3c9c 100644<br>
--- a/chardev/char-parallel.c<br>
+++ b/chardev/char-parallel.c<br>
@@ -157,10 +157,7 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, v=
oid *arg)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static void parallel_chr_open_fd(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);<br>
<br>
@@ -172,6 +169,7 @@ static void parallel_chr_open_fd(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0drv-&gt;mode =3D IEEE1284_MODE_COMPAT;<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
=C2=A0#endif /* __linux__ */<br>
<br>
@@ -227,21 +225,16 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, =
void *arg)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static void parallel_chr_open_fd(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0drv-&gt;fd =3D fd;<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifdef HAVE_CHARDEV_PARALLEL<br>
=C2=A0static void parallel_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *parallel =3D backend-&gt;u.parallel.dat=
a;<br>
@@ -251,7 +244,7 @@ static void parallel_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 parallel_chr_open_fd(chr, fd, be_opened, errp);<br>
+=C2=A0 =C2=A0 parallel_chr_open_fd(chr, fd, errp);<br>
=C2=A0}<br>
<br>
=C2=A0static void parallel_chr_parse(QemuOpts *opts, ChardevBackend *backen=
d,<br>
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c<br>
index e84492d42b..2f26372dfc 100644<br>
--- a/chardev/char-pipe.c<br>
+++ b/chardev/char-pipe.c<br>
@@ -103,10 +103,7 @@ static int win_chr_pipe_init(Chardev *chr, const char =
*filename,<br>
=C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0}<br>
<br>
-static void pipe_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *opts =3D backend-&gt;u.pipe.data;<br>
=C2=A0 =C2=A0 =C2=A0const char *filename =3D opts-&gt;device;<br>
@@ -114,14 +111,13 @@ static void pipe_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0if (win_chr_pipe_init(chr, filename, errp) &lt; 0) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0#else<br>
<br>
-static void pipe_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *opts =3D backend-&gt;u.pipe.data;<br>
=C2=A0 =C2=A0 =C2=A0int fd_in, fd_out;<br>
@@ -158,6 +154,8 @@ static void pipe_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0#endif /* !_WIN32 */<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index 909ab01f5f..d4d69a29a9 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -331,10 +331,7 @@ static int qemu_openpty_raw(int *aslave, char *pty_nam=
e)<br>
=C2=A0 =C2=A0 =C2=A0return amaster;<br>
=C2=A0}<br>
<br>
-static void pty_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
+static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PtyChardev *s;<br>
=C2=A0 =C2=A0 =C2=A0int master_fd, slave_fd;<br>
@@ -364,7 +361,6 @@ static void pty_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0qio_channel_set_name(s-&gt;ioc, name);<br>
=C2=A0 =C2=A0 =C2=A0g_free(name);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;timer_src =3D NULL;<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* create symbolic link */<br>
=C2=A0 =C2=A0 =C2=A0if (path) {<br>
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c<br>
index 19652fe2b3..30b17a96d3 100644<br>
--- a/chardev/char-ringbuf.c<br>
+++ b/chardev/char-ringbuf.c<br>
@@ -94,7 +94,6 @@ static void char_ringbuf_finalize(Object *obj)<br>
<br>
=C2=A0static void ringbuf_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevRingbuf *opts =3D backend-&gt;u.ringbuf.data;<br=
>
@@ -111,6 +110,8 @@ static void ringbuf_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;prod =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;cons =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;cbuf =3D g_malloc0(d-&gt;size);<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0void qmp_ringbuf_write(const char *device, const char *data,<br>
diff --git a/chardev/char-serial.c b/chardev/char-serial.c<br>
index 54c2b3935c..9995f18425 100644<br>
--- a/chardev/char-serial.c<br>
+++ b/chardev/char-serial.c<br>
@@ -41,14 +41,15 @@<br>
<br>
=C2=A0#ifdef _WIN32<br>
<br>
-static void serial_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error *=
*errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *serial =3D backend-&gt;u.serial.data;<b=
r>
+=C2=A0 =C2=A0 int ret =3D win_chr_serial_init(chr, serial-&gt;device, errp=
);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 win_chr_serial_init(chr, serial-&gt;device, errp);<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)=
=C2=A0 =C2=A0 =C2=A0 \<br>
@@ -258,10 +259,7 @@ static int serial_chr_ioctl(Chardev *chr, int cmd, voi=
d *arg)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static void serial_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error *=
*errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *serial =3D backend-&gt;u.serial.data;<b=
r>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
@@ -281,6 +279,8 @@ static void serial_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
=C2=A0#endif /* __linux__ || __sun__ */<br>
<br>
diff --git a/chardev/char-socket.c b/chardev/char-socket.c<br>
index 329cd9f0a8..3f57ef4016 100644<br>
--- a/chardev/char-socket.c<br>
+++ b/chardev/char-socket.c<br>
@@ -1365,10 +1365,7 @@ static bool qmp_chardev_validate_socket(ChardevSocke=
t *sock,<br>
=C2=A0}<br>
<br>
<br>
-static void tcp_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
+static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SocketChardev *s =3D SOCKET_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0ChardevSocket *sock =3D backend-&gt;u.socket.data;<br>
@@ -1439,9 +1436,6 @@ static void tcp_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;registered_yank =3D true;<br>
<br>
-=C2=A0 =C2=A0 /* be isn&#39;t opened until we get a connection */<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0update_disconnected_filename(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;is_listen) {<br>
@@ -1454,6 +1448,8 @@ static void tcp_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 /* be isn&#39;t opened until we get a connection */<br>
=C2=A0}<br>
<br>
=C2=A0static void tcp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)<br>
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c<br>
index f0920a23fa..534f6ed565 100644<br>
--- a/chardev/char-stdio.c<br>
+++ b/chardev/char-stdio.c<br>
@@ -85,10 +85,7 @@ static void term_stdio_handler(int sig)<br>
=C2=A0 =C2=A0 =C2=A0stdio_chr_set_echo(NULL, stdio_echo_state);<br>
=C2=A0}<br>
<br>
-static void stdio_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevStdio *opts =3D backend-&gt;u.stdio.data;<br>
=C2=A0 =C2=A0 =C2=A0struct sigaction act;<br>
@@ -123,6 +120,8 @@ static void stdio_chr_open(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0stdio_allow_signal =3D !opts-&gt;has_signal || opts-&gt=
;signal;<br>
=C2=A0 =C2=A0 =C2=A0stdio_chr_set_echo(chr, false);<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
diff --git a/chardev/char-udp.c b/chardev/char-udp.c<br>
index 099f76b8c2..b835a967e1 100644<br>
--- a/chardev/char-udp.c<br>
+++ b/chardev/char-udp.c<br>
@@ -188,10 +188,7 @@ static void udp_chr_parse(QemuOpts *opts, ChardevBacke=
nd *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void upd_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
+static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevUdp *udp =3D backend-&gt;u.udp.data;<br>
=C2=A0 =C2=A0 =C2=A0SocketAddress *local_addr =3D socket_address_flatten(ud=
p-&gt;local);<br>
@@ -215,7 +212,6 @@ static void upd_chr_open(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;ioc =3D QIO_CHANNEL(sioc);<br>
=C2=A0 =C2=A0 =C2=A0/* be isn&#39;t opened until we get a connection */<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_udp_class_init(ObjectClass *oc, const void *data)<br=
>
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c<br>
index 866f3a2039..0535960ff1 100644<br>
--- a/chardev/char-win-stdio.c<br>
+++ b/chardev/char-win-stdio.c<br>
@@ -144,7 +144,6 @@ static void win_stiod_chr_set_echo(Chardev *chr, bool e=
cho)<br>
<br>
=C2=A0static void win_stdio_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevStdio *opts =3D backend-&gt;u.stdio.data;<br>
@@ -208,6 +207,7 @@ static void win_stdio_chr_open(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0win_stiod_chr_set_echo(chr, false);<br>
<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
<br>
=C2=A0err3:<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index df37d1df16..44bfed3627 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -246,8 +246,7 @@ int qemu_chr_add_client(Chardev *s, int fd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CHARDEV_GET_CLASS(s)-&gt;chr_add_client(s=
, fd) : -1;<br>
=C2=A0}<br>
<br>
-static void qemu_char_open(Chardev *chr, ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened, Error **errp)<br>
+static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
=C2=A0 =C2=A0 =C2=A0/* Any ChardevCommon member would work */<br>
@@ -268,7 +267,7 @@ static void qemu_char_open(Chardev *chr, ChardevBackend=
 *backend,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (cc-&gt;chr_open) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;chr_open(chr, backend, be_opened, errp)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;chr_open(chr, backend, errp);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -1009,7 +1008,6 @@ static Chardev *chardev_new(const char *id, const cha=
r *typename,<br>
=C2=A0 =C2=A0 =C2=A0Object *obj;<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 bool be_opened =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(g_str_has_prefix(typename, &quot;chardev-&quot;)=
);<br>
=C2=A0 =C2=A0 =C2=A0assert(id);<br>
@@ -1020,7 +1018,7 @@ static Chardev *chardev_new(const char *id, const cha=
r *typename,<br>
=C2=A0 =C2=A0 =C2=A0chr-&gt;label =3D g_strdup(id);<br>
=C2=A0 =C2=A0 =C2=A0chr-&gt;gcontext =3D gcontext;<br>
<br>
-=C2=A0 =C2=A0 qemu_char_open(chr, backend, &amp;be_opened, &amp;local_err)=
;<br>
+=C2=A0 =C2=A0 qemu_char_open(chr, backend, &amp;local_err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_unref(obj);<br>
@@ -1030,9 +1028,6 @@ static Chardev *chardev_new(const char *id, const cha=
r *typename,<br>
=C2=A0 =C2=A0 =C2=A0if (!chr-&gt;filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr-&gt;filename =3D g_strdup(typename + =
8);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (be_opened) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
-=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return chr;<br>
=C2=A0}<br>
diff --git a/chardev/msmouse.c b/chardev/msmouse.c<br>
index d07cd998cb..9dc04e3b3e 100644<br>
--- a/chardev/msmouse.c<br>
+++ b/chardev/msmouse.c<br>
@@ -255,16 +255,16 @@ static void char_msmouse_finalize(Object *obj)<br>
<br>
=C2=A0static void msmouse_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MouseChardev *mouse =3D MOUSE_CHARDEV(chr);<br>
<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
=C2=A0 =C2=A0 =C2=A0mouse-&gt;hs =3D qemu_input_handler_register((DeviceSta=
te *)mouse,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;msmouse_handler);<br>
=C2=A0 =C2=A0 =C2=A0mouse-&gt;tiocm =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0fifo8_create(&amp;mouse-&gt;outbuf, MSMOUSE_BUF_SZ);<br=
>
+<br>
+=C2=A0 =C2=A0 /* Never send CHR_EVENT_OPENED */<br>
=C2=A0}<br>
<br>
=C2=A0static void char_msmouse_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/chardev/spice.c b/chardev/spice.c<br>
index 3ea2570665..f5b1f585eb 100644<br>
--- a/chardev/spice.c<br>
+++ b/chardev/spice.c<br>
@@ -251,9 +251,7 @@ static void chr_open(Chardev *chr, const char *subtype)=
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;sin.subtype =3D g_strdup(subtype);<br>
=C2=A0}<br>
<br>
-static void spice_vmc_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
+static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevSpiceChannel *spicevmc =3D backend-&gt;u.spicevm=
c.data;<br>
@@ -277,13 +275,10 @@ static void spice_vmc_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
=C2=A0 =C2=A0 =C2=A0chr_open(chr, type);<br>
=C2=A0}<br>
<br>
-static void spice_port_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
+static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevSpicePort *spiceport =3D backend-&gt;u.spiceport=
.data;<br>
@@ -302,7 +297,6 @@ static void spice_port_chr_open(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0chr_open(chr, &quot;port&quot;);<br>
<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
=C2=A0 =C2=A0 =C2=A0s =3D SPICE_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;sin.portname =3D g_strdup(name);<br>
<br>
diff --git a/chardev/wctablet.c b/chardev/wctablet.c<br>
index 8285a56e7b..65b2ceb58c 100644<br>
--- a/chardev/wctablet.c<br>
+++ b/chardev/wctablet.c<br>
@@ -326,13 +326,10 @@ static void wctablet_chr_finalize(Object *obj)<br>
<br>
=C2=A0static void wctablet_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);<br>
<br>
-=C2=A0 =C2=A0 *be_opened =3D true;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* init state machine */<br>
=C2=A0 =C2=A0 =C2=A0memcpy(tablet-&gt;outbuf, WC_FULL_CONFIG_STRING, WC_FUL=
L_CONFIG_STRING_LENGTH);<br>
=C2=A0 =C2=A0 =C2=A0tablet-&gt;outlen =3D WC_FULL_CONFIG_STRING_LENGTH;<br>
@@ -340,6 +337,8 @@ static void wctablet_chr_open(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0tablet-&gt;hs =3D qemu_input_handler_register((DeviceSt=
ate *)tablet,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;wctablet_handler);<br>
+<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0static void wctablet_chr_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/gdbstub/system.c b/gdbstub/system.c<br>
index 61b2b4b8da..49da1f73cc 100644<br>
--- a/gdbstub/system.c<br>
+++ b/gdbstub/system.c<br>
@@ -233,10 +233,9 @@ static int gdb_chr_write(Chardev *chr, const uint8_t *=
buf, int len)<br>
=C2=A0 =C2=A0 =C2=A0return len;<br>
=C2=A0}<br>
<br>
-static void gdb_chr_open(Chardev *chr, ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened, Error **errp)<br>
+static void gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
+=C2=A0 =C2=A0 /* Never send CHR_EVENT_OPENED */<br>
=C2=A0}<br>
<br>
=C2=A0static void char_gdb_class_init(ObjectClass *oc, const void *data)<br=
>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index 2baf2a8a1a..47c75c3582 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -260,8 +260,7 @@ struct ChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0void (*chr_parse)(QemuOpts *opts, ChardevBackend *backe=
nd, Error **errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* called after construction, open/starts the backend *=
/<br>
-=C2=A0 =C2=A0 void (*chr_open)(Chardev *chr, ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_ope=
ned, Error **errp);<br>
+=C2=A0 =C2=A0 void (*chr_open)(Chardev *chr, ChardevBackend *backend, Erro=
r **errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* write buf to the backend */<br>
=C2=A0 =C2=A0 =C2=A0int (*chr_write)(Chardev *s, const uint8_t *buf, int le=
n);<br>
diff --git a/ui/console-vc.c b/ui/console-vc.c<br>
index 931068d43a..4c8ea4c148 100644<br>
--- a/ui/console-vc.c<br>
+++ b/ui/console-vc.c<br>
@@ -1093,10 +1093,7 @@ void qemu_text_console_update_size(QemuTextConsole *=
c)<br>
=C2=A0 =C2=A0 =C2=A0dpy_text_resize(QEMU_CONSOLE(c), c-&gt;width, c-&gt;hei=
ght);<br>
=C2=A0}<br>
<br>
-static void vc_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Error **errp)<br>
+static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **err=
p)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevVC *vc =3D backend-&gt;u.vc.data;<br>
=C2=A0 =C2=A0 =C2=A0VCChardev *drv =3D VC_CHARDEV(chr);<br>
@@ -1144,7 +1141,7 @@ static void vc_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drv-&gt;t_attrib =3D TEXT_ATTRIBUTES_DEFA=
ULT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 *be_opened =3D true;<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Err=
or **errp)<br>
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c<br>
index f6c426e220..3e471f84cd 100644<br>
--- a/ui/dbus-chardev.c<br>
+++ b/ui/dbus-chardev.c<br>
@@ -176,9 +176,7 @@ dbus_chr_send_break(<br>
=C2=A0 =C2=A0 =C2=A0return DBUS_METHOD_INVOCATION_HANDLED;<br>
=C2=A0}<br>
<br>
-static void<br>
-dbus_chr_open(Chardev *chr, ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened, Error **=
errp)<br>
+static void dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ERRP_GUARD();<br>
<br>
@@ -211,7 +209,7 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET)=
)-&gt;chr_open(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr, be, be_opened, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr, be, errp);<br>
=C2=A0}<br>
<br>
=C2=A0static void<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index b5498a7ce3..3eeb5baa11 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -1963,10 +1963,7 @@ static void gd_vc_chr_set_echo(Chardev *chr, bool ec=
ho)<br>
<br>
=C2=A0static int nb_vcs;<br>
=C2=A0static Chardev *vcs[MAX_VCS];<br>
-static void gd_vc_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Error **errp)<br>
+static void gd_vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (nb_vcs =3D=3D MAX_VCS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Maximum number of =
consoles reached&quot;);<br>
@@ -1975,10 +1972,10 @@ static void gd_vc_chr_open(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0vcs[nb_vcs++] =3D chr;<br>
<br>
-=C2=A0 =C2=A0 /* console/chardev init sometimes completes elsewhere in a 2=
nd<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* console/chardev init sometimes completes elsewhere i=
n a 2nd<br>
=C2=A0 =C2=A0 =C2=A0 * stage, so defer OPENED events until they are fully i=
nitialized<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 *be_opened =3D false;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_gd_vc_class_init(ObjectClass *oc, const void *data)<=
br>
diff --git a/ui/spice-app.c b/ui/spice-app.c<br>
index ea0b62a22b..7ac9ae4e78 100644<br>
--- a/ui/spice-app.c<br>
+++ b/ui/spice-app.c<br>
@@ -49,8 +49,7 @@ struct VCChardev {<br>
<br>
=C2=A0struct VCChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass parent;<br>
-=C2=A0 =C2=A0 void (*parent_open)(Chardev *chr, ChardevBackend *backend,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool *be_opened, Error **errp);<br>
+=C2=A0 =C2=A0 void (*parent_open)(Chardev *chr, ChardevBackend *backend, E=
rror **errp);<br>
=C2=A0};<br>
<br>
=C2=A0#define TYPE_CHARDEV_VC &quot;chardev-vc&quot;<br>
@@ -67,10 +66,7 @@ chr_spice_backend_new(void)<br>
=C2=A0 =C2=A0 =C2=A0return be;<br>
=C2=A0}<br>
<br>
-static void vc_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool *be_opened,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Error **errp)<br>
+static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **err=
p)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VCChardevClass *vc =3D CHARDEV_VC_GET_CLASS(chr);<br>
=C2=A0 =C2=A0 =C2=A0ChardevBackend *be;<br>
@@ -87,7 +83,7 @@ static void vc_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0be =3D chr_spice_backend_new();<br>
=C2=A0 =C2=A0 =C2=A0be-&gt;u.spiceport.data-&gt;fqdn =3D fqdn ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_strdup(fqdn) : g_strdup_printf(&quot;or=
g.qemu.console.%s&quot;, chr-&gt;label);<br>
-=C2=A0 =C2=A0 vc-&gt;parent_open(chr, be, be_opened, errp);<br>
+=C2=A0 =C2=A0 vc-&gt;parent_open(chr, be, errp);<br>
=C2=A0 =C2=A0 =C2=A0qapi_free_ChardevBackend(be);<br>
=C2=A0}<br>
<br>
diff --git a/ui/vdagent.c b/ui/vdagent.c<br>
index 9972a9c476..3becc6c076 100644<br>
--- a/ui/vdagent.c<br>
+++ b/ui/vdagent.c<br>
@@ -662,7 +662,6 @@ static void vdagent_chr_recv_clipboard(VDAgentChardev *=
vd, VDAgentMessage *msg)<br>
<br>
=C2=A0static void vdagent_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(chr);<br>
@@ -692,7 +691,7 @@ static void vdagent_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vdagent_mouse_handler);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 *be_opened =3D true;<br>
+=C2=A0 =C2=A0 qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
=C2=A0}<br>
<br>
=C2=A0static void vdagent_clipboard_peer_register(VDAgentChardev *vd)<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--0000000000001b0c4e064535e6dd--


