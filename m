Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0457C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbEh-00067T-Na; Thu, 01 May 2025 17:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbEf-00066m-7B
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:14:25 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbEd-00086g-8h
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:14:24 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2243803b776so24382575ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134061; x=1746738861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjAzNRLbOrsoMtq/EPdzdknnHjpmqyE7LPvsWSwmdj8=;
 b=Zy/7VQjIEzH1X+U+aGj9Bazd4yzMqG3jAVSK2QRWE1qHlIDVTNSxktxmQ0//MfKE3G
 7GX5eVMjt/vkRPC5r3y/c9y+6TqvDUeKe2bmxX4SFftFuBZQAM+64X+USaGkg9fEmKFZ
 PbnWjmiW/iZZm1rNopT/HxgXPnc1326f7lr7IknBW2cAUs4nORXbCXmP+YS03ANx2GyG
 9JsB3sRGIXS8Vp/0xt3ST6LmYaZDRFGelWJEqkuEbOijDK8xAVzk0FCf2oFcgWp3LLEe
 0JaSxGVuxW6+sOJP6xulz1y9Tk8ziS+jKwoPrVeVxOwZlejlglvfqkkHCSCNGKFThasM
 Krrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134061; x=1746738861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IjAzNRLbOrsoMtq/EPdzdknnHjpmqyE7LPvsWSwmdj8=;
 b=nxiOyqet6G/mhlG1b1DC6GK4G575H22Rcl5yWoBzqDgYd7Y0HubkTZu571pLVg4B2Y
 ntQGKv35cTBN2IBEZDiU4his7sHlsMj6jwCSefRIbezRFbH/8MSTFzRsHNYjgEUn7rRI
 NWgS2Y3RY9jwZqbzQjRPgDeIo2uUhGCGl0ZuY+xVAXwGD5KUHGrDgoYv5dBtpqh3ytoB
 /glqF143fggG5wxFCLJTAJ5eh4mNhbIM+Sbt7/NoMWNZ1S748ttD/Jkju6GvSpraRAUa
 l3YpLLJYXkslMzoFrA278O9BrofobHXqX3Ml0B40jcJQxzfJnFzH+4auvOrk8sgjIDF1
 MByA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdaUq/A2/ylp39aIQLhblKwE9mWozP5JdKY91YVv1wgTcI8uwZWYJnsJm8GhbhPoaPvp3Hhxf6Dcc2@nongnu.org
X-Gm-Message-State: AOJu0YxfGIAP17NeBNb58t89emLayQG9jQe9OnOUw7EiE9CAmHEVfYKW
 HCo8mi1aDMR3v98IDhmNmf9iSvQGDA6uhG7QTebwYmQfX8QNJnaEV75x5K9inv4=
X-Gm-Gg: ASbGncvXWPscpIFCXnq6rXYiQGm37mIQx1NpJg78np1ODiTLdwbn796vJVyvTJ6umKL
 zy4XzoeomHDG1yhm1dLjvsYZbdlDWfzARvEr6lPoM1cgUVfHZhkiWwdNUgNqoJImIELFrVvBRG/
 05zDR3SihGeAL+W0BDYvpcZ5YA35j5S6+So29VDU9yxqCyCaWMyah5pG4dZKVjr/WgxWWG3eVFL
 iHQP3TktI7j7xznEzZZhAuHe13LlO+/nLLzDypa2qiLu6EiBNN02PXLoiNOEiESjYAIivbYz5pm
 BcsBykpd3cl8d4JbmJ+8a2LbLp/YX61MwWrjFlpxpHJOC+d8l/WJ9eNFD7mt2uSA71iizaNYL7C
 iLb9Ligg=
X-Google-Smtp-Source: AGHT+IHrnRruNGSrJshHmWNz0Xu2ccGJ1f+1U8k2VE3mc5qFlXIZViS2LGp1pbaM8OTkQ1Dqx2jCgg==
X-Received: by 2002:a17:903:2f91:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-22e10344ebamr9025215ad.22.1746134060854; 
 Thu, 01 May 2025 14:14:20 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1091702asm819235ad.206.2025.05.01.14.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 14:14:20 -0700 (PDT)
Message-ID: <757f10a3-712b-44a0-9914-5b221e185a20@linaro.org>
Date: Thu, 1 May 2025 14:14:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/33] target/arm/ptw: replace target_ulong with
 uint64_t
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-30-pierrick.bouvier@linaro.org>
 <21d32a4f-8954-4a36-ba0d-6cb7a50f242d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <21d32a4f-8954-4a36-ba0d-6cb7a50f242d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/1/25 12:35, Philippe Mathieu-Daudé wrote:
> On 1/5/25 08:23, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/ptw.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index d0a53d0987f..424d1b54275 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>>       uint64_t ttbr;
>>       hwaddr descaddr, indexmask, indexmask_grainsize;
>>       uint32_t tableattrs;
>> -    target_ulong page_size;
>> +    uint64_t page_size;
> 
> Alternatively size_t.

No, this is not related to the size of any host-side object.

Bear in mind this particular page_size is used for the sizes of the intermediate page 
table levels.  So, at the very top level of the page table walk this will be quite large.



r~

