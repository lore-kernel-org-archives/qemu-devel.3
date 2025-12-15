Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975E2D5B866
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 19:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEfA-0006T0-M5; Mon, 15 Dec 2025 14:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vVEf3-0006SA-9U
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:55:13 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vVEf1-0004z8-8V
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:55:13 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4ed67a143c5so8531cf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 11:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765828509; cv=none;
 d=google.com; s=arc-20240605;
 b=h2gC/KYuVgVxT0uST8qNmx04a+yCwejaDXT3ACPx0KnoLcx8htCVehlHaWCb6GyoH7
 U5WwlfrK4qjAu9YPyqvIiOeeBFaV4y4NQMO9cWtO0FqDoV78jc12lhdn8iVXuJNW4wYH
 jjDUCd9A6ODWg6buF9yDpwrgMhnYS1XQrjPvcEtO+9ti1sbZrthS5z/Jvjkeee7G2nmw
 3Eb3GJJ6Lb0ua9UaLv9Sw04ACgOudHLukORwnBh21fVzBCsgVrqBkfmaxiHX98AmtkeL
 2aSQ/S0SX7NiO+h1BgFjO/5VzmIhOA4+Fv2XUqn2oXOaHIfopuAEGXZye2iZWK05VUjp
 lmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N/c7i6VPcGhnY9ze/Hxv8Cxes8G194XI+dNW0Y+cbwE=;
 fh=j/EC1Pdi2jrvxGGLy+6tuGW/kismgzPvsEau6C6PmuU=;
 b=VX7vi3PeY3yFBEyHW7lWhBa8E8/2Qzn3OmdjgtVnYpgwndBFYMx7a1TP20cxYXEn97
 0cHp+vQpH9VvVByybqk3CZJD8sKcbmIIaxvFvNNcC7rbJtvVJ5Fbw/zF9ltMFM8WuJJX
 +fqurSP2wjq18YXC5FwzTxbjjXKbs9JegW52Thlw9EM2FSaryvjbY81E/wUTs2zcIYli
 2gJEb1TNPByvW+ZbUYk+8MNeZdGnuUhgGHLWzUmv0RI+EYVtnUPmAdSXk/tHj2o0fSoa
 Foh014C+v8rtAYVkNDHC8lzRlXItWgrhGy1ftNQnKbmu0W8uOAVB5+CsghKnvgzb+byJ
 QcBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765828509; x=1766433309; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/c7i6VPcGhnY9ze/Hxv8Cxes8G194XI+dNW0Y+cbwE=;
 b=tX94Mr0FPxxFmH8/JJ7l1v2KzpA1B544mTTVrnirtXIeohNZyK9krRV7+5SfT8SINI
 ic0kA/XE7PtMt3rh6GobqUVkTy/zYOHfUr/ywHs8OpY9riC8UiFP9wzrHVmo0bpw/BT1
 xXGAJD2LEK3qnVU2KwEzhrLx63Uhbktx2D13ky21fHNAZGYigyRLn5e8M+uRVV5r470R
 LSq2p9wU0rbWlBWf4tOwLrG1NoN2ZcHc3Dje60itWVXtPhcYioyWVm5sAPknCk3qhJn2
 KRNlHt2xNqrdo/3wLUXda63ceW0ZDv3DXTHbeV4eOjbx0vlxrednZtvbnt8/Z6Ge6RNO
 IAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765828509; x=1766433309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N/c7i6VPcGhnY9ze/Hxv8Cxes8G194XI+dNW0Y+cbwE=;
 b=YKVRAYvVwkxLO2dPNIyusn//v4gdWAoochdQWuasvdY4tcW50R5PRHZKCk8F+vzFxY
 M4EEAW4iXWw39o5EwrtsdLMPlCqq2efPa0WnozfSFu+8oIKCZm1pvt5+BWgHYBLmDMD/
 IDBefS0hDcpLmzs4IsSgwwfw//uTcv98n1KuHQfk2J8A8ETWa3b+LdP6Y6NvqdAuHYZ8
 GPYyLjqiGQjzm4cliynLb1mPifVUO+yISZ33HLxa2wjfw1pj5+/ugl0sLCCyfiudqEuW
 U4Cr1pg1mX7/LnSw/MkJbRqKtT/ToZ+DW9kc8l0TKSDRkvhrzKQvmcftHWaPGDMPNVv4
 29rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwJ0f4WCJcs6CSAC370ceyvluqV/eFx0u/7BSlAgFw6qBSl2NrycyHmwnWWap/DgVs1kJ3bKGji2ex@nongnu.org
X-Gm-Message-State: AOJu0YyIG3CXkchVaTi60Hnes1TiQ9PeVkUlpNh6CMPaMpqSKiuzEeop
 vubZ/8qEkoQhOQTgonnbUYYnSX3ulG7O2clStOsN0xPGxy3l2hfm5+Wl/2K14GT4G10Z/LOrMu6
 pV7DWd6Bl5DMbWectecQM2enMI1S+270q31FQ+rbS
X-Gm-Gg: AY/fxX4tCAGlFm92ONDEcONpDLlumAGHrYNgfyyPHQxey5nlUS7mpRii0M3yqrKl7sh
 URO22lR6Riz6dAAMiVk5MFX8VMzgPtg81NKtSfAvve/tWqBPi/GoIwU2seNuDQZypXQ3XxHEllB
 fTOtWbK2pO51YSbCJO/UzRHqDqy4uCna6XBtYoqxRMpVUHhT7oGeSdGGTopEKQHITuFvAB7Klq6
 fpLlj4uYcpcQS7XK/JTEWqZeFC6Yoc4NgdJY+YRfsKWKDgciFSVv+t1rZqx16XlkTXtdqxiMzVJ
 I3Ds+pmVRQs1LTU2SXMerGh/Ew==
X-Google-Smtp-Source: AGHT+IFaPoud79ZQtIL/y7abE6g0Z+mwHHJxHggsQc033QBNsJU/dDjV/ey5lZNLM+w7w+7isw7zAYILIkxZhdv2VX4=
X-Received: by 2002:a05:622a:65c6:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4f1dd5ed363mr912161cf.13.1765828509027; Mon, 15 Dec 2025
 11:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <CA+QoejW4vx7U-QYBK6GY10NpwXyQFe92j9M=OeURWz_D5vBbUw@mail.gmail.com>
 <SI6PR06MB76310C943D65CE7456178A50F7A1A@SI6PR06MB7631.apcprd06.prod.outlook.com>
In-Reply-To: <SI6PR06MB76310C943D65CE7456178A50F7A1A@SI6PR06MB7631.apcprd06.prod.outlook.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 15 Dec 2025 11:54:55 -0800
X-Gm-Features: AQt7F2obMtRVZfcS8Hri0ZacUAb0tpZBcFtY51y9FYqKJWvLltJsp8sL1UBiRGc
Message-ID: <CA+QoejVrXQ4fr_93-PSj9SPitmmxd2=+2SrsaRCZcN9iVakQpw@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Dec 10, 2025 at 10:42=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.co=
m> wrote:
>
> Hi Nabih,
>
> Thank you for your review and comments. I will wait a few more days
> to see if there is additional feedback from others. If you encounter
> anything unexpected in your local environment, please let me know. I
> will try to address it in the v4 patch if possible.
>
> Best regards,
> Kane

Hi Kane,

I just discovered that our machines seem to fail to boot halfway
through the stack, but work as expected at the top of the stack. My
guess is that the driver for the AST1700 doesn't quite know how to
deal with half the model existing and half of it missing. Is it
possible to reorganize the patches so the `hw/arm/aspeed: Integrate
AST1700 device into AST27X0` patch comes last? That way the driver
will only know of the existence of the AST1700 when the model fully
exists in QEMU. Mostly to make sure the machine works in any commit
and not just at HEAD.

Thanks!
Nabih


> > -----Original Message-----
> > From: Nabih Estefan <nabihestefan@google.com>
> > Sent: Thursday, December 11, 2025 7:02 AM
> > To: Kane Chen <kane_chen@aspeedtech.com>
> > Cc: C=C3=A9dric Le Goater <clg@kaod.org>; Peter Maydell
> > <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Tro=
y
> > Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
> > Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
> > open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC
> > here <qemu-devel@nongnu.org>; Troy Lee <troy_lee@aspeedtech.com>
> > Subject: Re: [PATCH v3 00/18] hw/arm/aspeed: AST1700 LTPI support and
> > device hookups
> >
> > On Sun, Dec 7, 2025 at 11:45=E2=80=AFPM Kane Chen via <qemu-devel@nongn=
u.org>
> > wrote:
> > >
> > > From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> > >
> > > Hi all,
> > >
> > > LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP
> > > DC-SCM
> > > 2.0 specification (see Figure 2):
> > > https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
> > >
> > > LTPI provides a protocol and physical interface for tunneling various
> > > low-speed signals between the Host Processor Module (HPM) and the
> > > Satellite Controller Module (SCM). In Figure 2 of the specification,
> > > the AST27x0 SoC (left) integrates two LTPI controllers, allowing it t=
o
> > > connect to up to two AST1700 boards. On the other side, the AST1700
> > > consolidates HPM FPGA functions and multiple peripheral interfaces
> > > (GPIO, UART, I2C, I3C, etc.) onto a single board.
> > >
> > > Because the AST1700 exposes additional I/O interfaces (GPIO, I2C, I3C=
,
> > > and others), it acts as an I/O expander. Once connected over LTPI, th=
e
> > > AST27x0 can control additional downstream devices through this link.
> > >
> > > This patch series is based on the SGPIO changes:
> > > https://lore.kernel.org/qemu-devel/20251106-aspeed-sgpio-v1-0-b026093=
7
> > > 16fa@google.com/
> > >
> > > It introduces a basic LTPI controller model and wires it into the
> > > AST27x0 SoC. The series also adds the AST1700-specific LTPI expander
> > > device and incrementally connects common peripherals on the AST1700
> > > model. For the I3C block, which may cause kernel crashes, its MMIO
> > > region is modeled as an unimplemented device to reserve address space
> > > and make the missing functionality explicit, ensuring stable guest
> > > probing.
> > >
> > > In the official release images, the AST1700 functions are not include=
d
> > > by default. To test the AST1700-related functionality, please include
> > > the following DTS files for probing:
> > >
> > https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/a
> > > rm64/boot/dts/aspeed/aspeed-ltpi0.dtsi
> > >
> > https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/a
> > > rm64/boot/dts/aspeed/aspeed-ltpi1.dtsi
> > >
> > > After including these DTS files in the BMC image, you can verify LTPI
> > > functionality using the following scenarios:
> > >
> > > 1. In U-Boot:
> > >    Run the ltpi command to trigger the LTPI connection and display th=
e
> > >    current connection status.
> > > 2. In BMC Linux:
> > >    Run i2cdetect -y <16-38> to scan and test the I2C buses exposed by
> > >    the AST1700.
> > >
> > > Any feedback or suggestions are appreciated!
> > >
> > > Kane
> > >
> >
> > I left some nit-picky notes on some of the patches, but after fixing pa=
tch 03
> > everything else seems good. FWIW I brought the whole patchset into our
> > branch and not only does everything compile properly, but I can also se=
e and
> > interact with the i2c buses from the AST1700 in our internal platforms.=
 Will
> > wait for v4 to add the reviewed and tested tags, but LGTM!
> >
> > > ---
> > >
> > > ChangeLog
> > > ---------
> > > v3:
> > > - Add PWM model
> > > - Integrate the SGPIO model
> > > - Fix I2C test case failure
> > > - Refine code structure
> > >
> > > v2:
> > > - Separate the AST1700 model into a standalone implementation
> > > - Refine the mechanism for assigning the AST1700 board number
> > >
> > > v1:
> > > - Initial version
> > > ---
> > >
> > > Kane-Chen-AS (18):
> > >   hw/misc: Add LTPI controller
> > >   hw/arm/aspeed: Attach LTPI controller to AST27X0 platform
> > >   hw/misc: Add basic Aspeed PWM model
> > >   hw/arm/aspeed: Add AST1700 LTPI expander device model
> > >   hw/arm/aspeed: Integrate AST1700 device into AST27X0
> > >   hw/arm/aspeed: Integrate interrupt controller for AST1700
> > >   hw/arm/aspeed: Attach LTPI controller to AST1700 model
> > >   hw/arm/aspeed: Attach UART device to AST1700 model
> > >   hw/arm/aspeed: Attach SRAM device to AST1700 model
> > >   hw/arm/aspeed: Attach SPI device to AST1700 model
> > >   hw/arm/aspeed: Attach ADC device to AST1700 model
> > >   hw/arm/aspeed: Attach SCU device to AST1700 model
> > >   hw/arm/aspeed: Attach GPIO device to AST1700 model
> > >   hw/arm/aspeed: attach I2C device to AST1700 model
> > >   hw/arm/aspeed: Attach WDT device to AST1700 model
> > >   hw/arm/aspeed: Attach PWM device to AST1700 model
> > >   hw/arm/aspeed: Attach SGPIOM device to AST1700 model
> > >   hw/arm/aspeed: Model AST1700 I3C block as unimplemented device
> > >
> > >  include/hw/arm/aspeed_ast1700.h |  53 +++++++
> > >  include/hw/arm/aspeed_soc.h     |  25 ++-
> > >  include/hw/i2c/aspeed_i2c.h     |   1 +
> > >  include/hw/intc/aspeed_intc.h   |   2 +
> > >  include/hw/misc/aspeed_ltpi.h   |  32 ++++
> > >  include/hw/misc/aspeed_pwm.h    |  31 ++++
> > >  hw/arm/aspeed_ast1700.c         | 269
> > ++++++++++++++++++++++++++++++++
> > >  hw/arm/aspeed_ast27x0.c         | 163 +++++++++++++++++--
> > >  hw/i2c/aspeed_i2c.c             |  19 ++-
> > >  hw/intc/aspeed_intc.c           |  60 +++++++
> > >  hw/misc/aspeed_ltpi.c           | 194 +++++++++++++++++++++++
> > >  hw/misc/aspeed_pwm.c            | 121 ++++++++++++++
> > >  hw/arm/meson.build              |   1 +
> > >  hw/misc/meson.build             |   2 +
> > >  hw/misc/trace-events            |   4 +
> > >  15 files changed, 957 insertions(+), 20 deletions(-)  create mode
> > > 100644 include/hw/arm/aspeed_ast1700.h  create mode 100644
> > > include/hw/misc/aspeed_ltpi.h  create mode 100644
> > > include/hw/misc/aspeed_pwm.h  create mode 100644
> > > hw/arm/aspeed_ast1700.c  create mode 100644 hw/misc/aspeed_ltpi.c
> > > create mode 100644 hw/misc/aspeed_pwm.c
> > >
> > > --
> > > 2.43.0
> > >
> > >

