Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31D3D58D75
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 18:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdOC-0005ke-Hc; Mon, 25 Nov 2024 13:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFdO0-0005f5-IE
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:00:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFdNy-0003HH-LF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:00:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a2033562so5771765e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 10:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732557633; x=1733162433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ac0iysu/ahEQUXIHfh0YrxOEs55it9ZquFHoKqSfZiU=;
 b=FX5u8Zc55yfzBk6HzCQ7kul0PTWj3OQbbI2YI3bG02JJZ+xeg6/kRobWa92kX34gZz
 lrXkbq4Eh//Waf3Ix6wuvybn7GWNJyysYGGsBviY5cQjVyPJtW1eHrt+JGS4pctu3AlD
 w3c/MKCrP8Ox+ZFgvA/JCOIZLhXBAM59ZvTczZkK0kz4Ejk0z/y+/rexaz4jWoYNTn6V
 W8mc+Gt/hS0SenVszU/RmLWhPEvhQWW1bTSJC8vj7hJ6z1BrijfIVOUQ0KE5Vnvg+V1u
 zgear97Vo6uWixTFtEUc/PS/Yu5tVdldjT/o9Dn13lU5fA5TxPv3GxbdIDtLKxJYKdAi
 OXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557633; x=1733162433;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ac0iysu/ahEQUXIHfh0YrxOEs55it9ZquFHoKqSfZiU=;
 b=QQJmxUgBaMVVTyOjkOuxE4xmX/WCxSD7TnM/oV08KiVsKULDCpBQat6PBx2yVjI9HZ
 hdhzrYKvv6q6/p5F/+RYhr4zJeTB0+N0hgBuI6rVku1zvj5Av8kjqJmk4BG1AsEMpfR0
 m98VbOWfkeFjXZPPqAHumeSCGkOBnJPZEF1XqkZa0aL6jaHfP53Dtx54pCgCDvcZTPfD
 qPv30UN5b/H4PC9vMBmJnslwCMJLAvidij7/w22fub2AXFT7cw/7VJmo68mO+1Ngxw1Y
 dQAtIlQSIWKHNQso3kALKdxD2rojtfGTwXluxI1nnFkM1eFC2VSxjkD4D/CgHwVAQBZ7
 qPPg==
X-Gm-Message-State: AOJu0YwXGQARSA8jElXvFNEyH4VZuS2tLzkO/W05XebyDPztlODCxh+W
 qck+GAAS+1mYBrpQ5/yQUGQUBqN1BDINJ5oA31KODbpgBgmv1fyYkiZBHNL0yMo=
X-Gm-Gg: ASbGncu6vZkyWoTZjudl7LpDUBidALGFxj2mjExLotTnv/8T9/au2izUHS2CbWwDgFz
 4EHDfGAR9CsicaYKk2Em4FaBoAXeW2LnuWvwZTE9o0QUA8EFEbJ6JehDnnLe58TAjPTBFCpt4hp
 Imdq2P+nUoPkiv0hJT+tJ0Wusx7hFUcrT7ocvMtASofDiBD4QJylXa1vur8MVtFB4Hy7jqNtM6e
 ItaSB4bu1eaEFG7DCHO+RIauxsgqXKuR/dNufu8izcV0oZl
X-Google-Smtp-Source: AGHT+IEdxyrvsmKoayoYbDsyscH4yKCHtcGWoou7tUuJQpR+jBjgeEhFMeMqPnr9elyMvWW345FLMw==
X-Received: by 2002:a05:600c:3b97:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-433ce4e7b6amr132044715e9.30.1732557632245; 
 Mon, 25 Nov 2024 10:00:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432f643e65bsm181717675e9.0.2024.11.25.10.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 10:00:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA1725F869;
 Mon, 25 Nov 2024 18:00:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  mathieu.poirier@linaro.org,
 gustavo.romero@linaro.org,  jean-philippe@linaro.org,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/functional/aarch64_virt: add test for FEAT_RME
In-Reply-To: <20241125065950.1179068-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sun, 24 Nov 2024 22:59:50 -0800")
References: <20241125065950.1179068-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 25 Nov 2024 18:00:29 +0000
Message-ID: <8734jfchxe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This boot an OP-TEE environment, and launch a nested guest VM inside it
> using the Realms feature.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/functional/test_aarch64_virt.py | 62 +++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/tes=
t_aarch64_virt.py
> index 30bab5a677c..3e8f9372132 100755
> --- a/tests/functional/test_aarch64_virt.py
> +++ b/tests/functional/test_aarch64_virt.py
> @@ -18,6 +18,7 @@
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import exec_command, wait_for_console_pattern
>  from qemu_test import get_qemu_img, run_cmd
> +from qemu_test.utils import archive_extract
>=20=20
>=20=20
>  class Aarch64VirtMachine(QemuSystemTest):
> @@ -129,6 +130,67 @@ def test_aarch64_virt_gicv2(self):
>          return
>          self.common_aarch64_virt("virt,gic-version=3D2")
>=20=20
> +    # Stack is built with OP-TEE build environment from those instructio=
ns:
> +    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
> +    # https://github.com/pbo-linaro/qemu-rme-stack
> +    ASSET_RME_STACK =3D Asset(
> +        ('https://fileserver.linaro.org/s/JX7oNgfDeGXSxcY/'
> +         'download/rme-stack-op-tee-4.2.0.tar.gz'),
> +         '1f240f55e8a7a66489c2b7db5d40391e5dcfdd54c82600bd0d4b2145b9a0fb=
fb')
> +
> +    # This tests the FEAT_RME cpu implementation, by booting a VM suppor=
ting it,
> +    # and launching a nested VM using it.
> +    def test_aarch64_virt_rme(self):
> +        stack_path_tar_gz =3D self.ASSET_RME_STACK.fetch()
> +        archive_extract(stack_path_tar_gz, self.workdir)
> +
> +        self.set_machine('virt')
> +        self.vm.set_console()
> +        self.require_accelerator('tcg')
> +
> +        rme_stack =3D os.path.join(self.workdir, 'rme-stack')
> +        kernel =3D os.path.join(rme_stack, 'out', 'bin', 'Image')
> +        bios =3D os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
> +        drive =3D os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ex=
t4')
> +
> +        self.vm.add_args('-accel', 'tcg')
> +        self.vm.add_args('-cpu', 'max,x-rme=3Don')
> +        self.vm.add_args('-m', '2048')
> +        self.vm.add_args('-M', 'virt,acpi=3Doff,'
> +                         'virtualization=3Don,'
> +                         'secure=3Don,'
> +                         'gic-version=3D3')
> +        self.vm.add_args('-bios', bios)
> +        self.vm.add_args('-kernel', kernel)
> +        self.vm.add_args('-drive', f'format=3Draw,if=3Dnone,file=3D{driv=
e},id=3Dhd0')
> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=3Dhd0')
> +        self.vm.add_args('-device', 'virtio-9p-device,fsdev=3Dshr0,mount=
_tag=3Dshr0')
> +        self.vm.add_args('-fsdev', f'local,security_model=3Dnone,path=3D=
{rme_stack},id=3Dshr0')
> +        self.vm.add_args('-device', 'virtio-net-pci,netdev=3Dnet0')
> +        self.vm.add_args('-netdev', 'user,id=3Dnet0')
> +        self.vm.add_args('-append', 'root=3D/dev/vda')
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Welcome to Buildroot')
> +        time.sleep(0.1)
> +        exec_command(self, 'root')
> +        time.sleep(0.1)
> +
> +        # We now boot the (nested) guest VM
> +        exec_command(self,
> +                     'qemu-system-aarch64 -M virt,gic-version=3D3 '
> +                     '-cpu host -enable-kvm -m 512M '
> +                     '-M confidential-guest-support=3Drme0 '
> +                     '-object rme-guest,id=3Drme0,measurement-algo=3Dsha=
512 '
> +                     '-device virtio-net-pci,netdev=3Dnet0,romfile=3D '
> +                     '-netdev user,id=3Dnet0 '
> +                     '-kernel /mnt/out/bin/Image '
> +                     '-initrd /mnt/out-br/images/rootfs.cpio '
> +                     '-serial stdio')
> +        # Detect Realm activation during boot.
> +        self.wait_for_console_pattern('SMC_RMI_REALM_ACTIVATE')
> +        # Wait for boot to complete.
> +        self.wait_for_console_pattern('Welcome to Buildroot')

This is the same as above? Or the console of the guest?

Could we also check the output of the other serial posts?

>=20=20
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

