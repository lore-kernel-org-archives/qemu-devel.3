Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882FFC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufFA-0002OF-2C; Tue, 18 Mar 2025 18:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tufEy-0002Iy-OD
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:16:55 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tufEv-0003Ou-FX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:16:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso6284316a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742336206; x=1742941006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rlhpsl5tgVQ8zMRpowh4yQuosLc3O2JMgDZISfiZ5hM=;
 b=hpdgZSYB+G566dFcDUwBIH+pd6p/54PM9I0EzS5WbGkFzT8/piEIQg6y8mKqxwm0bw
 VB5aSt1VIHSfULMIuR2u1BQPyykJwoHhe36M7Twv4NjclQKzuWRw1oO2wlzsFleoi27l
 tyMHy/+aCUWctJZeC/d+b/0DP7cwL0QGPpxtrXkFkQG6HcGHZ0uFwn6SD3owRR4D260S
 UajxBHDa34/bxadcB0vZp3LBEph21eTXU2pPYye4hW6qOs9nmi1qF/RFCWdvqPaPF3tx
 1nbRRilfrzPJ8hIfyHaJavEllox4nFLrmy0ElCj+6QTsgVeMwDVKuwAAycJ2NYv8+FNw
 75sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742336206; x=1742941006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rlhpsl5tgVQ8zMRpowh4yQuosLc3O2JMgDZISfiZ5hM=;
 b=IaGFNho4pKfx9rlUqJB5JkTb/IAiknYGyEEtXe2gpbxArUv9WzttqpFLKWUtN4TyKB
 ENYbxpu0k5NJXJtXRrKrAXsH/F0ygjA1ZbuyMBoAnvMhkggNu4eT3GBY4lGLZt8vLWc/
 L9hzQcZ8TMNWqyI1nzQPEAbSG4zzJh3iG5QjvPkxzHKsXU35aRAESbizkSZ+u8Au0hsB
 K0AvfBeeh8NYp2VBGXtH8C2YnfISfa4D2OjdRzubU1nlYyxqH7AXO13N+Dnsn8lbCE+7
 gD5QewP9yA6V/WCx+aWu155uwwwuyqkIvRj7vPMoRfDdE2pPewxfNku6NcyLYxZLAFud
 cIFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrlQ2Q/9oBPlOTmPk6VMZdJheGmccpnv8qVRy6RlmyjbDAWYcouYNeb8cqORBKOjA8QkaZxRqrUjNp@nongnu.org
X-Gm-Message-State: AOJu0Yw/PfJ9CtVcob2tXKgFUt5HODsxwodg2oRieOeuQqmAa7b5K/wF
 8dNUUPAtNhHs16hgYSUbIa/z+0o59bB6KenK8lvxcmzAzog/8DrlCK3ooF8qJqKeCEZ2JB+M7sL
 m
X-Gm-Gg: ASbGnctdSYgwhPCpMZcd49ZbMOM1OhqEvgA4NW+fzc2wCxaqbdHFIj6S9YL8Jpk4HNs
 kOqKXMcIHYZzkSVEXl16uiEglnTnMBnOEwfX1xvvd0WZNYK5vdxRcvnjaHCMzOVepiDt3HhdIYi
 PB2MEu45YjuBvqqPXVQL4yAAGkPCNvGsXW4hqyKyk4+IpmNEOy88qq6oHGCMqSKq5662U0YSgbK
 JvWCC52AiHQTgJa4z2xDqCkzyEuSIp3usJsARwNI6eaXGwWpXxgNQAUctXNlHOmsV3YlHrc749C
 LwF6jF7jG4NV8DwEAxDUI4bcrBe4Wb/RPRig6VpezM6h/iADOkjK/ZuvHA==
X-Google-Smtp-Source: AGHT+IF0Ndckq3b583mtKOlY3MX+DN60sgn8v5grOSR3pSkEnnl/CZ8U2ZVgWTXR0oI67omvJr7PSg==
X-Received: by 2002:a17:90b:4d05:b0:2ff:5ed8:83d0 with SMTP id
 98e67ed59e1d1-301be08e808mr471081a91.16.1742336205845; 
 Tue, 18 Mar 2025 15:16:45 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf61b34dsm10012a91.30.2025.03.18.15.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:16:45 -0700 (PDT)
Message-ID: <7202c9e9-1002-4cdc-9ce4-64785aac5de4@linaro.org>
Date: Tue, 18 Mar 2025 15:16:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] exec/cpu-all: allow to include specific cpu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-5-pierrick.bouvier@linaro.org>
 <35c90e78-2c2c-4bbb-9996-4031c9eef08a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <35c90e78-2c2c-4bbb-9996-4031c9eef08a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 3/18/25 15:11, Richard Henderson wrote:
> On 3/17/25 21:51, Pierrick Bouvier wrote:
>> Including "cpu.h" from code that is not compiled per target is ambiguous
>> by definition. Thus we introduce a conditional include, to allow every
>> architecture to set this, to point to the correct definition.
>>
>> hw/X or target/X will now include directly "target/X/cpu.h", and
>> "target/X/cpu.h" will define CPU_INCLUDE to itself.
>> We already do this change for arm cpu as part of this commit.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/cpu-all.h | 4 ++++
>>    target/arm/cpu.h       | 2 ++
>>    2 files changed, 6 insertions(+)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index 7c6c47c43ed..1a756c0cfb3 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -46,7 +46,11 @@
>>    
>>    CPUArchState *cpu_copy(CPUArchState *env);
>>    
>> +#ifdef CPU_INCLUDE
>> +#include CPU_INCLUDE
>> +#else
>>    #include "cpu.h"
>> +#endif
>>    
>>    #ifdef CONFIG_USER_ONLY
>>    
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index a8177c6c2e8..7aeb012428c 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -31,6 +31,8 @@
>>    #include "target/arm/multiprocessing.h"
>>    #include "target/arm/gtimer.h"
>>    
>> +#define CPU_INCLUDE "target/arm/cpu.h"
>> +
>>    #ifdef TARGET_AARCH64
>>    #define KVM_HAVE_MCE_INJECTION 1
>>    #endif
> 
> This doesn't make any sense to me.  CPU_INCLUDE is defined within the very file that
> you're trying to include by avoiding "cpu.h".
> 

Every target/X/cpu.h includes cpu-all.h, which includes "cpu.h" itself, 
relying on per target include path set by build system. Now we have 
common code, there is no "per target include path".

The other solutions are:
- build hw common libraries with per target include path, but I thought 
it was a good way to cleanup this, and not rely on this hidden 
dependency on the build system
- remove cpu.h inclusion from cpu-all.h, but it requires more 
modifications in other places.

I'm not sure which is the more desirable, compare to having this weird 
CPU_INCLUDE trick.

> 
> r~


