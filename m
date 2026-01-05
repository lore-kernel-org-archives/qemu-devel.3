Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175C9C79F8B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckUM-0000XU-ML; Mon, 05 Jan 2026 08:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vckUK-0000X1-Ol
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 08:19:12 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vckUJ-0002th-1d
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 08:19:12 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so1789866766b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 05:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767619148; x=1768223948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHtBYt4n+BBAlOLObc4SFCBtZrbF5RpBQDVhEAQxjaI=;
 b=TLNMKWDNXimn1gfXktG60dpTKyHB8QQ/4pXaHzzEPJVlPkEGi8d6sDcxVaVSLsQhY3
 Bx0dX+sJqGDCztlHA5jLjAPHh+43LeQI8E1rR89En3KkHS35DKpwKxLy8v7ZNvWsbOjS
 j9MFrjemGHsP2R16UhFbvDKlIoJHASmCgWuUS8FQ3Wy/hXhPP+ppJLYNYub6eH57b5mR
 Ln5MgWZqEcb4wYaQqErZLrjctFXzgcChIotbU05xR4bC6TbpddUCezJRRrd43Qmn6AVG
 LMkpX8nqC9J2722T4MqOimWD3s0umrVgovxPC2mqPhQKQeo9uJQ9bKXPX0lVDMN6lfoj
 eS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767619148; x=1768223948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RHtBYt4n+BBAlOLObc4SFCBtZrbF5RpBQDVhEAQxjaI=;
 b=Mvy3qx3dhRZT+3x6n8h6yW9wuvy3eIjrFjz/KxfrcTQBlvUU2X1Mv0ppvWzIu73s/i
 GOshJrIXdO2Nb5WjKBr8GKaJipiv1Lna9BaDFLj542LjVeXICBX9QG9LIvOf+UMkezx9
 jIveSkECf5TX/DqOhrnILyOXy2t2O95mxImEHSNCnrUVsSBOEWR5GZ8h6hoyw+L35xR1
 Kp8UDxIjTOt8Vob55nukGbPm5VbxLfqQD8yeXf2e6bqktxQUrwqmS/VAsrm6exSs0FX0
 laEQUn+7wedFPrmZkFK+4QBSmJBz9cggNfdpDF1N+gYl+8obHFbR8a8VZ3Qi4Ipde7ug
 NdCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2eWtJo56PgH2DPpUIWeXMhZa9oyjbuBC5A0a2uh4ZvCAh56VlADGQxryuyExfoay55IiCjlW2yxsk@nongnu.org
X-Gm-Message-State: AOJu0YyYxtRejH/gYX41vuAUrSr1l7mBKnNKtP8O+yUcBZU0Wighu0kf
 S7dmb3yMieJQuGYDGK4Bfvz2BsmFLwTDIV9OTm7NL5snHGlGsFWjH6N9UwIo2lgSYNZiPvDjtBe
 JHSL4gfi536u6/xrzjgKHEPRijXR9YyA=
X-Gm-Gg: AY/fxX7poJCBKt0cIV88btDc+QP8si0s2ypkWwPwZQA01Ms7sQkmHu3mLgGmVTY9WSY
 GblyuBI9iVG9f0ISrly9Qiud/mXWaqYrAMu/A/TP/gaBeJPVadE9j7PPUeP5gGdtr3lGoYQ1Ms2
 T7y7qJhRKlNGk3p8D/DWdDmlo62X0dBqVYk48tgr4z5IGQZ8MlXhmT+51QHO4aQbRcxXtoOa8+s
 tyw8gw3PpzlBOstg7zS9TMr9Mre+sciIUScJn5rcMF5Y1rv1pMVdRsyVzWJ7VgSZLuzzKw=
X-Google-Smtp-Source: AGHT+IH74SVfDQlRutcsS6lkryoXo81aoqNriKENEpqWq4VNBa9k4yx8IjT5SEpXOJbUdKIgcRxJLH1e4hxM9xl0dvs=
X-Received: by 2002:a17:907:da2:b0:b80:1348:226e with SMTP id
 a640c23a62f3a-b80371a2bc2mr5321914766b.33.1767619148149; Mon, 05 Jan 2026
 05:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-2-jasowang@redhat.com>
In-Reply-To: <20260104075412.1262-2-jasowang@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 5 Jan 2026 21:18:30 +0800
X-Gm-Features: AQt7F2qF1AtYTt3HQdRN9X-Ukvk9iWvIVrGrnZQWNLyz4y6WiaS82Uq-_OCHTKc
Message-ID: <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/filter-redirector: add support for dynamic status
 on/off switching
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x635.google.com
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

On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Currently, filter-redirector does not implement the status_changed
> callback, which means the 'status' property cannot be used to
> dynamically enable/disable the filter at runtime. When status is
> set to 'off' via QMP/HMP, the filter still receives data from the
> indev chardev because the chardev handlers remain registered.
>
> This patch adds proper support for the 'status' property:
>
> 1. Implement filter_redirector_status_changed() callback:
>    - When status changes to 'off': remove chardev read handlers
>    - When status changes to 'on': re-register chardev handlers
>      (only if chardev is already open)
>
> 2. Update filter_redirector_setup() to respect initial status:
>    - If filter is created with status=3Doff, do not register handlers
>    - This allows creating disabled filters via command line or QMP
>
> 3. Handle chardev OPENED/CLOSED events to re-arm handlers on reconnect:
>    - Keep the chr_event callback installed on CLOSE so a later OPENED
>      can re-register the read handlers when nf->on
>    - Use qemu_chr_fe_set_handlers_full(..., set_open=3Dfalse, sync_state=
=3Dfalse)
>      instead of qemu_chr_fe_set_handlers() because the latter forces
>      sync_state=3Dtrue and may emit CHR_EVENT_OPENED for an already-open
>      backend. Doing that from inside the chr_event callback would cause
>      recursive/re-entrant OPENED handling.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/filter-mirror.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 8e01e98f40..aa2ab452fd 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -179,9 +179,16 @@ static void redirector_chr_event(void *opaque, QEMUC=
hrEvent event)
>      MirrorState *s =3D FILTER_REDIRECTOR(nf);
>
>      switch (event) {
> +    case CHR_EVENT_OPENED:
> +        if (nf->on) {
> +            qemu_chr_fe_set_handlers_full(&s->chr_in, redirector_chr_can=
_read,
> +                                          redirector_chr_read, redirecto=
r_chr_event,
> +                                          NULL, nf, NULL, false, false);
> +        }
> +        break;
>      case CHR_EVENT_CLOSED:
> -        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> -                                 NULL, NULL, NULL, true);
> +        qemu_chr_fe_set_handlers_full(&s->chr_in, NULL, NULL, redirector=
_chr_event,
> +                                      NULL, nf, NULL, false, false);
>          break;
>      default:
>          break;
> @@ -306,9 +313,11 @@ static void filter_redirector_setup(NetFilterState *=
nf, Error **errp)
>              return;
>          }
>
> -        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
> -                                 redirector_chr_read, redirector_chr_eve=
nt,
> -                                 NULL, nf, NULL, true);
> +        if (nf->on) {
> +            qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read=
,
> +                                     redirector_chr_read, redirector_chr=
_event,
> +                                     NULL, nf, NULL, true);
> +        }
>      }
>
>      if (s->outdev) {
> @@ -324,6 +333,24 @@ static void filter_redirector_setup(NetFilterState *=
nf, Error **errp)
>      }
>  }
>
> +static void filter_redirector_status_changed(NetFilterState *nf, Error *=
*errp)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> +
> +    if (!s->indev) {

It's better to add a error here, for example:

        error_setg(errp,  "filter_redirector_status_changed failed for
the s->indev cleared" );


> +        return;
> +    }
> +
> +    if (nf->on) {
> +        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
> +                                 redirector_chr_read, redirector_chr_eve=
nt,
> +                                 NULL, nf, NULL, true);
> +    } else {
> +        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> +                                 NULL, NULL, NULL, true);

It seems like we need to keep the "redirector_chr_event" here?

And another thing, this series focus on indev, should we need to do
the same thing for outdev?

Thanks
Chen

> +    }
> +}
> +
>  static char *filter_redirector_get_indev(Object *obj, Error **errp)
>  {
>      MirrorState *s =3D FILTER_REDIRECTOR(obj);
> @@ -440,6 +467,7 @@ static void filter_redirector_class_init(ObjectClass =
*oc, const void *data)
>      nfc->setup =3D filter_redirector_setup;
>      nfc->cleanup =3D filter_redirector_cleanup;
>      nfc->receive_iov =3D filter_redirector_receive_iov;
> +    nfc->status_changed =3D filter_redirector_status_changed;
>  }
>
>  static void filter_mirror_init(Object *obj)
> --
> 2.34.1
>

