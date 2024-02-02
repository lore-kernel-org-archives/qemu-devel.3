Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23ECC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 20:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0P0-0007q0-OK; Fri, 02 Feb 2024 15:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rW0Oz-0007pn-E1
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:44:45 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rW0Om-0007Uj-0f
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:44:45 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42a88ad0813so59551cf.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 12:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706906670; x=1707511470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LeIYHZFwIjDi9fUU7mae7l1z19F6IxoFheyY6/CndU=;
 b=l890eBv/KVzsJrPHQKnqIm6VLmYOv4UkoKyoUkRcMuJTxnVYBh7Pkmst+4i7HTCPXp
 bWeqLeXRnyWfaZjGHoSz2jyJssEwmNAe991xDz3x3P85TX0wX9Z9SsBs1zI/oRm28por
 KUI9f+yzVnAjswvykHbGnVSEArJtTcDXFidY9WBrp0kUTfb6sS4ao9MWkO/D5yhEuPJf
 xSct9iH/O7O2Ys7EwbGODsJJX0i7WYVTaattf2YdpehYYG3zoYb1fhpxPJR0JXf7YrWX
 JSpj8LWAUqrRaSEZcVrJRgIm5D/xQzIa0rzMjBw1J0fTql92P/RugCAuh00naFkQSRn5
 RMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706906670; x=1707511470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LeIYHZFwIjDi9fUU7mae7l1z19F6IxoFheyY6/CndU=;
 b=KVO09V7h0Cmv65Ztqgt22a2Acf0meOdZUmoRfAkpErSflw45O4VV3ApZnuijQ4ozt0
 mk7nSgOCKNF91ZvMLUde0pvu7LptDO9ZNYiorcvsRCu0y8NNNlmYtpFJrpRHDyGrBj4z
 r7n6yo8yv/RF7LzbI5E9SbMxN5Si3OTROufc2IWnkDOz+cup0Exo/Hwj6bhhc1wYrSWz
 CXxe3HS9We3d/I3DgtmgHl0aJ4NhrZbqvBkG9SrhZdfasWRJGvhAkBqq+p3WfcyRfkCk
 OjdWT16pYgLZFQ3JhRtM+hxoxXbcMJntcOJ/PK0usQ8/eGTSRiBRfo8PmqQGHyQcqCb+
 BJdw==
X-Gm-Message-State: AOJu0YzgAWrJBNfRo0V17CzWfKwARl109sO4kae1sNk1vJLKilDyM2Ix
 S7LFLzGUlc5yL6ATDUItW/GI3E7+l6XVLM1AVLh78kfy0FexALb99ilzUBgmnTm/0KbAFyG9AG+
 amApjb9YL5h4YGzLcAZzHa/8izAiPFOo0z2uF
X-Google-Smtp-Source: AGHT+IFG72bgQu/t7P5jBHaN+i9ADw76v3CCr1GC/dHIXqWx7Wbhs7cmSMYq6Bxn8uiNjIG05zhmAh8vjJ0EaT9YVH4=
X-Received: by 2002:ac8:5b95:0:b0:42a:8e5d:d074 with SMTP id
 a21-20020ac85b95000000b0042a8e5dd074mr15729qta.18.1706906670078; Fri, 02 Feb
 2024 12:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20240126005541.1839038-1-komlodi@google.com>
 <20240126005541.1839038-2-komlodi@google.com>
 <CAFEAcA9xf3WvNPiTp2LRP_8Tuv=KDGMLDSwOtD+S0UDK5UVDZA@mail.gmail.com>
In-Reply-To: <CAFEAcA9xf3WvNPiTp2LRP_8Tuv=KDGMLDSwOtD+S0UDK5UVDZA@mail.gmail.com>
From: Joe Komlodi <komlodi@google.com>
Date: Fri, 2 Feb 2024 12:44:17 -0800
Message-ID: <CAGDLtxvxdxWa8JsC137OYbyneKDdOqsmak9XpEDVtTV6Heshyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/i2c: core: Add reset
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
 ENV_AND_HDR_SPF_MATCH=-0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
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

Hi peter,

On Thu, Feb 1, 2024 at 7:24=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 26 Jan 2024 at 00:56, Joe Komlodi <komlodi@google.com> wrote:
> >
> > It's possible for a reset to come in the middle of a transaction, which
> > causes the bus to be in an old state when a new transaction comes in.
> >
> > Signed-off-by: Joe Komlodi <komlodi@google.com>
> > ---
> >  hw/i2c/core.c        | 30 +++++++++++++++++++++++++-----
> >  include/hw/i2c/i2c.h |  6 +++++-
> >  2 files changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> > index 4cf30b2c86..def4f134d0 100644
> > --- a/hw/i2c/core.c
> > +++ b/hw/i2c/core.c
> > @@ -23,11 +23,31 @@ static Property i2c_props[] =3D {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > -static const TypeInfo i2c_bus_info =3D {
> > -    .name =3D TYPE_I2C_BUS,
> > -    .parent =3D TYPE_BUS,
> > -    .instance_size =3D sizeof(I2CBus),
> > -};
> > +static void i2c_bus_enter_reset(Object *obj, ResetType type)
> > +{
> > +    I2CBus *bus =3D I2C_BUS(obj);
> > +    I2CNode *node, *next;
> > +
> > +    bus->broadcast =3D false;
> > +    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
> > +        QLIST_REMOVE(node, next);
> > +        g_free(node);
> > +    }
>
> Doesn't it confuse the device that's partway through a
> transaction if we just forget about the transaction entirely
> without terminating it somehow? I'm not sure what real hardware
> does in this situation, though.
>

It could. Ideally all devices on the bus would have reset functions
implemented as well, so their state can reset.
With adding a bus-wide reset, what could end up happening is devices
without resets implemented end up in the wrong state compared to the
bus, while before they would stay in the same state as the bus.
However with the bus-wide reset, devices with resets now match their
state with the bus's state, while before there could be a mismatch.

Fixed the comments in this patch and in the other 2 patches in v3.

Thanks,
Joe

> > +}
> > +
> > +static void i2c_bus_class_init(ObjectClass *klass, void *data)
> > +{
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +    rc->phases.enter =3D i2c_bus_enter_reset;
> > +}
> > +
> > + static const TypeInfo i2c_bus_info =3D {
> > +     .name =3D TYPE_I2C_BUS,
> > +     .parent =3D TYPE_BUS,
> > +     .instance_size =3D sizeof(I2CBus),
> > +     .class_size =3D sizeof(I2CBusClass),
> > +     .class_init =3D i2c_bus_class_init,
> > + };
>
> Looks like you have stray extra spaces in front of this
> type definition (which has then caused 'diff' to not notice
> that you're only adding fields to the existing struct).
>
> >
> >  static int i2c_bus_pre_save(void *opaque)
> >  {
> > diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> > index 2a3abacd1b..420868a269 100644
> > --- a/include/hw/i2c/i2c.h
> > +++ b/include/hw/i2c/i2c.h
> > @@ -64,7 +64,7 @@ struct I2CSlave {
> >  };
> >
> >  #define TYPE_I2C_BUS "i2c-bus"
> > -OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
> > +OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
> >
> >  typedef struct I2CNode I2CNode;
> >
> > @@ -83,6 +83,10 @@ struct I2CPendingMaster {
> >  typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
> >  typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster) I2CPendingM=
asters;
> >
> > +struct I2CBusClass {
> > +    DeviceClass parent_class;
> > +};
>
> This isn't correct -- a FooBusClass's parent_class field
> should be a BusClass. But since you don't define any new
> fields in it, you don't need to define the struct at all.
>
> Instead, your TypeInfo for the TYPE_I2C_BUS can add a
> .class_init member, and leave the .class_size unset
> (it will then inherit the class-size from the parent
> class, which will be sizeof(BusClass)).
>
> > +
> >  struct I2CBus {
> >      BusState qbus;
> >      I2CNodeList current_devs;
> > --
> > 2.43.0.429.g432eaa2c6b-goog
>
> thanks
> -- PMM

