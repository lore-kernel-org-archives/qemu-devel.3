Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D235CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uMT-0002jO-Nz; Thu, 09 Oct 2025 13:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6uMP-0002iv-NF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:23:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6uMM-0002U4-3E
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:23:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso894108f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760030597; x=1760635397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wqkne4+npSOvj8EvNZGrqzK/aNtjwR1LF06q0J8MzsY=;
 b=fAPJJRyfQKwQY0sjtmAaa5Yb8jMmt/k9ULRfLk2y4ACYbPVcoW6bL3CXEtliy6kQsq
 5+bfkfKrjBU3T4jJuBk5dS2Q83G3llPbYulmagh6H686RF/7ssyFcLqA20Gsc+NdEBrM
 EuXscFxbTKW3T8qGJG0mwbXn7pR8jBwAVtdTN2UUSLJZSAY4eiM6QbaNFxHhYSWXv5Xi
 FIyxVKSKP7TftCkSFcEImbLg85shiSgGdfJCMsXEGlG/AcgJVoZ0oTJD3n1LZ/X3roNF
 P1tkD9gfJIh9wAGvOaEuq1Th4PMLeGK+cUEMVp94rvMYMXs4CQ3mfYMMlubLOB/xGhF7
 SWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760030597; x=1760635397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wqkne4+npSOvj8EvNZGrqzK/aNtjwR1LF06q0J8MzsY=;
 b=xMAJio8XVvdi2BHy593fzZebDc7anFQIeu1hvtyrYUF7wD7ENXJguONZNWVN8BZH5B
 c+qIm2qUvdNOpna0MLhA/kETqFt5wnHj8q2CbIgDsIpAUF2UcfFOTOJhMV80umsddjOw
 B+yGDi5BEWfn1x9KQCs2XNQgP4M/pt4RFeeut8I9bNNdXwtYfkS5bB10jDXkiEuu2Mak
 KmIl5+xtw7cebs7i0zupwHdnFKD4EClS7ZpWRsxAXUMNFel1hWAN7/rQm3pJJnGHa+Wp
 rCQM7upwTWAUIauSbko7TRcG5VrJYXlE3lySpfZJeMqVxTClKgqvOxYe0ykuR3xMZDz1
 wf8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqqWpXW7/yG8eRPdfw5I5810C0UxQF41LT9eWm6YtwxPyUH4rqOyfyj9Zdmg2xnjZsJBDxXT7PedB7@nongnu.org
X-Gm-Message-State: AOJu0YyfNpm4dIOw8pIuUAEf/gk1KJ7GadSz0L0qPicULSHyHb5k6qM6
 MaL2UMQxZUKyeYUL6DR7xb+L7xeJCYLqE28ZatfeSwO4b3hNi4Pnq1IjZHAojN6qEuo=
X-Gm-Gg: ASbGncuk0qgXJAETtFuMMi4RSuc8f2S4RaSNFBr+u56+nFCSxh2B4EQT88knFaH1i9i
 zaVko3f8zVxi4EmkYFP6cHTEyLVKCNysWhRU5EskpRi73T4kFzabhxZZrIMlJhEqW2ZQVQhSOAD
 Y00HpktmZzRAWXOlL8NzMFWE8OqxqhDXuHxwO3mUJ/1fE6vJ4T5jhVk27sRJave3hamnKyaXjs2
 OU+mwQQTDKgwM2O+GI15vXiuBSjgq5erSg0v7mmQK8irqKCehlD6j/Qg8sBSkMiVnMtzquUEWe4
 WnH/voULRhGQ2BcHbN19E0X9EqVhVwzzXUmjo4CFPGNz25xt+YqKaJdZkwOMZNlKhmymGu3el6T
 MvGUi41x5MUwfaretnOKAqrogtbP2Vl3exb6KuPsmAiB7bdoXawn/5Ty6MxkNhsThF1jZd0TjeC
 dzcAE0HUfHFCdzVsZSbw==
X-Google-Smtp-Source: AGHT+IH7yjKq+xSgRhuacMV6O5ty8dVy8k1QYMwdmUdnbjWk1Xt1nKfIw7Maok8KN6YX15xCX6Bdcg==
X-Received: by 2002:a05:6000:2c0c:b0:3ff:d5c5:6b0d with SMTP id
 ffacd0b85a97d-42666abb559mr5088579f8f.4.1760030596748; 
 Thu, 09 Oct 2025 10:23:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49d0307sm4803665e9.18.2025.10.09.10.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:23:16 -0700 (PDT)
Message-ID: <f745f163-6bad-47ad-a1c0-4be96b604266@linaro.org>
Date: Thu, 9 Oct 2025 19:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: Restrict qemu_ld2 and qemu_st2 opcodes to 32-bit
 hosts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250820134937.45077-1-philmd@linaro.org>
 <226ab909-0482-493f-bacf-5d2930d07ad7@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <226ab909-0482-493f-bacf-5d2930d07ad7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 21/8/25 22:27, Richard Henderson wrote:
> On 8/20/25 23:49, Philippe Mathieu-Daudé wrote:
>> qemu_ld2 and qemu_st2 opcodes are band-aid for 32-bit hosts
>> and can't be reached on 64-bit ones. See in commit 3bedb9d3e28
>> ("tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}") and 86fe5c2597c
>> ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}") their constraint
>> is C_NotImplemented.
> 
> Not true: ld2/st2 are also used for 128-bit load store.
> 
> See: aarch64, x86_64, loongarch64, ppc64, s390x.

OK. Hmm I guess I need to add a __attribute__((unused)) check like
you did in commit f408df587a0 ("tcg: Convert brcond2_i32 to
TCGOutOpBrcond2") to outop_qemu_ld2/st2 then.

