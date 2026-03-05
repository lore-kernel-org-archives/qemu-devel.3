Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E49F3092C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 13:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy8hx-0002HV-Be; Thu, 05 Mar 2026 08:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vy8ho-00022u-K3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:25:33 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vy8hm-0001XI-Ox
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:25:32 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-506cb1b63d0so94604771cf.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 05:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772717129; cv=none;
 d=google.com; s=arc-20240605;
 b=Yk8UIwn4KjSUb6Ub9NcvzQjtZ9+Q0gTqohFDZqo6q4fvr2c2frhe0VYYA7MX2UGFeS
 rKsk1jFuOq6ute/vyu7yLAXaamOIeeqHB7tplQfgxWlt40jdNHDAspHabBdjEauDAX8B
 H0Ck/cBGs5udEfplHsFvTLSOkeKSbS/eAwMrqgCRxqLZPcCRrEVjhs3l8K6kqgp/WkZD
 JQ+TRnhlzytALD0ScEXdKG4ByDSSvMTci6w2q3EzgsGAd+Qg/UdPWwdI3nbNFqNWZOiq
 WrMOfznnOZ4XyPwEjQMZKM+0onmaurDyPZi+8S5D5jV4udiHDRfieZ+WNF0jBc4E2Gdc
 KjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qPIQDYoGZHz5/2bJ20mCKmICG+V2wgA3o92DzL4q2YU=;
 fh=7S2IgaxyiShzJPOc4Ytvwc0OHZLP27e9oBXA1z9XfM0=;
 b=l0GQrFUlkjd7SVo/VTHVyRlLrocYWgGRYU/NLJl8xmbCzHP94ImKXBJ1q+1VyTUvaL
 Gis8DEUqz0Edus0d/ae10Y4hCAIwq2i65t5ktUM3irWXqeF1KARRXlvvZ9bKmdSg5oRV
 oG4gilQntF2jA13QXITzloeP7jejERS0hrRYXlecyptluM8+mZ0e4g0TdiLwCYxrcZo9
 QPlZQvH24fvPHlLaEcdWo+eE+Zs33Ro7ZvknrbzU324tw/9JhDCkX7KAu4GrHP/wpSKN
 VdqHYAlPwAO8YeYA3Msxa96Ebe4/oQe3BuVyLtZ+3aEO1XWCAngF5YfdT+16mM1WwgOs
 Uk9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772717129; x=1773321929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPIQDYoGZHz5/2bJ20mCKmICG+V2wgA3o92DzL4q2YU=;
 b=VqxhjfayhACiYFVyDmgbI3DjzIMCyX4HUqzaxnp4w1KYTZ0Ism1e/KUauTT2Ss7nXL
 3omKdMGtqYQk8LScqMMTJ8Uz6K2zRJDP3WabfzN8cnuc7QBYECvaio1c9hsIeeCaIgWK
 Ohu5Psypc8782rao/M7jifHNF+5Gf7EAcBeBZEseghiGvdtVu288Jx6CtgMaAHXK5IRR
 3S2NN5YtfBpNrAGqUOhhHv3kYcSW/qVEEKl8jHUowYfde4nQcu2VR04kNfWiaUQ+0/nZ
 CK0z3MP2O1P8lT7yaDa84nuVoSZqUplBifsKp2dAJ38soe8kKcI44CelY2U3QAPwYWSC
 CxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772717129; x=1773321929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qPIQDYoGZHz5/2bJ20mCKmICG+V2wgA3o92DzL4q2YU=;
 b=B9lfO2HsCJYgnVCynVzAQBOsmXRbCIj4b1sFWhMmXyfNM06UrFUFwciyYzxp6uMMb7
 r2b3HSdQDRZNBQMjlhyhw4b09hUYkzOwAY9iC4qJuFrab1KHCnTeEMJoivJCKNkDpgUC
 0Y17SVDvtLUFhOW46UOg8+oC3b14UVDMi7yC7Oa5oF4dq0rWkK6k8dzSxtxDf1yQ2n9o
 CJ34eOrW/djHm1uKVEjAtgnosW6nRcSy6Laug5veflysTw9iMjg/9R+DEmEH37/SyErX
 jtbaoK8ihn4zqbVCuCTpsnSiD+Wew7YBsxj3IIEmszuAznkURxi2DBtmxuaz9jidE+Sk
 KFfQ==
X-Gm-Message-State: AOJu0YzrnfHB1NfYmHVadbEYLT07TrTY5doMUidPviDy09N9XiMCWcJl
 oxaR1DAv76upqFBaF9Gy/3Hm11ecIpHRFZvAAz84SnkuoU4p7iieq5No+O/o4oBj2P6bDtipHnn
 kn1iVsnJ6wR8SrUvoyNW5rj6dWSWvtgg=
X-Gm-Gg: ATEYQzzbc9a61jfASP01gq3drds9xkqXkuH1Aiw2JdapTvogPCjHiTSH6SC3BLQPkS6
 XyQxoLxV03VT+tPUXT9ifoXCptYGEalxUxE+VP+kcqsYA5hSB24Onc9zWC/ZdRKexPraI8RPx1v
 tu9cB07VVSigy0m7p7nemgACzDrieGXrzWeBxsgoUD03D/I7QqYBiElYCWQOkXg3vIyTcty8Nfv
 +XreJc/VBbD255CUlmUtjeKblY6AG9JTxs+QURhbAMbKkim1ar4d6sZgt7gjJITO1dOaWLkINdi
 S0YasKE=
X-Received: by 2002:a05:622a:180a:b0:4f1:ab79:fb18 with SMTP id
 d75a77b69052e-508db2a196amr79560041cf.25.1772717128546; Thu, 05 Mar 2026
 05:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20260305003012.108262-1-matt@matthewpenney.net>
 <CAMxuvazif5c-wpPCG4dce-jm_G4MRxkZqP0qyp5TucudmwDLMA@mail.gmail.com>
 <l7SUyMhQt6JPXzWAoUOEWkMw02yJQDvwHWNTpN6NnK6S8jrLk3AExgEqpOvvfSgJLYLBDmJ1ji3Eg5qB_NjhV21c1f01sC8ZkwBY5YQl98I=@matthewpenney.net>
In-Reply-To: <l7SUyMhQt6JPXzWAoUOEWkMw02yJQDvwHWNTpN6NnK6S8jrLk3AExgEqpOvvfSgJLYLBDmJ1ji3Eg5qB_NjhV21c1f01sC8ZkwBY5YQl98I=@matthewpenney.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Mar 2026 14:25:17 +0100
X-Gm-Features: AaiRm52s6-W6GrMW--LSL7-_YJ-WWAvKgJHQOyABWuhqmNKLQVoM3tu4dMOtUOg
Message-ID: <CAJ+F1CKh=00BPwvwumeU6N50J1YKi2Lq8T9oY1Sozk_3z=JYJQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char: clear dangling GLib event source tag
To: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 lvivier@redhat.com, amit@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

Hi

On Thu, Mar 5, 2026 at 2:22=E2=80=AFPM Matthew Penney <matt@matthewpenney.n=
et> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> Thanks for the swift reply!
>
> Should I start by sending a V2 with your proposed update just for virtio-=
console.c, or do you prefer a larger bulk change across the codebase?

If you can clean the codebase in one patch, hopefully this is
agreeable with all the subsystem maintainers.

Though if your patch is actually a fix, it's worth it to make it a
different patch.

>
> Best,
> Matthew
>
>
>
> Sent with Proton Mail secure email.
>
> On Thursday, 5 March 2026 at 10:23, Marc-Andr=C3=A9 Lureau <marcandre.lur=
eau@redhat.com> wrote:
>
> > Hi
> >
> > On Thu, Mar 5, 2026 at 1:40=E2=80=AFAM Matthew Penney <matt@matthewpenn=
ey.net> wrote:
> > >
> > > Clear dangling GLib event source tag when virtio-console is
> > > unrealized. This prevents a stale tag from being used, and
> > > maintains consistency with the rest of virtio-console.
> > >
> > > Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> > > ---
> > >  hw/char/virtio-console.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> > > index 25db0f019b..11bf51e3ea 100644
> > > --- a/hw/char/virtio-console.c
> > > +++ b/hw/char/virtio-console.c
> > > @@ -258,6 +258,7 @@ static void virtconsole_unrealize(DeviceState *de=
v)
> > >
> > >      if (vcon->watch) {
> > >          g_source_remove(vcon->watch);
> > > +        vcon->watch =3D 0;
> >
> > The glib >=3D 2.56 way is:
> > g_clear_handle_id(&vcon->watch, g_source_remove);
> >
> > We could do a bulk change for the whole code base imho
> >
> > anyway
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > >      }
> > >  }
> > >
> > > --
> > > 2.53.0
> > >
> > >
> >
> >
>


--=20
Marc-Andr=C3=A9 Lureau

