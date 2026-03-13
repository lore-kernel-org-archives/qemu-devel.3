Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C34106ACFE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0qFA-0004eo-8U; Thu, 12 Mar 2026 20:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0qF8-0004eP-3Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:19:06 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0qF6-0000MI-AG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:19:05 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-660dcafc85aso3004683a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 17:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773361142; cv=none;
 d=google.com; s=arc-20240605;
 b=SRSeyrdE7CTUyXvGxhxsq0WPDVYfAoojaxB6ykm4Hv7Aj+M5dw+I4ng3L5zpwDbUu3
 X9cH5jY3Ydf4D4i1Nfvp2/pBqEMZB0WCiQo5HHxTZ9JqzoIqKoScaGogfDWe9+p4uxe7
 +rJCfY+E2QzFw6p0Sy28rCmtRKb+pkrKiEm3uTq06wmcePBCKMoru6d2W8KGA38Y5acw
 EAvRyG7c5JWq3IfjTKiigoJxNRLxIKP3hDGodkZM/w8I0AGaximxipS5IM41Sr0KmRuW
 vUKx22o+1BsHGtaOod+1NA//8At4k9zO2/4nFDM0l6cjfC8/i6425IqQ3LnOUFXwOUqo
 /CDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xWtWiNHkGGM1Fr2c4JrWLkhhDz1gIyv4cdzeeBKjUi8=;
 fh=3YKx16Laq/Ik0WArDqL2bxity6Ye0lJvC3VUSQHHn94=;
 b=R1nd2ICmf/OrsN98Ei9j8ehHz7M5n+pS4f3OF3KyZTTqkepzXSZc996Bfkf0Y92vLt
 On0aoaj6ywx4TCbJLmYruX2B64Udk+/YtH/0lxGQ/yx68F1osF0Qlbh9akq5vbvlZhgS
 d+J8G9fJorIMLeOr6WhZH+ndIzRELZMyFfjqfWSJc1IPlvsQTO99yNdryRUlVKzxjZCk
 5l99prypAy5vmGhUF7sOjbjueggIrX0cO12jo9B+vKvi7eLzdLKObFbyR2YpFFu53cNf
 uzdG3l7E9drodkiojMwWf/7ziugPgBFDUWX+wW+7eFy6psUCIwfS9nNpaeeastKyxKvr
 4dqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773361142; x=1773965942; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWtWiNHkGGM1Fr2c4JrWLkhhDz1gIyv4cdzeeBKjUi8=;
 b=LEuBTkUTxVjmXm6756CP4ZaXuAnzm+k1ny06ypuL1QGy93BRryUqU2TSngJW3e1MM+
 jGqr0GslThagYL0QaoSZhNugMYgklpXCBUpqLIrMO+7Dbxa8/gCeY+S2gz8ulAM4gzY1
 zB5GK0g7rhtLkuo15OsMKUyimsl6HZvzUMb4hHwLsMOZNRD/hJD4i0dGJ8li3wNQD1Un
 W1mYKqVUzd6DZGZ/nSn8tXrmIdnLpm9N+YQtUwqiTTynEhqLQUymvWEXi7/i/qYZDN2G
 0r+QQsMW939MYLOYTjufmgQGhCiD9mdD2wpQk2ezngvS4A+P9P3AhkUkTrjcxUObglrv
 lqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773361142; x=1773965942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xWtWiNHkGGM1Fr2c4JrWLkhhDz1gIyv4cdzeeBKjUi8=;
 b=hKIONZPWwiECSJn95mSTQTi0mSWo61e/OPyfX7gXaZ9ueNBGUnH4MqpuXxU2X6ZSFZ
 ac/63bnicrzQybBMVpy+T95eY5gzgT0nMdYFgYT12wHZmLsj+7kNeHLbgPGTV1ngBiSz
 vXLO89db7/gJYcpBjk1mmlHtPeYurjCFk5LGNC9PWh/HIDPCW8Yy2+kd3C0htLJWgDxx
 7S5MX1egXnGDTJhGWq4Eh7ppiWTo++S38Wd/6yA7Az+SLkEZ+yrT7iVIrtsWnYxlWLAC
 +WpvWF0Cjw+RO0TLA+ieSzGjFN1h85jVH7elG6wSxz7h+1aGtOf3LwxLAuqeRg2W9MQw
 Iacg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoLdjc/5Ta/m25wypeRSJJjKNPikOGJOn5tujPOZXtniQNZ2W4q6SM/YLRhcSQt7U8H9vJncnhB7/N@nongnu.org
X-Gm-Message-State: AOJu0YwKuwinUa3hh0jTTG1HUDuEppl4Y3lWrVchYPBtEX7UFAWJYffu
 50nzeeg1v+cyWd8636vyWBUK+v5XPwAqwlGi7V+Pc1FCzvGdD2IM/q6FlxZa3CFmNGpgQXf85vh
 fr+3yAaS9emmWM3lbVkuosspAfUWpOas=
X-Gm-Gg: ATEYQzwuq72MfTzQzAww7Vwgt4XWqm434IsRLjQK5B213xWBc5PaD4KovqtgHaK7qxV
 BUI9mK3uwnyxyylvc9sGE61+RH3wxkJS0+VymdiClQ9CY250deAMt8Lvs8Fn6wWav3LA+ykOHjp
 6zGGrpM/nK6Ecoed+UaI0ipe7kWD7nDk9mVIEtYF/0IEadA42o2+FpLnm53O5JSA1SlkbcTP6TA
 oTrskdqYOwghotj6DWw79YfGKxA2LvOTD4RaOdi7Mr5Uc3V8nqwb1WJwvMM/hnXLj67/xV7lOPC
 24iRO9xwyOOtYQnDeH2PEymPn+2olIFMdAeEcw==
X-Received: by 2002:a05:6402:540d:b0:663:7365:47a3 with SMTP id
 4fb4d7f45d1cf-663bac026aemr684575a12.22.1773361141949; Thu, 12 Mar 2026
 17:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
 <20260312043158.4191378-4-alistair.francis@wdc.com>
 <CAFEAcA8PjHZN0kxKqp=8y2xG3wefmh2JioV06p0Hgw9dkg3_Ug@mail.gmail.com>
 <a7a425d4-f01a-d25f-31df-38af8f4802d7@eik.bme.hu>
In-Reply-To: <a7a425d4-f01a-d25f-31df-38af8f4802d7@eik.bme.hu>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 10:18:35 +1000
X-Gm-Features: AaiRm51TNu_TUqK2McO7oIGkd8zzibSoYE3_kkx35ey7RnfHYfrNADaJt6fP4fE
Message-ID: <CAKmqyKNhg_xG3Ok-MhakVr6wOSABN6N=sjhOOqb18M81oEGrhg@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/arm: xlnx-zynqmp: Don't call qdev_get_machine in
 soc init
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, 
 pbonzini@redhat.com, berrange@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Mar 12, 2026 at 11:39=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu=
> wrote:
>
> On Thu, 12 Mar 2026, Peter Maydell wrote:
> > On Thu, 12 Mar 2026 at 04:32, <alistair23@gmail.com> wrote:
> >>
> >> From: Alistair Francis <alistair.francis@wdc.com>
> >>
> >> Calling qdev_get_machine() in the soc_init function would result in
> >> the following assert
> >>
> >>     ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
> >>
> >> when trying to run
> >>
> >>     ./qemu-system-aarch64 -S -display none -M virt -device xlnx-zynqmp=
,help
> >>
> >> as the machine wasn't created yet. We call qdev_get_machine() to obtai=
n
> >> the number of CPUs in the machine. So instead of initialising the CPUs=
 in
> >> the SoC init let's instead do it in the realise where the machine
> >> will exist.
> >
> > Here I'm not sure I agree. We should init child objects in init, not in
> > realize, unless there's a strong reason we need to not do that.
> > Working around "we crash if the user does something pointless
> > on the command line" isn't a strong enough reason IMHO.

Agreed, but there is an actual reason (maybe I should have been
clearer in the commit message). At SoC init the configuration for the
machine might not have been completed. So we don't have enough
information to init some child objects.

> >
> > The problem here, though, is of the kind "what child objects we
> > need depends on the configuration of this device", which kind of
> > pushes "init children" into "realize". We do that in some places

Exactly

> > already. But I don't like that -- it makes us inconsistent about
> > how we handle child init. If we're OK doing some child init in
> > the parent's realize method, why not do all child init in realize?

I agree it's not ideal. I think of it as we init children in the
parent init unless we can't because we depend on some configuration
data. At that point then we just have to do it in realise. We don't
really have much of an option. Maybe in the future things change and
we can revert this back, but for the time being I don't think there is
a better option

>
> How about saying that we do most things in realize (so simple devices
> don't even need an init method) and do in init those that need to be done
> before realize such as things exposing properties that can be set before
> realize. I think that's better than always splitting init and realize for
> all children that's most of the time would just add complexity without
> reason.

I do think we should strive to do all children init in the parent init
function, just sometimes we can't if we depend no certain config
information

Alistair

>
> This is similar to what I asked about in
> https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03945.html
>
> Regards,
> BALATON Zoltan

