Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463FCC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbMW-0002tH-VY; Tue, 15 Jul 2025 04:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubbMS-0002sD-CY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:50:04 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubbMP-0007PR-Q1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:50:04 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-713fba639f3so44187487b3.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752569398; x=1753174198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADiRvGYzzEhAcuiJ1XF1le/I69A10VHO1TIlD6EBLks=;
 b=i5nVFeH0x6CMyJlgRcdroyVkgY8gONQFFQu/tnyO9pPAIVvWmm2a/Pzman6YEz5H4Q
 JbVft89X+7Y4emFguFNd0auiwdDkN5Gy/wOOyy+b7/sfkSpOdqylUYesWi+gVMkyC2Tv
 lh3MDZxYOPjet5T4UcVjR04vIwV9kWOrY5Jr6siNbJKsFrOkEqjoMmsQelANWHFRGJMc
 Y2SfJOd9xdsuE4/f2ic5mpOD3R0+vKVoDcBB+ApsfU0hLt1RFrkpVL1E2CFHO4IA0d4S
 IoohNlI5AH+Qoj34Y/y1DCxD515FinWn9OXesIdBsMC5XLwpySbRRYT8zpl9A2yVa4c4
 m/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569398; x=1753174198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADiRvGYzzEhAcuiJ1XF1le/I69A10VHO1TIlD6EBLks=;
 b=iJH3QGF/z6Zo/W4J89ZPHSWVAdK7DBu1esrHNKVTY1VOwniQAeXvV/dx83BF/tJEQY
 ECKAMc+nMdKC14DIxeDy+oPJFcEwKq4Pr/f4hNUHhjbkEr9M/kWcprCtGmSPqZzWYehF
 475nBpEJT66HO55LXCO2tyZ6ti+yxE6suT+M5pqtDIclnGX+CML/37qlaYMbyAOzZqvU
 op0xnZ4Y1aq4EJ/Qp/0ij2NXXOyoLFW/s7/qwLNNdKhW1g+QSbjsphgw7VQEKUOfnW34
 TAIMsZ4nGBgc/YoaiOytYAyDrTAUbPSFuxEE9f9nLCVPvNyPhWwkigzUwI5yyvUBuHXr
 YBGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXXdRS+Orvd3lFQrgjqVGIxIz66N0V7V/IipjQo5O4n1i8IYseorZHdzjX+sseG/59tv/Qy7ETGMRX@nongnu.org
X-Gm-Message-State: AOJu0YzItZYoIeV6fYi2qldJxAa3472ZwkEHojgJXy6cuxwqdbEY6Rhr
 OD51YzXOTL8bNDQLgcmWMnl3yjbq5/RNI778DbumrgrhsvMqN31R2K+abS6iJflubHp4/VQFiqD
 X1R2t+rGHsU4J4bSYmTO8S0OKWr9p18gPkVkXXw5w6Q==
X-Gm-Gg: ASbGncunaxHztz2TJGxNzYnYPVS1M1NpzHZ8PFBtle2R195jQsu8xELzWtvN7ZP0+VO
 0ue9Ew59qpZTCPwTR6i9M31MtkJxrKUrpAFfIcC316C++Z1y2EKkNwynbYInvStPfv2cbBUzxYb
 Tu8Nr0iS+lG1saeUv5OzC3FN48KgwjUT41osRw2W74ipbMr7I1OppL9e+z4h50bdQIeOUKuLR6m
 a59Cth6
X-Google-Smtp-Source: AGHT+IHGB8KfHI/BhUJiEO++JoBT5qYeK1akm58kpL1f108Njyz/2cR176lir0ZkPsb6tB/vQe9J5OgI0L80FX3kMHQ=
X-Received: by 2002:a05:690c:fc9:b0:711:406f:7735 with SMTP id
 00721157ae682-717d5d7b900mr272601947b3.13.1752569397904; Tue, 15 Jul 2025
 01:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250704083723.1410455-1-clg@redhat.com>
 <20250704083723.1410455-10-clg@redhat.com>
 <CAFEAcA9-wpDS2_4paQgswqB=NfgxadvGB8WULWGqQXV7d47-Mg@mail.gmail.com>
 <7f8f262f-3490-4588-82b5-20b6af340f45@redhat.com>
In-Reply-To: <7f8f262f-3490-4588-82b5-20b6af340f45@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jul 2025 09:49:45 +0100
X-Gm-Features: Ac12FXzLRvWsXvKNu3CqweqxRtfPu1H8T5Wh1wngDEaglCJcaHONOrjo39JpnWI
Message-ID: <CAFEAcA-9aQs+gEK5y5A=YwJCzNYpbEy6UmhO+1=AhqaaLum9bQ@mail.gmail.com>
Subject: Re: [PULL 09/11] docs: add support for gb200-bmc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ed Tanous <etanous@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 15 Jul 2025 at 07:13, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 7/11/25 14:01, Peter Maydell wrote:
> > On Fri, 4 Jul 2025 at 09:39, C=C3=A9dric Le Goater <clg@redhat.com> wro=
te:
> >>
> >> From: Ed Tanous <etanous@nvidia.com>
> >>
> >> This patch updates the docs for support of gb200-bmc.
> >>
> >> Signed-off-by: Ed Tanous <etanous@nvidia.com>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >> Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-3-etan=
ous@nvidia.com
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >> ---
> >>   docs/system/arm/aspeed.rst | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> >> index 43d27d83cb54..bec0a1dfa8b8 100644
> >> --- a/docs/system/arm/aspeed.rst
> >> +++ b/docs/system/arm/aspeed.rst
> >> @@ -1,5 +1,4 @@
> >> -Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb=
``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g22=
0a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, =
``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, =
``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``withe=
rspoon-bmc``, ``yosemitev2-bmc``)
> >> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb=
``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5=
280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qco=
m-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``=
sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogap=
ass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
> >
> > Hi. This change removed the "=3D=3D=3D=3D=3D=3D" underlining from the t=
itle, which
> > has broken the rendering not just of this page but also of the list of
> > arm boards in the parent doc:
>
> Oh. I missed that. Sorry.
>
> May be we should reduce the line by removing the machine names ?
>
>    Aspeed family boards
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> or is there a specific reason to keep them ?

We want all the machine names so that they appear in the
table-of-contents in system/target-arm.rst -- readers of
the documentation may be searching for their machine by
the name they use on the command line, and not necessarily
know whether it is "Aspeed family" or not.

thanks
-- PMM

