Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57ACCE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 08:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smU07-000610-Hx; Fri, 06 Sep 2024 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smU03-0005ka-Kk
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:07:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smU01-0003c2-VD
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:07:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-374c1963cb6so950952f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725610040; x=1726214840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U2wVYjS7ZmFCucWKH2cbBK1L4EEhniDtrrrNI3gUKCM=;
 b=kx7M/T6XllLpqpvmcijUCn29p+e8B1TGqLr5/Fs20ZHLgUViDEnwvPWLCD9tmIAMRG
 o2b7s35dZElJWvgJ8iUj8zpHPHnh4QGDvUHpRXg4JccNv8XiIDcGVI2JNbIvq1LGu174
 kdE9fl0qg9yHgInztXe4zXT6vG2eZrD6optLe6Vp25cYUpyzGjXHt1wdmlr3DvsZUsHN
 CFGEqh/Uj30TuReiGTjCtEV1EQhDkzbx4V04/lW0dFqEkbkOnu5ykrMr2LljbvmdgXRq
 afPUn94StiNg7Ld/zNYyyDaWOIHPckkQYMksXynuF8GHFfvk+/ERkDb//l7vHk2EsDB2
 Nfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725610040; x=1726214840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2wVYjS7ZmFCucWKH2cbBK1L4EEhniDtrrrNI3gUKCM=;
 b=GwK4j9uteGqDmAy41cxQt9KVV9SJoz+yX/kNwoXW/cPW3A6POwb4OleC1FsXuiI+vK
 Cl1iUL1/xVlKOYz1u6k0opT+qiS7Hn164RIlMKb8y7BdqfxVD7JZyS4WGgdGhe+QnRgk
 In6MVNFR+fVM/Dit6Xqu+omB91S7elD8nJypwqCuEAK7NnKwirvJaxcN5Il1/UDu6+QA
 mmft4zO95X1y1zWnE75fPQ5za18rInItOK1yzEZfJJ2A3U+FKPf3Ckgr/MdtataWqz3A
 iL/62jOTGi+WSusVD0mkEeErEu8ZovZaahOzdxRt64GW3wWRFU3WGru+33KPrfrJ1Q4A
 rYlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/5sRbgfG31n0qFFlk4unG/xxrN9I4Ai3kcEdDpyztI4vLZk01pmyBUG2SCNVZ4NjvMiC1YKEP6iws@nongnu.org
X-Gm-Message-State: AOJu0Yy/EbPk7J2R3ukn74h3VoXjPWJaYHq+tb0ULAQb2FsBEAub7YP2
 4fRVsAAw0sCdIinSsuct2orfA6bH/U0gZ2WLwRFQSNh7eFjBAHxhdgwCY4MNPBw=
X-Google-Smtp-Source: AGHT+IFG79A7lTa3NcAr9MqobgUsVzJJRoe1RYWvuybLGv88O7NoXAwM4ydS9VAbatyav127T5ZWWw==
X-Received: by 2002:a5d:46ca:0:b0:377:9867:9028 with SMTP id
 ffacd0b85a97d-3788967aaffmr954106f8f.44.1725610039730; 
 Fri, 06 Sep 2024 01:07:19 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c9bb7a46csm43493215e9.1.2024.09.06.01.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 01:07:19 -0700 (PDT)
Message-ID: <0ae3ccda-0147-4f6a-8042-956a693ad740@linaro.org>
Date: Fri, 6 Sep 2024 10:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tests/qtest/boot-order-test: Make the machine name
 mandatory in this test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org
References: <20240905191434.694440-1-thuth@redhat.com>
 <20240905191434.694440-4-thuth@redhat.com>
 <639f1017-4e74-4fdc-89a6-6aeca6c0737c@linaro.org>
 <d4e13631-e468-4bd1-81e7-bb3bf8e2d495@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d4e13631-e468-4bd1-81e7-bb3bf8e2d495@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 6/9/24 10:04, Thomas Huth wrote:
> On 06/09/2024 09.59, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 5/9/24 21:14, Thomas Huth wrote:
>>> Let's make sure that we always pass a machine name to the 
>>> test_boot_orders()
>>> function, so we can check whether the machine is available in the binary
>>> and skip the test in case it is not included in the build.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/qtest/boot-order-test.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qtest/boot-order-test.c 
>>> b/tests/qtest/boot-order-test.c
>>> index 8f2b6ef05a..c67b8cfe16 100644
>>> --- a/tests/qtest/boot-order-test.c
>>> +++ b/tests/qtest/boot-order-test.c
>>> @@ -31,7 +31,7 @@ static void test_a_boot_order(const char *machine,
>>>       uint64_t actual;
>>>       QTestState *qts;
>>> -    if (machine && !qtest_has_machine(machine)) {
>>> +    if (!qtest_has_machine(machine)) {
>>
>> Should we defer the NULL check to qtest_has_machine_with_env()?
>> It uses g_str_equal() which is described as:
>>
>>    Note that this function is primarily meant as a hash table
>>    comparison function. For a general-purpose, NULL-safe string
>>    comparison function, see g_strcmp0().
>>
>> Better switch to g_strcmp0() in qtest_has_machine_with_env()?
> 
> What would be the intended meaning of the function when it is called 
> with "NULL" ? Use the default machine? Skip the test? ... I think it is 
> rather an error to call it with NULL, so it's OK if the test crashes 
> here since it should never happen?

Right.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



