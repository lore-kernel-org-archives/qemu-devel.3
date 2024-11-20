Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20089D6E2CE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 08:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfeH-0001ev-Tr; Wed, 20 Nov 2024 03:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfeG-0001el-P8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:01:16 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfeD-0003Kv-By
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:01:16 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539e59dadebso2374170e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 00:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732089671; x=1732694471; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gzed+WasMuk5OprZKiT4Z5huOL0QhRfXgZ+FQw0cSsA=;
 b=X94f/ixG8d/rRaUSp/UuNYKHhPeW6EWHmFiD/47xdET0/e4IL6cyRzJupdXmAAOwGO
 +FZ3vYD9CoRfk2631Kb7PqxgnoGGi3G53XoK4QUOWe3ajtz5RYj+6BvtUnp6ZmZfq1zc
 J31E1gobKp09Q6lc0FM3nnZiuYyTYUydvY8jIbgBBFBZmbBKPWKixYLBCNJAfWuyNNrS
 AU79V6zuZXFWOglOR+LFD+uODEB46JU1adtI4zqAD4ddTOoSK27CfgRiRsNYMG7xZ7kf
 OJsja7cb2kfFFdze79C5q5Wf/z+0e07wDUvcCjgdXrmZhneaMjgTce44hZiJZOteW2S6
 eweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732089671; x=1732694471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gzed+WasMuk5OprZKiT4Z5huOL0QhRfXgZ+FQw0cSsA=;
 b=fKsnqHDmlu8Qs5UfKUYNNNlju9KVKw1rRvgZcpzVSBFCmOHSdwkPnxmQnGPU0W4s9J
 wgyEtcMF0MmPabGvM75XxPCoT5KvScxWDI5BpgntWIvdmhQYDyQQ/pi6MykMWWg5s66+
 hhDMScTkbp/zbilmnrbgVbY4ECn7y93lyZFd6ZJRqBRUxFciLEqrymTQnDGpWmUv3q5V
 jMuEts0ssuPAzSDTRN0wNJRLkzu2VUjjA3gkasFcTY2S7/KU7QX7IBrz28j0pAx9c9zy
 MuYUpjBAIAA7RRRFLnm2HYnWW/NCBIA6ld3hRARNZfPnQ9BuCwioXlPxFKd7RdcT2v6S
 7VeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoo5vZWkz2CH9Mza4bJw9b96E4stBROsY4DQPqabbFfrPhkBaOIzRCx9y/YmWb30h4vz8KiSkaqb+p@nongnu.org
X-Gm-Message-State: AOJu0YxZdXhnmTB4EC2Dkr1U049KIHC7E9KHBKZWbyuc/4EG9IsoLhko
 HW10S0IBWyJZrGbI0EdJm5fuk/rtoRHdyP8j/d6bs89ycPkN3Hr6bJFgUP6blWpD9xL8iBqNNfW
 CR8py+LpfGf00AvQTtid+De6sX25nJI7n
X-Gm-Gg: ASbGncte3WhzTHdlMPzDCXLwK1MTorJL6QMsdfcKJP9aLA1YQd42WtSQcN/wbCHqDl4
 0Iat2AmHHPr7weXsKkxqPboDwARkLghMUzwH+hvoVJpxnFParAUw9FRWRd/aMbh4Reg==
X-Google-Smtp-Source: AGHT+IG8Cb6MT194JqtrSnOibfxIXB8Ro7byH2DeZFgCKMkl1Ds6/Z4N+qtOeJaofGjguB0LZqCzkIxEC22gzMW1lV4=
X-Received: by 2002:a05:6512:2389:b0:53c:74de:3cd2 with SMTP id
 2adb3069b0e04-53dc133339cmr650537e87.18.1732089669618; Wed, 20 Nov 2024
 00:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Wed, 20 Nov 2024 09:00:58 +0100
Message-ID: <CACZ9PQVSXCLN5VFM271okMFt=77jyYiyOLs3Kf-YbhqPkVZ8Xw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x135.google.com
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

Hi all,

Just a quick reminder about the patchset I sent a while
back for the `mux-be-id` property. I=E2=80=99d really like to move
forward with the mux-be implementation, but I=E2=80=99m still not
sure what the best approach would be. Any feedback and
comments would be appreciated.

Thanks.

--
Roman

On Wed, Oct 16, 2024 at 1:14=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>>
>> This patch implements multiplexing capability of several backend
>> devices, which opens up an opportunity to use a single frontend
>> device on the guest, which can be manipulated from several
>> backend devices.
>>
>> The idea of the change is trivial: keep list of backend devices
>> (up to 4), init them on demand and forward data buffer back and
>> forth.
>>
>> Patch implements another multiplexer type `mux-be`. The following
>> is QEMU command line example:
>>
>>    -chardev mux-be,id=3Dmux0 \
>>    -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mu=
x-be-id=3Dmux0 \
>>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
>
>
> I am not sure about adding "mux-be-id" to all chardev. It avoids the issu=
e of expressing a list of ids in mux-be though (while it may have potential=
 loop!)
>
> Markus, do you have a suggestion to take an array of chardev ids as a CLI=
 option? It looks like we could require QAPIfy -chardev from Kevin here..
>
> thanks
>
>>    -device virtconsole,chardev=3Dmux0 \
>>
>>    -vnc 0.0.0.0:0
>>
>> Which creates 2 backend devices: text virtual console (`vc0`) and a
>> socket (`sock0`) connected to the single virtio hvc console with the
>> backend multiplexer (`mux0`) help. `vc0` renders text to an image,
>> which can be shared over the VNC protocol.  `sock0` is a socket
>> backend which provides biderectional communication to the virtio hvc
>> console.
>>
>> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: qemu-devel@nongnu.org
>> ---
>>  chardev/char-fe.c          |   9 ++
>>  chardev/char-mux-be.c      | 290 +++++++++++++++++++++++++++++++++++++
>>  chardev/char.c             |  56 +++++--
>>  chardev/chardev-internal.h |  34 ++++-
>>  chardev/meson.build        |   1 +
>>  include/chardev/char.h     |   1 +
>>  qapi/char.json             |  25 ++++
>>  7 files changed, 403 insertions(+), 13 deletions(-)
>>  create mode 100644 chardev/char-mux-be.c
>>
>> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
>> index a2b5bff39fd9..2f794674563b 100644
>> --- a/chardev/char-fe.c
>> +++ b/chardev/char-fe.c
>> @@ -200,6 +200,12 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, E=
rror **errp)
>>              if (!mux_fe_chr_attach_frontend(d, b, &tag, errp)) {
>>                  return false;
>>              }
>> +        } else if (CHARDEV_IS_MUX_BE(s)) {
>> +            MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
>> +
>> +            if (!mux_be_chr_attach_frontend(d, b, errp)) {
>> +                return false;
>> +            }
>>          } else if (s->be) {
>>              error_setg(errp, "chardev '%s' is already in use", s->label=
);
>>              return false;
>> @@ -226,6 +232,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
>>          if (CHARDEV_IS_MUX_FE(b->chr)) {
>>              MuxFeChardev *d =3D MUX_FE_CHARDEV(b->chr);
>>              mux_fe_chr_detach_frontend(d, b->tag);
>> +        } else if (CHARDEV_IS_MUX_BE(b->chr)) {
>> +            MuxBeChardev *d =3D MUX_BE_CHARDEV(b->chr);
>> +            mux_be_chr_detach_frontend(d);
>>          }
>>          if (del) {
>>              Object *obj =3D OBJECT(b->chr);
>> diff --git a/chardev/char-mux-be.c b/chardev/char-mux-be.c
>> new file mode 100644
>> index 000000000000..64a4f2c00034
>> --- /dev/null
>> +++ b/chardev/char-mux-be.c
>> @@ -0,0 +1,290 @@
>> +/*
>> + * QEMU Character Backend Multiplexer
>> + *
>> + * Author: Roman Penyaev <r.peniaev@gmail.com>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g a copy
>> + * of this software and associated documentation files (the "Software")=
, to deal
>> + * in the Software without restriction, including without limitation th=
e rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or=
 sell
>> + * copies of the Software, and to permit persons to whom the Software i=
s
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be inclu=
ded in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH=
ALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "qemu/option.h"
>> +#include "qemu/cutils.h"
>> +#include "chardev/char.h"
>> +#include "sysemu/block-backend.h"
>> +#include "qapi/qapi-commands-control.h"
>> +#include "qapi/clone-visitor.h"
>> +#include "qapi/qapi-builtin-visit.h"
>> +#include "chardev-internal.h"
>> +
>> +/*
>> + * MUX-BE driver for multiplexing 1 frontend device with N backend devi=
ces
>> + */
>> +
>> +/*
>> + * Write to all backends. Different backend devices accept data with
>> + * various rate, so it is quite possible that one device returns less,
>> + * then others. In this case we return minimum to the caller,
>> + * expecting caller will repeat operation soon. When repeat happens
>> + * send to the devices which consume data faster must be avoided
>> + * for obvious reasons not to send data, which was already sent.
>> + */
>> +static int mux_be_chr_write_to_all(MuxBeChardev *d, const uint8_t *buf,=
 int len)
>> +{
>> +    int r, i, ret =3D len;
>> +    unsigned int written;
>> +
>> +    for (i =3D 0; i < d->be_cnt; i++) {
>> +        written =3D d->be_written[i] - d->be_min_written;
>> +        if (written) {
>> +            /* Written in the previous call so take into account */
>> +            ret =3D MIN(written, ret);
>> +            continue;
>> +        }
>> +        r =3D qemu_chr_fe_write(&d->backends[i], buf, len);
>> +        if (r < 0 && errno =3D=3D EAGAIN) {
>> +            /*
>> +             * Fail immediately if write would block. Expect to be call=
ed
>> +             * soon on watch wake up.
>> +             */
>> +            return r;
>> +        } else if (r < 0) {
>> +            /*
>> +             * Ignore all other errors and pretend the entire buffer is
>> +             * written to avoid this chardev being watched. This device
>> +             * becomes disabled until the following write succeeds, but
>> +             * writing continues to others.
>> +             */
>> +            r =3D len;
>> +        }
>> +        d->be_written[i] +=3D r;
>> +        ret =3D MIN(r, ret);
>> +    }
>> +    d->be_min_written +=3D ret;
>> +
>> +    return ret;
>> +}
>> +
>> +/* Called with chr_write_lock held.  */
>> +static int mux_be_chr_write(Chardev *chr, const uint8_t *buf, int len)
>> +{
>> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
>> +    return mux_be_chr_write_to_all(d, buf, len);
>> +}
>> +
>> +static void mux_be_chr_send_event(MuxBeChardev *d, QEMUChrEvent event)
>> +{
>> +    CharBackend *fe =3D d->frontend;
>> +
>> +    if (fe && fe->chr_event) {
>> +        fe->chr_event(fe->opaque, event);
>> +    }
>> +}
>> +
>> +static void mux_be_chr_be_event(Chardev *chr, QEMUChrEvent event)
>> +{
>> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
>> +
>> +    mux_be_chr_send_event(d, event);
>> +}
>> +
>> +static int mux_be_chr_can_read(void *opaque)
>> +{
>> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);
>> +    CharBackend *fe =3D d->frontend;
>> +
>> +    if (fe && fe->chr_can_read) {
>> +        return fe->chr_can_read(fe->opaque);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void mux_be_chr_read(void *opaque, const uint8_t *buf, int size)
>> +{
>> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);
>> +    CharBackend *fe =3D d->frontend;
>> +
>> +    if (fe && fe->chr_read) {
>> +        fe->chr_read(fe->opaque, buf, size);
>> +    }
>> +}
>> +
>> +void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event)
>> +{
>> +    mux_be_chr_send_event(d, event);
>> +}
>> +
>> +static void mux_be_chr_event(void *opaque, QEMUChrEvent event)
>> +{
>> +    mux_chr_send_all_event(CHARDEV(opaque), event);
>> +}
>> +
>> +static GSource *mux_be_chr_add_watch(Chardev *s, GIOCondition cond)
>> +{
>> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
>> +    Chardev *chr;
>> +    ChardevClass *cc;
>> +    unsigned int written;
>> +    int i;
>> +
>> +    for (i =3D 0; i < d->be_cnt; i++) {
>> +        written =3D d->be_written[i] - d->be_min_written;
>> +        if (written) {
>> +            /* We skip the device with already written buffer */
>> +            continue;
>> +        }
>> +
>> +        /*
>> +         * The first device that has no data written to it must be
>> +         * the device that recently returned EAGAIN and should be
>> +         * watched.
>> +         */
>> +
>> +        chr =3D qemu_chr_fe_get_driver(&d->backends[i]);
>> +        cc =3D CHARDEV_GET_CLASS(chr);
>> +
>> +        if (!cc->chr_add_watch) {
>> +            return NULL;
>> +        }
>> +
>> +        return cc->chr_add_watch(chr, cond);
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **e=
rrp)
>> +{
>> +    bool ret;
>> +
>> +    if (d->be_cnt >=3D MAX_MUX) {
>> +        error_setg(errp, "too many uses of multiplexed chardev '%s'"
>> +                   " (maximum is " stringify(MAX_MUX) ")",
>> +                   d->parent.label);
>> +        return false;
>> +    }
>> +    ret =3D qemu_chr_fe_init(&d->backends[d->be_cnt], chr, errp);
>> +    if (ret) {
>> +        /* Catch up with what was already written */
>> +        d->be_written[d->be_cnt] =3D d->be_min_written;
>> +        d->be_cnt +=3D 1;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void char_mux_be_finalize(Object *obj)
>> +{
>> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(obj);
>> +    CharBackend *fe =3D d->frontend;
>> +    int i;
>> +
>> +    if (fe) {
>> +        fe->chr =3D NULL;
>> +    }
>> +    for (i =3D 0; i < d->be_cnt; i++) {
>> +        qemu_chr_fe_deinit(&d->backends[i], false);
>> +    }
>> +}
>> +
>> +static void mux_be_chr_update_read_handlers(Chardev *chr)
>> +{
>> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
>> +    int i;
>> +
>> +    for (i =3D 0; i < d->be_cnt; i++) {
>> +        /* Fix up the real driver with mux routines */
>> +        qemu_chr_fe_set_handlers_full(&d->backends[i],
>> +                                      mux_be_chr_can_read,
>> +                                      mux_be_chr_read,
>> +                                      mux_be_chr_event,
>> +                                      NULL,
>> +                                      chr,
>> +                                      chr->gcontext, true, false);
>> +    }
>> +}
>> +
>> +bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error =
**errp)
>> +{
>> +    if (d->frontend) {
>> +        error_setg(errp,
>> +                   "multiplexed chardev '%s' is already used "
>> +                   "for multiplexing", d->parent.label);
>> +        return false;
>> +    }
>> +    d->frontend =3D b;
>> +
>> +    return true;
>> +}
>> +
>> +void mux_be_chr_detach_frontend(MuxBeChardev *d)
>> +{
>> +    d->frontend =3D NULL;
>> +}
>> +
>> +static void qemu_chr_open_mux_be(Chardev *chr,
>> +                                 ChardevBackend *backend,
>> +                                 bool *be_opened,
>> +                                 Error **errp)
>> +{
>> +    /*
>> +     * Only default to opened state if we've realized the initial
>> +     * set of muxes
>> +     */
>> +    *be_opened =3D mux_is_opened();
>> +}
>> +
>> +static void qemu_chr_parse_mux_be(QemuOpts *opts, ChardevBackend *backe=
nd,
>> +                                  Error **errp)
>> +{
>> +    ChardevMuxBe *mux;
>> +
>> +    backend->type =3D CHARDEV_BACKEND_KIND_MUX_BE;
>> +    mux =3D backend->u.mux_be.data =3D g_new0(ChardevMuxBe, 1);
>> +    qemu_chr_parse_common(opts, qapi_ChardevMuxBe_base(mux));
>> +}
>> +
>> +static void char_mux_be_class_init(ObjectClass *oc, void *data)
>> +{
>> +    ChardevClass *cc =3D CHARDEV_CLASS(oc);
>> +
>> +    cc->parse =3D qemu_chr_parse_mux_be;
>> +    cc->open =3D qemu_chr_open_mux_be;
>> +    cc->chr_write =3D mux_be_chr_write;
>> +    cc->chr_add_watch =3D mux_be_chr_add_watch;
>> +    cc->chr_be_event =3D mux_be_chr_be_event;
>> +    cc->chr_update_read_handler =3D mux_be_chr_update_read_handlers;
>> +}
>> +
>> +static const TypeInfo char_mux_be_type_info =3D {
>> +    .name =3D TYPE_CHARDEV_MUX_BE,
>> +    .parent =3D TYPE_CHARDEV,
>> +    .class_init =3D char_mux_be_class_init,
>> +    .instance_size =3D sizeof(MuxBeChardev),
>> +    .instance_finalize =3D char_mux_be_finalize,
>> +};
>> +
>> +static void register_types(void)
>> +{
>> +    type_register_static(&char_mux_be_type_info);
>> +}
>> +
>> +type_init(register_types);
>> diff --git a/chardev/char.c b/chardev/char.c
>> index cffe60860589..58fa8ac70a1e 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -341,6 +341,9 @@ static bool qemu_chr_is_busy(Chardev *s)
>>      if (CHARDEV_IS_MUX_FE(s)) {
>>          MuxFeChardev *d =3D MUX_FE_CHARDEV(s);
>>          return d->mux_bitset !=3D 0;
>> +    } else if (CHARDEV_IS_MUX_BE(s)) {
>> +        MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
>> +        return d->frontend !=3D NULL;
>>      } else {
>>          return s->be !=3D NULL;
>>      }
>> @@ -648,7 +651,8 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *o=
pts, GMainContext *context,
>>      ChardevBackend *backend =3D NULL;
>>      const char *name =3D qemu_opt_get(opts, "backend");
>>      const char *id =3D qemu_opts_id(opts);
>> -    char *bid =3D NULL;
>> +    const char *mux_be_id =3D NULL;
>> +    char *mux_fe_id =3D NULL;
>>
>>      if (name && is_help_option(name)) {
>>          GString *str =3D g_string_new("");
>> @@ -676,10 +680,16 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts =
*opts, GMainContext *context,
>>      }
>>
>>      if (qemu_opt_get_bool(opts, "mux", 0)) {
>> -        bid =3D g_strdup_printf("%s-base", id);
>> +        mux_fe_id =3D g_strdup_printf("%s-base", id);
>> +    }
>> +    mux_be_id =3D qemu_opt_get(opts, "mux-be-id");
>> +    if (mux_be_id && mux_fe_id) {
>> +        error_setg(errp, "chardev: mux and mux-be can't be used for the=
 same "
>> +                   "device");
>> +        goto out;
>>      }
>>
>> -    chr =3D qemu_chardev_new(bid ? bid : id,
>> +    chr =3D qemu_chardev_new(mux_fe_id ? mux_fe_id : id,
>>                             object_class_get_name(OBJECT_CLASS(cc)),
>>                             backend, context, errp);
>>      if (chr =3D=3D NULL) {
>> @@ -687,25 +697,40 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts =
*opts, GMainContext *context,
>>      }
>>
>>      base =3D chr;
>> -    if (bid) {
>> +    if (mux_fe_id) {
>>          Chardev *mux;
>>          qapi_free_ChardevBackend(backend);
>>          backend =3D g_new0(ChardevBackend, 1);
>>          backend->type =3D CHARDEV_BACKEND_KIND_MUX;
>>          backend->u.mux.data =3D g_new0(ChardevMux, 1);
>> -        backend->u.mux.data->chardev =3D g_strdup(bid);
>> +        backend->u.mux.data->chardev =3D g_strdup(mux_fe_id);
>>          mux =3D qemu_chardev_new(id, TYPE_CHARDEV_MUX_FE, backend, cont=
ext, errp);
>>          if (mux =3D=3D NULL) {
>> -            object_unparent(OBJECT(chr));
>> -            chr =3D NULL;
>> -            goto out;
>> +            goto unparent_and_out;
>>          }
>>          chr =3D mux;
>> +    } else if (mux_be_id) {
>> +        Chardev *s;
>> +
>> +        s =3D qemu_chr_find(mux_be_id);
>> +        if (!s) {
>> +            error_setg(errp, "chardev: mux-be device can't be found by =
id '%s'",
>> +                       mux_be_id);
>> +            goto unparent_and_out;
>> +        }
>> +        if (!CHARDEV_IS_MUX_BE(s)) {
>> +            error_setg(errp, "chardev: device '%s' is not a multiplexer=
 device"
>> +                       " of 'mux-be' type", mux_be_id);
>> +            goto unparent_and_out;
>> +        }
>> +        if (!mux_be_chr_attach_chardev(MUX_BE_CHARDEV(s), chr, errp)) {
>> +            goto unparent_and_out;
>> +        }
>>      }
>>
>>  out:
>>      qapi_free_ChardevBackend(backend);
>> -    g_free(bid);
>> +    g_free(mux_fe_id);
>>
>>      if (replay && base) {
>>          /* RR should be set on the base device, not the mux */
>> @@ -713,6 +738,11 @@ out:
>>      }
>>
>>      return chr;
>> +
>> +unparent_and_out:
>> +    object_unparent(OBJECT(chr));
>> +    chr =3D NULL;
>> +    goto out;
>>  }
>>
>>  Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
>> @@ -1114,7 +1144,7 @@ ChardevReturn *qmp_chardev_change(const char *id, =
ChardevBackend *backend,
>>          return NULL;
>>      }
>>
>> -    if (CHARDEV_IS_MUX_FE(chr)) {
>> +    if (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr)) {
>>          error_setg(errp, "Mux device hotswap not supported yet");
>>          return NULL;
>>      }
>> @@ -1302,7 +1332,7 @@ static int chardev_options_parsed_cb(Object *child=
, void *opaque)
>>  {
>>      Chardev *chr =3D (Chardev *)child;
>>
>> -    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
>> +    if (!chr->be_open && (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(c=
hr))) {
>>          open_muxes(chr);
>>      }
>>
>> @@ -1329,8 +1359,10 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChr=
Event event)
>>
>>      if (CHARDEV_IS_MUX_FE(chr)) {
>>          MuxFeChardev *d =3D MUX_FE_CHARDEV(chr);
>> -
>>          mux_fe_chr_send_all_event(d, event);
>> +    } else if (CHARDEV_IS_MUX_BE(chr)) {
>> +        MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
>> +        mux_be_chr_send_all_event(d, event);
>>      }
>>  }
>>
>> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
>> index 94c8d07ac235..8ea1258f8ff4 100644
>> --- a/chardev/chardev-internal.h
>> +++ b/chardev/chardev-internal.h
>> @@ -35,7 +35,9 @@
>>
>>  struct MuxFeChardev {
>>      Chardev parent;
>> +    /* Linked frontends */
>>      CharBackend *backends[MAX_MUX];
>> +    /* Linked backend */
>>      CharBackend chr;
>
>
> Maybe a patch to rename those fields would help.
>
>
>>
>>      unsigned long mux_bitset;
>>      int focus;
>> @@ -54,10 +56,36 @@ struct MuxFeChardev {
>>  };
>>  typedef struct MuxFeChardev MuxFeChardev;
>>
>> +struct MuxBeChardev {
>> +    Chardev parent;
>> +    /* Linked frontend */
>> +    CharBackend *frontend;
>> +    /* Linked backends */
>> +    CharBackend backends[MAX_MUX];
>> +    /*
>> +     * Number of backends attached to this mux. Once attached, a
>> +     * backend can't be detached, so the counter is only increasing.
>> +     * To safely remove a backend, mux has to be removed first.
>> +     */
>> +    unsigned int be_cnt;
>> +    /*
>> +     * Counters of written bytes from a single frontend device
>> +     * to multiple backend devices.
>> +     */
>> +    unsigned int be_written[MAX_MUX];
>> +    unsigned int be_min_written;
>> +};
>> +typedef struct MuxBeChardev MuxBeChardev;
>> +
>>  DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
>>                           TYPE_CHARDEV_MUX_FE)
>> -#define CHARDEV_IS_MUX_FE(chr)                             \
>> +DECLARE_INSTANCE_CHECKER(MuxBeChardev, MUX_BE_CHARDEV,
>> +                         TYPE_CHARDEV_MUX_BE)
>> +
>> +#define CHARDEV_IS_MUX_FE(chr)                              \
>>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)
>> +#define CHARDEV_IS_MUX_BE(chr)                              \
>> +    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_BE)
>>
>>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
>>
>> @@ -67,6 +95,10 @@ void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUC=
hrEvent event);
>>  bool mux_fe_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
>>                                  unsigned int *tag, Error **errp);
>>  bool mux_fe_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
>> +void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event);
>> +bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **e=
rrp);
>> +bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error =
**errp);
>> +void mux_be_chr_detach_frontend(MuxBeChardev *d);
>>
>>  Object *get_chardevs_root(void);
>>
>> diff --git a/chardev/meson.build b/chardev/meson.build
>> index 778444a00ca6..3a9f5565372b 100644
>> --- a/chardev/meson.build
>> +++ b/chardev/meson.build
>> @@ -3,6 +3,7 @@ chardev_ss.add(files(
>>    'char-file.c',
>>    'char-io.c',
>>    'char-mux-fe.c',
>> +  'char-mux-be.c',
>>    'char-null.c',
>>    'char-pipe.c',
>>    'char-ringbuf.c',
>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>> index 0bec974f9d73..c58c11c4eeaf 100644
>> --- a/include/chardev/char.h
>> +++ b/include/chardev/char.h
>> @@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
>>
>>  #define TYPE_CHARDEV_NULL "chardev-null"
>>  #define TYPE_CHARDEV_MUX_FE "chardev-mux"
>> +#define TYPE_CHARDEV_MUX_BE "chardev-mux-be"
>>  #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
>>  #define TYPE_CHARDEV_PTY "chardev-pty"
>>  #define TYPE_CHARDEV_CONSOLE "chardev-console"
>> diff --git a/qapi/char.json b/qapi/char.json
>> index fb0dedb24383..cdec8f9cf4e2 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -336,6 +336,17 @@
>>    'data': { 'chardev': 'str' },
>>    'base': 'ChardevCommon' }
>>
>> +##
>> +# @ChardevMuxBe:
>> +#
>> +# Configuration info for mux-be chardevs.
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'struct': 'ChardevMuxBe',
>> +  'data': { },
>> +  'base': 'ChardevCommon' }
>> +
>>  ##
>>  # @ChardevStdio:
>>  #
>> @@ -483,6 +494,8 @@
>>  #
>>  # @mux: (since 1.5)
>>  #
>> +# @mux-be: (since 9.2)
>> +#
>>  # @msmouse: emulated Microsoft serial mouse (since 1.5)
>>  #
>>  # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
>> @@ -525,6 +538,7 @@
>>              'pty',
>>              'null',
>>              'mux',
>> +            'mux-be',
>>              'msmouse',
>>              'wctablet',
>>              { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
>> @@ -599,6 +613,16 @@
>>  { 'struct': 'ChardevMuxWrapper',
>>    'data': { 'data': 'ChardevMux' } }
>>
>> +##
>> +# @ChardevMuxBeWrapper:
>> +#
>> +# @data: Configuration info for mux-be chardevs
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'struct': 'ChardevMuxBeWrapper',
>> +  'data': { 'data': 'ChardevMuxBe' } }
>> +
>>  ##
>>  # @ChardevStdioWrapper:
>>  #
>> @@ -707,6 +731,7 @@
>>              'pty': 'ChardevPtyWrapper',
>>              'null': 'ChardevCommonWrapper',
>>              'mux': 'ChardevMuxWrapper',
>> +            'mux-be': 'ChardevMuxBeWrapper',
>>              'msmouse': 'ChardevCommonWrapper',
>>              'wctablet': 'ChardevCommonWrapper',
>>              'braille': { 'type': 'ChardevCommonWrapper',
>> --
>> 2.34.1
>>
>>
>
>
> --
> Marc-Andr=C3=A9 Lureau

