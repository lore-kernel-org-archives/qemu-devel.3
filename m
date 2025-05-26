Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D368C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQme-0003vx-I0; Mon, 26 May 2025 01:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJQma-0003vc-DK
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJQmW-0004Vs-UH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748238829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HyrblzNbRL7yCY9da3hkCslV/WelzeNIBXzw5f57kVc=;
 b=PSUo8jTyMkBcNBo9davZtfvpf9OZHNxJJDKRnCq5WgyOcQPlWtZBqcaBo9Tq9cuF0BsGjf
 t42tBUQrLBMGNE/RLYNfpUUwFx0mbQtQpJRFIcMq3IVC/IP6RUYFZs6eb55A0/ccZYs5w/
 3cuSupz7vbXMh6oessQObN8KyOUUKMg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-UezCwCvzOVi46iZSGUxq-w-1; Mon, 26 May 2025 01:53:47 -0400
X-MC-Unique: UezCwCvzOVi46iZSGUxq-w-1
X-Mimecast-MFC-AGG-ID: UezCwCvzOVi46iZSGUxq-w_1748238826
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso122979066b.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748238826; x=1748843626;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyrblzNbRL7yCY9da3hkCslV/WelzeNIBXzw5f57kVc=;
 b=TQreqv1dBoYsIVY5EWZaBptWh67pgZ4l/BP1XcjV+wFzQYr619BCCEXTyxkAwpuvJN
 OlS6zUKBPtzo8F7swoqXN2lB6MKtoowmj1NXDaONvFGoITOtkBdNB5cmZvvBc9Ykhxsv
 mWud53XWsBAChQNfit1B7QB4lvOcc9eej1VJnDA4GU9dDFn4TDHYfvB9Jh5SEnz5Irvv
 6uPr0adUHk49o+8pVfoFzb1+Gq6y4EICea5i0rhwqkg3pY2Om14ytNJ63P7n17WlqBYS
 +EXROzOXhtl/yhngs+xGkNw3CCTTOz7qOYoodZ12mfm6JR5y396EclkLgEl+VJ3FsKTk
 f+YA==
X-Gm-Message-State: AOJu0Yy281mj78zhEfG+JWSvjJJ8J2oxe5+DP84PGqE4WACmx1vDpWY6
 jg/NWTfhfPt4rxSM92YGI1cbLu3YCyRPiNRJnJrG0t6TDzcw9q7PzeMSUnCFgV7CNlgqsP2zogj
 ggtUbxGMphwGKPpNqyBTP8W1HqQc5UnyCaJp0Vxc6LbbymJKDZPLJsCCy
X-Gm-Gg: ASbGncv6q7rar04pcZeivCvqp4JOxFcpd88g5ey3ixpvfUKnGSHGnWX0BvLqUqjAlXS
 Z71we17ZoHJnof28BgFqv9Ph7nVjrL0Y1QBlIcolZWwAPkXjd8FX5YI7duFUNN14i54AheCOujA
 +04udRVYOg/bn1TyjM9zMtO5eKYlmq+fKF9v+CuNsTcPu0F66YNdBFPLy/QPGaepxNDLvh09fut
 yjz5JGYXwI87b0hMtO9ZAvHgquyO3j7wF79WC/le4OTPtRIpNk1uU1JWbLXnNxCVyh0qr7EeVzO
 xQ0az8K7+njZtLslVNdCBgvgYjc4u9nNS1hHdcOkqWk=
X-Received: by 2002:a17:906:dc89:b0:ad2:1a60:f83b with SMTP id
 a640c23a62f3a-ad85b03b69emr714966266b.11.1748238825926; 
 Sun, 25 May 2025 22:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUczVO4sHfogZ20KfAy2cavZNlZkTBc0RBXOAkU8K0iDufb/WkiqrpUncHY8PomtZtWMlbqA==
X-Received: by 2002:a17:906:dc89:b0:ad2:1a60:f83b with SMTP id
 a640c23a62f3a-ad85b03b69emr714964266b.11.1748238825522; 
 Sun, 25 May 2025 22:53:45 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-602f33182d8sm2889939a12.7.2025.05.25.22.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:53:44 -0700 (PDT)
Message-ID: <168a934b-4659-41cc-beae-3264814636ed@redhat.com>
Date: Mon, 26 May 2025 07:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tests/functional: Add PCI hotplug test for aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, eric.auger@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20250512144629.182340-1-gustavo.romero@linaro.org>
 <87a57210k3.fsf@draig.linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87a57210k3.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 24/05/2025 17.38, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>> hot-unplug on arm64.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   MAINTAINERS                                  |  5 ++
>>   tests/functional/meson.build                 |  1 +
>>   tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
>>   3 files changed, 80 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23174b4ca7..9ebb768214 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2065,6 +2065,11 @@ S: Supported
>>   F: include/hw/pci/pcie_doe.h
>>   F: hw/pci/pcie_doe.c
>>   
>> +ARM PCI Hotplug
>> +M: Gustavo Romero <gustavo.romero@linaro.org>
>> +S: Supported
>> +F: tests/functional/test_aarch64_hotplug_pci.py
>> +
>>   ACPI/SMBIOS
>>   M: Michael S. Tsirkin <mst@redhat.com>
>>   M: Igor Mammedov <imammedo@redhat.com>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 52b4706cfe..2d68840fa2 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -83,6 +83,7 @@ tests_aarch64_system_quick = [
>>   tests_aarch64_system_thorough = [
>>     'aarch64_aspeed_ast2700',
>>     'aarch64_aspeed_ast2700fc',
>> +  'aarch64_hotplug_pci',
>>     'aarch64_imx8mp_evk',
>>     'aarch64_raspi3',
>>     'aarch64_raspi4',
>> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
>> new file mode 100755
>> index 0000000000..fa1bb62c8f
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_hotplug_pci.py
>> @@ -0,0 +1,74 @@
>> +#!/usr/bin/env python3
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# The test hotplugs a PCI device and checks it on a Linux guest.
>> +#
>> +# Copyright (c) 2025 Linaro Ltd.
>> +#
>> +# Author:
>> +#  Gustavo Romero <gustavo.romero@linaro.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
>> +from qemu_test import BUILD_DIR
>> +
>> +class HotplugPCI(LinuxKernelTest):
>> +
>> +    ASSET_KERNEL = Asset(
>> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> +         'current/images/netboot/debian-installer/arm64/linux'),
>> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
>> +
>> +    ASSET_INITRD = Asset(
>> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
>> +
>> '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
> 
> Hmm do we need to specify a checksum type now?

Yes. The whole cache management of the functional tests relies on the 
checksums, and we certainly don't want to have surprise effects in the tests 
if the assets change without us noticing.

> In fact could we use the existing tuxrun images instead of relying on
> debian stable not changing?

There seems also to be another image with "20230607" instead of "current" in 
the URL, maybe that one is a better fit?

  Thomas


