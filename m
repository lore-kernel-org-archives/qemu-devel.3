Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1B3CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHidU-0008AS-3r; Fri, 16 Oct 2026 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHidP-0008A9-Ek
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:10:11 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHidN-0005TW-TG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:10:11 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8565d77c277so50339367b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792159807; cv=none;
 d=google.com; s=arc-20260327;
 b=EYw6zslbdkEbDzxx87hHcPeHEIOHt/oRICV8+frZ46+wFxazXWWefn5vhexMMAX5s5
 uFPVo1Zjdk59heLxOO/7elOzYe5/uX2MOU9w2F4R+heyoqHgxrXYeE/8XLbZwbTerhJs
 2H4EiFBg7ig0IxBMzU71E4iH8rqpO1XA9XSkDXrbkqa+MY/qpDtJibA2A1KRJvw+HT/Q
 4IG6rP6pGGXuK4mLZM+TbVWaRS4PKc9aQR/FkstTtjZlYdyicOc8a3aWYUvT29R4MzOb
 DzIP42sImu9UUCHhbjEqb/ogjqnxTnwo4eaDYO2MXwRGhQFA6attJwYIjiY1Ucv5v4NP
 ox6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ugz2s4+8GXJV9icY9SJ1KjWat3hJ+B/MkHwGm3qoxTM=;
 fh=W/JhvAlf9kvTQdSfT2vqiKAkNO4YiRVg8H2M8w9SXbQ=;
 b=h1vpxqG7VPUeYRYZjRHzuZkDUWmRjwzu0vbYwIfqgB2p6iVkHteJRn5njVIMwUXg3l
 VKQ3PntHxK5txO569QgMh49RsqJHIEXa6ZN8p7qWo0RH4XsIwcL1nIXBtf5mD0B/meZD
 5co//ldHPxZDMV6kAAw1zXAwP54E1aXh3C/VSv2v9yxEFT8TyWroQLMfYtEULKadSErb
 Mcek+VHsQOc0B4s1kwiKig2T4IqzPmVqPe8F4ELiWp3aagm69cuKRMIxeGPM1ugeNycn
 q7mHfC07UsIIR5+3NA1lPPOccgdh1VoRn21AhG8RO4BQFqSwXdc1svfoFKL742Nlz8Ep
 h+ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792159807; x=1792764607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ugz2s4+8GXJV9icY9SJ1KjWat3hJ+B/MkHwGm3qoxTM=;
 b=VHUZpAGjFk1cwJIoQTZbP+KRbUFndKc8vusFFHcxWKd6QGBuhFvn8rly4mJTiMoGFB
 dxLZuBruX6lq3mzOeE/HEEWIOp6AlrawtgMgdASnaIaDSO/1km6ijgWbstPaYNX+xMDe
 hJCf3+wP2QETgW9avt/phyYwh4/Eo7AD65dT1bKIHCG7YL/H+qrvCIcwZvH1Dla4O2oC
 prIEG+Qo84IBe/CarWN1yNctoBeLYVm5ZjYs0n/lNGak1RtqMpocNR7JR/zd5qulgy1R
 NIjbc9Q6UKpVVpfhO3F+Y8my7D74w4anwaF9rnbGgsyTPI0s4B7AYn6nPzDfaAf/P0YX
 d4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792159807; x=1792764607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ugz2s4+8GXJV9icY9SJ1KjWat3hJ+B/MkHwGm3qoxTM=;
 b=XIo+bsYj6BOdXcPdtVL1L4rL0g6vyn080P3NOZhqfhvdhOHtUkJmTABonHIfoFMFDy
 06V6suYlFbEEgm1I8AZR4+KR/jSwUJCMbbUZQg/7zB8qb+6SFbi0He++3igBY3SzCjKQ
 KheY8ySqizK5sEo6rcvbLiMezFrWuMpMr/7jQlyGCQEpKfLDMTod/osWbsCzdzyXbubV
 /pJGqKvlPClaRWQXya39xahNtcCIw+wjzS5pXvz4Nm8quH+zIaaiL+9vbdNmCb7aaEPr
 YCjc8RkLT3nCPSEFfvWUFAhwqLoravODoq759zjxQWOzDdhRl4n58JdPe7arWPnwRUkC
 8oLg==
X-Gm-Message-State: AFq9FYIjdTiCKj8kT1RWCviAzmqtcOhkLFqNRbTH9bOnafeIHD4ctJiB
 6/4768gD87GhlBeJpDO7V4XKlZFNrWRXKs6m/2K+XALjePkF/WVqOmoFVAzBbeeKWaImV2R4jd/
 aElQjHOlWUzDmmVV1WThwtrp4Pofvrxh8MKSs8XjsxQ==
X-Gm-Gg: AYBFou1Bvz8gb6kO/UJJWXxsMeV1sxX3MQgGGXYcrRzIZeIxJxbSklTkV5NCnOHTTIT
 xWr9x3S1aSsAqqgEhwk0j2OSbQuGg11wCbtCwo6HfOo1GO69nVb0wlZMd7qzMW9RuGImeUv4ckI
 7/lRjmoSbO/vXSJkxXRD+OW+6AkrYQdOYv/QkT1FrQ7mv3/qDfLWEUXEGuvUxcjGVp7xustq5by
 07DEtTig0hzUQ2mVgp0esTeoS0dKNQ5esAw1sCBUPC4mn6pdS71lgUUVzg0cKsPxZsBkR0vUsSV
 nT6sxu4cCPIhGODzZIFJ4iqhUbL6Dfh3fiifuli5Euvia/9JCeUNkp7Vb11PloqM1uJiQQsAGPD
 Tty8gxFRQnxpmVwpzheLoQGEad9w5zkUwoZjFdpG4yIE9Y0rjGw==
X-Received: by 2002:a05:690c:4006:b0:8b0:eb21:e762 with SMTP id
 00721157ae682-8b0f22024f6mr285217b3.65.1792159807167; Fri, 16 Oct 2026
 07:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
 <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
 <atHrFXxyIl3Nbvht@redhat.com> <atHu0kCSQTD9E34p@redhat.com>
 <CAFEAcA9PTB=1V_hV1P0xpEW4aY+4LajYyzKzyTOJj=bb9=oPvA@mail.gmail.com>
 <atICMoFG2gkoHWJ-@redhat.com>
In-Reply-To: <atICMoFG2gkoHWJ-@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 15:09:55 +0100
X-Gm-Features: AclHuK-mwJ0hkB9nSRWo73LLt1WyfFFZKkOPiEgQdiNxT7lDLPvT-a4jLC3HEgo
Message-ID: <CAFEAcA8hJ_WK+4itRtQiJBtDnd5TfA5jrtrcF2qPAj0cnJ+U9Q@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 16 Oct 2026 at 11:53, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Oct 16, 2026 at 11:14:16AM +0100, Peter Maydell wrote:
> > On Fri, 16 Oct 2026 at 10:31, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:

> > > +#define qdev_realize_chain_parent(dev, dc, errp) \
> > > +    DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(dc)))->realize=
(dev, errp)
> >
> > I'm tempted to suggest that we drop the 'dc' argument here and
> > have the macro get the class from the dev:
> >     DEVICE_CLASS(object_class_get_parent(object_get_class(OBJECT(dev)))=
)->realize(dev,
> > errp)
> >
> > because I think almost all realize methods wanting to chain back up
> > won't have the class pointer to hand.
> >
> > We could maybe have an extra layer of abstraction here such that
> > you write something like:
> >
> >    parent_invoke(DEVICE_CLASS, dev)->realize(dev, errp);
> >
> > Or is that trying to be too clever?
>
> This won't work if we have multiple levels in the class hierarchy
> that need chaining up, as object_class_get_parent(object_get_class(dev))
> will always just get the first level parent class of 'dev'.

Isn't that always what you want, though? In a class hierarchy
Object->Device->A->B->C, C's realize method always wants to
chain to B's realize method, and more generally "invoke the
superclass method" from C wants B's implementation, not A's
(assuming B actually implemented it).

> Somewhere/how we need to identify the current class level we're
> calling from, so we know what parent to ask for.
>
> Another option is to do what GObject does and provide a simple
> helper for getting the parent class, from OBJECT_DEFINE_TYPE*
> macros:
>
>     ...
>     static inline ObjectClass * \
>     module_obj_name##_parent_class() { \
>         return object_class_by_name(TYPE_##PARENT_MODULE_OBJ_NAME); \
>     } \
>     ...
>
> which would be used
>
>     DeviceClass *dc =3D DEVICE_CLASS(pl050_kbd_parent_class());
>
>     dc->realize(dev, errp);
>
> but many (most) of qdev impls don't use the relatively new
> OBJECT_DEFINE_TYPE macros. They would have to instead explicitly
> reference the parent type name:
>
>     DeviceClass *dc =3D DEVICE_CLASS(object_class_by_name(TYPE_PL050));
>     dc->realize(dev, errp);

I still don't understand why we need to get the parent's
object class by name here, rather than saying "give me
the parent class of this object's class".

thanks
-- PMM

