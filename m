Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A635CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZBN-0002OH-Sx; Tue, 14 Oct 2025 03:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZBL-0002O2-Sx
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:10:51 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZBJ-0002H8-HB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:10:51 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-795be3a3644so38333076d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760425848; x=1761030648; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOWt5/6tkAbA8eVPVRUwd+GjGaJcbnLIiL7fTjAuQXs=;
 b=J7sWa4Op2yQbvsxPo9TCa0EwpbE8Byr0yYRLq7yCv3cXg1Wna9ovpqBI7CqerFDAYE
 vU2lOntaIkvkud54POEZnc5+ug1c//RxlVI+aSeif1rPH1nmwiGtwtRiDPTlXmP9/GX2
 erLKeOdivvhsTFgHQJiGHW/jSANYi6tfPLmqFnATVZ/3cjM2pTFCSrGivj+e/RPA+z+M
 uN6/uV+CP7O6++VvPA8nnh+l93+39MaAEi6rZBagUcxraj13eWvWw9rgIjW5dT0yag7T
 bwuMGTw1mn5Y4bBm+oHZk9/9Ql//kfaiPhMzllaeYDrsWpr9CmaD9TL/Zg/A57L2Kw7n
 CUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760425848; x=1761030648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOWt5/6tkAbA8eVPVRUwd+GjGaJcbnLIiL7fTjAuQXs=;
 b=gZ2oDEb14e5h0/lMbtfZqBqk0rSkcPYfosmtRrdPREaTOz5h7y0rSccitVlmYe1OGH
 R31ITSMliYwCBZvWVliInTpcEsYddLQn07jaaquQLK9MaoLma+xvPtwp2Y00nV0EoxJ7
 /gwcAKwEhcdmLSzFL28fBTeunvbjfqrhNcR3bcOBW6cRovroZs/1Thl0eA/6xITH28+a
 cU5rC9PWlameE5FJX063dv5cog8C1h9IwfRKMemfi74SS1zuAmD9Kj5V0n6LeNaadRwT
 G2aTqzmf6PdHKLJExfJds3NIx1DTo74S2ICY6SOiDJVnQkYH5MaPfx/v+7IepQSr9b1r
 GPaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXB4BI3RJcwsIS1oybg3Oyu4HNgC5/B5+hlkopKEtAPsYnJN3+f0bEDxS+/gjfTo7d8q34xAmSB0Uj@nongnu.org
X-Gm-Message-State: AOJu0Yze61dWzlMD19LZS+XH51iEUN/YoZA+yR1CnfWOi5FV09a28asF
 UaiEcyHZnfky7jl2flEn5eg0768zpreJRnsEbhtG8A8+5iFgDB4NzoLFNMYlwHZTZnuNfcWiJz5
 8L/UXTny4Nh5ibhLrCfDN5yDL9t0likc=
X-Gm-Gg: ASbGnctoM6C0jMULzEr24rdyZ1HJy7eIfn3VVZjUk3L+xrhKpdUI1lIP8TKLfrHUAI9
 uMfpqH84/KNoz/Zjx8QIw9JR4K5lWfdNfGqOa3sPTmeqKIRT0GuWj4jp4/BEdeW8j/KZ54jAG1e
 0/or20dJpryl24TE9S5xqiFttPkAmLe4dp2Wi8lDPz8zth91ibqJNGI5OJNImoQVI36Jx2HBztK
 ThEG9TDQUtNDShbPzilz0ZZlW78gcOhFG0RtBTyy94QlrO8+3hodow5HZuZldpQ7gci
X-Google-Smtp-Source: AGHT+IHxFaAUjZXi+vp0vQyKcNlvXW6+7T1L2G1aepoKEXaX2zOWiZNImWqLu7F1zIMgAPy7cu6J3kPJhPEHtuDlInM=
X-Received: by 2002:a05:622a:254:b0:4e7:2168:8679 with SMTP id
 d75a77b69052e-4e721688f13mr75256101cf.65.1760425847670; Tue, 14 Oct 2025
 00:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-4-vsementsov@yandex-team.ru>
In-Reply-To: <20251013133836.852018-4-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 11:10:36 +0400
X-Gm-Features: AS18NWA9G5exZPhn7kvlgvTsTkwNemHjflUYvpL2l7UsyRvW3XNKaFdBYH-gm2A
Message-ID: <CAJ+F1CL-wvyP3cVGAWyy_avQxzwPQcVJ+YtyxpRVY8HmKDNjkw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] chardev/char: qemu_char_open(): add return value
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2f.google.com
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

Hi

On Mon, Oct 13, 2025 at 5:40=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Accordingly with recommendations in include/qapi/error.h accompany
> errp by boolean return value and get rid of error propagation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index d5a2533e8e..64ec60c0f2 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -246,14 +246,20 @@ int qemu_chr_add_client(Chardev *s, int fd)
>          CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
>  }
>
> -static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
> +static bool qemu_char_open(Chardev *chr, ChardevBackend *backend,
>                             bool *be_opened, Error **errp)
>  {
> +    ERRP_GUARD();
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
>
>      if (cc->open) {
>          cc->open(chr, backend, be_opened, errp);
> +        if (*errp) {
> +            return false;
> +        }
>      }
> +
> +    return true;
>  }
>
>  static void char_init(Object *obj)
> @@ -1030,9 +1036,7 @@ static Chardev *chardev_new(const char *id, const c=
har *typename,
>          goto fail;
>      }
>
> -    qemu_char_open(chr, backend, &be_opened, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!qemu_char_open(chr, backend, &be_opened, &local_err)) {

You meant to pass errp instead, since you dropped error_propagate ?

>          goto fail;
>      }
>
> --
> 2.48.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

