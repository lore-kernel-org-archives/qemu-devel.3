Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC4AC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0R9i-0002j1-J3; Thu, 03 Apr 2025 16:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0R9e-0002i7-Hx
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:27:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0R9c-0003Qj-26
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:27:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso9310115e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712030; x=1744316830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMdxd7fjIjihh9SvmEj50b94nf5OcoxMUT8JuDjtX0w=;
 b=uplcUUgy63iZ2XFm44l3f/CvxTsHifU/NroszozUPy+T2xbXx4hNedFKM2fo114m8o
 3CkOMkg/iOBTBvCoNerwHLFeoCVYyKN1MTpudCQmMHISmEBgNmqEfTFc/gsz3nGnFi+2
 LjeBS94D5VVC4cUkBDTuCHcCtQN69XYzkXwJMByeZKYKQ/D4MOgKxl7x1TG6zDqZEbew
 wpjz97RCSbmR8wk1yaWszdFFXZCfSFxuuim+glrZ50Q6mp+Ymk42PG+DDV6DUdiJRcjO
 uPjfTr8IJK0jitgNtzupqCfIbelT/7/7EP9AfXKoez8HkTxTq9YCmQbCMgEklDVxwA/J
 cpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712030; x=1744316830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMdxd7fjIjihh9SvmEj50b94nf5OcoxMUT8JuDjtX0w=;
 b=cxAToA2SsurQe7REpPFmMTDX1xDYrmqnBmQyxFPriOv9aymNGSi3B4XqPUg/izZAwd
 3fjLPdFCzvmgwzkn4AsWPGFtCJCoJ7DDsMS0PZGMyiKN8G0oQFfVQb+DvnZFXplrVSvk
 wZvNT/P99eNHsXPOi3tuc9ZUo2NhK+e4TxQJmGpWUCsWojjG/I7/DILVLRPba8IlJ8yV
 u6bbipajcRtWSWZ59DpKtpfb39pXA9fATQt2Sr0F6MnTsTT2dlCXwnjbOJ36olmwWvT+
 b8XrbI7h32z7kpjEVfDOpJ3I2jUttxIz8SeXLBrsGqimVS0TIcf/eZfiOZU11126LxXh
 45Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuaMQav3CxZCYKU9gmBnASjGP28Ia7cV1Ps6OiUx+4EhFsdm6ZiZAlodPNdNNlRlBidKSzbqdm6/W5@nongnu.org
X-Gm-Message-State: AOJu0YyvNZyP49Nbhlffk7UMdXtOdL6XAdLoX+8n+wdENmwW9w5306If
 6XB/F5BtYU1LP/HghjtV/zYGo8GwlohHKkebuxXQ9MYBfETYilrItOq011v6kb0=
X-Gm-Gg: ASbGncuFZ2jQ8ckyVzoKmPGuGnw/8bKBJ/PtnvQsRE7Dtc4iRibUAf/ehd7qdotWn4/
 ku2mu857Ov9UhfQzdDegR3VOj+fG/V2ZW9a/Gc48/TVSpVkkuJRiSLPCyX7qV7/3B0KUJDEhjvW
 jIu5qEJfdArvhLBtK/1rV0hSO5jFfea65+VYkxk4jAYnRcdAxw9NxT7m7cvZw42aZPw5iJ0Zo4R
 50QN3/2iMXOPZGdJLN3ANvwCt1gxUqBnrSbIeRbrpgpQaH17KbDsn1/VoXzx/YIJweoS3dNQzT8
 ouiX/I4Q7taiLInUaPV+Fa3fSog1kBOhhWVixXxmpB/yTFHmLFsuD4zEmGTc/qiwkeJo5UHe56z
 4+5msNJEMf1c9T6HQ0JMPgIITslcD
X-Google-Smtp-Source: AGHT+IG6q2NbvrftZycWiIt3unU0xEkB4OU/iwKufzZaVzSyKXino8Oy1aPrQLr9ZbGdUbfk6udRYg==
X-Received: by 2002:a05:600c:3ecb:b0:43d:7588:66a5 with SMTP id
 5b1f17b1804b1-43ecfa06563mr4594095e9.31.1743712030167; 
 Thu, 03 Apr 2025 13:27:10 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a1fesm27825145e9.3.2025.04.03.13.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 13:27:09 -0700 (PDT)
Message-ID: <ba70bea2-46b7-4abc-b1cf-dbfe68d56143@linaro.org>
Date: Thu, 3 Apr 2025 22:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 02/14] tests/functional: Add a decorator for
 skipping tests on particular OS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-3-philmd@linaro.org>
 <7c417483-7d5d-456f-8187-56b5264f539e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7c417483-7d5d-456f-8187-56b5264f539e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 3/4/25 20:04, Thomas Huth wrote:
> On 03/04/2025 17.18, Philippe Mathieu-Daudé wrote:
>> Since tests might be failing on some operating systems,
>> introduce the skipIfOperatingSystem() decorator.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/qemu_test/__init__.py   |  2 +-
>>   tests/functional/qemu_test/decorators.py | 15 ++++++++++++++-
>>   2 files changed, 15 insertions(+), 2 deletions(-)


>> diff --git a/tests/functional/qemu_test/decorators.py b/tests/ 
>> functional/qemu_test/decorators.py
>> index 1651eb739a7..b6a1d41c55c 100644
>> --- a/tests/functional/qemu_test/decorators.py
>> +++ b/tests/functional/qemu_test/decorators.py
>> @@ -5,7 +5,7 @@
>>   import importlib
>>   import os
>>   import platform
>> -from unittest import skipUnless
>> +from unittest import skipIf, skipUnless
>>   from .cmd import which
>> @@ -26,6 +26,19 @@ def skipIfMissingCommands(*args):
>>       return skipUnless(has_cmds, 'required command(s) "%s" not 
>> installed' %
>>                                   ", ".join(args))
>> +'''
>> +Decorator to skip execution of a test if the current
>> +host operating system does not match one of the permitted
>> +ones.
> 
> "permitted ones" sounds like you'd need to specify the ones that are 
> allowed to run the test, but it's rather the other way round, you have 
> to specify the ones that are not able to run the test. I'd suggest to 
> rewrite the comment accordingly.
> 
>> +Example
>> +
>> +  @skipIfOperatingSystem("Linux", "Darwin")
>> +'''
>> +def skipIfOperatingSystem(*args):
>> +    return skipIf(platform.system() in args,
>> +                  'not running on one of the required OS(s) "%s"' %
> 
> Same here, maybe rather: "running on an OS (%s) that is not able to run 
> this test" ?

Yes indeed, thanks!


