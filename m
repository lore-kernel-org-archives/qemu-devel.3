Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC31CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIOyV-0003Va-B7; Mon, 10 Nov 2025 05:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vIOp3-0007mF-U9
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:08:35 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vIOp2-000730-79
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:08:29 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63e2cc1ac4aso2484266d50.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762769306; x=1763374106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5Z91bI5zAmTkC1Dz4DfzvP4Fg1nekpvX0sx8Pn60Ck=;
 b=AFFgpS7rQH9tESvLNm6r5sxrq89vHT79xyogChkYgl41vRe57IAHl/GC6ICbgoyzly
 FsBabPKFu/z8g8bBwVTZE9mvhnEK54JdOG7enaIKXCJLgQjtp/HwJmTDFM6gROMQ1//L
 Tkb8OP7T6I4g0H2FmlGFSrCdK0xM+Dvxk6ELFD4zb44H9qUtzvEPlGfZghi0nwYA27OI
 /5qgOWJ3oRwduwW+YauF7IVJ+xhGyKdzUsh0hB0WQOdJZyNj/3p7SNHxMzyQX9B8Balr
 cK+TpvzAY2ZylZXQW90riID/mFrtsOlfM376nWpNLGi6AB9H83IhpEpLRknE/MZpYLe9
 irhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762769306; x=1763374106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5Z91bI5zAmTkC1Dz4DfzvP4Fg1nekpvX0sx8Pn60Ck=;
 b=hK/+spd8xceaIcZCtNEPv/AUYDm3UWZZ9/trzaFWzW+CRG7M0tt024PThxHek1x7BC
 STr0XiikrteTNj3VIcYe82CPKA2XD0mV2zHb8YBvvGOfouthXX5pDO+Rf6foibjntYLy
 fFzDEiQ5XwQsH8DDcSrkx6vueUZkznByDfP5CI/Jzg5UcKmVvpV5HKOYf32JPNlwpBbA
 O1MzTLRYENnxk4SY+O+yvodD1hJ6zkeki+srwzPZfP2LIPvE8A8nUxZXH8MGwYTR/IjT
 T7NNITK51UXVDvjiqNecyyigshx9lmji8iSkg9L1jZUj3bYUzqWi6xwfuhiDHQbGgMAh
 nbaw==
X-Gm-Message-State: AOJu0YxGQWLoVVF/U5HQn9DkmFyGyygjl9dHUNvxIxWaDnCikN2twdkN
 nnNx7da69Q/8R6srAybOQGruLW8dG32ctFxtBx3vbn2igSK0pQd0QXj+7Mts/sZV4zNmgIm+8h/
 okN3aQZXs43zV8WLKkceVHFHZqz4Ej+F8gjJDK1c5kw==
X-Gm-Gg: ASbGnct3+Gnj/yt2u8dkuQLbVxdFDK27chzYJr1AEPxgnRZ84Bx9WNsCUeTD9tkPhbh
 jzTKHSdk2efTrg28TaTqDoK8kwEmIF7FiYGxM8/XSZoAtED7p74GOVd9EcLzjyJlsgOodmKml5M
 3NXHPvnoUHGmvFC7OzCX3HSy8fEsZdV9eufNss0P/hz5v2n6YE50FYs5zeYAaA3qfmoM0FgzBk/
 5IV++3e+1/4rOypVJHF9Yljadr5wVjSo2D3YLGz2tFQMdgV9vyQu3LzCWOZdf5AkkpKrihY
X-Google-Smtp-Source: AGHT+IFxxFj5LYob/JQRaSDxU48AY/P/IUEfSTPsDyVgl2jz9c2E0vPzAFla2I7xTd8AugWvTeAqqdRdbDi4O8VAqAY=
X-Received: by 2002:a05:690e:2555:b0:640:b501:d7dc with SMTP id
 956f58d0204a3-640d45475acmr5635050d50.23.1762769306201; Mon, 10 Nov 2025
 02:08:26 -0800 (PST)
MIME-Version: 1.0
References: <AM9PR04MB8487562AFE05FFEF901244E587C0A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA8wF30KdS=hdr1RfpEcgBA5epXgRXrJ=HvtCr=p8__EGQ@mail.gmail.com>
 <AM9PR04MB84874C7B2D4410AF0E54A5D387CEA@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB84874C7B2D4410AF0E54A5D387CEA@AM9PR04MB8487.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Nov 2025 10:08:14 +0000
X-Gm-Features: AWmQ_bnFr3_1CPHJ933-zuJZBO2S7OVZKcYd9yEAn4cxrdJOpnxIk7_YccKM-sQ
Message-ID: <CAFEAcA--ar0eAGNyiwn85Tdck2ch4U2UhNpPayOyKZ30oQWrxw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation
 Kit) board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 10 Nov 2025 at 04:43, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote=
:
>
> Thanks @Peter Maydell for the guidance. I am splitting this patch into a =
series of patches. I will soon send it across.
> For some reasons, git send-email doesn't seem to work on my official mach=
ine due to some smtp restrictions from IT. I am figuring out a workaround w=
ith the IT dept. so that I can use 'git send-email' itself. Otherwise, I mi=
ght have to resort to another alternative.

Yes, corporate firewalls can be awkward for email patches.
If you can't work something out with your IT dept you might
want to look at the section in our docs about using sourcehut:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-you-canno=
t-send-patch-emails

thanks
-- PMM

