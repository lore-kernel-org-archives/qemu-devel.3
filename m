Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF67E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 11:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSE9j-0002O3-Dz; Mon, 30 Dec 2024 06:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tSE9h-0002Nd-R2
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 06:41:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tSE9e-0007mb-12
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 06:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735558908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ixh73tbJXTGNMUkPswfDBwd6vOw5DGCXKxSSlYsX7g=;
 b=HPq63H/WwUkqOBnMAb2gdw/G54NBgluHFABJiM90yi6PCif3dhYr3o9gQJR+ERK4o6y1Bm
 HPJh4C8Ju9zPRmfKXeyJeP07L8a9J8nyBSXI7UldK6KkTXyLjb8m1PM6rSheypP1a4Bckn
 DL0GZYoAZXTishk1QFaJYHLhHqThOzA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-ZZqvxaJvOom5SMxrCalYzA-1; Mon, 30 Dec 2024 06:41:44 -0500
X-MC-Unique: ZZqvxaJvOom5SMxrCalYzA-1
X-Mimecast-MFC-AGG-ID: ZZqvxaJvOom5SMxrCalYzA
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4679fc5c542so146910421cf.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 03:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735558904; x=1736163704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Ixh73tbJXTGNMUkPswfDBwd6vOw5DGCXKxSSlYsX7g=;
 b=Q8tMDlRgsc4DCJxyOwXnQ62818lai1kvXWdZiEwGAVzzTSkEfYzhJE3AQ7DjtkBH0p
 Wj4BHCsHk/PvzU+cC/E0soU60+83j7OLBAQM0Gn69D8h9O1JqNHE3leag7/En0gjF50i
 6ZKVkfDGIGg7PiADq3JJZRqf91jlDbBZq1URO2ZM+J/wV9uV4K/4PdLl71OhnkJF0z66
 dAe6JvMHfHet1bD7leOz+iwkL+F0md4l0dRAAj5fvMxasHK+GPW+RkQ3TaxAFrNw9Bnl
 dgpuw/zPwx3GhoqznpVPBu1D6yGuh6b8RnF7jwiuksJqzVr7VnAfBvOWFkkJM48XLWGI
 kzzg==
X-Gm-Message-State: AOJu0YyDh3nqXel7asGIWij8fe6WwY5bmgVumGdTGx5VrGimU0TfGg2c
 edz1FwcTxJVyGKi3K2p7K8UOTuIaaTNRqQ9jkB266p287bGjN6leyWn6G5aZTxhBYZW9sEO0vJX
 M2XCYDzQ+/HXhXRrt2hfhTRiPv2yCz+VA0wo7Ve9MHYZUIPEXaYVD2NiMdecB5cqEl1NiKg33x0
 USUqSkeSFEpmQU3DntW/jDJZ3kn0sa3Stb7gE=
X-Gm-Gg: ASbGncvK5qi+SfixKdsXst61evNG82Voz5QPuaJ91SpFXiHnIX75NtNVw9STTgAJuyN
 YXGFJCfFa/iDy0wOa4NB/FqehPrg6OC/hSpFW1tM=
X-Received: by 2002:a05:622a:2c3:b0:467:6b20:e0b1 with SMTP id
 d75a77b69052e-46a4a8c389dmr489993881cf.6.1735558903580; 
 Mon, 30 Dec 2024 03:41:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR7aKYcz2+u8EJC4OLxr9LVY0ZqLNhqIEgc2MYI1hP5U7QS6VJbJC97zZkU46R4Ol3uIoazkDy6nR7Ez4Dq6k=
X-Received: by 2002:a05:622a:2c3:b0:467:6b20:e0b1 with SMTP id
 d75a77b69052e-46a4a8c389dmr489993621cf.6.1735558903086; Mon, 30 Dec 2024
 03:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <20241223132355.1417356-7-r.peniaev@gmail.com>
In-Reply-To: <20241223132355.1417356-7-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Dec 2024 15:41:32 +0400
Message-ID: <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi

On Mon, Dec 23, 2024 at 5:24=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
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
> Patch implements another multiplexer type `mux-be`. The following
> is QEMU command line example:
>
>    -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 \
>    -chardev vc,id=3Dvc0 \
>    -chardev mux-be,id=3Dmux0,chardevs.0=3Dsock0,chardevs.1=3Dvc0 \
>    -device virtconsole,chardev=3Dmux0 \
>    -vnc 0.0.0.0:0
>
> Which creates 2 backend devices: text virtual console (`vc0`) and a
> socket (`sock0`) connected to the single virtio hvc console with the
> backend multiplexer (`mux0`) help. `vc0` renders text to an image,
> which can be shared over the VNC protocol.  `sock0` is a socket
> backend which provides biderectional communication to the virtio hvc
> console.
>
> 'chardevs.N' list syntax is used for the sake of compatibility with
> the representation of JSON lists in 'key=3Dval' pairs format of the
> util/keyval.c, despite the fact that modern QAPI way of parsing,
> namely qobject_input_visitor_new_str(), is not used. Choice of keeping
> QAPI list sytax may help to smoothly switch to modern parsing in the
> future.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  chardev/char-fe.c          |   9 ++
>  chardev/char-mux-be.c      | 321 +++++++++++++++++++++++++++++++++++++
>  chardev/char.c             |  30 +++-
>  chardev/chardev-internal.h |  38 ++++-
>  chardev/meson.build        |   1 +
>  include/chardev/char.h     |   1 +
>  qapi/char.json             |  27 ++++
>  7 files changed, 423 insertions(+), 4 deletions(-)
>  create mode 100644 chardev/char-mux-be.c
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 8853f7fb4686..a156053ebef3 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -200,6 +200,12 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Er=
ror **errp)
>              if (!mux_fe_chr_attach_frontend(d, b, &tag, errp)) {
>                  return false;
>              }
> +        } else if (CHARDEV_IS_MUX_BE(s)) {
> +            MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
> +
> +            if (!mux_be_chr_attach_frontend(d, b, errp)) {
> +                return false;
> +            }
>          } else if (s->be) {
>              error_setg(errp, "chardev '%s' is already in use", s->label)=
;
>              return false;
> @@ -226,6 +232,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
>          if (CHARDEV_IS_MUX_FE(b->chr)) {
>              MuxFeChardev *d =3D MUX_FE_CHARDEV(b->chr);
>              mux_fe_chr_detach_frontend(d, b->tag);
> +        } else if (CHARDEV_IS_MUX_BE(b->chr)) {
> +            MuxBeChardev *d =3D MUX_BE_CHARDEV(b->chr);
> +            mux_be_chr_detach_frontend(d);
>          }
>          if (del) {
>              Object *obj =3D OBJECT(b->chr);
> diff --git a/chardev/char-mux-be.c b/chardev/char-mux-be.c
> new file mode 100644
> index 000000000000..f24c00dee2fe
> --- /dev/null
> +++ b/chardev/char-mux-be.c
> @@ -0,0 +1,321 @@
> +/*
> + * QEMU Character Backend Multiplexer
> + *
> + * Author: Roman Penyaev <r.peniaev@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/option.h"
> +#include "chardev/char.h"
> +#include "chardev-internal.h"
> +
> +/*
> + * MUX-BE driver for multiplexing 1 frontend device with N backend devic=
es
> + */
> +
> +/*
> + * Write to all backends. Different backend devices accept data with
> + * various rate, so it is quite possible that one device returns less,
> + * then others. In this case we return minimum to the caller,
> + * expecting caller will repeat operation soon. When repeat happens
> + * send to the devices which consume data faster must be avoided
> + * for obvious reasons not to send data, which was already sent.
> + */
> +static int mux_be_chr_write_to_all(MuxBeChardev *d, const uint8_t *buf, =
int len)
> +{
> +    int r, i, ret =3D len;
> +    unsigned int written;
> +
> +    /* Invalidate index on every write */
> +    d->be_eagain_ind =3D -1;
> +
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        written =3D d->be_written[i] - d->be_min_written;
> +        if (written) {
> +            /* Written in the previous call so take into account */
> +            ret =3D MIN(written, ret);
> +            continue;
> +        }
> +        r =3D qemu_chr_fe_write(&d->backends[i], buf, len);
> +        if (r < 0 && errno =3D=3D EAGAIN) {
> +            /*
> +             * Fail immediately if write would block. Expect to be calle=
d
> +             * soon on watch wake up.
> +             */
> +            d->be_eagain_ind =3D i;
> +            return r;

But next attempt to write will loop over the same backend again, which
will see the "same" write multiple times.

> +        } else if (r < 0) {
> +            /*
> +             * Ignore all other errors and pretend the entire buffer is
> +             * written to avoid this chardev being watched. This device
> +             * becomes disabled until the following write succeeds, but
> +             * writing continues to others.
> +             */
> +            r =3D len;
> +        }
> +        d->be_written[i] +=3D r;
> +        ret =3D MIN(r, ret);
> +    }
> +    d->be_min_written +=3D ret;
> +
> +    return ret;
> +}

I am not sure what is the correct way to handle write here. This
mux-be behaviour is different from mux-fe, since it handles all
backend I/Os, and does not select one... it's more of a "mixer",
right, Is this wanted?

> +
> +/* Called with chr_write_lock held.  */
> +static int mux_be_chr_write(Chardev *chr, const uint8_t *buf, int len)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +    return mux_be_chr_write_to_all(d, buf, len);
> +}
> +
> +static void mux_be_chr_send_event(MuxBeChardev *d, QEMUChrEvent event)
> +{
> +    CharBackend *fe =3D d->frontend;
> +
> +    if (fe && fe->chr_event) {
> +        fe->chr_event(fe->opaque, event);
> +    }
> +}
> +
> +static void mux_be_chr_be_event(Chardev *chr, QEMUChrEvent event)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +
> +    mux_be_chr_send_event(d, event);
> +}
> +
> +static int mux_be_chr_can_read(void *opaque)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);
> +    CharBackend *fe =3D d->frontend;
> +
> +    if (fe && fe->chr_can_read) {
> +        return fe->chr_can_read(fe->opaque);
> +    }
> +
> +    return 0;
> +}
> +
> +static void mux_be_chr_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);
> +    CharBackend *fe =3D d->frontend;
> +
> +    if (fe && fe->chr_read) {
> +        fe->chr_read(fe->opaque, buf, size);
> +    }
> +}
> +
> +void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event)
> +{
> +    mux_be_chr_send_event(d, event);
> +}
> +
> +static void mux_be_chr_event(void *opaque, QEMUChrEvent event)
> +{
> +    mux_chr_send_all_event(CHARDEV(opaque), event);
> +}
> +
> +static GSource *mux_be_chr_add_watch(Chardev *s, GIOCondition cond)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
> +    Chardev *chr;
> +    ChardevClass *cc;
> +
> +    if (d->be_eagain_ind =3D=3D -1)
> +        return NULL;
> +
> +    assert(d->be_eagain_ind < d->be_cnt);
> +    chr =3D qemu_chr_fe_get_driver(&d->backends[d->be_eagain_ind]);
> +    cc =3D CHARDEV_GET_CLASS(chr);
> +    if (!cc->chr_add_watch) {
> +        return NULL;
> +    }
> +
> +    return cc->chr_add_watch(chr, cond);
> +}
> +
> +static bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr,
> +                                      Error **errp)
> +{
> +    bool ret;
> +
> +    if (d->be_cnt >=3D MAX_MUX) {
> +        error_setg(errp, "mux-be: too many uses of multiplexed chardev '=
%s'"
> +                   " (maximum is " stringify(MAX_MUX) ")",
> +                   d->parent.label);
> +        return false;
> +    }
> +    ret =3D qemu_chr_fe_init(&d->backends[d->be_cnt], chr, errp);
> +    if (ret) {
> +        /* Catch up with what was already written */
> +        d->be_written[d->be_cnt] =3D d->be_min_written;
> +        d->be_cnt +=3D 1;
> +    }
> +
> +    return ret;
> +}
> +
> +static void char_mux_be_finalize(Object *obj)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(obj);
> +    CharBackend *fe =3D d->frontend;
> +    int i;
> +
> +    if (fe) {
> +        fe->chr =3D NULL;
> +    }
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        qemu_chr_fe_deinit(&d->backends[i], false);
> +    }
> +}
> +
> +static void mux_be_chr_update_read_handlers(Chardev *chr)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +    int i;
> +
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        /* Fix up the real driver with mux routines */
> +        qemu_chr_fe_set_handlers_full(&d->backends[i],
> +                                      mux_be_chr_can_read,
> +                                      mux_be_chr_read,
> +                                      mux_be_chr_event,
> +                                      NULL,
> +                                      chr,
> +                                      chr->gcontext, true, false);
> +    }
> +}
> +
> +bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error *=
*errp)
> +{
> +    if (d->frontend) {
> +        error_setg(errp, "mux-be: multiplexed chardev '%s' is already us=
ed "
> +                   "for multiplexing", d->parent.label);
> +        return false;
> +    }
> +    d->frontend =3D b;
> +
> +    return true;
> +}
> +
> +void mux_be_chr_detach_frontend(MuxBeChardev *d)
> +{
> +    d->frontend =3D NULL;
> +}
> +
> +static void qemu_chr_open_mux_be(Chardev *chr,
> +                                 ChardevBackend *backend,
> +                                 bool *be_opened,
> +                                 Error **errp)
> +{
> +    ChardevMuxBe *mux =3D backend->u.mux_be.data;
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +    strList *list =3D mux->chardevs;
> +
> +    d->be_eagain_ind =3D -1;
> +
> +    if (list =3D=3D NULL) {
> +        error_setg(errp, "mux-be: 'chardevs' list is not defined");
> +        return;
> +    }
> +
> +    while (list) {
> +        Chardev *s;
> +
> +        s =3D qemu_chr_find(list->value);
> +        if (s =3D=3D NULL) {
> +            error_setg(errp, "mux-be: chardev can't be found by id '%s'"=
,
> +                       list->value);
> +            return;
> +        }
> +        if (CHARDEV_IS_MUX_BE(s) || CHARDEV_IS_MUX_FE(s)) {
> +            error_setg(errp, "mux-be: multiplexers can't be stacked, che=
ck "
> +                       "chardev '%s', chardev should not be a multiplexe=
r or "
> +                       "have 'mux=3Don' enabled", list->value);
> +            return;
> +        }
> +        if (!mux_be_chr_attach_chardev(d, s, errp)) {
> +            return;
> +        }
> +        list =3D list->next;
> +    }
> +
> +    /*
> +     * Only default to opened state if we've realized the initial
> +     * set of muxes
> +     */
> +    *be_opened =3D mux_is_opened();
> +}
> +
> +static void qemu_chr_parse_mux_be(QemuOpts *opts, ChardevBackend *backen=
d,
> +                                  Error **errp)
> +{
> +    ChardevMuxBe *mux;
> +    strList **tail;
> +    int i;
> +
> +    backend->type =3D CHARDEV_BACKEND_KIND_MUX_BE;
> +    mux =3D backend->u.mux_be.data =3D g_new0(ChardevMuxBe, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevMuxBe_base(mux));
> +
> +    tail =3D &mux->chardevs;
> +
> +    for (i =3D 0; i < MAX_MUX; i++) {
> +        char optbuf[16];
> +        const char *dev;
> +
> +        snprintf(optbuf, sizeof(optbuf), "chardevs.%u", i);
> +        dev =3D qemu_opt_get(opts, optbuf);
> +        if (!dev)
> +            break;
> +
> +        QAPI_LIST_APPEND(tail, g_strdup(dev));
> +    }
> +}
> +
> +static void char_mux_be_class_init(ObjectClass *oc, void *data)
> +{
> +    ChardevClass *cc =3D CHARDEV_CLASS(oc);
> +
> +    cc->parse =3D qemu_chr_parse_mux_be;
> +    cc->open =3D qemu_chr_open_mux_be;
> +    cc->chr_write =3D mux_be_chr_write;
> +    cc->chr_add_watch =3D mux_be_chr_add_watch;
> +    cc->chr_be_event =3D mux_be_chr_be_event;
> +    cc->chr_update_read_handler =3D mux_be_chr_update_read_handlers;
> +}
> +
> +static const TypeInfo char_mux_be_type_info =3D {
> +    .name =3D TYPE_CHARDEV_MUX_BE,
> +    .parent =3D TYPE_CHARDEV,
> +    .class_init =3D char_mux_be_class_init,
> +    .instance_size =3D sizeof(MuxBeChardev),
> +    .instance_finalize =3D char_mux_be_finalize,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&char_mux_be_type_info);
> +}
> +
> +type_init(register_types);
> diff --git a/chardev/char.c b/chardev/char.c
> index 08e7f23bddb2..3e85cfc5a4ba 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -341,6 +341,9 @@ static bool qemu_chr_is_busy(Chardev *s)
>      if (CHARDEV_IS_MUX_FE(s)) {
>          MuxFeChardev *d =3D MUX_FE_CHARDEV(s);
>          return d->mux_bitset !=3D 0;
> +    } else if (CHARDEV_IS_MUX_BE(s)) {
> +        MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
> +        return d->frontend !=3D NULL;
>      } else {
>          return s->be !=3D NULL;
>      }
> @@ -949,7 +952,26 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "chardev",
>              .type =3D QEMU_OPT_STRING,
> +        },
> +        /*
> +         * Multiplexer options. Follows QAPI array syntax.
> +         * See MAX_MUX macro to obtain array capacity.
> +         */
> +        {
> +            .name =3D "chardevs.0",
> +            .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "chardevs.1",
> +            .type =3D QEMU_OPT_STRING,
>          },{
> +            .name =3D "chardevs.2",
> +            .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "chardevs.3",
> +            .type =3D QEMU_OPT_STRING,
> +        },
> +
> +        {
>              .name =3D "append",
>              .type =3D QEMU_OPT_BOOL,
>          },{
> @@ -1112,7 +1134,7 @@ ChardevReturn *qmp_chardev_change(const char *id, C=
hardevBackend *backend,
>          return NULL;
>      }
>
> -    if (CHARDEV_IS_MUX_FE(chr)) {
> +    if (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr)) {
>          error_setg(errp, "Mux device hotswap not supported yet");
>          return NULL;
>      }
> @@ -1300,7 +1322,7 @@ static int chardev_options_parsed_cb(Object *child,=
 void *opaque)
>  {
>      Chardev *chr =3D (Chardev *)child;
>
> -    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
> +    if (!chr->be_open && (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(ch=
r))) {
>          open_muxes(chr);
>      }
>
> @@ -1327,8 +1349,10 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrE=
vent event)
>
>      if (CHARDEV_IS_MUX_FE(chr)) {
>          MuxFeChardev *d =3D MUX_FE_CHARDEV(chr);
> -
>          mux_fe_chr_send_all_event(d, event);
> +    } else if (CHARDEV_IS_MUX_BE(chr)) {
> +        MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +        mux_be_chr_send_all_event(d, event);
>      }
>  }
>
> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> index 94c8d07ac235..8c98a3fb0767 100644
> --- a/chardev/chardev-internal.h
> +++ b/chardev/chardev-internal.h
> @@ -35,7 +35,9 @@
>
>  struct MuxFeChardev {
>      Chardev parent;
> +    /* Linked frontends */
>      CharBackend *backends[MAX_MUX];
> +    /* Linked backend */
>      CharBackend chr;
>      unsigned long mux_bitset;
>      int focus;
> @@ -54,10 +56,41 @@ struct MuxFeChardev {
>  };
>  typedef struct MuxFeChardev MuxFeChardev;
>
> +struct MuxBeChardev {
> +    Chardev parent;
> +    /* Linked frontend */
> +    CharBackend *frontend;
> +    /* Linked backends */
> +    CharBackend backends[MAX_MUX];
> +    /*
> +     * Number of backends attached to this mux. Once attached, a
> +     * backend can't be detached, so the counter is only increasing.
> +     * To safely remove a backend, mux has to be removed first.
> +     */
> +    unsigned int be_cnt;
> +    /*
> +     * Counters of written bytes from a single frontend device
> +     * to multiple backend devices.
> +     */
> +    unsigned int be_written[MAX_MUX];
> +    unsigned int be_min_written;
> +    /*
> +     * Index of a backend device which got EAGAIN on last write,
> +     * -1 is invalid index.
> +     */
> +    int be_eagain_ind;
> +};
> +typedef struct MuxBeChardev MuxBeChardev;
> +
>  DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
>                           TYPE_CHARDEV_MUX_FE)
> -#define CHARDEV_IS_MUX_FE(chr)                             \
> +DECLARE_INSTANCE_CHECKER(MuxBeChardev, MUX_BE_CHARDEV,
> +                         TYPE_CHARDEV_MUX_BE)
> +
> +#define CHARDEV_IS_MUX_FE(chr)                              \
>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)
> +#define CHARDEV_IS_MUX_BE(chr)                              \
> +    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_BE)
>
>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
>
> @@ -67,6 +100,9 @@ void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUCh=
rEvent event);
>  bool mux_fe_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
>                                  unsigned int *tag, Error **errp);
>  bool mux_fe_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
> +void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event);
> +bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error *=
*errp);
> +void mux_be_chr_detach_frontend(MuxBeChardev *d);
>
>  Object *get_chardevs_root(void);
>
> diff --git a/chardev/meson.build b/chardev/meson.build
> index 778444a00ca6..3a9f5565372b 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -3,6 +3,7 @@ chardev_ss.add(files(
>    'char-file.c',
>    'char-io.c',
>    'char-mux-fe.c',
> +  'char-mux-be.c',
>    'char-null.c',
>    'char-pipe.c',
>    'char-ringbuf.c',
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 0bec974f9d73..c58c11c4eeaf 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
>
>  #define TYPE_CHARDEV_NULL "chardev-null"
>  #define TYPE_CHARDEV_MUX_FE "chardev-mux"
> +#define TYPE_CHARDEV_MUX_BE "chardev-mux-be"
>  #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
>  #define TYPE_CHARDEV_PTY "chardev-pty"
>  #define TYPE_CHARDEV_CONSOLE "chardev-console"
> diff --git a/qapi/char.json b/qapi/char.json
> index e04535435034..2ad77a7f6435 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -332,6 +332,19 @@
>    'data': { 'chardev': 'str' },
>    'base': 'ChardevCommon' }
>
> +##
> +# @ChardevMuxBe:
> +#
> +# Configuration info for mux-be chardevs.
> +#
> +# @chardevs: List of chardev IDs, which should be added to this mux
> +#
> +# Since: 9.3
> +##
> +{ 'struct': 'ChardevMuxBe',
> +  'data': { 'chardevs': ['str'] },
> +  'base': 'ChardevCommon' }
> +
>  ##
>  # @ChardevStdio:
>  #
> @@ -479,6 +492,8 @@
>  #
>  # @mux: (since 1.5)
>  #
> +# @mux-be: (since 9.3)
> +#
>  # @msmouse: emulated Microsoft serial mouse (since 1.5)
>  #
>  # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
> @@ -521,6 +536,7 @@
>              'pty',
>              'null',
>              'mux',
> +            'mux-be',
>              'msmouse',
>              'wctablet',
>              { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
> @@ -595,6 +611,16 @@
>  { 'struct': 'ChardevMuxWrapper',
>    'data': { 'data': 'ChardevMux' } }
>
> +##
> +# @ChardevMuxBeWrapper:
> +#
> +# @data: Configuration info for mux-be chardevs
> +#
> +# Since: 9.3
> +##
> +{ 'struct': 'ChardevMuxBeWrapper',
> +  'data': { 'data': 'ChardevMuxBe' } }
> +
>  ##
>  # @ChardevStdioWrapper:
>  #
> @@ -703,6 +729,7 @@
>              'pty': 'ChardevPtyWrapper',
>              'null': 'ChardevCommonWrapper',
>              'mux': 'ChardevMuxWrapper',
> +            'mux-be': 'ChardevMuxBeWrapper',
>              'msmouse': 'ChardevCommonWrapper',
>              'wctablet': 'ChardevCommonWrapper',
>              'braille': { 'type': 'ChardevCommonWrapper',
> --
> 2.34.1
>


