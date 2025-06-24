Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D4BC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU53U-0004FZ-47; Tue, 24 Jun 2025 10:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU53R-0004CM-Gh
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:55:21 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU53P-0001FE-Iv
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:55:21 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b31e0ead80eso554885a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750776918; x=1751381718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j+ncAe3sExGJLsk0fG8h6nFy9mYtBg2eqpju7iERKSI=;
 b=FI/yt2BRYx7upK/mPOMHlI8a05bG2o2Kd7GmCONiE6KL/A0xEVFJfp4Ob2jRqPoNOQ
 SM5bb00yitn57QpakDiJmLIVhMZ0FFxUkvBZQCqxXTaCSfRvlZcMnxdwxuAq60pD8nSM
 ToGmuYyuYG+/YiaC70iZbX5+S/gP3M9/j5PqUT9VFYNO+nh0rOGpOJlxgzmR5N4pqObB
 wyIAvYobmC//0HCwUXPKY+4xQZ0+Lry/pSdPCn4oOFwyoRfpt4quRxIHA8ZjQRRVcNPs
 fnW+AMCFUtaZim7XzD902zBs3RCFKvhGPIaVa95l0iIGSYi9kKFew6KN8QZpZxK0TyyH
 Zaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750776918; x=1751381718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+ncAe3sExGJLsk0fG8h6nFy9mYtBg2eqpju7iERKSI=;
 b=bq+BoHq6/kQ4HVcETrOrXadbXJUeWJtrn/ORQfz8IOZhE9Ao3Xz1PW8yDO68sg5EhM
 bEM//HlVe0ee6Q0tVz9f8BchBaQGliehDuvGeezFKDiwyl3C7c7TF23+zJRlk9RcWBrG
 1r5a+2EY0n1z391SeI1HDg4xIwAAvTP2xH8XEoHrd3U+0ItzLdyKJDM8+iyDyprYw2Ua
 siImUEM3ZwEq97nGxZnS9lqIU8yEVG70hRbBrCqlHyOClZydy9rQ/yk65B8CATP3VufF
 OGmHjl3sTk/QyboaQhT5tUfTjrXX/LLxN1Bc4dFISb9D2a0pZn/JUoOhSmiVzFbUXw5z
 vd8w==
X-Gm-Message-State: AOJu0Ywjez296oe7m5zP2rAfq6E4CPJRu69uncNsD1ucu0F8ZmHvYhtG
 FB8IEsp9Xu7btySn3j3UGrBauik+cXjyllGzRbzyWeu9lufAWbwP26CPft3kjZT8Mq0=
X-Gm-Gg: ASbGnctIUirG0KCIvuxiVRfZOqmaZboYsalb+eNF8IviGc7m+dw4RLiLfK5Y7oiRr7I
 v0Yuiw7G7qRNrfMnDQ1zfb1T0ZvN6+pCh4icDUTvkkIrW9mOae0sFg9URMCi75crpKOIP5k3uGu
 Fu2sgv/RIjb3rAwFm6QNbWOxieKT77ehoCZ69p1fRAo4XV/Rlc76waPEzOEbs1X2IwPeLrRNGVE
 CZLkchkRXqcXpnOkownV0GeN40++R0SefbegfvIYcHO2Gq2vYxFTQsxfvyyJ3cM2onjZohE1Mxq
 UgIwcuqwBoXokGwqLKza0gKTThud/GFq/3l9VfuuHVLAAKsvD4kMNfJOGJpZ9t72gLx53lG5dBd
 E2cyaC9zpLmTryFY0SSwaR88ShJgz
X-Google-Smtp-Source: AGHT+IGSSn6OYEDVnZlvRw8xsxUxFT7AthS0Jdx9UtuaL37WmnpzT0vNQYTauDdWckmyoJafsgek3A==
X-Received: by 2002:a05:6a00:4b56:b0:748:e1e4:71ec with SMTP id
 d2e1a72fcca58-7490da69762mr25216075b3a.12.1750776917682; 
 Tue, 24 Jun 2025 07:55:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e21136sm2125882b3a.47.2025.06.24.07.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 07:55:17 -0700 (PDT)
Message-ID: <a10ad9ac-1a0c-4d6b-b5db-ec10423f5236@linaro.org>
Date: Tue, 24 Jun 2025 07:55:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 040/101] target/arm: Implemement SME2 SDOT, UDOT,
 USDOT, SUDOT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-41-richard.henderson@linaro.org>
 <CAFEAcA9=Nix2pj6Sc6-Ar=em6LAPhXa69bcSyZzW2jJfBmmUCA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9=Nix2pj6Sc6-Ar=em6LAPhXa69bcSyZzW2jJfBmmUCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/24/25 03:02, Peter Maydell wrote:
> On Sun, 22 Jun 2025 at 00:58, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/helper.h        |  8 ++++
>>   target/arm/tcg/translate-sme.c | 85 ++++++++++++++++++++++++++++++++++
>>   target/arm/tcg/vec_helper.c    | 51 ++++++++++++++++++++
>>   target/arm/tcg/sme.decode      | 63 ++++++++++++++++++++++++-
>>   4 files changed, 206 insertions(+), 1 deletion(-)
>>
> 
> 
>> +static void gen_helper_gvec_sudot_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
>> +                                     TCGv_ptr a, TCGv_i32 desc)
>> +{
>> +    gen_helper_gvec_usdot_4b(d, m, n, a, desc);
>> +}
> 
> This one also needs its own helper, rather than a wrapper of usdot.

Why?  There's no index.  Other than sign, the vector shapes are symmetric.

The SUDOT (4-way multiple and single vector) instruction isn't symmetric, but this helper 
is only handling a single vector.  We call it 4 times to implement

     sudot  za.s[w8, 0, vgx4], { z0.b-z3.b }, z4.b


r~

