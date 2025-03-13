Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B86C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfYc-00004u-2r; Thu, 13 Mar 2025 06:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsfYL-0008Up-B2
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:12:39 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsfYH-0001FA-VG
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:12:37 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e6343c68b8fso608800276.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741860749; x=1742465549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E8BNtE4D22LZkURYCBj+A5vFJT9ApgOGodu949sObHo=;
 b=bGkhQzpy4+CCFF8ay4bKWJrdXUPNnmJ29KK27c5wY6vTnBas68fnWj3moxSTuLbzF8
 6aHJxwz3P0DlHmwWicEpU4PMoeE11af5rFIt083e6sKiYcaIUNnJcwoZ2/ghD6p8xhLM
 1/pY5nXifYeC7Zg4lQf2O6X1aA72/57qHTYV5A5//TQxxF3aOufJTcK2KkXaY6g4BGCB
 7a2/csGffW6pkLaatxnWlsEY2jEdSSB+LLJaIsrg/+88JSktQDxnLS6k+UvjgzJBw2GB
 aEJ1jE+uD93XY/jnGSYYP6jbkOFM7ye5dp/29DXp2qK6IpjPWrdHa2jD1EmdHFegY3mX
 fmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741860749; x=1742465549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E8BNtE4D22LZkURYCBj+A5vFJT9ApgOGodu949sObHo=;
 b=FxsrQb2SdrVVnLFEFjg2UGM5l2JV0YHOZN2GgmRRSJVbVBM6B6TX1uAylFGu3e5zIT
 9FkiJ4i0rij6QHNWA5qW9DwA6nBpyRpljz510y2ktiixijweoYu9IviYV2kdTLw6EagA
 4SkFO8dLjgaruU4L8Zsy+l+R8Tf8/5mJAsE9I0MfuSmnKOYcaziT2rRGLYqBzrVMTp60
 qFeOOy224cBr47YnBRWl1Vn4RPakDJprFmngo7uJ/VOZ1zkk3Rv7BNhdgjMSOJkcf5A0
 +yYXh7B/c4CBdpt3wSfv8DQ6CxE3jiWPc8PTTG04a4ZIkxBeQsQIlqhO5BFPQ3BKGbyS
 YDGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWth77TPTgc1AlsQcgJarYiV1SMGgRrrVMV/Mzx8jCl2UUldKwlrb/gBNpihyoV6iaXJ8d9Njmrr5V9@nongnu.org
X-Gm-Message-State: AOJu0YwYemX5JhBgGSb9ccxNqC2l+yxF8ok9gCHUUBJYQ0UIl0fxDkGd
 5HbkneQZZilVu4PNjJ8el6TZzh0IwZ65nlruCrQFyE2FDkXbzni+Crt34eBJrvSgzWfbhaq1WvK
 QjDwsAt3qUTqFec8gOMXtBbZXgKFx9b56MVjY7w==
X-Gm-Gg: ASbGncuWQfak8AS3sVqqFLXdZVqAsFSVw/JRe0T8QAoyWcazQEabkgfTWUoIj80RwVV
 IpNOFhdqqdy2Mm3/GcLCyCXL8ta5ynwY4N6+4PCugXFLjwNy8r9y8c7qU05CXGny/zVFhz1TTeX
 M7f44d9hQpQqcd7wt8kSq4Z4V/G9Y=
X-Google-Smtp-Source: AGHT+IGvedEiL1qJjRiw1BlSHms2do7fJNn9XtaqVvJugtmEUw4BS6qVN7EMJWqMI/z6eSRmMAVSHD8abYwTKGSHHx0=
X-Received: by 2002:a05:6902:2788:b0:e60:c442:afbf with SMTP id
 3f1490d57ef6-e635c1f37f4mr32913337276.44.1741860749422; Thu, 13 Mar 2025
 03:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250312212611.51667-1-shentey@gmail.com>
 <20250312212611.51667-2-shentey@gmail.com>
 <065c6990-d2dc-7b03-cd0c-344ee6b6a619@eik.bme.hu>
In-Reply-To: <065c6990-d2dc-7b03-cd0c-344ee6b6a619@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Mar 2025 10:12:18 +0000
X-Gm-Features: AQ5f1JoxIFraBNw8Cg2E6XTijML8zd0g0vjS17-0zc8ULDgPKiudkOd-TfyK2Cw
Message-ID: <CAFEAcA9ivdbKoe2ip9njx4hFkkCsQCUHnMDrKeH-iQ_5368bJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/fsl-imx8mp: Make SoC not user-creatable,
 derive from TYPE_SYS_BUS_DEVICE
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 12 Mar 2025 at 23:58, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Wed, 12 Mar 2025, Bernhard Beschow wrote:
> > Fixes a crash when creating the SoC object on the command line:
> >
> >  $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
> >  **
> >  ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
> >  (n < tcg_max_ctxs)
> >  Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
> >  assertion failed: (n < tcg_max_ctxs)
> >  Aborted (core dumped)
> >
> > Furthermore, the SoC object should be derived from TYPE_SYS_BUS_DEVICE such that
> > it gets properly reset.
> >
> > Fixes: a4eefc69b237 "hw/arm: Add i.MX 8M Plus EVK board"
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Bernhard Beschow <shentey@gmail.com>

> > diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> > index 1ea98e1463..9133d49383 100644
> > --- a/hw/arm/fsl-imx8mp.c
> > +++ b/hw/arm/fsl-imx8mp.c
> > @@ -698,13 +698,15 @@ static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
> >     device_class_set_props(dc, fsl_imx8mp_properties);
> >     dc->realize = fsl_imx8mp_realize;
> >
> > +    /* Reason: SoC can only be instantiated from a board */
> > +    dc->user_creatable = false;
>
> I think sysbus devices are not user creatable by default (that's why
> dynamic sysbus device was introduced) so either this or the .parent change
> below is enough. You can have both just in case but maybe not necessary as
> other sysbus devices usually don't set user_createble either.

Yes, that's correct -- we don't need to manually set the
user_creatable flag here now we've changed the parent class
to be sysbus.

-- PMM

