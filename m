Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4374C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfkTu-0003Rd-R2; Wed, 05 Feb 2025 13:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfkTo-0003Qr-CI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:50:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfkTl-0004tF-KV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:50:31 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f08b44937so2300095ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738781427; x=1739386227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0twG+DzsW8xJ19dp/PRAPsRXZWZfMQqnllEje8OX288=;
 b=gD4732kkZVmtfj3yjlg6OqON13JWYiAJ3ambWoglrCMVanfqcH202cverFxEYfnhY1
 942IVinqihuFKAs2NODbnFJG26KwmFSfSgXTC/l6guwsDMdgn5aADHPLPf3SAkw6Buld
 rkcYRlzi7SNiBqZFXCAfTC4JR3BcrjA0PrO4lQY0Zw6MQvvLd51bqQNzQXnrHMZl5XG4
 8sVCJRVgugVHq+5bxPXgWVODD9ARMXJmRCQNZVQIIWwHFZp2PgQH5uaUeqsrZrgHqC0U
 eeH6p+ZvQ6hlbnSZWEggkk26t9BjYZzck8fEOk5Jkf5QUM6fAkoD2zWOqQnq36YVaUNb
 zw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738781427; x=1739386227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0twG+DzsW8xJ19dp/PRAPsRXZWZfMQqnllEje8OX288=;
 b=wL2xCsZsE9qKEMF2psg5uSP2ezz3kduWnJ5II/1pjTceZQHqHH0EvQ8MucUOjr9ex1
 SvWenSOdhKe0qeVxjrpp4u/NuRSjTXMX3p9zm2Cp5vGz0ULmVD0DFDjh7I2hS0Fe0kK3
 CAyuL/uN9Erf8IE5ZNkpV9n1kPE+rdrvBMSDIgM4se0H9MxS7EHY2VRHcw0AGVUbl1t+
 TcvdowN/SWdEfwzBnkoBZUaJBbf22uof5OOjpQPtFUAWpq+iy/j0ECoEMpLVwI0AjQ4N
 O9TISII3+vxb48DPZu2j/ZiNLoqulCgO1XAhdmi6OoNhAEvDm0U4DzXU+L2fwrx1qvzg
 C/HQ==
X-Gm-Message-State: AOJu0YwqPK+9j8lt41GSoUvoNrgkDukhEoKGm2Za7RvMh/V3z1wrW4QW
 VkKde0nMz+8Fg1aF6FGoq0hbOytJZQKSmGO9fsYwvsROmcen+8WjkZyxEmRRH2k=
X-Gm-Gg: ASbGncurgi0V8RPByZV+W9sQrTA/dGjMrp5RT04iyppzOBrYdOpDVRieBjuaJeo84/1
 ckeYFJ4z5ikMCJgmXohGeyi0NWqtmV/4y/RZwctt4G8qCrY0qkz3kLatmXX1a7hPTT1BR3y+oUL
 tygVGdma5ZGhau1r/UDgntg7xAhLV7P2/LPqXSBPhuAJnFnQeyCxDQLmR6wiGU3b3zEzesV6W5L
 IDDdDu0HL1Wm+a7RwoTkXKAzmOGKi74XnFaNqB4QTiGevn+ZRi5K/bFGLUDH/ax22ECbc+paZ6q
 RkcFljLPKao4PkaVm7Fpo0nrskCmLcOCBH8EonNu/6P7jHLMJ0iTBuI=
X-Google-Smtp-Source: AGHT+IEW0U/g9kHoU0eA8y6bPLgquQlnCaCoYLPB/Iaj2Zg2zhO619cBVD5zk6BjxCuf0505Fj1OpA==
X-Received: by 2002:a17:903:174d:b0:212:fa3:f627 with SMTP id
 d9443c01a7336-21f17e4771bmr54214665ad.16.1738781427163; 
 Wed, 05 Feb 2025 10:50:27 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f01d19457sm38677855ad.153.2025.02.05.10.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:50:26 -0800 (PST)
Message-ID: <0c511379-d7d5-43a0-b221-24865a355e2c@linaro.org>
Date: Wed, 5 Feb 2025 10:50:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
 <18acac8d-271a-4641-893e-93096f31a2ac@linaro.org>
 <Z6Ox8dSZjUSg81Dm@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z6Ox8dSZjUSg81Dm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/5/25 10:47, Daniel P. Berrangé wrote:
> On Wed, Feb 05, 2025 at 10:24:08AM -0800, Richard Henderson wrote:
>> On 2/5/25 07:59, Daniel P. Berrangé wrote:
>>> +
>>> +'''
>>> +Decorator to skip execution of a test on 32-bit targets
>>> +Example:
>>> +
>>> +  @skipIf32BitTarget()
>>> +'''
>>> +def skipIf32BitTarget():
>>> +    enoughBits = sys.maxsize > 2**32
>>
>> This will work for true 32-bit hosts, and possibly for containers running
>> emulation, but it won't work for cross-compilation (x86_64 to i686 or
>> aarch64 to arm).
> 
> If we've cross compiled qemu-system-XXXX then we won't be able to
> execute any functional tests for those binaries, so is it actually
> a problem ?

Absolutely we can execute those binaries, for the specific examples above.


r~

