Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1859D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxLz-0002lD-NU; Thu, 08 Jan 2026 16:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdxLw-0002c5-L9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:15:32 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdxLv-0005Fa-5A
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:15:32 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso2289464b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906930; x=1768511730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6D9ktFgpewzzFF8kStcc51K+CM4aSey9T0GIanftew4=;
 b=XsZr1igtnHtz586pLreuBW29AigLw0RuDxU4q2h0qPKN3fy8ROiDASiOkYPL/Tb91h
 I4bXi27TdVM/W7DXasZRQ9IyT5WBTiJyV5f5nmYibbk/OVl2HZLnlkIRX159L9hg4hz9
 sVeNPQbyiRjpE4IXCsEOC+DG2+S9etN9pSfcWSkleSoCcDMNylz/0lsQgYEg8UDaBwHr
 jT9xsP2VjJxfwYMEXa/CCFNgkzoXd8jGm5VwKVZ4G1s+RhQQu0+NHFctb97cup9sv4CG
 M9NZjzh9Bv6tkXawCktfcl4CM/h9QZfmH9E7UPUcpwnm3pUm6T3Iy9IMbVWxXoh1CG5X
 2+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906930; x=1768511730;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6D9ktFgpewzzFF8kStcc51K+CM4aSey9T0GIanftew4=;
 b=Td/wE74+Mbp1TGCxpJPwBLWV3j06LrDiU0lqQejFZ1Duqc4HT0YbsuY51S8IQKhKjC
 ATozNVIOCaB82HK7Em9tLRL3lMEIZL2HmbOkGOd2Jl0h8vqZY73XnbyzQkJjp4rvU5rg
 z1fIMCzEbKxblFA9I9UTPDBAW7wuNq6nuH3Ze5vN9ZswaBEuC6hAAREgep2ip7Ce+Tq2
 iiE9NgxZugYMf37pdbPYsDpfuFV1GjL3Te350Af1vSnDRoukGbiw17+ghuT5VwwrkaQT
 Gb55J4pzQ2zJSmiTTMirsSTol0aADYZwrwVDtuXh0CrA1DH6VbGJ0tEEwz1hOly8SGN5
 NZaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtomV7t5ZnHOw/QIC7EkWfOEo9BxlmCnb1NBdl+guMLhsDCd3paEFdZrlhmfhYGKbAk3h/om8JbWTx@nongnu.org
X-Gm-Message-State: AOJu0YxIZHun/QM6Np3T/qbaGUG0Le3YM49uZxTjn1TQeGfjOmj2N62H
 MTbn38Icz1Lx6myLn2mHk+VxPUF25MK/uLlXUGPnLZyPRmBLWauZ8azoJzC4+mmKI44=
X-Gm-Gg: AY/fxX4L4grqTxWvvCO4gCfRbeRQltT0a7EPUi+t2aQ71SrS/xioF6sP0H0bd6FEzvp
 LRqqgqmOMWWXqatae/hHiFBweNZGOS1DJDl0AK+KLGN1NLA6oxaDXoMktWZIVTdZUx4z0jXLj+d
 wc3MpJcVd98XhVQ5khmWEZG87b298MjN6QXE0vMGtvj83gS9XU67h8XKI6SwyigktWdOcwMLrwu
 i3h2cJrTlVDeVJkj7RoYrCCdhPAVarqlCJAsY5hJUaPbU3Z2uuVJ03HSbfamG7U6GsvASkzGLQs
 +L0EQIGGr4SPhhpXNXfD+yuxt8OsmL3LVep4Ibe28tbPDvKcyKfFNGargzXVxFSfE7lMXvbagVR
 8T+IfHt8NGLtsj1ESO1n1KFkL9oDlXtyn5HJ1wRSCku/fr9RLC8/HDjHU70WPpjR/l+gcfTQH2E
 FOD8ttJ7kYsXuRUDdsiCNF4UVaPo43aQ==
X-Google-Smtp-Source: AGHT+IHO03aSGNGRwOAnGwyPt8lTIX+R6oxEldGY70S4OgM0tjMyRQk3kBiIEswgbC1h1DX6TTzBhQ==
X-Received: by 2002:a05:6a00:4502:b0:81b:31e7:114e with SMTP id
 d2e1a72fcca58-81b7dd5ed67mr6781305b3a.22.1767906929634; 
 Thu, 08 Jan 2026 13:15:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e042e75b0sm246371b3a.21.2026.01.08.13.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:15:29 -0800 (PST)
Message-ID: <2379c4d9-3401-41cd-8a95-d833f799e10d@linaro.org>
Date: Fri, 9 Jan 2026 08:15:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/50] host/include/x86_64/bufferiszero: Remove no SSE2
 fallback
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-8-richard.henderson@linaro.org>
 <1928a9b9-aa81-49a8-844b-18617cc966ce@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1928a9b9-aa81-49a8-844b-18617cc966ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/9/26 07:09, Pierrick Bouvier wrote:
> On 1/7/26 9:29 PM, Richard Henderson wrote:
>> Since x86_64 always has SSE2, we can remove the fallback
>> that was present for i686.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   host/include/x86_64/host/bufferiszero.c.inc | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/ 
>> bufferiszero.c.inc
>> index 74ae98580f..7e9d896a8d 100644
>> --- a/host/include/x86_64/host/bufferiszero.c.inc
>> +++ b/host/include/x86_64/host/bufferiszero.c.inc
>> @@ -3,7 +3,6 @@
>>    * buffer_is_zero acceleration, x86 version.
>>    */
>> -#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
>>   #include <immintrin.h>
>>   /* Helper for preventing the compiler from reassociating
>> @@ -119,7 +118,3 @@ static unsigned best_accel(void)
>>   #endif
>>       return info & CPUINFO_SSE2 ? 1 : 0;
>>   }
>> -
>> -#else
>> -# include "host/include/generic/host/bufferiszero.c.inc"
>> -#endif
> 
> The only other user for this file is now
> host/include/aarch64/host/bufferiszero.c.inc.
> 
> Code could be directly moved there instead, so host/include/generic/host/ 
> bufferiszero.c.inc can be removed.
> 
> It can be done in another commit though.

No.  Everyone who *doesn't* have such a file uses generic.


r~

