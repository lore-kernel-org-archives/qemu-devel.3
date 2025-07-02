Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DEEC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 20:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX3e5-0007qu-0h; Wed, 02 Jul 2025 16:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX3dY-0007mD-Tn
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:01:00 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX3dW-0001oE-At
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:00:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23508d30142so59169235ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751486450; x=1752091250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z1tpJZRMnznmR2n62RNfv9FcyVHzEJOG11h48z8E1PA=;
 b=C3FE/NtTQ65rKa5Wabv+uOJiymIOD4DK5UXMpEWBi9ZfiHf30Pu4hZ4YNQDbCdDlRE
 h1aZqSSrACALupKxPoH13YiaW8KEEXklkBYR99uWxGsaG4GthQLrzPyQu464SaQyQl1N
 M45kKb+sbZH2b7Q+3EC6fbDhvf+PLbxR4ryqMbs8v9T/Ddi0gcQjnVJqTG7ih0mzWyPO
 Yc7lvF3Z7ZYAllH5xdzx8yHXllMF4/RgbZCPx9gyVxYgMp8SRqEOqH4GpAx1qH5hKjP6
 gfcN5wqP5icMnNjxVHZdc6fioxCpKnaNFJDg1QUHrJEcjJ+CKMG2DJs+wi8TA2u/Ac35
 3oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751486450; x=1752091250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z1tpJZRMnznmR2n62RNfv9FcyVHzEJOG11h48z8E1PA=;
 b=Zc3kCBTBh584pM0JZiwXlHEKRqa9YlpBEJH02dxXVjztrnvhj7iHIyOAzIovpNCYxP
 2evjYdv4xVODltbxjWRtCyN1iYWDIXBBTTAsvs3uiC38YsoIRMJdODcY7UTUFHq7Pv6U
 TOUq6h+5KAqy9lz1YhBp9LqwDdcUEa89JXAh0VSi78DJRYHPMEycxoNc5HAu8cbQZh+j
 y5smMtvS5DChQvjHvk380gsBlPN4e6ImtSXxWS1Yhz1B0R3PzIecXNWhlL2MfwQWQMJr
 VS59+0oRfCBmLdac4Grs8lV5bJ4sqj4OIdu1emCS6KqTXyXiyc7pPfqVaydofNATyOIZ
 8Asg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP2F85hGS7auk/2o2AGofNlSta4ptUUgaZkRbkvOlMW59QkUjFTQelAWFYOvXA5rS6mN16arXVIq3r@nongnu.org
X-Gm-Message-State: AOJu0YyI4xKlQWWnXykqzb9xtGud/GoUKXtoPdG17nhF95WSTs+JYbNE
 8ZvQFdvBjsufKYoah2DU7V/ItpAKtTzyx27PBV3+6cmarg/7cqDzsUE7Tmj6lilWfjE=
X-Gm-Gg: ASbGnct3ckEzRuf7+QqB/AWLPMKu5Uhs9yeBza5UISyGK2TJRq9ZVuQs6oXe8gOLk7s
 SGzZSjYwNmEwq8lVCwB26QtStJqS/6RzlowM5L+WSbvx9baKwzcARO36yqeYMzTmiQ8kTE/Mi5U
 xuH3S3zvrbc6zByoOGRwCqHrQE2xB+U9ChHDj9kWnxk6vSHvvIc+lpm/p/XW5dvAU/GBtafCemR
 kt7c+udI4J/bHo3HSL2v89Q/1c2frwKDS7NsuhfDh+S5LSYM4+AyZIpTMVf9qS7qTrmayZZBNHp
 TTrp/wibK3nBHur8Jkylvv+yokCBUKa1usUof54YBFdvu0C5Pr3N+CA5Gy7Qzd9T0C2jr+jNR+U
 =
X-Google-Smtp-Source: AGHT+IGz4I1oMkRg9OydbsrKfHcrC83KUSDyv3C7brnPQ17/CKUKtnusy6U5WnAEsWdkq5efcAI96A==
X-Received: by 2002:a17:903:8c6:b0:235:be0:db53 with SMTP id
 d9443c01a7336-23c797b51a5mr6730585ad.51.1751486449708; 
 Wed, 02 Jul 2025 13:00:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e1b49sm138076405ad.22.2025.07.02.13.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 13:00:49 -0700 (PDT)
Message-ID: <31db119d-8c89-4caa-a4ef-efbc5680623f@linaro.org>
Date: Wed, 2 Jul 2025 13:00:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: test device passthrough on aarch64
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, jean-philippe@linaro.org,
 alex.bennee@linaro.org, eric.auger@redhat.com, smostafa@google.com
References: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
 <ed4fb068-dcba-4ce0-83d7-3534d3e37509@kaod.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ed4fb068-dcba-4ce0-83d7-3534d3e37509@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/2/25 5:51 AM, Cédric Le Goater wrote:
> Hello,
> 
> On 6/27/25 22:02, Pierrick Bouvier wrote:
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
>>    tests/functional/meson.build                  |   2 +
>>    .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
>>    2 files changed, 144 insertions(+)
>>    create mode 100755 tests/functional/test_aarch64_device_passthrough.py
>>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 3021928a9d4..6cc78abb123 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -13,6 +13,7 @@ endif
>>    test_timeouts = {
>>      'aarch64_aspeed_ast2700' : 600,
>>      'aarch64_aspeed_ast2700fc' : 600,
>> +  'aarch64_device_passthrough' : 720,
>>      'aarch64_imx8mp_evk' : 240,
>>      'aarch64_raspi4' : 480,
>>      'aarch64_reverse_debug' : 180,
>> @@ -84,6 +85,7 @@ tests_aarch64_system_quick = [
>>    tests_aarch64_system_thorough = [
>>      'aarch64_aspeed_ast2700',
>>      'aarch64_aspeed_ast2700fc',
>> +  'aarch64_device_passthrough',
>>      'aarch64_imx8mp_evk',
>>      'aarch64_raspi3',
>>      'aarch64_raspi4',
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
> 
> Is this binary on the host.ext4 image ?
> 

Yes, it is the "vanilla" QEMU package from debian:trixie.
It would be better to cross compile current QEMU revision, and run that, 
but it's not something easily feasible with current CI architecture.

> If so, the test is testing a chosen QEMU version compiled in the
> L1 guest image but not the current QEMU version, which is the one
> running in the L0.
> 

Yes, this limits the scope of the test, I agree.

> Anyhow this is a very nice test and an excellent base to build on.
> As a next step, I’d suggest including tests with NICs using igb
> devices and igb virtual functions (VFs).
>

Sure, it can easily be extended with any scenario.
The key point (where I would like to get review from tests maintainers) 
is to know if using embedded scripts is ok, vs sequential interaction 
with stdio.

> It would also be great to run the L1 environment using the current
> version of QEMU. I haven't found a clean way to achieve that yet :/
>

Any scenario where we start to trigger a compilation will be painfully 
slow unfortunately.
It's clearly a limit of the testing infrastructure we have, and it 
prevents having more nested scenarios.

> Thanks,
> 
> C.
>

