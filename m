Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0F2CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCCaH-0004d5-JM; Fri, 24 Oct 2025 03:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCCaF-0004bB-Nb
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:51:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCCaD-0006rD-HV
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:51:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so1113553f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761292291; x=1761897091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4glzaFawliIjjaWDi2C0Xa1voW/SWLLSoWe8mQUe1ck=;
 b=jrid1vSQEvTP0ZPpvxdBg0W5UjNfopnPSqDH7OWziVoUGVvWtryOuiXhAA5syvp44d
 /1UGFNj0RQA4bLQS3e6zgAkQ57GY5OAjRIZVgDSNDwf6DYU6NoYMT1QQFFYxAb+mC3RN
 wmZ15ENRp72Q07Van5hJMN37uVm+PDyIRnst2cEbAWqBzxOVasBnSDc6h8/ViPypRFoE
 jLMAmEbU037Y5jRKOZXdyBbnNJzmoaWdSTf0XYQD6PaH13i/TGp4ahxd+XLIp1IyxO5a
 2iteXWxgDIOgnDW9ZYcp/spEyGdvaDLvMC+mm67rIcHOyHzDxVjN1fK8601TUHiPP168
 HWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761292291; x=1761897091;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4glzaFawliIjjaWDi2C0Xa1voW/SWLLSoWe8mQUe1ck=;
 b=IRQEf5aByML/LiStAxuP8/s/b/ge0q/TXhWJZZ9olFil+SU7wPy1OKw5LJkpVQsR3b
 4yyGMf0J1HNB1ALOMQUD0IihJXhJQGwu7qX7T1e+S9juLRG46HaQxNMw3ZpxOKOMRsD0
 AW9nE6NEaQP7h9x1Tk7DWCXrzDWlyisly2gNeL6zWdkfJkAQ8IAVNqVIb5FfJhECq5J6
 TWjVaVloqT1V7V0L1Mp2ObhMbVB3bkXrietOxnXKz2qyX5JCVKPcB9vvuVWSNhFV/G/I
 yL/YLaKkY7GPROc57vachsWIot+buw9BrhZxT9oP/QH3HzCALrmLS7evqDjPt8nvGH/B
 aIIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTWEZ06qbcGDj1Iz3yHFMgR3DoIPqbrnD67wUnoow9KXyDea/hHfR+A+In7nkmXXiwR5bx/znk4+Gz@nongnu.org
X-Gm-Message-State: AOJu0YyXDHeEkexi4PEClEDYamcVP+U3F6wTd/TbnQhTdi2lOP2r3x9Q
 IBE6mmqWj+cmSZWO5QWIF9VX450TYCQUrqhzkvWSFr+VrE+UdVCtEqM0It04Kv35AsI=
X-Gm-Gg: ASbGncu6GPKJbG/yIyXq1g7hZHXaiVBn8F9D57kDyJ1yXaUd8ZweTe6u3DNulBZ5lIB
 jkqHK2whohzGOIYp/fOzKJOct7DGlu+uTg/SJRtoXhF6eytw58TJrxBklO1O9rY9i7yCQPXmRsM
 j90duR8tZePmIZ5KRF3UMCAt0+wuu9uWiWd1Ccg68IHT5VpLfi5R6DrlARoPNkK8vGc7joRtNmn
 liPS7v3rULQdzPA8aj5bMgm2fq6RN0/xypKs+hIup4l/m1axL4aS3NQG2maZJOK60+Ik7Q4ykNd
 LVRo0s7PePSFTRNv5RXFjeViMOM1+e275XaIXN93sbiln5ZKVDa4BMXNbpjcDRYYaOeUWfM4SDe
 sl4mK+h7WUK4ZmDfuirvYhJbvWiphrJT1J/oPlQTLuMsY/75OIIbVrK3VtYNGPSHm3Orj/D1YB2
 btsYJ8yCHNRzI4duQiDSAYp2u3aTYAuOG970qArjeF3pwr9ulYQvnYSg==
X-Google-Smtp-Source: AGHT+IFrSXGqc72GBHPeTxxpi8VBFWjaaCGuZU2DGshUveK9WKKOUkzM27+cibwVbEhyJQCxffc+qg==
X-Received: by 2002:a05:6000:4301:b0:3df:c5e3:55f8 with SMTP id
 ffacd0b85a97d-429907523c1mr1016311f8f.54.1761292291495; 
 Fri, 24 Oct 2025 00:51:31 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898eb549sm7946672f8f.41.2025.10.24.00.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 00:51:30 -0700 (PDT)
Message-ID: <0d3e6fb4-ddb5-4b85-82b8-e1222079adc4@linaro.org>
Date: Fri, 24 Oct 2025 09:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/10] tests/functional: add memlock tests
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250611125846.125918-1-thuth@redhat.com>
 <20250611125846.125918-7-thuth@redhat.com>
 <986e788c-6a94-4c27-9a6e-a761e3f763c0@linaro.org>
In-Reply-To: <986e788c-6a94-4c27-9a6e-a761e3f763c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 24/10/25 09:45, Philippe Mathieu-Daudé wrote:
> Hi Alexandr,
> 
> On 11/6/25 14:58, Thomas Huth wrote:
>> From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>
>> Add new tests to check the correctness of the `-overcommit memlock`
>> option (possible values: off, on, on-fault) by using
>> `/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck
>> values:
>>
>> * if `memlock=off`, then VmLck = 0;
>> * if `memlock=on`, then VmLck > 0 and almost all memory is resident;
>> * if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.
>>
>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> Message-ID: <20250605065908.299979-3-dtalexundeer@yandex-team.ru>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/meson.build     |  1 +
>>   tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
>>   2 files changed, 80 insertions(+)
>>   create mode 100755 tests/functional/test_memlock.py
>>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 557d59ddf4d..c3fca446cff 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -312,6 +312,7 @@ tests_x86_64_system_quick = [
>>     'virtio_version',
>>     'x86_cpu_model_versions',
>>     'vnc',
>> +  'memlock',
>>   ]
>>   tests_x86_64_system_thorough = [
>> diff --git a/tests/functional/test_memlock.py b/tests/functional/ 
>> test_memlock.py
>> new file mode 100755
>> index 00000000000..2b515ff979f
>> --- /dev/null
>> +++ b/tests/functional/test_memlock.py
>> @@ -0,0 +1,79 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that check overcommit memlock options
>> +#
>> +# Copyright (c) Yandex Technologies LLC, 2025
>> +#
>> +# Author:
>> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import re
>> +
>> +from typing import Dict
>> +
>> +from qemu_test import QemuSystemTest
>> +from qemu_test import skipLockedMemoryTest
>> +
>> +
>> +STATUS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
>> +
>> +
>> +@skipLockedMemoryTest(2_097_152)  # 2GB
>> +class MemlockTest(QemuSystemTest):
>> +    """
>> +    Runs a guest with memlock options.
>> +    Then verify, that this options is working correctly
>> +    by checking the status file of the QEMU process.
>> +    """
>> +
>> +    def common_vm_setup_with_memlock(self, memlock):
>> +        self.vm.add_args('-overcommit', f'mem-lock={memlock}')
> 
> This test fails on Darwin:
> 
> qemu-system-x86_64: mlockall: Function not implemented
> qemu-system-x86_64: locking memory failed
> 
> Please consider using the @skipIfOperatingSystem("Darwin") decorator,
> ...
> 
>> +        self.vm.launch()
>> +
>> +    def test_memlock_off(self):
>> +        self.common_vm_setup_with_memlock('off')
>> +
>> +        status = self.get_process_status_values(self.vm.get_pid())
>> +
>> +        self.assertTrue(status['VmLck'] == 0)
>> +
>> +    def test_memlock_on(self):
>> +        self.common_vm_setup_with_memlock('on')
>> +
>> +        status = self.get_process_status_values(self.vm.get_pid())
>> +
>> +        # VmLck > 0 kB and almost all memory is resident
>> +        self.assertTrue(status['VmLck'] > 0)
>> +        self.assertTrue(status['VmRSS'] >= status['VmSize'] * 0.70)
>> +
>> +    def test_memlock_onfault(self):
>> +        self.common_vm_setup_with_memlock('on-fault')
>> +
>> +        status = self.get_process_status_values(self.vm.get_pid())
>> +
>> +        # VmLck > 0 kB and only few memory is resident
>> +        self.assertTrue(status['VmLck'] > 0)
>> +        self.assertTrue(status['VmRSS'] <= status['VmSize'] * 0.30)
>> +
>> +    def get_process_status_values(self, pid: int) -> Dict[str, int]:
>> +        result = {}
>> +        raw_status = self._get_raw_process_status(pid)
>> +
>> +        for line in raw_status.split('\n'):
>> +            if m := STATUS_VALUE_PATTERN.match(line):
>> +                result[m.group(1)] = int(m.group(2))
>> +
>> +        return result
>> +
>> +    def _get_raw_process_status(self, pid: int) -> str:
>> +        try:
>> +            with open(f'/proc/{pid}/status', 'r') as f:
> 
> ... or even better implement skipUntilOperatingSystem() and use

Sorry, I meant:

   skipUntilOperatingSystem -> skipUnlessOperatingSystem

> it instead, since this test is clearly Linux-focused.
> 
>> +                return f.read()
>> +        except FileNotFoundError:
>> +            self.skipTest("Can't open status file of the process")
>> +
>> +
>> +if __name__ == '__main__':
>> +    MemlockTest.main()
> Regards,
> 
> Phil.
> 


