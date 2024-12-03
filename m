Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722ECE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVE9-0003Da-Av; Tue, 03 Dec 2024 10:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIVE7-0003D6-6W
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:54:15 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIVE4-0002mE-Rp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:54:14 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so48486725e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733241250; x=1733846050; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WXH/s/ip8BsiNVAtl+QTmTFjS9rg6DwOtbG5SDcWnkI=;
 b=XcgScwX0Gshw6tm8EzLM3MtkyVbeBeDdSJi2RKJ+H4iC5yW0pnn4BQepzAuUZdWcci
 +3aSOqBbg6ephx9w65KCkaKg7srYWDTnNJc0C+DcKcc72DI4IaLRBGVBGQ6bcoV+6W2j
 8o+q0PZ8CTifc9PNj8RJjTAODwtUjrCh0rl7mMfSfMgOarhs7I4SmrC2Wm7zFu8ebOdz
 zlUGxamFVyWbkEtYDG2/kJoWMGzg5L3h8aTvw++AIVhwZwhfXj3RIdZy8+SzCK8x0B2l
 a06x5C5B483OjEczg3GLYCB5Im0djdY8BdZF78xh79YRtb/EYipBpMBBj2OLyi7sbw4h
 N+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241250; x=1733846050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXH/s/ip8BsiNVAtl+QTmTFjS9rg6DwOtbG5SDcWnkI=;
 b=HJ61UAIjUGksDSl4yRaDiIm5ZgukMjl9gMjeEQhoaMMNAVyAPeawPNFWO8zm1kAkXU
 gXR4hN5k/I0r6TI4ftJJ7bDAVdK86TosA2DaMZyBcEs6OEsjVYFicIDO3xNLv/b6iSJn
 J87tGx08oQA3CbON1DpeVKyK6UgHwiohgHT/OOvxYMX49tVmdOGVLjpxm4BkW6ubsSix
 ELmQMkX2q1DevV3m0sVjSfeY5ZJwiRhNLt0GDtXqx3Eqpz6gIL1eJfKhx9aHT6CWvTmF
 7tIg+I+uKRMh/E9jNNQiq7DCKdBV8QtdK+BguGLyPWY8sCiLCTFU6ASc1ChI4jlMom86
 wKuA==
X-Gm-Message-State: AOJu0YyYIYaRxOJIqsZTLTv7qKW2EhVLWz0bC1SC/4ygWi40AN9+xEEc
 5LIcwKJeMbAdSP0dmPYS4E1uAG2WjrrrYrSL5/sk25OdOqC34uiWM6rxYgfd7tI=
X-Gm-Gg: ASbGnct/d+alHeiiOX4IQTX8+fmixf3M6YWcoDZa3b4j6hdm6v9ooJIO0Esz+L/yFoJ
 02NX9udsM+d/SY+CS+TBhJ9R2YUDpC7PnogzXMthCPO9vgMcWSlTeTN//Dl8D7QWySLSM/3krYX
 RwHFYLNO8H5b/TeWqXB2VK6HOqvHvAol3bUOkLrBi2acILZq+EYzjV2CyLu99roiLIW7xltF7iZ
 EFtVpqwYPQBUiV5vnHPwDfsDD4ZbDN3OyswXW/V0GaWeTsQ
X-Google-Smtp-Source: AGHT+IFnyN+Vr6xTMF9G8jhDQLxpEJ4sTI9bFWDZYtPPwTa1OrwH0AryMYoMj7aOaiIl7eX2oy2MDg==
X-Received: by 2002:a05:600c:1994:b0:434:a1d3:a326 with SMTP id
 5b1f17b1804b1-434d09b1473mr28058655e9.6.1733241250239; 
 Tue, 03 Dec 2024 07:54:10 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dbf9f5sm191729705e9.16.2024.12.03.07.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 07:54:09 -0800 (PST)
Date: Tue, 3 Dec 2024 15:54:34 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, marcin.juszkiewicz@linaro.org,
 gustavo.romero@linaro.org, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, mathieu.poirier@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3] tests/functional/aarch64: add tests for FEAT_RME
Message-ID: <20241203155434.GB1903051@myrica>
References: <20241203001741.2068452-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203001741.2068452-1-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
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

On Mon, Dec 02, 2024 at 04:17:41PM -0800, Pierrick Bouvier wrote:
> This boot an OP-TEE environment, and launch a nested guest VM inside it
> using the Realms feature. We do it for virt and sbsa-ref platforms.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> -----
> 
> v2:
> - move test to its own file
> - add sbsa test
> - check output of `cca-workload-attestation report`
> 
> v3:
> - build and run test with cca-v4 images
> - factorize nested guest test between both tests
> - remove accel tcg option as it is the default when running tests
> Note: It's a long test and there is a work in progress to understand why
> debug build is so slow (x12 vs optimized).

Can the functional tests take as long as we want, or are they regularly
run by a CI?

The `cca-workload-attestation report` command is great for making sure the
RME feature is working and the guest is running in a Realm, and it's very
light. In my opinion it's sufficient here.

We could also run kvm-unit-tests on the host, various VM payloads and
configs (in particular edk2 boot), and performing local attestation, but
those would all be testing the other software components, so don't seem
relevant to this functional test of the QEMU emulator. That said we do
need regression tests for the whole software stack (including QEMU VMM)
and this test automation is really convenient so I'd like to extend it
with extra tests but outside the QEMU codebase.

Thanks,
Jean

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/functional/meson.build                 |   4 +
>  tests/functional/test_aarch64_rme_sbsaref.py |  70 +++++++++++++
>  tests/functional/test_aarch64_rme_virt.py    | 100 +++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
>  create mode 100755 tests/functional/test_aarch64_rme_virt.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 5c048cfac6d..b975a1560df 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -13,6 +13,8 @@ endif
>  test_timeouts = {
>    'aarch64_aspeed' : 600,
>    'aarch64_raspi4' : 480,
> +  'aarch64_rme_virt' : 720,
> +  'aarch64_rme_sbsaref' : 720,
>    'aarch64_sbsaref_alpine' : 720,
>    'aarch64_sbsaref_freebsd' : 720,
>    'aarch64_tuxrun' : 240,
> @@ -52,6 +54,8 @@ tests_aarch64_system_thorough = [
>    'aarch64_aspeed',
>    'aarch64_raspi3',
>    'aarch64_raspi4',
> +  'aarch64_rme_virt',
> +  'aarch64_rme_sbsaref',
>    'aarch64_sbsaref',
>    'aarch64_sbsaref_alpine',
>    'aarch64_sbsaref_freebsd',
> diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
> new file mode 100755
> index 00000000000..398562c166f
> --- /dev/null
> +++ b/tests/functional/test_aarch64_rme_sbsaref.py
> @@ -0,0 +1,70 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Realms environment on sbsa-ref machine and a
> +# nested guest VM using it.
> +#
> +# Copyright (c) 2024 Linaro Ltd.
> +#
> +# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import time
> +import os
> +import logging
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command, wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test.utils import archive_extract
> +from test_aarch64_rme_virt import test_realms_guest
> +
> +class Aarch64RMESbsaRefMachine(QemuSystemTest):
> +
> +    # Stack is built with OP-TEE build environment from those instructions:
> +    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
> +    # https://github.com/pbo-linaro/qemu-rme-stack
> +    ASSET_RME_STACK_SBSA = Asset(
> +        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
> +         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
> +         'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c104999e')
> +
> +    # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
> +    # and launching a nested VM using it.
> +    def test_aarch64_rme_sbsaref(self):
> +        stack_path_tar_gz = self.ASSET_RME_STACK_SBSA.fetch()
> +        archive_extract(stack_path_tar_gz, self.workdir)
> +
> +        self.set_machine('sbsa-ref')
> +        self.vm.set_console()
> +        self.require_accelerator('tcg')
> +
> +        rme_stack = os.path.join(self.workdir,
> +                                 'rme-stack-op-tee-4.2.0-cca-v4-sbsa')
> +        pflash0 = os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
> +        pflash1 = os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
> +        virtual = os.path.join(rme_stack, 'images', 'disks', 'virtual')
> +        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
> +
> +        self.vm.add_args('-cpu', 'max,x-rme=on')
> +        self.vm.add_args('-m', '2G')
> +        self.vm.add_args('-M', 'sbsa-ref')
> +        self.vm.add_args('-drive', f'file={pflash0},format=raw,if=pflash')
> +        self.vm.add_args('-drive', f'file={pflash1},format=raw,if=pflash')
> +        self.vm.add_args('-drive', f'file=fat:rw:{virtual},format=raw')
> +        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
> +        self.vm.add_args('-device', 'virtio-9p-pci,fsdev=shr0,mount_tag=shr0')
> +        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
> +        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
> +        self.vm.add_args('-netdev', 'user,id=net0')
> +
> +        self.vm.launch()
> +        # Wait for host VM boot to complete.
> +        wait_for_console_pattern(self, 'Welcome to Buildroot')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +
> +        test_realms_guest(self)
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
> new file mode 100755
> index 00000000000..be240c691c2
> --- /dev/null
> +++ b/tests/functional/test_aarch64_rme_virt.py
> @@ -0,0 +1,100 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Realms environment on virt machine and a nested
> +# guest VM using it.
> +#
> +# Copyright (c) 2024 Linaro Ltd.
> +#
> +# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import time
> +import os
> +import logging
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command, wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test.utils import archive_extract
> +
> +def test_realms_guest(test_rme_instance):
> +
> +    # Boot the (nested) guest VM
> +    exec_command(test_rme_instance,
> +                 'qemu-system-aarch64 -M virt,gic-version=3 '
> +                 '-cpu host -enable-kvm -m 512M '
> +                 '-M confidential-guest-support=rme0 '
> +                 '-object rme-guest,id=rme0 '
> +                 '-device virtio-net-pci,netdev=net0,romfile= '
> +                 '-netdev user,id=net0 '
> +                 '-kernel /mnt/out/bin/Image '
> +                 '-initrd /mnt/out-br/images/rootfs.cpio '
> +                 '-serial stdio')
> +    # Detect Realm activation during (nested) guest boot.
> +    wait_for_console_pattern(test_rme_instance,
> +                             'SMC_RMI_REALM_ACTIVATE')
> +    # Wait for (nested) guest boot to complete.
> +    wait_for_console_pattern(test_rme_instance,
> +                             'Welcome to Buildroot')
> +    exec_command_and_wait_for_pattern(test_rme_instance, 'root', '#')
> +    # query (nested) guest cca report
> +    exec_command(test_rme_instance, 'cca-workload-attestation report')
> +    wait_for_console_pattern(test_rme_instance,
> +                             '"cca-platform-hash-algo-id": "sha-256"')
> +    wait_for_console_pattern(test_rme_instance,
> +                             '"cca-realm-hash-algo-id": "sha-512"')
> +    wait_for_console_pattern(test_rme_instance,
> +                             '"cca-realm-public-key-hash-algo-id": "sha-256"')
> +
> +class Aarch64RMEVirtMachine(QemuSystemTest):
> +
> +    # Stack is built with OP-TEE build environment from those instructions:
> +    # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
> +    # https://github.com/pbo-linaro/qemu-rme-stack
> +    ASSET_RME_STACK_VIRT = Asset(
> +        ('https://fileserver.linaro.org/s/iaRsNDJp2CXHMSJ/'
> +         'download/rme-stack-op-tee-4.2.0-cca-v4-qemu_v8.tar.gz'),
> +         '1851adc232b094384d8b879b9a2cfff07ef3d6205032b85e9b3a4a9ae6b0b7ad')
> +
> +    # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
> +    # and launching a nested VM using it.
> +    def test_aarch64_rme_virt(self):
> +        stack_path_tar_gz = self.ASSET_RME_STACK_VIRT.fetch()
> +        archive_extract(stack_path_tar_gz, self.workdir)
> +
> +        self.set_machine('virt')
> +        self.vm.set_console()
> +        self.require_accelerator('tcg')
> +
> +        rme_stack = os.path.join(self.workdir,
> +                                 'rme-stack-op-tee-4.2.0-cca-v4-qemu_v8')
> +        kernel = os.path.join(rme_stack, 'out', 'bin', 'Image')
> +        bios = os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
> +        drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
> +
> +        self.vm.add_args('-cpu', 'max,x-rme=on')
> +        self.vm.add_args('-m', '2G')
> +        self.vm.add_args('-M', 'virt,acpi=off,'
> +                         'virtualization=on,'
> +                         'secure=on,'
> +                         'gic-version=3')
> +        self.vm.add_args('-bios', bios)
> +        self.vm.add_args('-kernel', kernel)
> +        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
> +        self.vm.add_args('-device', 'virtio-9p-device,fsdev=shr0,mount_tag=shr0')
> +        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
> +        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
> +        self.vm.add_args('-netdev', 'user,id=net0')
> +        self.vm.add_args('-append', 'root=/dev/vda')
> +
> +        self.vm.launch()
> +        # Wait for host VM boot to complete.
> +        wait_for_console_pattern(self, 'Welcome to Buildroot')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +
> +        test_realms_guest(self)
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> -- 
> 2.39.5
> 

