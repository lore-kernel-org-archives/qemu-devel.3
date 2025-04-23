Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9047C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YKd-0004C8-B4; Wed, 23 Apr 2025 07:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YKH-00040B-49
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:31:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YKF-0003Q5-0n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:31:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so30619025e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745407893; x=1746012693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZoweNb3jS+BVSvBj33Z9POFS0gl3QlDK7DUz44FwK38=;
 b=O0wakIuWu5nfZcg8MQm2Ok5SzZ3IyM5O3FDOAas1uEvya02mj/ncl/56HzfFAfwh/v
 nXyCUW507eR2Qk4hqfiOyFHEBua9OSj8ofiXhBwn3A23tDbSBSiaAk/XUtfZwOiWioB4
 quvcXvNli1+L/+b3p98mHgefUMDYF5UXgrBIUu1FKyE4yLVL4JCkfsDNQDRORTAnQX8R
 GlX31oz+4FgxsCcUrR1ARSw12MhtAprXPKbQkIuRH4gfwZF2iGLEkcnGMolr5mfuUNrO
 BaHrmT2ih31AFzGSPbGVREtYmainbMJPQm9Qn6NPb2y48dE3Cc0PC413as4vUO+BgdIE
 jBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745407893; x=1746012693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoweNb3jS+BVSvBj33Z9POFS0gl3QlDK7DUz44FwK38=;
 b=VCS4DkZxtNElRpPxTKcdZzV9VbOf5QgbiwNsofzawAmwQeNhDfdAtZcFx8S/CZEbis
 7+mP2N2NbED7EDOn5LJWD/pNIyVvAAtqXTh+gRwtVQaRxwczaAkFNL76KBt8ELnBxF2B
 m24r2LTKdc6WSlp7a6cpjSf1faIP+mY7VWWdfn4S6gKgglSkZ2MkR2qVoQ2rclYDkSQp
 +HIaFt35rNf6Sw/MzlzX1KX5pKGjf//6HH/Llw9FsL2NUUtGJF550VyHPjv9OUCZAR2h
 7ZOy1vd6/50XO9CgYD0lm/NAUAk805LnWMzSVW4cpFzW5nA/NL08wg5z8O5oSuVtVu/6
 5diA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpc+vy8Vm3l7A5zYTcmDEpGL3Pxk5/4zLm0fU6KuDx9NJ9ZlaSscNmtEszaHQ5NNUnGC44HfGUrAcg@nongnu.org
X-Gm-Message-State: AOJu0Yy7YledkM21/hV7q/TsBsVwTvrxqeBlJPUqjO2XZ71EC8t/mO9w
 HcFtb+2vpf1S0pkehh5TIXDS3p7DG9WAVI8L4q2B1qrr6FUsiDXeoX3TiZNEDL4=
X-Gm-Gg: ASbGncvuByoF1RmHqsLz1HngjcQq1i2yDzoot65XYZXTinTU7vM4hAxWg6UyH+GNDqB
 wLkJzlJXZg9wQhheQQU+PaaDPwIKo4WG1mabsuJ+FoFxjPxR5fk5Mq+YcGeJ1gbIdfXJjWktWxC
 A6b1/r1OMH/vGkGClrq6KJ6THeu6Hk5lv9h6ZI14yc9GPIFwPSV7BUIwGI8jQ11o9j6lUUQNSE9
 n8FRJSAGwINzTwn03+FhHqQl9scEPJ/KJ522HZdEjnlYYoO4VpPHuLd8iGKh9F+fyYIaKY6E2wj
 G2nKewGX448dow8sjW4BhONhn706hAyRbCLugvtGx+XVg49ETqnd7PZGuBLYyxQzUtTsmad59Nv
 kwij97u7R
X-Google-Smtp-Source: AGHT+IGqWtFbCYgdZAFuryle6E0qmyAbW5STW2y67aF0WmF4ykbpQ1vu8gL1bH+9D//Sf9ZZngE16Q==
X-Received: by 2002:a05:600c:46c6:b0:43d:b3:f95 with SMTP id
 5b1f17b1804b1-4406ac0fb4amr113852035e9.28.1745407893147; 
 Wed, 23 Apr 2025 04:31:33 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092db2a5dsm23014745e9.25.2025.04.23.04.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:31:32 -0700 (PDT)
Message-ID: <e3ea2723-126f-45af-8bdd-602ee512b51f@linaro.org>
Date: Wed, 23 Apr 2025 13:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2] tests/functional: Add test for imx8mp-evk
 board with USDHC coverage
To: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
References: <20250409202630.19667-1-shentey@gmail.com>
 <aa47d49a-b81a-46cf-811a-2045e453f4bf@redhat.com>
 <6621A6A6-83F8-476C-973C-FE3D1918E061@gmail.com>
 <2c725cbc-6ba0-4e07-8863-acacbb45e121@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2c725cbc-6ba0-4e07-8863-acacbb45e121@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Thomas,

On 23/4/25 11:40, Thomas Huth wrote:
> On 23/04/2025 11.31, Bernhard Beschow wrote:
>>
>>
>> Am 10. April 2025 06:05:35 UTC schrieb Thomas Huth <thuth@redhat.com>:
>>> On 09/04/2025 22.26, Bernhard Beschow wrote:
>>>> Introduce a functional test which boots Debian 12 on the imx8mp-evk 
>>>> board. Since
>>>> the root filesystem resides on an SD card, the test also verifies 
>>>> the basic
>>>> operation of the USDHC.
>>>>
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>
>>>> -- 
>>>> v2:
>>>> * Make test file executable (Thomas)
>>>> * Omit fetch() (Thomas)
>>>> * Omit "-accel tcg" (Thomas)
>>>> * Add "snapshot=on" to make potential future tests independent
>>>>
>>>> Supersedes: 20250405214900.7114-1-shentey@gmail.com
>>>> ---
>>>>    MAINTAINERS                                 |  1 +
>>>>    tests/functional/meson.build                |  1 +
>>>>    tests/functional/test_aarch64_imx8mp_evk.py | 66 ++++++++++++++++ 
>>>> +++++
>>>>    3 files changed, 68 insertions(+)
>>>>    create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index d54b5578f8..4ceffa89dc 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp.h
>>>>    F: include/hw/misc/imx8mp_*.h
>>>>    F: include/hw/pci-host/fsl_imx8m_phy.h
>>>>    F: docs/system/arm/imx8mp-evk.rst
>>>> +F: tests/functional/test_aarch64_imx8mp_evk.py
>>>>    F: tests/qtest/rs5c372-test.c
>>>>      MPS2 / MPS3
>>>> diff --git a/tests/functional/meson.build b/tests/functional/ 
>>>> meson.build
>>>> index 0f8be30fe2..aaaf3472f1 100644
>>>> --- a/tests/functional/meson.build
>>>> +++ b/tests/functional/meson.build
>>>> @@ -75,6 +75,7 @@ tests_aarch64_system_quick = [
>>>>      tests_aarch64_system_thorough = [
>>>>      'aarch64_aspeed',
>>>> +  'aarch64_imx8mp_evk',
>>>>      'aarch64_raspi3',
>>>>      'aarch64_raspi4',
>>>>      'aarch64_replay',
>>>> diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/ 
>>>> functional/test_aarch64_imx8mp_evk.py
>>>> new file mode 100755
>>>> index 0000000000..62fee74044
>>>> --- /dev/null
>>>> +++ b/tests/functional/test_aarch64_imx8mp_evk.py
>>>> @@ -0,0 +1,66 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>> +# Functional test that boots a Linux kernel and checks the console
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +from qemu_test import LinuxKernelTest, Asset
>>>> +
>>>
>>> In case you respin (due to other reasons), please add a second empty 
>>> line before the "class" statement (that's the style that we use in 
>>> the other tests, too).
>>>
>>> Anyway:
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> Ping (not for 10.0)
> 
> Peter, should this go through your arm tree, or shall I pick it up with 
> other functional test patches for my next PR?

My preference would be like with previous Avocado tests: when a
(functional) test concerns mostly a dedicated subsystem, I'd rather see
the dedicated subsystem maintainers to take it, so they get familiar
with the test. Except if the maintainers are busy or unresponsive of
course.


