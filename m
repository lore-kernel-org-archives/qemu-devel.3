Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F80C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 23:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb7H3-0007qK-DR; Fri, 16 Feb 2024 18:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rb7H0-0007q3-Kh
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 18:05:38 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rb7Gz-0003fT-23
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 18:05:38 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42dc7306ca1so28091cf.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 15:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708124734; x=1708729534; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAP/p0RQY4sKG/6US5auuEASiYh34ud7LSJkkSbosDs=;
 b=UxEZzLOpbB+FrzMQqYhGmnGIqSbcapTMSdudvt0emTDKBTYxZqmQiZLDViXPttGBws
 gUBB4LPI5SoBZskIsb9sqqNhbiHsaDyqXolONxj6HvWfWiO17xE2CvuvORm+AOddBuRW
 jloMNct9xnIxCiFzaBlk67wVSTRn+Xm3/jf4jjjUILgM1SynP4PFjUWIStnaF5TXdETw
 9Kv0kTva7Ncm2RdIbLdeEb/PJjHrD1AClAm5b3KYgkPFs57gZ5e81QdBUh7zihU6SvCL
 RjEAdxoKkv+76CDXaOMNbVYOfdDyAVluAUK905l2Az8EXPzsSezGiXNGJHqk1LAJmphe
 XpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708124734; x=1708729534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAP/p0RQY4sKG/6US5auuEASiYh34ud7LSJkkSbosDs=;
 b=Yz97wqD2dtPxhBPumUWZzhnpd0Aqu3Y6AkTItgYNV51/I0/ns4V9JQaRstLtcgVLoj
 Qg01kvwROZF+f7JHsA44UUwn8/C+m4Gaj9J9zQH9M87dXRC4jfYDfyPMgd/ASCJ/Iu4m
 uYxWHvOSAhi1PUSY23Dp2qyjEdFdN/vxQRr8TcR/+2NdFs24tFsVkRV2+ndDhYwWcsvU
 2iOz08a3ru9OY/TlrDB4uUAUpmUofhdZNnN5HwSQ7MV0GMz3v9zqB/QlZCJJ47uK6x8X
 alG3IQX9dAsPvnI+7o1driw6Sz6IjiEQKvTXwoIWkC9xRN8LWH9HwA1GDLsq8y8/oBbR
 pFVg==
X-Gm-Message-State: AOJu0YyRqu6fSFtmMtbNVjh9rOtxTox1BXlibWxntDz6ftZqaQuvYCEj
 aeb0BMjfF2i+NcCKsR7LxMGtTiqbehAsQNpjjZfFU7IG0MGXT7aQmF5rmYfhfuaWHnhz73uNBAl
 fmuwffrRTvaGh1CSi/tXu2YOfc10lvuvprXC3
X-Google-Smtp-Source: AGHT+IFsNQZMXNY8EwyQrBHWUG1y7LHLvOYDexK6PBozH4jC8+559FSdfv+or4m/qEr+lyOZTrldOFE+szkJCA5vOi0=
X-Received: by 2002:ac8:5499:0:b0:42d:ec9c:4ce9 with SMTP id
 h25-20020ac85499000000b0042dec9c4ce9mr80306qtq.25.1708124734414; Fri, 16 Feb
 2024 15:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
 <20240202204847.2062798-2-komlodi@google.com>
 <CAFEAcA8R13bQ7niSXhZPJ3vUD_OdNWpvjpKrWpz-gZsJxO_=dg@mail.gmail.com>
In-Reply-To: <CAFEAcA8R13bQ7niSXhZPJ3vUD_OdNWpvjpKrWpz-gZsJxO_=dg@mail.gmail.com>
From: Joe Komlodi <komlodi@google.com>
Date: Fri, 16 Feb 2024 15:05:22 -0800
Message-ID: <CAGDLtxur9OHDMxa7i2ggeKMhmusm6SfQ+dWqp-gPLNGbyp5eeQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/i2c: core: Add reset
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=komlodi@google.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Feb 8, 2024 at 8:39=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 2 Feb 2024 at 20:48, Joe Komlodi <komlodi@google.com> wrote:
> >
> > It's possible for a reset to come in the middle of a transaction, which
> > causes the bus to be in an old state when a new transaction comes in.
> >
> > Signed-off-by: Joe Komlodi <komlodi@google.com>
> > ---
> >  hw/i2c/core.c        | 19 +++++++++++++++++++
> >  include/hw/i2c/i2c.h |  2 +-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> > index 4cf30b2c86..3128067bba 100644
> > --- a/hw/i2c/core.c
> > +++ b/hw/i2c/core.c
> > @@ -23,10 +23,29 @@ static Property i2c_props[] =3D {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > +static void i2c_bus_hold_reset(Object *obj)
> > +{
> > +    I2CBus *bus =3D I2C_BUS(obj);
> > +    I2CNode *node, *next;
> > +
> > +    bus->broadcast =3D false;
> > +    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
> > +        QLIST_REMOVE(node, next);
> > +        g_free(node);
> > +    }
> > +}
>
> This does what it says it's going to do; but I think it
> would be good to hear from Corey whether it's better to
> do this, or instead to call i2c_end_transfer() in the
> reset-enter phase.

i2c_end_transfer() might actually make more sense (explained a little
more below). I'll see what Corey says though.
>
> Mostly QEMU's "reset" is like power-cycling, in which case
> I guess that what we have here where we just forget about
> the in-progress transfer and assume the device on the other
> end is also going to reset back to a neutral state is what
> we want.
>
> Does i2c have a concept of a bus-level "reset" operation?
>
Not really, as far as I know.
On hardware I believe if a reset happened in the middle of a
transaction it would just look like a transaction ending from the
target's PoV.

> > +
> > +static void i2c_bus_class_init(ObjectClass *klass, void *data)
> > +{
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    rc->phases.hold =3D i2c_bus_hold_reset;
> > +}
> > +
> >  static const TypeInfo i2c_bus_info =3D {
> >      .name =3D TYPE_I2C_BUS,
> >      .parent =3D TYPE_BUS,
> >      .instance_size =3D sizeof(I2CBus),
> > +    .class_init =3D i2c_bus_class_init,
> >  };
>
>
>
> >  static int i2c_bus_pre_save(void *opaque)
> > diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> > index 2a3abacd1b..49580e30e2 100644
> > --- a/include/hw/i2c/i2c.h
> > +++ b/include/hw/i2c/i2c.h
> > @@ -64,7 +64,7 @@ struct I2CSlave {
> >  };
> >
> >  #define TYPE_I2C_BUS "i2c-bus"
> > -OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
> > +OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
>
> I don't think you need this change any more ?

Oops, will fix in v4. I'll hold off on sending it until Corey gives
input on the reset behavior.

Thanks,
Joe
>
> thanks
> -- PMM

