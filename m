Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96DCD32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXTN-0004Z8-DB; Fri, 05 Dec 2025 10:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXTD-0004MA-6c
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXT9-0001Ud-8m
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764947498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M6J70z683XM/H8iChCKKY14GUS9h+lZsb+UG2AXtgeM=;
 b=iomJxrl83rIeJFdLiA6Kodx/CSRVKOaWYn2JpCni6JMlb4sBViDegPsQIQuMoRwct2UJBw
 DG/atVPIJFnOat6agB/COpSAembrHfBPyy5Y9LwP+Z0g/MMBVH33QIDf4b930fuurCvOr7
 CWaUV0rPVyYSMmVGjDyQe9HGhucaSPU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-7eH7CvtfMcSa-hrVf2NwWA-1; Fri, 05 Dec 2025 10:11:36 -0500
X-MC-Unique: 7eH7CvtfMcSa-hrVf2NwWA-1
X-Mimecast-MFC-AGG-ID: 7eH7CvtfMcSa-hrVf2NwWA_1764947495
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3437f0760daso4235776a91.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764947493; x=1765552293; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M6J70z683XM/H8iChCKKY14GUS9h+lZsb+UG2AXtgeM=;
 b=NJIv/BRB+DRF2wD3yflt1XZlJji11ek1HafUUQluKAe6YJQBl1tTIu77zzDCaommfe
 HFXPBdMqnS8PJ8WIUqXDpejR5IDOJmdgNH+IbeDHC8qZlklIUtw2lPmhSfklXxxqFs+n
 /JUtHl9qI0O0yeydYpB7GXJ4BssTvCx17epbSZVlwvCuMU+7eKKZt+a5X1M4KxMDjJOp
 63he2QJYczamKjzwsSEe08ahRmt833NHn3QeUsjNHxffMw4rir1fS0YOJVVaTBoxy3xh
 ZTgbFXKZDLuu0RLXyKQxmUKjiDC4hPfHxlmixSVzXWNJuNwjeKGl0MqVNFReQvGqmFac
 J4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947493; x=1765552293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6J70z683XM/H8iChCKKY14GUS9h+lZsb+UG2AXtgeM=;
 b=TcRSN3LeJwobrMfNOTk1FFFwTqxjhOIUHI0b8RRJGvPI3V4Oyz9QS3X8mHZ6hzx5J4
 hbVe5jA98XlTcZlATYh3BiOIspyk8WB0ZBH8crpBNy0F6Hq2heGUOQ1qzf1GlC1Tq5Dy
 HRd2IvTWx2JsR+yeNe2m6jrb/bSUsTAZkGCMXUHlKbrG4zjQQ8bRD8yj5AHoFNz7lEOm
 2Mo1a1p8jdRUOGEKi1T1O7HwbzyFlK9hZUYS8ufDG1dGCYcGeUOELV/4fW/dIlqejDZH
 3I3cn82eiDfby2u0COOr/hCFyz8TBcm4fyAdYyFdI+020ZvAWQdGGeO5Z1TA5Pp/JWz1
 Wrxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMY52XEs5gJk6cSW0PXKTAxu44SYsBknWvbJjeOk/S/uXK4EvF0NRTsm6y0cIsV4qrIY3In129SuEr@nongnu.org
X-Gm-Message-State: AOJu0Yz8be1zpM08LgJgjndvK8N0P4xP+mOy2BagdZ37jglALwlLvxyV
 /kSqVkL7hIE8fF2lVCJBV7TOoOldiaAY+K6tOSiusPZzVziCXVuG//TUbpGxAC0gDPYu7hR/h3T
 HkzPO8nNPRaApx5qL5qPaKQIQcAh8B2rKGaTvYFIwI6Q2uQCm36WHFeSRfVKg8OJ+SORvd/Ojnh
 j/LwZgVVwRBMvZHl9Pcxmy3i0+FXmrdk4=
X-Gm-Gg: ASbGncvTlavo95RuT7yLdjx0I+ALMsptvo5VuXh5iojAkVEImFx5UA37fun9ENH3A/v
 a97s+5FDPpPZk4fb1zI8Lqod6lxfl6q+NoyEaoJHFnp95FnCPtiuHdK2SDKpXOy5G1bPJ2oBnIy
 OmlWgVwXlcVxbCmyKYjddSrmK695XWad3AR0ebFLlKzNL1IQhhsLyIMkJ0u4sFcZg5BJt+xCum0
 P+h3J5wR3ITQNeQGyY1bdU8mQ==
X-Received: by 2002:a17:90b:1346:b0:343:f509:aa4a with SMTP id
 98e67ed59e1d1-34912847ac7mr9715331a91.36.1764947492820; 
 Fri, 05 Dec 2025 07:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzPlvjexJXJ23MEQXWlvaKUDpEHiLzc7JzylM1Yr4tBG4SQZrTl0XVOoiT20ZPWj0cQ5jGxK58Qogv/FiarMY=
X-Received: by 2002:a17:90b:1346:b0:343:f509:aa4a with SMTP id
 98e67ed59e1d1-34912847ac7mr9715303a91.36.1764947492384; Fri, 05 Dec 2025
 07:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-4-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-4-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:11:20 +0400
X-Gm-Features: AWmQ_bl3gWQJD0cRak2KyovEMJXX25-ysLEflCdYgaOpsAmN_LZIhDz9cyn9Uqg
Message-ID: <CAMxuvaxXzJuWbmp+UhsZtrcEWNROFnZZObigswyKXU6i8ZB1Ng@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] chardev: ChardevClass: consistent naming for
 handlers
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="00000000000054c62e064535dc13"
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

--00000000000054c62e064535dc13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Most handlers have name prefixed with "chr_". That's a good practice
> which helps to grep them. Convert the rest: .parse, .open,
> get/set_msgfds.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/baum.c                                      | 2 +-
>  chardev/char-console.c                              | 2 +-
>  chardev/char-fe.c                                   | 8 ++++----
>  chardev/char-file.c                                 | 4 ++--
>  chardev/char-hub.c                                  | 4 ++--
>  chardev/char-mux.c                                  | 4 ++--
>  chardev/char-null.c                                 | 2 +-
>  chardev/char-parallel.c                             | 4 ++--
>  chardev/char-pipe.c                                 | 4 ++--
>  chardev/char-pty.c                                  | 4 ++--
>  chardev/char-ringbuf.c                              | 4 ++--
>  chardev/char-serial.c                               | 4 ++--
>  chardev/char-socket.c                               | 8 ++++----
>  chardev/char-stdio.c                                | 4 ++--
>  chardev/char-udp.c                                  | 4 ++--
>  chardev/char-win-stdio.c                            | 2 +-
>  chardev/char.c                                      | 8 ++++----
>  chardev/msmouse.c                                   | 2 +-
>  chardev/spice.c                                     | 8 ++++----
>  chardev/wctablet.c                                  | 2 +-
>  gdbstub/system.c                                    | 2 +-
>  include/chardev/char.h                              | 8 ++++----
>  scripts/codeconverter/codeconverter/test_regexps.py | 2 +-
>  ui/console-vc.c                                     | 4 ++--
>  ui/dbus-chardev.c                                   | 8 ++++----
>  ui/dbus.c                                           | 4 ++--
>  ui/gtk.c                                            | 2 +-
>  ui/spice-app.c                                      | 6 +++---
>  ui/vdagent.c                                        | 4 ++--
>  29 files changed, 62 insertions(+), 62 deletions(-)
>
> diff --git a/chardev/baum.c b/chardev/baum.c
> index ad68321504..6b81c97d10 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -676,7 +676,7 @@ static void char_braille_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->open =3D baum_chr_open;
> +    cc->chr_open =3D baum_chr_open;
>      cc->chr_write =3D baum_chr_write;
>      cc->chr_accept_input =3D baum_chr_accept_input;
>  }
> diff --git a/chardev/char-console.c b/chardev/char-console.c
> index 7e1bf642eb..9a2e012d53 100644
> --- a/chardev/char-console.c
> +++ b/chardev/char-console.c
> @@ -38,7 +38,7 @@ static void char_console_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->open =3D qemu_chr_open_win_con;
> +    cc->chr_open =3D qemu_chr_open_win_con;
>  }
>
>  static const TypeInfo char_console_type_info =3D {
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 34b83fc1c4..a44f267373 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -130,8 +130,8 @@ int qemu_chr_fe_get_msgfds(CharFrontend *c, int *fds,
> int len)
>          return -1;
>      }
>
> -    return CHARDEV_GET_CLASS(s)->get_msgfds ?
> -        CHARDEV_GET_CLASS(s)->get_msgfds(s, fds, len) : -1;
> +    return CHARDEV_GET_CLASS(s)->chr_get_msgfds ?
> +        CHARDEV_GET_CLASS(s)->chr_get_msgfds(s, fds, len) : -1;
>  }
>
>  int qemu_chr_fe_set_msgfds(CharFrontend *c, int *fds, int num)
> @@ -142,8 +142,8 @@ int qemu_chr_fe_set_msgfds(CharFrontend *c, int *fds,
> int num)
>          return -1;
>      }
>
> -    return CHARDEV_GET_CLASS(s)->set_msgfds ?
> -        CHARDEV_GET_CLASS(s)->set_msgfds(s, fds, num) : -1;
> +    return CHARDEV_GET_CLASS(s)->chr_set_msgfds ?
> +        CHARDEV_GET_CLASS(s)->chr_set_msgfds(s, fds, num) : -1;
>  }
>
>  void qemu_chr_fe_accept_input(CharFrontend *c)
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 1f7adf592f..1e293e7054 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -133,8 +133,8 @@ static void char_file_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_file_out;
> -    cc->open =3D qmp_chardev_open_file;
> +    cc->chr_parse =3D qemu_chr_parse_file_out;
> +    cc->chr_open =3D qmp_chardev_open_file;
>  }
>
>  static const TypeInfo char_file_type_info =3D {
> diff --git a/chardev/char-hub.c b/chardev/char-hub.c
> index d0967c2233..082baa84ab 100644
> --- a/chardev/char-hub.c
> +++ b/chardev/char-hub.c
> @@ -276,8 +276,8 @@ static void char_hub_class_init(ObjectClass *oc, cons=
t
> void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_hub;
> -    cc->open =3D qemu_chr_open_hub;
> +    cc->chr_parse =3D qemu_chr_parse_hub;
> +    cc->chr_open =3D qemu_chr_open_hub;
>      cc->chr_write =3D hub_chr_write;
>      cc->chr_add_watch =3D hub_chr_add_watch;
>      /* We handle events from backends only */
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index db9e89f441..c82c2da56d 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -451,8 +451,8 @@ static void char_mux_class_init(ObjectClass *oc, cons=
t
> void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_mux;
> -    cc->open =3D qemu_chr_open_mux;
> +    cc->chr_parse =3D qemu_chr_parse_mux;
> +    cc->chr_open =3D qemu_chr_open_mux;
>      cc->chr_write =3D mux_chr_write;
>      cc->chr_accept_input =3D mux_chr_accept_input;
>      cc->chr_add_watch =3D mux_chr_add_watch;
> diff --git a/chardev/char-null.c b/chardev/char-null.c
> index 89cb85da79..674603b380 100644
> --- a/chardev/char-null.c
> +++ b/chardev/char-null.c
> @@ -38,7 +38,7 @@ static void char_null_class_init(ObjectClass *oc, const
> void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->open =3D null_chr_open;
> +    cc->chr_open =3D null_chr_open;
>  }
>
>  static const TypeInfo char_null_type_info =3D {
> diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
> index 62a44b2f96..a0839b784b 100644
> --- a/chardev/char-parallel.c
> +++ b/chardev/char-parallel.c
> @@ -274,8 +274,8 @@ static void char_parallel_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_parallel;
> -    cc->open =3D qmp_chardev_open_parallel;
> +    cc->chr_parse =3D qemu_chr_parse_parallel;
> +    cc->chr_open =3D qmp_chardev_open_parallel;
>      cc->chr_ioctl =3D pp_ioctl;
>  }
>
> diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
> index e9f3bb8290..a2cd322efe 100644
> --- a/chardev/char-pipe.c
> +++ b/chardev/char-pipe.c
> @@ -182,8 +182,8 @@ static void char_pipe_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_pipe;
> -    cc->open =3D qemu_chr_open_pipe;
> +    cc->chr_parse =3D qemu_chr_parse_pipe;
> +    cc->chr_open =3D qemu_chr_open_pipe;
>  }
>
>  static const TypeInfo char_pipe_type_info =3D {
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 652b0bd9e7..1a15082b02 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -394,8 +394,8 @@ static void char_pty_class_init(ObjectClass *oc, cons=
t
> void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D char_pty_parse;
> -    cc->open =3D char_pty_open;
> +    cc->chr_parse =3D char_pty_parse;
> +    cc->chr_open =3D char_pty_open;
>      cc->chr_write =3D char_pty_chr_write;
>      cc->chr_update_read_handler =3D pty_chr_update_read_handler;
>      cc->chr_add_watch =3D pty_chr_add_watch;
> diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
> index 98aadb6acf..6d5ba667bb 100644
> --- a/chardev/char-ringbuf.c
> +++ b/chardev/char-ringbuf.c
> @@ -227,8 +227,8 @@ static void char_ringbuf_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_ringbuf;
> -    cc->open =3D qemu_chr_open_ringbuf;
> +    cc->chr_parse =3D qemu_chr_parse_ringbuf;
> +    cc->chr_open =3D qemu_chr_open_ringbuf;
>      cc->chr_write =3D ringbuf_chr_write;
>  }
>
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 4c6ca713eb..97ed7adf73 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -305,8 +305,8 @@ static void char_serial_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_serial;
> -    cc->open =3D qmp_chardev_open_serial;
> +    cc->chr_parse =3D qemu_chr_parse_serial;
> +    cc->chr_open =3D qmp_chardev_open_serial;
>  #ifndef _WIN32
>      cc->chr_ioctl =3D tty_serial_ioctl;
>  #endif
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 26d2f11202..12916af7ff 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1576,14 +1576,14 @@ static void char_socket_class_init(ObjectClass
> *oc, const void *data)
>
>      cc->supports_yank =3D true;
>
> -    cc->parse =3D qemu_chr_parse_socket;
> -    cc->open =3D qmp_chardev_open_socket;
> +    cc->chr_parse =3D qemu_chr_parse_socket;
> +    cc->chr_open =3D qmp_chardev_open_socket;
>      cc->chr_wait_connected =3D tcp_chr_wait_connected;
>      cc->chr_write =3D tcp_chr_write;
>      cc->chr_sync_read =3D tcp_chr_sync_read;
>      cc->chr_disconnect =3D tcp_chr_disconnect;
> -    cc->get_msgfds =3D tcp_get_msgfds;
> -    cc->set_msgfds =3D tcp_set_msgfds;
> +    cc->chr_get_msgfds =3D tcp_get_msgfds;
> +    cc->chr_set_msgfds =3D tcp_set_msgfds;
>      cc->chr_add_client =3D tcp_chr_add_client;
>      cc->chr_add_watch =3D tcp_chr_add_watch;
>      cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index 2568164a10..b7e9af1388 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -142,9 +142,9 @@ static void char_stdio_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_stdio;
> +    cc->chr_parse =3D qemu_chr_parse_stdio;
>  #ifndef _WIN32
> -    cc->open =3D qemu_chr_open_stdio;
> +    cc->chr_open =3D qemu_chr_open_stdio;
>      cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
>  #endif
>  }
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 572fab0ad1..a6f496ac7b 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -223,8 +223,8 @@ static void char_udp_class_init(ObjectClass *oc, cons=
t
> void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_udp;
> -    cc->open =3D qmp_chardev_open_udp;
> +    cc->chr_parse =3D qemu_chr_parse_udp;
> +    cc->chr_open =3D qmp_chardev_open_udp;
>      cc->chr_write =3D udp_chr_write;
>      cc->chr_update_read_handler =3D udp_chr_update_read_handler;
>  }
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index fb802a00b1..26e67aef1c 100644
> --- a/chardev/char-win-stdio.c
> +++ b/chardev/char-win-stdio.c
> @@ -260,7 +260,7 @@ static void char_win_stdio_class_init(ObjectClass *oc=
,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->open =3D qemu_chr_open_stdio;
> +    cc->chr_open =3D qemu_chr_open_stdio;
>      cc->chr_write =3D win_stdio_write;
>      cc->chr_set_echo =3D qemu_chr_set_echo_win_stdio;
>  }
> diff --git a/chardev/char.c b/chardev/char.c
> index 3e432195a5..df37d1df16 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -267,8 +267,8 @@ static void qemu_char_open(Chardev *chr,
> ChardevBackend *backend,
>          }
>      }
>
> -    if (cc->open) {
> -        cc->open(chr, backend, be_opened, errp);
> +    if (cc->chr_open) {
> +        cc->chr_open(chr, backend, be_opened, errp);
>      }
>  }
>
> @@ -604,8 +604,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
> Error **errp)
>      backend =3D g_new0(ChardevBackend, 1);
>      backend->type =3D CHARDEV_BACKEND_KIND_NULL;
>
> -    if (cc->parse) {
> -        cc->parse(opts, backend, &local_err);
> +    if (cc->chr_parse) {
> +        cc->chr_parse(opts, backend, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              qapi_free_ChardevBackend(backend);
> diff --git a/chardev/msmouse.c b/chardev/msmouse.c
> index 1a55755d39..8405016489 100644
> --- a/chardev/msmouse.c
> +++ b/chardev/msmouse.c
> @@ -271,7 +271,7 @@ static void char_msmouse_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->open =3D msmouse_chr_open;
> +    cc->chr_open =3D msmouse_chr_open;
>      cc->chr_write =3D msmouse_chr_write;
>      cc->chr_accept_input =3D msmouse_chr_accept_input;
>      cc->chr_ioctl =3D msmouse_ioctl;
> diff --git a/chardev/spice.c b/chardev/spice.c
> index 39b79d60fb..61caa6d0ef 100644
> --- a/chardev/spice.c
> +++ b/chardev/spice.c
> @@ -364,8 +364,8 @@ static void char_spicevmc_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_spice_vmc;
> -    cc->open =3D qemu_chr_open_spice_vmc;
> +    cc->chr_parse =3D qemu_chr_parse_spice_vmc;
> +    cc->chr_open =3D qemu_chr_open_spice_vmc;
>      cc->chr_set_fe_open =3D spice_vmc_set_fe_open;
>  }
>
> @@ -380,8 +380,8 @@ static void char_spiceport_class_init(ObjectClass *oc=
,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D qemu_chr_parse_spice_port;
> -    cc->open =3D qemu_chr_open_spice_port;
> +    cc->chr_parse =3D qemu_chr_parse_spice_port;
> +    cc->chr_open =3D qemu_chr_open_spice_port;
>      cc->chr_set_fe_open =3D spice_port_set_fe_open;
>  }
>
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 0dc6ef08f5..8285a56e7b 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -346,7 +346,7 @@ static void wctablet_chr_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->open =3D wctablet_chr_open;
> +    cc->chr_open =3D wctablet_chr_open;
>      cc->chr_write =3D wctablet_chr_write;
>      cc->chr_ioctl =3D wctablet_chr_ioctl;
>      cc->chr_accept_input =3D wctablet_chr_accept_input;
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index e2220c1ae4..fe2afeb107 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -244,7 +244,7 @@ static void char_gdb_class_init(ObjectClass *oc, cons=
t
> void *data)
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
>      cc->internal =3D true;
> -    cc->open =3D gdb_monitor_open;
> +    cc->chr_open =3D gdb_monitor_open;
>      cc->chr_write =3D gdb_monitor_write;
>  }
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index b65e9981c1..2baf2a8a1a 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -257,10 +257,10 @@ struct ChardevClass {
>      bool supports_yank;
>
>      /* parse command line options and populate QAPI @backend */
> -    void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
> +    void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error
> **errp);
>
>      /* called after construction, open/starts the backend */
> -    void (*open)(Chardev *chr, ChardevBackend *backend,
> +    void (*chr_open)(Chardev *chr, ChardevBackend *backend,
>                   bool *be_opened, Error **errp);
>
>      /* write buf to the backend */
> @@ -282,10 +282,10 @@ struct ChardevClass {
>      int (*chr_ioctl)(Chardev *s, int cmd, void *arg);
>
>      /* get ancillary-received fds during last read */
> -    int (*get_msgfds)(Chardev *s, int* fds, int num);
> +    int (*chr_get_msgfds)(Chardev *s, int* fds, int num);
>
>      /* set ancillary fds to be sent with next write */
> -    int (*set_msgfds)(Chardev *s, int *fds, int num);
> +    int (*chr_set_msgfds)(Chardev *s, int *fds, int num);
>
>      /* accept the given fd */
>      int (*chr_add_client)(Chardev *chr, int fd);
> diff --git a/scripts/codeconverter/codeconverter/test_regexps.py
> b/scripts/codeconverter/codeconverter/test_regexps.py
> index b00e9ef15b..d3a5cc3ad3 100644
> --- a/scripts/codeconverter/codeconverter/test_regexps.py
> +++ b/scripts/codeconverter/codeconverter/test_regexps.py
> @@ -57,7 +57,7 @@ def fullmatch(regexp, s):
>
>      print(RE_TYPEINFO_START)
>      assert re.search(RE_TYPEINFO_START, r'''
> -    cc->open =3D qmp_chardev_open_file;
> +    cc->chr_open =3D qmp_chardev_open_file;
>  }
>
>  static const TypeInfo char_file_type_info =3D {
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 830842064d..931068d43a 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -1185,8 +1185,8 @@ static void char_vc_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D vc_chr_parse;
> -    cc->open =3D vc_chr_open;
> +    cc->chr_parse =3D vc_chr_parse;
> +    cc->chr_open =3D vc_chr_open;
>      cc->chr_write =3D vc_chr_write;
>      cc->chr_accept_input =3D vc_chr_accept_input;
>      cc->chr_set_echo =3D vc_chr_set_echo;
> diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
> index d05dddaf81..f6c426e220 100644
> --- a/ui/dbus-chardev.c
> +++ b/ui/dbus-chardev.c
> @@ -205,12 +205,12 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend=
,
>      opts =3D qemu_opts_create(qemu_find_opts("chardev"), NULL, 0,
> &error_abort);
>      qemu_opt_set(opts, "server", "on", &error_abort);
>      qemu_opt_set(opts, "wait", "off", &error_abort);
> -    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->parse(
> +    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_parse(
>          opts, be, errp);
>      if (*errp) {
>          return;
>      }
> -    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->open(
> +    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
>          chr, be, be_opened, errp);
>  }
>
> @@ -274,8 +274,8 @@ char_dbus_class_init(ObjectClass *oc, const void *dat=
a)
>      DBusChardevClass *klass =3D DBUS_CHARDEV_CLASS(oc);
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse =3D dbus_chr_parse;
> -    cc->open =3D dbus_chr_open;
> +    cc->chr_parse =3D dbus_chr_parse;
> +    cc->chr_open =3D dbus_chr_open;
>      cc->chr_set_fe_open =3D dbus_chr_set_fe_open;
>      cc->chr_set_echo =3D dbus_chr_set_echo;
>      klass->parent_chr_be_event =3D cc->chr_be_event;
> diff --git a/ui/dbus.c b/ui/dbus.c
> index d2dff33258..31f6eb1189 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -451,8 +451,8 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
>      DBusVCClass *klass =3D DBUS_VC_CLASS(oc);
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    klass->parent_parse =3D cc->parse;
> -    cc->parse =3D dbus_vc_parse;
> +    klass->parent_parse =3D cc->chr_parse;
> +    cc->chr_parse =3D dbus_vc_parse;
>  }
>
>  static const TypeInfo dbus_vc_type_info =3D {
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 48571bedbf..7aa97907ed 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1985,7 +1985,7 @@ static void char_gd_vc_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->open =3D gd_vc_open;
> +    cc->chr_open =3D gd_vc_open;
>      cc->chr_write =3D gd_vc_chr_write;
>      cc->chr_accept_input =3D gd_vc_chr_accept_input;
>      cc->chr_set_echo =3D gd_vc_chr_set_echo;
> diff --git a/ui/spice-app.c b/ui/spice-app.c
> index 24f78f305c..ea0b62a22b 100644
> --- a/ui/spice-app.c
> +++ b/ui/spice-app.c
> @@ -106,10 +106,10 @@ static void char_vc_class_init(ObjectClass *oc,
> const void *data)
>      VCChardevClass *vc =3D CHARDEV_VC_CLASS(oc);
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    vc->parent_open =3D cc->open;
> +    vc->parent_open =3D cc->chr_open;
>
> -    cc->parse =3D vc_chr_parse;
> -    cc->open =3D vc_chr_open;
> +    cc->chr_parse =3D vc_chr_parse;
> +    cc->chr_open =3D vc_chr_open;
>      cc->chr_set_echo =3D vc_chr_set_echo;
>  }
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 660686c9c0..9972a9c476 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -924,8 +924,8 @@ static void vdagent_chr_class_init(ObjectClass *oc,
> const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> -    cc->parse            =3D vdagent_chr_parse;
> -    cc->open             =3D vdagent_chr_open;
> +    cc->chr_parse        =3D vdagent_chr_parse;
> +    cc->chr_open         =3D vdagent_chr_open;
>      cc->chr_write        =3D vdagent_chr_write;
>      cc->chr_set_fe_open  =3D vdagent_chr_set_fe_open;
>      cc->chr_accept_input =3D vdagent_chr_accept_input;
> --
> 2.48.1
>
>

--00000000000054c62e064535dc13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 20=
25 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vs=
ementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Most handlers have name p=
refixed with &quot;chr_&quot;. That&#39;s a good practice<br>
which helps to grep them. Convert the rest: .parse, .open,<br>
get/set_msgfds.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br></=
blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
---<br>
=C2=A0chardev/baum.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 2 +-<br>
=C2=A0chardev/char-console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
8 ++++----<br>
=C2=A0chardev/char-file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++=
--<br>
=C2=A0chardev/char-hub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 +=
+--<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 +=
+--<br>
=C2=A0chardev/char-null.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-=
<br>
=C2=A0chardev/char-parallel.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0chardev/char-pipe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++=
--<br>
=C2=A0chardev/char-pty.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 +=
+--<br>
=C2=A0chardev/char-ringbuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0chardev/char-serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++----=
<br>
=C2=A0chardev/char-stdio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0chardev/char-udp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 +=
+--<br>
=C2=A0chardev/char-win-stdio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 8 ++++----<br>
=C2=A0chardev/msmouse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
2 +-<br>
=C2=A0chardev/spice.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 8 ++++----<br>
=C2=A0chardev/wctablet.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +=
-<br>
=C2=A0gdbstub/system.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 2 +-<br>
=C2=A0include/chardev/char.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 8 ++++----<br=
>
=C2=A0scripts/codeconverter/codeconverter/test_regexps.py | 2 +-<br>
=C2=A0ui/console-vc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 4 ++--<br>
=C2=A0ui/dbus-chardev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
8 ++++----<br>
=C2=A0ui/dbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0ui/spice-app.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 6 +++---<br>
=C2=A0ui/vdagent.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 4 ++--<br>
=C2=A029 files changed, 62 insertions(+), 62 deletions(-)<br>
<br>
diff --git a/chardev/baum.c b/chardev/baum.c<br>
index ad68321504..6b81c97d10 100644<br>
--- a/chardev/baum.c<br>
+++ b/chardev/baum.c<br>
@@ -676,7 +676,7 @@ static void char_braille_class_init(ObjectClass *oc, co=
nst void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D baum_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D baum_chr_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D baum_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D baum_chr_accept_input;<br>
=C2=A0}<br>
diff --git a/chardev/char-console.c b/chardev/char-console.c<br>
index 7e1bf642eb..9a2e012d53 100644<br>
--- a/chardev/char-console.c<br>
+++ b/chardev/char-console.c<br>
@@ -38,7 +38,7 @@ static void char_console_class_init(ObjectClass *oc, cons=
t void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_win_con;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_win_con;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo char_console_type_info =3D {<br>
diff --git a/chardev/char-fe.c b/chardev/char-fe.c<br>
index 34b83fc1c4..a44f267373 100644<br>
--- a/chardev/char-fe.c<br>
+++ b/chardev/char-fe.c<br>
@@ -130,8 +130,8 @@ int qemu_chr_fe_get_msgfds(CharFrontend *c, int *fds, i=
nt len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return CHARDEV_GET_CLASS(s)-&gt;get_msgfds ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHARDEV_GET_CLASS(s)-&gt;get_msgfds(s, fds, le=
n) : -1;<br>
+=C2=A0 =C2=A0 return CHARDEV_GET_CLASS(s)-&gt;chr_get_msgfds ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHARDEV_GET_CLASS(s)-&gt;chr_get_msgfds(s, fds=
, len) : -1;<br>
=C2=A0}<br>
<br>
=C2=A0int qemu_chr_fe_set_msgfds(CharFrontend *c, int *fds, int num)<br>
@@ -142,8 +142,8 @@ int qemu_chr_fe_set_msgfds(CharFrontend *c, int *fds, i=
nt num)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return CHARDEV_GET_CLASS(s)-&gt;set_msgfds ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHARDEV_GET_CLASS(s)-&gt;set_msgfds(s, fds, nu=
m) : -1;<br>
+=C2=A0 =C2=A0 return CHARDEV_GET_CLASS(s)-&gt;chr_set_msgfds ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CHARDEV_GET_CLASS(s)-&gt;chr_set_msgfds(s, fds=
, num) : -1;<br>
=C2=A0}<br>
<br>
=C2=A0void qemu_chr_fe_accept_input(CharFrontend *c)<br>
diff --git a/chardev/char-file.c b/chardev/char-file.c<br>
index 1f7adf592f..1e293e7054 100644<br>
--- a/chardev/char-file.c<br>
+++ b/chardev/char-file.c<br>
@@ -133,8 +133,8 @@ static void char_file_class_init(ObjectClass *oc, const=
 void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_file_out;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qmp_chardev_open_file;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_file_out;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qmp_chardev_open_file;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo char_file_type_info =3D {<br>
diff --git a/chardev/char-hub.c b/chardev/char-hub.c<br>
index d0967c2233..082baa84ab 100644<br>
--- a/chardev/char-hub.c<br>
+++ b/chardev/char-hub.c<br>
@@ -276,8 +276,8 @@ static void char_hub_class_init(ObjectClass *oc, const =
void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_hub;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_hub;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_hub;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_hub;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D hub_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_add_watch =3D hub_chr_add_watch;<br>
=C2=A0 =C2=A0 =C2=A0/* We handle events from backends only */<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
index db9e89f441..c82c2da56d 100644<br>
--- a/chardev/char-mux.c<br>
+++ b/chardev/char-mux.c<br>
@@ -451,8 +451,8 @@ static void char_mux_class_init(ObjectClass *oc, const =
void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_mux;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_mux;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_mux;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_mux;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D mux_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D mux_chr_accept_input;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_add_watch =3D mux_chr_add_watch;<br>
diff --git a/chardev/char-null.c b/chardev/char-null.c<br>
index 89cb85da79..674603b380 100644<br>
--- a/chardev/char-null.c<br>
+++ b/chardev/char-null.c<br>
@@ -38,7 +38,7 @@ static void char_null_class_init(ObjectClass *oc, const v=
oid *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D null_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D null_chr_open;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo char_null_type_info =3D {<br>
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c<br>
index 62a44b2f96..a0839b784b 100644<br>
--- a/chardev/char-parallel.c<br>
+++ b/chardev/char-parallel.c<br>
@@ -274,8 +274,8 @@ static void char_parallel_class_init(ObjectClass *oc, c=
onst void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_parallel;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qmp_chardev_open_parallel;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_parallel;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qmp_chardev_open_parallel;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_ioctl =3D pp_ioctl;<br>
=C2=A0}<br>
<br>
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c<br>
index e9f3bb8290..a2cd322efe 100644<br>
--- a/chardev/char-pipe.c<br>
+++ b/chardev/char-pipe.c<br>
@@ -182,8 +182,8 @@ static void char_pipe_class_init(ObjectClass *oc, const=
 void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_pipe;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_pipe;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_pipe;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_pipe;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo char_pipe_type_info =3D {<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index 652b0bd9e7..1a15082b02 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -394,8 +394,8 @@ static void char_pty_class_init(ObjectClass *oc, const =
void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D char_pty_parse;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D char_pty_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D char_pty_parse;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D char_pty_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D char_pty_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_update_read_handler =3D pty_chr_update_read_=
handler;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_add_watch =3D pty_chr_add_watch;<br>
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c<br>
index 98aadb6acf..6d5ba667bb 100644<br>
--- a/chardev/char-ringbuf.c<br>
+++ b/chardev/char-ringbuf.c<br>
@@ -227,8 +227,8 @@ static void char_ringbuf_class_init(ObjectClass *oc, co=
nst void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_ringbuf;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_ringbuf;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_ringbuf;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_ringbuf;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D ringbuf_chr_write;<br>
=C2=A0}<br>
<br>
diff --git a/chardev/char-serial.c b/chardev/char-serial.c<br>
index 4c6ca713eb..97ed7adf73 100644<br>
--- a/chardev/char-serial.c<br>
+++ b/chardev/char-serial.c<br>
@@ -305,8 +305,8 @@ static void char_serial_class_init(ObjectClass *oc, con=
st void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_serial;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qmp_chardev_open_serial;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_serial;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qmp_chardev_open_serial;<br>
=C2=A0#ifndef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_ioctl =3D tty_serial_ioctl;<br>
=C2=A0#endif<br>
diff --git a/chardev/char-socket.c b/chardev/char-socket.c<br>
index 26d2f11202..12916af7ff 100644<br>
--- a/chardev/char-socket.c<br>
+++ b/chardev/char-socket.c<br>
@@ -1576,14 +1576,14 @@ static void char_socket_class_init(ObjectClass *oc,=
 const void *data)<br>
<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;supports_yank =3D true;<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_socket;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qmp_chardev_open_socket;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_socket;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qmp_chardev_open_socket;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_wait_connected =3D tcp_chr_wait_connected;<b=
r>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D tcp_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_sync_read =3D tcp_chr_sync_read;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_disconnect =3D tcp_chr_disconnect;<br>
-=C2=A0 =C2=A0 cc-&gt;get_msgfds =3D tcp_get_msgfds;<br>
-=C2=A0 =C2=A0 cc-&gt;set_msgfds =3D tcp_set_msgfds;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_get_msgfds =3D tcp_get_msgfds;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_set_msgfds =3D tcp_set_msgfds;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_add_client =3D tcp_chr_add_client;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_add_watch =3D tcp_chr_add_watch;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_update_read_handler =3D tcp_chr_update_read_=
handler;<br>
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c<br>
index 2568164a10..b7e9af1388 100644<br>
--- a/chardev/char-stdio.c<br>
+++ b/chardev/char-stdio.c<br>
@@ -142,9 +142,9 @@ static void char_stdio_class_init(ObjectClass *oc, cons=
t void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_stdio;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_stdio;<br>
=C2=A0#ifndef _WIN32<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_stdio;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_stdio;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_echo =3D qemu_chr_set_echo_stdio;<br>
=C2=A0#endif<br>
=C2=A0}<br>
diff --git a/chardev/char-udp.c b/chardev/char-udp.c<br>
index 572fab0ad1..a6f496ac7b 100644<br>
--- a/chardev/char-udp.c<br>
+++ b/chardev/char-udp.c<br>
@@ -223,8 +223,8 @@ static void char_udp_class_init(ObjectClass *oc, const =
void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_udp;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qmp_chardev_open_udp;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_udp;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qmp_chardev_open_udp;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D udp_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_update_read_handler =3D udp_chr_update_read_=
handler;<br>
=C2=A0}<br>
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c<br>
index fb802a00b1..26e67aef1c 100644<br>
--- a/chardev/char-win-stdio.c<br>
+++ b/chardev/char-win-stdio.c<br>
@@ -260,7 +260,7 @@ static void char_win_stdio_class_init(ObjectClass *oc, =
const void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_stdio;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_stdio;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D win_stdio_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_echo =3D qemu_chr_set_echo_win_stdio;<br=
>
=C2=A0}<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 3e432195a5..df37d1df16 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -267,8 +267,8 @@ static void qemu_char_open(Chardev *chr, ChardevBackend=
 *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (cc-&gt;open) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;open(chr, backend, be_opened, errp);<br=
>
+=C2=A0 =C2=A0 if (cc-&gt;chr_open) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;chr_open(chr, backend, be_opened, errp)=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -604,8 +604,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0backend =3D g_new0(ChardevBackend, 1);<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_NULL;<br>
<br>
-=C2=A0 =C2=A0 if (cc-&gt;parse) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;parse(opts, backend, &amp;local_err);<b=
r>
+=C2=A0 =C2=A0 if (cc-&gt;chr_parse) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc-&gt;chr_parse(opts, backend, &amp;local_err=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local=
_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_free_ChardevBackend(ba=
ckend);<br>
diff --git a/chardev/msmouse.c b/chardev/msmouse.c<br>
index 1a55755d39..8405016489 100644<br>
--- a/chardev/msmouse.c<br>
+++ b/chardev/msmouse.c<br>
@@ -271,7 +271,7 @@ static void char_msmouse_class_init(ObjectClass *oc, co=
nst void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D msmouse_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D msmouse_chr_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D msmouse_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D msmouse_chr_accept_input;<b=
r>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_ioctl =3D msmouse_ioctl;<br>
diff --git a/chardev/spice.c b/chardev/spice.c<br>
index 39b79d60fb..61caa6d0ef 100644<br>
--- a/chardev/spice.c<br>
+++ b/chardev/spice.c<br>
@@ -364,8 +364,8 @@ static void char_spicevmc_class_init(ObjectClass *oc, c=
onst void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_spice_vmc;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_spice_vmc;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_spice_vmc;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_spice_vmc;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_fe_open =3D spice_vmc_set_fe_open;<br>
=C2=A0}<br>
<br>
@@ -380,8 +380,8 @@ static void char_spiceport_class_init(ObjectClass *oc, =
const void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_spice_port;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_spice_port;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D qemu_chr_parse_spice_port;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qemu_chr_open_spice_port;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_fe_open =3D spice_port_set_fe_open;<br>
=C2=A0}<br>
<br>
diff --git a/chardev/wctablet.c b/chardev/wctablet.c<br>
index 0dc6ef08f5..8285a56e7b 100644<br>
--- a/chardev/wctablet.c<br>
+++ b/chardev/wctablet.c<br>
@@ -346,7 +346,7 @@ static void wctablet_chr_class_init(ObjectClass *oc, co=
nst void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D wctablet_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D wctablet_chr_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D wctablet_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_ioctl =3D wctablet_chr_ioctl;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D wctablet_chr_accept_input;<=
br>
diff --git a/gdbstub/system.c b/gdbstub/system.c<br>
index e2220c1ae4..fe2afeb107 100644<br>
--- a/gdbstub/system.c<br>
+++ b/gdbstub/system.c<br>
@@ -244,7 +244,7 @@ static void char_gdb_class_init(ObjectClass *oc, const =
void *data)<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;internal =3D true;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D gdb_monitor_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D gdb_monitor_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D gdb_monitor_write;<br>
=C2=A0}<br>
<br>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index b65e9981c1..2baf2a8a1a 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -257,10 +257,10 @@ struct ChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0bool supports_yank;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* parse command line options and populate QAPI @backen=
d */<br>
-=C2=A0 =C2=A0 void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error=
 **errp);<br>
+=C2=A0 =C2=A0 void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, E=
rror **errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* called after construction, open/starts the backend *=
/<br>
-=C2=A0 =C2=A0 void (*open)(Chardev *chr, ChardevBackend *backend,<br>
+=C2=A0 =C2=A0 void (*chr_open)(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_ope=
ned, Error **errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* write buf to the backend */<br>
@@ -282,10 +282,10 @@ struct ChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0int (*chr_ioctl)(Chardev *s, int cmd, void *arg);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* get ancillary-received fds during last read */<br>
-=C2=A0 =C2=A0 int (*get_msgfds)(Chardev *s, int* fds, int num);<br>
+=C2=A0 =C2=A0 int (*chr_get_msgfds)(Chardev *s, int* fds, int num);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* set ancillary fds to be sent with next write */<br>
-=C2=A0 =C2=A0 int (*set_msgfds)(Chardev *s, int *fds, int num);<br>
+=C2=A0 =C2=A0 int (*chr_set_msgfds)(Chardev *s, int *fds, int num);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* accept the given fd */<br>
=C2=A0 =C2=A0 =C2=A0int (*chr_add_client)(Chardev *chr, int fd);<br>
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/=
codeconverter/codeconverter/test_regexps.py<br>
index b00e9ef15b..d3a5cc3ad3 100644<br>
--- a/scripts/codeconverter/codeconverter/test_regexps.py<br>
+++ b/scripts/codeconverter/codeconverter/test_regexps.py<br>
@@ -57,7 +57,7 @@ def fullmatch(regexp, s):<br>
<br>
=C2=A0 =C2=A0 =C2=A0print(RE_TYPEINFO_START)<br>
=C2=A0 =C2=A0 =C2=A0assert re.search(RE_TYPEINFO_START, r&#39;&#39;&#39;<br=
>
-=C2=A0 =C2=A0 cc-&gt;open =3D qmp_chardev_open_file;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D qmp_chardev_open_file;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo char_file_type_info =3D {<br>
diff --git a/ui/console-vc.c b/ui/console-vc.c<br>
index 830842064d..931068d43a 100644<br>
--- a/ui/console-vc.c<br>
+++ b/ui/console-vc.c<br>
@@ -1185,8 +1185,8 @@ static void char_vc_class_init(ObjectClass *oc, const=
 void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D vc_chr_parse;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D vc_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D vc_chr_parse;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D vc_chr_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D vc_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D vc_chr_accept_input;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_echo =3D vc_chr_set_echo;<br>
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c<br>
index d05dddaf81..f6c426e220 100644<br>
--- a/ui/dbus-chardev.c<br>
+++ b/ui/dbus-chardev.c<br>
@@ -205,12 +205,12 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,<=
br>
=C2=A0 =C2=A0 =C2=A0opts =3D qemu_opts_create(qemu_find_opts(&quot;chardev&=
quot;), NULL, 0, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0qemu_opt_set(opts, &quot;server&quot;, &quot;on&quot;, =
&amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0qemu_opt_set(opts, &quot;wait&quot;, &quot;off&quot;, &=
amp;error_abort);<br>
-=C2=A0 =C2=A0 CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))-&gt=
;parse(<br>
+=C2=A0 =C2=A0 CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))-&gt=
;chr_parse(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opts, be, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (*errp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))-&gt=
;open(<br>
+=C2=A0 =C2=A0 CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))-&gt=
;chr_open(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr, be, be_opened, errp);<br>
=C2=A0}<br>
<br>
@@ -274,8 +274,8 @@ char_dbus_class_init(ObjectClass *oc, const void *data)=
<br>
=C2=A0 =C2=A0 =C2=A0DBusChardevClass *klass =3D DBUS_CHARDEV_CLASS(oc);<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D dbus_chr_parse;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D dbus_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D dbus_chr_parse;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D dbus_chr_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_fe_open =3D dbus_chr_set_fe_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_echo =3D dbus_chr_set_echo;<br>
=C2=A0 =C2=A0 =C2=A0klass-&gt;parent_chr_be_event =3D cc-&gt;chr_be_event;<=
br>
diff --git a/ui/dbus.c b/ui/dbus.c<br>
index d2dff33258..31f6eb1189 100644<br>
--- a/ui/dbus.c<br>
+++ b/ui/dbus.c<br>
@@ -451,8 +451,8 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)<b=
r>
=C2=A0 =C2=A0 =C2=A0DBusVCClass *klass =3D DBUS_VC_CLASS(oc);<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 klass-&gt;parent_parse =3D cc-&gt;parse;<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D dbus_vc_parse;<br>
+=C2=A0 =C2=A0 klass-&gt;parent_parse =3D cc-&gt;chr_parse;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D dbus_vc_parse;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo dbus_vc_type_info =3D {<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index 48571bedbf..7aa97907ed 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -1985,7 +1985,7 @@ static void char_gd_vc_class_init(ObjectClass *oc, co=
nst void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D gd_vc_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D gd_vc_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D gd_vc_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D gd_vc_chr_accept_input;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_echo =3D gd_vc_chr_set_echo;<br>
diff --git a/ui/spice-app.c b/ui/spice-app.c<br>
index 24f78f305c..ea0b62a22b 100644<br>
--- a/ui/spice-app.c<br>
+++ b/ui/spice-app.c<br>
@@ -106,10 +106,10 @@ static void char_vc_class_init(ObjectClass *oc, const=
 void *data)<br>
=C2=A0 =C2=A0 =C2=A0VCChardevClass *vc =3D CHARDEV_VC_CLASS(oc);<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 vc-&gt;parent_open =3D cc-&gt;open;<br>
+=C2=A0 =C2=A0 vc-&gt;parent_open =3D cc-&gt;chr_open;<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse =3D vc_chr_parse;<br>
-=C2=A0 =C2=A0 cc-&gt;open =3D vc_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse =3D vc_chr_parse;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open =3D vc_chr_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_echo =3D vc_chr_set_echo;<br>
=C2=A0}<br>
<br>
diff --git a/ui/vdagent.c b/ui/vdagent.c<br>
index 660686c9c0..9972a9c476 100644<br>
--- a/ui/vdagent.c<br>
+++ b/ui/vdagent.c<br>
@@ -924,8 +924,8 @@ static void vdagent_chr_class_init(ObjectClass *oc, con=
st void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
<br>
-=C2=A0 =C2=A0 cc-&gt;parse=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D vd=
agent_chr_parse;<br>
-=C2=A0 =C2=A0 cc-&gt;open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D vdagent_chr_open;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_parse=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D vdagent_chr_=
parse;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D vdagent=
_chr_open;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D vdagent=
_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_set_fe_open=C2=A0 =3D vdagent_chr_set_fe_ope=
n;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_accept_input =3D vdagent_chr_accept_input;<b=
r>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--00000000000054c62e064535dc13--


