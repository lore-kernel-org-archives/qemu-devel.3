Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98FCCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrNm-0006ua-Kp; Mon, 03 Nov 2025 05:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrNl-0006sn-GS
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:01:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrNh-0000Lr-QA
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:01:48 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so2724502f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164102; x=1762768902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0kg1/AYV9jqvDNp0UcsZv457kUsXIFzZ5jwURtrm/g=;
 b=LkoLolJ5vmPTiOAW9BpKAArQL/DKCbdV+TRFKPaQXY4pYWyJV9Yy9g3i69tlmAG9wz
 R7x6qCZrohd1fAgScURmO13i4r2L8gd+DVTPhPAPsaFLtqlse2XlgGVuyADUtoB8jcHE
 1GgDVxR9DXIfDATiZWscpYG2wvZlW12PuXHx78uX9nR1wXBUNKhIC6PtUst7oevWjZYb
 Gw4tRRH4rRtZ9AtjwQOFgwG7M5Jixu+4wYQxtxyNl+yfscsf8UcsHp+DgaDh33s85NWL
 fQQENpYlFH8FAAzUNLeSdzS2V2xbx8p1ZsOSoUbDsZ8D5qSaa06qIZ/l4Xoc5s4gttIR
 DeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164102; x=1762768902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V0kg1/AYV9jqvDNp0UcsZv457kUsXIFzZ5jwURtrm/g=;
 b=U9giEpiBv32zz9+rz3HAeWQhF5cj+Lyw7nXTUFKOlJ6SRa9mfwoJktB9oKqTTkkR/W
 p1xM6o7VKr7f3JrBxk2gNIeJQ3f+P3U8LQ+qdP0Zsp5YH07AZpgeHH1cfU1fU+F0lgGK
 BikyVEYzoT6K67GlAu3ZKPQ6PTFI+MGzsK4gMr5XjhzowvnvTwozxQC6CDfnAQL0+Cte
 Z/Tskbc9Mlk3+Z/55ldkEi3I4fyTQ/rj6MoPdZqUq4NdzAG2GhHKylrgk4yoNwSfaXzz
 uvItgXVhZH6QWX5Lp+s8nzSuRKhgHdxqD7/G2oKjb/1FCiv9mGi7yZx4G/4yeFSRj7HP
 xuUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI6iee9IQYow2xcK4V97SlPUYnzuznArrYcXHTM6Sq8Py99vRGSV4YFWSVxKJgd4RnRd0WA7Rbetav@nongnu.org
X-Gm-Message-State: AOJu0YzTpAMtwK7TPPInu/dY5YRrNxXu+7LyjN4d7me/qZm+JjiHqcYT
 isQewx5UDxUgvy2nRvfu6HdIo1JYSfcCBqf2cElz2n/ffviDIQnpZ7KYAPZOm0caz38=
X-Gm-Gg: ASbGncuCad74rHE306T2FDLtesmecDjLIjJbwRozGkoQcm1dY1uVwV1LzmCIjyL2Dv3
 tlRkFMNEeGeeho+aqzWHihgh8iXrW6wMkFD3USXuyoEHZUUiaQvh/QMJWZjWefW3eDrduBUxk6R
 6FuvDgsJ9SLLFa9RzA+rDKRmGRhBmuPVb5vp+Lyxp1dGu/9YfkX/nrB7Euu6yWp/t+iXO7HOL8P
 WKmDAwvzygdI0VcoI9QPwmOrFDfqZGUOuz5ZpCqH33fSdPlgSLk7dTYwwbsFRTBuUGH95Dh4hmR
 L4Y2xIYzi2TsHVVZLjzv6wuJ3V7TPwcMkmQeraXTuf2nnh8nQnRfT3oY3A6xoWVKSUbh9G2jAbt
 ng6cEbfGaCdrCKCd8KPbBTYQrnRgx0joHImmFLZoG9Y5htSDtzzCBDKWQNqpPBi9E508J9lsJfz
 jaiOyxs0/BhbYwwMUarpMiHNiuo10+ZB/5P6CU60Ig+kFY24a6zx3IxnpexvsTow==
X-Google-Smtp-Source: AGHT+IF3xXiY9zBjyJZywDN2GeQGBmb0BDj/R9RTXOzz1/hArawD6Ny0G2505AVDJ+LTzU1LSO5ENA==
X-Received: by 2002:a05:6000:491c:b0:429:ca7f:8d73 with SMTP id
 ffacd0b85a97d-429ca7f8f21mr5735028f8f.26.1762164102454; 
 Mon, 03 Nov 2025 02:01:42 -0800 (PST)
Received: from [172.18.178.65] (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429cab8575bsm12120425f8f.31.2025.11.03.02.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 02:01:41 -0800 (PST)
Message-ID: <0f1a0739-69c5-4a4a-b627-17f3a3bb9824@linaro.org>
Date: Mon, 3 Nov 2025 11:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 43/59] accel/hvf: Implement WFI without using pselect()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-44-philmd@linaro.org>
 <12196f65-ad1c-4753-ac15-211567c77297@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <12196f65-ad1c-4753-ac15-211567c77297@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 28/10/25 13:01, Richard Henderson wrote:
> On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
>> --- a/accel/hvf/hvf-accel-ops.c
>> +++ b/accel/hvf/hvf-accel-ops.c
>> @@ -128,14 +128,15 @@ static int hvf_init_vcpu(CPUState *cpu)
>>       cpu->accel = g_new0(AccelCPUState, 1);
>>       /* init cpu signals */
>> +    sigset_t unblock_ipi_mask;
> 
> Why introduce this?  Surely it's unused...
> 
>>       struct sigaction sigact;
>>       memset(&sigact, 0, sizeof(sigact));
>>       sigact.sa_handler = dummy_signal;
>>       sigaction(SIG_IPI, &sigact, NULL);
>> -    pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
>> -    sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
>> +    pthread_sigmask(SIG_BLOCK, NULL, &unblock_ipi_mask);
>> +    sigdelset(&unblock_ipi_mask, SIG_IPI);
> 
> ... apart from mere initialization.

Leftover (now removed).

