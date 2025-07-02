Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDACC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 20:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX3iv-0001Qh-Lq; Wed, 02 Jul 2025 16:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX3it-0001Pb-9C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:06:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX3ir-00034O-2W
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:06:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-236377f00easo59042715ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751486781; x=1752091581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xlpv1TcQ1E2n260z2esJm863BtFfgWr/3sF8687tYho=;
 b=kRg+rGKhB7dr3ttx9zQA71y1HmXdXqap/eyXpaM9mILjLF0JHWi81NmvB3+DXPkj4k
 4bLBN4hKrjNuQ3xLRSgipMzFQnpGv4JWSksZKIB0AgOOLksDAqHp+U2TbIrn5lk3tGdk
 8t5T9G9cNLN+NP/7kjNckToKCAQ4uEQZVHESftLn2b6ph7KRts8sf+n8rRvXpeDkdyC6
 fyTdlegTZMzaMbm7PKciVunAQLq+0qVfmZT9WY7PAdFcP/xWRV6ss7oc5yeEXdsvz3m2
 EgG866FDhCi6Tnq6I6XjRbkIWMXntXymIIxqq+vp+VMpZA3U65Kw7sWbIpY2Bi8v6qZ/
 txdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751486781; x=1752091581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xlpv1TcQ1E2n260z2esJm863BtFfgWr/3sF8687tYho=;
 b=K1Rnx/fxCsNwf0swH/yA4R48T/tPMKFWNchbHFg7RTQb5mo1DLCU6ilGTFrXJOc2pO
 CjgWhRAGhOQ2VhVslWbjEW8I6SOEGFtoG+vB2E19WoN9OlAXRjAZJuhZJimlR58deKrc
 Su2S26Fw1yk+98BIvGrY+/o9WCWTTrdVjxd5/bVZxulrF4c83fap1tFkIGG8kn6YBa8a
 vtGePdv6EPbdtCvOSIJqm6qKoEiG5JQ1UxG09Cm2hZaXjg0pHuLsWXjZbWfuziRrJQuq
 VELuZvdl8V5NgvuR2djYoRYbw/aAQQc40gG09CESq8DucnZZDIjJljphfmdOPM6peSul
 ZBNw==
X-Gm-Message-State: AOJu0Ywi3697+zzGpEs+BnkYNnXFf7X5axSn2Z6xaTRGFNe4qvDTrefK
 usWuEYByvGME0oz/7LEhML/i0H6sMLOq6U6TU/WBoMzZr3o0YTKRwNZyTD9b8+fnB78=
X-Gm-Gg: ASbGnct15tzi39oCHjMCYHFeYsZB3sHgrtgJUN/Wlmc5Gwxdn5T8qqH+v2z1a1itp5g
 qBJ3UmllrL9cWSmFiyj06Dh67FBpW5Z9i2IcP349Shf3p+sJXTqaALNo6yTXWgn8xzgjb0utq35
 k1F9S88Ui0pHG2uuprOa0drec1iojmW4nYZLkcwzH0yefJchAYBJ+kMXkAsjZunt7Pq7C2Twfhh
 RJUQlOVWFZ50Tmp55PqAWdttxT823lXohEnEG7JmCm0qgMos+waAfGd5iSGzklaqIQdsCAn405X
 y0p1WwBvSHEVhp7GXEGUFFwCcdN9B2fIp1IFuBW0LTaLkBVpgphYIe42KZ/RsKTAyEVQv/8/33s
 =
X-Google-Smtp-Source: AGHT+IHVJhQY+hR8kUET3qif5PfptMSsFakNvuzew5awe3hzoM93kMKqWp6bJOnxWt1kWl6iv6wGFw==
X-Received: by 2002:a17:903:46cf:b0:235:eefe:68f4 with SMTP id
 d9443c01a7336-23c79692071mr8736425ad.29.1751486780972; 
 Wed, 02 Jul 2025 13:06:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3b932csm133751065ad.182.2025.07.02.13.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 13:06:20 -0700 (PDT)
Message-ID: <71e9007a-d76a-46fb-9e3d-477c0642764d@linaro.org>
Date: Wed, 2 Jul 2025 13:06:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: test device passthrough on aarch64
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, thuth@redhat.com,
 jean-philippe@linaro.org, eric.auger@redhat.com, smostafa@google.com
References: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
 <ed4fb068-dcba-4ce0-83d7-3534d3e37509@kaod.org>
 <87ecuyemwl.fsf@draig.linaro.org>
 <403d594e-cd95-4578-868c-02df19daf7bd@kaod.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <403d594e-cd95-4578-868c-02df19daf7bd@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/2/25 6:48 AM, Cédric Le Goater wrote:
> On 7/2/25 15:35, Alex Bennée wrote:
>> Cédric Le Goater <clg@kaod.org> writes:
>>
>>> Hello,
>>>
>>> On 6/27/25 22:02, Pierrick Bouvier wrote:
>>>> This test allows to document and exercise device passthrough, using a
>>>> nested virtual machine setup. Two disks are generated and passed to the
>>>> VM, and their content is compared to original images.
>>>> Guest and nested guests commands are executed through two scripts,
>>>> and
>>>> init used in both system is configured to trigger a kernel panic in case
>>>> any command fails. This is more reliable and readable than executing all
>>>> commands through prompt injection and trying to guess what failed.
>>>> Initially, this test was supposed to test smmuv3 nested emulation
>>>> (combining both stages of translation), but I could not find any setup
>>>> (kernel + vmm) able to do the passthrough correctly, despite several
>>>> tries.
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     tests/functional/meson.build                  |   2 +
>>>>     .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
>>>>     2 files changed, 144 insertions(+)
>>>>     create mode 100755 tests/functional/test_aarch64_device_passthrough.py
>>>> diff --git a/tests/functional/meson.build
>>>> b/tests/functional/meson.build
>>>> index 3021928a9d4..6cc78abb123 100644
>>>> --- a/tests/functional/meson.build
>>>> +++ b/tests/functional/meson.build
>>>> @@ -13,6 +13,7 @@ endif
>>>>     test_timeouts = {
>>>>       'aarch64_aspeed_ast2700' : 600,
>>>>       'aarch64_aspeed_ast2700fc' : 600,
>>>> +  'aarch64_device_passthrough' : 720,
>>>>       'aarch64_imx8mp_evk' : 240,
>>>>       'aarch64_raspi4' : 480,
>>>>       'aarch64_reverse_debug' : 180,
>>>> @@ -84,6 +85,7 @@ tests_aarch64_system_quick = [
>>>>     tests_aarch64_system_thorough = [
>>>>       'aarch64_aspeed_ast2700',
>>>>       'aarch64_aspeed_ast2700fc',
>>>> +  'aarch64_device_passthrough',
>>>>       'aarch64_imx8mp_evk',
>>>>       'aarch64_raspi3',
>>>>       'aarch64_raspi4',
>>>> diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/test_aarch64_device_passthrough.py
>>>> new file mode 100755
>>>> index 00000000000..1f3f158a9ff
>>>> --- /dev/null
>>>> +++ b/tests/functional/test_aarch64_device_passthrough.py
>>>> @@ -0,0 +1,142 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>> +# Boots a nested guest and compare content of a device (passthrough) to a
>>>> +# reference image. Both vfio group and iommufd passthrough methods are tested.
>>>> +#
>>>> +# Copyright (c) 2025 Linaro Ltd.
>>>> +#
>>>> +# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +import os
>>>> +
>>>> +from qemu_test import QemuSystemTest, Asset
>>>> +from qemu_test import exec_command, wait_for_console_pattern
>>>> +from qemu_test import exec_command_and_wait_for_pattern
>>>> +from random import randbytes
>>>> +
>>>> +guest_script = '''
>>>> +#!/usr/bin/env bash
>>>> +
>>>> +set -euo pipefail
>>>> +set -x
>>>> +
>>>> +# find disks from nvme serial
>>>> +dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
>>>> +dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
>>>> +pci_vfio=$(basename $(readlink -f /sys/block/$dev_vfio/../../../))
>>>> +pci_iommufd=$(basename $(readlink -f /sys/block/$dev_iommufd/../../../))
>>>> +
>>>> +# bind disks to vfio
>>>> +for p in "$pci_vfio" "$pci_iommufd"; do
>>>> +    if [ "$(cat /sys/bus/pci/devices/$p/driver_override)" == vfio-pci ]; then
>>>> +        continue
>>>> +    fi
>>>> +    echo $p > /sys/bus/pci/drivers/nvme/unbind
>>>> +    echo vfio-pci > /sys/bus/pci/devices/$p/driver_override
>>>> +    echo $p > /sys/bus/pci/drivers/vfio-pci/bind
>>>> +done
>>>> +
>>>> +# boot nested guest and execute /host/nested_guest.sh
>>>> +# one disk is passed through vfio group, the other, through iommufd
>>>> +qemu-system-aarch64 \
>>>
>>> Is this binary on the host.ext4 image ?
>>>
>>> If so, the test is testing a chosen QEMU version compiled in the
>>> L1 guest image but not the current QEMU version, which is the one
>>> running in the L0.
>>>
>>> Anyhow this is a very nice test and an excellent base to build on.
>>> As a next step, I’d suggest including tests with NICs using igb
>>> devices and igb virtual functions (VFs).
>>>
>>> It would also be great to run the L1 environment using the current
>>> version of QEMU. I haven't found a clean way to achieve that yet :/
>>
>> I sometimes boot up with a virtiofsd mapped to $HOME but it gets a
>> little unstable over time and I haven't had a chance to figure out where
>> things where going wrong.
>>
>> We have the containers to reliably build a cross image of QEMU but we
>> would have to ensure the guest image matches so we don't run into
>> library skew issues.
> 
> and could we generate a disk image from a container build, keep the
> artifact and use it in the functional test to boot the L1 guest  ?
>

It could be an idea. But then it pushes a strong requirement to have 
exactly the same environment running in the VM. For instance, the 
current software stack in v2 is using alpine (while using debian on v1), 
so you'd have to be very careful how you cross compile.

That said, it may be an opportunity to provide a gold/standard test 
setup (based on debian (or any other distro), with full batteries 
setup), and assume this to run several functional tests based on it.
This way, the same "fat" image could be reused with different functional 
tests, and this would allow to provide current QEMU branch as part of 
the container (using virtfs or virtiofsd. I strongly prefer the former, 
which does not rely on any external binary to be built/launched).

> 
> Thanks,
> 
> C.
> 


