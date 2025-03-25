Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253CFC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEc-0001aF-Vf; Mon, 24 Mar 2025 21:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEa-0001ZP-N0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEU-0007QY-Bk
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2260c915749so66296455ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866650; x=1743471450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UwgoocbzyjIZFw5YoMLGSPLzvZLOD/sl0xS6wYzFato=;
 b=db0Wz4JTHHzS3bBsugv0W4X7JsvA2mqYEsoox17Nnovb5AqbGQhRG35RaGb9G8Q8tl
 VLVsij35YdfPjko49lusxWXU15LY87yLsHTPosNueP+CC1RkKX9qojPSARV6ihOevzZ8
 veLB3WzsE+RqP1TeSfic4O6iiVrX+a4IeLpVmupFtI1TPJaiblgNd1jkxNCYMyg+6YAB
 KNxcFybODpbI7hsI2XSdfGwOTEIB0G8OxoL9Swt8s+O014QRKFVdS1q8NJnU9vCVFdYv
 jKYuvMlIqt3j2AwWdG5cjMbMRyR2b10qFzEMe7aMS3FiH7NyneWv1LgrfCAk56y7WR2E
 Q6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866650; x=1743471450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UwgoocbzyjIZFw5YoMLGSPLzvZLOD/sl0xS6wYzFato=;
 b=VhR7+vKGVjRavN5EAGcf51YZdH37OiyF8oUvHpgw0EfGBSORfSgMsxrw/bP6J/xbsO
 l5kxRxrrZMH4lxorFo8VxVxtudbwqxivS6wIe/IkpaFK4HouwC8L5L3niABlREO7h8hA
 MRlL9Ksvt5XU8dtsZdu8fiVYawZrDkUgqKwKDpjcTZvEJjqKgK+a1CGkRti3IwbaPOkU
 ImNZgOwEt/WuVE3fA7pXa1/f5TX6nnh36MYhYWsGN/p2tE7k8iPVAz/mL6dD3XjDFcnI
 MpK4oG0faOBpTkax/ngR8QaGFL4SCmtBG8Mpwf2vE58rAOxLifyoLrAeQe5rYLv/TTCZ
 pWIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc/0U6c1ClcEs66bASj5vbnORxkRXo4SaxwRsIukk8QEELEbq9JV62TAvTYJp/yajQAcwYd278v3ys@nongnu.org
X-Gm-Message-State: AOJu0Yx1R6nkZS2pBTDrATKnepY/zaelAT8vBrpcs1pTd6EEiGEYCTSl
 xgQiWqy7tJSWFO3XeYPuSKzAFXGWsVZjral/NIR5El8QUh4QmN1Y6+mYAJ78Cs8QLuWKobWbGWc
 T6rU=
X-Gm-Gg: ASbGncuvyYMP0h5MG+b2xvZD1CxOLT9hTLkbJQ3tZSLaZkGFJXfd0z0C4qk2/8DhvZi
 SxK+5BoY+jCFoXtZSCuaQHqiIjKTdx6r0NMSiasTfktdW01aCLVYB1kfw3TLPWePOp0GNTZCb96
 qP4+mOgoYAT1u3+7tW1mdnTpyJr8+f9neFOjF+P/NWgqINZO8G9IpbBuMtiBBwMIz5pc9aJXENH
 ThPoiy5suo750vt8qCUf9X2TGWZ+9ctb/iLcHU/hzMCJZvTq8XLE0qRTRVnzV375a2W7VOaIHq9
 CTsf+qEWt8nhpaRs2ujSCEcHW2YvSVHLfOuL5eba8PaLhKEN1o9d2tS0nw==
X-Google-Smtp-Source: AGHT+IHjEpHCQ0H2gpHkBwhU12Hh3f1pvPqq29o3qNn2s8Hc78qWYTm1QwX5L0b8zIxH2zexZQbfDA==
X-Received: by 2002:a05:6a00:2316:b0:736:3fa8:cf7b with SMTP id
 d2e1a72fcca58-739059a347cmr24165122b3a.13.1742866650335; 
 Mon, 24 Mar 2025 18:37:30 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fa38e1sm8784770b3a.35.2025.03.24.18.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:29 -0700 (PDT)
Message-ID: <b07b3853-ca39-4098-ac9e-56a3ea6b508e@linaro.org>
Date: Mon, 24 Mar 2025 18:24:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] target/avr: Enable TARGET_PAGE_BITS_VARY
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Increase TARGET_PHYS_ADDR_SPACE_BITS to allow flexibility in the page
> size without triggering an assert.  Select the page size based on the
> size of sram.  This leaves sram on exactly one page and minimizes the
> number of pages required to span the flash.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu-param.h | 11 +++++++++--
>   hw/avr/arduino.c       | 15 +++++++++++++++
>   2 files changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


