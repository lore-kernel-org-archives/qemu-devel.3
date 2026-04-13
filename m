Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403D5F34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHFH-0007p1-Jc; Mon, 13 Apr 2026 09:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCHFE-0007om-1m
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:22:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCHFA-0006i9-21
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:22:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so41909405e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776086542; x=1776691342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLvLo2XKC0NvOjwJT9iISh66X4JaJ6aNIWQADjHDq68=;
 b=ZLjQ7GmmWGuLMsejY3dxgcQGBULkMGw3+HN7xL2m8sPPyp1jmNJFllikiLhctHnBhN
 lMnIS1n/9gZDI9Vyrz7tP1I+8kPWh6jNjOPnJy9tbk4nWIZdhJ5IxJY1EBkyqpMy5eIe
 mCNytJjD0X199ewaNVlG6AlP1t/gdl7eT06shVeaUytFNuo5wGURVLRCLTj/TEtI5KVb
 ali+Lgtjp9ojwfAOaEtufKnpHpD7eEYfSXMQZFlYoigQTcdae55LzvbBZ4Am501OD/jw
 eJYkB2HjAuy04JgYgiomu6Ju2uqU9OHWTP11B6KSf5dPFKHj2U9HcQeEFr29BCW55l5i
 nJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776086542; x=1776691342;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lLvLo2XKC0NvOjwJT9iISh66X4JaJ6aNIWQADjHDq68=;
 b=Xs36pel0/QzRt2lAFsgVtc+MJCWaGVs3hBO+9k7sqBI4EebvPRfEd/yiFzCTWKloFa
 glznyRkqnMG9sYsEmtvdZxYxNQ4xEMoJKs1Wc0lInCHiFo5Acmn0VY39j4AZ+zbsr4Gi
 O8IATau0PCIe0vJNxg/1NfvMlBxkPHrYPa6SyXM+qOHePCN0htsAYAXiLcEaIZ1E00vn
 mf3MywQUpG9rwKIs4H1lYMITZ9JCqv2/eTLo4P30eAAR1yQF4LNC5kwGR3FJ5YIFXX5t
 3qHz0eTAV4SoDUUfyXndZp7awp40svn1GczIBW+5lonRPdzFkFutvcNBZ2pBfPHojnRD
 7z5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/552fh4wp1vpwxMZWaIRkv7rI5DuwQas6Hrv8ERXeO4aHAeGgM2D82EvKaT0wBnhK3VgXesqD//Ege@nongnu.org
X-Gm-Message-State: AOJu0YwDsSLooNGf4/o60UzAr6ijTOE4v642xxd1p5QtvXfa/CAsBbj7
 V1mYEUCqd4uvrNpsmMMSpEHrQct3wzerFhK4X5wWe1wQ1r6MSJ3YYxKx
X-Gm-Gg: AeBDievU6SrzRA5iYERd1cDn2VDV5/JkvteylkazDY+Y1rzNQS+K93u4hPfmiXThWzU
 qSHA7aqTYGM06dhSWyTYIb7/OMHvvYY6BKHIUM5N5NNJ/Kg9JwUvh95+Gb74EIbLLyEkXQCBDgI
 lIUTe/3NnNxuu76vjE+AQFOCUyS4w8ls9YMYs+OR8l0lcRCAnTx1OROrpRT3ggvKYSNNHY4WZCQ
 v7jW8J577AdM2nM65l8m+AGcZLlwMrdfUMyJJU/6yqPdmVSqbM0HK5lZoZobgp3GIBx9mfcOpfv
 yVaBw852z73+icVVTTVPwvF/cfwjKLJEDqW+2kb3YiLcDLoqzBXYZHR6HeQsGGNJ0+NuuAN0dxE
 A8UBGSGc/8k0D80kOW4T4mnI1AN97ksqYwFF1kMcgu3Goq5aSysehMOoHDU/y2O5fg/owYkhsDt
 O12Y3iiN2WGi8yGW4pd0ivr85PwF+HdvBBuEVudQaouHuFpGQw7/etqAJ6ho+sbK21hUzuUBHdq
 6CX36ZNpUqlgLxBIQwX
X-Received: by 2002:a05:600c:4504:b0:486:fbdb:b718 with SMTP id
 5b1f17b1804b1-488d6868606mr174185805e9.25.1776086541718; 
 Mon, 13 Apr 2026 06:22:21 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d538c03esm298060405e9.13.2026.04.13.06.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 06:22:20 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:22:19 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/7] hw/arm/sabrelite: Add FlexCAN support
In-Reply-To: <D2D2A915-D9EB-40A9-921C-0DB50D4CA810@gmail.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <D2D2A915-D9EB-40A9-921C-0DB50D4CA810@gmail.com>
Message-ID: <3AC8F245-DFEF-4F59-AA27-B4160F5EE02D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 2=2E April 2026 10:02:56 UTC schrieb Bernhard Beschow <shentey@gmail=2E=
com>:
>
>
>Am 19=2E M=C3=A4rz 2026 19:13:07 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <ma=
tyas=2Ebobek@gmail=2Ecom>:
>
>Hi Maty=C3=A1=C5=A1,
>
>>This series adds emulation of the FlexCAN CAN controller, version 2,
>>found in NXP i=2EMX6 series SoCs=2E The controller is integrated into
>>fsl-imx6 and the Sabrelite ARM board=2E
>>
>>The chip has two FlexCAN controllers, but the Linux Sabrelite
>>device tree enables only one by default=2E Linux kernel with both
>>controllers enabled has been tested to work properly (using a custom
>>device tree)=2E
>>See docs/system/devices/can=2Erst for an example of QEMU command line
>>invocation=2E
>>
>>More information about the implementation can be found in my bachelor
>>thesis [1]=2E
>>
>>The headers (struct FlexcanRegs and flexcan_regs=2Eh macros) were copied
>>from the Linux kernel=2E Marc Kleine-Budde is the copyright holder=2E He
>>has been kindly asked to provide consent, to confirm his approval for
>>the inclusion of said header fragments into QEMU=2E
>>
>>Changes from v1:
>>- removed DPRINTF (turned into traces or guest errors)
>>- removed gotos and unnecessary continues
>>- register memory region shortened to actual length w/o padding
>>- make flexcan_* fns private
>>- used DEVICE(s)->canonical_path instead of allocating new strings
>>- changed DEVICE_NATIVE_ENDIAN to DEVICE_LITTLE_ENDIAN
>>- removed ugly USE macro
>>- used enums instead of define sequences in flexcan=2Ec
>>- fixed FlexCAN KConfig conf (fixes build on non-arm-softmmu)
>>- fixed style and other issues from Bernhard's review
>>- better wording in docs
>>- rebased onto latest master
>>- Link to v1: https://lore=2Ekernel=2Eorg/qemu-devel/cover=2E1765826753=
=2Egit=2Ematyas=2Ebobek@gmail=2Ecom
>
>Nice!
>
>>
>>Thanks Bernhard Beschow for the review and his patience=2E
>>I borrowed some fixes from his flexcan branch at [2]=2E
>
>You're welcome to do that!
>
>I'm on reviewing v2=2E Since I'm currently rather busy this will take me =
more time=2E And I want to mention that I'm very much looking forward to ha=
ving CAN support in i=2EMX devices!

I believe I've now given each patch a (conditional) R-b tag -- please let =
me know if I missed something=2E So there is a realistic chance that this s=
eries could be merged in the next iteration!

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>
>>
>>[1] http://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-B=
obek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>>[2] https://github=2Ecom/shentok/qemu/tree/flexcan
>>
>>Maty=C3=A1=C5=A1 Bobek (7):
>>  hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
>>  hw/arm/sabrelite: Introduce class SabreliteMachineState
>>  hw/misc/imx6_ccm: Add PLL3 and CAN clock
>>  hw/net/can/flexcan: NXP FlexCAN core emulation
>>  hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
>>  tests: Add qtests for FlexCAN
>>  docs/arm/sabrelite: Mention FlexCAN support
>>
>> MAINTAINERS                   |    9 +
>> docs/system/arm/sabrelite=2Erst |    1 +
>> docs/system/devices/can=2Erst   |   24 +
>> hw/arm/Kconfig                |    1 +
>> hw/arm/fsl-imx6=2Ec             |   29 +
>> hw/arm/sabrelite=2Ec            |   68 +-
>> hw/misc/imx6_ccm=2Ec            |   24 +
>> hw/misc/trace-events          |    2 +
>> hw/net/Kconfig                |    5 +
>> hw/net/can/flexcan=2Ec          | 1407 ++++++++++++++++++++++++++++++++=
+
>> hw/net/can/flexcan_regs=2Eh     |  193 +++++
>> hw/net/can/meson=2Ebuild        |    1 +
>> hw/net/can/trace-events       |   18 +
>> include/hw/arm/fsl-imx6=2Eh     |    6 +
>> include/hw/misc/imx6_ccm=2Eh    |    4 +
>> include/hw/misc/imx_ccm=2Eh     |    1 +
>> include/hw/net/flexcan=2Eh      |  142 ++++
>> tests/qtest/flexcan-test=2Ec    |  424 ++++++++++
>> tests/qtest/meson=2Ebuild       |    1 +
>> 19 files changed, 2350 insertions(+), 10 deletions(-)
>> create mode 100644 hw/net/can/flexcan=2Ec
>> create mode 100644 hw/net/can/flexcan_regs=2Eh
>> create mode 100644 include/hw/net/flexcan=2Eh
>> create mode 100644 tests/qtest/flexcan-test=2Ec
>>

