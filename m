Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449DEC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKCV-0002DT-Pj; Fri, 24 Jan 2025 08:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbKCR-0002D4-Mi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:58:19 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbKCP-0006x4-S6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:58:19 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so396243166b.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 05:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737727095; x=1738331895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYRUdSolMlIsWDuVLlIudwNf6o2f2ka+Oz5ZtNvDT00=;
 b=gbdJFGFm8acGPJbo7TK/8fEDrOkLR2upBEr1WmMbIWLYH45f/pBhDswV+EBA1hH1dK
 xUbFRd5wLCj5e6LCcrdPxjKfnCC2d5HkGgmH2EGBZzshou6XBBUOHlG6SeHR39e+kjQm
 fLF8bnJSb99Bf9Q26+L/GuF8fqFdmTm+67fmNRKxL+QEYqYMGb+lPl0matseesQrqQXD
 rcry9OcF5A8cd0k40WcSN0USNrCIhCtsuH3h5N/t/lSxDrz1/d94dtWHKjruVAnawfJ3
 k95MMLPfQHyJahrqP1plv4VBMvYIbGNie+QxLRV37xfri4ybQ0BcuPu/GWyYwb/wDQTf
 kA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737727095; x=1738331895;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tYRUdSolMlIsWDuVLlIudwNf6o2f2ka+Oz5ZtNvDT00=;
 b=ibR+TDyC2RkAWKpbY65x5OdCYRTVV604Ve5twISs9ANaskElEPvnqBqiJbPZ9FlQhL
 BkNKGuUUtSK6YTkFqK6K5cpBuq+y3QPZkvajcxv5EjBc/+KmRJxtKYhRuuedZcl9QK7c
 J4yzt90xLdjkKCEYjL/YFPTx6Qp4+v42I1/3WK52Pv0XV46XSqjco4MYoWyY2icYmaQs
 L+QBXGaQ+mbV8xbNavesT2/SCub/61GNNxY8JI9rTMRk5EqtLOWUy2PEOqS2045QA1SQ
 9mgwEhnNXwz2MTtTmJuT4ntXdaq6S5+6oXTfcQf832tEZ7tD32J19ZS7swvWGFWeveXZ
 O80g==
X-Gm-Message-State: AOJu0Yx2OBDmwchAlKn1jADsJTed0rrDVLr3s6kdwIzf4+1taLwM1rpW
 bKsweq3Pxqwkf+uFqNfeHThNdWl67zygCktRT9ZIY9jXlKMVL0Z7z4SL0Ck7QPY=
X-Gm-Gg: ASbGncswqskZzqTMUbX8ccXJLs5gzUARV6zUBPgbsxC9gvvBCbiht5D+9cyeAndLMvg
 Bat8d04BiyEIv+0ngyzVfu6Sjj1+z/HTsCLgc5QMwEgH3LGdywuD9OXKUEGFkVj9sBY48kTpkUq
 jmqx0b/SH21MMjUsQWzfmtJT+3hSh0iXYiGyKR4yUL6K2RR7RG5+7OVZOtIvlvs0rDr2r3jVHRP
 pmly3t41n9HRwJlAoWBXtOal/Kx8sdZiBdd3nce+HnT/YFbscljdEMsa19SlfrL3KEcVZB1u+Ga
 1OA=
X-Google-Smtp-Source: AGHT+IESFKgN6TCkRFzcX1E2fmzDvAQODujNSPatD91n8srD78gd/g3Skg2AdUOa2b7Vhc4VZF6krA==
X-Received: by 2002:a17:907:94cb:b0:aa6:423c:850e with SMTP id
 a640c23a62f3a-ab38b29954bmr2803378066b.27.1737727095266; 
 Fri, 24 Jan 2025 05:58:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760ab0bcsm135499666b.95.2025.01.24.05.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 05:58:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3DC35F748;
 Fri, 24 Jan 2025 13:58:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Joel Stanley
 <joel@jms.id.au>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/functional: Add a test for the arm microbit machine
In-Reply-To: <20250124101709.1591761-1-thuth@redhat.com> (Thomas Huth's
 message of "Fri, 24 Jan 2025 11:17:09 +0100")
References: <20250124101709.1591761-1-thuth@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 24 Jan 2025 13:58:13 +0000
Message-ID: <8734h8joui.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> We don't have any functional tests for this machine yet, thus let's
> add a test with a MicroPython binary that is available online

We do have a basic system test:

  test-armv6m-undef: test-armv6m-undef.S
          $(CC) -mcpu=3Dcortex-m0 -mfloat-abi=3Dsoft \
                  -Wl,--build-id=3Dnone -x assembler-with-cpp \
                  $< -o $@ -nostdlib -static \
                  -T $(ARM_SRC)/$@.ld

  run-test-armv6m-undef: QEMU_OPTS=3D-semihosting-config enable=3Don,target=
=3Dnative,chardev=3Doutput -M microbit -kernel

  ARM_TESTS+=3Dtest-armv6m-undef

But I guess this exercised more of the machine as micropython actually
comes up.

> (thanks to Joel Stanley for providing it, see:
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg606064.html ).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                           |  1 +
>  tests/functional/meson.build          |  1 +
>  tests/functional/test_arm_microbit.py | 31 +++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100755 tests/functional/test_arm_microbit.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d9b3a0011..7b4d84bf5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1157,6 +1157,7 @@ F: hw/*/microbit*.c
>  F: include/hw/*/nrf51*.h
>  F: include/hw/*/microbit*.h
>  F: tests/qtest/microbit-test.c
> +F: tests/functional/test_arm_microbit.py
>  F: docs/system/arm/nrf.rst
>=20=20
>  ARM PL011 Rust device
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index bcfbb70b65..a301c38806 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -105,6 +105,7 @@ tests_arm_system_thorough =3D [
>    'arm_cubieboard',
>    'arm_emcraft_sf2',
>    'arm_integratorcp',
> +  'arm_microbit',
>    'arm_orangepi',
>    'arm_quanta_gsj',
>    'arm_raspi2',
> diff --git a/tests/functional/test_arm_microbit.py b/tests/functional/tes=
t_arm_microbit.py
> new file mode 100755
> index 0000000000..68ea4e73d6
> --- /dev/null
> +++ b/tests/functional/test_arm_microbit.py
> @@ -0,0 +1,31 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright 2025, The QEMU Project Developers.
> +#
> +# A functional test that runs MicroPython on the arm microbit machine.
> +
> +from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_p=
attern
> +from qemu_test import wait_for_console_pattern
> +
> +
> +class MicrobitMachine(QemuSystemTest):
> +
> +    ASSET_MICRO =3D Asset('https://ozlabs.org/~joel/microbit-micropython=
.hex',
> +        '021641f93dfb11767d4978dbb3ca7f475d1b13c69e7f4aec3382f212636bffd=
6')
> +
> +    def test_arm_microbit(self):
> +        self.set_machine('microbit')
> +
> +        micropython =3D self.ASSET_MICRO.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-device', f'loader,file=3D{micropython}')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Type "help()" for more informati=
on.')
> +        exec_command_and_wait_for_pattern(self, 'import machine as mch',=
 '>>>')
> +        exec_command_and_wait_for_pattern(self, 'mch.reset()', 'MicroPyt=
hon')
> +        wait_for_console_pattern(self, '>>>')

We could do more if we wanted - all the microbit specific stuff lives in
the microbit module:

  https://microbit-micropython.readthedocs.io/en/latest/microbit_micropytho=
n_api.html

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

