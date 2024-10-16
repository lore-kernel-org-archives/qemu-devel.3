Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D6D2A52F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t176O-0007f6-Pr; Wed, 16 Oct 2024 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t176N-0007ek-4a
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:42:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t176H-0000gY-6E
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:42:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e5a1c9071so3293696b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729096935; x=1729701735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uHOGqysiZdjdbsRYTH0VIqC/aGvnJhRxa2LGj0rsgTw=;
 b=dpghk73s1R6mE2Hhl2BPyO/WXmoiK62/Sye82UdkPY05mGHbUu+0z7DSShf8hsQuVF
 EWppGbicOcTC5dMOWsKvU048tPcqhAA+ljKL/6Q2e2WZlWaqxjWITSvmCK8AM7LxM6US
 0U8o7oQpnevuKseQbvlnT6hNzwh5vrs09PJBTq67LQit9HZl57UzZxLHRPHynPth3UVk
 oKj1guecrRNI5LuIIKQeIiJIuWiX3FCIWhXkCp8sfHNf04RJvogLJUUIJjFku3iRBRd2
 llDkAhh03zW4s3pRRcC5RhutOi/av9KKIVGx/3rcvdWdsoItnGlocfXHOmnAhdj8fNJN
 vSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729096935; x=1729701735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uHOGqysiZdjdbsRYTH0VIqC/aGvnJhRxa2LGj0rsgTw=;
 b=O+GppYW4qSrYyFmZ3Idus5ZQWK6DUGnWv1rJTORhkjUMd5IEymfdXWomtlgViV7rQz
 d+N7nfSFifzuOZevycWwcjFxeuWgRN3LpT57KGsP0XbnF4FOiwoKfBoHcX7o27D3FkBa
 4IY/zgKDJF2nqU4hUjLu91cZdVeWKEAv5tVYehbFmDt2SKz3rWf/uOwQkzWI6oZohsB/
 AHixGIIo0gFWg0E14MMES9ingFdxYnDZUnXTjoPUz6OxvdDOWoyUiSxchP+rZzqo5R3v
 U7cOXvN69NGgSgMPeWQRbQkrKZXqQsrxuc4WyepucCRT61Ymi6yUJEI2AphjQg9F+1tJ
 pbLw==
X-Gm-Message-State: AOJu0Yw2aHQnzBu3Yc9iXjv56ukuPE2FFgW0hDyI+zKq9hDZ+DymN3bw
 8ft8/lp4xKrgkXaAaqBJc138ULl4f2x+QjbyXuGsb7BFcnR48q+D8HfHHEDin/Q=
X-Google-Smtp-Source: AGHT+IGUmgXBVsbMaXtgNqBDCPuzpZy0ruQD5w9XFsc90uH6FCL+ufVE2xkCB6xWAWOcKGPZjtYWnA==
X-Received: by 2002:a05:6a21:3946:b0:1d9:1aa0:10b6 with SMTP id
 adf61e73a8af0-1d91aa01161mr723259637.3.1729096935452; 
 Wed, 16 Oct 2024 09:42:15 -0700 (PDT)
Received: from [192.168.1.221] ([148.222.130.0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e82a19a8esm1452028b3a.211.2024.10.16.09.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 09:42:15 -0700 (PDT)
Message-ID: <4ee4f4bb-140a-43b7-bc5b-5c0098a6079a@linaro.org>
Date: Wed, 16 Oct 2024 13:42:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert most Aspeed machine tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Thomas Huth <thuth@redhat.com>
References: <20241016090741.2026630-1-clg@redhat.com>
 <Zw-HwHsGaO0W2fbc@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zw-HwHsGaO0W2fbc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/10/24 06:30, Daniel P. Berrangé wrote:
> On Wed, Oct 16, 2024 at 11:07:41AM +0200, Cédric Le Goater wrote:
>> This is a simple conversion of the tests with some cleanups and
>> adjustments to match the new test framework. Replace the zephyr image
>> MD5 hashes with SHA256 hashes while at it.
>>
>> The SDK tests depend on a ssh class from avocado.utils which is
>> difficult to replace. To be addressed separately.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/avocado/machine_aspeed.py     | 252 --------------------------
>>   tests/functional/meson.build        |   2 +
>>   tests/functional/test_arm_aspeed.py | 269 ++++++++++++++++++++++++++++
>>   3 files changed, 271 insertions(+), 252 deletions(-)
>>   create mode 100644 tests/functional/test_arm_aspeed.py
>>
>> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
>> new file mode 100644
>> index 000000000000..2f9a90f64d8f
>> --- /dev/null
>> +++ b/tests/functional/test_arm_aspeed.py
>> @@ -0,0 +1,269 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots the ASPEED SoCs with firmware
>> +#
>> +# Copyright (C) 2022 ASPEED Technology Inc
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +import time
>> +import subprocess
>> +import tempfile
>> +
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +from qemu_test import interrupt_interactive_console_until_pattern
>> +from qemu_test import exec_command
>> +from qemu_test import has_cmd
>> +from qemu_test.utils import archive_extract
>> +from zipfile import ZipFile
>> +from unittest import skipUnless
>> +
>> +class AST1030Machine(QemuSystemTest):
>> +
>> +    def test_ast1030_zephyros_1_04(self):
>> +        asset_url = Asset(
>> +            ('https://github.com/AspeedTech-BMC'
>> +             '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip'),
>> +            '4ac6210adcbc61294927918707c6762483fd844dde5e07f3ba834ad1f91434d3')
> 
> Don't instantiate assets inline to test code, as this makes them
> invisible to the logic that pre-downloads assets prior to running
> tests. As a result you're liable to have test timeouts if the
> on-the-fly asset download takes too long.
> 
> Instead You should use a class level varible with an "ASSET_" name
> prefix eg
> 
>     ASSET_<BLAH> = Asset(....)

This is somehow documented in docs/devel/testing/functional.rst but
could be clarified:

   The second problem with downloading files from the internet are time
   constraints. The time for downloading files should not be taken into
   account when the test is running and the timeout of the test is
   ticking (since downloading can be very slow, depending on the network
   bandwidth).
   This problem is solved by downloading the assets ahead of time, before
   the tests are run. This pre-caching is done with the qemu_test.Asset
   class. To use it in your test, declare an asset in your test class
   with its URL and SHA256 checksum like this::

       ASSET_somename = (
           ('https://www.qemu.org/assets/images/qemu_head_200.png'),
 
'34b74cad46ea28a2966c1d04e102510daf1fd73e6582b6b74523940d5da029dd')


> 
> See other converted tests for examples of the pattern.
> 
>> +        kernel_name = "ast1030-evb-demo/zephyr.elf"
>> +        zip_file = asset_url.fetch()
>> +        with ZipFile(zip_file, 'r') as zf:
>> +                     zf.extract(kernel_name, path=self.workdir)
>> +        kernel_file = os.path.join(self.workdir, kernel_name)
>> +
>> +        self.set_machine('ast1030-evb')
>> +        self.vm.set_console()
>> +        self.vm.add_args('-kernel', kernel_file, '-nographic')
>> +        self.vm.launch()
>> +        wait_for_console_pattern(self, "Booting Zephyr OS")
>> +        exec_command_and_wait_for_pattern(self, "help",
>> +                                          "Available commands")
>> +
> 
> With regards,
> Daniel


