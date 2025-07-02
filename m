Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20453C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 20:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX3lC-000390-PX; Wed, 02 Jul 2025 16:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX3lA-00038F-EW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:08:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX3l7-0003JG-VQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:08:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so3229767b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751486923; x=1752091723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LJfljIIjCbxutQJusLhGW00lBh/Pe/rekIvXyHw1fMU=;
 b=Q+cNaXdEti5ig2nbSEkyPrSgjMkuBMBiEST2xnDpHvJ1mPz+EL8js8AhYwk0wGUHMZ
 addYDtSI3cJ1R3BQoW5UaKSNnt2gH3/KOC8ET9dhieTUVV5IwpuntzgjO/H1a69ZwsBK
 uv3BEQ8GcYvSbN/oLQBuEos6bz0Cr511y3vJaCwMM6KnAF0nQdsGIrjdim4nkrk/x/5h
 YNxtQWTrJ1GtAaF5f0n5q9aFwu/CbodezX8zD/7B2P065AMfnvTjlcM5yX+lSnK8IF73
 5/bc8bHc0YOD5p1SSEE7HB71phtiphJxrg7uK1OYh8b8b+JHDskeIA9uumpUvBXAxsHY
 xzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751486923; x=1752091723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJfljIIjCbxutQJusLhGW00lBh/Pe/rekIvXyHw1fMU=;
 b=pWWwQylrv9VSKZf5Nhchu3pjqveQBnSxlP/E4Mjvs5KzMApM3Ag+g6NS1xLf7pm+Dr
 nR344DSOAaBuspc8qC9iKPVUggflnHbTE+P16z9ucR2MAOV1KfaLbtyVsKJWepcBAHoq
 44ztCuTxonGYTn56kmgvOPbfDGpOrqoxRepDNnjXnt1tZWgbVyjJI2Hpshx0enUkR7n6
 VnSwiVJLKZJiVNg7WWTh9LD/fooMSuPuuOdpalhff/mnMOY7H4hPw/MdK75pwFzMWCuL
 s7PLO20B79Qbgxj2DezQq5JFeUV94RsKnKI1ZgZd9oRMKA/OlsIHjtID9PFQjdpqNQBU
 7lNw==
X-Gm-Message-State: AOJu0Yy9qJKt1jBkv239+az/rSs6n0VprYJSaWyxA8JjGz4KLsr/GIJx
 cRqlyzlrZwBavL1vozc7iTCsCwhEGM7JAqdRKfR7zfu4tWHTWJ5ljgww83kAzJpI7k2hyBPZsqq
 qDrPx
X-Gm-Gg: ASbGncuu+dSsPjIkJyudad2CmYuuhkFnInE88cqdYMFB07PA7pudh9yNQygteDUF17U
 jYviJmuwinU8oV5S5NXeslZg4MAfXTl4/47M4p8lJAGTCJSnz8ZFnriKVcf3DfZHVlSSLqNpj0j
 bPrnQRT+jS1y3Lj2TKKmQYHXE1HCZZ3KlhXCqu5SMGpZ+8lmj85vxjHBU55tWH2iA02rdLMTn+R
 0G1tG/7q7iXflOf/7wxwJq3P5uW3GR0RcL6h0mWJJMbL2W+t+3GebYn0MJEfkknR3et5fNXgw0F
 EwuZjQeXsKw1gNq368TetAPc6nCbmpNqjkPuYBUTHcYoINGvyzfOeB5qG14Y/ExG8DtSmqqKEWs
 =
X-Google-Smtp-Source: AGHT+IHX2oMtJuJico2ObkixzdDrt0sVzni5dhmyIbPCyRWIsiq0X56koX+AinrdKisauf+xl47Ghg==
X-Received: by 2002:a05:6a00:4b11:b0:740:9abe:4d94 with SMTP id
 d2e1a72fcca58-74b513ea979mr5399988b3a.21.1751486923032; 
 Wed, 02 Jul 2025 13:08:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c6c67sm15406799b3a.110.2025.07.02.13.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 13:08:42 -0700 (PDT)
Message-ID: <2862e805-e2b5-4b4b-a21e-6e7e61d39639@linaro.org>
Date: Wed, 2 Jul 2025 13:08:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: test device passthrough on aarch64
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, jean-philippe@linaro.org,
 alex.bennee@linaro.org, eric.auger@redhat.com, smostafa@google.com
References: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
 <aGUvc6XJjsluZtH_@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aGUvc6XJjsluZtH_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/2/25 6:09 AM, Daniel P. Berrangé wrote:
> On Fri, Jun 27, 2025 at 01:02:22PM -0700, Pierrick Bouvier wrote:
>> This test allows to document and exercise device passthrough, using a
>> nested virtual machine setup. Two disks are generated and passed to the
>> VM, and their content is compared to original images.
>>
>> Guest and nested guests commands are executed through two scripts, and
>> init used in both system is configured to trigger a kernel panic in case
>> any command fails. This is more reliable and readable than executing all
>> commands through prompt injection and trying to guess what failed.
>>
>> Initially, this test was supposed to test smmuv3 nested emulation
>> (combining both stages of translation), but I could not find any setup
>> (kernel + vmm) able to do the passthrough correctly, despite several
>> tries.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   tests/functional/meson.build                  |   2 +
>>   .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
>>   2 files changed, 144 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_device_passthrough.py
>>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 3021928a9d4..6cc78abb123 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -13,6 +13,7 @@ endif
>>   test_timeouts = {
>>     'aarch64_aspeed_ast2700' : 600,
>>     'aarch64_aspeed_ast2700fc' : 600,
>> +  'aarch64_device_passthrough' : 720,
>>     'aarch64_imx8mp_evk' : 240,
>>     'aarch64_raspi4' : 480,
>>     'aarch64_reverse_debug' : 180,
>> @@ -84,6 +85,7 @@ tests_aarch64_system_quick = [
>>   tests_aarch64_system_thorough = [
>>     'aarch64_aspeed_ast2700',
>>     'aarch64_aspeed_ast2700fc',
>> +  'aarch64_device_passthrough',
>>     'aarch64_imx8mp_evk',
>>     'aarch64_raspi3',
>>     'aarch64_raspi4',
>> diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/test_aarch64_device_passthrough.py
>> new file mode 100755
>> index 00000000000..1f3f158a9ff
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_device_passthrough.py
>> @@ -0,0 +1,142 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Boots a nested guest and compare content of a device (passthrough) to a
>> +# reference image. Both vfio group and iommufd passthrough methods are tested.
>> +#
>> +# Copyright (c) 2025 Linaro Ltd.
>> +#
>> +# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import exec_command, wait_for_console_pattern
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +from random import randbytes
>> +
>> +guest_script = '''
>> +#!/usr/bin/env bash
>> +
>> +set -euo pipefail
>> +set -x
>> +
>> +# find disks from nvme serial
>> +dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
>> +dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
>> +pci_vfio=$(basename $(readlink -f /sys/block/$dev_vfio/../../../))
>> +pci_iommufd=$(basename $(readlink -f /sys/block/$dev_iommufd/../../../))
>> +
>> +# bind disks to vfio
>> +for p in "$pci_vfio" "$pci_iommufd"; do
>> +    if [ "$(cat /sys/bus/pci/devices/$p/driver_override)" == vfio-pci ]; then
>> +        continue
>> +    fi
>> +    echo $p > /sys/bus/pci/drivers/nvme/unbind
>> +    echo vfio-pci > /sys/bus/pci/devices/$p/driver_override
>> +    echo $p > /sys/bus/pci/drivers/vfio-pci/bind
>> +done
>> +
>> +# boot nested guest and execute /host/nested_guest.sh
>> +# one disk is passed through vfio group, the other, through iommufd
>> +qemu-system-aarch64 \
>> +-M virt \
>> +-display none \
>> +-serial stdio \
>> +-cpu host \
>> +-enable-kvm \
>> +-m 1G \
>> +-kernel /host/Image.gz \
>> +-drive format=raw,file=/host/guest.ext4,if=virtio \
>> +-append "root=/dev/vda init=/init -- bash /host/nested_guest.sh" \
>> +-virtfs local,path=/host,mount_tag=host,security_model=mapped,readonly=off \
>> +-device vfio-pci,host=$pci_vfio \
>> +-object iommufd,id=iommufd0 \
>> +-device vfio-pci,host=$pci_iommufd,iommufd=iommufd0
>> +'''
>> +
>> +nested_guest_script = '''
>> +#!/usr/bin/env bash
>> +
>> +set -euo pipefail
>> +set -x
>> +
>> +image_vfio=/host/disk_vfio
>> +image_iommufd=/host/disk_iommufd
>> +
>> +dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
>> +dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
>> +
>> +# compare if devices are identical to original images
>> +diff $image_vfio /dev/$dev_vfio
>> +diff $image_iommufd /dev/$dev_iommufd
>> +
>> +echo device_passthrough_test_ok
>> +'''
>> +
>> +class Aarch64DevicePassthrough(QemuSystemTest):
>> +
>> +    # https://github.com/pbo-linaro/qemu-linux-stack
>> +    #
>> +    # Linux kernel is compiled with defconfig +
>> +    # IOMMUFD + VFIO_DEVICE_CDEV + ARM_SMMU_V3_IOMMUFD
>> +    # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
>> +    ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
>> +        ('https://fileserver.linaro.org/s/fx5DXxBYme8dw2G/'
>> +         'download/device_passthrough.tar.xz'),
>> +         '812750b664d61c2986f2b149939ae28cafbd60d53e9c7e4b16e97143845e196d')
>> +
>> +    # This tests the device passthrough implementation, by booting a VM
>> +    # supporting it with two nvme disks attached, and launching a nested VM
>> +    # reading their content.
>> +    def test_aarch64_device_passthrough(self):
>> +        self.set_machine('virt')
>> +        self.require_accelerator('tcg')
>> +
>> +        self.vm.set_console()
>> +
>> +        stack_path_tar_gz = self.ASSET_DEVICE_PASSTHROUGH_STACK.fetch()
>> +        self.archive_extract(stack_path_tar_gz, format="tar")
>> +
>> +        stack = self.scratch_file('out')
>> +        kernel = os.path.join(stack, 'Image.gz')
>> +        rootfs_host = os.path.join(stack, 'host.ext4')
>> +        disk_vfio = os.path.join(stack, 'disk_vfio')
>> +        disk_iommufd = os.path.join(stack, 'disk_iommufd')
>> +        guest_cmd = os.path.join(stack, 'guest.sh')
>> +        nested_guest_cmd = os.path.join(stack, 'nested_guest.sh')
> 
> Don't incrementally create paths like this - use the
> 'scratch_file' method for all components
> 
>   ie
> 
>     kernel = self.scratch_file('out', 'Image.gz')
>     rootfs_host =  self.scratch_file('out', 'host.ext4')
>     ...etc...
>

May I ask what's the benefit of this?

It forces you to repeat full path (luckily short in this case), but I 
don't see the difference with simply joining paths.

