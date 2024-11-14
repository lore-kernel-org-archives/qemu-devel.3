Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C25D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf5L-0005Zw-80; Thu, 14 Nov 2024 14:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBf5H-0005NL-0s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:00:52 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBf5E-0001Kk-G4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:00:50 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-210e5369b7dso11646795ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610847; x=1732215647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WCF10UJl5PG27w8WAO2jHWY7UVY497UxuwsdECCW7mU=;
 b=WykTOAUSTLYPuiaLbQU9fBu/l23OL28YSd9eSkVGikOXZcHs2QYQB4V5w6JX+UMdbs
 SEqV5oaLfSHq4PbfpoHOmn0MpCGAcnAXDq005W5iizpIUvKLY4knAX0Ht0s6mo9T6x6X
 hv6he3Yl+wVqLvf2pWwxLJ79i2+3vmCpncG0Hw/5iNfAnSGGX1wcELjFujwjbAqhq13P
 pu/NR6IGmK4jnTtxGQc3JdXEPzRBB4P9OLCbTe+gHiYTV9mjEWRkDRvqBxokF3AUMkHz
 acr6GlDkx8AEryLVRm5hPs4iStoQnHsaTNcanfEFhBLT5ekfbhIppBLp0HbUJTnuiE/g
 tyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610847; x=1732215647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WCF10UJl5PG27w8WAO2jHWY7UVY497UxuwsdECCW7mU=;
 b=r6INht914DtANu3vJtxp9Rq1sgFh6mPfs8DsRbakPYWv0BozyaAClcZyDv9vSAlWIw
 5oPze0sY6FgBPq/7woj9N0e5qaRjljsNtdpUNkIJbDu0/rKnoqQpmJ3IeuABpcYOQOuP
 CUYfITy8XdSoP0HlJLdPb+w217VW6NUfaiumVNT2mq/sBfbytm/atcSbRZ+n6bxQ2s5/
 KjKue1MTexi+fX36d8Upjqcx4ZDqvovOnPWQP2oGYfcw6HKco0oC9UUPUwuTtWm7p54m
 2pC1MdvsznsxD0A6bes4/SiIKQGYhjvGaIFNe74X4fdu13wYP5ZrpPyEXzgWCfdDu4Bw
 lPPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL5Hnuui6Fbxt7wNSpNAkaj5ynUhvHppeLZ/vAL+2Xyr7ValwvhVwGxxAiMzOzedxGCyNjqroLfK1F@nongnu.org
X-Gm-Message-State: AOJu0Yyk5YEmp7/J48LMPcCLyU9XqTFuasx99j/pQZl3i2ScS7zomaGR
 JLwG1s4bDCyWN9f7Om5ZzN5zsyeuhJoT6FnoDfnHa8EOcCRR67ePS+38ysw1gUY=
X-Google-Smtp-Source: AGHT+IGnHzzYqk+q7/Yv5JN7lqD83FpYqSx/4shcVG1QfnTZYGSwgaOyl2SBchN7ed/snrWOVkfC9A==
X-Received: by 2002:a17:902:ce90:b0:20c:a175:1942 with SMTP id
 d9443c01a7336-211c5011492mr45572645ad.24.1731610846935; 
 Thu, 14 Nov 2024 11:00:46 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d05dcfsm13642015ad.201.2024.11.14.11.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:00:46 -0800 (PST)
Message-ID: <6db9d01c-4d1b-4102-b5e9-d8b613234bff@linaro.org>
Date: Thu, 14 Nov 2024 11:00:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] target/arm/mte: Restrict 'exec/ram_addr.h' to
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 11/13/24 17:12, Philippe Mathieu-Daudé wrote:
> "exec/ram_addr.h" contains system specific declarations.
> Restrict its inclusion to sysemu to avoid build errors
> when refactoring.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

