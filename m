Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321EBCCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zoI-0006Bt-Be; Wed, 01 Oct 2025 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zoD-00067o-88
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:36:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zo3-0007IR-9W
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:36:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-78af9ebe337so94155b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759336545; x=1759941345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yj1etB7dz6B2SrykECpHpVFrBoe/dfGwOm0Zu2It1m8=;
 b=GdRMxeF4DirErAoPG0Unu5ycSq9pHlU/sblSB3JYKZdoVmbSCi+4z0rYtALuciMLhB
 R1ZNLljMU+E/lGF8ZPgn5Enk0Ykng446wqP9dZOzha1Ef9JBqwcrDFiCui87qawLrriN
 jgFR1yTcpFngJFiNFX3nchkCd2pvj3/dnhDhhl8cQYDuoTFV6HFNxAK5jb7TtXimskmG
 odhkcf0vUkHVRcfFXfo27dBR/WarykYHz6u/cXcQ2jnx4Jqm9YDTmnwBrO2K1Q1mDjMN
 1hPsjcYVwx8mYrV2fnWj5c7pHw83VdU6AwlH/L84DfFBHQjXI49ynEm399DwH8u9bnRG
 PMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759336545; x=1759941345;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yj1etB7dz6B2SrykECpHpVFrBoe/dfGwOm0Zu2It1m8=;
 b=VhYJ+Y1nI5hqYteEcHgZgjMS0G1+0VQUdY4BpBAN7NIZvZm/L70b82nw7tDQ3OeF4h
 Q0RttlzxYpb6ejroM8ykwoadq5ZfEIfZRTzyaJ4z0MERw8//LABX0A3mMpG37cfLhEDZ
 nP0UxzvLU50p7JnGO9JULRKZ7n2R2/6ZpDXN2TVN3QHWVzOjWgwDFYz0Xc9+BdA9F75m
 GXI5EgMzAYYuZfzO3hnE2AZ7ua5FB5AwRP4OzxiXIkX7bTAaxvNH4h9LdHnxc3VtK74M
 duG85H8QeAHEr4kHy5e8AdeQFdErZiHwnSvr+Kr0oUpjXaSd1u9M+2aKVThhvGP7g0Cq
 ubjA==
X-Gm-Message-State: AOJu0Yy/R80q9fJEAmRj2shdkh5gSgv4sawdzV1H0U/0c2yD6yWopAQW
 ZkNRm5z+Q9pwRjlt4t8Y43I9yvyahnaObSqik4svm8UaftuMBaZKuIdY1kclhOIowYc=
X-Gm-Gg: ASbGncuCix5AsuSa/SbjDlZWpC7JNOWBpG/arc9JPOieuwMofTS26T1coEemSKrXuBK
 YFS7C4VXzmtCZnnqjedzQiml2MtA2yqyxAwztAI0yz9Nv8jyCr0wAi6jQwbCgOV671MPvFOlVFs
 8GVi2g0pcybfQEpgPkIZ9qzUw7uugU8VfMZ1341Ex7FqI+nfkauJ6ZDG13zG9qP5I0a7GE1x/sX
 y/MgUeuWhVPzNSMvWohRrgQixK+SfGF84jlFdFB4NerU2VTol1Was8dYMAIUJPPUiXobMK56yxq
 SFj0ty5Nwz7nNcfMdklR6t/+dCoenDEgO2lAASniyUzSjQlxK6dVlT6FNrp3wJH5DBf2UuuXFIp
 rbV9QRb3ATL7200rBzjJIb5Tju9xhjCBAQO9Z0/mRivXs6G7x8GOx+Qts0JG+qVNr0w6RM9ahGh
 TqG7UYfhg6U/KwZSRqDdh02ro9prBNA9E=
X-Google-Smtp-Source: AGHT+IF3EPkkHdN3dGaDsrKnobA5Ss2WAYPrZ1tSjTgLyD62juadCZr4IcGU0Nj7qL7nrey5zB8ggw==
X-Received: by 2002:a05:6a21:9210:b0:2cd:5403:ed9d with SMTP id
 adf61e73a8af0-321e3edc7bfmr5900224637.33.1759336544767; 
 Wed, 01 Oct 2025 09:35:44 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099d4dec5sm1811a12.30.2025.10.01.09.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 09:35:43 -0700 (PDT)
Message-ID: <b5280074-e87c-4838-b816-eb9e42dd090c@linaro.org>
Date: Wed, 1 Oct 2025 09:35:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] hw/core/cpu: Remove @CPUState::as field
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20251001150529.14122-1-philmd@linaro.org>
 <CAFEAcA-daogqBPxt72qTM6BuMuD1wuw+vXZwxLUQftwY2FZk=w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-daogqBPxt72qTM6BuMuD1wuw+vXZwxLUQftwY2FZk=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/1/25 09:08, Peter Maydell wrote:
> On Wed, 1 Oct 2025 at 16:05, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Instead of using the convenient @CPUState::as shortcut, use
>> cpu_get_address_space(asidx=0) to get the vCPU first address
>> space.
>>
>> The goal is to reduce the risk of AS mis-use for targets
>> that uses multiple ASes per vCPU.
> 
> I'm not sure I agree with this. The cpu->as is handy for
> the large number of targets which only use one AddressSpace:
> which is everything except arm and x86 right now.
> 
> Targets that use multiple address spaces need to be careful
> about which AS they use by definition. Unless we have a
> track record of code in those targets carelessly using
> cpu->as when it should do something else, I'm not sure
> that there's a benefit that makes it worth making the
> "use the one and only AS this CPU will ever have" more awkward.

I agree.

Moreover, '0' as a default is just as bad as cpu->as, because you're giving no thought to 
the selection.  Similarly using MEMATTRS_UNSPECIFIED.  When such things matter, we need 
the real attributes and/or as piped down from the proper memory reference.


r~

