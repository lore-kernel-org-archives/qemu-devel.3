Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83650D3C525
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 17:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1U92-0003zP-P4; Thu, 17 Oct 2024 13:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1U91-0003yu-1d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1U8z-0007ED-6g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729185516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EvIStF4w9OyQ5tqyoopsYC/PFkbUhaQn37tIE4UQB/w=;
 b=DnwzmgK+Yl5eumoa3mH8XqpM9AZXDkAqSgJ/NQ49plc1AwqUOZ9hhiUkFbqKqMWPnlHG3N
 qcv3UjoAt4dfDdhPsw52beYwKcPMORoeVct1dh3LgRIP5so9V7fiN/5r47WA4GIEfX1oZE
 6Xmfl5cy+nKCkucDRkcqhVWKjSIBK8k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-YG_tfXgVP5ihaW8U2OoR8g-1; Thu, 17 Oct 2024 13:18:34 -0400
X-MC-Unique: YG_tfXgVP5ihaW8U2OoR8g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315ad4938fso7050155e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 10:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729185513; x=1729790313;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvIStF4w9OyQ5tqyoopsYC/PFkbUhaQn37tIE4UQB/w=;
 b=Vj/Qb0OaOm87yrdE3SLCwKorEvAox0lV/+zVpx0cTjb7jeUcV7kqLIvpJ30TJXABnQ
 lm97Xreuk1qCff77cAaQ3SoDgkCOc2UfU80quG+/wZktHlvdlPqz17f/DMGpIbPJV6x6
 KsUHWy9p1qN533eWLJGHq3xCL4RgV5PQUkR3NG49gENJvZIuWfegfPd8seyAk1o8QWpf
 r3zBzFkQjHDj/j3t1olWMhHgx2WrK21caIX0f0FUxC11bAmITW/Iwo7sPYVzYrzHXcGg
 Rw8Uac1ZtizZ2AhAUZy5CXcx921kxZBwaVYG9JHUq4xVvP8N6clcfzhEKYFWOIZmwijW
 xF1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBYn8BpdItPaqy5kLl6YfcVpwMjsC0CWWembAC/XvbmVoJtRacgjbHKvFgkv+czi58zzVdwZFC3XOT@nongnu.org
X-Gm-Message-State: AOJu0Yw3on39oeT58IhtSAWYfMy/9oEYWfnpEd+Y8fGNeVpj/SdD82Bi
 owuaHzodqbhDdWpOG7Zk5PNFpMR1kbXlO1cIbfB2UFdAF4yC7gWcPgncezmb3utQXTFnyiThZ/u
 NnVv9G1mj5lLZlPoWHFRDO+50p7HvBUXd7PQnJqD5nEMFD9wAWw6w
X-Received: by 2002:adf:a3d7:0:b0:37d:52e3:e3f0 with SMTP id
 ffacd0b85a97d-37d86d3cb13mr4798627f8f.44.1729185513410; 
 Thu, 17 Oct 2024 10:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkWn4FFzJad3tBM40Jzdm/CiCRNPNO5lwAED8lFOJ+nnz9/OD3HuNFTHWroveDxmOMLLO1jQ==
X-Received: by 2002:adf:a3d7:0:b0:37d:52e3:e3f0 with SMTP id
 ffacd0b85a97d-37d86d3cb13mr4798610f8f.44.1729185512799; 
 Thu, 17 Oct 2024 10:18:32 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa90547sm7826081f8f.49.2024.10.17.10.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 10:18:32 -0700 (PDT)
Message-ID: <70ac6525-85d6-4d0d-bf35-4d6bc924c8a8@redhat.com>
Date: Thu, 17 Oct 2024 19:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Add a functional test for the sx1
 board
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <20241017163247.711244-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241017163247.711244-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/10/2024 18.32, Peter Maydell wrote:
> Add a functional test for the sx1 board that uses the kernel and
> rootfs provided by Guenter Roeck in the linux-test-downloads repo:
>   https://github.com/groeck/linux-test-downloads/
> 
> We have three variants of the test for this board:
>    * just boot initrd
>    * boot with filesystem on SD card
>    * boot from flash
> 
> In all cases these images have a userspace that is configured to
> immediately reboot the system on successful boot, and the board
> itself supports telling QEMU to do the reboot, so we only need to
> wait for QEMU to exit (via -no-reboot).
> 
> Since there are three subtests, the test as a whole takes about
> 80s on my local machine. That's about the same as the aarch64_virt
> test, so give it the same overall test timeout as that one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The sdcard test requires the 'hw/sd/omap_mmc: Don't use sd_cmd_type_t' bugfix.
> ---
>   tests/functional/meson.build     |  2 +
>   tests/functional/test_arm_sx1.py | 72 ++++++++++++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
>   create mode 100755 tests/functional/test_arm_sx1.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 0450805a9c4..ec72bfaf63e 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -16,6 +16,7 @@ test_timeouts = {
>     'aarch64_virt' : 360,
>     'acpi_bits' : 240,
>     'arm_raspi2' : 120,
> +  'arm_sx1' : 360,
>     'mips_malta' : 120,
>     'netdev_ethtool' : 180,
>     'ppc_40p' : 240,
> @@ -54,6 +55,7 @@ tests_arm_system_thorough = [
>     'arm_collie',
>     'arm_integratorcp',
>     'arm_raspi2',
> +  'arm_sx1',
>     'arm_vexpress',
>   ]
>   
> diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
> new file mode 100755
> index 00000000000..2d86405831e
> --- /dev/null
> +++ b/tests/functional/test_arm_sx1.py
> @@ -0,0 +1,72 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) 2024 Linaro Ltd.
> +#
> +# Functional test that boots a Linux kernel on an sx1 machine
> +# and checks the console. We have three variants:
> +#  * just boot initrd
> +#  * boot with filesystem on SD card
> +#  * boot from flash
> +# In all cases these images have a userspace that is configured
> +# to immediately reboot the system on successful boot, so we
> +# only need to wait for QEMU to exit (via -no-reboot).
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +from qemu_test.utils import archive_extract
> +
> +class SX1Test(LinuxKernelTest):
> +
> +    ASSET_ZIMAGE = Asset(
> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/zImage',
> +        'a0271899a8dc2165f9e0adb2d0a57fc839ae3a469722ffc56c77e108a8887615')
> +
> +    ASSET_INITRD = Asset(
> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/rootfs-armv4.cpio',
> +        '35b0721249821aa544cd85b85d3cb8901db4c6d128eed86ab261e5d9e37d58f8')
> +
> +    ASSET_SD_FS = Asset(
> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/rootfs-armv4.ext2',
> +        'c1db7f43ef92469ebc8605013728c8950e7608439f01d13678994f0ce101c3a8')
> +
> +    ASSET_FLASH = Asset(
> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/flash',
> +        '17e6a2758fa38efd2666be0879d4751fd37d194f25168a8deede420df519b676')
> +
> +    CONSOLE_ARGS = 'console=ttyS0,115200 earlycon=uart8250,mmio32,0xfffb0000,115200n8'
> +
> +    def test_arm_sx1_initrd(self):
> +        self.set_machine('sx1')
> +        zimage_path = self.ASSET_ZIMAGE.fetch()
> +        initrd_path = self.ASSET_INITRD.fetch()
> +        self.vm.add_args('-append', f'kunit.enable=0 rdinit=/sbin/init {self.CONSOLE_ARGS}')
> +        self.vm.add_args('-no-reboot')
> +        self.launch_kernel(zimage_path,
> +                           initrd=initrd_path)
> +        self.vm.wait()
> +
> +    def test_arm_sx1_sd(self):
> +        self.set_machine('sx1')
> +        zimage_path = self.ASSET_ZIMAGE.fetch()
> +        sd_fs_path = self.ASSET_SD_FS.fetch()
> +        self.vm.add_args('-append', f'kunit.enable=0 root=/dev/mmcblk0 rootwait {self.CONSOLE_ARGS}')
> +        self.vm.add_args('-no-reboot')
> +        self.vm.add_args('-snapshot')
> +        self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
> +        self.launch_kernel(zimage_path)
> +        self.vm.wait()
> +
> +    def test_arm_sx1_flash(self):
> +        self.set_machine('sx1')
> +        zimage_path = self.ASSET_ZIMAGE.fetch()
> +        flash_path = self.ASSET_FLASH.fetch()
> +        self.vm.add_args('-append', f'kunit.enable=0 root=/dev/mtdblock3 rootwait {self.CONSOLE_ARGS}')
> +        self.vm.add_args('-no-reboot')
> +        self.vm.add_args('-snapshot')
> +        self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
> +        self.launch_kernel(zimage_path)
> +        self.vm.wait()
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()

Reviewed-by: Thomas Huth <thuth@redhat.com>


