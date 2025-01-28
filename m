Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9ACC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqQ2-0006lJ-46; Tue, 28 Jan 2025 13:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcqQ0-0006kO-Kb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:34:36 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcqPy-0005jE-Gx
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:34:36 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso40018775e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738089273; x=1738694073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wet72yOjpWce2wt8e0A0ok/61g/UShWlC+bbn2LdEMs=;
 b=cIra9cpwfB8y54sW0FZZ4JQ9u3EbLXmwKbWjZZ8ceWwQReNJjGRYWYmo8B4KWg3i7K
 zec52pzYNG9uMmzIThfWLxe6ieL39MNPG296bQ2GyKhzLDKcA56ZKr5yZ/qp6RAUuu1N
 kcQjFC/tMZIsjqANqgtxmnTEH71U8b6JGYaiolyWGckPMqelBquHc/Mgwv2NPDqjAGF9
 up1qFazUuBWreuGAJisOS/6mmOBB3I370Cgg4KGm39guE2tSNGIdMxcrpz1NyfJh3Ysp
 FT5UK124pe695znDoXeBsS8gwI/MSU+eR3+CVZYutMqelnabNi4M5euM8rpe4Rd8pbZo
 EqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738089273; x=1738694073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wet72yOjpWce2wt8e0A0ok/61g/UShWlC+bbn2LdEMs=;
 b=k0xFxCNP1ltB3SWb3BUydIqn1ToE2BJb02Ayy+yeKKFNBA448kOG/sq7n1wRmtJxVe
 Tqul7Ue8n8eBBTdrNvjU3QcVjogYiFRAbBAZlV5mmYC0A7Nxz1WGkd1hwB9GOl6HHcKh
 PFhpRV/Ph+msxwZ/SH4MD5H0kIaF8TBQorB7aKYXl5I961lQp7/Tii+oBGd8kUgqaLxI
 F7nxaA6LLOq4yEj/8Hlb30suxITyd8jPz3Vfqjq4o1u9S5VlgB4vS9fgbgwA4Kz+CwdQ
 XamfVVPId016O2GB7Px3yJS88jP7IrciFDLvUTqQSjFScPu23Q/6kz6UDwVkL+K+quHC
 +Q1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUirv7+dX/EdMrSzTZmYYWJRfa048de0QKTr6mCqr3cFxpNjFkCiAcIbb808LPnyCbtcUBCLxDUnPM1@nongnu.org
X-Gm-Message-State: AOJu0Yy/7VzrUuTMSlUxEuMTnKKQIZaqZwPO0fc4atUC4dbUkncCOfII
 eD3PUqxDI007JKJCm9oBb1M8Jnj6oFv7WzA0UjVffw9wxAlU7sBIYylKXUgez5g=
X-Gm-Gg: ASbGncv8eFy1UxUNt2NMf01J27qgVdRQZJ76+MRPZGp15wf//AQ9yZRvX93EkisN1zQ
 Ff4cs9yr1bgrITvvKW2fxixNzzpfGogRlyxleMCdgo39pPubmYTRoCdG/iadVu55jIZJk31Wil0
 tloVaSlGTyx0i8Y/vqVIiJvhq10TBqj3ait8smbp/KZ2mGgqlX6b7jAifzX4TaR7yfXc3yBmp2Y
 Ob+13tkWY+qvXxjljwqOLsc7lvi201mOMRZ3qQYxbOYsFbIa33sANMfoQ6utyWuXIEubZ61mNyQ
 mCj8+spbKvVvPDG9aGwnmNXuA/3m4FEoqwYtrcSa361Ap6GRelo7LBQHOBk=
X-Google-Smtp-Source: AGHT+IGUNhzpXj5hnpBOb91gKmsvwyQSYg7t9qfSvdoQyhGwpaYTMmxounnzgAEW6jZKe3b2dthowA==
X-Received: by 2002:a05:600c:28c:b0:436:5fc9:309d with SMTP id
 5b1f17b1804b1-4389ec8a8d0mr455457655e9.30.1738089272654; 
 Tue, 28 Jan 2025 10:34:32 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd50184dsm174672735e9.10.2025.01.28.10.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:34:32 -0800 (PST)
Message-ID: <28c5e1cc-6d78-4116-ae55-d59ab492cf78@linaro.org>
Date: Tue, 28 Jan 2025 19:34:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc64 mac99 test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20250128180742.1137741-1-clg@redhat.com>
 <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/1/25 19:20, Thomas Huth wrote:
> On 28/01/2025 19.07, Cédric Le Goater wrote:
>> The test sequence boots from disk a mac99 machine in 64-bit mode, in
>> which case the CPU is a PPC 970.
>>
>> The buildroot rootfs is built with config :
>>
>> BR2_powerpc64=y
>> BR2_powerpc_970=y
>>
>> and the kernel with the g5 deconfig.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS                          |  1 +
>>   tests/functional/meson.build         |  2 ++
>>   tests/functional/test_ppc64_mac99.py | 45 ++++++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+)
>>   create mode 100644 tests/functional/test_ppc64_mac99.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3a2291d17d7e..ebf249173f00 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1446,6 +1446,7 @@ F: include/hw/pci-host/uninorth.h
>>   F: include/hw/input/adb*
>>   F: pc-bios/qemu_vga.ndrv
>>   F: tests/functional/test_ppc_mac.py
>> +F: tests/functional/test_ppc64_mac99.py
>>   Old World (g3beige)
>>   M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 01a87b03e553..821a0a7c49ac 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -41,6 +41,7 @@ test_timeouts = {
>>     'ppc64_powernv' : 480,
>>     'ppc64_pseries' : 480,
>>     'ppc64_tuxrun' : 420,
>> +  'ppc64_mac99' : 120,
>>     'riscv64_tuxrun' : 120,
>>     's390x_ccw_virtio' : 420,
>>     'sh4_tuxrun' : 240,
>> @@ -181,6 +182,7 @@ tests_ppc64_system_thorough = [
>>     'ppc64_powernv',
>>     'ppc64_pseries',
>>     'ppc64_tuxrun',
>> +  'ppc64_mac99',
>>   ]
>>   tests_riscv32_system_quick = [
>> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/ 
>> test_ppc64_mac99.py
>> new file mode 100644
>> index 000000000000..ba582d267dae
>> --- /dev/null
>> +++ b/tests/functional/test_ppc64_mac99.py
>> @@ -0,0 +1,45 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots a mac99 machine with a PPC970 CPU
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import LinuxKernelTest, Asset
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +
>> +class mac99Test(LinuxKernelTest):
>> +
>> +    ASSET_BR2_MAC99_LINUX = Asset(
>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/ 
>> main/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
>> +        
>> 'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
>> +
>> +    ASSET_BR2_MAC99_ROOTFS = Asset(
>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/ 
>> main//buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/ 
>> rootfs.ext2',
>> +        
>> 'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
>> +
>> +    def test_ppc64_mac99_buildroot(self):
>> +        self.require_netdev('user')
>> +
>> +        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
>> +        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
>> +
>> +        self.set_machine('mac99')
> 
> Nit: Move the set_machine to the top of the function, so that the assets 
> don't have to be fetched in case the machine is not available.

Nice to know, this is not obvious. Should we check for unset machine
in fetch()? Or add fetch_for_machine()... Nitpicking yet more :p

> 
> With that nit fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
>> +        self.vm.set_console()
>> +
>> +        self.vm.add_args('-kernel', linux_path,
>> +                         '-append', 'root=/dev/sda',
>> +                         '-drive', f'file={rootfs_path},format=raw',
>> +                         '-net', 'nic,model=sungem', '-net', 'user',
>> +                         '-snapshot', '-nographic')
> 
> I just also noticed that we already have "-display none" in python/qemu/ 
> machine/machine.py, so you likely don't need the -nographic here (but 
> looks like we've got that wrong in a bunch of tests already).

Maybe warn in QEMUMachine::_pre_launch() if "-display none" && '-nographic'?

> 
>> +        self.vm.launch()

