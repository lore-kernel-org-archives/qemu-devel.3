Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7207FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEU6J-0005jb-1F; Mon, 12 May 2025 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEU6G-0005Xg-Kp
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:25:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEU6D-0006pm-Fu
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:25:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so49603065e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747059943; x=1747664743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rSPZR3sadD5efGt8lWmxGdMlXZ0hZfBQa22foBmhhWE=;
 b=mgciK5Uxsm3KHiI8N71eR1gnQ8eGInGL58M4HHcDO6zuiu+NIMW/PMiDu1I7vGwoZ+
 /rLtUIjmFqgmiXnLZ0bVopV1MCHU5lH/9c0LmohBI+MHjYqP71izxd+p4ItSmGThsA63
 UL+PKsoiHS0ClunXsQvf/wK2WXRoQ23UKRSc3Kv84L5HzW8wH1XSmvjXiQIH9gBAk2Eq
 0rr9eyKpI1Lzq8CnXU2CHJQBY7y8BOqwiuqYvIbK9kZogEbAbYCPRMy0gri7VqAdMX1r
 qAfrO1kfti58i+iS7YgypiV7A3wP4RXd4rwAmriIJidXXdxdVzw0nuG7tbzpli1Pl6zq
 hjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059943; x=1747664743;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSPZR3sadD5efGt8lWmxGdMlXZ0hZfBQa22foBmhhWE=;
 b=MzTigkx6eLjYnYrHVEbrsf3g21gZHC/b/gBzRxG0IN7rWwAdDZsvgce440289GCLq7
 TLL6cV3nHwHskn/7SkuuCEmIu160L5p7/QJjKzzirsXJjOifHTG/YKFMRsjFXoaY12pE
 3ogZRixX6po3sFH0XcjO/nuEbWer+Y0eZEggcDOI2bPwpr/Cc2nt5B/Uq8WrrisXH/2g
 uNF9fy+83KjVSP72/EL/3X3zQgd/Q6VTIBCHblrRlDOxJuWciFy6NPwfSVjBP7HZ/AwB
 OFKmJtuBJ4/np0EXqFVN94Uj/j5XGfV+wkM/ohfOesqaPFHfiY2bWwZ0NVX4P+4ApOlc
 UX2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa3wvp+7qfaCcmu/aJG+almcma9LQXoKUFrhAq2FgjwNvKc4cTSduONYBFiZP3XNGr6iiKcWCf0mrh@nongnu.org
X-Gm-Message-State: AOJu0Yzy/Fubw9S88lmJzzkleTAuvAJHt9JKyo26eNuEFuKq0+toMXqo
 D0mbrXkyIlbst1yZc3lsdLNj0ckeYTcElrv9fylMKeT8S/u/301L7feYLlBRGLw=
X-Gm-Gg: ASbGncsWdqh/zbJLTwtf2aTOBatjISS1qOWmihKPiyYBd/0pTwTVlRfTVkIpLTxtpFr
 lWQ0gwQuDt2YhPgFU/KuV1eEYfJWZiiE8PLbNv2+zbZi7RKfgJ76BONJHmmd8/Z6UT9wTmOksCa
 bMjcDoAMlp3rWdUPx8qS44hKq6HYprVYJPMyQb9UvW7EiUGFyi8iKUgM2r34IVk+yTow6L16YEZ
 oCULnUSHHj9lAA711OcKTQw/WCEllzWPtzrsneCjOZ5HHZMotw4fyOYxPwdNNFLBCuItu2W0qYD
 whIaFBRhOKGdcDyGxIWbk3h5Cb6Sqlpq9DLBw/4x3W+1Mh6c0WlPqeB+nvJc/5ruOe8+KvhwYci
 y5RX8uMtJeSpe
X-Google-Smtp-Source: AGHT+IEuLocMAPIUE16H2o8ZUrtjGxyc2fI0K438orNL1KwTirasf7qmz9ALKjwya655Rah6MA//tQ==
X-Received: by 2002:a05:600c:3d0c:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-442d6c31f3fmr130230175e9.0.1747059943597; 
 Mon, 12 May 2025 07:25:43 -0700 (PDT)
Received: from [10.93.5.179] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb6esm172654765e9.25.2025.05.12.07.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 07:25:43 -0700 (PDT)
Message-ID: <1ba74c1a-df5f-4fb2-9f17-0a5990f88803@linaro.org>
Date: Mon, 12 May 2025 15:25:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Add PCI hotplug test for aarch64
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20250512123646.157447-1-gustavo.romero@linaro.org>
 <1f9b943e-3c6c-47ea-929f-6c512e4c8ac7@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <1f9b943e-3c6c-47ea-929f-6c512e4c8ac7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Thomas,

On 5/12/25 10:03, Thomas Huth wrote:
> On 12/05/2025 14.36, Gustavo Romero wrote:
>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>> native controller and does not support ACPI-based hotplugging. However,
>> since support is planned, this test sets 'acpi=force' and specifies an
>> EDK2 firmware image in advance. This is harmless and prepares for future
>> ACPI support.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   MAINTAINERS                                  |  5 ++
>>   tests/functional/meson.build                 |  1 +
>>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>>   3 files changed, 79 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23174b4ca7..9ebb768214 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2065,6 +2065,11 @@ S: Supported
>>   F: include/hw/pci/pcie_doe.h
>>   F: hw/pci/pcie_doe.c
>> +ARM PCI Hotplug
>> +M: Gustavo Romero <gustavo.romero@linaro.org>
>> +S: Supported
>> +F: tests/functional/test_aarch64_hotplug_pci.py
>> +
>>   ACPI/SMBIOS
>>   M: Michael S. Tsirkin <mst@redhat.com>
>>   M: Igor Mammedov <imammedo@redhat.com>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 52b4706cfe..2d68840fa2 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -83,6 +83,7 @@ tests_aarch64_system_quick = [
>>   tests_aarch64_system_thorough = [
>>     'aarch64_aspeed_ast2700',
>>     'aarch64_aspeed_ast2700fc',
>> +  'aarch64_hotplug_pci',
>>     'aarch64_imx8mp_evk',
>>     'aarch64_raspi3',
>>     'aarch64_raspi4',
>> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
>> new file mode 100755
>> index 0000000000..05c92d7a45
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_hotplug_pci.py
>> @@ -0,0 +1,73 @@
>> +#!/usr/bin/env python3
>> +#
>> +# The test hotplugs a PCI device and checks it on a Linux guest.
>> +#
>> +# Copyright (c) 2025 Linaro Ltd.
>> +#
>> +# Author:
>> +#  Gustavo Romero <gustavo.romero@linaro.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +from os import path
>> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
>> +from qemu_test import BUILD_DIR
>> +
>> +class HotplugPCI(LinuxKernelTest):
>> +
>> +    ASSET_KERNEL = Asset(
>> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> +         'current/images/netboot/debian-installer/arm64/linux'),
>> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
>> +
>> +    ASSET_INITRD = Asset(
>> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
>> +        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
>> +
>> +    def test_hotplug_pci(self):
>> +
>> +        self.set_machine('virt')
>> +        self.vm.add_args('-m', '512M')
>> +        self.vm.add_args('-cpu', 'cortex-a57')
>> +        self.vm.add_args('-append',
>> +                         'console=ttyAMA0,115200 acpi=force init=/bin/sh')
>> +        self.vm.add_args('-device',
>> +                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1')
>> +        self.vm.add_args('-bios', path.join(BUILD_DIR, 'pc-bios',
>> +                         'edk2-aarch64-code.fd'))
> 
> Sorry for missing it in v1, but we've got a dedicated function for creating paths in the build directory: self.build_file() ... in case you respin, could you please that one instead?

Sure, done in v3. Thanks!


Cheers,
Gustavo

