Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF66EE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ96g-0000sx-Nu; Thu, 05 Dec 2024 05:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJ96f-0000sD-3b
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJ96c-0006n3-Uc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733394549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yoGg0i1yuJIE4i716VsMsY8Hrg6b//pfuqDhx7v9BDk=;
 b=N/SjNIX+0v16W5x43dWFfjjyHDa7hRvXjzNQcUhEGAsUSjHXBtseRHsXz8G8GMC43xWNEi
 kVdky0NYhP+FjmP5G2A8Y/vAo631fHGM3L1BJr9/DVeCevAIw1pFtaxQgKclMZotwCY5nn
 Jt/G1hDLUbwLeH7azR2KGI8daW27P1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-WkhLvZYjOHS0GWv4uxMjTA-1; Thu,
 05 Dec 2024 05:29:05 -0500
X-MC-Unique: WkhLvZYjOHS0GWv4uxMjTA-1
X-Mimecast-MFC-AGG-ID: WkhLvZYjOHS0GWv4uxMjTA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F32E81964CC6; Thu,  5 Dec 2024 10:29:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDA041956095; Thu,  5 Dec 2024 10:28:58 +0000 (UTC)
Date: Thu, 5 Dec 2024 10:28:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 mathieu.poirier@linaro.org, jean-philippe@linaro.org,
 marcin.juszkiewicz@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: Re: [PATCH v4] tests/functional/aarch64: add tests for FEAT_RME
Message-ID: <Z1GAZxhiQ0jN1-a0@redhat.com>
References: <20241203213629.2482806-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203213629.2482806-1-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 03, 2024 at 01:36:29PM -0800, Pierrick Bouvier wrote:
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
> 
> v4:
> - use pauth-impdef=on to speed up build time execution (x2.5 faster)
> - increase timeout value
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
> index 5c048cfac6d..60ae7bbd3d6 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -13,6 +13,8 @@ endif
>  test_timeouts = {
>    'aarch64_aspeed' : 600,
>    'aarch64_raspi4' : 480,
> +  'aarch64_rme_virt' : 1200,
> +  'aarch64_rme_sbsaref' : 1200,

These 20 minute timeouts seem rather excessive.

On my test machines _virt runs in 45 seconds, and _sbsaref
runs in 2m20. The latter is slow, but not dramatically
different from our other slow tests. It doesn't feel like
it justifies a 20 minute timeout ?

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
> index 00000000000..c136b5ce178
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
> +        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
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
> index 00000000000..39e4e4adb5f
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
> +        self.vm.add_args('-cpu', 'max,x-rme=on,pauth-impdef=on')
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
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


