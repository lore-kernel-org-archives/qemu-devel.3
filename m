Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C356C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmFN-0001ci-I4; Thu, 14 Mar 2024 10:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkmFL-0001bk-5c
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:39:51 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkmFJ-0003Xb-Bu
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:39:50 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5139d80f8b6so1326082e87.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710427187; x=1711031987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vxbaZwekquaku/Npv8Z3xYVN46oxQj9yTwQgTQzjTiA=;
 b=RwA2ODj/gX0IzYonzxMAs/3k1ZGQaGXu7ys8KH5SqPlnbwsxFCN22pNweT6OIh03w7
 nXaoZpzkXXgywWhVrigQyThIC9KhwxH8VMLBf4+li/jopnAieQJsIsfq3xwWTBu8mIxc
 C4ivT21RO1R4I8beip8N/AEEtlf8j6bR0ow9ms8SDeu08c0GT2+Wi7YfYTXFefVhZQpC
 oss6Dv8XGyoHK5RufR0Dz8TBBpPbh/3Nuwkks4lvqUPbgKAyYbo8bFCb+QvIfO83K3cR
 VuhnmasxMuptKEyrlfwCK0aMGy/bGk01anuv3UioUDenW1+08r1eLJtAGkvGh/yhe8mK
 p+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710427187; x=1711031987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vxbaZwekquaku/Npv8Z3xYVN46oxQj9yTwQgTQzjTiA=;
 b=ZMl7M15dE0B4xLKL5TIHBvzME0sLGgcu8t57n1B+DmCRjs38bitiaMRSDuad/ctF4K
 CCT4dCf2p5ahIep1+EW5t9kbQZeMnhOhl6f85qu0Nv2TvdWhKG7u6cNclcjt4Vn/nAqB
 YdUqWXohUHiLrHSDeCMJ1vMkCJmuHRXihzS2FE8AxyAtOupmiuzvh5cQoPBGDpIOyhTT
 RF4e/P8KfZWSLe0CSj/jYKihdDkJNVIK1+brG5QuyWksBqy13Mi1fRl2EAypFO4XYYH9
 ZSHL2FJ3wIE9VyJQJsfzUujecPh6qqFgylG43OIZZ1npcbuJbmUHlU3pUyJ1YAXW+3c4
 +tUg==
X-Gm-Message-State: AOJu0Yz8paURWzdaFNWzaj32RUQczjFRr01B7Z3irNObYNlZH7Fl71rw
 3FEg8nG0YPrcQlLJfYuZ5FpdrNJ/PVZT3BbWHT/ecAiwJiI6AFkQoRPR6PFcPcE=
X-Google-Smtp-Source: AGHT+IFZvxJxW8cgPHeNwKAYGFIModlfpPdaIpc+8Azsyrt/9fTFf+s5LRJRKJ5jMQv5WzA4yhvZiw==
X-Received: by 2002:a05:6512:443:b0:513:c9ca:1333 with SMTP id
 y3-20020a056512044300b00513c9ca1333mr196656lfk.22.1710427187340; 
 Thu, 14 Mar 2024 07:39:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.77])
 by smtp.gmail.com with ESMTPSA id
 bh26-20020a05600c3d1a00b00413ee67f741sm3648570wmb.13.2024.03.14.07.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 07:39:46 -0700 (PDT)
Message-ID: <7da62f7f-3e87-470b-b089-1bfe5aa97555@linaro.org>
Date: Thu, 14 Mar 2024 15:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests/avocado: use OpenBSD 7.4 for sbsa-ref
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-3-b557c56559cd@linaro.org>
 <87bk7hggcz.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87bk7hggcz.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 14/3/24 13:14, Alex Bennée wrote:
> Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:
> 
>> 7.4 was released in October 2023, time to update before 7.3 gets dropped.
>>
>> Disabled tests for 'max' cpu as OpenBSD fails there.
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> ---
>>   tests/avocado/machine_aarch64_sbsaref.py | 47 +++++++++++++++++++++++---------
>>   1 file changed, 34 insertions(+), 13 deletions(-)
>>
>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
>> index 259225f15f..0e52dc5854 100644
>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>> +++ b/tests/avocado/machine_aarch64_sbsaref.py
>> @@ -159,14 +159,14 @@ def test_sbsaref_alpine_linux_max(self):
>>       # This tests the whole boot chain from EFI to Userspace
>>       # We only boot a whole OS for the current top level CPU and GIC
>>       # Other test profiles should use more minimal boots
>> -    def boot_openbsd73(self, cpu):
>> +    def boot_openbsd(self, cpu):
>>           self.fetch_firmware()
>>   
>>           img_url = (
>> -            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
>> +            "https://cdn.openbsd.org/pub/OpenBSD/7.4/arm64/miniroot74.img"
>>           )
>>   
>> -        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
>> +        img_hash = "7b08b2ce081cff6408d183f7152ddcfd2779912104866e4fdf6ae2d864b51142"
>>           img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
>>   
>>           self.vm.set_console()
>> @@ -180,23 +180,44 @@ def boot_openbsd73(self, cpu):
>>           self.vm.launch()
>>           wait_for_console_pattern(self,
>>                                    "Welcome to the OpenBSD/arm64"
>> -                                 " 7.3 installation program.")
>> +                                 " 7.4 installation program.")
>>   
>> -    def test_sbsaref_openbsd73_cortex_a57(self):
>> +    def test_sbsaref_openbsd_cortex_a57(self):
>>           """
>>           :avocado: tags=cpu:cortex-a57
>> +        :avocado: tags=os:openbsd
>>           """
>> -        self.boot_openbsd73("cortex-a57")
>> +        self.boot_openbsd("cortex-a57")
>>   
>> -    def test_sbsaref_openbsd73_neoverse_n1(self):
>> +    def test_sbsaref_openbsd_neoverse_n1(self):
>>           """
>>           :avocado: tags=cpu:neoverse-n1
>> +        :avocado: tags=os:openbsd
>>           """
>> -        self.boot_openbsd73("neoverse-n1")
>> +        self.boot_openbsd("neoverse-n1")
>>   
>> -    def test_sbsaref_openbsd73_max(self):
>> -        """
>> -        :avocado: tags=cpu:max
>> -        """
>> -        self.boot_openbsd73("max")
>> +# OpenBSD 7.4 does not boot on current max cpu.
>> +#
>> +#   def test_sbsaref_openbsd_max_pauth_off(self):
>> +#       """
>> +#       :avocado: tags=cpu:max
>> +#       :avocado: tags=os:openbsd
>> +#       """
>> +#       self.boot_openbsd("max,pauth=off")
> 
> If we are not going to delete the entries then at least use a @skip
> instead of commenting. Maybe:
> 
>    @skip("Potential un-diagnosed upstream bug?")

Daniel or Peter suggested to open a GitLab issue and use

     @skip("https://gitlab.com/qemu-project/qemu/-/issues/xyz")

to track progress.

> but it would be nice to figure out exactly where is breaks.


