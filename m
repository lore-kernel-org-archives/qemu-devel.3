Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B761EC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulozj-0003rA-Pe; Tue, 12 Aug 2025 09:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulozg-0003qX-U2
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:24:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulozX-0000GD-TM
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:24:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b77b8750acso3421412f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755005075; x=1755609875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZN+G4bdnVDkkg3blN5USgtqbA/I/5juzqd04yuSpCZE=;
 b=DjOIQJ7ipqxxyn+hdO2dSdxbr779GGgXa5DrnHHfwmZp1In3vMdGlruFOxIQ5WqqaE
 JlRrWn0oGvoljCiILX139WfZ+3PZK2zeebqy4FpfcjSAHO6mHMHPrx63pZrp84YNpI+v
 svpKE161ng1FPv8kC/wLm/VOqg3QCC+i08Udo166tpu3YiQAxWuAvPIOrYnudQ7O5OKz
 /M9qKBY43I4riIQTVKU8BMjSu/onVg1occwJukwXhVj77RG3lWdfE88fOKU/7Dz6Kunv
 rNc9cQIQgpRNljr8X10gemLHOb+YmhLBZYBENFO9NlTBvYNXqADqba91Bmh5JMeMAMyQ
 gSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755005075; x=1755609875;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZN+G4bdnVDkkg3blN5USgtqbA/I/5juzqd04yuSpCZE=;
 b=CoocUeaj87yOD1iTHa4FHISqSa3qO0PQvaoufEAluNF9oVSIMjPMHdXlzP2SDfgM1C
 d1HaczGlRyULy9k8+j05kOPuKUtkZXEfn9H7kNX/zC25Nknh40WxT+s4LcX1IgHNGw3S
 2kyFUlabhub6+y+KCEq4I+VYtuy1mYP11VtFczoWiB+/Z3t+5ZYu2F6u9aztbbXWV7Ga
 PnCiHgkWdpnCMTVsWj9ZrmaLj7kSmXgzqSzsKOdbNgs0bhFLHQAlkZAVVzOuMAFK6lxP
 KIxIbntK9kgJ3zYA2Op/ISlQ6ZX/M/5BCRBFOcekcf/9FN4pfOLkmak++x4OU2LM99c0
 nmWw==
X-Gm-Message-State: AOJu0Yw0kFhv6p5evwEDC60Wp7YAA3vMjHQrlOzyJDJQVQaMXmdRwld8
 lm+lEkVvrUNd0QuBI5pZi+9pouy6Wa8a306mHHW9EqupMep7wrngXRCC3Tqfa3QfYJw=
X-Gm-Gg: ASbGncsTJpdzrM+CH71XHxq6dBDdbWbhaOTS4r97/Y69Q9kei81vJuiHmYYF/+JtSN0
 P/zoaRqY8RlM57lU18nAp0h6+FIpVxEcV2KaQOL9HxV/CAUBRUjaRCPsIGZuv4M4auz4kDDeEdx
 bzLgSs+XUCgLNhqi0sI5vy2767b/4oIqMfLj4B8ld82M4W4jod2O1VKWegs3nRzbAqcBAXuYw7e
 3G2czPetlLaSYmmYx1Vse/JrJl0k5mvm7ZTIjYgWm8uy8xhBX6rAj1tG8Xob5h/c0OW1HPIZLh8
 zOUeVZJpQV34S4mki8JthEWOJ4Thy8tDKuIX8/5RDwEjbli6XYFldMf67nDk4QNSnT5iBF1E4wc
 dWhZcbattQLe+9jflNwTY3vI=
X-Google-Smtp-Source: AGHT+IHaG8uH2AbKqVVFG3ka0aCa7k7o2q03IIuljqDKt2uFb8zKZceqQMIOBcDmpqvjajVYVFfrFw==
X-Received: by 2002:a05:6000:2484:b0:3b7:910d:8054 with SMTP id
 ffacd0b85a97d-3b911160e86mr2730682f8f.11.1755005075262; 
 Tue, 12 Aug 2025 06:24:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47c516sm44608296f8f.62.2025.08.12.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 06:24:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46EA75F7F3;
 Tue, 12 Aug 2025 14:24:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Guenter Roeck <linux@roeck-us.net>,
 qemu-riscv@nongnu.org,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Bin
 Meng <bmeng.cn@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH-for-10.1 2/2] tests/functional: Test SPI-SD adapter
 without SD card connected
In-Reply-To: <20250808135115.77310-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Aug 2025 15:51:15
 +0200")
References: <20250808135115.77310-1-philmd@linaro.org>
 <20250808135115.77310-3-philmd@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 12 Aug 2025 14:24:33 +0100
Message-ID: <87ikisad0u.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> SPI-SD adapter should be usable, even without any SD card
> wired. Refactor test_riscv64_sifive_u_mmc_spi() to make it
> more generic and add another test, inspired by this report:
> https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@r=
oeck-us.net/
>
> Inspired-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/tests/functional/test_riscv64_sifive_u.py b/tests/functional=
/test_riscv64_sifive_u.py
> index dc4cb8a4a96..f7ab1abfd56 100755
> --- a/tests/functional/test_riscv64_sifive_u.py
> +++ b/tests/functional/test_riscv64_sifive_u.py
> @@ -27,25 +27,37 @@ class SifiveU(LinuxKernelTest):
>           'rootfs.ext2.gz'),
>          'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28=
b')
>=20=20
> -    def test_riscv64_sifive_u_mmc_spi(self):
> +    def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
>          self.set_machine('sifive_u')
>          kernel_path =3D self.ASSET_KERNEL.fetch()
>          rootfs_path =3D self.uncompress(self.ASSET_ROOTFS)
>=20=20
>          self.vm.set_console()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> -                               'root=3D/dev/mmcblk0 rootwait '
>                                 'earlycon=3Dsbi console=3DttySIF0 '
> -                               'panic=3D-1 noreboot')
> +                               'root=3D/dev/mmcblk0 ')
>          self.vm.add_args('-kernel', kernel_path,
> -                         '-drive', f'file=3D{rootfs_path},if=3Dsd,format=
=3Draw',
>                           '-append', kernel_command_line,
>                           '-no-reboot')
> +        if connect_card:
> +            self.vm.add_args('-drive', f'file=3D{rootfs_path},if=3Dsd,fo=
rmat=3Draw')
> +            kernel_command_line +=3D 'panic=3D-1 noreboot rootwait '
> +            pattern =3D 'Boot successful.'
> +        else:
> +            kernel_command_line +=3D 'panic=3D0 noreboot '
> +            pattern =3D 'Cannot open root device "mmcblk0" or unknown-bl=
ock(0,0)'
> +
>          self.vm.launch()
> -        self.wait_for_console_pattern('Boot successful.')
> +        self.wait_for_console_pattern(pattern)
>=20=20
>          os.remove(rootfs_path)
>=20=20
> +    def _test_riscv64_sifive_u_nommc_spi(self):
> +        self.do_test_riscv64_sifive_u_mmc_spi(False)

This test won't run because of the leading _

> +
> +    def test_riscv64_sifive_u_mmc_spi(self):
> +        self.do_test_riscv64_sifive_u_mmc_spi(True)
> +
>=20=20
>  if __name__ =3D=3D '__main__':
>      LinuxKernelTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

