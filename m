Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E36CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHexN-0001zt-QK; Fri, 16 Oct 2026 06:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHexM-0001yC-0P
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 06:14:32 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHexK-00025l-9D
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 06:14:31 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab37e44643so23564297b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 03:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792145667; cv=none;
 d=google.com; s=arc-20260327;
 b=pu9knriFSr36ZE+TvCrgsnU5m1Rbk+5ZoOy3mGAqTcScPU1h16r+uBHQC8xrF5W566
 fTpcNiPJF3iO2rPA6S1NdTn/AB5yaBOg9Zw3+jSaF0KEk4M8fRR+lEEZm/YLwz3i2thi
 I/1btacliJ3OJ2axVj5ZGo489x33MwL/1cKjYSw+Q3ybDrumqkfeTQhTMJ4PuPVeEixU
 Taq9LaaLs3wWlEuoubZSARS3PzSeGcFd7fkhY1f6XmpNeDK7xMnpcSyxtiwE2UVxHq74
 jV4OTy4AX8MavViuSL3fzq9R2EwnQHLGClQ/5mdWf2AoS51nY78ATjzqM1pQto/b8wyO
 6NMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VvZcWaEOtfKFRQ8xBYWK9IzKT7vm+Yd3RrHeYl3ROFo=;
 fh=W/JhvAlf9kvTQdSfT2vqiKAkNO4YiRVg8H2M8w9SXbQ=;
 b=DJsHJJzax9KbRD3BXtJfxXuIqV0kuwZQmHOZyLkohj7KWOhKkt6tDI062ZS8J8p4+A
 S6oxy1spg/JAzl3BHdLjyK4IfNuj2maNPeRqpHmTNxCDXK58AzzbAGJtpaHAsyaQ6e56
 v5ej4AimQgVNsCE4X3IRTH50tgFNvoWpn3X+zC7rYi0o3B65jgQbomSPNL4kMvMmNvaK
 rfgjSB0RE+K7QXpxfH1id/pDs9rfICMVpTslhd0uK4gAhL4Pv2EPkjn7yvi/WA4bX7Qj
 uTGI/IXNOApTgSNzGcsgi6e3k2qWLuXD0vqY94asUuQpfMsfYZL8z7+y1vKk7R7LR71k
 mcow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792145667; x=1792750467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VvZcWaEOtfKFRQ8xBYWK9IzKT7vm+Yd3RrHeYl3ROFo=;
 b=s1pdXEgEIuu9JfLCLC0//e6gzW5B9wAW9UMN440Mqi/ONb0al3ZmgL2ibT8+1o7HQr
 8Q8Pshfn0AvIRzPw6bqWsoKfh/bl3cFmZWaExp81EWWWvlDfaFF69h2BLMF5eowuGF9a
 4GlRR03Pi60TcrLQCtdXrh8ZXQ9KJUd8jRyJd2S0uKIfvSg3XqA2mDZCmX7hsU3+YGAV
 bmFx1LojPG4gdE5FUorO51UKrJewcVpFsh+OKeVFNg+TPnoP2THUDt9D+Jv/8MXpya6z
 CyGgSqTAXRUa7qADYtLeWPibrpauNJ3MstKPjBSbcn4jJpVM4n1nRCGkDFHfbL6rUahB
 5qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792145667; x=1792750467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VvZcWaEOtfKFRQ8xBYWK9IzKT7vm+Yd3RrHeYl3ROFo=;
 b=vk2CV3t5Ydz03layW+q00BfJOxRsoGkGrEqMQln3J5dEbc7CP0SPiGpTVdzvVtWNpN
 WDOh4B5vmP9S261oLTTzBfBzrkNAwXXNLKYPNM1C77/DNg+QQIuMDX8gkeBsbZ0CvTvH
 zWFegjwzvUtu6eBsEwPtngkgIAjZcDEF+sCH9eaNpU4+3WV43lWOMnQY1vgFeHla2FBt
 +gMoZDAtvPt0hJ3nJHSJNM0ztklJ3olYxEiHfy9afAx+lpJcD82A2jCy7QbL85C6Qegi
 pu2+7B8zjOtV1Lhx2oiTL8FplIFQnsOuZFRNSB19qN3GwK2C4lYn44MrspsnwfnLSB9b
 QjCQ==
X-Gm-Message-State: AFq9FYKJX8xocUE1g+5dCf42NrrOGkHtb1dUcPIKm+rcsewaWYTLjFZg
 YVCYeEWpwVVOG/UQ0kaIEovriNILxYkidlkvUMmnYdrcii3mKLs7MSFyL1H8/T06v9D7aJ/816E
 2zMrytPLuo8b8WLvmNtqgvAuJRlSSICrROljuQhm4JQ==
X-Gm-Gg: AYBFou13jfzstXAAt0WIQDbRHeDxinNHzKQRHaUaUqlGB0cCiIYqs1D8t/BE8Sin39o
 ++xtxtlgr/j58kOhEETMkFk3MOWjD/wb8Y84ArMDZgF4c+kT9OCekdwiwz8D7r6PCxxxLCqCCCx
 GgTS+afR7D6mP1ut7vxmCmcDQKoHHC4RLHTNc0Craw106AuKAY62ZVX2oqWIW56yjuNpY1l0Ina
 8JeIoVIBHTWXzRBBhmslt/ZSVECKoJWF/jtd3boe3VkH8QAdZnmmTIub4143ZNafwqiru5sdr2u
 pjTf6e+DLd+0amJg7QjqOTpjxAvUaH8jyrfSXODDfw7LAxRKicNAiJUXL95YbDABR4AmSUuTPLv
 KyvDeyxn0lqKgsCGBDPgvMKS8CG10CQpc38FIeMw=
X-Received: by 2002:a05:690c:309:b0:8b0:dabc:a6fb with SMTP id
 00721157ae682-8b0dabca7f5mr16084517b3.31.1792145667449; Fri, 16 Oct 2026
 03:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
 <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
 <atHrFXxyIl3Nbvht@redhat.com> <atHu0kCSQTD9E34p@redhat.com>
In-Reply-To: <atHu0kCSQTD9E34p@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 11:14:16 +0100
X-Gm-Features: AclHuK8uswMqZ5BSA5O7JvRn54OW6h-Ynv9l_siOiGm0K17FfoHnAR3TxoPPqFg
Message-ID: <CAFEAcA9PTB=1V_hV1P0xpEW4aY+4LajYyzKzyTOJj=bb9=oPvA@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 16 Oct 2026 at 10:31, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Oct 16, 2026 at 10:15:01AM +0100, Daniel P. Berrang=C3=A9 wrote:
> > We're overwriting the DeviceClass::realize field in the class
> > struct instance for "pl050_keyboard". We still have the completely
> > independent class struct instance for "pl050" (which is what
> > object_class_get_parent() returns) that contains the 'realize'
> > field value set by the parent class.
> >
> > eg if I put a break on pl050_kbd_realize():
> >
> >   (gdb) print pdc->parent_class->parent_class->parent_class->type->name
> >   $5 =3D 0x555557de40a0 "pl050_keyboard"
> >   (gdb) print pdc->parent_class->parent_class->realize
> >   $6 =3D (DeviceRealize) 0x55555585db67 <pl050_kbd_realize>
> >
> > and separately
> >
> >   (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->parent_cl=
ass->type->name
> >   $7 =3D 0x555557de3ee0 "pl050"
> >   (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->realize
> >   $8 =3D (DeviceRealize) 0x55555585daf4 <pl050_realize>

Ah. I didn't realize you could get at the parent's class
struct like this.

> We can make it a little less ugly in the callers with a macro in
> qdev.h thus:
>
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index 8e91e2fcb08..18e85850c31 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -461,6 +461,9 @@ static inline bool qdev_is_realized(const DeviceState=
 *dev)
>   */
>  bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
>
> +#define qdev_realize_chain_parent(dev, dc, errp) \
> +    DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(dc)))->realize(dev=
, errp)

I'm tempted to suggest that we drop the 'dc' argument here and
have the macro get the class from the dev:
    DEVICE_CLASS(object_class_get_parent(object_get_class(OBJECT(dev))))->r=
ealize(dev,
errp)

because I think almost all realize methods wanting to chain back up
won't have the class pointer to hand.

We could maybe have an extra layer of abstraction here such that
you write something like:

   parent_invoke(DEVICE_CLASS, dev)->realize(dev, errp);

Or is that trying to be too clever?

> +
>  /**
>   * qdev_realize_and_unref: Realize @dev and drop a reference
>   * @dev: device to realize
>
>
> which would be used thus:
>
>
> diff --git a/hw/input/pl050.c b/hw/input/pl050.c
> index 48df2734e26..abe939171f2 100644
> --- a/hw/input/pl050.c
> +++ b/hw/input/pl050.c
> @@ -168,7 +168,7 @@ static void pl050_kbd_realize(DeviceState *dev, Error=
 **errp)
>      }
>
>      ps->ps2dev =3D PS2_DEVICE(&s->kbd);
> -    pdc->parent_realize(dev, errp);
> +    qdev_realize_chain_parent(dev, pdc, errp);
>  }
>
>  static void pl050_kbd_init(Object *obj)
> @@ -191,7 +191,8 @@ static void pl050_mouse_realize(DeviceState *dev, Err=
or **errp)
>      }
>
>      ps->ps2dev =3D PS2_DEVICE(&s->mouse);
> -    pdc->parent_realize(dev, errp);
> +
> +    qdev_realize_chain_parent(dev, pdc, errp);
>  }
>
>  static void pl050_mouse_init(Object *obj)
> @@ -206,10 +207,8 @@ static void pl050_mouse_init(Object *obj)
>  static void pl050_kbd_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    PL050DeviceClass *pdc =3D PL050_CLASS(oc);
>
> -    device_class_set_parent_realize(dc, pl050_kbd_realize,
> -                                    &pdc->parent_realize);
> +    dc->realize =3D pl050_kbd_realize;
>  }
>
>  static const TypeInfo pl050_kbd_info =3D {
> @@ -223,10 +222,8 @@ static const TypeInfo pl050_kbd_info =3D {
>  static void pl050_mouse_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    PL050DeviceClass *pdc =3D PL050_CLASS(oc);
>
> -    device_class_set_parent_realize(dc, pl050_mouse_realize,
> -                                    &pdc->parent_realize);
> +    dc->realize =3D pl050_mouse_realize;
>  }
>
>  static const TypeInfo pl050_mouse_info =3D {
> diff --git a/include/hw/input/pl050.h b/include/hw/input/pl050.h
> index 2cdfa74f73c..7169afc151f 100644
> --- a/include/hw/input/pl050.h
> +++ b/include/hw/input/pl050.h
> @@ -17,8 +17,6 @@
>
>  struct PL050DeviceClass {
>      SysBusDeviceClass parent_class;
> -
> -    DeviceRealize parent_realize;
>  };

Yes, this is clearly vastly better than we have at the moment.
device_class_set_parent_unrealize() can do similarly.

Does something similar work when QOM interfaces are involved?
We have resettable_class_set_parent_phases() which deals with
updating the methods of ResettableClass, which is an interface
declared by TYPE_DEVICE.

thanks
-- PMM

