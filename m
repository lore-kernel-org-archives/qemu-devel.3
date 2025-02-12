Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E89C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBLa-0004jw-LI; Wed, 12 Feb 2025 06:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBLY-0004jN-BX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:56:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBLT-00041d-Al
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:56:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso46044685e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739361356; x=1739966156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RxESNT7HCJ6Of8a1TZuAFzI73cFXynRqLXnqZ+nXQTI=;
 b=p1qsof48TAvTHgqg0jLQlIBqifgCnNks4h8N1afzlfclncAtwrL8rZmCSKz9DDMbHd
 W1KK8bDo7gKQmxFzd9EQ/8Z/GUNb9ktQBXZqOC/HT32eZP1ra0KtEvOWpmepWUH3tVKT
 s1f0jD/ci5FVE2c9cPbBjjFaW+vRaAxUcjC50n6HW/Hz4iOx3yIppH5VtLaV1F1WNRFc
 1Rv0DKwvKTpkU35pSMHqegyy1aWIRHLcL8K1NIJdcd2eyEgg88nkVgZ4GNFf9jKEFUKU
 ToJTK/5IAKoQamjnT4c6OzOQTy8zTY/3DfWZxBNl8Ah9A4ulwEnQ4pjCgbVqgHf4X8nP
 U07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739361356; x=1739966156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxESNT7HCJ6Of8a1TZuAFzI73cFXynRqLXnqZ+nXQTI=;
 b=m2M9yAnoJRue5KxSzDsbYeWvLpID3rZSkbWEg/0XAAAKiNuqTSJeNGlTK9csQeW5ng
 o9Mv94uUii7Rc4H5AiDRGp4SamLsROTV0IZnsRc47L9dk7ptH91Vd7aMcrio5wPKZvYT
 jkB56A+rE+7sm7PXi3DOgdvEEOcQ9XV3lOWO6ucVMc0ZMbopnWXQtEZdNt9hxP2kJEOw
 nSlS9Fw+YFPuHU5Gamcahw2eEEPOaHJ1OCymEDFuJyISprvZSQghrOd1ywUX+ZWnyPyZ
 zcJI2ya7XEsySkfzVeu44SOtvna8TeqeMhFQ9KnCuvm05vpnghHvExCMKRkq8oE61RLb
 qtyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8SSKkhNSnS89DOCLVSptIZE/kFP5SKdQ/dNGGVX/+GGYltg4Z4d39yf634L5sNYIQk2fO6E6BPfZZ@nongnu.org
X-Gm-Message-State: AOJu0YwB3L1FRDv0H8Yu73LxqrNKxZVybKjmQEq9GegMYD/ZLBDk580h
 14xrSxinSzTl+8Bbo2En/hiE63TN++trisKNSLZkLdDDv25OYKrPj/P2r60YFjY=
X-Gm-Gg: ASbGncvKQpJwP5KT7xnDlWa/ImEvK+6dl9yYLGQdnZZS1Uk18GJLAe99nZiSEOjI127
 NCr3JMfD+3bzzs6lLq3YeDwT1b2tphKcKtOATNEtsF4C4h1OUKdKvWXbCHDhzZ87CNHW9oeXwSC
 K4iFxyDLkLCfBWZXpcWXCY5mKzRgFCu04jWQV7p1SZegf7fEWkCuquRIKpVU5q6BLr4HF4SBVVq
 Hz4wWtCzdXyV66mT/JkKrB/7Wp0rP4XVkEfamEun93T1E0hg7yrwB91cXUV0R27f1R5Xd3n3VXK
 Rhe89IiK0zCB5DISbfQdO9bR6oG37RUWyY3ea22i2Eyrm6zcupdy9z2c8dU=
X-Google-Smtp-Source: AGHT+IHxdudSorSPRRDScUpFIyb3AMeyK3B37cnXrlkjMf+xda3NgGokyVodB4eWMiz2M7XX11YX3Q==
X-Received: by 2002:a05:600c:1c97:b0:439:4b8c:1459 with SMTP id
 5b1f17b1804b1-43958165f0cmr29794715e9.4.1739361356244; 
 Wed, 12 Feb 2025 03:55:56 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a076496sm17418505e9.32.2025.02.12.03.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:55:55 -0800 (PST)
Message-ID: <d190b43f-df23-4cc7-bf0a-a9337a4488ca@linaro.org>
Date: Wed, 12 Feb 2025 12:55:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] tests/functional: Have microblaze tests inherit
 common parent class
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-12-philmd@linaro.org>
 <c18f47eb-c308-4dfe-9e2f-5f33bf73010d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c18f47eb-c308-4dfe-9e2f-5f33bf73010d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 12/2/25 12:46, Thomas Huth wrote:
> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>> Have the MicroblazeMachine class being common to both
>> MicroblazeBigEndianMachine and MicroblazeLittleEndianMachine
>> classes. Move the xmaton and ballerina tests to the parent class.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <20250206131052.30207-16-philmd@linaro.org>
>> ---
>>   .../functional/test_microblaze_s3adsp1800.py  | 24 +++++++++++++++
>>   .../test_microblazeel_s3adsp1800.py           | 30 ++-----------------
>>   2 files changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/ 
>> functional/test_microblaze_s3adsp1800.py
>> index c4226f49cf3..650416e0c09 100755
>> --- a/tests/functional/test_microblaze_s3adsp1800.py
>> +++ b/tests/functional/test_microblaze_s3adsp1800.py
>> @@ -7,6 +7,7 @@
>>   # This work is licensed under the terms of the GNU GPL, version 2 or
>>   # later. See the COPYING file in the top-level directory.
>> +from qemu_test import exec_command_and_wait_for_pattern
>>   from qemu_test import QemuSystemTest, Asset
>>   from qemu_test import wait_for_console_pattern
>> @@ -20,6 +21,11 @@ class MicroblazeMachine(QemuSystemTest):
>>            'day17.tar.xz'),
>>           
>> '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
>> +    ASSET_IMAGE_LE = Asset(
>> +        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
>> +         'day05.tar.xz'),
>> +        
>> 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
>> +
>>       def do_ballerina_be_test(self, machine):
>>           self.set_machine(machine)
>>           self.archive_extract(self.ASSET_IMAGE_BE)
>> @@ -34,6 +40,24 @@ def do_ballerina_be_test(self, machine):
>>           # message, that's why we don't test for a later string here. 
>> This
>>           # needs some investigation by a microblaze wizard one day...
>> +    def do_xmaton_le_test(self, machine):
>> +        self.require_netdev('user')
>> +        self.set_machine(machine)
>> +        self.archive_extract(self.ASSET_IMAGE_LE)
>> +        self.vm.set_console()
>> +        self.vm.add_args('-kernel', self.scratch_file('day13', 
>> 'xmaton.bin'))
>> +        tftproot = self.scratch_file('day13')
>> +        self.vm.add_args('-nic', f'user,tftp={tftproot}')
>> +        self.vm.launch()
>> +        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
>> +        wait_for_console_pattern(self, 'buildroot login:')
>> +        exec_command_and_wait_for_pattern(self, 'root', '#')
>> +        exec_command_and_wait_for_pattern(self,
>> +                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
>> +                '821cd3cab8efd16ad6ee5acc3642a8ea')
>> +
>> +class MicroblazeBigEndianMachine(MicroblazeMachine):
> 
> Add this here 'til the problem with the precaching is fixed:
> 
>      ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE
> 
> ?

Actually the cache works, I mis-interpreted the network issue.

I'll update Daniel on the other thread.

