Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BBBC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0KS-0000Hf-Gz; Wed, 02 Jul 2025 12:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX0KO-0000H8-PE
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:28:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX0KJ-0005Ux-Rw
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:28:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso3889754f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751473725; x=1752078525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bP8ud+i1jqcrTj4HjnlAu3Yq0+7svexrq5/VWLYbZyM=;
 b=v8uWl07PmXEM+v0y+Bt+xCuwWj/EhO49mDi7uS+GH4OYnavIRHv2Gu62NH5Yxqj+a+
 ywbh1+GCtZC7H7zX3BdAlTBEJQIBN2A3Md1GiI8zpVGDouh3CVM0EQFvgWg7OnCWZ2Q6
 swC0XbH6FlZ6xbp6ZldnliA9hjb5KUsUMnyGPB+XHp0DtmIQWDPfsxl6N3dbcNsqQu3R
 rkXwUdBRH1mqA39eyK23ieS3ZyiT72jvbxXz8gtUewontyTadWDVXFi781Oa+dIuvX3d
 gZqZfpGK51BNKaGb2yBcuSb7QPRRVQ2uFdQrihzUeaDgJYm4tT/tFA3CbmhVIiurQtfX
 99dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751473725; x=1752078525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bP8ud+i1jqcrTj4HjnlAu3Yq0+7svexrq5/VWLYbZyM=;
 b=LDvQAF8qvjWNdRO9wzxeitxhoTJTVLtFP53e7i9XhbSYaSHJe3T1EwW7vw0LZT2Zh6
 VMt3Unzw4oGSHDWKjbOPoVibUpqRdQjzftZtKtRqTa8wYopcz7CVxLkJ4DUApAGs7p3U
 alzwI36CaGfg4ilwvJ83WXJYQ8xIKOus6wnlPaMqd4SRQi8CIxxYdT7jFotRhayXJAL1
 uOUhoG0cm4+FyBoNjJlF6Cp8wty/mXNvCPjWqX94jVd3rf9wrGQHiqy9Q6gXee6DHuG/
 JUTwea0UPyrJXjw65gtRskmWO+TgPSC3DagdPgU89rrDkSORQnZr7LJhP+cLmeiQidCr
 Hejw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrWbajENJwKKLx+WGGuyZ6YYDCtQ9qq14CjxXo846uuFl7G28MAH6cQYL6ZtdzVsn3gerXUsg00ECj@nongnu.org
X-Gm-Message-State: AOJu0Yzixq8ACYSC3PzJB2i2Av3OZNEEh0h4CBS9bsLMEZVvd/e7aj1A
 C2w5Ex2YiCy7A181LEyb6e5XR4Fe5/5Hj297T49wMQxYf5D2G154I2Eb53dOKsrpaoU=
X-Gm-Gg: ASbGncsTi9Lu+xwvsF8HSPvydqAHsb19p7cw17Dfg6swdedOeodlWguu+dDixJ8cHsY
 C8riznShlmJQgj9D8evnV3Q9SW7J8RKnJw4eBuF4ehT2qAOzEAH9bmKjjxn3GOGb3PL9P6RIlfM
 npNkoXdXgEeUUPpaRMOItit3ykibu1NH9xVptsE4uzn7TxfcqqIcmQSkR6gxKCBu1diBbSRkbVF
 Z94VS+T//Sx8/YhXshCbnXEiS5kZBLhpSv13jopAJcbvSq38ozRxsK9RuT7aV4EKv35lLEFPSPA
 ZZvIC2v+a8RTvzRIYKicR8Vcv0YBc8BQevQr6IPANKp3SXErQq5Lb8jqhvY+8Bxi87CtMmI1Hq5
 D1zITDJ4Cwm5PDawyCkmAKJdwUSLEvm4iyoasU7yRu9o=
X-Google-Smtp-Source: AGHT+IFqI3RRBeARiOZROO+c5nr7GXhaJri1iWvinGZAhi1IU7Q1mqvtwo8v1gsXBC2Zq4E7LAF3jQ==
X-Received: by 2002:a05:6000:2284:b0:3a5:5270:a52c with SMTP id
 ffacd0b85a97d-3b1faa90a2dmr2600837f8f.0.1751473725118; 
 Wed, 02 Jul 2025 09:28:45 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c8013fesm16668990f8f.38.2025.07.02.09.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 09:28:44 -0700 (PDT)
Message-ID: <d4667f1c-836b-49a3-87c0-a2d72a0078d0@linaro.org>
Date: Wed, 2 Jul 2025 18:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 62/68] accel/tcg: Add rr_vcpu_destroy() stub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-63-philmd@linaro.org>
 <a856e1ba-4382-41e8-80cf-b626cc388f7c@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a856e1ba-4382-41e8-80cf-b626cc388f7c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 2/7/25 17:34, Richard Henderson wrote:
> On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/tcg-accel-ops-rr.h | 2 ++
>>   accel/tcg/tcg-accel-ops-rr.c | 5 +++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/tcg-accel-ops-rr.h
>> index a73fe5b94a6..4234ef2f706 100644
>> --- a/accel/tcg/tcg-accel-ops-rr.h
>> +++ b/accel/tcg/tcg-accel-ops-rr.h
>> @@ -20,4 +20,6 @@ void rr_start_vcpu_thread(CPUState *cpu);
>>   int rr_cpu_exec(CPUState *cpu);
>> +void rr_vcpu_destroy(CPUState *cpu);
>> +
>>   #endif /* TCG_ACCEL_OPS_RR_H */
>> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
>> index a9150802369..95c7d3a3172 100644
>> --- a/accel/tcg/tcg-accel-ops-rr.c
>> +++ b/accel/tcg/tcg-accel-ops-rr.c
>> @@ -137,6 +137,11 @@ static void rr_deal_with_unplugged_cpus(void)
>>       }
>>   }
>> +void rr_vcpu_destroy(CPUState *cpu)
>> +{
>> +    /* Already dealt with in rr_deal_with_unplugged_cpus() */
>> +}
>> +
>>   static void rr_force_rcu(Notifier *notify, void *data)
>>   {
>>       rr_kick_next_cpu();
> 
> Why?  Is this hook mandatory?

No, I'll drop.

