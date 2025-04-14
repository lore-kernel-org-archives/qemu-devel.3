Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F25C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4GUl-00017p-7E; Mon, 14 Apr 2025 05:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4GUj-00017c-HP
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4GUg-00020u-Lb
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744624364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3qvRBxuvE6GEtvn6SaawjrRkKLWvQEhWycs8AYwc0rk=;
 b=VTBl1bJM0Ua5OBxEGGQz1HR0nDsai7D7Dx3PhI/xh+TM9CJeTh8i8bFhxrjaGPklklRSYN
 wmVER/DhW1xoixhYjM7xh036TWtZ3YHHHfuv65XshlkJjhy7jTN0DDL8DcyDKVdZJdGqZW
 6r87ZqfYXVzQaRFH9Sdd/RAGkoTozL0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-RbPi9DcZPXWEO4v-coGDFw-1; Mon, 14 Apr 2025 05:52:40 -0400
X-MC-Unique: RbPi9DcZPXWEO4v-coGDFw-1
X-Mimecast-MFC-AGG-ID: RbPi9DcZPXWEO4v-coGDFw_1744624359
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso25211435e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 02:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744624359; x=1745229159;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3qvRBxuvE6GEtvn6SaawjrRkKLWvQEhWycs8AYwc0rk=;
 b=C9E8wUsOt16Fyy1uErBUK0TOWy9C2uM8RpCNu6YA4yuGcRioNN6AhDF8XpjNlgfHHz
 YJNmJgVgHw5bR1tn03ui52DTpa55dC+BNRFiKG5hRyYA82/gVZs2VCjxg7qEpWvl+GKu
 IGl6E/MOjCL/tS6NlamY2/Xg7N3WvWUIN7893pzjp6RLVLtNzc9LvG0y/mzXTiEGBLMK
 7k/a5ROVu/MZ+AxuWXb++uQBYSvk4LRAXbk23EnIixNFG5pF8TGZiTmDwq8tvNlm5mv6
 kJA97SPHOWvggUHNlDd0vuRl6KDqVUslrM8BmjpJopp2pOfyaqpg+7WqD5coCzIq+KcB
 SOzA==
X-Gm-Message-State: AOJu0Ywywkj6TOFoVmSdj3OgWcS8NDHo46LMPSgmftEsYaPfnT8lx2Ak
 XHCo6TIWxHWq0w+ZcybPuUdX1+Iop73WFJeOEwTT5qhfgMakI4n24xgU8kcUPwmiRQFXYkwI84w
 59lJHoyjtOUbZ7pfBvB+M3VH1Bw8WXmYvxOY4w6FBawYJAoUtSJth
X-Gm-Gg: ASbGncsDqfO8F7iJYzPVHYijUs25dYO+1nrPhsmeS/Pf1ydb2S5F6j8mdKWJYcuEId6
 iEcjOKVbvapAcp3+euFGCKfWjDzsulLZFgreEPbRRVWITCjpRtPAolXWl/GxCPEu+FbyPk6OrAi
 7/sJpPcjZyKV3Y4nnRIodQEANK+9POtpPjU457McJ8a3LhT80Fd2q4TpybYCw58YII2HAn8Klu6
 hr2POxCJxDfua3cEcmoex0P8sPOsqfYTRYSQ5TcQGkd1kfXH1iMkmHe1HKJPX/S8G0RyUg9Joiu
 DIcghd1X0pDG6jhJxsLEkctD60TQoCVFnRde
X-Received: by 2002:a05:600c:5026:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43f3a9aee21mr116251855e9.30.1744624359421; 
 Mon, 14 Apr 2025 02:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSLmiqyh0l57W5P0CU1AhubYSHrFKkv1O6Oxbc1ZxZSVCz2uLrIMiKZYH97+IAModnYIpMdw==
X-Received: by 2002:a05:600c:5026:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43f3a9aee21mr116251605e9.30.1744624358977; 
 Mon, 14 Apr 2025 02:52:38 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c49f7sm169173085e9.17.2025.04.14.02.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 02:52:38 -0700 (PDT)
Message-ID: <2ecb3d51-300a-4b4d-bc79-842f6356a32f@redhat.com>
Date: Mon, 14 Apr 2025 11:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] tests/functional: Convert reverse_debugging tests
 to the functional framework
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-4-thuth@redhat.com> <Z-PJQwDMG3QYP563@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z-PJQwDMG3QYP563@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 26/03/2025 10.30, Daniel P. Berrangé wrote:
> On Tue, Mar 25, 2025 at 09:00:11PM +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> These tests are using the gdb-related library functions from the
>> Avocado framework which we don't have in the functional framework
>> yet. So for the time being, keep those imports and skip the test
>> if the Avocado framework is not installed on the host.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS                                   |   2 +-
>>   tests/functional/meson.build                  |   4 +
>>   .../reverse_debugging.py                      | 114 +++---------------
>>   .../functional/test_aarch64_reverse_debug.py  |  37 ++++++
>>   tests/functional/test_ppc64_reverse_debug.py  |  41 +++++++
>>   tests/functional/test_x86_64_reverse_debug.py |  36 ++++++
>>   6 files changed, 138 insertions(+), 96 deletions(-)
>>   rename tests/{avocado => functional}/reverse_debugging.py (66%)
>>   create mode 100755 tests/functional/test_aarch64_reverse_debug.py
>>   create mode 100755 tests/functional/test_ppc64_reverse_debug.py
>>   create mode 100755 tests/functional/test_x86_64_reverse_debug.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8f470a1c9b7..73ccf5e5176 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3670,7 +3670,7 @@ F: docs/system/replay.rst
>>   F: stubs/replay.c
>>   F: tests/avocado/replay_kernel.py
>>   F: tests/avocado/replay_linux.py
>> -F: tests/avocado/reverse_debugging.py
>> +F: tests/functional/*reverse_debug*.py
>>   F: tests/functional/*replay*.py
>>   F: qapi/replay.json
>>   
> 
>> diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarch64_reverse_debug.py
>> new file mode 100755
>> index 00000000000..82925bf5908
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_reverse_debug.py
>> @@ -0,0 +1,37 @@
>> +#!/usr/bin/env python3
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Reverse debugging test
>> +#
>> +# Copyright (c) 2020 ISP RAS
>> +#
>> +# Author:
>> +#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +from qemu_test import Asset, skipIfMissingImports
>> +from reverse_debugging import ReverseDebugging
>> +
>> +
>> +@skipIfMissingImports('avocado')
> 
> Would it make sense to specialize this to 'avocado.utils' ?

Sure, can do!

>> +class ReverseDebugging_AArch64(ReverseDebugging):
>> +
>> +    REG_PC = 32
>> +
>> +    KERNEL_ASSET = Asset(
>> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>> +         'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
>> +        '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
>> +
>> +    def test_aarch64_virt(self):
>> +        self.set_machine('virt')
>> +        self.cpu = 'cortex-a53'
>> +        kernel_path = self.KERNEL_ASSET.fetch()
>> +        self.reverse_debugging(args=('-kernel', kernel_path))
>> +
>> +
>> +if __name__ == '__main__':
>> +    ReverseDebugging.main()
> 
>> diff --git a/tests/functional/test_x86_64_reverse_debug.py b/tests/functional/test_x86_64_reverse_debug.py
>> new file mode 100755
>> index 00000000000..aba31f68748
>> --- /dev/null
>> +++ b/tests/functional/test_x86_64_reverse_debug.py
>> @@ -0,0 +1,36 @@
>> +#!/usr/bin/env python3
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Reverse debugging test
>> +#
>> +# Copyright (c) 2020 ISP RAS
>> +#
>> +# Author:
>> +#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +from qemu_test import skipIfMissingImports, skipFlakyTest
>> +from reverse_debugging import ReverseDebugging
>> +
>> +
>> +@skipIfMissingImports('avocado')
>> +class ReverseDebugging_X86_64(ReverseDebugging):
>> +
>> +    REG_PC = 0x10
>> +    REG_CS = 0x12
>> +    def get_pc(self, g):
>> +        return self.get_reg_le(g, self.REG_PC) \
>> +            + self.get_reg_le(g, self.REG_CS) * 0x10
>> +
>> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
> 
> This bug refers to ppc64. Was this a copy and paste mistake, does
> that bug need updating to also mention x86_64 ?

I'm not sure whether it's the same bug, so I opened another one for x86 here:

  https://gitlab.com/qemu-project/qemu/-/issues/2922

I also noticed that it fails on aarch64 in some rare cases, and in a 
different way. So here's another bug for aarch64:

  https://gitlab.com/qemu-project/qemu/-/issues/2921

I'll use those in the decorators in the next version of the patch.

  Thomas


