Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D51CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCCUv-0003Es-DM; Fri, 24 Oct 2025 03:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCCUs-0003Eb-Uk
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:46:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCCUq-0005lk-ME
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:46:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so13835845e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761291958; x=1761896758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P2agAksDfgBGMvxHt2qKw+DNuFUbP3mLGdaRkoIB8P4=;
 b=e29j8DH5N7W7i5HThZO3ZmAxXjpNyuBICIuVU88dd/J3chHy9Mx61Mj9en7TkTzXTm
 y5ixeLwNWWrf0Z+I1BrAiief1Q2W5fUi50zkvDyAh486eQPtEJ7ChQug9Vs6eHLDol0o
 5J0mJyhYhIfh1kWxC93XV0doHmrecPlXCljc6nkPI9J5+bgwVkdpBRQnW0RaAreNtAN8
 huSY/b1RgpmxDlPoBPPascrAmEkyZZwU5at6WETMx9SPb4F9hQ8H4RLtKv1S3UI06Mgy
 jurtr0uihgVgTDFL1+19Qa8gMKf7BNleXzCD7qKC1T70Ea20cs7m3SISWKjoyC8Yd9jo
 ypUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761291958; x=1761896758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P2agAksDfgBGMvxHt2qKw+DNuFUbP3mLGdaRkoIB8P4=;
 b=iEvnUR2/TMpQUN8jgDiicA5KtFvvHQO2KfLuqr7FybrxNMY2MgrR8FkfjkbHz43MOE
 HYdoXFwo+FYQrX+hUPLtVRvdVszpR7gU0ep4U/3L13xUJ/du50cxHlh9nd7tEP9XeY2u
 +XHvGTXRCKTs0syFlnqhoTqVO9XQRXRs5KROK+PxWKco+x9QWZ+FiArX6pN+KTCqACfq
 8rgzjS36kaJrQi9LAooWpbEW+JoGuD2DU1sgzJRsvv9BISs4d/bIcu8WWl08tFF4SGsI
 E+pXGOsTfmu+LS0n3se69T2DyaaAKHqstk3A/PRlmpjUZ7getFN90GncaAkhEU8Wuj5W
 UMVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrOXcwTGIjCowFKVwOTVymjwvtGijZzNDPevdOkyPWCTeJqFRQVJDnZrf8JYTI1fCzGQUw5Pf74lJ5@nongnu.org
X-Gm-Message-State: AOJu0Yz4M9Wmbli5YCY0Cse8E18q+GvQ7z8nqyZHMd1jCgSvIeHO9Qja
 nlM0ePdoyA4R4WUlPg+Hxoe+VwPdUrhrOg+tftnXKNFMqoqoflVlEEfijr6+d5ccZ+U=
X-Gm-Gg: ASbGnctECvzIfZrz5GZXJBJLpXfs+Dx5eCE7+WMnP7SiTSOhPuDfN9/Y7ppm8xBQh9u
 Biqe8GeWN/EkzBHtCeNagpCRcu3KD15d7rAUzl8EeDbZS+bjs+pwMadKnou0SmgN5AYG2ZvPeh3
 dIXiyotr09X/K24ShiBEh86KIk/Ytv+fYjvjVc7LfYGYmLziZhT5F9yFvkeM4kmPdV0PTAXATey
 AQRxYGX1aaxxHIoBHB6S9Cue4+cxmB0HXamddmy4IGjpAgCJb673f3EOy+I9f1t0Hm18/B6zEQE
 68L816oF8Iukb15etGb7HeSPm9FnROdiy1yPM2DkascHyYMZ7vpJfpWhn0XKQG5M/0UoBkTNH9y
 jVnjDsjM44gIzLqGoshU192oCj7ImQ+SELc5hmq4/NnAO8VouXO9UvgDtZ103ukAkpatepFmMIa
 a+T57F1QEs+t7v6r52yeuweeLXD7csukXvLng7+RwtpRQ=
X-Google-Smtp-Source: AGHT+IHr8V282N5L3nNEMqaWZVdSPvkmOzHks78ib+Dt+p58tXtVqkuEjad8TGkwW/zP6oeJNGXFGg==
X-Received: by 2002:a05:600c:1546:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-475d2ecb307mr10654715e9.31.1761291958471; 
 Fri, 24 Oct 2025 00:45:58 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf15b10sm89114855e9.11.2025.10.24.00.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 00:45:57 -0700 (PDT)
Message-ID: <986e788c-6a94-4c27-9a6e-a761e3f763c0@linaro.org>
Date: Fri, 24 Oct 2025 09:45:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/10] tests/functional: add memlock tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250611125846.125918-1-thuth@redhat.com>
 <20250611125846.125918-7-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250611125846.125918-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Alexandr,

On 11/6/25 14:58, Thomas Huth wrote:
> From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> 
> Add new tests to check the correctness of the `-overcommit memlock`
> option (possible values: off, on, on-fault) by using
> `/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck
> values:
> 
> * if `memlock=off`, then VmLck = 0;
> * if `memlock=on`, then VmLck > 0 and almost all memory is resident;
> * if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> Message-ID: <20250605065908.299979-3-dtalexundeer@yandex-team.ru>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build     |  1 +
>   tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+)
>   create mode 100755 tests/functional/test_memlock.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 557d59ddf4d..c3fca446cff 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -312,6 +312,7 @@ tests_x86_64_system_quick = [
>     'virtio_version',
>     'x86_cpu_model_versions',
>     'vnc',
> +  'memlock',
>   ]
>   
>   tests_x86_64_system_thorough = [
> diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
> new file mode 100755
> index 00000000000..2b515ff979f
> --- /dev/null
> +++ b/tests/functional/test_memlock.py
> @@ -0,0 +1,79 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that check overcommit memlock options
> +#
> +# Copyright (c) Yandex Technologies LLC, 2025
> +#
> +# Author:
> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import re
> +
> +from typing import Dict
> +
> +from qemu_test import QemuSystemTest
> +from qemu_test import skipLockedMemoryTest
> +
> +
> +STATUS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
> +
> +
> +@skipLockedMemoryTest(2_097_152)  # 2GB
> +class MemlockTest(QemuSystemTest):
> +    """
> +    Runs a guest with memlock options.
> +    Then verify, that this options is working correctly
> +    by checking the status file of the QEMU process.
> +    """
> +
> +    def common_vm_setup_with_memlock(self, memlock):
> +        self.vm.add_args('-overcommit', f'mem-lock={memlock}')

This test fails on Darwin:

qemu-system-x86_64: mlockall: Function not implemented
qemu-system-x86_64: locking memory failed

Please consider using the @skipIfOperatingSystem("Darwin") decorator,
...

> +        self.vm.launch()
> +
> +    def test_memlock_off(self):
> +        self.common_vm_setup_with_memlock('off')
> +
> +        status = self.get_process_status_values(self.vm.get_pid())
> +
> +        self.assertTrue(status['VmLck'] == 0)
> +
> +    def test_memlock_on(self):
> +        self.common_vm_setup_with_memlock('on')
> +
> +        status = self.get_process_status_values(self.vm.get_pid())
> +
> +        # VmLck > 0 kB and almost all memory is resident
> +        self.assertTrue(status['VmLck'] > 0)
> +        self.assertTrue(status['VmRSS'] >= status['VmSize'] * 0.70)
> +
> +    def test_memlock_onfault(self):
> +        self.common_vm_setup_with_memlock('on-fault')
> +
> +        status = self.get_process_status_values(self.vm.get_pid())
> +
> +        # VmLck > 0 kB and only few memory is resident
> +        self.assertTrue(status['VmLck'] > 0)
> +        self.assertTrue(status['VmRSS'] <= status['VmSize'] * 0.30)
> +
> +    def get_process_status_values(self, pid: int) -> Dict[str, int]:
> +        result = {}
> +        raw_status = self._get_raw_process_status(pid)
> +
> +        for line in raw_status.split('\n'):
> +            if m := STATUS_VALUE_PATTERN.match(line):
> +                result[m.group(1)] = int(m.group(2))
> +
> +        return result
> +
> +    def _get_raw_process_status(self, pid: int) -> str:
> +        try:
> +            with open(f'/proc/{pid}/status', 'r') as f:

... or even better implement skipUntilOperatingSystem() and use
it instead, since this test is clearly Linux-focused.

> +                return f.read()
> +        except FileNotFoundError:
> +            self.skipTest("Can't open status file of the process")
> +
> +
> +if __name__ == '__main__':
> +    MemlockTest.main()
Regards,

Phil.


