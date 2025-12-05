Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73722D33980
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXZx-0000b5-GP; Fri, 05 Dec 2025 10:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXZw-0000ar-9J
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXZq-0002iI-Ka
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764947913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDLYF5jHNMRRC9xOhhI+oTS2Xc7+Q3dWZXrNVUibJiU=;
 b=XUQFUA71icCD1YK8IE0xdaCM1OwUYhn7stG/Xts/XjqpxwIUjjZj9JBQsE+rYleNF5zFW+
 nAiIa0W3d26CoLOi9jUCZ0X7veefuFb8Fa8yeH1paC3qPl74lcEYmW22jY9Dz5DEoIplmd
 Gxn7M8LTCkr/8EkVH6gH2TNVSHl6zyg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-j2-LDm2PMrOO2vZ2OADT0Q-1; Fri, 05 Dec 2025 10:18:31 -0500
X-MC-Unique: j2-LDm2PMrOO2vZ2OADT0Q-1
X-Mimecast-MFC-AGG-ID: j2-LDm2PMrOO2vZ2OADT0Q_1764947911
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-340bc4ef67fso2531861a91.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764947910; x=1765552710; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDLYF5jHNMRRC9xOhhI+oTS2Xc7+Q3dWZXrNVUibJiU=;
 b=ovRhrBNBx1CuBY2KK9moyi3oyHIcbEfOs6IJV7joAifczJv+n/fF7qG2KDl+pO6zWu
 U/tRt9veNq8B5B95ml2pABopuLZUyJ1qpIz7AqAeY+Kigx2gHvJQm+6/IiYEkC3CraYa
 9hcoCIfg0xLnA7KvmkfH1N9NI4c8Xq+D5D4E8M3jLmJb/t3v+deGbEUGQM3cJp4Td0Oe
 3WQ2lqZ+ODXjFliFw0CR5Qnb6dQzutzaJizPc7qIQO7jY6WL/oZBLYcJ4kJw91na2kEb
 RO1cpueki4Uj3mtp8mKjKiugO0+CdlA1uGtqzf2IXZffZDAjO9f5hhqnaRgcMPyowlOo
 JzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947910; x=1765552710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDLYF5jHNMRRC9xOhhI+oTS2Xc7+Q3dWZXrNVUibJiU=;
 b=oM+P9uPn5Rd5BKM6do887USPfyVy13v3gYsFsqAEr0PqFbMuf/SRGAWWq8AaFj8FY8
 WYrU2hxNyWJ5VbABJhVQ5tyL1YpLuLRfKRjoHqqPHrOq/mR5ZIibfw8pVWEnFweRa2K4
 TaXDsguX++i9QDJLwabYmWvbADLHTBvig94Brlz6cax4+x4qYqhtr/o9s1b0+p+UzquI
 wp0jH1RIBrhvcUF1tCrEHbI1Nc/HPPe52Dy3K8wYr4AXFNcPAS5wZSxIThNaI2Ph8xpW
 lWr2WiGKoYzQfzwX3yn1j94TnqDVH7Tl+c7rYeHngc+ytY0+WVwTwxqydaQhfwvpzLeY
 CqVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvrbwC3MQDZyYlzK+mkPDIZhR1Bqz0jABt9AVRNL8o9MzW+1MOZGsE1A2um8u543oJS8kPq9nWsTPy@nongnu.org
X-Gm-Message-State: AOJu0YyAu3vcpcteub5+lqxuJ31AwhUBVokVgcYgvdvAMqpOuxGFPrxs
 7kOdT86nMWbAvtOBw5fawSHI/aOz7GmVy0ieiPQ4ja062spFLytoIZbxbjvhy7XkyZP1PCF5kQX
 i0BBVusJU8MYTiwpqZD0EjGanWPNtmpy8NtK58zv1YfPJux7JuLPRolrZ1jhEBmMujktoToMBQS
 OOj4d6X5kmWqyX4SeZybzwogAuwyXmlm8hNMgH2oTCCw==
X-Gm-Gg: ASbGncvphZLaShH/9tAAynQFHlRnEggFMO9uAwQAUOYIELAInnxMZylen+/OxShbJ0Y
 2doBG4s9oS8GwEWcjwZ4eaIHc5hB4X5L0lf2A5LSKoJEIYS1cni4Rhm5jEL84WCVSNUniyPL+iE
 UFHIJwLKvLox+tjJQys1GIcI/BSaBxmud4tbRBnoYjLufPGb7UjunJ6UUUFId5PIM0hprIqWuci
 6LGtxYRFVOUCNTgGOr6xrefMQ==
X-Received: by 2002:a17:90b:3a8b:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-34947f1b93cmr7145863a91.28.1764947910111; 
 Fri, 05 Dec 2025 07:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuCgpbxosMCsl6BmQtBEO/538MaLYi232sdki596sJUjeWMTtFt+djh7KkuN9opG61hVGO939txQdWbo11fKk=
X-Received: by 2002:a17:90b:3a8b:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-34947f1b93cmr7145809a91.28.1764947909370; Fri, 05 Dec 2025
 07:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-7-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-7-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:18:17 +0400
X-Gm-Features: AWmQ_bn25BKLlUDrSpFEtW4plaEpBOR6HDRDuy-6HyecotcChMr2xrz4IjQ3YsY
Message-ID: <CAMxuvaz-9r8kd50mFKSTpak3RYG7ODQnRuTwf2UMO9HweFuOxg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] chardev: .chr_open(): add boolean return value
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002f750d064535f506"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002f750d064535f506
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Add boolean return value to follow common recommendations for functions
> with errrp in include/qapi/error.h
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  chardev/baum.c           |  5 +++--
>  chardev/char-console.c   |  1 +
>  chardev/char-file.c      | 13 +++++++------
>  chardev/char-hub.c       | 11 ++++++-----
>  chardev/char-mux.c       |  8 +++++---
>  chardev/char-null.c      |  4 ++--
>  chardev/char-parallel.c  | 14 ++++++++------
>  chardev/char-pipe.c      | 12 +++++++-----
>  chardev/char-pty.c       |  9 ++++++---
>  chardev/char-ringbuf.c   |  5 +++--
>  chardev/char-serial.c    | 15 +++++++++------
>  chardev/char-socket.c    | 17 +++++++++--------
>  chardev/char-stdio.c     | 11 ++++++-----
>  chardev/char-udp.c       |  5 +++--
>  chardev/char-win-stdio.c |  7 ++++---
>  chardev/msmouse.c        |  3 ++-
>  chardev/spice.c          | 12 +++++++-----
>  chardev/wctablet.c       |  3 ++-
>  gdbstub/system.c         |  3 ++-
>  include/chardev/char.h   |  2 +-
>  ui/console-vc.c          |  3 ++-
>  ui/dbus-chardev.c        |  6 +++---
>  ui/gtk.c                 |  5 +++--
>  ui/spice-app.c           | 10 ++++++----
>  ui/vdagent.c             | 10 +++++-----
>  25 files changed, 112 insertions(+), 82 deletions(-)
>
> diff --git a/chardev/baum.c b/chardev/baum.c
> index 58b74dc98d..0b0247dde0 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -642,7 +642,7 @@ static void char_braille_finalize(Object *obj)
>      }
>  }
>
> -static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool baum_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      BaumChardev *baum =3D BAUM_CHARDEV(chr);
>      brlapi_handle_t *handle;
> @@ -656,7 +656,7 @@ static void baum_chr_open(Chardev *chr, ChardevBacken=
d
> *backend, Error **errp)
>                     brlapi_strerror(brlapi_error_location()));
>          g_free(handle);
>          baum->brlapi =3D NULL;
> -        return;
> +        return false;
>      }
>      baum->deferred_init =3D 0;
>
> @@ -669,6 +669,7 @@ static void baum_chr_open(Chardev *chr, ChardevBacken=
d
> *backend, Error **errp)
>      qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  static void char_braille_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-console.c b/chardev/char-console.c
> index 423f0f4cc4..c911cc62e3 100644
> --- a/chardev/char-console.c
> +++ b/chardev/char-console.c
> @@ -31,6 +31,7 @@ static void console_chr_open(Chardev *chr,
> ChardevBackend *backend,
>  {
>      win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  static void char_console_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 34ef386abc..b0dd9d5f87 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -34,7 +34,7 @@
>  #include "chardev/char-fd.h"
>  #endif
>
> -static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool file_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevFile *file =3D backend->u.file.data;
>  #ifdef _WIN32
> @@ -44,7 +44,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>
>      if (file->in) {
>          error_setg(errp, "input file not supported");
> -        return;
> +        return false;
>      }
>
>      if (file->has_append && file->append) {
> @@ -61,7 +61,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>                       FILE_ATTRIBUTE_NORMAL, NULL);
>      if (out =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg(errp, "open %s failed", file->out);
> -        return;
> +        return false;
>      }
>
>      win_chr_set_file(chr, out, false);
> @@ -77,7 +77,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>
>      out =3D qmp_chardev_open_file_source(file->out, flags, errp);
>      if (out < 0) {
> -        return;
> +        return false;
>      }
>
>      if (file->in) {
> @@ -85,7 +85,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>          in =3D qmp_chardev_open_file_source(file->in, flags, errp);
>          if (in < 0) {
>              qemu_close(out);
> -            return;
> +            return false;
>          }
>      }
>
> @@ -94,11 +94,12 @@ static void file_chr_open(Chardev *chr, ChardevBacken=
d
> *backend, Error **errp)
>          if (in >=3D 0) {
>              qemu_close(in);
>          }
> -        return;
> +        return false;
>      }
>  #endif
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  static void file_chr_parse(QemuOpts *opts, ChardevBackend *backend,
> diff --git a/chardev/char-hub.c b/chardev/char-hub.c
> index aa6058c2f6..05cf722b5b 100644
> --- a/chardev/char-hub.c
> +++ b/chardev/char-hub.c
> @@ -203,7 +203,7 @@ static void hub_chr_update_read_handlers(Chardev *chr=
)
>      }
>  }
>
> -static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool hub_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHub *hub =3D backend->u.hub.data;
>      HubChardev *d =3D HUB_CHARDEV(chr);
> @@ -213,7 +213,7 @@ static void hub_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>
>      if (list =3D=3D NULL) {
>          error_setg(errp, "hub: 'chardevs' list is not defined");
> -        return;
> +        return false;
>      }
>
>      while (list) {
> @@ -223,17 +223,17 @@ static void hub_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>          if (s =3D=3D NULL) {
>              error_setg(errp, "hub: chardev can't be found by id '%s'",
>                         list->value);
> -            return;
> +            return false;
>          }
>          if (CHARDEV_IS_HUB(s) || CHARDEV_IS_MUX(s)) {
>              error_setg(errp, "hub: multiplexers and hub devices can't be=
 "
>                         "stacked, check chardev '%s', chardev should not =
"
>                         "be a hub device or have 'mux=3Don' enabled",
>                         list->value);
> -            return;
> +            return false;
>          }
>          if (!hub_chr_attach_chardev(d, s, errp)) {
> -            return;
> +            return false;
>          }
>          list =3D list->next;
>      }
> @@ -242,6 +242,7 @@ static void hub_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>       * Closed until an explicit event from backend, so we don't
>       * send CHR_EVENT_OPENED now.
>       */
> +    return true;
>  }
>
>  static void hub_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 7210df431f..881443d869 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -361,7 +361,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
>      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
>  }
>
> -static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool mux_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevMux *mux =3D backend->u.mux.data;
>      Chardev *drv;
> @@ -370,12 +370,12 @@ static void mux_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>      drv =3D qemu_chr_find(mux->chardev);
>      if (drv =3D=3D NULL) {
>          error_setg(errp, "mux: base chardev %s not found", mux->chardev)=
;
> -        return;
> +        return false;
>      }
>
>      d->focus =3D -1;
>      if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
> -        return;
> +        return false;
>      }
>
>      /*
> @@ -385,6 +385,8 @@ static void mux_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>      if (muxes_opened) {
>          qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>      }
> +
> +    return true;
>  }
>
>  static void mux_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/chardev/char-null.c b/chardev/char-null.c
> index 900b5febb6..d5a101178b 100644
> --- a/chardev/char-null.c
> +++ b/chardev/char-null.c
> @@ -26,9 +26,9 @@
>  #include "chardev/char.h"
>  #include "qemu/module.h"
>
> -static void null_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool null_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
> -    /* do not send CHR_EVENT_OPENED */
> +    return true;
>  }
>
>  static void char_null_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
> index 359efa3c9c..cbf87e660d 100644
> --- a/chardev/char-parallel.c
> +++ b/chardev/char-parallel.c
> @@ -157,7 +157,7 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd,
> void *arg)
>      return 0;
>  }
>
> -static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
> +static bool parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
>  {
>      ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
>
> @@ -165,11 +165,12 @@ static void parallel_chr_open_fd(Chardev *chr, int
> fd, Error **errp)
>
>      if (ioctl(fd, PPCLAIM) < 0) {
>          error_setg_errno(errp, errno, "not a parallel port");
> -        return;
> +        return false;
>      }
>
>      drv->mode =3D IEEE1284_MODE_COMPAT;
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>  #endif /* __linux__ */
>
> @@ -225,15 +226,16 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd=
,
> void *arg)
>      return 0;
>  }
>
> -static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
> +static bool parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
>  {
>      ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
>      drv->fd =3D fd;
> +    return true;
>  }
>  #endif
>
>  #ifdef HAVE_CHARDEV_PARALLEL
> -static void parallel_chr_open(Chardev *chr,
> +static bool parallel_chr_open(Chardev *chr,
>                                ChardevBackend *backend,
>                                Error **errp)
>  {
> @@ -242,9 +244,9 @@ static void parallel_chr_open(Chardev *chr,
>
>      fd =3D qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
>      if (fd < 0) {
> -        return;
> +        return false;
>      }
> -    parallel_chr_open_fd(chr, fd, errp);
> +    return parallel_chr_open_fd(chr, fd, errp);
>  }
>
>  static void parallel_chr_parse(QemuOpts *opts, ChardevBackend *backend,
> diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
> index 2f26372dfc..472b3e0801 100644
> --- a/chardev/char-pipe.c
> +++ b/chardev/char-pipe.c
> @@ -103,21 +103,22 @@ static int win_chr_pipe_init(Chardev *chr, const
> char *filename,
>      return -1;
>  }
>
> -static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *opts =3D backend->u.pipe.data;
>      const char *filename =3D opts->device;
>
>      if (win_chr_pipe_init(chr, filename, errp) < 0) {
> -        return;
> +        return false;
>      }
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  #else
>
> -static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *opts =3D backend->u.pipe.data;
>      int fd_in, fd_out;
> @@ -143,7 +144,7 @@ static void pipe_chr_open(Chardev *chr, ChardevBacken=
d
> *backend, Error **errp)
>          );
>          if (fd_in < 0) {
>              error_setg_file_open(errp, errno, filename);
> -            return;
> +            return false;
>          }
>      }
>
> @@ -152,10 +153,11 @@ static void pipe_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>          if (fd_out !=3D fd_in) {
>              close(fd_out);
>          }
> -        return;
> +        return false;
>      }
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  #endif /* !_WIN32 */
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index d4d69a29a9..9e26e97baf 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -331,7 +331,7 @@ static int qemu_openpty_raw(int *aslave, char
> *pty_name)
>      return amaster;
>  }
>
> -static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      PtyChardev *s;
>      int master_fd, slave_fd;
> @@ -342,13 +342,13 @@ static void pty_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>      master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
>      if (master_fd < 0) {
>          error_setg_errno(errp, errno, "Failed to create PTY");
> -        return;
> +        return false;
>      }
>
>      close(slave_fd);
>      if (!qemu_set_blocking(master_fd, false, errp)) {
>          close(master_fd);
> -        return;
> +        return false;
>      }
>
>      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> @@ -368,10 +368,13 @@ static void pty_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>
>          if (res !=3D 0) {
>              error_setg_errno(errp, errno, "Failed to create PTY symlink"=
);
> +            return false;
>          } else {
>              s->path =3D g_strdup(path);
>          }
>      }
> +
> +    return true;
>  }
>
>  static void pty_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
> index 30b17a96d3..8f998d26a4 100644
> --- a/chardev/char-ringbuf.c
> +++ b/chardev/char-ringbuf.c
> @@ -92,7 +92,7 @@ static void char_ringbuf_finalize(Object *obj)
>      g_free(d->cbuf);
>  }
>
> -static void ringbuf_chr_open(Chardev *chr,
> +static bool ringbuf_chr_open(Chardev *chr,
>                               ChardevBackend *backend,
>                               Error **errp)
>  {
> @@ -104,7 +104,7 @@ static void ringbuf_chr_open(Chardev *chr,
>      /* The size must be power of 2 */
>      if (d->size & (d->size - 1)) {
>          error_setg(errp, "size of ringbuf chardev must be power of two")=
;
> -        return;
> +        return false;
>      }
>
>      d->prod =3D 0;
> @@ -112,6 +112,7 @@ static void ringbuf_chr_open(Chardev *chr,
>      d->cbuf =3D g_malloc0(d->size);
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  void qmp_ringbuf_write(const char *device, const char *data,
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 9995f18425..0c73bafc54 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -41,15 +41,17 @@
>
>  #ifdef _WIN32
>
> -static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool serial_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *serial =3D backend->u.serial.data;
>      int ret =3D win_chr_serial_init(chr, serial->device, errp);
>      if (ret < 0) {
> -        return;
> +        return false;
>      }
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +
> +    return true;
>  }
>
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)
> \
> @@ -259,7 +261,7 @@ static int serial_chr_ioctl(Chardev *chr, int cmd,
> void *arg)
>      return 0;
>  }
>
> -static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool serial_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevHostdev *serial =3D backend->u.serial.data;
>      int fd;
> @@ -267,20 +269,21 @@ static void serial_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>      fd =3D qmp_chardev_open_file_source(serial->device, O_RDWR | O_NONBL=
OCK,
>                                        errp);
>      if (fd < 0) {
> -        return;
> +        return false;
>      }
>      if (!qemu_set_blocking(fd, false, errp)) {
>          close(fd);
> -        return;
> +        return false;
>      }
>      tty_serial_init(fd, 115200, 'N', 8, 1);
>
>      if (!qemu_chr_open_fd(chr, fd, fd, errp)) {
>          close(fd);
> -        return;
> +        return false;
>      }
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>  #endif /* __linux__ || __sun__ */
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3f57ef4016..31c9acd164 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1365,7 +1365,7 @@ static bool
> qmp_chardev_validate_socket(ChardevSocket *sock,
>  }
>
>
> -static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      ChardevSocket *sock =3D backend->u.socket.data;
> @@ -1390,7 +1390,7 @@ static void tcp_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>          if (!creds) {
>              error_setg(errp, "No TLS credentials with id '%s'",
>                         sock->tls_creds);
> -            return;
> +            return false;
>          }
>          s->tls_creds =3D (QCryptoTLSCreds *)
>              object_dynamic_cast(creds,
> @@ -1398,7 +1398,7 @@ static void tcp_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>          if (!s->tls_creds) {
>              error_setg(errp, "Object with id '%s' is not TLS credentials=
",
>                         sock->tls_creds);
> -            return;
> +            return false;
>          }
>          object_ref(OBJECT(s->tls_creds));
>          if (!qcrypto_tls_creds_check_endpoint(s->tls_creds,
> @@ -1406,7 +1406,7 @@ static void tcp_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>                                            ?
> QCRYPTO_TLS_CREDS_ENDPOINT_SERVER
>                                            :
> QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
>                                            errp)) {
> -            return;
> +            return false;
>          }
>      }
>      s->tls_authz =3D g_strdup(sock->tls_authz);
> @@ -1414,7 +1414,7 @@ static void tcp_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>      s->addr =3D addr =3D socket_address_flatten(sock->addr);
>
>      if (!qmp_chardev_validate_socket(sock, addr, errp)) {
> -        return;
> +        return false;
>      }
>
>      qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
> @@ -1431,7 +1431,7 @@ static void tcp_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>       */
>      if (!chr->handover_yank_instance) {
>          if (!yank_register_instance(CHARDEV_YANK_INSTANCE(chr->label),
> errp)) {
> -            return;
> +            return false;
>          }
>      }
>      s->registered_yank =3D true;
> @@ -1441,15 +1441,16 @@ static void tcp_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>      if (s->is_listen) {
>          if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
>                                             is_waitconnect, errp) < 0) {
> -            return;
> +            return false;
>          }
>      } else {
>          if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0)=
 {
> -            return;
> +            return false;
>          }
>      }
>
>      /* be isn't opened until we get a connection */
> +    return true;
>  }
>
>  static void tcp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index 534f6ed565..fe1cbb2d88 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -85,19 +85,19 @@ static void term_stdio_handler(int sig)
>      stdio_chr_set_echo(NULL, stdio_echo_state);
>  }
>
> -static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevStdio *opts =3D backend->u.stdio.data;
>      struct sigaction act;
>
>      if (is_daemonized()) {
>          error_setg(errp, "cannot use stdio with -daemonize");
> -        return;
> +        return false;
>      }
>
>      if (stdio_in_use) {
>          error_setg(errp, "cannot use stdio by multiple character
> devices");
> -        return;
> +        return false;
>      }
>
>      stdio_in_use =3D true;
> @@ -105,11 +105,11 @@ static void stdio_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>      old_fd1_flags =3D fcntl(1, F_GETFL);
>      tcgetattr(0, &oldtty);
>      if (!qemu_set_blocking(0, false, errp)) {
> -        return;
> +        return false;
>      }
>
>      if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
> -        return;
> +        return false;
>      }
>
>      atexit(term_exit);
> @@ -122,6 +122,7 @@ static void stdio_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>      stdio_chr_set_echo(chr, false);
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>  #endif
>
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index b835a967e1..3d3bc1f659 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -188,7 +188,7 @@ static void udp_chr_parse(QemuOpts *opts,
> ChardevBackend *backend, Error **errp)
>      }
>  }
>
> -static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool upd_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevUdp *udp =3D backend->u.udp.data;
>      SocketAddress *local_addr =3D socket_address_flatten(udp->local);
> @@ -203,7 +203,7 @@ static void upd_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>      qapi_free_SocketAddress(remote_addr);
>      if (ret < 0) {
>          object_unref(OBJECT(sioc));
> -        return;
> +        return false;
>      }
>
>      name =3D g_strdup_printf("chardev-udp-%s", chr->label);
> @@ -212,6 +212,7 @@ static void upd_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>
>      s->ioc =3D QIO_CHANNEL(sioc);
>      /* be isn't opened until we get a connection */
> +    return true;
>  }
>
>  static void char_udp_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index 0535960ff1..bb9c195a8b 100644
> --- a/chardev/char-win-stdio.c
> +++ b/chardev/char-win-stdio.c
> @@ -142,7 +142,7 @@ static void win_stiod_chr_set_echo(Chardev *chr, bool
> echo)
>      }
>  }
>
> -static void win_stdio_chr_open(Chardev *chr,
> +static bool win_stdio_chr_open(Chardev *chr,
>                                 ChardevBackend *backend,
>                                 Error **errp)
>  {
> @@ -155,7 +155,7 @@ static void win_stdio_chr_open(Chardev *chr,
>      stdio->hStdIn =3D GetStdHandle(STD_INPUT_HANDLE);
>      if (stdio->hStdIn =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg(errp, "cannot open stdio: invalid handle");
> -        return;
> +        return false;
>      }
>
>      is_console =3D GetConsoleMode(stdio->hStdIn, &dwMode) !=3D 0;
> @@ -208,7 +208,7 @@ static void win_stdio_chr_open(Chardev *chr,
>      win_stiod_chr_set_echo(chr, false);
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> -    return;
> +    return true;
>
>  err3:
>      qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
> @@ -217,6 +217,7 @@ err2:
>      CloseHandle(stdio->hInputDoneEvent);
>  err1:
>      qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
> +    return false;
>  }
>
>  static void char_win_stdio_finalize(Object *obj)
> diff --git a/chardev/msmouse.c b/chardev/msmouse.c
> index 9dc04e3b3e..365f04546e 100644
> --- a/chardev/msmouse.c
> +++ b/chardev/msmouse.c
> @@ -253,7 +253,7 @@ static void char_msmouse_finalize(Object *obj)
>      fifo8_destroy(&mouse->outbuf);
>  }
>
> -static void msmouse_chr_open(Chardev *chr,
> +static bool msmouse_chr_open(Chardev *chr,
>                               ChardevBackend *backend,
>                               Error **errp)
>  {
> @@ -265,6 +265,7 @@ static void msmouse_chr_open(Chardev *chr,
>      fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
>
>      /* Never send CHR_EVENT_OPENED */
> +    return true;
>  }
>
>  static void char_msmouse_class_init(ObjectClass *oc, const void *data)
> diff --git a/chardev/spice.c b/chardev/spice.c
> index f5b1f585eb..ad97d98ac6 100644
> --- a/chardev/spice.c
> +++ b/chardev/spice.c
> @@ -251,7 +251,7 @@ static void chr_open(Chardev *chr, const char *subtyp=
e)
>      s->sin.subtype =3D g_strdup(subtype);
>  }
>
> -static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
> +static bool spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
>                                 Error **errp)
>  {
>      ChardevSpiceChannel *spicevmc =3D backend->u.spicevmc.data;
> @@ -272,13 +272,14 @@ static void spice_vmc_chr_open(Chardev *chr,
> ChardevBackend *backend,
>                            subtypes);
>
>          g_free(subtypes);
> -        return;
> +        return false;
>      }
>
>      chr_open(chr, type);
> +    return true;
>  }
>
> -static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
> +static bool spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
>                                  Error **errp)
>  {
>      ChardevSpicePort *spiceport =3D backend->u.spiceport.data;
> @@ -287,12 +288,12 @@ static void spice_port_chr_open(Chardev *chr,
> ChardevBackend *backend,
>
>      if (name =3D=3D NULL) {
>          error_setg(errp, "missing name parameter");
> -        return;
> +        return false;
>      }
>
>      if (!using_spice) {
>          error_setg(errp, "spice not enabled");
> -        return;
> +        return false;
>      }
>
>      chr_open(chr, "port");
> @@ -301,6 +302,7 @@ static void spice_port_chr_open(Chardev *chr,
> ChardevBackend *backend,
>      s->sin.portname =3D g_strdup(name);
>
>      vmc_register_interface(s);
> +    return true;
>  }
>
>  static void spice_vmc_chr_parse(QemuOpts *opts, ChardevBackend *backend,
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 65b2ceb58c..214d5ca2e2 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -324,7 +324,7 @@ static void wctablet_chr_finalize(Object *obj)
>      }
>  }
>
> -static void wctablet_chr_open(Chardev *chr,
> +static bool wctablet_chr_open(Chardev *chr,
>                                ChardevBackend *backend,
>                                Error **errp)
>  {
> @@ -339,6 +339,7 @@ static void wctablet_chr_open(Chardev *chr,
>                                               &wctablet_handler);
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  static void wctablet_chr_class_init(ObjectClass *oc, const void *data)
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 49da1f73cc..ec24d812b3 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -233,9 +233,10 @@ static int gdb_chr_write(Chardev *chr, const uint8_t
> *buf, int len)
>      return len;
>  }
>
> -static void gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      /* Never send CHR_EVENT_OPENED */
> +    return true;
>  }
>
>  static void char_gdb_class_init(ObjectClass *oc, const void *data)
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 47c75c3582..23a227dca9 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -260,7 +260,7 @@ struct ChardevClass {
>      void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error
> **errp);
>
>      /* called after construction, open/starts the backend */
> -    void (*chr_open)(Chardev *chr, ChardevBackend *backend, Error **errp=
);
> +    bool (*chr_open)(Chardev *chr, ChardevBackend *backend, Error **errp=
);
>
>      /* write buf to the backend */
>      int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 4c8ea4c148..f22806fed7 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -1093,7 +1093,7 @@ void qemu_text_console_update_size(QemuTextConsole
> *c)
>      dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
>  }
>
> -static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ChardevVC *vc =3D backend->u.vc.data;
>      VCChardev *drv =3D VC_CHARDEV(chr);
> @@ -1142,6 +1142,7 @@ static void vc_chr_open(Chardev *chr, ChardevBacken=
d
> *backend, Error **errp)
>      }
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
> diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
> index 3e471f84cd..9442b47551 100644
> --- a/ui/dbus-chardev.c
> +++ b/ui/dbus-chardev.c
> @@ -176,7 +176,7 @@ dbus_chr_send_break(
>      return DBUS_METHOD_INVOCATION_HANDLED;
>  }
>
> -static void dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      ERRP_GUARD();
>
> @@ -206,9 +206,9 @@ static void dbus_chr_open(Chardev *chr, ChardevBacken=
d
> *backend, Error **errp)
>      CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_parse(
>          opts, be, errp);
>      if (*errp) {
> -        return;
> +        return false;
>      }
> -    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
> +    return
> CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
>          chr, be, errp);
>  }
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 3eeb5baa11..e2c0135646 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1967,7 +1967,7 @@ static void gd_vc_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>  {
>      if (nb_vcs =3D=3D MAX_VCS) {
>          error_setg(errp, "Maximum number of consoles reached");
> -        return;
> +        return false;
>      }
>
>      vcs[nb_vcs++] =3D chr;
> @@ -1976,13 +1976,14 @@ static void gd_vc_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>       * console/chardev init sometimes completes elsewhere in a 2nd
>       * stage, so defer OPENED events until they are fully initialized
>       */
> +    return true;
>  }
>
>  static void char_gd_vc_class_init(ObjectClass *oc, const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->chr_open =3D gd_vc_chr_open;
> +    cc->chr_open =3D char_gtk_init;
>

Bad rename, and missing corrected return type (I'll fix on commit if no
more changes)


>      cc->chr_write =3D gd_vc_chr_write;
>      cc->chr_accept_input =3D gd_vc_chr_accept_input;
>      cc->chr_set_echo =3D gd_vc_chr_set_echo;
> diff --git a/ui/spice-app.c b/ui/spice-app.c
> index 7ac9ae4e78..9e55f27371 100644
> --- a/ui/spice-app.c
> +++ b/ui/spice-app.c
> @@ -49,7 +49,7 @@ struct VCChardev {
>
>  struct VCChardevClass {
>      ChardevClass parent;
> -    void (*parent_open)(Chardev *chr, ChardevBackend *backend, Error
> **errp);
> +    bool (*parent_init)(Chardev *chr, ChardevBackend *backend, Error
> **errp);
>  };
>
>  #define TYPE_CHARDEV_VC "chardev-vc"
> @@ -66,11 +66,12 @@ chr_spice_backend_new(void)
>      return be;
>  }
>
> -static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
> +static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error
> **errp)
>  {
>      VCChardevClass *vc =3D CHARDEV_VC_GET_CLASS(chr);
>      ChardevBackend *be;
>      const char *fqdn =3D NULL;
> +    bool ok;
>
>      if (strstart(chr->label, "serial", NULL)) {
>          fqdn =3D "org.qemu.console.serial.0";
> @@ -83,8 +84,9 @@ static void vc_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>      be =3D chr_spice_backend_new();
>      be->u.spiceport.data->fqdn =3D fqdn ?
>          g_strdup(fqdn) : g_strdup_printf("org.qemu.console.%s",
> chr->label);
> -    vc->parent_open(chr, be, errp);
> +    ok =3D vc->parent_init(chr, be, errp);
>      qapi_free_ChardevBackend(be);
> +    return ok;
>  }
>
>  static void vc_chr_set_echo(Chardev *chr, bool echo)
> @@ -102,7 +104,7 @@ static void char_vc_class_init(ObjectClass *oc, const
> void *data)
>      VCChardevClass *vc =3D CHARDEV_VC_CLASS(oc);
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    vc->parent_open =3D cc->chr_open;
> +    vc->parent_init =3D cc->chr_open;
>
>      cc->chr_parse =3D vc_chr_parse;
>      cc->chr_open =3D vc_chr_open;
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 3becc6c076..d5c6e3340b 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -660,8 +660,7 @@ static void vdagent_chr_recv_clipboard(VDAgentChardev
> *vd, VDAgentMessage *msg)
>  /* ------------------------------------------------------------------ */
>  /* chardev backend                                                    */
>
> -static void vdagent_chr_open(Chardev *chr,
> -                             ChardevBackend *backend,
> +static bool vdagent_chr_open(Chardev *chr, ChardevBackend *backend,
>                               Error **errp)
>  {
>      VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(chr);
> @@ -673,7 +672,7 @@ static void vdagent_chr_open(Chardev *chr,
>       * so we have to byteswap everything on BE hosts.
>       */
>      error_setg(errp, "vdagent is not supported on bigendian hosts");
> -    return;
> +    return false;
>  #endif
>
>      vd->mouse =3D VDAGENT_MOUSE_DEFAULT;
> @@ -692,6 +691,7 @@ static void vdagent_chr_open(Chardev *chr,
>      }
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    return true;
>  }
>
>  static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
> @@ -1074,7 +1074,7 @@ static const VMStateDescription vmstate_vdagent =3D=
 {
>      }
>  };
>
> -static void vdagent_chr_init(Object *obj)
> +static void vdagent_chr_instance_init(Object *obj)
>  {
>      VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);
>
> @@ -1097,7 +1097,7 @@ static const TypeInfo vdagent_chr_type_info =3D {
>      .name =3D TYPE_CHARDEV_QEMU_VDAGENT,
>      .parent =3D TYPE_CHARDEV,
>      .instance_size =3D sizeof(VDAgentChardev),
> -    .instance_init =3D vdagent_chr_init,
> +    .instance_init =3D vdagent_chr_instance_init,
>      .instance_finalize =3D vdagent_chr_fini,
>      .class_init =3D vdagent_chr_class_init,
>  };
> --
> 2.48.1
>
>

--0000000000002f750d064535f506
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 20=
25 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vs=
ementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Add boolean return value =
to follow common recommendations for functions<br>
with errrp in include/qapi/error.h<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0chardev/baum.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++-=
-<br>
=C2=A0chardev/char-console.c=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0chardev/char-file.c=C2=A0 =C2=A0 =C2=A0 | 13 +++++++------<br>
=C2=A0chardev/char-hub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 ++++++-----<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +++++---<br>
=C2=A0chardev/char-null.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0chardev/char-parallel.c=C2=A0 | 14 ++++++++------<br>
=C2=A0chardev/char-pipe.c=C2=A0 =C2=A0 =C2=A0 | 12 +++++++-----<br>
=C2=A0chardev/char-pty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 ++++++---<br>
=C2=A0chardev/char-ringbuf.c=C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A0chardev/char-serial.c=C2=A0 =C2=A0 | 15 +++++++++------<br>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 | 17 +++++++++--------<br>
=C2=A0chardev/char-stdio.c=C2=A0 =C2=A0 =C2=A0| 11 ++++++-----<br>
=C2=A0chardev/char-udp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A0chardev/char-win-stdio.c |=C2=A0 7 ++++---<br>
=C2=A0chardev/msmouse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0chardev/spice.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +++++++-----<b=
r>
=C2=A0chardev/wctablet.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0gdbstub/system.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0include/chardev/char.h=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0ui/console-vc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0ui/dbus-chardev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++---<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 5 +++--<br>
=C2=A0ui/spice-app.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++++---=
-<br>
=C2=A0ui/vdagent.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++=
+-----<br>
=C2=A025 files changed, 112 insertions(+), 82 deletions(-)<br>
<br>
diff --git a/chardev/baum.c b/chardev/baum.c<br>
index 58b74dc98d..0b0247dde0 100644<br>
--- a/chardev/baum.c<br>
+++ b/chardev/baum.c<br>
@@ -642,7 +642,7 @@ static void char_braille_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
+static bool baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0BaumChardev *baum =3D BAUM_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0brlapi_handle_t *handle;<br>
@@ -656,7 +656,7 @@ static void baum_chr_open(Chardev *chr, ChardevBackend =
*backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brlap=
i_strerror(brlapi_error_location()));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(handle);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0baum-&gt;brlapi =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0baum-&gt;deferred_init =3D 0;<br>
<br>
@@ -669,6 +669,7 @@ static void baum_chr_open(Chardev *chr, ChardevBackend =
*backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0qemu_set_fd_handler(baum-&gt;brlapi_fd, baum_chr_read, =
NULL, baum);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_braille_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/chardev/char-console.c b/chardev/char-console.c<br>
index 423f0f4cc4..c911cc62e3 100644<br>
--- a/chardev/char-console.c<br>
+++ b/chardev/char-console.c<br>
@@ -31,6 +31,7 @@ static void console_chr_open(Chardev *chr, ChardevBackend=
 *backend,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), =
true);<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_console_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/chardev/char-file.c b/chardev/char-file.c<br>
index 34ef386abc..b0dd9d5f87 100644<br>
--- a/chardev/char-file.c<br>
+++ b/chardev/char-file.c<br>
@@ -34,7 +34,7 @@<br>
=C2=A0#include &quot;chardev/char-fd.h&quot;<br>
=C2=A0#endif<br>
<br>
-static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
+static bool file_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevFile *file =3D backend-&gt;u.file.data;<br>
=C2=A0#ifdef _WIN32<br>
@@ -44,7 +44,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *b=
ackend, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (file-&gt;in) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;input file not sup=
ported&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (file-&gt;has_append &amp;&amp; file-&gt;append) {<b=
r>
@@ -61,7 +61,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *b=
ackend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 FILE_ATTRIBUTE_NORMAL, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (out =3D=3D INVALID_HANDLE_VALUE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;open %s failed&quo=
t;, file-&gt;out);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0win_chr_set_file(chr, out, false);<br>
@@ -77,7 +77,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *b=
ackend, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0out =3D qmp_chardev_open_file_source(file-&gt;out, flag=
s, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (out &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (file-&gt;in) {<br>
@@ -85,7 +85,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *b=
ackend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in =3D qmp_chardev_open_file_source(file-=
&gt;in, flags, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (in &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_close(out);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -94,11 +94,12 @@ static void file_chr_open(Chardev *chr, ChardevBackend =
*backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (in &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_close(in);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void file_chr_parse(QemuOpts *opts, ChardevBackend *backend,<b=
r>
diff --git a/chardev/char-hub.c b/chardev/char-hub.c<br>
index aa6058c2f6..05cf722b5b 100644<br>
--- a/chardev/char-hub.c<br>
+++ b/chardev/char-hub.c<br>
@@ -203,7 +203,7 @@ static void hub_chr_update_read_handlers(Chardev *chr)<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
+static bool hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHub *hub =3D backend-&gt;u.hub.data;<br>
=C2=A0 =C2=A0 =C2=A0HubChardev *d =3D HUB_CHARDEV(chr);<br>
@@ -213,7 +213,7 @@ static void hub_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (list =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;hub: &#39;chardevs=
&#39; list is not defined&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (list) {<br>
@@ -223,17 +223,17 @@ static void hub_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;hub:=
 chardev can&#39;t be found by id &#39;%s&#39;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 list-&gt;value);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_HUB(s) || CHARDEV_IS_MUX(s=
)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;hub:=
 multiplexers and hub devices can&#39;t be &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;stacked, check chardev &#39;%s&#39;, chardev should not &q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;be a hub device or have &#39;mux=3Don&#39; enabled&quot;,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 list-&gt;value);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!hub_chr_attach_chardev(d, s, errp)) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list =3D list-&gt;next;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -242,6 +242,7 @@ static void hub_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 * Closed until an explicit event from backend, so we d=
on&#39;t<br>
=C2=A0 =C2=A0 =C2=A0 * send CHR_EVENT_OPENED now.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void hub_chr_parse(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
index 7210df431f..881443d869 100644<br>
--- a/chardev/char-mux.c<br>
+++ b/chardev/char-mux.c<br>
@@ -361,7 +361,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)<br=
>
=C2=A0 =C2=A0 =C2=A0mux_chr_send_event(d, d-&gt;focus, CHR_EVENT_MUX_IN);<b=
r>
=C2=A0}<br>
<br>
-static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
+static bool mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevMux *mux =3D backend-&gt;u.mux.data;<br>
=C2=A0 =C2=A0 =C2=A0Chardev *drv;<br>
@@ -370,12 +370,12 @@ static void mux_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0drv =3D qemu_chr_find(mux-&gt;chardev);<br>
=C2=A0 =C2=A0 =C2=A0if (drv =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;mux: base chardev =
%s not found&quot;, mux-&gt;chardev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;focus =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0if (!qemu_chr_fe_init(&amp;d-&gt;chr, drv, errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -385,6 +385,8 @@ static void mux_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0if (muxes_opened) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void mux_chr_parse(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)<br>
diff --git a/chardev/char-null.c b/chardev/char-null.c<br>
index 900b5febb6..d5a101178b 100644<br>
--- a/chardev/char-null.c<br>
+++ b/chardev/char-null.c<br>
@@ -26,9 +26,9 @@<br>
=C2=A0#include &quot;chardev/char.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
<br>
-static void null_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
+static bool null_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* do not send CHR_EVENT_OPENED */<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_null_class_init(ObjectClass *oc, const void *data)<b=
r>
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c<br>
index 359efa3c9c..cbf87e660d 100644<br>
--- a/chardev/char-parallel.c<br>
+++ b/chardev/char-parallel.c<br>
@@ -157,7 +157,7 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, vo=
id *arg)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)<br>
+static bool parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);<br>
<br>
@@ -165,11 +165,12 @@ static void parallel_chr_open_fd(Chardev *chr, int fd=
, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ioctl(fd, PPCLAIM) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, &quot;not a=
 parallel port&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0drv-&gt;mode =3D IEEE1284_MODE_COMPAT;<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
=C2=A0#endif /* __linux__ */<br>
<br>
@@ -225,15 +226,16 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, =
void *arg)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)<br>
+static bool parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0drv-&gt;fd =3D fd;<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifdef HAVE_CHARDEV_PARALLEL<br>
-static void parallel_chr_open(Chardev *chr,<br>
+static bool parallel_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
@@ -242,9 +244,9 @@ static void parallel_chr_open(Chardev *chr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0fd =3D qmp_chardev_open_file_source(parallel-&gt;device=
, O_RDWR, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 parallel_chr_open_fd(chr, fd, errp);<br>
+=C2=A0 =C2=A0 return parallel_chr_open_fd(chr, fd, errp);<br>
=C2=A0}<br>
<br>
=C2=A0static void parallel_chr_parse(QemuOpts *opts, ChardevBackend *backen=
d,<br>
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c<br>
index 2f26372dfc..472b3e0801 100644<br>
--- a/chardev/char-pipe.c<br>
+++ b/chardev/char-pipe.c<br>
@@ -103,21 +103,22 @@ static int win_chr_pipe_init(Chardev *chr, const char=
 *filename,<br>
=C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0}<br>
<br>
-static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
+static bool pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *opts =3D backend-&gt;u.pipe.data;<br>
=C2=A0 =C2=A0 =C2=A0const char *filename =3D opts-&gt;device;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (win_chr_pipe_init(chr, filename, errp) &lt; 0) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0#else<br>
<br>
-static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
+static bool pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *opts =3D backend-&gt;u.pipe.data;<br>
=C2=A0 =C2=A0 =C2=A0int fd_in, fd_out;<br>
@@ -143,7 +144,7 @@ static void pipe_chr_open(Chardev *chr, ChardevBackend =
*backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd_in &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_file_open(errp, =
errno, filename);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -152,10 +153,11 @@ static void pipe_chr_open(Chardev *chr, ChardevBacken=
d *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd_out !=3D fd_in) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd_out);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0#endif /* !_WIN32 */<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index d4d69a29a9..9e26e97baf 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -331,7 +331,7 @@ static int qemu_openpty_raw(int *aslave, char *pty_name=
)<br>
=C2=A0 =C2=A0 =C2=A0return amaster;<br>
=C2=A0}<br>
<br>
-static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
+static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PtyChardev *s;<br>
=C2=A0 =C2=A0 =C2=A0int master_fd, slave_fd;<br>
@@ -342,13 +342,13 @@ static void pty_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0master_fd =3D qemu_openpty_raw(&amp;slave_fd, pty_name)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (master_fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, &quot;Faile=
d to create PTY&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0close(slave_fd);<br>
=C2=A0 =C2=A0 =C2=A0if (!qemu_set_blocking(master_fd, false, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(master_fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0chr-&gt;filename =3D g_strdup_printf(&quot;pty:%s&quot;=
, pty_name);<br>
@@ -368,10 +368,13 @@ static void pty_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errn=
o, &quot;Failed to create PTY symlink&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;path =3D g_strdup(pat=
h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void pty_chr_parse(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)<br>
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c<br>
index 30b17a96d3..8f998d26a4 100644<br>
--- a/chardev/char-ringbuf.c<br>
+++ b/chardev/char-ringbuf.c<br>
@@ -92,7 +92,7 @@ static void char_ringbuf_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0g_free(d-&gt;cbuf);<br>
=C2=A0}<br>
<br>
-static void ringbuf_chr_open(Chardev *chr,<br>
+static bool ringbuf_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
@@ -104,7 +104,7 @@ static void ringbuf_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0/* The size must be power of 2 */<br>
=C2=A0 =C2=A0 =C2=A0if (d-&gt;size &amp; (d-&gt;size - 1)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;size of ringbuf ch=
ardev must be power of two&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;prod =3D 0;<br>
@@ -112,6 +112,7 @@ static void ringbuf_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;cbuf =3D g_malloc0(d-&gt;size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0void qmp_ringbuf_write(const char *device, const char *data,<br>
diff --git a/chardev/char-serial.c b/chardev/char-serial.c<br>
index 9995f18425..0c73bafc54 100644<br>
--- a/chardev/char-serial.c<br>
+++ b/chardev/char-serial.c<br>
@@ -41,15 +41,17 @@<br>
<br>
=C2=A0#ifdef _WIN32<br>
<br>
-static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error *=
*errp)<br>
+static bool serial_chr_open(Chardev *chr, ChardevBackend *backend, Error *=
*errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *serial =3D backend-&gt;u.serial.data;<b=
r>
=C2=A0 =C2=A0 =C2=A0int ret =3D win_chr_serial_init(chr, serial-&gt;device,=
 errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)=
=C2=A0 =C2=A0 =C2=A0 \<br>
@@ -259,7 +261,7 @@ static int serial_chr_ioctl(Chardev *chr, int cmd, void=
 *arg)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error *=
*errp)<br>
+static bool serial_chr_open(Chardev *chr, ChardevBackend *backend, Error *=
*errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevHostdev *serial =3D backend-&gt;u.serial.data;<b=
r>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
@@ -267,20 +269,21 @@ static void serial_chr_open(Chardev *chr, ChardevBack=
end *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0fd =3D qmp_chardev_open_file_source(serial-&gt;device, =
O_RDWR | O_NONBLOCK,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errp);<br=
>
=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (!qemu_set_blocking(fd, false, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0tty_serial_init(fd, 115200, &#39;N&#39;, 8, 1);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!qemu_chr_open_fd(chr, fd, fd, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
=C2=A0#endif /* __linux__ || __sun__ */<br>
<br>
diff --git a/chardev/char-socket.c b/chardev/char-socket.c<br>
index 3f57ef4016..31c9acd164 100644<br>
--- a/chardev/char-socket.c<br>
+++ b/chardev/char-socket.c<br>
@@ -1365,7 +1365,7 @@ static bool qmp_chardev_validate_socket(ChardevSocket=
 *sock,<br>
=C2=A0}<br>
<br>
<br>
-static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
+static bool tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SocketChardev *s =3D SOCKET_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0ChardevSocket *sock =3D backend-&gt;u.socket.data;<br>
@@ -1390,7 +1390,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!creds) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;No T=
LS credentials with id &#39;%s&#39;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sock-&gt;tls_creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tls_creds =3D (QCryptoTLSCreds *)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_dynamic_cast(creds,<=
br>
@@ -1398,7 +1398,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;tls_creds) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Obje=
ct with id &#39;%s&#39; is not TLS credentials&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sock-&gt;tls_creds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_ref(OBJECT(s-&gt;tls_creds));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!qcrypto_tls_creds_check_endpoint(s-&=
gt;tls_creds,<br>
@@ -1406,7 +1406,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0? QCRYPTO_TLS_CREDS_ENDPOINT_SERVER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0: QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;tls_authz =3D g_strdup(sock-&gt;tls_authz);<br>
@@ -1414,7 +1414,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;addr =3D addr =3D socket_address_flatten(sock-&gt=
;addr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!qmp_chardev_validate_socket(sock, addr, errp)) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTAB=
LE);<br>
@@ -1431,7 +1431,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (!chr-&gt;handover_yank_instance) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!yank_register_instance(CHARDEV_YANK_=
INSTANCE(chr-&gt;label), errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;registered_yank =3D true;<br>
@@ -1441,15 +1441,16 @@ static void tcp_chr_open(Chardev *chr, ChardevBacke=
nd *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;is_listen) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qmp_chardev_open_socket_server(chr, i=
s_telnet || is_tn3270,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 is_waitconnect, errp) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qmp_chardev_open_socket_client(chr, r=
econnect_ms, errp) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* be isn&#39;t opened until we get a connection */<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void tcp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Er=
ror **errp)<br>
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c<br>
index 534f6ed565..fe1cbb2d88 100644<br>
--- a/chardev/char-stdio.c<br>
+++ b/chardev/char-stdio.c<br>
@@ -85,19 +85,19 @@ static void term_stdio_handler(int sig)<br>
=C2=A0 =C2=A0 =C2=A0stdio_chr_set_echo(NULL, stdio_echo_state);<br>
=C2=A0}<br>
<br>
-static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **=
errp)<br>
+static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevStdio *opts =3D backend-&gt;u.stdio.data;<br>
=C2=A0 =C2=A0 =C2=A0struct sigaction act;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (is_daemonized()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;cannot use stdio w=
ith -daemonize&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (stdio_in_use) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;cannot use stdio b=
y multiple character devices&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0stdio_in_use =3D true;<br>
@@ -105,11 +105,11 @@ static void stdio_chr_open(Chardev *chr, ChardevBacke=
nd *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0old_fd1_flags =3D fcntl(1, F_GETFL);<br>
=C2=A0 =C2=A0 =C2=A0tcgetattr(0, &amp;oldtty);<br>
=C2=A0 =C2=A0 =C2=A0if (!qemu_set_blocking(0, false, errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!qemu_chr_open_fd(chr, 0, 1, errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0atexit(term_exit);<br>
@@ -122,6 +122,7 @@ static void stdio_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0stdio_chr_set_echo(chr, false);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
diff --git a/chardev/char-udp.c b/chardev/char-udp.c<br>
index b835a967e1..3d3bc1f659 100644<br>
--- a/chardev/char-udp.c<br>
+++ b/chardev/char-udp.c<br>
@@ -188,7 +188,7 @@ static void udp_chr_parse(QemuOpts *opts, ChardevBacken=
d *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
+static bool upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevUdp *udp =3D backend-&gt;u.udp.data;<br>
=C2=A0 =C2=A0 =C2=A0SocketAddress *local_addr =3D socket_address_flatten(ud=
p-&gt;local);<br>
@@ -203,7 +203,7 @@ static void upd_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0qapi_free_SocketAddress(remote_addr);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(sioc));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0name =3D g_strdup_printf(&quot;chardev-udp-%s&quot;, ch=
r-&gt;label);<br>
@@ -212,6 +212,7 @@ static void upd_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;ioc =3D QIO_CHANNEL(sioc);<br>
=C2=A0 =C2=A0 =C2=A0/* be isn&#39;t opened until we get a connection */<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_udp_class_init(ObjectClass *oc, const void *data)<br=
>
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c<br>
index 0535960ff1..bb9c195a8b 100644<br>
--- a/chardev/char-win-stdio.c<br>
+++ b/chardev/char-win-stdio.c<br>
@@ -142,7 +142,7 @@ static void win_stiod_chr_set_echo(Chardev *chr, bool e=
cho)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void win_stdio_chr_open(Chardev *chr,<br>
+static bool win_stdio_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
@@ -155,7 +155,7 @@ static void win_stdio_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0stdio-&gt;hStdIn =3D GetStdHandle(STD_INPUT_HANDLE);<br=
>
=C2=A0 =C2=A0 =C2=A0if (stdio-&gt;hStdIn =3D=3D INVALID_HANDLE_VALUE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;cannot open stdio:=
 invalid handle&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0is_console =3D GetConsoleMode(stdio-&gt;hStdIn, &amp;dw=
Mode) !=3D 0;<br>
@@ -208,7 +208,7 @@ static void win_stdio_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0win_stiod_chr_set_echo(chr, false);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
-=C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 return true;<br>
<br>
=C2=A0err3:<br>
=C2=A0 =C2=A0 =C2=A0qemu_del_wait_object(stdio-&gt;hInputReadyEvent, NULL, =
NULL);<br>
@@ -217,6 +217,7 @@ err2:<br>
=C2=A0 =C2=A0 =C2=A0CloseHandle(stdio-&gt;hInputDoneEvent);<br>
=C2=A0err1:<br>
=C2=A0 =C2=A0 =C2=A0qemu_del_wait_object(stdio-&gt;hStdIn, NULL, NULL);<br>
+=C2=A0 =C2=A0 return false;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_win_stdio_finalize(Object *obj)<br>
diff --git a/chardev/msmouse.c b/chardev/msmouse.c<br>
index 9dc04e3b3e..365f04546e 100644<br>
--- a/chardev/msmouse.c<br>
+++ b/chardev/msmouse.c<br>
@@ -253,7 +253,7 @@ static void char_msmouse_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0fifo8_destroy(&amp;mouse-&gt;outbuf);<br>
=C2=A0}<br>
<br>
-static void msmouse_chr_open(Chardev *chr,<br>
+static bool msmouse_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
@@ -265,6 +265,7 @@ static void msmouse_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0fifo8_create(&amp;mouse-&gt;outbuf, MSMOUSE_BUF_SZ);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0/* Never send CHR_EVENT_OPENED */<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_msmouse_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/chardev/spice.c b/chardev/spice.c<br>
index f5b1f585eb..ad97d98ac6 100644<br>
--- a/chardev/spice.c<br>
+++ b/chardev/spice.c<br>
@@ -251,7 +251,7 @@ static void chr_open(Chardev *chr, const char *subtype)=
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;sin.subtype =3D g_strdup(subtype);<br>
=C2=A0}<br>
<br>
-static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,<br>
+static bool spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevSpiceChannel *spicevmc =3D backend-&gt;u.spicevm=
c.data;<br>
@@ -272,13 +272,14 @@ static void spice_vmc_chr_open(Chardev *chr, ChardevB=
ackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0subtypes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(subtypes);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0chr_open(chr, type);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
-static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,<br>
+static bool spice_port_chr_open(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevSpicePort *spiceport =3D backend-&gt;u.spiceport=
.data;<br>
@@ -287,12 +288,12 @@ static void spice_port_chr_open(Chardev *chr, Chardev=
Backend *backend,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (name =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;missing name param=
eter&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!using_spice) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;spice not enabled&=
quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0chr_open(chr, &quot;port&quot;);<br>
@@ -301,6 +302,7 @@ static void spice_port_chr_open(Chardev *chr, ChardevBa=
ckend *backend,<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;sin.portname =3D g_strdup(name);<br>
<br>
=C2=A0 =C2=A0 =C2=A0vmc_register_interface(s);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void spice_vmc_chr_parse(QemuOpts *opts, ChardevBackend *backe=
nd,<br>
diff --git a/chardev/wctablet.c b/chardev/wctablet.c<br>
index 65b2ceb58c..214d5ca2e2 100644<br>
--- a/chardev/wctablet.c<br>
+++ b/chardev/wctablet.c<br>
@@ -324,7 +324,7 @@ static void wctablet_chr_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void wctablet_chr_open(Chardev *chr,<br>
+static bool wctablet_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
@@ -339,6 +339,7 @@ static void wctablet_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;wctablet_handler);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void wctablet_chr_class_init(ObjectClass *oc, const void *data=
)<br>
diff --git a/gdbstub/system.c b/gdbstub/system.c<br>
index 49da1f73cc..ec24d812b3 100644<br>
--- a/gdbstub/system.c<br>
+++ b/gdbstub/system.c<br>
@@ -233,9 +233,10 @@ static int gdb_chr_write(Chardev *chr, const uint8_t *=
buf, int len)<br>
=C2=A0 =C2=A0 =C2=A0return len;<br>
=C2=A0}<br>
<br>
-static void gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
+static bool gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Never send CHR_EVENT_OPENED */<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_gdb_class_init(ObjectClass *oc, const void *data)<br=
>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index 47c75c3582..23a227dca9 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -260,7 +260,7 @@ struct ChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0void (*chr_parse)(QemuOpts *opts, ChardevBackend *backe=
nd, Error **errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* called after construction, open/starts the backend *=
/<br>
-=C2=A0 =C2=A0 void (*chr_open)(Chardev *chr, ChardevBackend *backend, Erro=
r **errp);<br>
+=C2=A0 =C2=A0 bool (*chr_open)(Chardev *chr, ChardevBackend *backend, Erro=
r **errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* write buf to the backend */<br>
=C2=A0 =C2=A0 =C2=A0int (*chr_write)(Chardev *s, const uint8_t *buf, int le=
n);<br>
diff --git a/ui/console-vc.c b/ui/console-vc.c<br>
index 4c8ea4c148..f22806fed7 100644<br>
--- a/ui/console-vc.c<br>
+++ b/ui/console-vc.c<br>
@@ -1093,7 +1093,7 @@ void qemu_text_console_update_size(QemuTextConsole *c=
)<br>
=C2=A0 =C2=A0 =C2=A0dpy_text_resize(QEMU_CONSOLE(c), c-&gt;width, c-&gt;hei=
ght);<br>
=C2=A0}<br>
<br>
-static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **err=
p)<br>
+static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **err=
p)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevVC *vc =3D backend-&gt;u.vc.data;<br>
=C2=A0 =C2=A0 =C2=A0VCChardev *drv =3D VC_CHARDEV(chr);<br>
@@ -1142,6 +1142,7 @@ static void vc_chr_open(Chardev *chr, ChardevBackend =
*backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Err=
or **errp)<br>
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c<br>
index 3e471f84cd..9442b47551 100644<br>
--- a/ui/dbus-chardev.c<br>
+++ b/ui/dbus-chardev.c<br>
@@ -176,7 +176,7 @@ dbus_chr_send_break(<br>
=C2=A0 =C2=A0 =C2=A0return DBUS_METHOD_INVOCATION_HANDLED;<br>
=C2=A0}<br>
<br>
-static void dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
+static bool dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ERRP_GUARD();<br>
<br>
@@ -206,9 +206,9 @@ static void dbus_chr_open(Chardev *chr, ChardevBackend =
*backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET)=
)-&gt;chr_parse(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opts, be, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (*errp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))-&gt=
;chr_open(<br>
+=C2=A0 =C2=A0 return CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKE=
T))-&gt;chr_open(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr, be, errp);<br>
=C2=A0}<br>
<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index 3eeb5baa11..e2c0135646 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -1967,7 +1967,7 @@ static void gd_vc_chr_open(Chardev *chr, ChardevBacke=
nd *backend, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (nb_vcs =3D=3D MAX_VCS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Maximum number of =
consoles reached&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0vcs[nb_vcs++] =3D chr;<br>
@@ -1976,13 +1976,14 @@ static void gd_vc_chr_open(Chardev *chr, ChardevBac=
kend *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 * console/chardev init sometimes completes elsewhere i=
n a 2nd<br>
=C2=A0 =C2=A0 =C2=A0 * stage, so defer OPENED events until they are fully i=
nitialized<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void char_gd_vc_class_init(ObjectClass *oc, const void *data)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;chr_open =3D gd_vc_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D char_gtk_init;<br></blockquote><div><br>=
</div><div>Bad rename, and missing corrected return type (I&#39;ll fix on c=
ommit if no more changes)</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D gd_vc_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D gd_vc_chr_accept_input;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_echo =3D gd_vc_chr_set_echo;<br>
diff --git a/ui/spice-app.c b/ui/spice-app.c<br>
index 7ac9ae4e78..9e55f27371 100644<br>
--- a/ui/spice-app.c<br>
+++ b/ui/spice-app.c<br>
@@ -49,7 +49,7 @@ struct VCChardev {<br>
<br>
=C2=A0struct VCChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass parent;<br>
-=C2=A0 =C2=A0 void (*parent_open)(Chardev *chr, ChardevBackend *backend, E=
rror **errp);<br>
+=C2=A0 =C2=A0 bool (*parent_init)(Chardev *chr, ChardevBackend *backend, E=
rror **errp);<br>
=C2=A0};<br>
<br>
=C2=A0#define TYPE_CHARDEV_VC &quot;chardev-vc&quot;<br>
@@ -66,11 +66,12 @@ chr_spice_backend_new(void)<br>
=C2=A0 =C2=A0 =C2=A0return be;<br>
=C2=A0}<br>
<br>
-static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **err=
p)<br>
+static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **err=
p)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VCChardevClass *vc =3D CHARDEV_VC_GET_CLASS(chr);<br>
=C2=A0 =C2=A0 =C2=A0ChardevBackend *be;<br>
=C2=A0 =C2=A0 =C2=A0const char *fqdn =3D NULL;<br>
+=C2=A0 =C2=A0 bool ok;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (strstart(chr-&gt;label, &quot;serial&quot;, NULL)) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fqdn =3D &quot;org.qemu.console.serial.0&=
quot;;<br>
@@ -83,8 +84,9 @@ static void vc_chr_open(Chardev *chr, ChardevBackend *bac=
kend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0be =3D chr_spice_backend_new();<br>
=C2=A0 =C2=A0 =C2=A0be-&gt;u.spiceport.data-&gt;fqdn =3D fqdn ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_strdup(fqdn) : g_strdup_printf(&quot;or=
g.qemu.console.%s&quot;, chr-&gt;label);<br>
-=C2=A0 =C2=A0 vc-&gt;parent_open(chr, be, errp);<br>
+=C2=A0 =C2=A0 ok =3D vc-&gt;parent_init(chr, be, errp);<br>
=C2=A0 =C2=A0 =C2=A0qapi_free_ChardevBackend(be);<br>
+=C2=A0 =C2=A0 return ok;<br>
=C2=A0}<br>
<br>
=C2=A0static void vc_chr_set_echo(Chardev *chr, bool echo)<br>
@@ -102,7 +104,7 @@ static void char_vc_class_init(ObjectClass *oc, const v=
oid *data)<br>
=C2=A0 =C2=A0 =C2=A0VCChardevClass *vc =3D CHARDEV_VC_CLASS(oc);<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 vc-&gt;parent_open =3D cc-&gt;chr_open;<br>
+=C2=A0 =C2=A0 vc-&gt;parent_init =3D cc-&gt;chr_open;<br>
<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_parse =3D vc_chr_parse;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_open =3D vc_chr_open;<br>
diff --git a/ui/vdagent.c b/ui/vdagent.c<br>
index 3becc6c076..d5c6e3340b 100644<br>
--- a/ui/vdagent.c<br>
+++ b/ui/vdagent.c<br>
@@ -660,8 +660,7 @@ static void vdagent_chr_recv_clipboard(VDAgentChardev *=
vd, VDAgentMessage *msg)<br>
=C2=A0/* ------------------------------------------------------------------=
 */<br>
=C2=A0/* chardev backend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
<br>
-static void vdagent_chr_open(Chardev *chr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
+static bool vdagent_chr_open(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(chr);<br>
@@ -673,7 +672,7 @@ static void vdagent_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 * so we have to byteswap everything on BE hosts.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;vdagent is not supported on bige=
ndian hosts&quot;);<br>
-=C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 return false;<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0vd-&gt;mouse =3D VDAGENT_MOUSE_DEFAULT;<br>
@@ -692,6 +691,7 @@ static void vdagent_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_EVENT_OPENED);<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void vdagent_clipboard_peer_register(VDAgentChardev *vd)<br>
@@ -1074,7 +1074,7 @@ static const VMStateDescription vmstate_vdagent =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
-static void vdagent_chr_init(Object *obj)<br>
+static void vdagent_chr_instance_init(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);<br>
<br>
@@ -1097,7 +1097,7 @@ static const TypeInfo vdagent_chr_type_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_CHARDEV_QEMU_VDAGENT,<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_CHARDEV,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(VDAgentChardev),<br>
-=C2=A0 =C2=A0 .instance_init =3D vdagent_chr_init,<br>
+=C2=A0 =C2=A0 .instance_init =3D vdagent_chr_instance_init,<br>
=C2=A0 =C2=A0 =C2=A0.instance_finalize =3D vdagent_chr_fini,<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D vdagent_chr_class_init,<br>
=C2=A0};<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--0000000000002f750d064535f506--


