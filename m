Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4EFC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lHP-0000aq-FE; Fri, 04 Apr 2025 13:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lHF-0000Zc-I1
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:56:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lH9-0004bZ-Om
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:56:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso1450734f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743789375; x=1744394175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePAU+7UKq0j2v6w8pgTjrvdgqWO4eySAa1JlaTYqfzQ=;
 b=EQytejUTOsNG+7aTRG0Q9OkJnVtb3EXUSi0Z50VD60SwjlQ1pJbMcHeWqzs6LGfJoA
 ILA8bLgZ3u1pKkEkIwTPLmxK5w6SWJ4m93eMUHVVNG39sSZQ7pXdnPIVam7ygLsPDSVV
 9KXiFTsOedL18+SNhOmCDzYQ8izQP9foR6HN5/ySXZHrrGiKad7qXzVbpaTgprEgd7Un
 h6T2+BLkMOoD0I6GOEvEEM+OMCQ+J7Ho1p801HKVhWgLpGt7xM4mlRfRvkkDU9GyzpbI
 HtiHPZ5cbKrWuCYZNt+G+WqWbvD5xRwbfhQqKrTL9qS9D+0p7rq60xBSZSYtqf/j1MNL
 EUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789375; x=1744394175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePAU+7UKq0j2v6w8pgTjrvdgqWO4eySAa1JlaTYqfzQ=;
 b=VKsOndmRtXv61/V6HUUZ0slvFoXNcD9a247AophtxIFKtmoPA/FvqdLUWtyvuJh0gK
 oZ0yjatzCI3u1A7x9oKHMfQVoHX2FymgxKuDuD8HXcZIsTQIuoxZrPOpfZxYObao4wnZ
 CM7rVxwUORihhzPzPYc0g8l8arZE6XdGy0UsBkqz19H3o/ogaRce5vKKps1hmZkHHbhS
 h3X/PiSXMv1vpYVlLsGFEj2bo7e6cI6/onlZp0LPup5Pd84pTVCzrXE/KUS5hnM+Pw9f
 cccP0d475npK9m+3yoR9n4R5L5TLTBdz4hJwgQ/hWcJ46VlbZxJ5U2ytReByabARqjSC
 hjyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwYPn0vWxTriilp8KyMV/P4P9dcyAF1a1PoVeaXHrIthWpin6N9jEQYofXFlj2hXF6IsBc0UGrQ89G@nongnu.org
X-Gm-Message-State: AOJu0YyTkLMNWC8DUVgunCKUiEUA2gdZwpIrefJFFKgUk9EMRXc6qjhm
 vLUrvn1sj9xfp0GFZa511tFdk03+bDi2La/IMccXrlLI9v38+TU8ZVDS+xdvc60=
X-Gm-Gg: ASbGncvMJKIbwuvVNx9hXlxbozKX7O2z+9U0e6UbxXDY7QsKUGBBLdNQAC17IMJAJW+
 /Bu7bw7LokZGSZ6TBGN5eCJY89qfZpglgshntd7kDFLcHUq8fLqRWZpyGv9VGt8VAP17aAw59IX
 ggY05+xUlWN1Vz+GvA1Ys61LdN9Gk2fg2DkM6MR5rQ7iNHSFuWz9ATxILXqaltSspDvYXOf6zqJ
 NPOSa/2KItAg7o0SFWfS3V0OFGnlb/UiX9UB9T2PYlbG9puhJHVDaDjoouWBt05E1ni0AlyOu+2
 McZ/O860LEOb2OmJrWD/iEeJDAjsM4igvHjRXasc1PZA84SG5ZmbY/Dr1nv8WAWuqGjHe5tx55r
 ot83Zc6eYH+isAEtukA==
X-Google-Smtp-Source: AGHT+IHnCf70n8DXOkisww+YjVfSlMSCn4aEFN/SqvnhutdFLS0K7sqQusWefh9yiYuJhMbWBRqjtw==
X-Received: by 2002:a5d:5f48:0:b0:39c:2678:302b with SMTP id
 ffacd0b85a97d-39cba933313mr4034822f8f.45.1743789374998; 
 Fri, 04 Apr 2025 10:56:14 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bf258sm51516195e9.23.2025.04.04.10.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:56:14 -0700 (PDT)
Message-ID: <45de7f1f-c8d0-44e0-8247-6a928860614e@linaro.org>
Date: Fri, 4 Apr 2025 19:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 11/19] accel/tcg: Replace CPU_RESOLVING_TYPE
 -> target_cpu_type()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-12-philmd@linaro.org>
 <86fe4d7f-f0cd-42b9-99f0-b802337657b2@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <86fe4d7f-f0cd-42b9-99f0-b802337657b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 4/4/25 18:51, Pierrick Bouvier wrote:
> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/tcg-all.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>> index bf27c5c0fb3..a13cb39644f 100644
>> --- a/accel/tcg/tcg-all.c
>> +++ b/accel/tcg/tcg-all.c
>> @@ -35,6 +35,7 @@
>>   #include "qapi/qapi-types-common.h"
>>   #include "qapi/qapi-builtin-visit.h"
>>   #include "qemu/units.h"
>> +#include "qemu/target_info.h"
>>   #if defined(CONFIG_USER_ONLY)
>>   #include "hw/qdev-core.h"
>>   #else
>> @@ -44,7 +45,6 @@
>>   #include "accel/tcg/cpu-ops.h"
>>   #include "internal-common.h"
>>   #include "cpu-param.h"
>> -#include "cpu.h"
>>   struct TCGState {
>> @@ -73,7 +73,7 @@ bool qemu_tcg_mttcg_enabled(void)
>>   static void mttcg_init(TCGState *s)
>>   {
>> -    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
>> +    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
>>       bool mttcg_supported = cc->tcg_ops->mttcg_supported;
>>       if (s->mttcg_enabled == ON_OFF_AUTO_AUTO) {
> 
> It can be squashed with previous commit.

Not exactly the same set of maintainers, but can do.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!

