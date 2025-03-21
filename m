Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039A5C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvddt-0008RJ-VN; Fri, 21 Mar 2025 10:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvddq-0008QS-E3
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:46:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvddo-00050Z-Kt
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:46:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so1294315f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742568389; x=1743173189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjixmlmR73pubIiILUBrdG4AtS8okAzSuUsQBY/dQYM=;
 b=evB7cGXc7FvhknQdQW0Dx/7i88rod62NIzJibLlEehKHaUFr6NQBtnfZwh3IUx7QeU
 Rjppdz5BVIB4mYuG8TX68P9qjKCA6D1oPghBb36Ys0v0D91hwH49j13WyNbu2Q+AHilC
 cyVgXafdzZPKCaYmFHFV6bUmE7kmOTabmuk/YZvmMhOaj6SnwgTXBKFs5OLWPmGCaSVn
 brq2GqRIPFFzPnq7hTG2zkOtO3yLwmQzCHFpy0m55LjPHtq5rzDn+iC4jkW5vdYot41J
 nGt8NkMrTPULbNcCjRcDqUwnMPQONQwHZeENrszieb0gcdgcO8iRgz9phBXnwJrDurJ5
 5hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742568389; x=1743173189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IjixmlmR73pubIiILUBrdG4AtS8okAzSuUsQBY/dQYM=;
 b=HwOMbiIsXyjsd4vn1SVC422FMMQSOQkg+TXuw7VLpo9PN6pLykFd4sGbnvO/qLMyqU
 m17gFWWzpIFB7efV5YulbqhDjyTC1MwqSYKQiU9oRfYzm2CDjsb3J5s7O7PdkgwT2Lyt
 vCxWZZhFjYwHs9JUjLvt+L2KzUdoZWW5K7UngYUfLodcxoSrVlv4Qn8Pi0jV2pgq3fC7
 vyGyXt+U6kf10pAzWKCsujB4mIC+YhqRNkpNOU95rbRaaoUAucfUHxF781liBnybu/0F
 7leMBGy82nc7vIw1iOqGsayhT+MG6WFMsI9OchypdZo+I1/hGbhTnREc/VTKHAOMMW19
 7Dzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/21wXWPO+0ErtvvizeF1CK0dZvXZtJPrt/pZJ3OEJcuvB5JpRvBJQwNDduhln3KZZm/ciXkGnxJtQ@nongnu.org
X-Gm-Message-State: AOJu0YyM8k2WKHURHZDZmIHSdXRVUdkQ9msy8i2BBY/OuJyzSHLmnxtx
 1UIg40WDPltwBkjpO+Rd6RRG2vdqJFg2bUCcOclfMJP+STNE0bN/1RqhQGgU6ZM=
X-Gm-Gg: ASbGnctmAMSoqSafX4MVFz0UHBStEZH8bhhhG2LAac/S6m694ZIayQ6UDl5qthHGdrN
 QElkdHl7s9SLpbYJlZHWrK9tm0/PWUITANCDNcImz1RUO4Yju4KlVs7A8wAytsb2zmnVvJCGjaZ
 x4/hlKdxdhKHhMk5KFN7BqfrlepXMKmgVWFfXIu3BBRwVuJw+vxrs7FkMuNE2XIArSfjWkSYrJ1
 vXNnBOLQ656O/3F3mEjUP+9gLtK357hctEPqU2JF5kwJKrD7TlP88JMOys+ZZIFMLyaiFVBjNeJ
 Ds1YM0ImeFhPnkT+sNt0MiTmREFwjlsCidg+O1DAz1gzunfsOkannpN3cs37gx81aCLYTMRAaRV
 n184wegxP0JRB
X-Google-Smtp-Source: AGHT+IFqfuDhHc1iwTqMGg+GQOTNXAvC2WJFKACEtuC8WmvzhwfiaEfafNMU3n85BBIW90YDqRhYXg==
X-Received: by 2002:a05:6000:1566:b0:391:3291:e416 with SMTP id
 ffacd0b85a97d-3997f903a53mr3859975f8f.19.1742568389570; 
 Fri, 21 Mar 2025 07:46:29 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd2798bsm29644125e9.20.2025.03.21.07.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 07:46:29 -0700 (PDT)
Message-ID: <cb0c2703-cb84-477f-8f3b-3a715f373664@linaro.org>
Date: Fri, 21 Mar 2025 15:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 3/4] tcg: Have tcg_req_mo() use runtime
 TCGContext::guest_mo
To: Anton Johansson <anjo@rev.ng>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-4-philmd@linaro.org>
 <obxwsiulhaid5f5rpjdgaclzzbay4dgs4jko2wxyojk5lwjmm5@7gctc6ef5n7s>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <obxwsiulhaid5f5rpjdgaclzzbay4dgs4jko2wxyojk5lwjmm5@7gctc6ef5n7s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 21/3/25 15:39, Anton Johansson wrote:
> On 21/03/25, Philippe Mathieu-Daudé wrote:
>> In order to use TCG with multiple targets, replace the
>> compile time use of TCG_GUEST_DEFAULT_MO by a runtime
>> access to tcg_ctx->guest_mo.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/internal-target.h | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
>> index 1cb35dba99e..014ee756f9d 100644
>> --- a/accel/tcg/internal-target.h
>> +++ b/accel/tcg/internal-target.h
>> @@ -49,11 +49,9 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
>>    * Filter @type to the barrier that is required for the guest
>>    * memory ordering vs the host memory ordering.  A non-zero
>>    * result indicates that some barrier is required.
>> - *
>> - * This is a macro so that it's constant even without optimization.
>>    */
>>   #define tcg_req_mo(type) \
>> -    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
>> +    ((type) & tcg_ctx->guest_mo & ~TCG_TARGET_DEFAULT_MO)
>>   
>>   /**
>>    * cpu_req_mo:
>> -- 
>> 2.47.1
>>
> 
> I'll parrot some older feedback by Richard
> 
>    https://lore.kernel.org/all/92cc9335-10bf-4a74-9eb4-249de5545dc5@linaro.org/
> 
> but tcg_ctx->guest_mo can be undefined or bogus here. Could we not
> take cpu and access cpu->cc->tcg_ops->guest_default_memory_order
> directly instead?

Yes, cpu_req_mo() has access to @cpu.

