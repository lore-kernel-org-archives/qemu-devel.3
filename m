Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B885FD711C8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 23:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWNaM-000174-Ts; Thu, 18 Dec 2025 18:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vWNaL-00016o-62
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 18:39:05 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vWNaI-0007Rl-Qf
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 18:39:04 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so74867266b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766101141; x=1766705941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2HEHuJUo/i2MG8kDnCf84RXxS7jcr6/Oai12kIGuAo=;
 b=UEiPkmmzznOIHfaoBD5BhlWgkHoD7Ymunxh8SN5TQbuQyg6ZOJJMscc95c1V8GXBPs
 s3LdEV8lIJwOo3fhsq5mNMmGfS+nXLjA/vnnZQVaRAxA8usNlI2UuMYSQdYYIL8/cRlA
 kbamqlRlnkb8O6NCXOKLjcFL5+qqGmfy1ctNB3h3WS4QjZT1mOh0rOhIgvh+5WBbAEEX
 ZVskE7uLtAsb0xFtb9uuVDQjmXuO7KyWzdWRpCe/ec2eMMWu7X3VSbWH3pLiYqZyU+rr
 sqP8o0FmiSKiaTxm5AZYRSGL64o9Biglx+oqmDF3elLtPYiXtvMgkm06IhDP6RFxF7LY
 UHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766101141; x=1766705941;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q2HEHuJUo/i2MG8kDnCf84RXxS7jcr6/Oai12kIGuAo=;
 b=GqnvzOijdsHXPgejwOxh+SoMfeuvSa2QQrYXqjWqQhJNGrxg97XALckEwKMLOq6tHn
 vfrGHOn0Td0+lllGMAZKgDh5wYlKIHOGUJ35QcatqWRl8SeySMfl+vma30GmDEROPJ3J
 h0u9QP9b4Qv3AwPwZ7MuuRD0CFzrq5eEEntUcn2cOv7K/puSLd8GkTIZTH8F3Z5Afj4E
 TncwOvvE3vThRNB4nXmviSpZD+Ph/TG6dCM4+3d3sQgPDbCg1XwFY6tevyPxe08hLadN
 w15abHjARIGBfZ7oPJI4x2DlR/t+c4nbHy/yF1LM0xq6VaRJZNKMFYAFw1hxu6Z20WnN
 141A==
X-Gm-Message-State: AOJu0Yws0z9qAxLkWI+tulW9nV6pj60i3HdPYoGW2Uxc6f9E8db9Fhht
 w9An/cW7O4t+zyyCxvDXLYU/3EVcAUyI9nnxf03sCLUVbqqrZCaSfdaS
X-Gm-Gg: AY/fxX5BjHhTRg0vPgO1gl77p1Nsy0wTeste3f6OS5MxGTjwVsvWZ/Yh/DzNIbGq+i5
 ASzoZth5pIUDGeGuTGkvN7hOucgxbTuRZtHzR2ztsQre9RGjVmqJ23ybBU6q17+zJMRsHYqHi5c
 8GLPUR5CJ2IfcBXtCTPLNBMKR9N/WWn5aHBoAbgEY7IBQhamaMnatbVmtqxOxgdfz50pRwx3V7O
 mjYdyiLnbHQaXWcXdtOKkAt8XspRgj9iSmuA7x4iAt51KCkmwNqAJl3eXxfVggSgnndkixMm/X1
 uFPwTybz1fAWrQ0x+v5NPNUraBQieQVm2PFAyAfRD3HOC2YJ36Dmx2Oh3fT1GBxdEGT3GoUeGdO
 enkG23oNDb48R159smhy1P75nPT2c9pn7dm6VeMgeo6sts2k5MLuimiIjDT9PvZSJJoFvo676hH
 PO+t5PqdGIdjhO+rddXviyy1yWbKvtfsY0TkJDZVGkXKoidqpgJFAplbeRTIxwKhugnf+GvQ==
X-Google-Smtp-Source: AGHT+IHkFJNpW0PFf+Dok3vj2IPew1D3zoWSKIt9MPUK+raSe2BrRgwDww1fVXBe4aRbir+fhUBCpA==
X-Received: by 2002:a17:907:980a:b0:b76:d880:e70b with SMTP id
 a640c23a62f3a-b80371d5006mr111445866b.55.1766101140728; 
 Thu, 18 Dec 2025 15:39:00 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-077-011-003-230.77.11.pool.telefonica.de. [77.11.3.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f48606sm66028166b.62.2025.12.18.15.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 15:39:00 -0800 (PST)
Date: Thu, 18 Dec 2025 23:38:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Pavel Pisa <pisa@fel.cvut.cz>,
 =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>
CC: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 0/6] hw/arm/sabrelite: Add FlexCAN support
In-Reply-To: <202512160144.54648.pisa@fel.cvut.cz>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <202512160144.54648.pisa@fel.cvut.cz>
Message-ID: <4BBA8CE7-A166-4358-B608-B990DF32F55C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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



Am 16=2E Dezember 2025 00:44:54 UTC schrieb Pavel Pisa <pisa@fel=2Ecvut=2E=
cz>:
>Dear Matyas Bobek and Bernhard Beschow,
>
>On Monday 15 of December 2025 21:03:09 Maty=C3=A1=C5=A1 Bobek wrote:
>> This series adds emulation of the FlexCAN CAN controller, version 2,
>> found in NXP i=2EMX6 series SoCs=2E The controller is integrated into
>> fsl-imx6 and the Sabrelite ARM board=2E
>
>First, thanks a lot to Matyas Bobek for finding the courage
>and sending the FlexCAN series, finally, after keeping it updated
>log time on his flexcan-series-XXX branches at his personal
>QEMU development repository
>
>  https://gitlab=2Efel=2Ecvut=2Ecz/bobekmat/qemu-flexcan/-/branches
>
>Bernhard Beschow, thanks for expressing interrest in the project=2E
>Your intererst helped Matyas Bobek to collect courage to send=2E

Nice! Yeah, contributing to an OSS project can be intimidating at first=2E=
 But seeing one's work accepted is encuraging which is the real beauty of O=
SS=2E

>I have found that you have invested a lot in the CAN on
>your imx8mp-flexcan and can-cleanup branches, thanks again
>
>  https://github=2Ecom/shentok/qemu/branches
>
>It is shame that long delay in sending of patches has
>lead to some divergence of the effort=2E
>
>I have gone through your changes and would be happy if the
>effort can be joined and integrated into mainline=2E
>
>I would prefer to help Matyas Bobek's series to be updated
>in state that it passes review and then the FlexCAN
>can be moved forward by you and others=2E
>
>In long term, the extension to support FlexCAN3 would
>be very usesfull=2E But that that is work for other thesis,
>GSoC and or company funded project or developers=2E
>I would be happy to provide my knowledge as the time
>allows or look for students, etc=2E

Well, the imx8mp-flexcan branch is a moving target and currently exists as=
 a proof of concept=2E Once this series is merged, I would like to integrat=
e this series' FlexCAN functionality into imx8mp, even if the real controll=
er has more features=2E So this branch just allows me to look into the futu=
re which helps my review=2E

>
>As for the series and your (Bernhard Beschow) changes:

Let's keep the discussion on the list=2E While there is some truth to my b=
ranches I'd prefer to stick to the review process and only discuss topics r=
aised here=2E I'll provide my feedback as soon as I find time for it=2E

Best regards,
Bernhard

>
>I have seen that you suggest some reordering of some
>functions in the hw/net/can/flexcan=2Ec file=2E If you think
>that it is the better, more readable order for QEMU developers,
>I would suggest and have plea to Matyas Bobek to proceed
>with reorder=2E Same with tracepoints and debug prints
>which could be updated into state that your or others
>follow-up patches would not cause massive code movement
>which complicates tracking and reading of the changes=2E
>
>On the other hand, I have some arguments against unification
>of memory FlexCAN access function and inlining register accesses
>into them=2E We have already discused with Matyas Bobek that
>for FlexCAN3 and other future changes it would worth to
>separate registers from memory part etc=2E So I would kept
>this separation=2E Making as much as possible of the core
>opaque for its external use is right from my view point
>on the other hand=2E
>
>As for the CAN core changes, again there are some which
>I see as good moves, some cleanup of long term unused original
>structures which have been planned for another integration
>into QEMU before simplification to pass review etc=2E On the other
>hand, I would keep client state without const and with destructors
>etc=2E Again, actual code is somehow usable in its actual form,
>but from the long term perspective, I see the need for
>back-pressure propagation, emulation of the highest priority
>message (the lowest ID) exchange the first, etc=2E and I have some
>plans for that=2E I do not think that CAN emulation is and will
>be some real performance bottleneck in QEMU use for embedded
>systems development so I would like to keep there space
>for future more precise emulation=2E
>
>Same with reset on the chip core level, I think that its
>redundant call does not cause any performance problems,
>but I would be happy if the controller codes are reusable
>for wide scenarios=2E I have written and used LinCAN with
>such controllers at time of ISA bus on PC=2E I would be happy if
>we have mechanism how to map them on SoCs with FPGAs=2E
>Unfortunately this valid and very usesfull feature
>
>(
>for example for our RTEMS effort on Zynq
>  https://docs=2Ertems=2Eorg/docs/main/bsp-howto/can=2Ehtml
>and ideally even on PolarFire (as time allows) where even NuttX
>can be tested and CI run
>  https://github=2Ecom/apache/nuttx/tree/master/drivers/can
>)
>
>hit concrete wall in May, without any suggestion how to
>make that needed use of QEMU for CI acceptable=2E =20
>
>But our SJA1000 code is already used by Espressif in their
>QEMU fork
>  https://github=2Ecom/espressif/qemu/tree/esp-develop/hw/net/can
>so there is more proven use out of PCI based cards=2E CTU CAN FD
>is used mostly on FPGAs but here are MCUs with it so again,
>even if the usability of mainline QEMU for FPGA development
>would stay blocked, there are standard, hopefully non problematic,
>regular machine code initiated uses of the CAN controllers
>which are part of QEMU=2E
>
>So I would be happy if we can thought about that wider use
>to check that it would not be more problematic in future
>if some code is optimized=2E
>
>On the other hand, it is right that even in esp32_twai=2Ec
>case, the integration is based on RESETTABLE_CLASS
>and esp32_twai_reset() calls can_sja_hardware_reset()
>explicitly=2E So can_sja_hardware_reset() during can_sja_init()
>is not strictly necessary=2E
>
>Back to sabrelite FlexCAN support series=2E
>In general I agree with the patch series and I have
>consulted and reviewed it multiple times=2E
>So it can be considered to be approved by me
>that it is functionally OK as well as it respects
>copyright requirements etc=2E I add my
>
>Signed-off-by: Pavel Pisa <pisa@fel=2Ecvut=2Ecz>
>
>As for individual formatting and may be some debug prints,
>I would allow it to go in in its actual form and then reduce
>these latter that we have state with more, may it be even
>abundant, debug in mainline recorded=2E But I expect that
>there could be more request for style and details from
>more experienced QEMU developers=2E
>
>There is one unresolved patch check report about
>DEVICE_NATIVE_ENDIAN
>
>+static const struct MemoryRegionOps flexcan_ops =3D {
>+    =2Eread =3D flexcan_mem_read,
>+    =2Ewrite =3D flexcan_mem_write,
>+    =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
>+    =2Evalid =3D {
>+        =2Emin_access_size =3D 1,
>+        =2Emax_access_size =3D 4,
>+        =2Eunaligned =3D true,
>+        =2Eaccepts =3D flexcan_mem_accepts
>+    },
>+    =2Eimpl =3D {
>+        =2Emin_access_size =3D 4,
>+        =2Emax_access_size =3D 4,
>+        =2Eunaligned =3D false
>+    },
>+};
>
>But I do not know what I can suggest there=2E The device is
>infernally accessed by 32-bits words and should be
>mapped in native format because same core is used
>on little-endian and may it be even bi-endian ARMs[*1]
>and for sure on big-endian PowerPCs=2E We believe that
>native endianness with host is the best option in this
>case=2E Extending =2Evalid=2Emax_access_size to 8 is right
>and probably require for 64-bit targets as I understand
>from your patches=2E
>
>[*1] as I have used bi-endian ARMs they mapped peripherals
>often native way on 32-bit entities=2E So again, fixed
>DEVICE_BIG_ENDIAN or DEVICE_LITTLE_ENDIAN is incorrect
>in such case=2E
>
>Best wishes,
>
>                Pavel
>
>                Pavel Pisa
>    phone:      +420 603531357
>    e-mail:     pisa@cmp=2Efelk=2Ecvut=2Ecz
>    Department of Control Engineering FEE CVUT
>    Karlovo namesti 13, 121 35, Prague 2
>    university: http://control=2Efel=2Ecvut=2Ecz/
>    personal:   http://cmp=2Efelk=2Ecvut=2Ecz/~pisa
>    social:     https://social=2Ekernel=2Eorg/ppisa
>    projects:   https://www=2Eopenhub=2Enet/accounts/ppisa
>    CAN related:http://canbus=2Epages=2Efel=2Ecvut=2Ecz/
>    RISC-V education: https://comparch=2Eedu=2Ecvut=2Ecz/
>    Open Technologies Research Education and Exchange Services
>    https://gitlab=2Efel=2Ecvut=2Ecz/otrees/org/-/wikis/home

