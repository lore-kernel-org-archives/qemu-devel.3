Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADFCCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vh7-0006we-P1; Tue, 30 Sep 2025 04:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yulei.sh@bytedance.com>)
 id 1v3Vgy-0006ou-7F
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:26:37 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yulei.sh@bytedance.com>)
 id 1v3Vgi-0002Og-42
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:26:35 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b346142c74aso1082926566b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1759220770; x=1759825570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6GLUUkgLvDZ+Tm+Pc+6u0FXUZ1AzZzv78+xXdVWMaE=;
 b=S7jOANxsly1yfeQ7rCGfngo3SItNS95cDVtgSbwO7c5D60ehhOMzenvp5MM6bG7cin
 DO8TyxC75cUoTiUstdxP7607K1LujJ+n95ZrIENIxzkqLuG0i9Zl87rZA2XXbf0cFhwi
 O6xrBBYD3XkGbfySOzZR/he3pQrP66vtV0g5x+0z6a1Ltpeqk4fe8VQKvoSsVsrwUd5d
 S4eJEEua8C3CxYW1jbqSsc++u51FPM6PgIaYMoIcbTiB+DiFt4dKr4QlfIzPhcAwMN87
 4jkttVKlHM1w6/bEHjFbxLWOHiEveQqbssD3/YNnYdLDkS8ReM1a5ilKgiLYfi1WZ5oJ
 hO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220770; x=1759825570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6GLUUkgLvDZ+Tm+Pc+6u0FXUZ1AzZzv78+xXdVWMaE=;
 b=D1Xmh/tP8LiUYQ60jQ2sBV5VdJ65R2Xg5JMetFtHnIsv94/DoalbEzJkVG3WaTSWIR
 Qkh71J3+UU9FdU22cMZL5MLHR6xxeU6iMjUbMQrls44r+xLj6kcihZBxEgTOLLkMMyDE
 pcNmcr32WGED0crld/acTBCgOvdRAp9SnHCsAAX8Iab8iCiC/ErljaxO+bUvoZlGAV+Y
 RtU+W6KqosNwNDTUvfKhkf39syXR9E2X6gG9dNQZ1V8RTZd/TzbFKhWf+RqYGoYQtFKs
 4MuP4EHqxPbKP+nJzIhxw6C6hVQj2UAIJmg5w5GMBHuQYmtYSm6E8kixAqLf4bXsnTiq
 VHAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03QV1nQMLLIwuJs+NlMAYOAkD14VgRi0/3OhYdYgcRH+aAk3glSp2RL1k5CJkNVgGm96FBDgLlPnc@nongnu.org
X-Gm-Message-State: AOJu0YwWBj4d131OWi6KC9GHCnqMWNJfSUnxS/Ts+nmJdR31n0GgOccs
 cjEQdulORCHpF29Qmq02WnNYWlnzEVZTf9HbwwTvLhWUuCDheNe2/gFSjhlzpbccU68YSwLOh1D
 C4MyH1qoIkZw362oSJ6AWjVNbD3nvoZMsYCz/yCTU0w==
X-Gm-Gg: ASbGncuteWOF7v5WRKcN8owZ5p8+UgRKT/AGiUCZf7xNnGZ+xvM9OXcfMcJgjPrw3QE
 xg/KHoiV5IBX9k2tqA4O9WS4z6ZA7/iO0pMpuMeeSuyrAI95cgQhV0ck6eIvQawbMBjl5/KVr1m
 g+wT8Q41WYhwZ7InU+rJLq/Ny07pHXYbxAvvBOD/oqOINVq86y1avmNW98c3cAd2r0fYqXw0kV1
 of7XEQ1nd42zXSQFr+rDpVDFy4Q2FS8Q36IskLkQ41di0lWYZZKxnQlZOY=
X-Google-Smtp-Source: AGHT+IGaeyXCfToQvvO95i2F+nQ5XV5jW8f7rXJ+cTi870Y05+C9YKmJi7ekmrSHw5jXrLvFg8EnXYgQb2MLJAYi32g=
X-Received: by 2002:a17:907:98a:b0:b2b:59b5:ae38 with SMTP id
 a640c23a62f3a-b34ba545629mr2573260766b.40.1759220770056; Tue, 30 Sep 2025
 01:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201025131435.144-1-wangzhiqiang.bj@bytedance.com>
 <20201025131435.144-2-wangzhiqiang.bj@bytedance.com>
 <a3e42923-d81a-40c2-8b17-28d6264d5518@kaod.org>
 <CAGm54UE3D_gd8=iDMkF+nPUqZN5-Mhp-46HONi3Ok6oEkdyDwA@mail.gmail.com>
 <3c61d5e6-e571-40a1-a770-7e9d2f53a189@kaod.org>
In-Reply-To: <3c61d5e6-e571-40a1-a770-7e9d2f53a189@kaod.org>
From: Lei Yu <yulei.sh@bytedance.com>
Date: Tue, 30 Sep 2025 16:25:58 +0800
X-Gm-Features: AS18NWBAFRRzYF4PfjF8d3_IeIAplsh2iau0SU6iGLz1gJ7IO-KwZcVpajPcrx4
Message-ID: <CAGm54UFhhh1DtKkm+X_g4NFUTqSN_f3CF4w4-FnuuouVk7rVMw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/2] aspeed: Add support for the
 g220a-bmc board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, 
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 =?UTF-8?B?5byg5YGl?= <zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=yulei.sh@bytedance.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 4:21=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> Hello,
>
> On 9/30/25 10:13, Lei Yu wrote:
> > On Tue, Sep 30, 2025 at 1:57=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod=
.org> wrote:
> >>
> >> On 10/25/20 14:14, John Wang wrote:
> >>> G220A is a 2 socket x86 motherboard supported by OpenBMC.
> >>> Strapping configuration was obtained from hardware.
> >>>
> >>> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> >>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> >>
> >> Hello John
> >>
> >> Would it be possible to contribute a functional test for this
> >> machine ?
> >>
> >> Since this machine contributes little to the Aspeed models,
> >> its value lies in the firmware it can run to exercise the
> >> models. Without functional tests, I plan to schedule the
> >> removal in the QEMU 10.2 cycle.
> >>
> >
> > This model is used in the QEMU CI for g220a in our internal CI.
>
> Good to know !
>
> > May I ask what exactly are expected to do "to contribute a functional t=
est"?
>
> It's a small python test downloading a FW image and booting
> the machine, possibly also testing that expected services are
> up and running, network, I2C devices, etc. This last part is
> optional.
>
> See the test_aspeed_*.py files under :
>
>    https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional/ar=
m?ref_type=3Dheads
>
> test_aspeed_bletchley.py is minimum
> test_aspeed_ast2600.py is complex
>

Got it. We will submit the functional test script for g220a.

> Thanks,
>
> C.
>
>

