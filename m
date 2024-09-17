Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1191C36019
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXNK-0007T9-UA; Tue, 17 Sep 2024 08:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sqXNA-000761-TF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sqXN6-0001LT-U8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726576315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUdTfaf+yFa0VXWiQF8eylK0H6cYpiKi3xH6n7GD1d8=;
 b=FwRpgap589XE0AbgIdfV3CRJJE5HHD1syEQEI/Khu3DqaFzaXmmNPbpAS+FzK3tM/R4Uqy
 9bBNIaEb8/Gn8xM5yXlCsoRcdx7qAwmHQ20M2s4VJCnrzsAbGRzqa0ogYKC99rDdjKPNoR
 Jeb+ptbEV1H+vOt1f9rgiBJlGUzXUnU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-n4YXRLZMOm-wmauBnofBvQ-1; Tue, 17 Sep 2024 08:31:53 -0400
X-MC-Unique: n4YXRLZMOm-wmauBnofBvQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c517e32a97so2428426d6.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576313; x=1727181113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUdTfaf+yFa0VXWiQF8eylK0H6cYpiKi3xH6n7GD1d8=;
 b=Fkg3QBjriPCtSsAk992ttIsD7xqOFUfUC3XDkDzKliIKZITSwLVP8kqS9dxdd1cPOu
 875pL0O1YLfHQfO25pracXzXLP/foMRew69JOc5I5vTC478nsTxHd/ITTcJIkVHRwkX0
 vXehq7f9wfXcPakt6MLoR/Fmb4za5Q2FpxC9bXDyxoSXdmlXSXHb4crwmoXxrRjZmGQq
 u/wrt6r6nDFOYyvQ6+4xJ1+sLcqy7z6WtO5f+1zPZckC09mLbI4wz6t90rw3T0fg7crw
 t542BD/MpGrRKdHcJuish/6JAl1ShKgCIJNOVCASiSc0suxVqBEHkOVaToun7YVNTxwr
 RVXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsAc5dT2Hmk5RehkEvbjwjJw6rF5o/6XdYkrmqPaTkGtSvhQ/a6+vj3mynzEDx/wPFC2Wd2JVC3BCB@nongnu.org
X-Gm-Message-State: AOJu0YxATmciEBGAXKpo5sjvdWOMiOM5IRQRlajP3ZEiBFq4jAGScJRb
 ize/OhPQyiXGbMPBmrMXkuLWTlmvn1byeZfYmUbe1SOuoWVeCtj7Up+ErOvx3b4BfxtHyqSVpWl
 sZE5hmXeqshLh4dzZ8JGUoFg3JO19ICJmO5cMxHMUvBye4e+jeoJLvtzyc5xMn/ELJKvnvIU9j7
 8Vez3MG6jTrH6mWndS+1a8s2oeOAc=
X-Received: by 2002:a05:6214:450a:b0:6c5:55d5:f53d with SMTP id
 6a1803df08f44-6c57350b9e6mr264867006d6.8.1726576313124; 
 Tue, 17 Sep 2024 05:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4xxs7/Nvt5eJKKi8nB4UgrZX/yWN6AUXm9QmW1POQ8ip2dr25+mM3exZHkUS506YhofuzzzQ26Z67Z+DTuPM=
X-Received: by 2002:a05:6214:450a:b0:6c5:55d5:f53d with SMTP id
 6a1803df08f44-6c57350b9e6mr264866716d6.8.1726576312687; Tue, 17 Sep 2024
 05:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240913163636.253949-1-r.peniaev@gmail.com>
 <20240913163636.253949-2-r.peniaev@gmail.com>
In-Reply-To: <20240913163636.253949-2-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Sep 2024 16:31:41 +0400
Message-ID: <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: implement backend chardev multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Roman

On Fri, Sep 13, 2024 at 8:37=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> This patch implements multiplexing capability of several backend
> devices, which opens up an opportunity to use a single frontend
> device on the guest, which can be manipulated from several
> backend devices.
>
> The idea of the change is trivial: keep list of backend devices
> (up to 4), init them on demand and forward data buffer back and
> forth.
>
> The following is QEMU command line example:
>
>   -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 \
>   -chardev vc,id=3Dvc0 \
>   -chardev mux,id=3Dmux0,chardev=3Dvc0,,sock0 \
>   -device virtconsole,chardev=3Dmux0 \
>   -vnc 0.0.0.0:0
>
> Which creates 2 backend devices: text virtual console (`vc0`)
> and a socket (`sock0`) connected to the single virtio hvc
> console with the multiplexer (`mux0`) help. `vc0` renders
> text to an image, which can be shared over the VNC protocol.
> `sock0` is a socket backend which provides biderectional
> communication to the virtio hvc console.

I think I would rather implement a new mux for this purpose, like
"mux-be" perhaps?

"mux" has been a bit hidden (behind mux=3Don) for various reasons, and
is probably not at production quality level.

I am not sure how CLI should handle option arrays these days
(especially with -chardev CLI not being json-friendly).

>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  chardev/char-fe.c          |  14 +++--
>  chardev/char-mux.c         | 120 +++++++++++++++++++++++++++++--------
>  chardev/char.c             |   2 +-
>  chardev/chardev-internal.h |   7 ++-
>  4 files changed, 111 insertions(+), 32 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index b214ba3802b1..d1f67338084d 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -197,16 +197,22 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, E=
rror **errp)
>          if (CHARDEV_IS_MUX(s)) {
>              MuxChardev *d =3D MUX_CHARDEV(s);
>
> -            if (d->mux_cnt >=3D MAX_MUX) {
> +            if (d->fe_cnt >=3D MAX_MUX) {
>                  error_setg(errp,
>                             "too many uses of multiplexed chardev '%s'"
>                             " (maximum is " stringify(MAX_MUX) ")",
>                             s->label);
>                  return false;
>              }
> -
> -            d->backends[d->mux_cnt] =3D b;
> -            tag =3D d->mux_cnt++;
> +            if (d->fe_cnt > 0 && d->be_cnt > 1) {
> +                error_setg(errp,
> +                           "multiplexed chardev '%s' is already used "
> +                           "for backend multiplexing",
> +                           s->label);
> +                return false;
> +            }
> +            d->backends[d->fe_cnt] =3D b;
> +            tag =3D d->fe_cnt++;
>          } else if (s->be) {
>              error_setg(errp, "chardev '%s' is already in use", s->label)=
;
>              return false;
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index ee2d47b20d9b..82f728b5caf8 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> +#include "qemu/cutils.h"
>  #include "chardev/char.h"
>  #include "sysemu/block-backend.h"
>  #include "qapi/qapi-commands-control.h"
> @@ -40,13 +41,39 @@
>   */
>  static bool muxes_opened =3D true;
>
> +/* Write to all backends  */
> +static int mux_chr_fe_write(MuxChardev *mux, const uint8_t *buf, int len=
)
> +{
> +        int r, ret =3D -1, i;
> +
> +        for (i =3D 0; i < mux->be_cnt; i++) {
> +                r =3D qemu_chr_fe_write(&mux->chrs[i], buf, len);
> +                ret =3D ret < 0 ? r : MAX(r, ret);

I think it should be conservative and fail early if one of the backend
fails. Also if different frontends can write different amounts, there
needs to be some buffering... or it should always use write_all()
which has also a shortcoming since it blocks the thread.

> +        }
> +
> +        return ret;
> +}
> +
> +/* Write to all backends  */
> +static int mux_chr_fe_write_all(MuxChardev *mux, const uint8_t *buf, int=
 len)
> +{
> +        int r, ret =3D -1, i;
> +
> +        for (i =3D 0; i < mux->be_cnt; i++) {
> +                r =3D qemu_chr_fe_write_all(&mux->chrs[i], buf, len);
> +                ret =3D ret < 0 ? r : MAX(r, ret);
> +        }
> +
> +        return ret;
> +}
> +
>  /* Called with chr_write_lock held.  */
>  static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(chr);
>      int ret;
>      if (!d->timestamps) {
> -        ret =3D qemu_chr_fe_write(&d->chr, buf, len);
> +        ret =3D mux_chr_fe_write(d, buf, len);
>      } else {
>          int i;
>
> @@ -71,11 +98,11 @@ static int mux_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
>                           (int)(ti % 1000));
>                  /* XXX this blocks entire thread. Rewrite to use
>                   * qemu_chr_fe_write and background I/O callbacks */
> -                qemu_chr_fe_write_all(&d->chr,
> +                mux_chr_fe_write_all(d,
>                                        (uint8_t *)buf1, strlen(buf1));
>                  d->linestart =3D 0;
>              }
> -            ret +=3D qemu_chr_fe_write(&d->chr, buf + i, 1);
> +            ret +=3D mux_chr_fe_write(d, buf + i, 1);
>              if (buf[i] =3D=3D '\n') {
>                  d->linestart =3D 1;
>              }
> @@ -168,9 +195,9 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d,=
 int ch)
>              qemu_chr_be_event(chr, CHR_EVENT_BREAK);
>              break;
>          case 'c':
> -            assert(d->mux_cnt > 0); /* handler registered with first fe =
*/
> +            assert(d->fe_cnt > 0); /* handler registered with first fe *=
/
>              /* Switch to the next registered device */
> -            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
> +            mux_set_focus(chr, (d->focus + 1) % d->fe_cnt);
>              break;
>          case 't':
>              d->timestamps =3D !d->timestamps;
> @@ -248,8 +275,8 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEven=
t event)
>          return;
>      }
>
> -    /* Send the event to all registered listeners */
> -    for (i =3D 0; i < d->mux_cnt; i++) {
> +    /* Send the event to all registered frontend listeners */
> +    for (i =3D 0; i < d->fe_cnt; i++) {
>          mux_chr_send_event(d, i, event);
>      }
>  }
> @@ -262,8 +289,16 @@ static void mux_chr_event(void *opaque, QEMUChrEvent=
 event)
>  static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(s);
> -    Chardev *chr =3D qemu_chr_fe_get_driver(&d->chr);
> -    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +    Chardev *chr;
> +    ChardevClass *cc;
> +
> +    if (d->be_cnt > 1) {
> +            /* TODO: multiple backends have to be combined on a single w=
atch */

I think this must be done, otherwise there is a severe limitation.

> +            return NULL;
> +    }
> +
> +    chr =3D qemu_chr_fe_get_driver(&d->chrs[0]);
> +    cc =3D CHARDEV_GET_CLASS(chr);
>
>      if (!cc->chr_add_watch) {
>          return NULL;
> @@ -277,27 +312,32 @@ static void char_mux_finalize(Object *obj)
>      MuxChardev *d =3D MUX_CHARDEV(obj);
>      int i;
>
> -    for (i =3D 0; i < d->mux_cnt; i++) {
> +    for (i =3D 0; i < d->fe_cnt; i++) {
>          CharBackend *be =3D d->backends[i];
>          if (be) {
>              be->chr =3D NULL;
>          }
>      }
> -    qemu_chr_fe_deinit(&d->chr, false);
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        qemu_chr_fe_deinit(&d->chrs[i], false);
> +    }
>  }
>
>  static void mux_chr_update_read_handlers(Chardev *chr)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(chr);
> +    int i;
>
> -    /* Fix up the real driver with mux routines */
> -    qemu_chr_fe_set_handlers_full(&d->chr,
> -                                  mux_chr_can_read,
> -                                  mux_chr_read,
> -                                  mux_chr_event,
> -                                  NULL,
> -                                  chr,
> -                                  chr->gcontext, true, false);
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        /* Fix up the real driver with mux routines */
> +        qemu_chr_fe_set_handlers_full(&d->chrs[i],
> +                                      mux_chr_can_read,
> +                                      mux_chr_read,
> +                                      mux_chr_event,
> +                                      NULL,
> +                                      chr,
> +                                      chr->gcontext, true, false);
> +    }
>  }
>
>  void mux_set_focus(Chardev *chr, int focus)
> @@ -305,7 +345,7 @@ void mux_set_focus(Chardev *chr, int focus)
>      MuxChardev *d =3D MUX_CHARDEV(chr);
>
>      assert(focus >=3D 0);
> -    assert(focus < d->mux_cnt);
> +    assert(focus < d->fe_cnt);
>
>      if (d->focus !=3D -1) {
>          mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
> @@ -324,19 +364,49 @@ static void qemu_chr_open_mux(Chardev *chr,
>      ChardevMux *mux =3D backend->u.mux.data;
>      Chardev *drv;
>      MuxChardev *d =3D MUX_CHARDEV(chr);
> -
> -    drv =3D qemu_chr_find(mux->chardev);
> -    if (drv =3D=3D NULL) {
> -        error_setg(errp, "mux: base chardev %s not found", mux->chardev)=
;
> +    const char *offset, *chardevs;
> +    int length, i;
> +
> +    if (d->fe_cnt > 1) {
> +        error_setg(errp,
> +                   "multiplexed chardev '%s' is already used "
> +                   "for frontend multiplexing",
> +                   chr->label);
>          return;
>      }
>
> +    chardevs =3D mux->chardev;
> +    for (i =3D 0; i < MAX_MUX; i++) {
> +        char *chardev;
> +
> +        offset =3D qemu_strchrnul(chardevs, ',');
> +        length =3D offset - chardevs;
> +        if (!length) {
> +            break;
> +        }
> +        chardev =3D strndupa(chardevs, length);
> +        chardevs +=3D length + 1;
> +        drv =3D qemu_chr_find(chardev);
> +        if (drv =3D=3D NULL) {
> +            error_setg(errp, "mux: base chardev %s not found", chardev);
> +            goto deinit_on_error;
> +        }
> +        qemu_chr_fe_init(&d->chrs[i], drv, errp);
> +        d->be_cnt +=3D 1;
> +    }
>      d->focus =3D -1;
>      /* only default to opened state if we've realized the initial
>       * set of muxes
>       */
>      *be_opened =3D muxes_opened;
> -    qemu_chr_fe_init(&d->chr, drv, errp);
> +
> +    return;
> +
> +deinit_on_error:
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        qemu_chr_fe_deinit(&d->chrs[i], false);
> +    }
> +    d->be_cnt =3D 0;
>  }
>
>  static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
> diff --git a/chardev/char.c b/chardev/char.c
> index ba847b6e9eff..2643c79e5749 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
>  {
>      if (CHARDEV_IS_MUX(s)) {
>          MuxChardev *d =3D MUX_CHARDEV(s);
> -        return d->mux_cnt >=3D 0;
> +        return d->fe_cnt >=3D 0;
>      } else {
>          return s->be !=3D NULL;
>      }
> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> index 4e03af31476c..72c2e4da7552 100644
> --- a/chardev/chardev-internal.h
> +++ b/chardev/chardev-internal.h
> @@ -35,10 +35,13 @@
>
>  struct MuxChardev {
>      Chardev parent;
> +    /* Linked frontends */
>      CharBackend *backends[MAX_MUX];
> -    CharBackend chr;
> +    /* Linked backends */
> +    CharBackend chrs[MAX_MUX];
>      int focus;
> -    int mux_cnt;
> +    int fe_cnt;
> +    int be_cnt;
>      int term_got_escape;
>      int max_size;
>      /* Intermediate input buffer catches escape sequences even if the
> --
> 2.34.1
>


It would also require some tests and QAPI support.


