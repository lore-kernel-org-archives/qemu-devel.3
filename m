Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF17BC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglPt-00084x-0p; Wed, 21 Aug 2024 09:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglPq-00084R-M4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:30:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglPn-0004SH-1H
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:30:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso55315565e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247016; x=1724851816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04eYKQ4b7wyqvMG7PnTWSUsDEQxkeFN0uHCmMKltbYQ=;
 b=cObUjuAUR/0cUxcD7Js3o15aGjXtdAe9pwm2CjvSjSI2AH/FZYnaTFz1SQCgSoBuZ8
 BJAG39NE5ZUot6njWoLLFFxsT3GN2lgrFxQg6fdwwsnearxokQwdbMFm6Mo4vFP19sY3
 hMO/Arf7fp2DuuO2bGO6Q5is3LFWVz4vqZOkOojhrOSiQ/dBEJ0RRc/qprWzRBS5bZMx
 ayzlOlYvHjvw327TFyGzl5P6BL2/71n8m6zdMFxAILwv2tYVOR/BgJ88Ws5JSZ5smNI0
 mksTFHX2VrckLdP+3mHw4WWxXaykqvwgM93YAvWUx/l9olD6SGefdpTwgalf8KOUIULJ
 Y5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247016; x=1724851816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04eYKQ4b7wyqvMG7PnTWSUsDEQxkeFN0uHCmMKltbYQ=;
 b=qNMHDV0gR4UwuLtgoyyB+W5AHJPhiRqqkR//8ZToV8FqgMJanpB5Lv2Gmt08VS+Zfp
 DxaRDt3vEGduQRwclD/OJ/NcgmbGDdVGfK2R2V3RDaJwK4Q6usMUGBc4+OTXWAMKPg/c
 ohIT2EMfZeqbmu0uKuiqu6psA2rXiqyk34ibcN95Pr5AmYW0bkb1HpaxKP+YIt2vH6Pv
 /6qlWYvLKyvVUhzNidoniGEsSV3h5QxSFzdXgzT7u1OUxn32I4u6Zyjl3In7lB/jiTW4
 qbWLHKSRFMdhNlnN7LZxGpbiTFG5ZELpPyKqZAwWZJA6ZmC8UgTMROzwKriWFVx/x4d0
 Ey+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg9mL6im5A2XFH1rYFfZxvmz5old3lP8HXN8EYVEwUfB4qLdEChFvqMgZDRlfPN/P1o3zosTjqK86N@nongnu.org
X-Gm-Message-State: AOJu0YxNo6yAMxGhSeFClDRWnqIW96ULa50Adp02W3axQn780dgzKkGW
 ehEQH8zBQNPCGv2KBTvebSIWj8gZUMrCt/8FwFZ/gGDhlz6a+Bu7rdfcH+NLkUg=
X-Google-Smtp-Source: AGHT+IEiACJfTrwxJfo4aMid6xADQxtcVfyg5K8yjGcyR76vCoBq6bJ/nQJineRcApcgt7HrXtNTAQ==
X-Received: by 2002:a05:600c:1e1d:b0:426:6822:861 with SMTP id
 5b1f17b1804b1-42abd25496cmr14940915e9.36.1724247016250; 
 Wed, 21 Aug 2024 06:30:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abee8d1d9sm26828925e9.22.2024.08.21.06.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 06:30:15 -0700 (PDT)
Message-ID: <e67b9214-78fa-4eaf-9683-9982366241c2@linaro.org>
Date: Wed, 21 Aug 2024 15:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert mips fuloong2e avocado test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240821112959.54237-1-philmd@linaro.org>
 <9a289ee9-63c4-470a-8256-da1f04e539aa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9a289ee9-63c4-470a-8256-da1f04e539aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 21/8/24 13:46, Thomas Huth wrote:
> On 21/08/2024 13.29, Philippe Mathieu-Daudé wrote:
>> Straight forward conversion. Update the SHA1 hashes to
>> SHA256 hashes since SHA1 should not be used anymore nowadays.
>>
>> Since the asset is expected locally and the test is guarded
>> with QEMU_TEST_ALLOW_UNTRUSTED_CODE, keep it under the 'quick'
>> category.
>>
>>    $ RESCUE_YL_PATH=/path/to/rescue-yl QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
>>      make check-functional-mips64el
>>    1/4 qemu:func-quick+func-mips64el / 
>> func-mips64el-empty_cpu_model      OK   0.12s   1 subtests passed
>>    2/4 qemu:func-quick+func-mips64el / 
>> func-mips64el-version              OK   0.13s   1 subtests passed
>>    3/4 qemu:func-quick+func-mips64el / 
>> func-mips64el-info_usernet         OK   0.15s   1 subtests passed
>>    4/4 qemu:func-quick+func-mips64el / 
>> func-mips64el-mips64el_fuloong2e   OK   0.19s   1 subtests passed
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20240821082748.65853-1-thuth@redhat.com>
>> ---
>>   MAINTAINERS                                   |  2 +-
>>   tests/functional/meson.build                  |  4 +++
>>   .../test_mips64el_fuloong2e.py}               | 32 +++++++++----------
>>   3 files changed, 21 insertions(+), 17 deletions(-)
>>   rename tests/{avocado/machine_mips_fuloong2e.py => 
>> functional/test_mips64el_fuloong2e.py} (56%)
>>   mode change 100644 => 100755
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 25e71ac14c..77fbb5d42e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1384,7 +1384,7 @@ S: Odd Fixes
>>   F: hw/mips/fuloong2e.c
>>   F: hw/pci-host/bonito.c
>>   F: include/hw/pci-host/bonito.h
>> -F: tests/avocado/machine_mips_fuloong2e.py
>> +F: tests/functional/test_mips64el_fuloong2e.py
>>   Loongson-3 virtual platforms
>>   M: Huacai Chen <chenhuacai@kernel.org>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 12e08e365b..8d28313a65 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -51,6 +51,10 @@ tests_microblazeel_thorough = [
>>     'microblazeel_s3adsp1800'
>>   ]
>> +tests_mips64el_quick = [
>> +  'mips64el_fuloong2e',
>> +]
>> +
>>   tests_mips64el_thorough = [
>>     'mips64el_loongson3v',
>>   ]
>> diff --git a/tests/avocado/machine_mips_fuloong2e.py 
>> b/tests/functional/test_mips64el_fuloong2e.py
>> old mode 100644
>> new mode 100755
>> similarity index 56%
>> rename from tests/avocado/machine_mips_fuloong2e.py
>> rename to tests/functional/test_mips64el_fuloong2e.py
>> index 89291f47b2..523dce4ec4
>> --- a/tests/avocado/machine_mips_fuloong2e.py
>> +++ b/tests/functional/test_mips64el_fuloong2e.py
>> @@ -1,3 +1,5 @@
>> +#!/usr/bin/env python3
>> +#
>>   # Functional tests for the Lemote Fuloong-2E machine.
>>   #
>>   # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
>> @@ -9,34 +11,32 @@
>>   import os
>> -from avocado import skipUnless
>> -from avocado_qemu import QemuSystemTest
>> -from avocado_qemu import wait_for_console_pattern
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern
>> +from unittest import skipUnless
>>   class MipsFuloong2e(QemuSystemTest):
>>       timeout = 60
>> -    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted 
>> code')
>> -    @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not 
>> available')
> 
> Wouldn't it be better to keep the RESCUE_YL_PATH decorator?

Oops yes, no clue how I removed that.

> 
>> +    ASSET_KERNEL = Asset(
>> +        # http://dev.lemote.com/files/resource/download/rescue/rescue-yl
>> +        ('file://' + os.getenv('RESCUE_YL_PATH')),
> 
> The precaching is now failing if this environment variable has not been 
> set:
> 
> Traceback (most recent call last):
>    File 
> "/home/thuth/devel/qemu/tests/functional/test_mips64el_fuloong2e.py", 
> line 18, in <module>
>      class MipsFuloong2e(QemuSystemTest):
>    File 
> "/home/thuth/devel/qemu/tests/functional/test_mips64el_fuloong2e.py", 
> line 24, in MipsFuloong2e
>      ('file://' + os.getenv('RESCUE_YL_PATH')),
>       ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> TypeError: can only concatenate str (not "NoneType") to str
> 
> Since we don't really need precaching in this case, maybe you could move 
> the asset definition into the function itself, or do this test without 
> the asset framework?

Good idea.

