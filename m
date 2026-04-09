Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12C4F31E26
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAqFm-0002pn-6b; Thu, 09 Apr 2026 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAqFj-0002pX-00
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:04 -0400
Received: from mail-10627.protonmail.ch ([79.135.106.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAqFf-0002y0-EP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775744453; x=1776003653;
 bh=ET7eMLj99h44CbM8DpKXUknP91w3oGNmPtzBKZPRAYE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LiXA1lSwjQzScmRbH2jQmSLOzmxtNU65UxeYnUrGfyADqKb5lmbAfvJqod1WfirQc
 t3wV/D4yPZGvTQPTCcLOD8mZiXbwZcRAV8pbNmM6peLlLH5zXQrlVhv9tF8RlAO0Va
 N3xBj4Fe5+BXEn/ksht7TLYTfYGBA0fEmg7+DIyDnD+SWfRxuyj4RmZHtvVgua7vs/
 47e5FB1ig8yCPO2MuK1b4TV8vzCP3lkpL6OAIXBNqQA82jb7f8WKeXPdkygg3z0039
 fwR7ywHRuo/Z4WIRkrQwHYCTddEncjWUGA7HV/RWJ1l3a+iH9H1rsoF4u3CQQemXKN
 lvgVC893YReow==
Date: Thu, 09 Apr 2026 14:20:48 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] io: use g_clear_handle_id() for GSource cleanup
Message-ID: <_FLwJ4IKFwbr2FlwMah_gLTk8PG-FdvyrrFM2UgmbYPlN7wSwZIslJehtfZV7mb8w1UD69eX6LD5Lt9wGkstMiLrdrkkzU1coVZiuy7CSNE=@matthewpenney.net>
In-Reply-To: <20260408100605.66795-3-philmd@linaro.org>
References: <20260408100605.66795-1-philmd@linaro.org>
 <20260408100605.66795-3-philmd@linaro.org>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: e2bf4a4740bc173d9b570b403a5d8ee2f28d176e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.27;
 envelope-from=matt@matthewpenney.net; helo=mail-10627.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

Thanks for picking this up and cleaning it up.

This matches what I was aiming for with my series.

Best regards,
Matt



Sent with Proton Mail secure email.

On Wednesday, 8 April 2026 at 11:06, Philippe Mathieu-Daud=C3=A9 <philmd@li=
naro.org> wrote:

> Use g_clear_handle_id() instead of g_source_remove() with
> manual ID checking and zeroing.
>=20
> This simplifies the code and ensures consistent handling of
> GSource IDs, since g_clear_handle_id() checks for a non-zero
> ID before calling the cleanup function and zeros it afterwards.
>=20
> No functional change intended.
>=20
> Mechanical change using the following Coccinelle spatch script:
>=20
>   @@
>   expression TAG;
>   @@
>   -    if (TAG > 0) {
>   +    if (TAG) {
>            g_source_remove(TAG);
>            <... when !=3D TAG
>            TAG =3D 0;
>            ...>
>        }
>=20
>   @@
>   expression TAG;
>   @@
>   -    g_source_remove(TAG);
>   -    TAG =3D 0;
>   +    g_clear_handle_id(&TAG, g_source_remove);
>=20
>   @@
>   expression TAG;
>   @@
>   -    if (TAG) {
>            g_clear_handle_id(&TAG, g_source_remove);
>   -    }
>=20
> Inspired-by: Matthew Penney <matt@matthewpenney.net>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/char/cmsdk-apb-uart.c  |  5 +----
>  hw/char/nrf51_uart.c      |  5 +----
>  hw/char/serial.c          |  6 +-----
>  hw/char/stm32l4x5_usart.c |  5 +----
>  hw/char/terminal3270.c    |  5 +----
>  hw/char/virtio-console.c  | 10 ++--------
>  hw/usb/redirect.c         |  5 +----
>  io/channel-websock.c      | 13 +++----------
>  net/passt.c               |  8 ++------
>  net/stream.c              | 15 +++------------
>  net/stream_data.c         |  5 +----
>  net/vhost-user.c          |  8 ++------
>  ui/dbus-clipboard.c       |  6 ++----
>  ui/input-barrier.c        |  6 +-----
>  ui/vnc-auth-vencrypt.c    |  6 +-----
>  ui/vnc-ws.c               | 12 ++----------
>  16 files changed, 25 insertions(+), 95 deletions(-)
>=20
> diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
> index edb80f61819..0631821a571 100644
> --- a/hw/char/cmsdk-apb-uart.c
> +++ b/hw/char/cmsdk-apb-uart.c
> @@ -236,10 +236,7 @@ buffer_drained:
>=20
>  static void uart_cancel_transmit(CMSDKAPBUART *s)
>  {
> -    if (s->watch_tag) {
> -        g_source_remove(s->watch_tag);
> -        s->watch_tag =3D 0;
> -    }
> +    g_clear_handle_id(&s->watch_tag, g_source_remove);
>  }
>=20
>  static void uart_write(void *opaque, hwaddr offset, uint64_t value,
> diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
> index 73069232441..96f0d085fdd 100644
> --- a/hw/char/nrf51_uart.c
> +++ b/hw/char/nrf51_uart.c
> @@ -104,10 +104,7 @@ buffer_drained:
>=20
>  static void uart_cancel_transmit(NRF51UARTState *s)
>  {
> -    if (s->watch_tag) {
> -        g_source_remove(s->watch_tag);
> -        s->watch_tag =3D 0;
> -    }
> +    g_clear_handle_id(&s->watch_tag, g_source_remove);
>  }
>=20
>  static void uart_write(void *opaque, hwaddr addr,
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 0f3469a1e8f..0729cd2ce9d 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -856,11 +856,7 @@ const VMStateDescription vmstate_serial =3D {
>  static void serial_reset(void *opaque)
>  {
>      SerialState *s =3D opaque;
> -
> -    if (s->watch_tag > 0) {
> -        g_source_remove(s->watch_tag);
> -        s->watch_tag =3D 0;
> -    }
> +    g_clear_handle_id(&s->watch_tag, g_source_remove);
>=20
>      s->rbr =3D 0;
>      s->ier =3D 0;
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index 736f1e764e6..dd1b0991956 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -280,10 +280,7 @@ buffer_drained:
>=20
>  static void usart_cancel_transmit(Stm32l4x5UsartBaseState *s)
>  {
> -    if (s->watch_tag) {
> -        g_source_remove(s->watch_tag);
> -        s->watch_tag =3D 0;
> -    }
> +    g_clear_handle_id(&s->watch_tag, g_source_remove);
>  }
>=20
>  static void stm32l4x5_update_params(Stm32l4x5UsartBaseState *s)
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index 1d857bad9bc..989b6f6ee1e 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -52,10 +52,7 @@ static int terminal_can_read(void *opaque)
>=20
>  static void terminal_timer_cancel(Terminal3270 *t)
>  {
> -    if (t->timer_tag) {
> -        g_source_remove(t->timer_tag);
> -        t->timer_tag =3D 0;
> -    }
> +    g_clear_handle_id(&t->timer_tag, g_source_remove);
>  }
>=20
>  /*
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index efe7cd6772e..4737b9a56eb 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -159,10 +159,7 @@ static void chr_event(void *opaque, QEMUChrEvent eve=
nt)
>          virtio_serial_open(port);
>          break;
>      case CHR_EVENT_CLOSED:
> -        if (vcon->watch) {
> -            g_source_remove(vcon->watch);
> -            vcon->watch =3D 0;
> -        }
> +        g_clear_handle_id(&vcon->watch, g_source_remove);
>          virtio_serial_close(port);
>          break;
>      case CHR_EVENT_BREAK:
> @@ -255,10 +252,7 @@ static void virtconsole_realize(DeviceState *dev, Er=
ror **errp)
>  static void virtconsole_unrealize(DeviceState *dev)
>  {
>      VirtConsole *vcon =3D VIRTIO_CONSOLE(dev);
> -
> -    if (vcon->watch) {
> -        g_clear_handle_id(&vcon->watch, g_source_remove);
> -    }
> +    g_clear_handle_id(&vcon->watch, g_source_remove);
>  }
>=20
>  static void virtconsole_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 100afbdb06a..bde821e214b 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1226,10 +1226,7 @@ static void usbredir_chardev_close_bh(void *opaque=
)
>          usbredirparser_destroy(dev->parser);
>          dev->parser =3D NULL;
>      }
> -    if (dev->watch) {
> -        g_source_remove(dev->watch);
> -        dev->watch =3D 0;
> -    }
> +    g_clear_handle_id(&dev->watch, g_source_remove);
>  }
>=20
>  static void usbredir_create_parser(USBRedirDevice *dev)
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index da7e7c9e345..3479a5c32d2 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -1066,10 +1066,7 @@ static gboolean qio_channel_websock_flush(QIOChann=
el *ioc,
>=20
>  static void qio_channel_websock_unset_watch(QIOChannelWebsock *ioc)
>  {
> -    if (ioc->io_tag) {
> -        g_source_remove(ioc->io_tag);
> -        ioc->io_tag =3D 0;
> -    }
> +    g_clear_handle_id(&ioc->io_tag, g_source_remove);
>  }
>=20
>  static void qio_channel_websock_set_watch(QIOChannelWebsock *ioc)
> @@ -1246,12 +1243,8 @@ static int qio_channel_websock_close(QIOChannel *i=
oc,
>      buffer_free(&wioc->encinput);
>      buffer_free(&wioc->encoutput);
>      buffer_free(&wioc->rawinput);
> -    if (wioc->hs_io_tag) {
> -        g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
> -    }
> -    if (wioc->io_tag) {
> -        g_clear_handle_id(&wioc->io_tag, g_source_remove);
> -    }
> +    g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
> +    g_clear_handle_id(&wioc->io_tag, g_source_remove);
>      if (wioc->io_err) {
>          g_clear_pointer(&wioc->io_err, error_free);
>      }
> diff --git a/net/passt.c b/net/passt.c
> index 4ff94ee509d..d3b5ab426c9 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -90,10 +90,7 @@ static void net_passt_cleanup(NetClientState *nc)
>          g_free(s->vhost_net);
>          s->vhost_net =3D NULL;
>      }
> -    if (s->vhost_watch) {
> -        g_source_remove(s->vhost_watch);
> -        s->vhost_watch =3D 0;
> -    }
> +    g_clear_handle_id(&s->vhost_watch, g_source_remove);
>      qemu_chr_fe_deinit(&s->vhost_chr, true);
>      if (s->vhost_user) {
>          vhost_user_cleanup(s->vhost_user);
> @@ -421,8 +418,7 @@ static void passt_vhost_user_event(void *opaque, QEMU=
ChrEvent event)
>          if (s->vhost_watch) {
>              AioContext *ctx =3D qemu_get_current_aio_context();
>=20
> -            g_source_remove(s->vhost_watch);
> -            s->vhost_watch =3D 0;
> +            g_clear_handle_id(&s->vhost_watch, g_source_remove);
>              qemu_chr_fe_set_handlers(&s->vhost_chr, NULL, NULL,  NULL, N=
ULL,
>                                       NULL, NULL, false);
>=20
> diff --git a/net/stream.c b/net/stream.c
> index ea83f4a763a..6df4e251feb 100644
> --- a/net/stream.c
> +++ b/net/stream.c
> @@ -71,24 +71,15 @@ static gboolean net_stream_send(QIOChannel *ioc,
>  static void net_stream_cleanup(NetClientState *nc)
>  {
>      NetStreamState *s =3D DO_UPCAST(NetStreamState, data.nc, nc);
> -    if (s->timer_tag) {
> -        g_source_remove(s->timer_tag);
> -        s->timer_tag =3D 0;
> -    }
> +    g_clear_handle_id(&s->timer_tag, g_source_remove);
>      if (s->addr) {
>          qapi_free_SocketAddress(s->addr);
>          s->addr =3D NULL;
>      }
>      if (s->data.ioc) {
>          if (QIO_CHANNEL_SOCKET(s->data.ioc)->fd !=3D -1) {
> -            if (s->data.ioc_read_tag) {
> -                g_source_remove(s->data.ioc_read_tag);
> -                s->data.ioc_read_tag =3D 0;
> -            }
> -            if (s->data.ioc_write_tag) {
> -                g_source_remove(s->data.ioc_write_tag);
> -                s->data.ioc_write_tag =3D 0;
> -            }
> +            g_clear_handle_id(&s->data.ioc_read_tag, g_source_remove);
> +            g_clear_handle_id(&s->data.ioc_write_tag, g_source_remove);
>          }
>          object_unref(OBJECT(s->data.ioc));
>          s->data.ioc =3D NULL;
> diff --git a/net/stream_data.c b/net/stream_data.c
> index 03740e9f73e..73b45da9fe3 100644
> --- a/net/stream_data.c
> +++ b/net/stream_data.c
> @@ -84,10 +84,7 @@ void net_stream_data_rs_finalize(SocketReadState *rs)
>      if (qemu_send_packet_async(&d->nc, rs->buf,
>                                 rs->packet_len,
>                                 net_stream_data_send_completed) =3D=3D 0)=
 {
> -        if (d->ioc_read_tag) {
> -            g_source_remove(d->ioc_read_tag);
> -            d->ioc_read_tag =3D 0;
> -        }
> +        g_clear_handle_id(&d->ioc_read_tag, g_source_remove);
>      }
>  }
>=20
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index a4bb49bbcff..2d0fc49b4d8 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -215,10 +215,7 @@ static void net_vhost_user_cleanup(NetClientState *n=
c)
>          s->vhost_net =3D NULL;
>      }
>      if (nc->queue_index =3D=3D 0) {
> -        if (s->watch) {
> -            g_source_remove(s->watch);
> -            s->watch =3D 0;
> -        }
> +        g_clear_handle_id(&s->watch, g_source_remove);
>          qemu_chr_fe_deinit(&s->chr, true);
>          if (s->vhost_user) {
>              vhost_user_cleanup(s->vhost_user);
> @@ -356,8 +353,7 @@ static void net_vhost_user_event(void *opaque, QEMUCh=
rEvent event)
>          if (s->watch) {
>              AioContext *ctx =3D qemu_get_current_aio_context();
>=20
> -            g_source_remove(s->watch);
> -            s->watch =3D 0;
> +            g_clear_handle_id(&s->watch, g_source_remove);
>              qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
>                                       NULL, NULL, false);
>=20
> diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
> index 935b6b1a2ac..90318384ee4 100644
> --- a/ui/dbus-clipboard.c
> +++ b/ui/dbus-clipboard.c
> @@ -80,8 +80,7 @@ dbus_clipboard_update_info(DBusDisplay *dpy, QemuClipbo=
ardInfo *info)
>      if (req->invocation && info->types[req->type].data) {
>          dbus_clipboard_complete_request(dpy, req->invocation, info, req-=
>type);
>          g_clear_object(&req->invocation);
> -        g_source_remove(req->timeout_id);
> -        req->timeout_id =3D 0;
> +        g_clear_handle_id(&req->timeout_id, g_source_remove);
>          return;
>      }
>=20
> @@ -183,8 +182,7 @@ dbus_clipboard_request_cancelled(DBusClipboardRequest=
 *req)
>          "Cancelled clipboard request");
>=20
>      g_clear_object(&req->invocation);
> -    g_source_remove(req->timeout_id);
> -    req->timeout_id =3D 0;
> +    g_clear_handle_id(&req->timeout_id, g_source_remove);
>  }
>=20
>  static void
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> index 0a2198ca500..84212c50442 100644
> --- a/ui/input-barrier.c
> +++ b/ui/input-barrier.c
> @@ -518,11 +518,7 @@ static void input_barrier_complete(UserCreatable *uc=
, Error **errp)
>  static void input_barrier_instance_finalize(Object *obj)
>  {
>      InputBarrier *ib =3D INPUT_BARRIER(obj);
> -
> -    if (ib->ioc_tag) {
> -        g_source_remove(ib->ioc_tag);
> -        ib->ioc_tag =3D 0;
> -    }
> +    g_clear_handle_id(&ib->ioc_tag, g_source_remove);
>=20
>      if (ib->sioc) {
>          qio_channel_close(QIO_CHANNEL(ib->sioc), NULL);
> diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
> index d9c212ff328..a1b8cde2292 100644
> --- a/ui/vnc-auth-vencrypt.c
> +++ b/ui/vnc-auth-vencrypt.c
> @@ -101,11 +101,7 @@ static int protocol_client_vencrypt_auth(VncState *v=
s, uint8_t *data, size_t len
>          QIOChannelTLS *tls;
>          vnc_write_u8(vs, 1); /* Accept auth */
>          vnc_flush(vs);
> -
> -        if (vs->ioc_tag) {
> -            g_source_remove(vs->ioc_tag);
> -            vs->ioc_tag =3D 0;
> -        }
> +        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
>=20
>          tls =3D qio_channel_tls_new_server(
>              vs->ioc,
> diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
> index 9e3503d93d8..65e8b344b65 100644
> --- a/ui/vnc-ws.c
> +++ b/ui/vnc-ws.c
> @@ -54,11 +54,7 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC=
_UNUSED,
>      VncState *vs =3D opaque;
>      QIOChannelTLS *tls;
>      Error *err =3D NULL;
> -
> -    if (vs->ioc_tag) {
> -        g_source_remove(vs->ioc_tag);
> -        vs->ioc_tag =3D 0;
> -    }
> +    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
>=20
>      if (condition & (G_IO_HUP | G_IO_ERR)) {
>          vnc_client_error(vs);
> @@ -123,11 +119,7 @@ gboolean vncws_handshake_io(QIOChannel *ioc G_GNUC_U=
NUSED,
>  {
>      VncState *vs =3D opaque;
>      QIOChannelWebsock *wioc;
> -
> -    if (vs->ioc_tag) {
> -        g_source_remove(vs->ioc_tag);
> -        vs->ioc_tag =3D 0;
> -    }
> +    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
>=20
>      if (condition & (G_IO_HUP | G_IO_ERR)) {
>          vnc_client_error(vs);
> --
> 2.53.0
>=20
> 

