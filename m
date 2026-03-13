Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F62F107BCCD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15YI-0003RR-1Q; Fri, 13 Mar 2026 12:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YF-00037j-Q8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15YE-0002BG-Ah
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:39:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so17974615ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419989; x=1774024789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K+8nHS04iLV1s8972ppfvVMqz10n2O2mU0lL13+rHtM=;
 b=NF9WjxkxrZKCxuVKB77GHMEyJlQlJ2R7fUcNkExOojLeZ+04CEgiJx0CTPPQIOkRFG
 MloOZYv1GEjMW9PxIoS/tc/d1wTTgvSdH3bHFPADQNAD1JuCaDwpAuPxiRjdkdpLfrtb
 Ne03GXgG8ZLrlmeWAqC0ZYGCMObfRhwmx2GvtIG4pazwZoc6X9bZs9MlwgDbmd79Fy3D
 ajqYu7CN98oI/goo3W22eMEp2DeCX1uOAlxGzN1AkM4PJbNzMhNV6XpB/qVXNfhG7ICr
 wqg7rj35CM6uHIVmVk/ptY/eVtEPWLcLD5aRau6Gw+CZ2UbGOLNXliC+jcTo6YSFAVRb
 zA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419989; x=1774024789;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K+8nHS04iLV1s8972ppfvVMqz10n2O2mU0lL13+rHtM=;
 b=HLsTdB1pwpVwXXCDIkpElklxb6+dXpA1nia8etqdmhnYTEd9EGKg/qXdA3+4cR2CKF
 XdldYoq5NdaDYlBk+Y3vkHeJ0bOXOCvl+x6aUVY5NR/cYTXxTzNkNK2sSCLyu3NE4WYR
 sMc0G0wbyIJL08ZdRHBJsp2cLzx9JO0rHEzaJMfzFcMCsvvhqfP/tUc8honi1JuaYOnP
 723YQ0cXMyuRA9icWlEZHItZTPmNz2TSwsG8/GKsnpN9Tgn/Tv71S+N4ff8NDJIq9xaS
 Yk3+KaS5/JreLTQoaPhkayaR6IKt2B0isMfCdZ9oJYQ/xXr6pWLvAmk4tEJK0w2JdyA5
 voBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVnBpa193a4FHf+wo8pKEQejDT7E/cxCO+5Wu8ML0Q3AB4+6zy40bAwbZvKaP47my88esashjBOnqa@nongnu.org
X-Gm-Message-State: AOJu0YwJjnjzkn1/ejqjWc0fPofitfbksj6ORxoJ35ba7FxAODz//YJ3
 sU1mBOjf/K0K6fXO5jg3cLy9tRA8scYMNwGjP8NKgdfKTO1SHByYV8j2b+evgUom9Bg=
X-Gm-Gg: ATEYQzz8tDMDT+t4UYc77mRjAq+QFr93WqvknGmlHK0KhstqXUlc2U2836sUYvu+H2K
 yzPqjy1mtE0l6nrEvevGcIdaoM/XJxUgC7RfK2mkRSiEQixFQfCmwaxS1E5r/rtoi4eWR7GIgv1
 0zm9kmW7vuLmbK8gd9d866tFK0gIpaT3f+hySLU+pq5mhoknaGvt6OJNSrgGzgvNyFF3G6uHYmb
 XhoIWqEpfb9TupmsGcgO8Rry5O/p9KH5QUuXDX7x6fkznVmQ7BBnknOoN1se/kfJmpwNMqRKZq2
 dF715copiNy8k/arRNSycn64ltnOr5in9EDngkxvQ7RG2PUQqhdOjW/QFA5rN1RQHtmjzlUWUMR
 F2bPsrzxrA9BU66ATC/jJZCYKJmjwPvYmetIw9UizicH7U+3NGpwZuT1R3UbOgZwN+8M8hyL4hh
 BoyS3RVxfDJf08BiUInhJHE1J+A341GotZjPwjMnCNShk620n+J4+ONdR8YqITbzKlcQP6fkvuz
 NOMvZI=
X-Received: by 2002:a17:902:e543:b0:2ae:606b:bd98 with SMTP id
 d9443c01a7336-2aecaad0c39mr39987255ad.26.1773419988724; 
 Fri, 13 Mar 2026 09:39:48 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece627683sm25163655ad.32.2026.03.13.09.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:39:48 -0700 (PDT)
Message-ID: <f42d32f1-6053-490c-a810-4c588c0d32b4@linaro.org>
Date: Fri, 13 Mar 2026 09:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/38] hw/mips: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-28-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/intc/mips_gic.h | 2 +-
>   hw/mips/bootloader.c       | 2 +-
>   hw/mips/fuloong2e.c        | 2 +-
>   hw/mips/jazz.c             | 2 +-
>   hw/mips/malta.c            | 2 +-
>   hw/misc/mips_cpc.c         | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

