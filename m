Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D552FE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 16:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRwCs-0004yC-LA; Sun, 29 Dec 2024 11:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRwCr-0004y3-ES
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:31:57 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRwCp-0007sj-Ju
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:31:57 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso14975652a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 08:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735489913; x=1736094713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdUjj2+n29/l86eI9xSDRR7fpkQ+03qRp5MqmJ5qmDE=;
 b=nkd2QqMX0pPTcDuiH4N69JCA/Vp65lssuJvF1VPk9Is4vlgMaj+qir8nBW3CJMQAh5
 OSKtqaxjfBEYF3ECi0pjQk16dsCu27ebKqVzmNTBf+h8ztdFDN9f1Tgu82WmO0oXum3g
 AQSJ8P1oiqpIsXiWfqig/TKHTXeO7LCPRDEmqoy/Dv86iNYyIbrimra6m72wlHmV0JAb
 lxSUC5yHzO8gM/HUAkCVfeX0mnpTTe8C1yqN75UyaOzrNeTfFQJTmjRo5Tz/NwOrGhYz
 mDAzyYczjEtla2gy4qrF1Oe0fI+H/g/CuyFVMyUq3JIEjYdrZ/wOUZTdRw+9gz6U7Pmh
 owaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735489913; x=1736094713;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PdUjj2+n29/l86eI9xSDRR7fpkQ+03qRp5MqmJ5qmDE=;
 b=FO6ZuJUQ2cPFZrwyGrEjlBcKV2aBdkS0J+pEwTUVCw9Qw2+XvCwqOJHQGcugf51P7s
 yq8CXDYDUl3fgZdtUjjfCyeH548EMEuvrJdgUK+HoPoOcqF0chwQMViV9SloZY991ffT
 Np4vYR+WZpHX6i8/mzLb4gF1fSaYlH4umfdADFEmu3THKESSteFxyvHFNrTT91IM5DBj
 CyD90OVTVxVTkrpcEM9y0kbGY3Ijs0SQ5pgfPrDK123XrWkYJYRo4unNDQAiKz9D7tMR
 E/rTFS/BmAzKsG13+vspyZaXtDTgFnicKMqdHygbHsTwy/Dl7XI1ISGPE3BnEpGNbfYU
 pBfw==
X-Gm-Message-State: AOJu0YztL8ot3EEUHPaVYaoukP5pX1pmUpfowRtmlXTQGNAIY5cKn4qn
 RZvYVIjxNdJehb/Xk/WbwKJmxQi8HWv/sAV0XwuaiQI+qjaZK0O16Yp5lmEIwFQ=
X-Gm-Gg: ASbGnct7znDOERwDlg6yBvMTQhwiE/8jb9rJhkfIPW/an7mTuawQtblO7xXRUKsJPth
 oJ1lIJ8N38MCFzzSdhKXN0OnaQn8juFFRPHLyfwrs52GOSIMK4PnNbqY08vupLmCA3LOVZYDKeY
 jEAzmZoNaRasF+Zsb0IenoUOe4d6Mdll/5dH+Y6Z2x1co3adK9yTgg3CTr6nD0nWLD3dp0CH69o
 YDunmIu1uG+8TcAOaEuWlxO+eyR5qAyAukSU5ywj9CTr6aQ95QCODU=
X-Google-Smtp-Source: AGHT+IEyG5W2X351R6GDmHkvD/lulsyeYKeGgLWLUOgbULTMblm1IN9P65WPOwCfKx3J2nNt5jOojQ==
X-Received: by 2002:a05:6402:4402:b0:5d2:60d9:a2a0 with SMTP id
 4fb4d7f45d1cf-5d81de5d896mr31638386a12.33.1735489911773; 
 Sun, 29 Dec 2024 08:31:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806fedbbasm14032070a12.71.2024.12.29.08.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2024 08:31:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD6655F7C6;
 Sun, 29 Dec 2024 16:31:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] tests/functional/test_rx_gdbsim: Use stable URL for
 test_linux_sash
In-Reply-To: <20241229083419.180423-1-huth@tuxfamily.org> (Thomas Huth's
 message of "Sun, 29 Dec 2024 09:34:19 +0100")
References: <20241229083419.180423-1-huth@tuxfamily.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sun, 29 Dec 2024 16:31:48 +0000
Message-ID: <87v7v2v4az.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Thomas Huth <huth@tuxfamily.org> writes:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Yoshinori said [*] URL references on OSDN were stable, but they
> appear not to be. Mirror the artifacts on GitHub to avoid failures
> while testing on CI.
>
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg686487.html
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-ID: <20200630202631.7345-1-f4bug@amsat.org>
> [huth: Adapt the patch to the new version in the functional framework]
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>

The test works but I'm definitely missing some of the console output
from the end:

  =E2=9E=9C  head ./tests/functional/rx/test_rx_gdbsim.RxGdbSimMachine.test=
_uboot/base.log
  2024-12-29 16:30:13,829 - DEBUG: Using cached asset /home/alex/.cache/qem=
u/download/dd7dd4220cccf7aeb32227b26233bf39600db05c3f8e26005bcc2bf6c927207d=
 for https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/u-=
boot.bin
  2024-12-29 16:30:13,829 - DEBUG: QEMUMachine "default" created
  2024-12-29 16:30:13,829 - DEBUG: QEMUMachine "default" temp_dir: /home/al=
ex/lsrc/qemu.git/builds/all/tests/functional/rx/test_rx_gdbsim.RxGdbSimMach=
ine.test_uboot/scratch/qemu-machine-pb_7irt4
  2024-12-29 16:30:13,829 - DEBUG: VM launch command: '/home/alex/lsrc/qemu=
.git/builds/all/qemu-system-rx -display none -vga none -chardev socket,id=
=3Dmon,fd=3D5 -mon chardev=3Dmon,mode=3Dcontrol -machine gdbsim-r5f562n8 -c=
hardev socket,id=3Dconsole,fd=3D10 -serial chardev:console -bios /home/alex=
/.cache/qemu/download/dd7dd4220cccf7aeb32227b26233bf39600db05c3f8e26005bcc2=
bf6c927207d -no-reboot'
  2024-12-29 16:30:13,857 - DEBUG: Console interaction: success_msg=3D'U-Bo=
ot 2016.05-rc3-23705-ga1ef3c71cb-dirty' failure_msg=3D'None' send_string=3D=
'None'
  2024-12-29 16:30:13,857 - DEBUG: Opening console socket
  2024-12-29 16:30:13,863 - DEBUG: Shutting down VM appliance; timeout=3D30
  2024-12-29 16:30:13,863 - DEBUG: Attempting graceful termination
  2024-12-29 16:30:13,863 - DEBUG: Closing console socket
  2024-12-29 16:30:13,863 - DEBUG: Politely asking QEMU to terminate
  =F0=9F=95=9916:31:20 alex@draig:qemu.git/builds/all  on =EE=82=A0 testing=
/next [$?]=20
  =E2=9E=9C  cat ./tests/functional/rx/test_rx_gdbsim.RxGdbSimMachine.test_=
uboot/console.log=20
  2024-12-29 16:30:13,859:=20
  2024-12-29 16:30:13,859:=20
  2024-12-29 16:30:13,863: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty
  =F0=9F=95=9916:31:32 alex@draig:qemu.git/builds/all  on =EE=82=A0 testing=
/next [$?]=20

> ---
>  tests/functional/test_rx_gdbsim.py | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_r=
x_gdbsim.py
> index 20623aa51c..49245793e1 100755
> --- a/tests/functional/test_rx_gdbsim.py
> +++ b/tests/functional/test_rx_gdbsim.py
> @@ -21,13 +21,16 @@ class RxGdbSimMachine(QemuSystemTest):
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>=20=20
>      ASSET_UBOOT =3D Asset(
> -        'https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz',
> -        '7146567d669e91dbac166384b29aeba1715beb844c8551e904b86831bfd9d04=
6')
> +        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/g=
dbsim/'
> +         'u-boot.bin'),
> +        'dd7dd4220cccf7aeb32227b26233bf39600db05c3f8e26005bcc2bf6c927207=
d')
>      ASSET_DTB =3D Asset(
> -        'https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb',
> +        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/g=
dbsim/'
> +         'rx-gdbsim.dtb'),
>          'aa278d9c1907a4501741d7ee57e7f65c02dd1b3e0323b33c6d4247f1b32cf29=
a')
>      ASSET_KERNEL =3D Asset(
> -        'http://acc.dl.osdn.jp/users/23/23845/zImage',
> +        ('https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/g=
dbsim/'
> +         'zImage'),
>          'baa43205e74a7220ed8482188c5e9ce497226712abb7f4e7e4f825ce19ff965=
6')
>=20=20
>      def test_uboot(self):
> @@ -36,7 +39,7 @@ def test_uboot(self):
>          """
>          self.set_machine('gdbsim-r5f562n8')
>=20=20
> -        uboot_path =3D self.uncompress(self.ASSET_UBOOT)
> +        uboot_path =3D self.ASSET_UBOOT.fetch()
>=20=20
>          self.vm.set_console()
>          self.vm.add_args('-bios', uboot_path,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

