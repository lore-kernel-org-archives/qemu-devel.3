Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141CFCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKii-0006cp-0O; Tue, 05 May 2026 14:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKig-0006cS-JR
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:42:10 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKid-0004Nd-Oy
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:42:10 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-651b4d09141so261172d50.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 11:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778006526; cv=none;
 d=google.com; s=arc-20240605;
 b=D7L8/JYu0yKl8w/IPB1cf47rz68oW0h4mn7s7e0E5EDKKTeX8UOX48O4D77hMOnO7G
 TFmB7VgCAwT8z6eoVgY2BoJUovqm7XpgKAdZ4SGd84nXIULLM6LWIAAal2ogeuirfBXg
 zG2NHiVmqRqBmHNdpFljcCLhLIibd/YYURFfoseXzblwAcCdxUqOP4JHQU/ldQopHWrP
 +ZJs5yKXbt88pGkKbgVrCkppLPWGwqilDp1lz2/BHv5V8GK1B1DQb/6yTumV71Qz3jzu
 DyI5Rwhck34HAGcbYpDocw1068Wh6Up016+FN55qN67e+IAeVjyPFellWbo4zIfDGkHM
 vR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QhWgxVD87K48Iy1+q5naoIAHxckRFpYt2Sd5qZUK67g=;
 fh=iURSkrg2JWuit73ReLCOvssB3j3U3smJkMMCI2aPwyE=;
 b=HQu1lOP1m5cyWJVngIt2kX1NBoVS36t9T+d3kc5T+yNKREvdfoi4j9RPZN3ElEjLmF
 TKVhcl6PmuFAihWHRagWucH5Ws9HH7HdMtvaiMNNsda0mjLxLzAAk/b8kt4TJ2ED/8zh
 EkIAey1saoVdw7FpJxttu+Bd7ALo3F2eYHvwW3Z84rXT7QGnObSm0pPGwHr+WvAGdOJ2
 nyR2IdCzNw8ZidncvRIkntafrgQq3TZIJpaZjrIlre+aKH6GxJzcAzFeGhcoOxqSw2UP
 UQmZ8f0jfpXWjNU0LJ1X3VP1+pTSKlNgjwLSmjXBA66i2ZzL5mQlykuF90DXpSIZSZFm
 bOyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778006526; x=1778611326; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhWgxVD87K48Iy1+q5naoIAHxckRFpYt2Sd5qZUK67g=;
 b=k7eXQ3Xzs8RjBatDpFA32yi9W6dQFvIS0LyCa41dct0iyU0CZU0W/Mq9qwvZy4CapS
 Q/GN+k5vctH0hk85gGk94Q8v/RbYGZSzgWdwCdwM3SryRcC372B6aUugaotbyUk88Ulx
 lZzqe6EuoR7sN5HAPx1bL5cOZHAhSTixHeqcs8yndOzoLbf/K8SQNIvvcDjrl4mfkgui
 FTb8j2A/V+m0aS6a8FA4EkfOytNc/btMWQNpoSkmaG9Af5+FtffUSl8BfycbA+cmb718
 onju4Ah872RuxLoDiTTDo8j9D4zJuNcwmE9u4GB2EKlWV1iv1J1l9NWwEOYvYRKBDaQM
 HYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778006526; x=1778611326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhWgxVD87K48Iy1+q5naoIAHxckRFpYt2Sd5qZUK67g=;
 b=gRiH88na+z6tv109dRS79oZS92mZWO9q2n/FKN2VRbKdZsGv172deShKJ/knLYHioc
 UShrVr/ySqRM+mO3JPPs6Ikb0R+jdAo9fJdaBB7SZMK2yUHrNFoO9qLq3C0vHPu3ELln
 kFc94TiiCpu/RG54bcn6Z10obNFXAcHLK3XlhG9NIr8uI0olaAKu09VvzG6yfOdSEf/P
 nlYSX024cvcduHPXIyYJh9ZtKEZF+UHBL6Btjlm/dI7ZXb563zfLPfpOWMDrJkIWIyPK
 UeQwT4Wgzjkaoo95MCipNO3gM0R1K1l0ir5JEsCaiYeSQwMLRexPLG/DwoQTkuMZh/Y1
 oTUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9p/3RgyxzRSvfXz53lVB2Mno7thCV+rXJmCcxUstYxqGUbyNTiqoIp/UEpo+fW+6TpqbNpWD6+Ra4N@nongnu.org
X-Gm-Message-State: AOJu0Yw2OYSAEqBS4zgXt9h2RqYYpaO89V2XVSJDvnJEf7v/bTkDcxx5
 vgXCLLtyhbjlyqLGzOmVoBRdevVuqUpemaxHNzJGucI0veAHP+DttFGw6BV+t76PYWS+T9EYd/c
 gudeZjWyYb1PyTl8OsPnsY2F7ENs4PmbryFwXrKqo6A==
X-Gm-Gg: AeBDieuG2PgPXdk5pX8AcToDi5G7CAOUG8lCiL0RVtRhFajHX5z6vTaVG9hwBgI/Kef
 3nbHA19t73A/78xkY0Zvj6d1CQD73zYBpgnBIbdu70NLFipXRSd4hob078Nz+ONeZqNcJa2fWwC
 z/quTKQHlJEOkkvfXzaLwGV887Wmd1vpBKTcwuq2qaQqrieJFE7JkaKR/ZTWV8WGOpQ2I+1d3eW
 cDlwIvy7c+50V3Dum0VJsn3WPoWgDB8L/O52Ier/j4d/GQxOGdTO+Z65uNBWlRQ5/yg00iwmzjs
 M63Jh40gMrGmZUDawLiNFKpMISags+668tW4A1ppte++5GxqXDRyPPDufjgITVt39F6ec6QxlIG
 lHQ==
X-Received: by 2002:a05:690e:169d:b0:65c:7492:9d5c with SMTP id
 956f58d0204a3-65c7492a244mr1746285d50.28.1778006526107; Tue, 05 May 2026
 11:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <1B6ED5DC-6808-4A41-B8FA-B2C97C5C8933@gmail.com>
In-Reply-To: <1B6ED5DC-6808-4A41-B8FA-B2C97C5C8933@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 19:41:52 +0100
X-Gm-Features: AVHnY4Jd62kNEZX-JTP15GNvAtu-L-pBRSl-sg6WFwHKHP2gqGOamvQZiBnUW9Q
Message-ID: <CAFEAcA9kQNdx=gwSd_Ec=R2nwegT1R-BEiC9yXvfr23VJHDZiA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
To: Bernhard Beschow <shentey@gmail.com>
Cc: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>, 
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, 
 qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 5 May 2026 at 19:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 30. April 2026 18:26:02 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <matyas.b=
obek@gmail.com>:
> >This series adds emulation of the FlexCAN CAN controller, version 2,
> >found in NXP i.MX6 series SoCs. The controller is integrated into
> >fsl-imx6 and the Sabrelite ARM board.
> >
> >The chip has two FlexCAN controllers, but the Linux Sabrelite
> >device tree enables only one by default. Linux kernel with both
> >controllers enabled has been tested to work properly (using a custom
> >device tree).
> >See docs/system/devices/can.rst for an example of QEMU command line
> >invocation.
> >
> >More information about the implementation can be found in my bachelor
> >thesis [1].
> >
> >The headers (struct FlexcanRegs and flexcan_regs.h macros) were copied
> >from the Linux kernel. Marc Kleine-Budde is the copyright holder. He
> >has been kindly asked to provide consent, to confirm his approval for
> >the inclusion of said header fragments into QEMU. The approval is still
> >pending, hopefully it will be resolved soon. I will update the patchset
> >on request if another wording/solution for the copyright statement is
> >proposed/requested.
>
> Tested with imx8mp-evk: https://github.com/shentok/qemu/commits/imx8mp-fl=
excan/ which works excellent. Next step after this series is merged would b=
e upstreaming that branch.
>
> I guess the only open issue is the licensing of struct FlexcanRegs [1] wh=
ich originates from Linux? How do we proceed here?
>
> Best regards,
> Bernhard
>
> [1] https://lore.kernel.org/qemu-devel/202603211316.18181.pisa@fel.cvut.c=
z/

Could you say what the problem is? In general there is no problem
with taking header structs from the Linux kernel, as they are
GPL-2-only and that is a QEMU-compatible license. The relevant
source files or pieces of source files would need to be noted
as 2-only rather than our default of 2-or-later, but that is
doable -- we already do that for other things we have borrowed
from the kernel.

thanks
-- PMM

