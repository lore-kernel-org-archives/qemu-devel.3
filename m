Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B56BCD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 22:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTp0c-0005LF-VZ; Sun, 31 May 2026 18:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wTp0b-0005L2-PY
 for qemu-devel@nongnu.org; Sun, 31 May 2026 18:51:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wTp0a-0002Du-18
 for qemu-devel@nongnu.org; Sun, 31 May 2026 18:51:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so1263263f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780267910; x=1780872710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVD8pp94OInapvhizfEjV8BMP7eAhx3/9Ah5xRZ7yB8=;
 b=WbkGS/6h6UpF3yik1IL7XvNq4at8nveqnQD12ZCxgF2dhVDpag40kZfL8la5ZmPNkd
 JdvTKoq3WvLhYYSL4TssM6b630fkRn4CcHsForwnqrO/z8GBgOzmeIb1bUGQ66RvUdRX
 VxAQ9nxsma4A/lKoqxA16BLYm+yYJQxNH/SHAKfL1/eaFLMjxO/Gslw71pyj2oa8h7si
 p9zm8hXL9TNJ5kHt0mduiW1Hfj3ukFYmspDcuEBbU3FKI4NIedTQHMfA7wTkZiynH/Jo
 L8dXvQgkI6QTjseBlFDCILPw/SFtnIA8Ic0RzwO0kom56uuHS3qWeYY+quNRQ4kMpE6D
 wHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780267910; x=1780872710;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tVD8pp94OInapvhizfEjV8BMP7eAhx3/9Ah5xRZ7yB8=;
 b=gvKe4gDeQdJSh489YqBIxusdpk0YVp1+TvJMZNLT/jeE+coeYujsGfttpXOorWQji+
 jJMD17zeGnpISupNwNFLCKXMlO4PXWvaxGZwaxTLdaMvNkSVu1b8o8O5RrbFxVbYi9Wy
 +EXKoCd5struPSuVgr/V47/bPKtRFlYUxQa1oZf3+u0BeXypkhBxPQqZlimZhONQQMiV
 ree0WtKW2RCXXTjHP5maO2j1P1YePglvue5W7dV9mF8qnNlJtRRryqHg/iaudRePjKIm
 B5jVVfdSutbDlGUUFgX3GQI5x7Y0sjxXZn8F774+6cqgQxkUYs0ZUtyHYolWDwtZmZ9E
 TSOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UvRdMorhT5kf/QF9CZLM8j3rvnKctv6SyXChNDZa8d/j4/Lb3VYxZWqW5dZNhi1YAgCd7iMvARgzi@nongnu.org
X-Gm-Message-State: AOJu0YyOLjxr0C/EoOjYePKPKpbNcGQgN9JUjc8sG1mMOUw1+4pUFlyJ
 2GncKZS+tSBIV9o1tnZhaTRhejHavBaZSIMfnxB2TphmTMH/qb+I7aYp
X-Gm-Gg: Acq92OEUwRTtnGwpgpX6CsHjiohuUDarHvYfMt/ssVxMjUAxwypJ0IoAIpm4Jg6nY6I
 b/ZjSuZej/PoqVfWXpjQrFG5W1KbLTDw8gOwc3WtCODnPDZefyo7rCV9QGb28RQjMS8LAzhhZRg
 DW1rz3ccJCAe2gjgBaicCwKMeUUnKC2yst06zXYrYa5PUnihDnQLo3+/kfn+43Rnf9/kgfCXUYJ
 ep60sCdfwt+/S3NEjfW13kiSJxz76ipEn56zvIcezqWIw49Lh2fPO5gv2OudKZMFETG43ktkT3y
 NNb7nggpYjeRtcGjx7PF2AuF9eE8BYnQBKL4M/yMAdkXZsOeNld4a8qieALHe3EiHPH3LYpbycy
 GPgH6xTTJm/Yq6G2IXmCWZwY2sTCHyG+fYM7Vgac2+T/3IWf03nLxdru3voD/hslo2c+M+DQ5Bn
 coHQ2iO50qdC5850FnDaUSINIge0ZibRYh8YJU6dMp9smnK0Ex+/zN6IUrVdWGQp+X/+Gzp80l2
 nxdBVpHXwv9a8x1DFkPPeMxm/R4PXgMYJSwizBj5hCWTlkI+VKTGvMy
X-Received: by 2002:a05:6000:22c7:b0:45e:f61f:7952 with SMTP id
 ffacd0b85a97d-45ef6b0ed94mr16385156f8f.12.1780267909491; 
 Sun, 31 May 2026 15:51:49 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1de4-8e00-0110-758a-6876-5140.310.pool.telefonica.de.
 [2a02:3100:1de4:8e00:110:758a:6876:5140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3559645sm19585771f8f.26.2026.05.31.15.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 15:51:49 -0700 (PDT)
Date: Sun, 31 May 2026 22:51:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BEXT=5D_Re=3A_=5BPATCHv1_0/7?=
 =?US-ASCII?Q?=5D_hw/arm=3A_Adding_Cortex-M7?=
 =?US-ASCII?Q?_Asymmetric_Multiprocessing_boot_support_for_i=2EMX8MP?=
In-Reply-To: <AM0PR04MB4370F0A97B0CF2363BFE9CA187082@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <D6AE3A65-8ED9-47B9-B7D5-51D8500B47AF@gmail.com>
 <AM0PR04MB4370F0A97B0CF2363BFE9CA187082@AM0PR04MB4370.eurprd04.prod.outlook.com>
Message-ID: <A626B2F1-D50B-4E0B-857C-2E101B6FFB1A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
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



Am 27=2E Mai 2026 17:34:33 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@nx=
p=2Ecom>:
>
>
>> -----Original Message-----
>> From: Bernhard Beschow <shentey@gmail=2Ecom>
>> Sent: 27 May 2026 02:56
>> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-devel@nongnu=2Eor=
g
>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>> Subject: [EXT] Re: [PATCHv1 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>> Multiprocessing boot support for i=2EMX8MP
>>=20
>> Caution: This is an external email=2E Please take care when clicking li=
nks or
>> opening attachments=2E When in doubt, report the message using the 'Rep=
ort
>> this email' button
>>=20
>>=20
>> Am 19=2E Mai 2026 17:56:28 UTC schrieb Gaurav Sharma
>> <gaurav=2Esharma_7@nxp=2Ecom>:
>> >Changes in v1:
>> >
>> >This series adds Asymmetric Multiprocessing (AMP) boot support for the
>> >Cortex-M7 core on the i=2EMX8MP SoC=2E The M7 firmware can be loaded a=
nd
>> >started from Linux running on the Cortex-A53 cores via the remoteproc
>> >framework=2E
>> >
>> >The series introduces the following peripheral models needed for AMP:
>> >  - GPC (General Power Controller)
>> >  - GPR (General Purpose Registers)
>> >  - SRC (System Reset Controller) authored by Bernhard Beschow
>> ><shentey@gmail=2Ecom>
>> >  - MU (Messaging Unit)
>> >  - Extends the CCM with M7 clock outputs and wires into the i=2EMX8MP
>> >SoC
>> >  - Enable Cortex-M7 boot in i=2EMX8MP EVK functional test
>>=20
>> Awesome work!
>>=20
>> I'd like to experiment with this series myself=2E Could there be some "=
cooking
>> recipe" in the board documentation for easy reproduction/failsafe tutor=
ial? Is
>> there perhaps some Buildroot defconfig with the appropriate support
>> enabled? Or even better: Are there any binary images that could be used=
 in a
>> functional test in addition?
>>=20
>
>Hey Bernhard,=20
>Thanks for your feedback!
>
>There's an application note that covers this use-case (AN5317, referenced=
 in the rst doc)=2E However, the complete setup requires combining informat=
ion from multiple sources=2E
>
>Requirements to exercise M7 image loading via Linux:
>
>1=2E RPMSG-specific device tree with M7 DDR alias - covered in AN5317
>2=2E Bare-metal ELF executable linked to run from DDR - requires building=
 from MCUXpresso SDK
>
>Building the M7 firmware:
>
>1=2E Download the MCUXpresso SDK for i=2EMX8MP
>2=2E Build a DDR-linked example using the ARM GCC toolchain (e=2Eg=2E, bo=
ards/evkmimx8mp/driver_examples/uart/polling)
>3=2E Copy the resulting ELF to the guest Linux filesystem
>4=2E Load via remoteproc as documented in the rst
>
>Currently there isn't a single official document covering the complete en=
d-to-end flow=2E Users might need to refer two different sources at best=2E=
 I can add concise build instructions to the rst doc itself, providing a se=
lf-contained reference=2E How does that sound?

Yes, sounds good! One way to think about it is to provide detailed instruc=
tions for conducting a manual test for somebody who has never done this bef=
ore=2E

>
>Regarding binary images: We can provide a pre-built test ELF for function=
al testing, though users would still need the appropriate device tree confi=
guration=2E

I think binary images would only be needed for fully automated functional =
tests=2E AFAIU this requires kernel support for e=2Eg=2E remoteproc -- do n=
ormal Linux distributions enable this? Then the device tree blob would need=
 to be patched and the M7 ELF be injected into the guest=2E I wonder if the=
 functional testing framework can do this?

Anyhow, this is juat an idea for fully automated tests which QEMU encurage=
s=2E If it is infeasible it shall not block this series=2E

>
>> Last but not least: Wouldn't it be useful if you became co-maintainer o=
f the
>> imx8mp-evk? Perhaps the two sections in the MAINTAINERS file could be
>> merged=2E
>>=20
>
>Sure=2E I can add myself to the MAINTAINERS of imx8mp-evk, but what do yo=
u mean by merging the two sections in the MAINTAINERS file ?

I was thinking about merging the imx8mm and imx8mp sections in the MAINTAI=
NERS file, similar to the MPS2 and MPS3 family of boards=2E It seems that m=
ore shared device models might evolve in the future where choosing between =
imx8mm and imx8mp sections becomes awkward=2E Moreover, when modifying one =
SoC, the other one should probably be kept in sync=2E Hence it might make s=
ense to merge the sections=2E What do you think?

>
>> Best regards,
>> Bernhard
>>=20
>> >
>> >Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >
>> >Bernhard Beschow (1):
>> >  hw/misc: Add SRC (System Reset Controller) to i=2EMX8MP
>> >
>> >Gaurav Sharma (6):
>> >  hw/misc: Add i=2EMX8MP GPC (General Power Controller) IP
>> >  hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>> >  hw/misc: Add MU (Messaging Unit) IP to i=2EMX8MP device model
>> >  hw/misc: Extend i=2EMX8MP CCM with Cortex-M7 clock outputs
>> >  hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP
>> >  tests/functional: Enable Cortex-M7 boot in i=2EMX8MP EVK functional
>> >test
>> >
>> > docs/system/arm/imx8m=2Erst                   |  90 +++-
>> > hw/arm/Kconfig                              |   4 +
>> > hw/arm/fsl-imx8mp=2Ec                         | 212 ++++++++++
>> > hw/misc/Kconfig                             |  12 +
>> > hw/misc/imx8mp_ccm=2Ec                        |   9 +
>> > hw/misc/imx8mp_gpc=2Ec                        | 124 ++++++
>> > hw/misc/imx8mp_gpr=2Ec                        | 129 ++++++
>> > hw/misc/imx8mp_mu=2Ec                         | 308 ++++++++++++++
>> > hw/misc/imx8mp_src=2Ec                        | 431 +++++++++++++++++=
+++
>> > hw/misc/meson=2Ebuild                         |   4 +
>> > hw/misc/trace-events                        |   5 +
>> > include/hw/arm/fsl-imx8mp=2Eh                 |  29 +-
>> > include/hw/misc/imx8mp_ccm=2Eh                |   3 +
>> > include/hw/misc/imx8mp_gpc=2Eh                |  34 ++
>> > include/hw/misc/imx8mp_gpr=2Eh                |  56 +++
>> > include/hw/misc/imx8mp_mu=2Eh                 |  53 +++
>> > include/hw/misc/imx8mp_src=2Eh                |  32 ++
>> > tests/functional/aarch64/test_imx8mp_evk=2Epy |   3 +-
>> > 18 files changed, 1535 insertions(+), 3 deletions(-) create mode
>> > 100644 hw/misc/imx8mp_gpc=2Ec create mode 100644 hw/misc/imx8mp_gpr=
=2Ec
>> > create mode 100644 hw/misc/imx8mp_mu=2Ec create mode 100644
>> > hw/misc/imx8mp_src=2Ec create mode 100644
>> include/hw/misc/imx8mp_gpc=2Eh
>> > create mode 100644 include/hw/misc/imx8mp_gpr=2Eh create mode 100644
>> > include/hw/misc/imx8mp_mu=2Eh create mode 100644
>> > include/hw/misc/imx8mp_src=2Eh
>> >

