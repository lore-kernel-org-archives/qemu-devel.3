Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3689CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHQ17-0007A9-50; Thu, 15 Oct 2026 14:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHQ0x-0006qR-8A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:17:19 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHQ0v-000245-72
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:17:14 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0d126f631so16034127b3.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792088230; cv=none;
 d=google.com; s=arc-20260327;
 b=V9NvvYYbvwQvWxUC9N0XN1lciVfGyMHUGUYz1Gqc5AWzHG0dZg6iFuTsWsZBHD7dSQ
 pSLs9CFOwFAquOA+wyINSAJDKN1hal3fuT0OMfu1bwXav9qaaWw6C/EOLzcg76ulZ1i3
 rpDC3/i0FZNPd9dO5DWGnIrO8CbHDllY4g7M6jyLqln4XlLRWgwuXFJhthnFNd78Ua3c
 KULTDyYTZT7t5vALvyNPKWLPUqxZl5Q9JUxVUcC/ePgIhFDLMZkZo2rtLp+Nr6UMIktn
 C9c/d6996DwU9HkPSNf2pOVgcL6QZJqxvLsN9vq+0HNCR0h3g5a+ga8PawOxN0nhgbWd
 rfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7CwE7f/YNKXWSR3ShZsT/nFCuFAw+1Nclzgc4s6rzvE=;
 fh=W/JhvAlf9kvTQdSfT2vqiKAkNO4YiRVg8H2M8w9SXbQ=;
 b=TNGSVjvAOPtGWYg2ZFBHoYHePCkipX/xCG9pSuJDBz/eiLUvqzvSUe31IDHZHYr4C1
 /nkudsfrc4WmJ+XOD2h6kzU3G60WlTjtULMhNvfJSeKn2dQa9KxsRp9wyfeD75nGj+Jz
 xRk5TWeX1kZEcBtiw1DZhDunjolFQpZi5UDbkJWzPIkBTdMt4IDFsz4uyvhDwx7XRH9/
 SLtNVhqPObUs2kWwY7dCpveI11YEltZzM+6fSlZacgQEV8R8Szg9bi30+bxK4u5E1fNg
 gzkj2ZUwmuwtiSXwDYJa4kKwLSsZnwbqwUP3rDcom11VVwf4/t/HNjLoycsLLms+8R2j
 LSxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792088230; x=1792693030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7CwE7f/YNKXWSR3ShZsT/nFCuFAw+1Nclzgc4s6rzvE=;
 b=dWGPW/zA/vCRoBDYoVFTMwS7TGs+nC9EmZjX5NUaYQxNRak57fLgRRuupk6tfMdmR/
 Hz/kBmlW5Qvs9rOm9Kp6ZAhdG4InbBy2Xc8O2fHZ48LVD/UOrc7f15bDs+TMk2U7X7MQ
 zwER2VhxasGeSPuUCvET/dA+hS98OZAgOdabsylJ8pZtL79yS211/x/ALU2jNUCBTumH
 dp/SDW3iQxw9pK10aGA0MCKeaYzoRE6jZ5Z2ctpDQVYUoO3/18UCxQUTBUmCKWGZoeBR
 sE5z3Ymw6j5dbP4lqXhjklJucAXY6QXRHK7tDa/dzW8cczL2F1xWo1cVD6SKVasdVB6v
 am6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792088230; x=1792693030;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7CwE7f/YNKXWSR3ShZsT/nFCuFAw+1Nclzgc4s6rzvE=;
 b=wlJL9rzzygpEEt0jiKgQmfHEnCb2/6PU8Cq679BNCOfDmz96KhAGhCKVFeYJYB38Uf
 SjPP63hf5TvBGdy+kRaI3rRcmTab+fnnMCcQzVdSbtXvHEpKTGWh3SRK9cuDnaClaNN/
 uKtgJqN8T9Jd9wA/RbMwSuem8AF1DNSwD/bHODukkNVlBMnFaEwrWPTr0u7XUpW8ml/P
 DY7Z027FkzY0hLnrmvtiXJbARXAnD3SL3sr5ya5ZqfRtn0aJs/mizrxHEnTHy5LBtne3
 Xbzrro3w75MvvyfOB28GXrx4d2mn5rwtc4OUyFXcF6aVye/Uq7XPAkYYQK8mKtfCR+hi
 XpYw==
X-Gm-Message-State: AFq9FYKoh8+5Ot3RAYKjLA6FH+Ec8TQfktqiRGhohVmZISMak5pFs5GF
 O3+DkbeQRPtlF729f45WxFNuprzWjc8/iJbaOd1CCihSQ0S0G7/7KD8gFAIo4ZCWu+6P3iRD491
 MFxnsTyxx6zSHWHcbkwhFXi6EYKScliUlDXHo3rWV4Q==
X-Gm-Gg: AYBFou216Tu/dTKuC1XBQ0GBmuYYbxbgbRnYTbCOGxiRmZibdTrqghyao2x8EAQmHEM
 aR6Lda8fKd9Rhs42Lk4ocz6HNsXiXtUSOqFkM/BtHnKOqCgZbNv/nJsSMmvDE70ARdK4GCsUbRF
 3B1uCE1KUTNI8Q5dGxkbM5C1WEpsSywY3XH7Zw2JqkQ1/2/qAfukl6XvUozr2a0PD5udg59OfOC
 9SllNlgyuT1EO/7LbNc75EmsR7cTtEvF7OQDD/54CF0aiSqejF6qCS9nSJ6YhCoC/6i878r5vDN
 +dy9azmAiZYii3JapZR3KE1hdFiAF+83NCGsF67PBXX7YBq8Y2yQnp5iRax+C0eryiiBreDnVQR
 SIZnJyZU4Hf9cVfqfaF7PMj3tg3CeNZmKl5IKAJw=
X-Received: by 2002:a05:690c:4f89:b0:8b0:ccc3:27d2 with SMTP id
 00721157ae682-8b0ccc3303fmr13955287b3.29.1792088229601; Thu, 15 Oct 2026
 11:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
In-Reply-To: <atEC-pIGhLYLXVmC@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 19:16:58 +0100
X-Gm-Features: AclHuK9D2GmlMxylJU6DEN1cXhtTGabHjX96stEfAkOtxavRWQGHySqK_Otu9X4
Message-ID: <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 15 Oct 2026 at 17:44, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Oct 15, 2026 at 05:33:52PM +0100, Peter Maydell wrote:
> > The documentation for device_class_set_parent_realize() suggests that
> > the parent realize function pointer is "usually in the instance
> > structure".  This is definitely wrong, because the function pointer
> > is a class thing, and should live in a class struct, not an instance
> > struct.  Update the documentation to correct this, instead
> > recommending that it should be placed in the class struct for the
> > child class.
> >
> > At time of writing, of the 75 or so uses of this function, about 50
> > put the parent_realize pointer in the child class struct, and about
> > 25 in the parent class struct.  We recommend the former both because
> > it is the more common choice, and also because it makes more logical
> > sense: it's the child that knows (a) that it exists at all and that
> > (b) it wants to have a realize method that will mean it needs to
> > chain back to the parent, and we shouldn't need to edit the parent's
> > class struct because we want to add a child class that chains to its
> > realize method.
>
> I'm confused why we need to store a copy of the parent's
> realize method at all, when we can just reference it from
> the parent class struct ?
>
> Taking one example
>
>   static void pl050_kbd_realize(DeviceState *dev, Error **errp)
>   {
>       PL050DeviceClass *pdc =3D PL050_GET_CLASS(dev);
>       PL050KbdState *s =3D PL050_KBD_DEVICE(dev);
>       PL050State *ps =3D PL050(dev);
>
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
>           return;
>       }
>
>       ps->ps2dev =3D PS2_DEVICE(&s->kbd);
>       pdc->parent_realize(dev, errp);
>   }
>
> why wouldn't we rewrite that as
>
>   static void pl050_kbd_realize(DeviceState *dev, Error **errp)
>   {
>       PL050DeviceClass *pdc =3D PL050_GET_CLASS(dev);
>       DeviceClass *parent =3D DEVICE_CLASS(object_class_get_parent(OBJECT=
_CLASS(pdc)));
>       PL050KbdState *s =3D PL050_KBD_DEVICE(dev);
>       PL050State *ps =3D PL050(dev);
>
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
>           return;
>       }
>
>       ps->ps2dev =3D PS2_DEVICE(&s->kbd);
>       parent->realize(dev, errp);
>   }
>
> am I missing a reason we need to store the parent's
> realize method pointer ?

Because the parent class's struct doesn't have a pointer to
its realize method. pl050_class_init() does this to set
up its realize method:

    DeviceClass *dc =3D DEVICE_CLASS(oc);

    dc->realize =3D pl050_realize;

and that's the only place where pl050_realize is pointed to.

To put the child class's realize method into place we need
to overwrite the DeviceClass::realize field, which means we
need somewhere to put the old value.

We could alternatively solve this by saying:
 (a) every class struct must have a "realize" field,
     and the class init sets both DeviceClass::realize and
     MyClass::realize (perhaps restrict this to only "every
     class that has or might need to have subclasses")
 (b) to chain to the superclass realize, get the MyParentClass
     class pointer and call MyParentClass::realize

The support (or lack thereof) in QOM for methods like realize,
unrealize and reset which should pretty much always chain to
their parent class implementation is pretty terrible, so if
we can come up with something more ergonomic I'd be happy to
throw out the hacks we have today.

thanks
-- PMM

