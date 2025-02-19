Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D644DC021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkkML-0005Vh-Vk; Wed, 19 Feb 2025 08:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkkMI-0005SH-BT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkkMF-0004A5-Ke
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739972602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cRSvO7CgbFvDK1lGdLXOPSoxIeFjmPSpwGlaJIE2qi4=;
 b=PQbl9WrtwdEplBh6Xf2lGBrmISlCP82mxnZOYMJbbDw3QvPND0hqcoom8i3ljjrQuno4Bq
 GsJwmpK1eWx7xNOTRVeuEq9UVlNQ1c6cl/IcSnUbTtFu3itdsy4ahALgmD5kHGM86Tw9U2
 LNCPtAdz/2ld43RxTdO5g0c5D3KNzEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-sxrF0CD8MPaLnPVd3p6IhQ-1; Wed, 19 Feb 2025 08:43:18 -0500
X-MC-Unique: sxrF0CD8MPaLnPVd3p6IhQ-1
X-Mimecast-MFC-AGG-ID: sxrF0CD8MPaLnPVd3p6IhQ_1739972597
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso56638765e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 05:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739972597; x=1740577397;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRSvO7CgbFvDK1lGdLXOPSoxIeFjmPSpwGlaJIE2qi4=;
 b=VfLe7a3jDg2dOGoWAWgk7Ld9Up4lhyvkFWpayno8OKoaEPGDl28ZzkYfN2ZVx0f2DN
 O2XwMA0qFSuYVqc7mcTt9yO4e0xmdIedGg5Hd8AOCqUoULNAyaVWdf+gC3tClNtLQg42
 0rv5Z5brmPq5MMbFqYQMesU1smgRUoAEgK/HYvt0gGTcUOJaX9XOQT6Xv6HJvIyAh6Vc
 dhtExadwdCwOs7FLhuTGh4KC0cSQMZhxXJna0+vYXQswIWc6oJJ769UxK634BeRU0LP9
 dQZc9z/oLmt6588IikDG8OlwA0hIUXepWYg1mXYcDVbyqD4Lcdi35MtMCEDf/Drzbtxu
 ZKOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/zQhsfMZfR4vthPrSZbNT9cJ9624WDT9HnsiOgXWyYLznDGOfxkSzraEf4NS0i+wj4yZkPkJRx6bu@nongnu.org
X-Gm-Message-State: AOJu0YwnqCpyZCcLwSpKqq1x0hbu2cE2exVmXygbWVCFXw3ZyP+yXeyD
 go4axsZIxFRG5cDM3TLZk2bRK0UkbUC2JxKeWSnuQsG/IXTXxf/j9Xp56+57rOuwZIjopvCVdZH
 qqE+sB+8+3Cd1HzVQs47mFRUAOvbOCVg8azajXHqyr+Ixj6SRyaJLoR1gSEJe
X-Gm-Gg: ASbGncsXOkG+Mnpx1pc4NgRmuCmztti7r6r/OTwUO2h7bKGF8DVIIqbuozq5hXz8e2p
 iL7h6dn0z/pnAZX+4Vyd0aSMY8qcz06fjr4w38R8a4/aeUm+pvqSjRjzRR4qGIoY1cnSHBjRW2w
 ks4VgKO/GEJP8Tk2eN4MSIpoRBHROvjtqa1CJMuL5Bh1T34jLt9ijl6nPuxIiGIHMWU+lk7xqjO
 HHiOkOV4d+ACXDdPhSxYn3kvhCZ+geNPiEYGEBBMbdWVjv1No4kioG4g9IFHHXE+I1GHYYCblbu
 Nn03WK7BFGy9s/1cWjoHkdX45vkKIKpevFlJ
X-Received: by 2002:a5d:6951:0:b0:38d:c44a:a64b with SMTP id
 ffacd0b85a97d-38f33f566f7mr17129227f8f.48.1739972597309; 
 Wed, 19 Feb 2025 05:43:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpIExgm5NF2SHCUyt+jucv9qokmOiI1Vo5380QVR0keYAOntRyJXNc1z5inRgv4Pk9QRLOtQ==
X-Received: by 2002:a5d:6951:0:b0:38d:c44a:a64b with SMTP id
 ffacd0b85a97d-38f33f566f7mr17129195f8f.48.1739972596975; 
 Wed, 19 Feb 2025 05:43:16 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dcf08sm18163477f8f.36.2025.02.19.05.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:43:16 -0800 (PST)
Message-ID: <87751cfc-b2b9-4995-a024-13905a1c47ca@redhat.com>
Date: Wed, 19 Feb 2025 14:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Virt" <qemu-arm@nongnu.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-24-alex.bennee@linaro.org>
 <91a78caf-2200-42b7-8da6-e857af38bad7@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <91a78caf-2200-42b7-8da6-e857af38bad7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 19/02/2025 14.25, Philippe Mathieu-Daudé wrote:
> (+Markus for CLI)
> 
> On 10/1/25 14:17, Alex Bennée wrote:
>> Now that we have virtio-gpu Vulkan support, let's add a test for it.
>> Currently this is using images build by buildroot:
>>
>>    https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>
>>
>> diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/ 
>> test_aarch64_virt.py
>> index 201c5ed023..6b2336a28d 100755
>> --- a/tests/functional/test_aarch64_virt.py
>> +++ b/tests/functional/test_aarch64_virt.py
>> @@ -13,10 +13,12 @@
>>   import logging
>>   from subprocess import check_call, DEVNULL
>> +from qemu.machine.machine import VMLaunchFailure
>> +
>>   from qemu_test import QemuSystemTest, Asset
>> -from qemu_test import exec_command_and_wait_for_pattern
>> +from qemu_test import exec_command, exec_command_and_wait_for_pattern
>>   from qemu_test import wait_for_console_pattern
>> -from qemu_test import get_qemu_img
>> +from qemu_test import skipIfMissingCommands, get_qemu_img
>>   class Aarch64VirtMachine(QemuSystemTest):
>> @@ -132,5 +134,73 @@ def test_aarch64_virt_gicv2(self):
>>           self.common_aarch64_virt("virt,gic-version=2")
>> +    ASSET_VIRT_GPU_KERNEL = Asset(
>> +        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
>> +        'download?path=%2F&files='
>> +        'Image',
>> +        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
>> +
>> +    ASSET_VIRT_GPU_ROOTFS = Asset(
>> +        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
>> +        'download?path=%2F&files='
>> +        'rootfs.ext4.zstd',
>> +        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
>> +
>> +    @skipIfMissingCommands('zstd')
>> +    def test_aarch64_virt_with_gpu(self):
>> +        # This tests boots with a buildroot test image that contains
>> +        # vkmark and other GPU exercising tools. We run a headless
>> +        # weston that nevertheless still exercises the virtio-gpu
>> +        # backend.
>> +
>> +        self.set_machine('virt')
>> +        self.require_accelerator("tcg")
>> +
>> +        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
>> +        image_path = self.uncompress(self.ASSET_VIRT_GPU_ROOTFS, 
>> format="zstd")
>> +
>> +        self.vm.set_console()
>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>> +                               'console=ttyAMA0 root=/dev/vda')
>> +
>> +        self.vm.add_args("-accel", "tcg")
>> +        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
>> +        self.vm.add_args("-machine", "virt,gic-version=max",
>> +                         '-kernel', kernel_path,
>> +                         '-append', kernel_command_line)
>> +        self.vm.add_args("-smp", "2", "-m", "2048")
>> +        self.vm.add_args("-device",
>> +                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
>> +        self.vm.add_args("-display", "egl-headless")
>> +        self.vm.add_args("-display", "dbus,gl=on")
> 
> [*]
> 
>> +        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
>> +        self.vm.add_args("-blockdev",
>> +                         "driver=raw,file.driver=file,"
>> +                         "node-name=hd0,read-only=on,"
>> +                         f"file.filename={image_path}")
>> +        self.vm.add_args("-snapshot")
>> +
>> +        try:
>> +            self.vm.launch()
>> +        except VMLaunchFailure as excp:
>> +            if "old virglrenderer, blob resources unsupported" in 
>> excp.output:
>> +                self.skipTest("No blob support for virtio-gpu")
>> +            elif "old virglrenderer, venus unsupported" in excp.output:
>> +                self.skipTest("No venus support for virtio-gpu")
> 
> This seems dependent on the order of the CLI arguments, as I got:
> 
> qemu-system-aarch64: -device virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on: 
> 'virtio-gpu-gl-pci' is not a valid device model name
> 
> I understand it is too complex to check this device availability with
> meson, in order to avoid running the test.
> 
> Can we use device introspection instead, like we do in QTest with
> qtest_qom_has_concrete_type() for accelerators? Maybe in the lines of:
> 
>    @skipIfMissingQOMType('virtio-gpu-gl-pci')

We already have "self.require_device('...')" that can be used to check for 
the availability of devices and skip the test if it is not built in ... 
would that be suitable here?

  Thomas


