Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2DEE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 18:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXNpN-0002y2-G0; Sun, 21 Dec 2025 13:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vXNpH-0002xE-Qn
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 13:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vXNpF-0001z9-O9
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 13:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766340395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ccxl3nO+1AINr1Oym/UazhsSFyxGbfZIORO3WwOLSoU=;
 b=E5iKSyaSWbgoxRmfBn6ugwimrl9XpZRJO+rK4fVRWPxy8ZctRNtGlhnA1TFU5B1m/2eOrW
 8o2NmSiqoJA94R6XPS2tDCP7ZO3aJvtoLULPZCWXB1vGwFx4eSNdVz19BNADf+nMY5BkTT
 uVwwBA1uelHktGDIbR5691ljBWnfACU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-hLXRAvSaN52EOqdGmBj8jw-1; Sun, 21 Dec 2025 13:06:33 -0500
X-MC-Unique: hLXRAvSaN52EOqdGmBj8jw-1
X-Mimecast-MFC-AGG-ID: hLXRAvSaN52EOqdGmBj8jw_1766340392
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477771366cbso21158895e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766340392; x=1766945192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ccxl3nO+1AINr1Oym/UazhsSFyxGbfZIORO3WwOLSoU=;
 b=rUwKpNSMXEeHC5qcZf2Zw6DZZj6G3E2S/uAtbHduZRsqqv1/qe+iM5UDlOJKWACJHh
 ScHO1SU0Rbdf633Dz2SPbCwcT6yA4UFh6wbabbHug98FyzU6lOnO0bzz21kPM7eIL9q3
 rjITIX1JSBrPP4Yatp1T+6L9ocfaoQZpdaW28m6UzNaSXA0HKB6lgNLp/ugc5FXhJ/Sz
 uy+VKN9C3lFbCTcnTb4c1D26jlAjZ/vPhQBEnEFPi4BvNmgz9X9KJ59JFm+4Q2rc2eta
 xx/lXEoydpZR+wa3KftBLCNO93UUwPT6D+oVs4Bl9Kv5br2M/JFIIDRY43Ta650SSR1Q
 t1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766340392; x=1766945192;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccxl3nO+1AINr1Oym/UazhsSFyxGbfZIORO3WwOLSoU=;
 b=r5IPmi2tgYZuKfHFwuWaIhrB3yist4ExipXbKI+4YDDmXIA0tWP24ovRi+9F9T4hZO
 vqIRYabks08eyWjS3y7DdOwKnZethUZZoqufHh4fDm5cXuiYjp3wVqXIYNTsB2H9fkty
 iUjQ8EC4n19jL9wA9cwWJI1gJaKvAKTbQ2tjXf4Hvq8AXSeFU6FKg9dTa1hKL1RcSs+M
 v1+uwF94xkIEUNxVBdkWM34ybc5F/XwCtoyW0jTjkWOoNg4kWU7Y+ElBM/3D9WXuqdUJ
 pDPWUvGZOQhBJCKWjl7b5ag0pB5+nMtJEUmMPHSyl8OR0wRhR7qmSco9jmx27QR+uGBX
 h9Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTE0yCCqX+QQLSPyVwqf7SB0y+POl34pnnpxbsJxxN+K8X+Ou7At5yI8JaGIJJO90u0+7/6j3DrHYM@nongnu.org
X-Gm-Message-State: AOJu0YzPeT1qFJeI7vwycHAJu/zo2zlet6U6cqj79VVM8sRXIevx7zNJ
 DPVoAAL+IOwGhiunMiXCy962ain8D/UC+0AHpEenU09i/3tq6/6WqLnwu5fm8oVAGpfe+qFEt7F
 doItUZ5QUGJ50lkOh30bwTeEeyAhx2ck5kxdjhDrOFB38nmZQ5C/n4W5R
X-Gm-Gg: AY/fxX5P1XxSuxMZx7bQTTSIzrgzG20UztmT0KOZiEOATecZUXiyxVcxDHiJcY9U7kP
 MxLyU5ohX2vK1ReEN1tD5xqQfMCyTSAEP3XmhbwcufGJNv1ox+4Bq95DOtEceTnIbbW1YH4/Hmz
 t7XKHvotZy8PG3NctnfqtSZwSsJ02l2wUYDO4DIZNzkRF6Tnmh09YxMFuYp163XrNURuUWD/pPr
 iDyw7/5jkKQqjQ4v5DYLmccwEfAJxSOiNaiZmAgXTrYfNgHToZ1Lt46RG3GM5z5MYZTn8HTwveV
 th2gsrrFma+e+Lcbt7CJkDDmCsTVZDCFKpFqC4sjCz1noeMJ+TYaCRDY2VnUxGIRrLxeple8IJs
 HUFoO08fBYo171T9MJzWn9cCGA4o25dAlRVM7Jf/pF4CQmw==
X-Received: by 2002:a05:600c:4fc6:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-47d19576cc6mr91231955e9.17.1766340392077; 
 Sun, 21 Dec 2025 10:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3151ZOjBX8r2LOWDg0AcWY4rEcjKVI4JSg6xDDnfR6rxdl34V6MClbFWfxOOPfI7EZ0YkMQ==
X-Received: by 2002:a05:600c:4fc6:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-47d19576cc6mr91231695e9.17.1766340391634; 
 Sun, 21 Dec 2025 10:06:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3ad0c60sm84199135e9.5.2025.12.21.10.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 10:06:30 -0800 (PST)
Message-ID: <51e9eb2a-78d4-4ec4-84a2-aea8c45ab8d4@redhat.com>
Date: Sun, 21 Dec 2025 19:06:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/11] tests/functional: Add gb200 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Patrick Williams <patrick@stwcx.xyz>
Cc: Ed Tanous <etanous@nvidia.com>, Thomas Huth <thuth@redhat.com>
References: <20250704083723.1410455-1-clg@redhat.com>
 <20250704083723.1410455-12-clg@redhat.com>
 <3d97400f-0d42-4f21-b64b-c719443ca3aa@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3d97400f-0d42-4f21-b64b-c719443ca3aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

+ Patrick

On 12/21/25 15:56, Philippe Mathieu-Daudé wrote:
> Hi Ed, Cédric,
> 
> On 4/7/25 10:37, Cédric Le Goater wrote:
>> From: Ed Tanous <etanous@nvidia.com>
>>
>> To support the newly added gb200 machine, add appropriate tests and
>> extend do_test_arm_aspeed_openbmc() to support the hostname of this
>> new system: "gb200nvl-obmc".
>>
>> Signed-off-by: Ed Tanous <etanous@nvidia.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-5-etanous@nvidia.com
>> [ clg: Adjust commit log to document do_test_arm_aspeed_openbmc() change ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/aspeed.py                    |  9 +++++--
>>   tests/functional/meson.build                  |  2 ++
>>   .../test_arm_aspeed_gb200nvl_bmc.py           | 26 +++++++++++++++++++
>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/functional/test_arm_aspeed_gb200nvl_bmc.py
>>
>> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
>> index 7a40d5dda736..b131703c5283 100644
>> --- a/tests/functional/aspeed.py
>> +++ b/tests/functional/aspeed.py
>> @@ -8,8 +8,13 @@
>>   class AspeedTest(LinuxKernelTest):
>>       def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
>> -                                   cpu_id='0x0', soc='AST2500 rev A1'):
>> -        hostname = machine.removesuffix('-bmc')
>> +                                   cpu_id='0x0', soc='AST2500 rev A1',
>> +                                   image_hostname=None):
>> +        # Allow for the image hostname to not end in "-bmc"
>> +        if image_hostname is not None:
>> +            hostname = image_hostname
>> +        else:
>> +            hostname = machine.removesuffix('-bmc')
>>           self.set_machine(machine)
>>           self.vm.set_console()
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index fb87b957aa6c..050c9000b95c 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -33,6 +33,7 @@ test_timeouts = {
>>     'arm_aspeed_ast2600' : 1200,
>>     'arm_aspeed_bletchley' : 480,
>>     'arm_aspeed_catalina' : 480,
>> +  'arm_aspeed_gb200nvl_bmc' : 480,
>>     'arm_aspeed_rainier' : 480,
>>     'arm_bpim2u' : 500,
>>     'arm_collie' : 180,
>> @@ -129,6 +130,7 @@ tests_arm_system_thorough = [
>>     'arm_aspeed_ast2600',
>>     'arm_aspeed_bletchley',
>>     'arm_aspeed_catalina',
>> +  'arm_aspeed_gb200nvl_bmc',
>>     'arm_aspeed_rainier',
>>     'arm_bpim2u',
>>     'arm_canona1100',
>> diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
>> new file mode 100644
>> index 000000000000..8e8e3f05c1b2
>> --- /dev/null
>> +++ b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
>> @@ -0,0 +1,26 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots the ASPEED machines
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import Asset
>> +from aspeed import AspeedTest
>> +
>> +
>> +class GB200Machine(AspeedTest):
>> +
>> +    ASSET_GB200_FLASH = Asset(
>> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
> 
> This test is failing for me:
> 
> 2025-12-21 11:10:40,608 - qemu-test - INFO - Downloading https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz to /builds/philmd/qemu/functional-cache/download/b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc...
> 2025-12-21 11:10:40,798 - qemu-test - ERROR - Unable to download https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz: HTTP error 404
> urllib.error.HTTPError: HTTP Error 404: Not Found
> qemu_test.asset.AssetError: https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz: Unable to download: HTTP error 404
> make: *** [Makefile:170: run-ninja] Error 1
> 

I believe this due to :

   https://github.com/legoater/qemu-aspeed-boot/commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a

To fix, I can 'revert' the change above or we can fix QEMU.

Thanks,

C.


