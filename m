Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B28CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZVD-0006VF-Lq; Tue, 14 Oct 2025 03:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZVA-0006QJ-Dx
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:21 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZV8-0004ue-0y
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:20 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-7f7835f4478so48664766d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760427076; x=1761031876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KDOEhL/HRE+8GnpR2fMlCwynydc11iyHCsuLm5Opjc=;
 b=VAPvWY8vac0TyfwORZ0aPb4eaWkERTnN+B6E0etOr1czL5Cbio5WsIrhWoNvD7Hl/e
 r0u4i+nTlliK0gWervvFidT8A3ymLcJ/qSgwgW79XTCfZ5DjyzGZeazt4Ura847MG+TT
 HxRNGHLT09OyzOa2Eoda9EK4PIoN4hQdcPMNQVTgSUqMm2zVsr+B24UHqocemS5CD5tm
 7NbnQTo7x0neI7Iea5W9FgYccx70EmtJlfLyxB30a52HE5TjPWHMCBQWgH5e5HvoN6xT
 yEL1ISS0o294o7WRGhLXggwLKb2/xMKd2JgwPyVC3ythSeak1GyotQHrq5Ywwq+sHWpT
 J3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760427076; x=1761031876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KDOEhL/HRE+8GnpR2fMlCwynydc11iyHCsuLm5Opjc=;
 b=QLCc3Ejxi9eugnBBXSOCTsH7fssUpELk+QmrCn26jJtK2EbiaRStfJQFl7j+rXQKs/
 s9EuoFOy1X4AtMu7r9A457IoD6pno/EP4apvmsP1yRaAeZaW+Y8bndfcgdzcnrkwKryF
 +RT0uQ1px0te9T2ggHZhUHA8TRt8Yjw85FszTCIOf66fLI5x3yuSrd4dKRebbqK2vLRD
 rUTRGLC/PDDwCKdSgivmEBrjHgNGPV9/cR1m+d9iBArh/8OVqKc4L///pBn/nS546RPT
 AAAi5WLy033xdhn7HmVuYfKEE9fnKiXgCb8Xm5nzQXc5sNMQDIV81LgAf9Wrqt92gxjG
 80mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfUk5kLOfrShw+oGuBviUcBN7ltqLNUXp/qPxVxf20LdKxnneJXEIxXgtQnquQ7a5Ob7w+yB9LYeR4@nongnu.org
X-Gm-Message-State: AOJu0YwjaYjcEJLVS4C5rXr0gD0t9Q7yo/yVOUWqDWebjxIQBwDa5e2m
 n1CYEE/LTfKZfxAi6P0yT3PilkGFaYmX92LpSJIRnEBmuhrK69nH6T0clS69Zs0SoeRE0JUhZLc
 24srN3kfOzgPVAGlsLIlGmGf9tLOvOjM=
X-Gm-Gg: ASbGncuIw0T/atk3uB9UzNEsos5GUD27I4PY/S6enC9JSGcyNCRHQl9otktl2Xc+t+p
 xzOm4zthZ9Usb6zLDvbsoROCr/bUnmuc2+t94PcQ6BUgxFb5vmV5cflmq5nr/LvBXlTyueDhroA
 jDbeYXZztaNSMmd3gfMytNEy3GKITc9jusG2duCvxZwMGJv9/meJTokiH2epwyV649/cGMiFSTS
 wrKd/a+w0H0yJGCxQDvb2dZDlGgJxx72V7LNX9VBrgisyy/nAxgM6Wh8GJiMD+THIUCHlF62YTq
 7Jk=
X-Google-Smtp-Source: AGHT+IH58Z4Ltt+x53u4A++CNKgvJh5SIm+FaQwohQ/rO1reLALw8AkPNugFODeAwxnpt25JHqQchMWf26K4L0WD3u8=
X-Received: by 2002:a05:6214:1c4c:b0:820:8fa6:130e with SMTP id
 6a1803df08f44-87b074cdb2dmr302207896d6.0.1760427076040; Tue, 14 Oct 2025
 00:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-7-vsementsov@yandex-team.ru>
In-Reply-To: <20251013133836.852018-7-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 11:31:04 +0400
X-Gm-Features: AS18NWCAsk9SIryZe1xRRtK3uljFP8rz0SMglsFKKrJdxpGKlAdgiZqpoYNNKkg
Message-ID: <CAJ+F1CLB_Fu_o+pjuZfvTaErNEEvd_xRJnFM27kQJO_mezWWbA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] chardev/char-socket: move to .init + .connect api
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf31.google.com
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

On Mon, Oct 13, 2025 at 5:40=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Move char-socket to new API. This will help to realize backend-transfer
> feature for vhost-user-blk.
>
> With this commit qemu_chr_fe_init() starts to do connecting, so we
> should handle its errors instead of passing &error_abort.
>
> Also, move qemu_chr_fe_init() in test-char.c, to trigger connect
> before trying to get address.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-socket.c         | 55 ++++++++++++++++++++---------------
>  chardev/char.c                |  7 +++--
>  include/chardev/char-socket.h |  1 +
>  tests/unit/test-char.c        | 14 ++++-----
>  ui/dbus-chardev.c             | 12 ++++++--
>  5 files changed, 54 insertions(+), 35 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index f3bc6290d2..0a5738c158 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1287,6 +1287,25 @@ static int qmp_chardev_open_socket_client(Chardev =
*chr,
>  }
>
>
> +static bool char_socket_connect(Chardev *chr, Error **errp)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +
> +    if (s->is_listen) {
> +        if (qmp_chardev_open_socket_server(chr, s->is_telnet || s->is_tn=
3270,
> +                                           s->is_waitconnect, errp) < 0)=
 {
> +            return false;
> +        }
> +    } else {
> +        if (qmp_chardev_open_socket_client(chr, errp) < 0) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +
>  static bool qmp_chardev_validate_socket(ChardevSocket *sock,
>                                          SocketAddress *addr,
>                                          Error **errp)
> @@ -1363,10 +1382,9 @@ static bool qmp_chardev_validate_socket(ChardevSoc=
ket *sock,
>  }
>
>
> -static void qmp_chardev_open_socket(Chardev *chr,
> -                                    ChardevBackend *backend,
> -                                    bool *be_opened,
> -                                    Error **errp)
> +static bool char_socket_init(Chardev *chr,
> +                             ChardevBackend *backend,
> +                             Error **errp)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      ChardevSocket *sock =3D backend->u.socket.data;
> @@ -1374,7 +1392,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      bool is_listen      =3D sock->has_server  ? sock->server  : true;
>      bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
>      bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false;
> -    bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
>      bool is_websock     =3D sock->has_websocket ? sock->websocket : fals=
e;
>      SocketAddress *addr;
>
> @@ -1383,6 +1400,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      s->is_tn3270 =3D is_tn3270;
>      s->is_websock =3D is_websock;
>      s->do_nodelay =3D do_nodelay;
> +    s->is_waitconnect =3D sock->has_wait ? sock->wait : false;
>      s->reconnect_time_ms =3D sock->has_reconnect_ms ? sock->reconnect_ms=
 : 0;
>
>      if (sock->tls_creds) {
> @@ -1392,7 +1410,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          if (!creds) {
>              error_setg(errp, "No TLS credentials with id '%s'",
>                         sock->tls_creds);
> -            return;
> +            return false;
>          }
>          s->tls_creds =3D (QCryptoTLSCreds *)
>              object_dynamic_cast(creds,
> @@ -1400,7 +1418,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          if (!s->tls_creds) {
>              error_setg(errp, "Object with id '%s' is not TLS credentials=
",
>                         sock->tls_creds);
> -            return;
> +            return false;
>          }
>          object_ref(OBJECT(s->tls_creds));
>          if (!qcrypto_tls_creds_check_endpoint(s->tls_creds,
> @@ -1408,7 +1426,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>                                            ? QCRYPTO_TLS_CREDS_ENDPOINT_S=
ERVER
>                                            : QCRYPTO_TLS_CREDS_ENDPOINT_C=
LIENT,
>                                            errp)) {
> -            return;
> +            return false;
>          }
>      }
>      s->tls_authz =3D g_strdup(sock->tls_authz);
> @@ -1416,7 +1434,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      s->addr =3D addr =3D socket_address_flatten(sock->addr);
>
>      if (!qmp_chardev_validate_socket(sock, addr, errp)) {
> -        return;
> +        return false;
>      }
>
>      qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
> @@ -1433,26 +1451,14 @@ static void qmp_chardev_open_socket(Chardev *chr,
>       */
>      if (!chr->handover_yank_instance) {
>          if (!yank_register_instance(CHARDEV_YANK_INSTANCE(chr->label), e=
rrp)) {
> -            return;
> +            return false;
>          }
>      }
>      s->registered_yank =3D true;
>
> -    /* be isn't opened until we get a connection */
> -    *be_opened =3D false;
> -
>      update_disconnected_filename(s);
>
> -    if (s->is_listen) {
> -        if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
> -                                           is_waitconnect, errp) < 0) {
> -            return;
> -        }
> -    } else {
> -        if (qmp_chardev_open_socket_client(chr, errp) < 0) {
> -            return;
> -        }
> -    }
> +    return true;
>  }
>
>  static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
> @@ -1576,7 +1582,8 @@ static void char_socket_class_init(ObjectClass *oc,=
 const void *data)
>      cc->supports_yank =3D true;
>
>      cc->parse =3D qemu_chr_parse_socket;
> -    cc->open =3D qmp_chardev_open_socket;
> +    cc->init =3D char_socket_init;
> +    cc->connect =3D char_socket_connect;
>      cc->chr_wait_connected =3D tcp_chr_wait_connected;
>      cc->chr_write =3D tcp_chr_write;
>      cc->chr_sync_read =3D tcp_chr_sync_read;
> diff --git a/chardev/char.c b/chardev/char.c
> index 01ffe37acf..4d151f537c 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1221,12 +1221,15 @@ ChardevReturn *qmp_chardev_change(const char *id,=
 ChardevBackend *backend,
>      }
>
>      chr->be =3D NULL;
> -    qemu_chr_fe_init(be, chr_new, &error_abort);
> +    if (!qemu_chr_fe_init(be, chr_new, errp)) {
> +        object_unref(OBJECT(chr_new));
> +        return NULL;
> +    }
>
>      if (be->chr_be_change(be->opaque) < 0) {
>          error_setg(errp, "Chardev '%s' change failed", chr_new->label);
>          chr_new->be =3D NULL;
> -        qemu_chr_fe_init(be, chr, &error_abort);
> +        qemu_chr_fe_init(be, chr, NULL);
>          if (closed_sent) {
>              qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>          }
> diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.=
h
> index d6d13ad37f..0109727eaa 100644
> --- a/include/chardev/char-socket.h
> +++ b/include/chardev/char-socket.h
> @@ -68,6 +68,7 @@ struct SocketChardev {
>      bool is_listen;
>      bool is_telnet;
>      bool is_tn3270;
> +    bool is_waitconnect;
>      GSource *telnet_source;
>      TCPChardevTelnetInit *telnet_init;
>
> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> index f30a39f61f..5c9482a478 100644
> --- a/tests/unit/test-char.c
> +++ b/tests/unit/test-char.c
> @@ -845,6 +845,7 @@ static void char_websock_test(void)
>                                0xef, 0xaa, 0xc5, 0x97, /* Masking key */
>                                0xec, 0x42              /* Status code */ =
};
>
> +    qemu_chr_fe_init(&be, chr, &error_abort);
>      addr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_abo=
rt);
>      qdict =3D qobject_to(QDict, addr);
>      port =3D qdict_get_str(qdict, "port");
> @@ -852,7 +853,6 @@ static void char_websock_test(void)
>      handshake_port =3D g_strdup_printf(handshake, port, port);
>      qobject_unref(qdict);
>
> -    qemu_chr_fe_init(&be, chr, &error_abort);
>      qemu_chr_fe_set_handlers(&be, websock_server_can_read, websock_serve=
r_read,
>                               NULL, NULL, chr, NULL, true);
>
> @@ -1216,6 +1216,8 @@ static void char_socket_server_test(gconstpointer o=
paque)
>      g_assert_nonnull(chr);
>      g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
>
> +    qemu_chr_fe_init(&be, chr, &error_abort);
> +
>      qaddr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_ab=
ort);
>      g_assert_nonnull(qaddr);
>
> @@ -1224,8 +1226,6 @@ static void char_socket_server_test(gconstpointer o=
paque)
>      visit_free(v);
>      qobject_unref(qaddr);
>
> -    qemu_chr_fe_init(&be, chr, &error_abort);
> -
>   reconnect:
>      data.event =3D -1;
>      data.be =3D &be;
> @@ -1417,6 +1417,8 @@ static void char_socket_client_test(gconstpointer o=
paque)
>      qemu_opts_del(opts);
>      g_assert_nonnull(chr);
>
> +    qemu_chr_fe_init(&be, chr, &error_abort);
> +
>      if (config->reconnect) {
>          /*
>           * If reconnect is set, the connection will be
> @@ -1431,8 +1433,6 @@ static void char_socket_client_test(gconstpointer o=
paque)
>                                            &error_abort));
>      }
>
> -    qemu_chr_fe_init(&be, chr, &error_abort);
> -
>   reconnect:
>      data.event =3D -1;
>      data.be =3D &be;
> @@ -1550,6 +1550,8 @@ static void char_socket_server_two_clients_test(gco=
nstpointer opaque)
>      g_assert_nonnull(chr);
>      g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
>
> +    qemu_chr_fe_init(&be, chr, &error_abort);
> +
>      qaddr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_ab=
ort);
>      g_assert_nonnull(qaddr);
>
> @@ -1558,8 +1560,6 @@ static void char_socket_server_two_clients_test(gco=
nstpointer opaque)
>      visit_free(v);
>      qobject_unref(qaddr);
>
> -    qemu_chr_fe_init(&be, chr, &error_abort);
> -
>      qemu_chr_fe_set_handlers(&be, char_socket_can_read, char_socket_disc=
ard_read,
>                               count_closed_event, NULL,
>                               &closed, NULL, true);
> diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
> index d05dddaf81..23cf9d6ee9 100644
> --- a/ui/dbus-chardev.c
> +++ b/ui/dbus-chardev.c
> @@ -210,8 +210,14 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
>      if (*errp) {
>          return;
>      }
> -    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->open(
> -        chr, be, be_opened, errp);
> +    if (!CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->init(
> +        chr, be, errp)) {
> +        return;
> +    }
> +    if (!CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->conne=
ct(
> +        chr, errp)) {
> +        return;
> +    }
>  }
>
>  static void
> @@ -276,6 +282,8 @@ char_dbus_class_init(ObjectClass *oc, const void *dat=
a)
>
>      cc->parse =3D dbus_chr_parse;
>      cc->open =3D dbus_chr_open;
> +    cc->init =3D NULL;
> +    cc->connect =3D NULL;
>      cc->chr_set_fe_open =3D dbus_chr_set_fe_open;
>      cc->chr_set_echo =3D dbus_chr_set_echo;
>      klass->parent_chr_be_event =3D cc->chr_be_event;
> --
> 2.48.1
>
>


--
Marc-Andr=C3=A9 Lureau

