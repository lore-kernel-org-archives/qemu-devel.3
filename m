Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78153D0EE20
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 19:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szKs7-00071q-Js; Fri, 11 Oct 2024 15:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szKrz-00071F-WB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 15:00:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szKry-0000Ad-BJ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 15:00:11 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20caccadbeeso8054755ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728673208; x=1729278008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YBamzvrkO2AVdUFg/eWNF/7TlRFyTmsrUURSSA6u0kg=;
 b=LQIYfrnlfdb5Msc4+OZkZ7Jkg4b+Ns3EeC7k26pEeY7nSBqkfCo8k1U1s/gAfCNlaz
 O9jZ99SRon7yW3TJNCkS3yT6yTDiVIvKxTXFi8FqYQP1Aa1Ssi7y1P3mi7aFERmjWDWE
 GiMtT5/evqvAfk7M/5giKPJY96kpikCetjJCfiZptZ7+ePoyR0cPJhCiBU4dkIx9wI9e
 gA8UJP8Kn336vwofKzWEdUWGzJ/9TnRlrBaGetzRoEkGxuQ8Nl8OtD8EMYyaqSUWU1XY
 XWveLcE5KHuach9oJzlGvZ4A7G+5t48or4H7kUuMRB447FcWw2UrhvRP9kV8b2QNczcs
 /5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728673208; x=1729278008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YBamzvrkO2AVdUFg/eWNF/7TlRFyTmsrUURSSA6u0kg=;
 b=C3jVxsF0lp/IQDT/zsbN0F/lHEWewugmebOMHL+wy+0KqAbtPQzaoScQBV8yjZtusD
 5EW+/pAZcdoOAy7cUZV5roURrlho17hqAWLsYmaUOoIxgQxgUg8y0rBYedN1Z3Fp8GTW
 te5HVi/gYiNr6w17IOZYbY8q4dkXzHXTDwS7zMG24Xicv8rZd3w7UCG6qHZtFXk5EZPS
 ZNrLQKSEfKBOiO3ErTOCDMfQUhwcplBQNpSWrLjr1aXwv0YOOZq1ycipwhAO0kkIg9JD
 b77IRznNq04owZqGw4tJRkRN+ywM6gBHbWWxrJCNxszo59ZSV3g4VwK+9HrfXh3TgZNf
 0xfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO2iJv2OVWxyJ8UOuo7RDjLK+306qIKdiIwlp3Ft45R2XwADrJVhqSJrw3OBpGTNfIwbbi7iLQikY1@nongnu.org
X-Gm-Message-State: AOJu0YzDCBY2PIoIsWU25qE4vPIg6rQIZGcAF3aEundno6PE3agADp+9
 ZfJC/Zwz3nd86oLa3vcuZxQf/TEeLWTrsIjxAyqOBzSBzeEWuSPGmNZvIdWuUDE=
X-Google-Smtp-Source: AGHT+IGdslKGFF/deWnUtDFCxtZcsvvZPaGdEkF1GvxxQzFuBfgLIByeZ3D8Ya9VsBqPwwBCP0OlqA==
X-Received: by 2002:a17:902:cec3:b0:20b:5be:a403 with SMTP id
 d9443c01a7336-20ca1429594mr42032475ad.11.1728673208450; 
 Fri, 11 Oct 2024 12:00:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c215edfsm26373955ad.210.2024.10.11.12.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 12:00:08 -0700 (PDT)
Message-ID: <2f5ed4cb-2a60-4078-86e0-ade89420f39d@linaro.org>
Date: Fri, 11 Oct 2024 12:00:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Use probe_access_full_mmu in ptw_translate
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20241009002029.317490-1-richard.henderson@linaro.org>
 <6bb33897-348e-4a0d-9027-2c86bef2ce3a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6bb33897-348e-4a0d-9027-2c86bef2ce3a@linaro.org>
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

On 10/8/24 20:48, Philippe Mathieu-Daudé wrote:
> On 8/10/24 21:20, Richard Henderson wrote:
>> The probe_access_full_mmu function was designed for this purpose,
>> and does not report the memory operation event to plugins.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/i386/tcg/sysemu/excp_helper.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
>> index 8fb05b1f53..8f4dc08535 100644
>> --- a/target/i386/tcg/sysemu/excp_helper.c
>> +++ b/target/i386/tcg/sysemu/excp_helper.c
>> @@ -62,12 +62,11 @@ typedef struct PTETranslate {
>>   static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
> 
> We can remove the @ra argument; maybe clearer to do it in a
> separate commit.

Good idea.

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


