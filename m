Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B936CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKK7T-0001v8-2k; Tue, 05 May 2026 14:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wKK72-0001sf-42
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:03:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wKK6r-0005RY-Kz
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:03:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so5080139f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778004183; x=1778608983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCTx84tlBdBwEyORHk4E+U0CrSuvcjYEig/jnRcdvoI=;
 b=XRk/jj2aquR47x7Q4HlVLb9yrgvWpXaBq7Ek041n/hZWlq5LLTyxJhsXad4yYToEob
 uFSTxygAgCe39qKM+UFz55s27len1uUlOFSRaTftUjLvr4WemophYjk83Y0q8/LfcGuK
 6KqHp2vaktEZkQhKb6tQnoiRBJlu6y3qbc77b2f1mjndd6jlvSc9/OnfsnIDVI09pK7R
 ghlnV7sA1vouDx/giYPRCR0u5XH5m+VBYSVNcFgAq3VpKmr4WuRn11MIA5mgTRuO99uV
 cSRmMamopbvxwgf3k6AYXnb94U1IG3Y4WRN0voFQ7JmsIobCDAlGBjOk3gSpIQJ5bUGQ
 G4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778004183; x=1778608983;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dCTx84tlBdBwEyORHk4E+U0CrSuvcjYEig/jnRcdvoI=;
 b=l+GpxrqXUHPzTv3194ogbydVZUgv3gpXrsc8KrjjdBKNK3+/3X6WunEWB/6fUGZ3F2
 RB2pdooHJxQfHO3ZoThOJPi8aME2cAFUdre5PsWAf/pjkOaBmB3FLs1MLWoHqSQvLdJ8
 9jTDtB2r+7lV+fwUrIl8bnS4r0/Xra8i3g8zfkYcENvulLumbccFV13w6TWjO0Fie4x7
 j3jUQUpFtELJMaIeBHqBG1Q8yiv8hbw2nx9Ozy7F9cDQL0uxKsb6/NtHYn/9m/1Bu13V
 3g3syP8H3sKNlch5HuLSwtdMco/4qYCiQsJaPOA+uaSZXbHfplUrvRA5Bbsa2+MwBtyy
 jR5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1GgqIrXF5U1YvRcaXWGtQTI1nZjhOYYKTS9uo6w38TFu1iqooSGVney4PPQ+zJeZn1welcXR4cSjK@nongnu.org
X-Gm-Message-State: AOJu0YzHRbRyliZWoTgNDGo4bbsl2rSlxJNm81ywCfuA+M6EKSmbaln5
 Xemo4c/rGUFov6+uZ2i7g+1aWk0dmIPgs2MTZ4fqL/ehArJbU7WQaR/H
X-Gm-Gg: AeBDieutk7FazxnqzaZGt9iDvEhcn2RamCVZMSSDPX+ylE+Jco8kKY61U5RU/UZ7I1d
 ZdZ9FFhbEWD66cckctQwE8GYWHrNnb1qLYWV6q0DmM6VY3Aydxg63IALGNOTQ2hOTumjzk65CRJ
 n8wQnATPmo/Vj2CMcgY9k+/Nt9/vbJpab1NY190MTwp9SV2VJ9e67uXEs0LPDFzsUHInJHWkPh9
 BzF2KVfoPz6L9FolzB+WOL4bbYNnqGABIRbwxsmnToYxQp2eV0DGTL0j7RZHu+uOz7yLOAj5HcY
 0QHOubwIJT+yZO/k+W+NSwyuccezUrK0t2Xbh+6+ZDayl8wHqM37/QFz2uALFDb5Q+SN2kK71bD
 Z3sod5Ml1c0bylHP2vme86tlIb5rfxoleoNzNvlECJaVv7KyYvu8Fmn43mPaHQL7nnp1g96NTJF
 VsK3rSvhS+PJOyua/+NxN/WqrSzehidkJk9vRt3kQ=
X-Received: by 2002:a05:6000:2910:b0:43f:ea25:20ff with SMTP id
 ffacd0b85a97d-4515d3dc31bmr210955f8f.29.1778004182992; 
 Tue, 05 May 2026 11:03:02 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2203csm6396491f8f.37.2026.05.05.11.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 11:03:01 -0700 (PDT)
Date: Tue, 05 May 2026 18:02:59 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
In-Reply-To: <cover.1777571962.git.matyas.bobek@gmail.com>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
Message-ID: <1B6ED5DC-6808-4A41-B8FA-B2C97C5C8933@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
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



Am 30=2E April 2026 18:26:02 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <matyas=
=2Ebobek@gmail=2Ecom>:
>This series adds emulation of the FlexCAN CAN controller, version 2,
>found in NXP i=2EMX6 series SoCs=2E The controller is integrated into
>fsl-imx6 and the Sabrelite ARM board=2E
>
>The chip has two FlexCAN controllers, but the Linux Sabrelite
>device tree enables only one by default=2E Linux kernel with both
>controllers enabled has been tested to work properly (using a custom
>device tree)=2E
>See docs/system/devices/can=2Erst for an example of QEMU command line
>invocation=2E
>
>More information about the implementation can be found in my bachelor
>thesis [1]=2E
>
>The headers (struct FlexcanRegs and flexcan_regs=2Eh macros) were copied
>from the Linux kernel=2E Marc Kleine-Budde is the copyright holder=2E He
>has been kindly asked to provide consent, to confirm his approval for
>the inclusion of said header fragments into QEMU=2E The approval is still
>pending, hopefully it will be resolved soon=2E I will update the patchset
>on request if another wording/solution for the copyright statement is
>proposed/requested=2E

Tested with imx8mp-evk: https://github=2Ecom/shentok/qemu/commits/imx8mp-f=
lexcan/ which works excellent=2E Next step after this series is merged woul=
d be upstreaming that branch=2E

I guess the only open issue is the licensing of struct FlexcanRegs [1] whi=
ch originates from Linux? How do we proceed here?

Best regards,
Bernhard

[1] https://lore=2Ekernel=2Eorg/qemu-devel/202603211316=2E18181=2Episa@fel=
=2Ecvut=2Ecz/

>
>Changes from v2:
>- moved variable declarations to the top-of-the-block
>- cleanup
>- removed redundant license boilerplate
>- rebased onto latest master
>- Link to v2: https://lore=2Ekernel=2Eorg/qemu-devel/cover=2E1773866323=
=2Egit=2Ematyas=2Ebobek@gmail=2Ecom/
>
>Changes from v1 to v2:
>- removed DPRINTF (turned into traces or guest errors)
>- removed gotos and unnecessary continues
>- register memory region shortened to actual length w/o padding
>- make flexcan_* fns private
>- used DEVICE(s)->canonical_path instead of allocating new strings
>- changed DEVICE_NATIVE_ENDIAN to DEVICE_LITTLE_ENDIAN
>- removed ugly USE macro
>- used enums instead of define sequences in flexcan=2Ec
>- fixed FlexCAN KConfig conf (fixes build on non-arm-softmmu)
>- fixed style and other issues from Bernhard's review
>- better wording in docs
>- rebased onto latest master
>- Link to v1: https://lore=2Ekernel=2Eorg/qemu-devel/cover=2E1765826753=
=2Egit=2Ematyas=2Ebobek@gmail=2Ecom
>
>Thanks Bernhard Beschow for the review and his patience=2E
>I borrowed some fixes from his flexcan branch at [2]=2E
>
>[1] http://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-Bo=
bek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>[2] https://github=2Ecom/shentok/qemu/tree/flexcan
>
>Maty=C3=A1=C5=A1 Bobek (7):
>  hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
>  hw/arm/sabrelite: Introduce class SabreliteMachineState
>  hw/misc/imx6_ccm: Add PLL3 and CAN clock
>  hw/net/can/flexcan: NXP FlexCAN core emulation
>  hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
>  tests: Add qtests for FlexCAN
>  docs/arm/sabrelite: Mention FlexCAN support
>
> MAINTAINERS                   |    9 +
> docs/system/arm/sabrelite=2Erst |    1 +
> docs/system/devices/can=2Erst   |   24 +
> hw/arm/Kconfig                |    1 +
> hw/arm/fsl-imx6=2Ec             |   29 +
> hw/arm/sabrelite=2Ec            |   68 +-
> hw/misc/imx6_ccm=2Ec            |   24 +
> hw/misc/trace-events          |    2 +
> hw/net/Kconfig                |    5 +
> hw/net/can/flexcan=2Ec          | 1395 +++++++++++++++++++++++++++++++++
> hw/net/can/flexcan_regs=2Eh     |  193 +++++
> hw/net/can/meson=2Ebuild        |    1 +
> hw/net/can/trace-events       |   18 +
> include/hw/arm/fsl-imx6=2Eh     |    6 +
> include/hw/misc/imx6_ccm=2Eh    |    4 +
> include/hw/misc/imx_ccm=2Eh     |    1 +
> include/hw/net/flexcan=2Eh      |  139 ++++
> tests/qtest/flexcan-test=2Ec    |  421 ++++++++++
> tests/qtest/meson=2Ebuild       |    1 +
> 19 files changed, 2332 insertions(+), 10 deletions(-)
> create mode 100644 hw/net/can/flexcan=2Ec
> create mode 100644 hw/net/can/flexcan_regs=2Eh
> create mode 100644 include/hw/net/flexcan=2Eh
> create mode 100644 tests/qtest/flexcan-test=2Ec
>

