Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D51C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezY4-0007XG-TR; Mon, 03 Feb 2025 11:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezY2-0007X1-UT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:43:46 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezY1-0007sN-7X
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:43:46 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216281bc30fso13056255ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738601023; x=1739205823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k2lK/In7iyMrH3mAB9QIf907KTpXr/dTaOTl61QLKMc=;
 b=etGbUuPlNzSpfgAJPYdt6pQyszlUq20vEttVvWT6xnwfd6ui48t6zBJBa+Z3u8/vuJ
 2C3uvM4xMk8v+KaZe0fV/jGY9mh2BgUtXIV7ml6MkDPpVLSjvLg4I+LjhTBnPO4KegNt
 3gaMmFQeqBPHUrCwSUDOmoafiuMZQ+ba10OSuCbNWG6fI/GDYNP3nflm5//5JUHqAVd8
 4odvnYHJ6v9dk7uXsAx4giAMpR66uICI+DHrZzwMRj5d9mZfQOnarHuzWS4TAR/JTfLV
 TD+UIbwGFSJbNerjRqz4IlgYftAlUwgrDH8InSEHWeMHJkVIGNFde0iTLetVv7ZzeAiT
 dNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601023; x=1739205823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k2lK/In7iyMrH3mAB9QIf907KTpXr/dTaOTl61QLKMc=;
 b=S31C8adrXXKZPHnD82PERzmyVxmbAAzHpOoXZEVO3r/YOcoRBcBb0UzR/rpOkE6cVi
 vTs4lTf6tbEssI3cwQmmrguNB6EBKlV3GqosDxp7orUYYw1FdtjVbCDE4nChNaDpZ3z8
 IHI0lHUqAWeoWCaTYfvVa8Th1cs4i8CkqLneCx/7MxXxcrPqkeAficSj+V0+/mA2aHhT
 NpK2APzSy6VnvNOCOEYBwXj4+oyPjBfNtoSUGAL+9T7TWwHIKXVnPcWdJZEAWibnYgAK
 0076nWNoMdEfL6jWc95ZDQbUflK2N3gBq7B6i56dv/X9E/deKEzaC6i1jy8IwSDITtaE
 oTKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeLEfJZMBVJrGLYOzTIBYQo+hGxbza96MZQmf+oF0aWofJxNq9G5tfEcOVfo7bq0XS9lzGttI5fug8@nongnu.org
X-Gm-Message-State: AOJu0YxWlUelA6OOP67JySW2jOMe5FfGpi3NCmF8xsIHv6SVSQUd1U17
 csXbsdKQZsVb6r95pe0queUUwfI9So4y+HaumyD3VZxraMJ3fRlF5qLULdIXCOs=
X-Gm-Gg: ASbGncvwPmxC6L1RHg7cm34hkU+AkY3DA9ZczYeRdBKlDakBJe13EY9/Iy86JD1fwuh
 HHD8t3SXAST+xnDhvARqSeiaJNED/Sn3U+a/eMWOM/vXD2VW/TbfFrfp8BDL8SOQniKILcoy3Hq
 i2dq6oMBkJqf0dwfkzgCAxokvwj4GDzSwfnsqjxWmWK4o53uLtHVid1AF5aa882D4uOzwAKVlCi
 uXCIegoxhy/HqfZdvegB5ts9TOirmNYxsD9U9WrvMdFdgr6TbRkVmF8rlb6yTW21WDXtnV7LP9s
 i7uMQfOe3Z2cDELwWJLvV36KxmCLqe0W4RZGJAWMEWXUxxOdK9QTJiY=
X-Google-Smtp-Source: AGHT+IGHo3AcwUUtTt1EFVqj+iBS1LUEbV+MG7k5D2zrQAHzCl//V/tfFIWbXfrCR6q8PGU9GUwTtg==
X-Received: by 2002:a05:6a00:44c4:b0:72a:8bb6:2963 with SMTP id
 d2e1a72fcca58-72fd0c20951mr33597755b3a.13.1738601023080; 
 Mon, 03 Feb 2025 08:43:43 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ffde3d977sm5713206b3a.177.2025.02.03.08.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:43:42 -0800 (PST)
Message-ID: <cfed8291-a3eb-464a-94a6-4d962c46d17a@linaro.org>
Date: Mon, 3 Feb 2025 08:43:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] accel/stubs: Expand stubs for TCG
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-8-richard.henderson@linaro.org>
 <cb6859a5-f4fc-4f7a-8e32-5aa2be3ee7be@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cb6859a5-f4fc-4f7a-8e32-5aa2be3ee7be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/3/25 02:22, Thomas Huth wrote:
> On 03/02/2025 04.18, Richard Henderson wrote:
>> Add tcg_allowed, qmp_x_query_jit, qmp_x_query_opcount.
>> These are referenced when CONFIG_TCG is enabled globally,
>> but not for a specific target.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/stubs/tcg-stub.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
>> index 7f4208fddf..9c2e2dc6e1 100644
>> --- a/accel/stubs/tcg-stub.c
>> +++ b/accel/stubs/tcg-stub.c
>> @@ -13,6 +13,18 @@
>>   #include "qemu/osdep.h"
>>   #include "exec/tb-flush.h"
>>   #include "exec/exec-all.h"
>> +#include "qapi/error.h"
>> +
>> +/*
>> + * This file *ought* to be built once and linked only when required.
>> + * However, it is built per-target, which means qemu/osdep.h has already
>> + * undef'ed CONFIG_TCG, which hides the auto-generated declaration.
> 
> So why don't we only build this file once?

I think we'd have to create a static library for it.
It didn't seem worth the effort at the time.
I can re-investigate if you like.


r~

