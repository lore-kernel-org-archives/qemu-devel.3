Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74414E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ3u-0003OG-Qd; Mon, 29 Dec 2025 14:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3p-00038P-30
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:48 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3k-0000Ab-Lp
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:44 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso3867311cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:37:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037059; cv=none;
 d=google.com; s=arc-20240605;
 b=d/h0vo4P+tg4U8gQvheoHjQj0jACxe3cJImhjflhuv24vFDbyY4Ggb/cexQIdFaZ+f
 KgKVeXeZpUQCB+U5EMfZUWKr8P02mcyX1Ps+sgF+c2bTwiyjxDdLyAp5tONuCKvlpKgt
 Juki9/ReVEtuRXowEK6TwUn2OQSr/ja7/ng6mjN4eE+c0N8zN7MZi+O+CEOWqduTSi3z
 Em5aAoKWZUB+jgNA6XyUfzXiJLBENeBLjSa0XJ7LZ+mG9RDcElWffV4TAnMGMHLyNB4i
 xzaSRFPBXTamhtP5xnibowFR64YNCZCXM4TXZBoPMZOaCfJctDDRb6Bk6O7ou3W5WL3a
 2JMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rVMEy/BamA5mxoD6Wwf1mVSt7RfPRduBc+X7r9wWNkg=;
 fh=oUZElo35k2lV8zAoO2Z0SnDNqX9ywWeToS1fe71U2Zo=;
 b=WK+0y+6r5HeaVOMhSMeDw64y8v29TV/+7mCJuknZ7jgF/v0dapWwj0K4LYnhdxYYR1
 fNO6KLuFBshGBk/22tcNhcndUqvqpd0twglEdwgEKiI5W4m2xtqlPj7VF7h1827F/Pvd
 mGVVqt2s4K39UFmYVhWJ0G4nDSkDwj658A+R/HxhYy04nMorbtGrgM0cDDE23xKTm30v
 e1uwHB1hNBkenWZ49/XBmS26r7gDF40A2M+ZpePD0uFk2WMsUn1iZthi+i5Ibc9HNns0
 kgNtwCZNtWxmLrrAflwJRx0fAqS0NZkvWNrOZqWnUB/0mmQeps2oh+IOMVgbhVu/mgHc
 8NMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037059; x=1767641859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVMEy/BamA5mxoD6Wwf1mVSt7RfPRduBc+X7r9wWNkg=;
 b=exyZ3RhHE9ZpnLWDOPQudzj0KOEe7fbmy/NQpdVbei1+Lyxgh1khJhXRtfNJ7lw/Jf
 RYGYpwE7oLdyuGfxRgmQWxPUneavC/oZwx+1Fmcz2rV7Fonp7qSTmqASiK/MqChGDK+n
 m2EkyR5Vns7vzDIdpMBJMebpJl12aikucPnZZDBQa5W+lIGMNTNCdZ+Xr230MngX11wS
 /VmowpCd1xNfFe2XFpw9q/Y78lmOvbd8PbsxJoomYIVuaFsqsVIjayxI3NESomblGIga
 iYq6Ehs2jHw9f4hlZskHhogFYiSWqYtRWMNAHpX1wAPoAYu+qoIUPh2yEwm9PBuKvR0c
 hKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037059; x=1767641859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVMEy/BamA5mxoD6Wwf1mVSt7RfPRduBc+X7r9wWNkg=;
 b=Zd0bdpnXAaUVPLBdkbt+7q21aIt3m1U9MKo4FQR+QroeW05JjPZRlv7qPnzWaFtO1p
 u9VfE8QqxjF7UUlZjWpeMcikX3WslvW9wy89xzmda55u0nrHaYxLDlKnnw+4eZ7ItwTA
 wYkbJ3yXKBh8WFAX5Hz+NiBb4iKpSprmuSKRkAzELI9w/Ior4NeiB/8S8+zattWAga6S
 Ee70LLyilH6TRFbRQl5dCOt4vDyjRKgFf7Pw63M2w0NGU/qsTK/BpuU0k1AlLak065nG
 PfBUCsC14HMC/NH6OUuG/i26lQdMYE7CWBGSe/u/x32sY4rAbfzm8ZjWa5uvPc3ElRyn
 zaVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpWVarOq3KU5Vx3Tdfvw9OthdQNKArx4w7uOdtIb4Vn+8m4gQutVTxWYC2JdRRaecF12bwlzME2DwS@nongnu.org
X-Gm-Message-State: AOJu0YxXN2t9/N3qUHjXv4O4fQdivHq4VO4ZNhOK/sNuGcg1IwbEEsN1
 MO+16hNoI3PcL+EEdlqflJ6aiRk/fCxoVFufHiz/ebIRfrXZ9oCDFfP6gly+rDDtIdmW5XNWlng
 cBbjLfCmf0H/CjMpaUL3twDsU7tnVHqDfBFHRDJjt
X-Gm-Gg: AY/fxX6bh4UL32HMitoq+h65KbYtLEYHBvE9BnamLTMOsgD0oTATw5FL7sqjPFfibvz
 kDGP7xVcp6qd6cq21auLkOjNpKQi2CqOxK8nB48Cf4bf38Z0m04H0Q/bt9XSJboPYA4ZUleBfGz
 UKlvoMoemBSnYxEPQanCboKUYWIvA8kDTFRiW5Om2LYb2s3qCn74BdleQbYkbrJcNzuYxVTY6MN
 kr3cpHcybV3wY6jAhSqQWZXYQwAmDrN/CxiSB/nM18ryCXRY9NjEodhP45kNncg8vGxIymv6/pB
 AVGcguUSKqoXV7vR7T80ActUTg==
X-Google-Smtp-Source: AGHT+IGgvXNbmoI60rasMpyPG1UeTlp1fun3FWKbwaF3Y8BvbwOhW6X7hJ/7q8g2B3mL/pHQnqFmi+FLf8lyRYL5jfk=
X-Received: by 2002:a05:622a:249:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-4f4e5f601e6mr30359311cf.7.1767037059041; Mon, 29 Dec 2025
 11:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-1-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:37:27 -0800
X-Gm-Features: AQt7F2q5ZaT6AlSODsJXipGG7aPsafjafA1_28h_rk-Ud73cvt76P9b0qawMULM
Message-ID: <CA+QoejUnF6UY2tQ2h9MvGUs1V9hhUbVan=smQzyizjbnO4SVmQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Tue, Dec 23, 2025 at 5:42=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.com=
> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Hi all,
>
> LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM
> 2.0 specification (see Figure 2):
> https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
>
> LTPI provides a protocol and physical interface for tunneling various
> low-speed signals between the Host Processor Module (HPM) and the
> Satellite Controller Module (SCM). In Figure 2 of the specification,
> the AST27x0 SoC (left) integrates two LTPI controllers, allowing it to
> connect to up to two AST1700 boards. On the other side, the AST1700
> consolidates HPM FPGA functions and multiple peripheral interfaces
> (GPIO, UART, I2C, I3C, etc.) onto a single board.
>
> Because the AST1700 exposes additional I/O interfaces (GPIO, I2C, I3C,
> and others), it acts as an I/O expander. Once connected over LTPI,
> the AST27x0 can control additional downstream devices through this link.
>
> This patch series is based on the SGPIO changes:
> https://patchwork.kernel.org/project/qemu-devel/patch/20251219-aspeed-sgp=
io-v5-1-fd5593178144@google.com/
>
> It introduces a basic LTPI controller model and wires it into the
> AST27x0 SoC. The series also adds the AST1700-specific LTPI expander
> device and incrementally connects common peripherals on the AST1700
> model. For the I3C block, which may cause kernel crashes, its MMIO
> region is modeled as an unimplemented device to reserve address space
> and make the missing functionality explicit, ensuring stable guest
> probing.
>
> In the official release images, the AST1700 functions are not included
> by default. To test the AST1700-related functionality, please include
> the following DTS files for probing:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm6=
4/boot/dts/aspeed/aspeed-ltpi0.dtsi
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm6=
4/boot/dts/aspeed/aspeed-ltpi1.dtsi
>
> After including these DTS files in the BMC image, you can verify LTPI
> functionality using the following scenarios:
>
> 1. In U-Boot:
>    Run the ltpi command to trigger the LTPI connection and display the
>    current connection status.
> 2. In BMC Linux:
>    Run i2cdetect -y <16-38> to scan and test the I2C buses exposed by
>    the AST1700.
>
> Any feedback or suggestions are appreciated!
>
> Kane
>

Adding the explanation of the tested tag in every patch feels
unnecessary since the tests applied equally to all patches. However, I
didn't want to add the tag without any explanation, so I figured I
might as well reply to the cover letter. I tested between patches to
make sure all our internal tests passed and there was no unexpected
breakages, and once the whole patchset landed tested against our
internal ast2700 machines and was able to see the i2c buses and attach
devices to them.


> ---
>
> ChangeLog
> ---------
> v4:
> - Add missing Signed-off-by
> - Fix checkpatch.pl warnings
> - Refine code structure
> - Enable AST1700 support only after all devices are ready
>
> v3:
> - Add PWM model
> - Integrate the SGPIO model
> - Fix I2C test case failure
> - Refine code structure
>
> v2:
> - Separate the AST1700 model into a standalone implementation
> - Refine the mechanism for assigning the AST1700 board number
>
> v1:
> - Initial version
> ---
>
> Kane-Chen-AS (19):
>   hw/misc: Add LTPI controller
>   hw/arm/aspeed: Attach LTPI controller to AST27X0 platform
>   hw/misc: Add basic Aspeed PWM model
>   hw/arm/aspeed: Add AST1700 LTPI expander device model
>   hw/arm/aspeed: Integrate AST1700 device into AST27X0
>   hw/arm/aspeed: Integrate interrupt controller for AST1700
>   hw/arm/aspeed: Attach LTPI controller to AST1700 model
>   hw/arm/aspeed: Attach UART device to AST1700 model
>   hw/arm/aspeed: Attach SRAM device to AST1700 model
>   hw/arm/aspeed: Attach SPI device to AST1700 model
>   hw/arm/aspeed: Attach ADC device to AST1700 model
>   hw/arm/aspeed: Attach SCU device to AST1700 model
>   hw/arm/aspeed: Attach GPIO device to AST1700 model
>   hw/arm/aspeed: attach I2C device to AST1700 model
>   hw/arm/aspeed: Attach WDT device to AST1700 model
>   hw/arm/aspeed: Attach PWM device to AST1700 model
>   hw/arm/aspeed: Attach SGPIOM device to AST1700 model
>   hw/arm/aspeed: Model AST1700 I3C block as unimplemented device
>   hw/arm/aspeed: Enable AST1700 IO expander support
>
>  include/hw/arm/aspeed_ast1700.h |  53 +++++++
>  include/hw/arm/aspeed_soc.h     |  25 ++-
>  include/hw/i2c/aspeed_i2c.h     |   1 +
>  include/hw/intc/aspeed_intc.h   |   2 +
>  include/hw/misc/aspeed_ltpi.h   |  33 ++++
>  include/hw/misc/aspeed_pwm.h    |  31 ++++
>  hw/arm/aspeed_ast1700.c         | 268 ++++++++++++++++++++++++++++++++
>  hw/arm/aspeed_ast27x0.c         | 165 ++++++++++++++++++--
>  hw/i2c/aspeed_i2c.c             |  19 ++-
>  hw/intc/aspeed_intc.c           |  60 +++++++
>  hw/misc/aspeed_ltpi.c           | 193 +++++++++++++++++++++++
>  hw/misc/aspeed_pwm.c            | 121 ++++++++++++++
>  hw/arm/meson.build              |   1 +
>  hw/misc/meson.build             |   2 +
>  hw/misc/trace-events            |   4 +
>  15 files changed, 959 insertions(+), 19 deletions(-)
>  create mode 100644 include/hw/arm/aspeed_ast1700.h
>  create mode 100644 include/hw/misc/aspeed_ltpi.h
>  create mode 100644 include/hw/misc/aspeed_pwm.h
>  create mode 100644 hw/arm/aspeed_ast1700.c
>  create mode 100644 hw/misc/aspeed_ltpi.c
>  create mode 100644 hw/misc/aspeed_pwm.c
>
> --
> 2.43.0
>

