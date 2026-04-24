Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F7FED3C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGzU-0004Cb-7m; Fri, 24 Apr 2026 09:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGGzP-00049p-0s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:54:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGGzM-0002rv-De
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:54:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso65177635e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777038873; x=1777643673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ty9h+ZYk6jAUeMMG5fjohOSnEAHIpxjQWLk+t2TduXA=;
 b=Uu23wpniZUIJe1Siwg8pBCvKg54Uq8/LRn7l3stS8wefwP8cIx6TUkAJkIAnQt4VFm
 C6ro5TVu3y2+kL04I34o3iWj2VxVzvBj4rEul6Yl0Cjh/G13jFqX/ZFoNUw/ODcDS8dl
 6QIgObFJCeRqucnV5ElAPBvCgoF7Y4W/OnXvywIOv2PSizllTesnfV5VT1+ZTyjgR8e/
 5KYU21/QnZTDf2c5nNGTuz+sSLlx/t7sCpj6Ers0JeeeZmaPnC9JzI7KJsBFirgStRLR
 UXp+5qeywfeMQIAfpiZmhhpiKbE5Uc58OfseXtsDWgJUjaboZDLOn05123G1ZK2yZaz3
 kR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777038873; x=1777643673;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ty9h+ZYk6jAUeMMG5fjohOSnEAHIpxjQWLk+t2TduXA=;
 b=P9h87i0CxVBd/TGVxQk8tl7EsvWGRJ/9nzSKK7lIgg3XsL0uIY1iBnZcissMU+4gEK
 AvPYNAGYw1nuKjUdQJEk7+VwT4ecd80s+O+l2ymLZqVc/CXuO9or9r3g6HWWPfgIOO6B
 9qCme3cv0/vUYF8wQEe3Ao5xerw20+ssZAPeNwdJ4SQn7SXDZUBWVQX8fwbwT6rpC0Ds
 r2XEbe2hebuifh7EpLpiX8WOL9owNqH/RASWfWmE+tHNg7y1oGw8W3lLPatIxw3HWZc2
 J1cezKpXqgjwVB7lnk5+QforLQVCVctPVlQRqWL9KGNhqlAGdUDWW6nI36rm7iS6bQ6j
 Ri1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/my0Ajy3Zt19ajzCBgxMH/F2zdJ04E6Uijgi59KsIybwhKV3msJJzP+Xxvbf8cJ75VRCms9kHDnEje@nongnu.org
X-Gm-Message-State: AOJu0YzXjdd/qSJM608k3wXo90Ep1sVhPmMstwvVEWcuvIAsSCp3yn+b
 0M4kVH8NQHNKXuInl6CF8KR3E3HffoDds9RJK7T9HJiKGaSS/9IXfyBYPrCXB1bivGY=
X-Gm-Gg: AeBDieuM0OCISKuqZIzHLTADiVuDy1FbfQSngOYb8cqXHQd+pN+ZTt3Z1paN9tSCnM6
 PYAj0+2Zoqgd4AHnc+V7JktqJrlkwUER1qdDHOXBNMmFXaKikYoS5uT6/zJb9ySgPGncllJ5fWE
 8ygM/ky07x1FQq7RnnZCgmNh7/EWYLDKqhYy041qu0EXtyr8TX6VOXF1CfU8EXab4ihOPlJ4bbL
 wjgH54logJJhNsW272x4MXxCwCN+3Sr2iZKnMA7vjCrmxJukmaBhLThx8jI7Ceje1cLrPOkepYL
 TJMZnfEVbRWffUJXYeYDwMfcDx8Bx+GkcanZL02sogHGmVdym6rqn70umRBWwur/UQv/Kk7skm6
 2E0fP208SJ7pjltOQKk9JohSUR+eOphpSQTOoPwF6CHH9GGoBRKjrHUHdcF3rACj4E1lZLEHxi7
 +3WjjWpGONfXs/4eIS0IjQTVrcdN2rylOY2tCRpN1XCJCo/SKaoxRbHqiooLMQny5ntNWVdqmNx
 Skk
X-Received: by 2002:a05:600c:890b:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-488fb775a35mr336928405e9.19.1777038872614; 
 Fri, 24 Apr 2026 06:54:32 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm719952305e9.4.2026.04.24.06.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 06:54:31 -0700 (PDT)
Message-ID: <2bf9724b-4b29-49b7-ac97-f7130056583f@linaro.org>
Date: Fri, 24 Apr 2026 15:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] tests/functional/test_aarch64_kvm: Stop dumping
 kernel ringbuf
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-5-philmd@linaro.org>
 <4072248e-a815-4868-80bb-a241496ffc78@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <4072248e-a815-4868-80bb-a241496ffc78@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/4/26 09:39, Thomas Huth wrote:
> On 23/04/2026 19.02, Philippe Mathieu-Daudé wrote:
>> Avoid the following kernel message to interfere our stdout parsing:
>>
>>    platform gpio-keys: deferred probe pending: gpio-keys: failed to 
>> get gpio
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/aarch64/test_kvm.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/ 
>> aarch64/test_kvm.py
>> index 7545f5ed554..a03a6134626 100755
>> --- a/tests/functional/aarch64/test_kvm.py
>> +++ b/tests/functional/aarch64/test_kvm.py
>> @@ -48,6 +48,7 @@ def _launch_guest(self, kvm_mode="nvhe"):
>>           self.wait_for_console_pattern('buildroot login:')
>>           ec_and_wait(self, 'root', '#')
>> +        ec_and_wait(self, 'dmesg -n 1', '#')
>>           ec_and_wait(self, f"export PS1='{self.PS1}'", self.OK_CMD)
> 
> In other tests, we are adding "quiet" to the kernel_command_line to 
> avoid this problem - that way the kernel messages also cannot interfere 
> with the login prompt. Could you check whether that works here, too? If 
> so, I think I'd rather prefer that solution instead.

I tried:

-- >8 --
          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
+                               f" quiet console=ttyAMA0 
kvm-arm.mode={kvm_mode}")

---

but it didn't help. Anyway no worries, I'll figure that later. Dropping
this patch for now.

