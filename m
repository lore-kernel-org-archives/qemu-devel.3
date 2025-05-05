Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA3DC3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1ZV-0004gg-7u; Mon, 05 May 2025 15:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1ZT-0004fQ-IP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:33:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1ZQ-00037R-Nk
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:33:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso44136335ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746473623; x=1747078423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vWUJ5/LQMFceJ7l1Ffi4cUdM3ed9wHY8/6UU56HqvrM=;
 b=ma34r9OOihzbptOUGUtBd7jXCUuZEBJdeaXont48I6gYoUbHDwP/aMC+2qVs63RLez
 TRUZRk2mE8zEuPIxJ2NIiVChX53lY2kcjhLlIDefy7MyD5f+Z0vIeV1NvFL5UEtA2Av3
 6ZhCi8gIDB93QolFbNU7GMNPqGfqjh4Zcr9VMpsMITOJKaYgSpgijgM/ALPKgQMRs33Y
 8eH2dBvPcSoEBUQ1xQrtX8bGlQYjR050JpiSSB4BTOIkhm0shm6mdzgPbCzgIrPvwhul
 w16Wy/nhf5IxCZr/dC9zmI4Nx8lLQJUGeAjs8kkgwiwKp8w0dTqccxksaIiW6nchOMTa
 qbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746473623; x=1747078423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWUJ5/LQMFceJ7l1Ffi4cUdM3ed9wHY8/6UU56HqvrM=;
 b=ckzjMqE6HIV1op5KjZS/IUVaat1pfFQsmi+/cHMHI6EuaKyWnKPZzAL04F4oUR8lsV
 TtYbQsuOOfrRMVpQH17t9RtaET2JqHPXZJqDqblOH1+3kbULDrMnqIZKQmOKquglBFJT
 MPT0/osE3/XprxewM9izcpFsy3xkywrv/eLBGvT0/FthS4DXO+mqvT4Iqx6LLy7wg0s8
 u2JVazyiNaO1J+UXxcyZazi/HhP8UCTsOC+vMVF5CPA0ZTgXzk1AznmRyn7va/SX2dW1
 7zrCu4cMeverSDclKDFiTJaaxZl97CAmnxdYSclGdiSresjVsgArP4VX5y9+kYr1m7O8
 ULVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj/FOfh5bp1WNJElfLw4k66Kb+eWEXzd4YPpertwsh3NE2qQU9Jfec7lajuOhvlloJBHNxo/6+1R1S@nongnu.org
X-Gm-Message-State: AOJu0YxVoyz4NC7xmBxrKhc1+vtShy1soFywjt9kCGKO6KtRGGuhnOjr
 +4TwIqii0SjffwzgykBOYuJSSnVFWnxOgaKoWynpvN2aIrDVx1hRSsl0DmEK3gs=
X-Gm-Gg: ASbGncsohbYY/gM8Xo34J4bskpMPC2BZY3ACNdl5SSL8QZNzwot15GJvCyDstobaiFG
 SwRUJ87Jtd+EnYPl2J46AH7Y+tHh+xdPTuNqSk8eDh2uFlB18BT0/dDUrr9Wv+6MmSTudgUtl0n
 Aj7iPPsQituTa2NBmiUHc+fabOOZhfTqHQk6za6fdBrrIqLF9Dp6cyk/KBTRpD3mXpnjsu8rhQF
 +iQGhH/suk/NVE36Y9W1Q7Y8i9RUorA9e8mZIV7j4VXBZcYEpeq9dCenTHQ+F484v5LhHCAFCSy
 0Zetn5V9uaA1ZkhO0mQJRu5QNC1gvOOIQhZL1NPwYNCH1N/PMYDEEg==
X-Google-Smtp-Source: AGHT+IEX9V83EnaL/ZcwpR1eBzmw998FIZZRQI9U8y2GSW1Kc/OQM9yPvI/71pp5QWhFctyPBRWNWg==
X-Received: by 2002:a17:902:ecc4:b0:220:fe36:650c with SMTP id
 d9443c01a7336-22e328077efmr10171025ad.23.1746473623187; 
 Mon, 05 May 2025 12:33:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151ebd08sm58947705ad.104.2025.05.05.12.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:33:42 -0700 (PDT)
Message-ID: <85513f8e-232c-4d66-ad03-15c4f697dbae@linaro.org>
Date: Mon, 5 May 2025 12:33:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 47/48] target/arm/tcg/arith_helper: compile file twice
 (system, user)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-48-pierrick.bouvier@linaro.org>
 <e8eee40f-3785-4816-b96a-af022b3031b1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e8eee40f-3785-4816-b96a-af022b3031b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/5/25 11:54 AM, Richard Henderson wrote:
> On 5/4/25 18:52, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/arith_helper.c | 4 +++-
>>    target/arm/tcg/meson.build    | 3 ++-
>>    2 files changed, 5 insertions(+), 2 deletions(-)
> 
> This one doesn't use CPUARMState, so we can probably drop the cpu.h include, and thus
> always build once.
>

Done.

> r~


