Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007B6C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjwa-0002iY-MD; Mon, 23 Jun 2025 12:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjwX-0002gR-FM
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:22:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjwV-00048u-RC
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:22:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso2291281b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750695766; x=1751300566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nuuRzpg3CvEoh/9sFHUW5U4XIUcatWG8jYPtClYSAmM=;
 b=ZTsIUuMzEvqvrxPRH98xLPVHcwN4fxyDCrOaltc/rGaUNT2M3GUD6cIhVFIlqNUgG2
 BuqyV9BXe8qPP8NqmaTDrGsxtF9vvcEjOmrssfZyxJyap18J7F39lalsBujThFEC2xbB
 mrKS7pHmGUKWNUXgX+OH6fqBOVqWEr7dGe9ppkJLq6GzdTY5Ktn/q3anoo2jhNwXxykw
 h+imD4TNueR6ZacvziOCIFEKw/V8D1Y/K4lS0nLWlWxndgQp/eQmEEP59WyeUpVI4aIh
 N8YhUrgto8b2St+UvL8Dv+jqpVIi09QgO1lOWp8ktfRjjI+h6Ko9i4dNmVzCefOVarb5
 NfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750695766; x=1751300566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nuuRzpg3CvEoh/9sFHUW5U4XIUcatWG8jYPtClYSAmM=;
 b=qoGOU1MuhlCyAXeLjBo4xIfxkqW/MLDeYs0I48Vlr6dFwky216kiyvrDkD0HrX1Lsb
 tNqIT6bh+5+lStu0VNWV3gc1I/RzPIz4y3U5VXoSO8FpFxCa76Xw5ObCOinrFt5HT3bU
 JBXiGwGxp/5a2zPvgQ0W0/jQWYLtlEtdImhbT3YsFO6kxRsSH6/c0ZoIiB1qRvGD92t8
 zImjzmK3FCi4kgd8Hm3iQQ1nGJiIW2itpLW/ck27R08klD2ZLApFG8egr72jkUnb0enI
 Wwg0sGpYb9W5ifX9GFM9EEKOEmwlYT6ZkcjRVv4iBS0yp8Fh4uO7g1AvowiSSV3+wWC7
 Rvtw==
X-Gm-Message-State: AOJu0YxcJuibs2QLU/xkXSrfJ99C9FADV9LSJ8Z7K6JwgT04IkQjLBzL
 UyZWsZc/mipKVvrBWu/+UGFIOaQg01G3qSEKQs+K052QKngf1UhambVtQrz16CaY3co=
X-Gm-Gg: ASbGnctbUrmCX9Da6F1vFb6IEUoTqUJ+IVCzeC+2L2PEXAq9zbXYX5omTfbCY3RFIYo
 htlVKzwazyAimmKWL2qnQf7YZdO0Vwo6A6rq2/dwCJLJc0PvBlGqynQnFLoskKMW+JNUrfAUXSB
 FzcbcGw3X0JoKBBAXN/IMwqluFt7nUhuGeg7fxYnnHAf6lPq6rhyP+0O7E+JOZstWKprGUtXtXk
 P0z897TtuNh4jMAGc9J96CSmn4dV+rR0kD4ZyKmDcpC8ftPoNVYCgmDAb10u9cvjIthniRn9Omu
 H76Y5OCn10od6KZsbuyzvSG6R/4W6rHaLRe/C2uppPLdfE6V/V7SLJFcCtRVGzOpZxggpmAqMWM
 rnPi4wYjyoSfAUqDWK/JwIFSKyoAN
X-Google-Smtp-Source: AGHT+IG88iRjE51iYlr1I5ayFl5RDN/EdXgSzy9IKr912kTVfXi0QHmIiE2iba7xG2Yjpx9ktEedbg==
X-Received: by 2002:a05:6a00:3cd4:b0:748:e38d:fecc with SMTP id
 d2e1a72fcca58-7490d71c76amr15436617b3a.22.1750695766302; 
 Mon, 23 Jun 2025 09:22:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a62874csm9042199b3a.94.2025.06.23.09.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 09:22:46 -0700 (PDT)
Message-ID: <b71a2e42-489a-499d-b6b0-afde744a5ada@linaro.org>
Date: Mon, 23 Jun 2025 09:22:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 004/101] tcg: Add base arguments to check_overlap_[234]
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-5-richard.henderson@linaro.org>
 <CAFEAcA-Zu8O6gGKdSUg57Sw0Q3VtfnQ5RnQWw0WDCKp3mietbA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-Zu8O6gGKdSUg57Sw0Q3VtfnQ5RnQWw0WDCKp3mietbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/23/25 03:06, Peter Maydell wrote:
> On Sun, 22 Jun 2025 at 00:58, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tcg-op-gvec.c | 55 ++++++++++++++++++++++++++---------------------
>>   1 file changed, 31 insertions(+), 24 deletions(-)
>>
>> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
>> index c26cfb24cc..54304d08cc 100644
>> --- a/tcg/tcg-op-gvec.c
>> +++ b/tcg/tcg-op-gvec.c
>> @@ -58,29 +58,34 @@ static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
>>   }
>>
>>   /* Verify vector overlap rules for two operands.  */
>> -static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)
>> +static void check_overlap_2(TCGv_ptr dbase, uint32_t d,
>> +                            TCGv_ptr abase, uint32_t a, uint32_t s)
>>   {
>> -    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
>> +    tcg_debug_assert(dbase != abase || d == a || d + s <= a || a + s <= d);
>>   }
> 
> This is now a looser check than the actual requirements, right?

Correct.  If dbase and abase are different pointers, and their runtime values incorrectly 
overlap, we can't detect that at compile-time.

> (in that it's possible but wrong to specify overlapping
> vectors via getting dbase and abase wrong). Might be worth
> noting that in the comment.

Done.

r~

