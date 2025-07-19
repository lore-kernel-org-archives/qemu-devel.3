Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D045C83F34
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 10:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ud5Gu-00072V-57; Sat, 19 Jul 2025 06:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ud5Gs-00070v-Jk
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 06:58:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ud5Gq-0005Bt-5I
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 06:58:26 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-612a338aed8so4402984a12.1
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752922702; x=1753527502; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8Hm6/XgHGRBWMQZUMt9opfSeLhgLNJl99ffPwzT47U=;
 b=hD7Dkm2ctUMwWoH+hH5+r4VAQApskVCoROYHX1TCPHQEHg9VtGg+uN/KlKzkx+FEvE
 1VdDOBBYrud4y5XaRE4ChcIMg2W6EI04xpFCmTnJX19ILjNOKJkZmALHOdfZq0V20HeY
 ZcY8ebtxoOFB1O9xClBxvpxDv/35On4ps3wmkCmdoY1n8FFTtO3HH5DPSbQz5a604Dlp
 tVYqQB/U0yfy7jZB2FeQAujWdk5z9NNFtiuTyaIojHgpRATs5Gju/KNJlbi+Iz6mFsG7
 nHH+vfCQNSireFl0VhJr8WRr697Tg/OL82CNQgawPvDLKHVgFZiJVooj8NP/KpnOTVg3
 g8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752922702; x=1753527502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8Hm6/XgHGRBWMQZUMt9opfSeLhgLNJl99ffPwzT47U=;
 b=ceHhfSCkEmq4mVFENgJjn4DNDJ+FJ72NdcSVqDwFVJipaW6c8V02I7l6gWmVpTot2t
 VosiSTfSPd0REANbVvsXbtDkFrjJURxU13quX0zwGolaVxn7FKRvxMabfqvWs+uxjRz5
 flipRPPBFWgQAGdNElQSt2z/h8yHuiuLaaZ54uqHEPtNIGZnEK2o3Uv3MVEnqZ+/Y0tm
 DzUy4/8Ku3bjzXHSwgLlRm958N34bWeQSqLuWgxB9NFtrlHW7WyfbX9r8a5nQ6DxqzB4
 r3Zz6OK9047NZxwaZfu8VvMBQHw6eax++HJ7iWtMBvpCO4F2I+6KWBpAyPjS/a2Z8lj7
 EU9g==
X-Gm-Message-State: AOJu0Yzts0kSJd8ATkJebc9OvuTRUKFLueqAaMPVb3zSYwWWbdO+pIAH
 p033iGDSqaEGuPcLDGNYmaO+9jWQ19ijvacN420Phj2AP/BY00JED1ggYhgT/+keAyHLmWZNXGr
 lZRmUpb/A00uUzS1tcWnoqC8PLomxFpe5arw63qrWGg==
X-Gm-Gg: ASbGncv182sgh0rxgp+9i60K/8STNsmGx1PP9dfg37zsD1iSHdnNoNrG0ZIfHCQgGAE
 8kH8kJoupmjnw4uqOv2kMsuixkk0Hzea28EzLnyX3y+rWKtekdxOxhmiEP4/AoYocBEWOMVMkz0
 vcByMMWQrjUHoG1Y9Vfa9Q5Z23ZsDh11OlP9+LOrtobPqu75xxHsfl4MfTNWhlFZ9YdyGtyi7fW
 6ozow==
X-Google-Smtp-Source: AGHT+IEWx1W+d/87Grq7vp8nz/riltDZZm1o/2vsMip8rfU08kVFdrqhaJWYUU81VENT1mzZJwD7Y2ZsVaaFXjuZW+4=
X-Received: by 2002:a05:6402:2686:b0:612:dfdd:46fc with SMTP id
 4fb4d7f45d1cf-612dfdd49dcmr3101047a12.11.1752922697193; Sat, 19 Jul 2025
 03:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250719035838.2284029-1-pierrick.bouvier@linaro.org>
 <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
In-Reply-To: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sat, 19 Jul 2025 13:57:50 +0300
X-Gm-Features: Ac12FXy7utydUVTQE3qVBLVXqcnxMiMDp0pUqzyszsqjBQHfmnvwlFfFPuOqjDg
Message-ID: <CAAjaMXYRar1FnWSXqxRb1cKabWOXu2YxFi5B_JhypS0OZZ2LSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests/functional/test_aarch64_rme: update image
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, jean-philippe@linaro.org, 
 richard.henderson@linaro.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 gustavo.romero@linaro.org, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, Jul 19, 2025 at 7:00=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> TF-A needs to be patched to enable support for FEAT_TCR2 and
> FEAT_SCTLR2. This new image contains updated firmware.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/functional/test_aarch64_rme_sbsaref.py | 64 ++++++++-------
>  tests/functional/test_aarch64_rme_virt.py    | 85 +++++++-------------
>  2 files changed, 66 insertions(+), 83 deletions(-)
>
> diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functio=
nal/test_aarch64_rme_sbsaref.py
> index 746770e776d..cd6390b548a 100755
> --- a/tests/functional/test_aarch64_rme_sbsaref.py
> +++ b/tests/functional/test_aarch64_rme_sbsaref.py
> @@ -10,21 +10,23 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
>  import os
> +from os.path import join
> +import shutil
>
>  from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
>  from qemu_test import exec_command_and_wait_for_pattern
> -from test_aarch64_rme_virt import test_realms_guest
>
>
>  class Aarch64RMESbsaRefMachine(QemuSystemTest):
>
> -    # Stack is built with OP-TEE build environment from those instructio=
ns:
> +    # Stack is inspired from:
>      # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
> -    # https://github.com/pbo-linaro/qemu-rme-stack
> +    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_sbsa_relea=
se
> +    # ./build.sh && ./archive_artifacts.sh out.tar.xz
>      ASSET_RME_STACK_SBSA =3D Asset(
> -        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
> -         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
> -         'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c10499=
9e')
> +        ('https://github.com/pbo-linaro/qemu-linux-stack/'
> +         'releases/download/build/rme_sbsa_release-a7f02cf.tar.xz'),
> +         '27d8400b11befb828d6db0cab97e7ae102d0992c928d3dfbf38b24b6cf6c32=
4c')

Hi Pierrick, I got:

> qemu_test.asset.AssetError: https://github.com/pbo-linaro/qemu-linux-stac=
k/releases/download/build/rme_sbsa_release-a7f02cf.tar.xz: Download retries=
 exceeded

Maybe fileserver.linaro.org is a better option?

>      # This tests the FEAT_RME cpu implementation, by booting a VM suppor=
ting it,
>      # and launching a nested VM using it.
> @@ -35,35 +37,41 @@ def test_aarch64_rme_sbsaref(self):
>
>          self.vm.set_console()
>
> -        stack_path_tar_gz =3D self.ASSET_RME_STACK_SBSA.fetch()
> -        self.archive_extract(stack_path_tar_gz, format=3D"tar")
> +        stack_path_tar =3D self.ASSET_RME_STACK_SBSA.fetch()
> +        self.archive_extract(stack_path_tar, format=3D"tar")
>
> -        rme_stack =3D self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-s=
bsa')
> -        pflash0 =3D os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
> -        pflash1 =3D os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
> -        virtual =3D os.path.join(rme_stack, 'images', 'disks', 'virtual'=
)
> -        drive =3D os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ex=
t4')
> +        rme_stack =3D self.scratch_file('.')
> +        pflash0 =3D join(rme_stack, 'out', 'SBSA_FLASH0.fd')
> +        pflash1 =3D join(rme_stack, 'out', 'SBSA_FLASH1.fd')
> +        rootfs =3D join(rme_stack, 'out', 'host.ext4')
>
> -        self.vm.add_args('-cpu', 'max,x-rme=3Don,pauth-impdef=3Don')
> +        efi =3D join(rme_stack, 'out', 'EFI')
> +        os.mkdir(efi)
> +        shutil.copyfile(join(rme_stack, 'out', 'Image'), join(efi, 'Imag=
e'))
> +        with open(join(efi, 'startup.nsh'), 'w') as startup:
> +            startup.write('fs0:Image nokaslr root=3D/dev/vda rw init=3D/=
init --'
> +                          ' /host/out/lkvm run --realm'
> +                          ' -m 256m'
> +                          ' --restricted_mem'
> +                          ' --kernel /host/out/Image'
> +                          ' --disk /host/out/guest.ext4'
> +                          ' --params "root=3D/dev/vda rw init=3D/init"')
> +
> +        self.vm.add_args('-cpu', 'max,x-rme=3Don')
> +        self.vm.add_args('-smp', '2')
>          self.vm.add_args('-m', '2G')
>          self.vm.add_args('-M', 'sbsa-ref')
>          self.vm.add_args('-drive', f'file=3D{pflash0},format=3Draw,if=3D=
pflash')
>          self.vm.add_args('-drive', f'file=3D{pflash1},format=3Draw,if=3D=
pflash')
> -        self.vm.add_args('-drive', f'file=3Dfat:rw:{virtual},format=3Dra=
w')
> -        self.vm.add_args('-drive', f'format=3Draw,if=3Dnone,file=3D{driv=
e},id=3Dhd0')
> -        self.vm.add_args('-device', 'virtio-blk-pci,drive=3Dhd0')
> -        self.vm.add_args('-device', 'virtio-9p-pci,fsdev=3Dshr0,mount_ta=
g=3Dshr0')
> -        self.vm.add_args('-fsdev', f'local,security_model=3Dnone,path=3D=
{rme_stack},id=3Dshr0')
> -        self.vm.add_args('-device', 'virtio-net-pci,netdev=3Dnet0')
> -        self.vm.add_args('-netdev', 'user,id=3Dnet0')
> -
> +        self.vm.add_args('-drive', f'file=3Dfat:rw:{efi},format=3Draw')
> +        self.vm.add_args('-drive', f'format=3Draw,file=3D{rootfs},if=3Dv=
irtio')
> +        self.vm.add_args('-virtfs',
> +                         f'local,path=3D{rme_stack}/,mount_tag=3Dhost,'
> +                         'security_model=3Dmapped,readonly=3Doff')
>          self.vm.launch()
> -        # Wait for host VM boot to complete.
> -        wait_for_console_pattern(self, 'Welcome to Buildroot',
> -                                 failure_message=3D'Synchronous Exceptio=
n at')
> -        exec_command_and_wait_for_pattern(self, 'root', '#')
> -
> -        test_realms_guest(self)
> +        # Wait for host and guest VM boot to complete.
> +        wait_for_console_pattern(self, 'root@guest',
> +                                 failure_message=3D'Kernel panic')
>
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()
> diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional=
/test_aarch64_rme_virt.py
> index 8452d27928f..bb603aaa26c 100755
> --- a/tests/functional/test_aarch64_rme_virt.py
> +++ b/tests/functional/test_aarch64_rme_virt.py
> @@ -9,50 +9,22 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
> -import os
> +from os.path import join
>
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import exec_command, wait_for_console_pattern
>  from qemu_test import exec_command_and_wait_for_pattern
>
> -def test_realms_guest(test_rme_instance):
> -
> -    # Boot the (nested) guest VM
> -    exec_command(test_rme_instance,
> -                 'qemu-system-aarch64 -M virt,gic-version=3D3 '
> -                 '-cpu host -enable-kvm -m 512M '
> -                 '-M confidential-guest-support=3Drme0 '
> -                 '-object rme-guest,id=3Drme0 '
> -                 '-device virtio-net-pci,netdev=3Dnet0,romfile=3D '
> -                 '-netdev user,id=3Dnet0 '
> -                 '-kernel /mnt/out/bin/Image '
> -                 '-initrd /mnt/out-br/images/rootfs.cpio '
> -                 '-serial stdio')
> -    # Detect Realm activation during (nested) guest boot.
> -    wait_for_console_pattern(test_rme_instance,
> -                             'SMC_RMI_REALM_ACTIVATE')
> -    # Wait for (nested) guest boot to complete.
> -    wait_for_console_pattern(test_rme_instance,
> -                             'Welcome to Buildroot')
> -    exec_command_and_wait_for_pattern(test_rme_instance, 'root', '#')
> -    # query (nested) guest cca report
> -    exec_command(test_rme_instance, 'cca-workload-attestation report')
> -    wait_for_console_pattern(test_rme_instance,
> -                             '"cca-platform-hash-algo-id": "sha-256"')
> -    wait_for_console_pattern(test_rme_instance,
> -                             '"cca-realm-hash-algo-id": "sha-512"')
> -    wait_for_console_pattern(test_rme_instance,
> -                             '"cca-realm-public-key-hash-algo-id": "sha-=
256"')
> -
>  class Aarch64RMEVirtMachine(QemuSystemTest):
>
> -    # Stack is built with OP-TEE build environment from those instructio=
ns:
> +    # Stack is inspired from:
>      # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
> -    # https://github.com/pbo-linaro/qemu-rme-stack
> +    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_release
> +    # ./build.sh && ./archive_artifacts.sh out.tar.xz
>      ASSET_RME_STACK_VIRT =3D Asset(
> -        ('https://fileserver.linaro.org/s/iaRsNDJp2CXHMSJ/'
> -         'download/rme-stack-op-tee-4.2.0-cca-v4-qemu_v8.tar.gz'),
> -         '1851adc232b094384d8b879b9a2cfff07ef3d6205032b85e9b3a4a9ae6b0b7=
ad')
> +        ('https://github.com/pbo-linaro/qemu-linux-stack/'
> +         'releases/download/build/rme_release-86101e5.tar.xz'),
> +         'e42fef8439badb52a071ac446fc33cff4cb7d61314c7a28fdbe61a11e1faad=
3a')
>
>      # This tests the FEAT_RME cpu implementation, by booting a VM suppor=
ting it,
>      # and launching a nested VM using it.
> @@ -63,15 +35,16 @@ def test_aarch64_rme_virt(self):
>
>          self.vm.set_console()
>
> -        stack_path_tar_gz =3D self.ASSET_RME_STACK_VIRT.fetch()
> -        self.archive_extract(stack_path_tar_gz, format=3D"tar")
> +        stack_path_tar =3D self.ASSET_RME_STACK_VIRT.fetch()
> +        self.archive_extract(stack_path_tar, format=3D"tar")
>
> -        rme_stack =3D self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-q=
emu_v8')
> -        kernel =3D os.path.join(rme_stack, 'out', 'bin', 'Image')
> -        bios =3D os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
> -        drive =3D os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ex=
t4')
> +        rme_stack =3D self.scratch_file('.')
> +        kernel =3D join(rme_stack, 'out', 'Image')
> +        bios =3D join(rme_stack, 'out', 'flash.bin')
> +        rootfs =3D join(rme_stack, 'out', 'host.ext4')
>
> -        self.vm.add_args('-cpu', 'max,x-rme=3Don,pauth-impdef=3Don')
> +        self.vm.add_args('-cpu', 'max,x-rme=3Don')
> +        self.vm.add_args('-smp', '2')
>          self.vm.add_args('-m', '2G')
>          self.vm.add_args('-M', 'virt,acpi=3Doff,'
>                           'virtualization=3Don,'
> @@ -79,23 +52,25 @@ def test_aarch64_rme_virt(self):
>                           'gic-version=3D3')
>          self.vm.add_args('-bios', bios)
>          self.vm.add_args('-kernel', kernel)
> -        self.vm.add_args('-drive', f'format=3Draw,if=3Dnone,file=3D{driv=
e},id=3Dhd0')
> -        self.vm.add_args('-device', 'virtio-blk-pci,drive=3Dhd0')
> -        self.vm.add_args('-device', 'virtio-9p-device,fsdev=3Dshr0,mount=
_tag=3Dshr0')
> -        self.vm.add_args('-fsdev', f'local,security_model=3Dnone,path=3D=
{rme_stack},id=3Dshr0')
> -        self.vm.add_args('-device', 'virtio-net-pci,netdev=3Dnet0')
> -        self.vm.add_args('-netdev', 'user,id=3Dnet0')
> +        self.vm.add_args('-drive', f'format=3Draw,file=3D{rootfs},if=3Dv=
irtio')
> +        self.vm.add_args('-virtfs',
> +                         f'local,path=3D{rme_stack}/,mount_tag=3Dhost,'
> +                         'security_model=3Dmapped,readonly=3Doff')
>          # We need to add nokaslr to avoid triggering this sporadic bug:
>          # https://gitlab.com/qemu-project/qemu/-/issues/2823
> -        self.vm.add_args('-append', 'root=3D/dev/vda nokaslr')
> +        self.vm.add_args('-append',
> +                         'nokaslr root=3D/dev/vda rw init=3D/init --'
> +                         ' /host/out/lkvm run --realm'
> +                         ' -m 256m'
> +                         ' --restricted_mem'
> +                         ' --kernel /host/out/Image'
> +                         ' --disk /host/out/guest.ext4'
> +                         ' --params "root=3D/dev/vda rw init=3D/init"')
>
>          self.vm.launch()
> -        # Wait for host VM boot to complete.
> -        wait_for_console_pattern(self, 'Welcome to Buildroot',
> -                                 failure_message=3D'Synchronous Exceptio=
n at')
> -        exec_command_and_wait_for_pattern(self, 'root', '#')
> -
> -        test_realms_guest(self)
> +        # Wait for host and guest VM boot to complete.
> +        wait_for_console_pattern(self, 'root@guest',
> +                                 failure_message=3D'Kernel panic')
>
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()
> --
> 2.47.2
>
>

