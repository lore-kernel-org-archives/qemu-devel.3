Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9853E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBU4-0001xZ-H5; Tue, 07 Jan 2025 10:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVBU3-0001xF-Ln
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:27:07 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVBU1-00047p-W8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:27:07 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so23348631a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 07:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736263624; x=1736868424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xnhe/f46nqxtalb7KGtFTeaX7QlcvPzDfu3D/eQVlsY=;
 b=NLIQmHXge127CVvXXfp+vNEuCrRpu1XHagwTXMgNSgnCBJzTl5o2SG/oCnb26TMaov
 nqz6v/Re7avDXZ+sNarI0x/u4f6zDBuqcgfM6zTayI5u4cimrWW7Yiw3Hz/uj2IzyFId
 fg/Y7OwiWkKzAMuh7liropfZ4IDPaED45p75pIUjq9/cmg/Kd2zrxLAzc329ROp60N7A
 LCazvSIvY4gDv6jBfqTNAMRvBJmPfgMLxZGuFJBxXje48wLpfhd9jxqskdWhfjhqYD0W
 5dnLNRd4rBfDpebwc5KNoLsAkFfgvI3c9/0OvyD1279ItIFXIx+m8tFeI4Eagibi89KC
 pRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263624; x=1736868424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xnhe/f46nqxtalb7KGtFTeaX7QlcvPzDfu3D/eQVlsY=;
 b=VE3QxPSN6nuafepAGCk9LDJWBNKA1ewVUq+cZSrIdwZh0Q67b89H2VkjuiELY2uHFo
 y4bAWvs/afdDhFchaNkVtQ52czj/5HcYVZEDbg4mbgBgz91iV3XYBxb1qpX1XSBji6L+
 Jz1oLFcDOrfF3jDM74K2zXhSvuJBJuu7yrFoNUuLeOoEk61dhpE1GsCRaY1GJTl4m9pp
 e8nN+ZGTSsrc+vhPUZM2E1TVMgg0OPQRhS8IztTeljr2AH0ay4MQMujl7zkFxVyHDzZh
 j4G/G0Ik+HE/93t6UiJD+uv4QIhzpQB1S7VLwgG4cagsX3t9fndkkal6YIzbWYcMMxoq
 CNnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyo22ijKztxhJamyiXV+n8pKSNd5Bzm0wGTEPwwFUpLoeMhSu2VFlvVUBpupoPJ4R3XNestV64RftV@nongnu.org
X-Gm-Message-State: AOJu0YyiCbW4ZuiHC8/DGDh8JdeCwum4hB9o/tU472mNd/opOAZYArxm
 z9glDH2S0RN8DugPxrTLAMPeY9hN1A/ksOThNkgqsfZc5sGGbmjkFVMPMbH1XgceTG03Usubofa
 s
X-Gm-Gg: ASbGncuqoJvLyyDzvypjDLS0abWenuU4Jdu5IRYgybwnvLwQr4ouFNTFGbImQ7SVvn0
 sJ3xpcqj9IMUlFYCPYi5vMO4w07Rhw4WFk9ksH/tQ9okoLY2aTWimcaweuI7gVCzQhi4zyQ9Efe
 UDrZZ2zsj4N4FOgPFt57cvIEKc8txFyuQTibru0yxbRf0joNA298B6xKgWLc9gkukjWvwIhrkmM
 ILMiwdlSGw2a2Im+n0noz1sMB2rleNbLwKCZfCY7BTPKo9yQGFuGZj61fMmmkHDWx5FX2RANl2q
 cu6UsUjUjHgdqapiw2UvhxC0q5A5Apw=
X-Google-Smtp-Source: AGHT+IH71vueA1E7eI8vMK9Vr28aT1Vn9Mvlzd76I4gNft2jGcvSZchMluQnK9wkIsL2EhkEFxMbSw==
X-Received: by 2002:a17:90a:e18b:b0:2ee:fdf3:390d with SMTP id
 98e67ed59e1d1-2f452edc2cfmr77205326a91.31.1736263624354; 
 Tue, 07 Jan 2025 07:27:04 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f7307sm309935065ad.195.2025.01.07.07.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 07:27:04 -0800 (PST)
Message-ID: <4f5fb5fe-2f12-4fdf-9fab-600742b72a99@linaro.org>
Date: Tue, 7 Jan 2025 07:27:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg/riscv: Use BEXTI for single-bit extractions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com
References: <20250102181601.1421059-1-richard.henderson@linaro.org>
 <20250102181601.1421059-3-richard.henderson@linaro.org>
 <05497e58-43ad-41de-b868-223aafa6ed3e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <05497e58-43ad-41de-b868-223aafa6ed3e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 1/7/25 02:29, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 2/1/25 19:16, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/riscv/tcg-target-has.h |  8 +++++++-
>>   tcg/riscv/tcg-target.c.inc | 13 +++++++++++--
>>   2 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
>> index 10e61edc45..ea38ee5cbb 100644
>> --- a/tcg/riscv/tcg-target-has.h
>> +++ b/tcg/riscv/tcg-target-has.h
>> @@ -64,7 +64,13 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
>>           /* ofs > 0 uses SRLIW; ofs == 0 uses add.uw. */
>>           return ofs || (cpuinfo & CPUINFO_ZBA);
>>       }
>> -    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && len == 16;
>> +    switch (len) {
>> +    case 1:
>> +        return (cpuinfo & CPUINFO_ZBS) && ofs != 0;
> 
> Why can't we have ofs=0?

To prefer ANDI.


r~

