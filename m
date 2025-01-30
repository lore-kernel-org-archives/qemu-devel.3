Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FB7C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 09:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRFQ-00033H-Vt; Thu, 30 Jan 2025 04:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdRFO-00032G-IG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 04:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdRFL-0004yi-2U
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 04:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738230841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QhMLr9EqRWlucnkq5C4x8L76n74Szbyb+BRVb3qhOg0=;
 b=D8PVqBGM/eW9LlacJnX7GVWQ/6p2Ahhdwevfmjk0JFbbPtn15YpHLeCItqMIO7NB0t+01I
 afPYcHLM+8wSK8WpFNyx6ku2rHMq9X/DKYejpgwmZwyQpc9ct7+5k1lRmAUDhyjmaSeHxj
 ZhZIxklRJ+PnEZFVpykG8ZNPPGjKqS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-TU6GxynFNt2BGvEbP37zYQ-1; Thu, 30 Jan 2025 04:53:59 -0500
X-MC-Unique: TU6GxynFNt2BGvEbP37zYQ-1
X-Mimecast-MFC-AGG-ID: TU6GxynFNt2BGvEbP37zYQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43651b1ba8aso3758995e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 01:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738230838; x=1738835638;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhMLr9EqRWlucnkq5C4x8L76n74Szbyb+BRVb3qhOg0=;
 b=k0m5UFCXZIJpBmSrrxkCKkG/sexyqo+1rF9iLbuT6rxRXn5OEGhuV7YAXy0LiVS/a0
 LpknGp7eHCSYHcRGiwFjPry65ESLpmKZpDJSbM7+YGHNQr+bO2XEuiuc4YXQKpZAzMyU
 oXNSDySAsThRy3/bnfXqxv+bpnT3Sd3xDhltkwWVCBhZ8OBZEqWrW6LqM2iDijzkq7YV
 /4HK9peYVGpRy2ZkU/GY8Lz43XY/h+62Tewkn2EKd/9Ly5eo4sUzZW7QL0KHU0IuoTtk
 UO6Ab+mP5EVhmcXmfiPWcqr5EXqY0QEeIhZEAuDXEKtLzms9aS1WIPYpYe6jF/BGjG6C
 3ItQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvUUWJFloZbR3kO4yFaEns0gq6vcKdKvfwWH4+J0wRT/DuV7y55PHlnwLwbkWYRynqmo+YmS0U2imY@nongnu.org
X-Gm-Message-State: AOJu0Yyq7hzW5GZnzVrJDOEzdMcd78qH6dg9ITHol/VchOxaobQoL1IW
 od/eUpC4e8DfGjyNbD/MC9hl1C28odxGLqPRJcQFb5D8WnI/BLBYhCVXt1qRUlC6bKq3FjcBaLN
 LSNU3x6cX51TlMJfgWYEGl5Wl352//ugtU7RgUEoAcf4w1TeMHGWz
X-Gm-Gg: ASbGncvDwiyay3MpHfYx62r8eHbpWHhCEmtfus6Flb8X2qazjBc8xgu5vsitIyX1cSf
 D4BeDltmVubqkwTpvkEQ98nO8ooI0oNDZ7I8aAoM5ujfgwufGyGnkALlfQfWdLmA81XAW+3EZHl
 t8MkM4GJT0he8i8KnWHqbJGkGVbSNRuXr0jSms9aJSnawmZ7ZzGXGWUS1Ll0mnOTY7bJE/qgAIw
 3keZFRHbcuug3zCZzpLUchJyWQB3voB+CreE/nmlUDlblHcoJxgtryBN9wCclvVbnz2xgzxxy5z
 OFRdB0ADnOQ20Zbylc1EBnLILLjHhWdBKgd5eL+pMOk=
X-Received: by 2002:a05:600c:5248:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-438dc3cbf74mr60916385e9.15.1738230837916; 
 Thu, 30 Jan 2025 01:53:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrDU9dvlj9SXHtWEYOGQhiUvJVNCO+KQsrWcftqX5pcp/BebGs0hBsPzvfD5eUIpg/stl26A==
X-Received: by 2002:a05:600c:5248:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-438dc3cbf74mr60916015e9.15.1738230837474; 
 Thu, 30 Jan 2025 01:53:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf53asm1426783f8f.87.2025.01.30.01.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:53:56 -0800 (PST)
Message-ID: <e96fc587-6317-4e6c-8e31-46baa64ccbc3@redhat.com>
Date: Thu, 30 Jan 2025 10:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Add a ppc64 mac99 test
To: Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org
References: <20250128212145.1186617-1-clg@redhat.com>
 <390bd0cd-c918-33e5-7647-3662944d3066@eik.bme.hu>
 <33dee683-ab7b-4c3d-8c57-bc9bd2489858@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <33dee683-ab7b-4c3d-8c57-bc9bd2489858@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On 1/30/25 10:37, Thomas Huth wrote:
> On 29/01/2025 17.58, BALATON Zoltan wrote:
>> On Tue, 28 Jan 2025, Cédric Le Goater wrote:
>>> The test sequence boots from disk a mac99 machine in 64-bit mode, in
>>> which case the CPU is a PPC 970.
>>>
>>> The buildroot rootfs is built with config :
>>>
>>> BR2_powerpc64=y
>>> BR2_powerpc_970=y
>>>
>>> and the kernel with the g5 deconfig.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>
>>> Changes in v2:
>>>
>>> - Moved self.set_machine('mac99') at the top
>>> - Dropped sungem nic on the command line
>>>
>>> MAINTAINERS                          |  1 +
>>> tests/functional/meson.build         |  2 ++
>>> tests/functional/test_ppc64_mac99.py | 43 ++++++++++++++++++++++++++++
>>> 3 files changed, 46 insertions(+)
>>> create mode 100755 tests/functional/test_ppc64_mac99.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 3a2291d17d7e..ebf249173f00 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1446,6 +1446,7 @@ F: include/hw/pci-host/uninorth.h
>>> F: include/hw/input/adb*
>>> F: pc-bios/qemu_vga.ndrv
>>> F: tests/functional/test_ppc_mac.py
>>> +F: tests/functional/test_ppc64_mac99.py
>>>
>>> Old World (g3beige)
>>> M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>> index 01a87b03e553..821a0a7c49ac 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -41,6 +41,7 @@ test_timeouts = {
>>>   'ppc64_powernv' : 480,
>>>   'ppc64_pseries' : 480,
>>>   'ppc64_tuxrun' : 420,
>>> +  'ppc64_mac99' : 120,
>>>   'riscv64_tuxrun' : 120,
>>>   's390x_ccw_virtio' : 420,
>>>   'sh4_tuxrun' : 240,
>>> @@ -181,6 +182,7 @@ tests_ppc64_system_thorough = [
>>>   'ppc64_powernv',
>>>   'ppc64_pseries',
>>>   'ppc64_tuxrun',
>>> +  'ppc64_mac99',
>>> ]
>>>
>>> tests_riscv32_system_quick = [
>>> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/ test_ppc64_mac99.py
>>> new file mode 100755
>>> index 000000000000..9aec7c020748
>>> --- /dev/null
>>> +++ b/tests/functional/test_ppc64_mac99.py
>>> @@ -0,0 +1,43 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Functional test that boots a mac99 machine with a PPC970 CPU
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +from qemu_test import LinuxKernelTest, Asset
>>> +from qemu_test import exec_command_and_wait_for_pattern
>>> +
>>> +class mac99Test(LinuxKernelTest):
>>> +
>>> +    ASSET_BR2_MAC99_LINUX = Asset(
>>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/ buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
>>> +        'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
>>> +
>>> +    ASSET_BR2_MAC99_ROOTFS = Asset(
>>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main// buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
>>> +        'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
>>> +
>>> +    def test_ppc64_mac99_buildroot(self):
>>> +        self.set_machine('mac99')
>>> +
>>> +        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
>>> +        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
>>> +
>>> +        self.vm.set_console()
>>> +
>>> +        self.vm.add_args('-kernel', linux_path,
>>> +                         '-append', 'root=/dev/sda',
>>> +                         '-drive', f'file={rootfs_path},format=raw',
>>> +                         '-snapshot', '-nographic') # -nographic to get a console
>>
>> Nit: # -nographic for serial console or get a console on serial
> 
> Ok, but the line is getting too long ... I'll squash this when
> picking up the patch (unless there are any objections):
> 
> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/test_ppc64_mac99.py
> index 9aec7c0207..dfd9c01371 100755
> --- a/tests/functional/test_ppc64_mac99.py
> +++ b/tests/functional/test_ppc64_mac99.py
> @@ -25,10 +25,11 @@ def test_ppc64_mac99_buildroot(self):
> 
>           self.vm.set_console()
> 
> +        # Note: We need '-nographic' to get a serial console
>           self.vm.add_args('-kernel', linux_path,
>                            '-append', 'root=/dev/sda',
>                            '-drive', f'file={rootfs_path},format=raw',
> -                         '-snapshot', '-nographic') # -nographic to get a console
> +                         '-snapshot', '-nographic')
>           self.vm.launch()
> 
>           self.wait_for_console_pattern('>> OpenBIOS')
> 
>   Thomas
> 

LGTM,


Thanks,

C.




