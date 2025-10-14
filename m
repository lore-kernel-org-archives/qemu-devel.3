Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2263CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZVH-0006b0-Li; Tue, 14 Oct 2025 03:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZVD-0006VJ-RJ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:25 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZVC-0004v6-36
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:23 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-78f15d5846dso82773056d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760427081; x=1761031881; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pK3hGy8gQaunyTuvyJ1gtkdEz4Adpj0UtdCSBrh+yCc=;
 b=DH2S7xglaWRNiSzdbWojIv6TFaghgWMipOdrXh0uitMllJzm+Kq4hYi/Wh+POYzxRH
 s4y0qWKpPA5iI6pN1hEHqlpQls4EhMJaMyIrPuOzvO65nL28DFdEvqGAdcy3Z7PkRbCB
 8Ul2mcd3bLdhIdmG47phWOfEyi09MX14ptZlKj5o2bFScULWgpj3uTW7Xr8po8zqdGM5
 vE4Cz5d9shxB1kZ2LEGEseHLR+OCX1lBkDojunxfXgAPMtlyVtJftniBjhiPtGuvDoxA
 igcMj+iesDdNlxqcFYSoEsoxeuesN5VbHY1aXd/nx0DN3hwJB/fZEumRuPg0EAAmr/L4
 5MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760427081; x=1761031881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pK3hGy8gQaunyTuvyJ1gtkdEz4Adpj0UtdCSBrh+yCc=;
 b=IE9JVRWn5FyT7Ou3CnJxXdp3Vj1hsODT6CUoh/aDj2O2edy3v6UZXI4d7b0IXoVg0E
 5VdKPSTFOgioKROzIQWdYDie7rwrwjiVi0SoFmcTS9pCYOEvKSiEaxkz1bEjFyNw0uZx
 l2ewZQAy5zjVKwcZuJDXRrlXNCOc7PDO0rB9QkBsl7Rqz8uG6JBExKuA5FkVq3MIY4NO
 T2/tmCAB/SgthC8h13GOHyhK88S1w6mUAre6bl+9tQx+qLqsGuQCgJohW1BgX++QKYHy
 oGJSmJt3X4S2SoQ8g8xiJBTzKs9cLnRvRsRlGuI5Ti3IRYFRq/ZSVC8GxdasIeaK4Rry
 rD3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwyB1L7I2C+UfZsEBk4dS7f3DK6JONljtg+i+DTNy4jn7IJ2fxTNf53N5TztkKP1FNwgQw00CkvQ3c@nongnu.org
X-Gm-Message-State: AOJu0Yzz2XFKPZ4QnMnG2qxbtsrswdwjJz4YsPFTspqDpG/bGzQ4PuDY
 BN6yoGqYuXLZGcHkp2DQngZcq2sELMvtaf73So5LfBIfX+4Je6qLzWPcNnMAyPghX7Yl9eJ+nqx
 a67Ddd6kh7pJI8V0Gk9rHr2ZfYVnEmhw=
X-Gm-Gg: ASbGncuFQqdjEYJA+GDSxVpj00pG68H4qheJ7xgjH6zdDkVPDV2PdGshS4zg125+7zx
 YF3KBiBvsb+5My0bMbNTeWU8UtII5iWxPBg9Qh9G2Yy64gIFGw5RP9zvU8ueSKN6OY4QEhtdqBs
 du1bk7KUdMaWGGQXYdE3VyqIXFu1uUvOgwEeeiKVpiP3aEdYzXLBUl+cRz72wQGq9JQkYGwVjdo
 uKp96w7CW6uaId4Sj75kWSxDnFox+xbYVPkZ3ajlMfSi+soVjlR9laIvmIo6aKOei0p
X-Google-Smtp-Source: AGHT+IFWvp1Rm3fFx2ZzlodGMzocEugZMnKmLl7+pxT1sCjpTEvXHr1gWjDJ/a03P8dYSpbd6emXE00L5gYJ0DCur0U=
X-Received: by 2002:a05:622a:409:b0:4d2:2d8b:4e4d with SMTP id
 d75a77b69052e-4e6eace7918mr334376591cf.21.1760427080901; Tue, 14 Oct 2025
 00:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-2-vsementsov@yandex-team.ru>
In-Reply-To: <20251013133836.852018-2-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 11:31:09 +0400
X-Gm-Features: AS18NWBthDP4Wvuj5BFNeF4LTCkaQ_EJo7eloMQ5kTSFXc27Rj0cGlOxIJLoyfE
Message-ID: <CAJ+F1C+=CRRaPHFf2ukSLki6vw0McoA0j3PPAL7gJBfJbSPZYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] chardev/char-socket: simplify reconnect-ms handling
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf34.google.com
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

On Mon, Oct 13, 2025 at 5:39=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We pass it to qmp_chardev_open_socket_client() only to write
> to s->reconnect_time_ms. Let's simply set this field earlier,
> together with other options.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-socket.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 62852e3caf..f3bc6290d2 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1274,18 +1274,16 @@ skip_listen:
>
>
>  static int qmp_chardev_open_socket_client(Chardev *chr,
> -                                          int64_t reconnect_ms,
>                                            Error **errp)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>
> -    if (reconnect_ms > 0) {
> -        s->reconnect_time_ms =3D reconnect_ms;
> +    if (s->reconnect_time_ms > 0) {
>          tcp_chr_connect_client_async(chr);
>          return 0;
> -    } else {
> -        return tcp_chr_connect_client_sync(chr, errp);
>      }
> +
> +    return tcp_chr_connect_client_sync(chr, errp);
>  }
>
>
> @@ -1378,7 +1376,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false;
>      bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
>      bool is_websock     =3D sock->has_websocket ? sock->websocket : fals=
e;
> -    int64_t reconnect_ms =3D sock->has_reconnect_ms ? sock->reconnect_ms=
 : 0;
>      SocketAddress *addr;
>
>      s->is_listen =3D is_listen;
> @@ -1386,6 +1383,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      s->is_tn3270 =3D is_tn3270;
>      s->is_websock =3D is_websock;
>      s->do_nodelay =3D do_nodelay;
> +    s->reconnect_time_ms =3D sock->has_reconnect_ms ? sock->reconnect_ms=
 : 0;
> +
>      if (sock->tls_creds) {
>          Object *creds;
>          creds =3D object_resolve_path_component(
> @@ -1450,7 +1449,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>              return;
>          }
>      } else {
> -        if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0)=
 {
> +        if (qmp_chardev_open_socket_client(chr, errp) < 0) {
>              return;
>          }
>      }
> --
> 2.48.1
>
>


--
Marc-Andr=C3=A9 Lureau

