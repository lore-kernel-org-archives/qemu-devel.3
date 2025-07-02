Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04137C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxcQ-0000WH-P8; Wed, 02 Jul 2025 09:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWxcI-0000T7-O4
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:35:17 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWxcG-0002aQ-7i
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:35:14 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6099d89a19cso8585245a12.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751463309; x=1752068109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBX6H8cg+eP92HN2jpwxPh/l/T6B+C/auGuYAi7x/vI=;
 b=fQBLbksmpvwhS/+nDoozKtKVcYFUNItFX0mO7BvDxA6v5/C1JLAYoDVOGphYFgDvoU
 T/EXz9wenhCl0huBHRlKXKc5H9VhUdZOlRM27SzLjx1XMYEvA2FBprkGp8y9h96MaLi/
 oZntEI4qPjhEXWauGrcShu7WRERn3Oz7XLNORPeAjvMI2jxPrParYm0iZmBK3ubBdjXc
 9bVe9k0NWWmLSC4yqdTYKZqtg33bkI/jQgsvPEWMTiZPRM5sYG+Kad4CCOcAy8DvgCp3
 wI7dZxoLO29mrorh1A4vcvHvofbLDdS0abf02dMyjEjYuU4Sembp40l7TdzqAGmigoX3
 JrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463309; x=1752068109;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YBX6H8cg+eP92HN2jpwxPh/l/T6B+C/auGuYAi7x/vI=;
 b=B+qrisSFR+bAqRDGJfFJPOUB6CY5bnapp72HkMw/BC2YOoyJACbG5g10I2bJMCcU+y
 wJdakmdczkL1xLuLzIrRc1fZquP2PCStaNdExC4Aq5K1LKy1Lo1NObIFsYjJGGIZ1yPP
 ev65zUfB254J9xEUrekV+BmPWQu07qtysxUgCV3P7MBKqu3ospgtV3dvlHu+wEYner4E
 A+ZXBcOZ96fSdAWzjFwB+Zk78MFrinLNA9LlYb9hKbJD5mHi/pfXmktBdpXvPsztNw9C
 hoRJbkD8TyAC7kLzFpqLKtMFrLTHvMgPVzQNo6eq9pzlyZ08z7xXEaF35o+fhe/lmv+k
 vMZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5A26b98nUzAeZQr6hyvMCgJCc06lrKZNmyxxpLOU5T4EEgm8jyEj+fYKikCqwlNmd3AA1DaLc6l97@nongnu.org
X-Gm-Message-State: AOJu0Yxz+Tuum8yiisEwAQGGUitmXGoSR0tW5wzO8aJ+IywJaTz64z6E
 78XJ85Lb3C2ZhW9i197LhDUtdgOvvCjfs8SfYr15wtWG1woWBCx5AGaYL51nTBSLRhE=
X-Gm-Gg: ASbGncuo2/z2I9C+Dqf0zMe3+XKsffqgbxOSPvA4YfFzxL50/zAL5Kq5v/hsfv/wunw
 BJPW7xtqP/Z4FcxmI51CPePg7FVMFkbKzqIWfXQnF+RK7MuvRFYC5bWMsJ7HY67q/DkEbDeJfZO
 cz+D7qJZnm3g2qBIoaE5SHWXgl9AJQ5SSHObLW+/YMZ6Rbu3/iRgNHJS1DwM4hkpzG3aXtHcbMZ
 ksWpuXMjECbKuwSwZs/KCg6K7OJVtPqMKRbQF4HocWPVa6CK7UNAkJBECcfUaCgv5FDZE8NtJR0
 1hMMH2mTLpGjdp4Sewb0jzXdcjB+Tx9/t5xV1wiuDkZtSmaMfRrphgjYxqo9kmc=
X-Google-Smtp-Source: AGHT+IEAXGDC/gaIc8QbylmkCYGGTN7q90Everfzpzyaa+FlDVtyub/qwOPrfaPBADuBolTh/ztOlw==
X-Received: by 2002:a17:907:a604:b0:ae3:cc60:8ce7 with SMTP id
 a640c23a62f3a-ae3cc60930fmr130634566b.19.1751463308695; 
 Wed, 02 Jul 2025 06:35:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353ca2095sm1074966366b.162.2025.07.02.06.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:35:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DBADF5F8BE;
 Wed, 02 Jul 2025 14:35:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 berrange@redhat.com,  thuth@redhat.com,  jean-philippe@linaro.org,
 eric.auger@redhat.com,  smostafa@google.com
Subject: Re: [PATCH v2] tests/functional: test device passthrough on aarch64
In-Reply-To: <ed4fb068-dcba-4ce0-83d7-3534d3e37509@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 2 Jul 2025 14:51:38 +0200")
References: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
 <ed4fb068-dcba-4ce0-83d7-3534d3e37509@kaod.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 02 Jul 2025 14:35:06 +0100
Message-ID: <87ecuyemwl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Hello,
>
> On 6/27/25 22:02, Pierrick Bouvier wrote:
>> This test allows to document and exercise device passthrough, using a
>> nested virtual machine setup. Two disks are generated and passed to the
>> VM, and their content is compared to original images.
>> Guest and nested guests commands are executed through two scripts,
>> and
>> init used in both system is configured to trigger a kernel panic in case
>> any command fails. This is more reliable and readable than executing all
>> commands through prompt injection and trying to guess what failed.
>> Initially, this test was supposed to test smmuv3 nested emulation
>> (combining both stages of translation), but I could not find any setup
>> (kernel + vmm) able to do the passthrough correctly, despite several
>> tries.
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   tests/functional/meson.build                  |   2 +
>>   .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
>>   2 files changed, 144 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_device_passthrough.py
>> diff --git a/tests/functional/meson.build
>> b/tests/functional/meson.build
>> index 3021928a9d4..6cc78abb123 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -13,6 +13,7 @@ endif
>>   test_timeouts =3D {
>>     'aarch64_aspeed_ast2700' : 600,
>>     'aarch64_aspeed_ast2700fc' : 600,
>> +  'aarch64_device_passthrough' : 720,
>>     'aarch64_imx8mp_evk' : 240,
>>     'aarch64_raspi4' : 480,
>>     'aarch64_reverse_debug' : 180,
>> @@ -84,6 +85,7 @@ tests_aarch64_system_quick =3D [
>>   tests_aarch64_system_thorough =3D [
>>     'aarch64_aspeed_ast2700',
>>     'aarch64_aspeed_ast2700fc',
>> +  'aarch64_device_passthrough',
>>     'aarch64_imx8mp_evk',
>>     'aarch64_raspi3',
>>     'aarch64_raspi4',
>> diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests=
/functional/test_aarch64_device_passthrough.py
>> new file mode 100755
>> index 00000000000..1f3f158a9ff
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_device_passthrough.py
>> @@ -0,0 +1,142 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Boots a nested guest and compare content of a device (passthrough) to=
 a
>> +# reference image. Both vfio group and iommufd passthrough methods are =
tested.
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
>> +guest_script =3D '''
>> +#!/usr/bin/env bash
>> +
>> +set -euo pipefail
>> +set -x
>> +
>> +# find disks from nvme serial
>> +dev_vfio=3D$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
>> +dev_iommufd=3D$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
>> +pci_vfio=3D$(basename $(readlink -f /sys/block/$dev_vfio/../../../))
>> +pci_iommufd=3D$(basename $(readlink -f /sys/block/$dev_iommufd/../../..=
/))
>> +
>> +# bind disks to vfio
>> +for p in "$pci_vfio" "$pci_iommufd"; do
>> +    if [ "$(cat /sys/bus/pci/devices/$p/driver_override)" =3D=3D vfio-p=
ci ]; then
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
> If so, the test is testing a chosen QEMU version compiled in the
> L1 guest image but not the current QEMU version, which is the one
> running in the L0.
>
> Anyhow this is a very nice test and an excellent base to build on.
> As a next step, I=E2=80=99d suggest including tests with NICs using igb
> devices and igb virtual functions (VFs).
>
> It would also be great to run the L1 environment using the current
> version of QEMU. I haven't found a clean way to achieve that yet :/

I sometimes boot up with a virtiofsd mapped to $HOME but it gets a
little unstable over time and I haven't had a chance to figure out where
things where going wrong.

We have the containers to reliably build a cross image of QEMU but we
would have to ensure the guest image matches so we don't run into
library skew issues. I have had a static build working but thats not a
very well supported configuration for qemu-system.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

