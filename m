Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34ECC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Go-0004e1-VM; Tue, 07 Jul 2026 08:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wh5Gh-0004d2-Pj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:51:21 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wh5Gd-000290-C0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:51:19 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39b3027009fso34071511fa.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783428672; cv=none;
 d=google.com; s=arc-20260327;
 b=CbY0fnxhBAhX670it58goMcJCAKG8gFF50yyUrPmqFv2W7OJ7Gp7cVEx3orIq7/uT/
 AxBDIwFCUnhCjxehB8HaotvnaBLnhp++HqIC4AySnkAjG7sAqIncSfS1cFrDHI/Q7Vaw
 Wl0zhwJxY7PuO90N891+9E5PsMjChoqeQSH9/OTEmWJG32q4gQ/YHoQLIWNmsAnrEF7P
 IW82Wa9JZjeDCRBB/bosOnwRBo+A/9jJOVqrLx+Vo+MeCBP2fQLNzC2SDgzhO2P3uwP1
 Mgfqo5U3Nn6qmeTQPXUw/mFiI6IrT8LdgognCZ6m0+OUnw9o3pypd2sxqR3NnhIzmlAf
 Id9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tkoSI/EU5OkkPNZRvfMDKmbwSqNV8O6mpqgdmjz813I=;
 fh=AUiu90TA3MVLcSd7vVueiq3/CE1bBYl17Vk+oJ4aAT4=;
 b=XGAQ+imSiRB7hlVylKYPFWpKcSDLMppgMswxb7vQF9oSCL33pwbINzhd1fvwUnKdi0
 RKVGkGAT3z72vm4+SoXqvxWhi+2x+QNui0M/NE46jfZuVk/gV40ceRVBFKysQwKySS/H
 kJIgsEtPXg7XLCZZOrWcpohvvgwrtpnP6c3Opnj0FzHoFtHCMS26Z9abb/DqD2HP04gj
 gUiEGeVL2/gz3EEQPhmFnvRuqjxvTGyB3v8fVQY7G8/+qoHMMQf2UHvN3j0zGSTclcN7
 J6/RgfO+0xuKaK06fJx2zJ2wujkoDnvhVQE+HjaMpoY/ay/CkVFcF3q3c6sjFGKL+gQO
 3Z9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1783428672; x=1784033472; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkoSI/EU5OkkPNZRvfMDKmbwSqNV8O6mpqgdmjz813I=;
 b=J3e6tghPFsJqi91m2f768/lQ5QviddqPM1MY5NkN+ejsHk0KJ8jg6hjRpSkBoKTZbG
 X7z7Y6nYxeNdDsbleFGGrmM8Gs+11mW8ZHVLT3OhdOyXl1WjhJOFVdLYOZDJqA9D+TGP
 QHnZNjGLK9N0ya/sG2vdPGV2StQpDNGoHUp1zNqnrG74Z9Xn/xbNMI2ulzTFhRAVrqCJ
 lvJlNq0vfew/Ji5yORoYaa8Nt1fTvKxbbT3bg5hntKmCDddUuV7Fo9E4530pDCOvZPv/
 roUP0OaHoYBxpAXeXkWQCSU6HB/e1Cpqp7Uk6S5KyKOX10fPzDPFI2U2IbwsQmgOJ07h
 iNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783428672; x=1784033472;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkoSI/EU5OkkPNZRvfMDKmbwSqNV8O6mpqgdmjz813I=;
 b=O+XPLk8cGWNrMUAzPDOv5L67tB2jP8LMPzZrgPUUoyvdiqbj7WVNW9TGeZ34XqR461
 HJH2r1c8WU22Ora4V5AOuZtZK/zOR4hgAJ3bxCxKVpaO3pC06v0VqKOfvpCah42pn6Xb
 9r67pcAVhMmroSDqLppA0Wor6x6h2M5YDw2MeSDasOfBb2NsbYOXzaL1lOnZfOTAqWjc
 RVxbK2qbqoPQRuxPuYYhe7uJkmkIQZKD6JsdBvDi0pEb1K1gc/1N9afX+YU8V5Dp5J+R
 e5aVUYzUO4nuiGWpt5CgI/KKsZMk4waeTX5fYaHMBOCEtcBRF3ubL83UCkOVtlaDn3ry
 UzRQ==
X-Gm-Message-State: AOJu0YzjHxXnP3kMIFLqsFG9XGE80qKZbztjC6amsaM3FAV9kgfxX+Hm
 lO14NccYpA0cnBuL4MVORSPsuqbemsQX8cYqJUvc9A73Z8GvEmB/VjMaC9pVivQZ1UAnBxMnTY/
 0TIGuORvDd1Kdw0MTg6Pkt0B30oaFroo91OvHglv/twKI4PDd37HDQ4V1UQ==
X-Gm-Gg: AfdE7ckutUi+fTnzPhoPKON/Xjbiob1crAzt6EeJc/xK7L7y1AFlChLwZ+vjq+42lzb
 RJunxjNeuARL75crqolFjMPNivDhdciPcxK1JBKL2WHH3ruPXJcQKPABD7f75NIy4V+RUJ3XrJT
 y8ni/6QfwGpAARefkepKdo8zQDgl/eFgWMgdL812sN/zOpW+Lns/Zb/1GA9rkO04muC2mDtWYbj
 NlXXfQ5sTAyulUf8nTktW5UA2sAWGyXZsf0dRkO4BRplPLIN1+O14HieycUR5XaPOsmsqdyQOCP
 oPiTiO4=
X-Received: by 2002:a2e:a105:0:b0:39b:b01:ab84 with SMTP id
 38308e7fff4ca-39c5fd7dca1mr12247841fa.3.1783428671802; Tue, 07 Jul 2026
 05:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260619115533.5664-1-alexander.hansen@9elements.com>
 <20260619115533.5664-3-alexander.hansen@9elements.com>
In-Reply-To: <20260619115533.5664-3-alexander.hansen@9elements.com>
From: Alexander Hansen <alexander.hansen@9elements.com>
Date: Tue, 7 Jul 2026 14:51:00 +0200
X-Gm-Features: AVVi8CdjD_CEoJ0tKlpxzWYDj7mZ8kNamozMLfEs7IsUqobzxZF-kat-JBQ8Pcc
Message-ID: <CAEr1sMs-Fwt_LbCU8KUnMRKgUaWuGrSX1EAz7KapXPGmSX4z6w@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] ast2600: yosemite4 functional test
To: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Titus Rwantare <titusr@google.com>, Emmanuel Blot <eblot@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alexander.hansen@9elements.com; helo=mail-lj1-x22a.google.com
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

Hi Cedric,

sorry to ping, since the
- (ast2600: yosemite4 initial support) and
- (ast2600: yosemite4 functional test)

also work by themselves, would you consider those two as ready or is
there something i need to fix there.
Alternatively, do all patches of a series need to go in together?
Would it help if I pushed those 2 again separately.

Thanks again for taking the time reviewing those patches :)

Alexander

Am Fr., 19. Juni 2026 um 13:55 Uhr schrieb <alexander.hansen@9elements.com>=
:
>
> From: Alexander Hansen <alexander.hansen@9elements.com>
>
> Add a functional test for the Yosemite V4 (fby4-bmc) machine
> that validates:
> - U-Boot initialization and kernel boot sequence
>
> The test uses an OpenBMC image built for the yosemite4 board and
> validates console output through the boot process.
>
> Cc: Emmanuel Blot <eblot@meta.com>
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
> Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
> Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
> Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
> Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>  tests/functional/arm/meson.build         |  2 ++
>  tests/functional/arm/test_aspeed_fby4.py | 45 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/functional/arm/test_aspeed_fby4.py
>
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meso=
n.build
> index 61b00932db..19331b3f16 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -15,6 +15,7 @@ test_arm_timeouts =3D {
>    'aspeed_anacapa' : 480,
>    'aspeed_bletchley' : 480,
>    'aspeed_catalina' : 480,
> +  'aspeed_fby4': 480,
>    'aspeed_gb200nvl_bmc' : 480,
>    'aspeed_rainier' : 480,
>    'bpim2u' : 500,
> @@ -50,6 +51,7 @@ tests_arm_system_thorough =3D [
>    'aspeed_anacapa',
>    'aspeed_bletchley',
>    'aspeed_catalina',
> +  'aspeed_fby4',
>    'aspeed_gb200nvl_bmc',
>    'aspeed_rainier',
>    'bpim2u',
> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/=
arm/test_aspeed_fby4.py
> new file mode 100755
> index 0000000000..a521834f79
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -0,0 +1,45 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from qemu_test import wait_for_console_pattern
> +from aspeed import AspeedTest
> +
> +
> +class YosemiteV4Machine(AspeedTest):
> +
> +    ASSET_YOSEMITE_V4_FLASH =3D Asset(
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/mas=
ter/images/yosemite4-bmc/openbmc-20260505132843/obmc-phosphor-image-yosemit=
e4-20260505132843.static.mtd.xz',
> +        'dff6946363b41f952b15cfc3156482b89fcfc1b0ecfc3ec8b3ed496a5f001ef=
9')
> +
> +    def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboo=
t,
> +                                   cpu_id, soc):
> +
> +        self.set_machine(machine)
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', f'file=3D{image},if=3Dmtd,format=3Dra=
w',
> +                         '-snapshot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern(f'U-Boot {uboot}')
> +        self.wait_for_console_pattern('## Loading kernel from FIT Image'=
)
> +        self.wait_for_console_pattern('Starting kernel ...')
> +        self.wait_for_console_pattern(f'Booting Linux on physical CPU {c=
pu_id}')
> +        self.wait_for_console_pattern(f'ASPEED {soc}')
> +        self.wait_for_console_pattern('/init as init process')
> +        # yosemite v4 does not emit the hostname log which is
> +        # different from the other machines.
> +        self.wait_for_console_pattern('yosemite4 login:')
> +
> +    def test_arm_ast2600_yosemitev4_openbmc(self):
> +        image_path =3D self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
> +
> +        self.do_test_arm_aspeed_openbmc_no_network('fby4-bmc', image=3Di=
mage_path,
> +                                        uboot=3D'2019.04', cpu_id=3D'0xf=
00',
> +                                        soc=3D'AST2600 rev A3')
> +
> +if __name__ =3D=3D '__main__':
> +    AspeedTest.main()
> --
> 2.54.0
>

