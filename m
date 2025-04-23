Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2855DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 19:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7fqu-0002jw-JG; Wed, 23 Apr 2025 15:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7fqq-0002jC-IL
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:33:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7fqo-0007nB-S2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:33:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2255003f4c6so2669865ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745436821; x=1746041621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RSlMGzGf5vQp7otOFOXifnH7VCc6/loIDHgwRerBfio=;
 b=WW3KZoey0UX9RzFcsE1wl9TiW5jMbrYzlYmwur2wk/yW3WjesS/BT0fjl3IaO5gKbV
 7guz0KFe6EQPFxq6icYVENix1MgUqGMf8NqjYq7ypP/4Ytk0UhzVwUmjJc1P1QqSgHPs
 zuGi63mXDZyQWaOyWLQcUpeMm40b+i5rC9qOmyZoGuwVHJHPqON7H2LRWdz/oBu8bxV5
 48g4I2iP5b3H3UtIV4X7O/V4R4R1SnMJvQDWxvhg3MB3dTOLwbuMjKaXoBRnr7Z8D+mD
 DvWvM9BOc21ek9kBtIjgQcV3VsDYayO1ky1X60jx3WxbF6YfsOjSdk7rd9dSjYAynkVO
 6fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745436821; x=1746041621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RSlMGzGf5vQp7otOFOXifnH7VCc6/loIDHgwRerBfio=;
 b=tX/J2/0K7JLYYifm68PBqmKgseVSFSB+RCcHfZmzOXsKUbilsJErqG2rYl1O3KuN1m
 mM39Mxq2DHX7B5/GLyi61Elple1YSNC1AiQ/D2G6G3cR+5ZP2781F9kVk5Z0Gy09OxJM
 Z9sO5R/sYSWlUjqxyhM0k9La216wSprjP1ze+JKP//Y3rn2rjc0kLEWfLECh7HiodeS8
 Q5sNCkR1Yd7c6jtjOqZuQNZv0+Xjo3nsLyc1X4/JZfnZAK1dHByKeNhbqeRuuFnQpKZa
 uZYfDOjY1yhgxcHpjxUppBQiVnxErDxZaV1w+66N+gshXxjwehJ+Ry2hxQ2g5dOFsiQ3
 BOcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbJiJYp6bzsJBN71wplK5hJbuuBn9Z9uO6GfoaylaC0YofNdD5caGyjoTMs0Cn9k4m9uF5uJehxxaF@nongnu.org
X-Gm-Message-State: AOJu0Ywft/jh2BRgP5sFXCRzoUJxGjQgAPRamEVf0jz+3Q5GMQGom8wz
 NtvTibpDyfiBiZMFNDayOvc0ghv/5rZjVHAwcFKeQOEnsvKv4TkTV6feAKDFHfxV/UtCFLzvpvL
 7
X-Gm-Gg: ASbGncvAK5vjh0I6eEziNv5Cv8ham/FZt6SD5cYY3I2XW0SXaDFweA7SK8S2XaG+IH7
 VxGpnJFh0onmm0gWFHJ5o8XyWZl3HTX+tulmtGQ+NDrBjTpba2VbHTK4P01g18WBvyipy9IHeRG
 w6uvBWV0/5Yah/RYpqV3AEzLZpgufexZkq0BOrgI8tS1TpKBqeFK9S97iPbg+dMkb78iyAgCZ28
 KElGD0d6Ft9GYj8mYotEbe7kUtCMj7zfqcgzho+ClXs8kHoTjRbRnfTeMPuY3Km22ysyMqPMpCE
 2S0cKT2RdZ3FTE2Ho4arAZkjIvdIJ8uOa7b8ObQ/y+2LfgDTQiZciQ==
X-Google-Smtp-Source: AGHT+IFAw5hnncdtrKp8j81+AzenyXknUxz7hW4136XFjjH4KkoM8/O6x+asTTVZ8F25zS8L+lH3bw==
X-Received: by 2002:a17:902:e748:b0:224:255b:c934 with SMTP id
 d9443c01a7336-22db1b40236mr7359505ad.51.1745436820734; 
 Wed, 23 Apr 2025 12:33:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb490esm108339915ad.114.2025.04.23.12.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 12:33:40 -0700 (PDT)
Message-ID: <213ba7a9-6c86-48cd-b595-38954d938665@linaro.org>
Date: Wed, 23 Apr 2025 12:33:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
 <0d3d3209-4513-4366-a105-6b71aa9caa88@linaro.org>
 <1937ddb0-a87d-4a87-ac73-3be72ded0c55@linaro.org>
 <6f2805ef-2fcd-4525-a7fd-cad59c64f38c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6f2805ef-2fcd-4525-a7fd-cad59c64f38c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/23/25 12:12, Richard Henderson wrote:
>> @Richard:
>> Is it a concern regarding code maintenance, or potential impact on .data?
> 
> I was thinking of impact on .data, especially with so many.
> 

du qemu-system-aarch64 optimized and stripped (in kB):
31880	upstream
31896	upstream + this series

So we have +16kB which is a size increase of +0.0005%.
Even if we project something similar on other architectures (let's say 
x10), the final impact on binary size should be < 0.005%.

Maybe it's a reasonable impact considering the trade off on coherency 
and readability through the codebase?
Else, in case we make this array const, can we expect the linker to 
deduplicate it? I'm not familiar with how final .data section is assembled.

