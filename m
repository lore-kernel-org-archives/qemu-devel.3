Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD794CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZV2-0006KM-Uw; Tue, 14 Oct 2025 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZV1-0006K7-RH
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:11 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZUz-0004tg-0F
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:11 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-86302b5a933so534616685a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760427067; x=1761031867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QL5hwtgTzFs25SOn//C8sVWADJsIoS4osiiMds2f8EE=;
 b=JeHklxqRQv2035Stt/KswUJHppicAYVGyIimLSX52mBNwgo48s8tlkThb+Iyk6jeqS
 tzMs/0d16cQSN7TtF6vXjv1OmsWD8PTIKPNm7Jk5Ad3t5rvqIUJtSgMQNQvilDL1V5bZ
 7czJMedqZfbjxaNpENWp8h4s/SeYMnIVPRT2BVY+sM4RQL7eYgaV/cX8VO0ZBbFnhd6N
 1xFCtvcbfdzeDP9/Qxzck3tZW1gesvymJ6DnUcEfJwpYBEQFI8xRo4c3sw5Mcim9LINl
 BpwJ1GU7+Spnjr0VNHU3VImV3lKRctg3jdx2W2KdX7y1f5Ai7wjy7mx9yLZqwHRWI/FT
 0G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760427067; x=1761031867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QL5hwtgTzFs25SOn//C8sVWADJsIoS4osiiMds2f8EE=;
 b=KpmS6TonR3g4lo2Ct6n6g0dKLG9qtYq5UMVdcz76jja/e2/dRkzvasoBjRw8SkkPeZ
 HwPKS+gsnHoe6Tw4QSziVzLPecu38bMXBB6r29h9NP9w1jlGG+mDDWJl8aOz1TTr2S8G
 ciR7OTcwhapIiAriOpxXU0SQgzkNRFt72ZqVcoJJ63w6XRqnUodb8FZo4oDgukQwOtEj
 KoZLs7xhWTHLG3IS4HD/34MXt80zizr968n5uvqHHml9BFFiPT4Aiz4mYZFLlKBG0P67
 jxi4g019xRlzO99mpdW9zNoLuU9zEQnpcSIqB19WcNSR5JZHYU87vb/282ECCSibWKJB
 26Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfFhM/iWBwnojdwt9k5ho4+ss7Lt4/aBcaVFTJeS8tGxfoOlGn4OweKsegjrIhx2EevSwjOeTjXFab@nongnu.org
X-Gm-Message-State: AOJu0YyIuav3tQD388vl1OXTBeqP5GFv+ejXfPVu2ds/ZNoEWKyg98zM
 V39Xi0fBnUZBf19MjDGXVSDNhGBkfuiRGZB++AmzSeIVPBm89PwiyPj8ne02hj1KM4XRX+tdoNE
 9H6Xmg2OOcQQNZ28OpLzrkVjIjS7fK+w=
X-Gm-Gg: ASbGncsQfp+rsP1K3ZDurO1CrDmZ3lOvMWV9GJe0WXu3KKfGpuke4rSs1kt0BujcXG6
 iRlIdMTDc6wrI9M0NkLU1LtsbWk4G66mvdcQyIOuXetJZpywoLCbkQttgVcXIlq7p5FNc3shz9r
 TCk/0NXDicdGVe2QGd0VWF1XaRxwMExchVeV409iWMA51DuMtLF7Dd+UmlmpQCf31hxYyAKu5mE
 5caA5L1TRZboQQ8zx1LkxWdqxO4XdSM29eAogyTdjdehWuPI7x3MUALQWToe0Pyy6Hu
X-Google-Smtp-Source: AGHT+IFMlO3Q2YihQxlDV7oGpNho/F1/AGMnc24kWlQGpDunsvLsK2SQJ+REQWToi5qbUbxywPi61MSYYyN+YOya5Rs=
X-Received: by 2002:a05:622a:347:b0:4e8:10f4:5c6b with SMTP id
 d75a77b69052e-4e810f45d53mr1413481cf.39.1760427067477; Tue, 14 Oct 2025
 00:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-6-vsementsov@yandex-team.ru>
In-Reply-To: <20251013133836.852018-6-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 11:30:55 +0400
X-Gm-Features: AS18NWBy5He2kO3zn4FxjSSzXkANNVa4tvaSzG7Tr0NmxT9GgHQUzWVf2WWiQ5Y
Message-ID: <CAJ+F1CK40S7noGs3pzoOO4e3qrYUirkrhqNe4ubPv6aiz+Sp6g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x732.google.com
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
> We'll need a possibility to postpone connect step to later point in
> time to implement backend-transfer migration feature for vhost-user-blk
> in further commits. Let's start with new char interface for backends.
>
> .init() takes QAPI parameters and should parse them, called early
>
> .connect() should actually establish a connection, and postponed to
> the point of attaching to frontend. Called at later point, either
> at time of attaching frontend, either from qemu_chr_wait_connected().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-fe.c      |  4 ++++
>  chardev/char.c         | 40 +++++++++++++++++++++++++++++++++++++---
>  include/chardev/char.h | 22 +++++++++++++++++++++-
>  3 files changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 158a5f4f55..973fed5bea 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -193,6 +193,10 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Er=
ror **errp)
>  {
>      unsigned int tag =3D 0;
>
> +    if (!qemu_chr_connect(s, errp)) {
> +        return false;
> +    }
> +
>      if (s) {
>          if (CHARDEV_IS_MUX(s)) {
>              MuxChardev *d =3D MUX_CHARDEV(s);
> diff --git a/chardev/char.c b/chardev/char.c
> index 6498d53daa..01ffe37acf 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -33,6 +33,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-char.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qom/object.h"
>  #include "system/replay.h"
>  #include "qemu/help_option.h"
>  #include "qemu/module.h"
> @@ -338,10 +339,29 @@ static bool qemu_chr_is_busy(Chardev *s)
>      }
>  }
>
> +bool qemu_chr_connect(Chardev *chr, Error **errp)
> +{
> +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (chr->connect_postponed) {
> +        assert(cc->connect);
> +        chr->connect_postponed =3D false;
> +        if (!cc->connect(chr, errp)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  int qemu_chr_wait_connected(Chardev *chr, Error **errp)
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
>
> +    if (!qemu_chr_connect(chr, errp)) {
> +        return -1;
> +    }
> +
>      if (cc->chr_wait_connected) {
>          return cc->chr_wait_connected(chr, errp);
>      }
> @@ -1029,7 +1049,7 @@ static Chardev *chardev_new(const char *id, const c=
har *typename,
>  {
>      Object *obj;
>      Chardev *chr =3D NULL;
> -    Error *local_err =3D NULL;
> +    ChardevClass *cc;
>
>      assert(g_str_has_prefix(typename, "chardev-"));
>      assert(id);
> @@ -1044,8 +1064,22 @@ static Chardev *chardev_new(const char *id, const =
char *typename,
>          goto fail;
>      }
>
> -    if (!qemu_char_open(chr, backend, typename + 8, &local_err)) {
> -        goto fail;
> +    cc =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (cc->init) {
> +        assert(!cc->open);
> +        assert(cc->connect);
> +
> +        if (!cc->init(chr, backend, errp)) {
> +            goto fail;
> +        }
> +        assert(chr->filename);
> +
> +        chr->connect_postponed =3D true;
> +    } else {
> +        if (!qemu_char_open(chr, backend, typename + 8, errp)) {
> +            goto fail;
> +        }
>      }
>
>      return chr;
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 429852f8d9..ebadaf3482 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -63,6 +63,7 @@ struct Chardev {
>      CharBackend *be;
>      char *label;
>      char *filename;
> +    bool connect_postponed;
>      int logfd;
>      int be_open;
>      /* used to coordinate the chardev-change special-case: */
> @@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
>                                  bool permit_mux_mon);
>  int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_a=
ll);
>  #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true=
)
> +bool qemu_chr_connect(Chardev *chr, Error **errp);
>  int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>
>  #define TYPE_CHARDEV "chardev"
> @@ -259,10 +261,28 @@ struct ChardevClass {
>      /* parse command line options and populate QAPI @backend */
>      void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
>
> -    /* called after construction, open/starts the backend */
> +    /*
> +     * Called after construction, create and open/starts the backend,
> +     * mutual exclusive with .init. .connect must not be defined when
> +     * .open is defined.
> +     */
>      void (*open)(Chardev *chr, ChardevBackend *backend,
>                   bool *be_opened, Error **errp);
>
> +    /*
> +     * Called after construction, create the backend, mutual exclusive
> +     * with .open, and must be accompanied by .connect.
> +     * Must set chr-filename.
> +     */
> +    bool (*init)(Chardev *chr, ChardevBackend *backend,
> +                 Error **errp);
> +
> +    /*
> +     * Called after .init(), open/starts the backend, mutual exclusive
> +     * with .open. Must send CHR_EVENT_OPENED.
> +     */
> +    bool (*connect)(Chardev *chr, Error **errp);
> +
>      /* write buf to the backend */
>      int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
>
> --
> 2.48.1
>
>


--
Marc-Andr=C3=A9 Lureau

