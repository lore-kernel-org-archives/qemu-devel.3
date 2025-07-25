Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6C2C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLmI-0006cM-80; Fri, 25 Jul 2025 13:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLhK-0007p9-Vt
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:55:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLhG-000163-Tz
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:55:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso2138707b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753462500; x=1754067300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C5ybC4+556kRb3jk6R1jU/KZj899M/K06S2SGKx0ZJ0=;
 b=XAtutLzZJP3Ynfe63i+n199V0knsgHAOxy7b6JNELCjmktqm59f8ShvJdt6gAWV6qK
 ndPkLgmLJn6ZLPzYQCNCYJjK4xHM4RaPozKTnHwXThaUF2GdkmMuDWVkv81YZ/3K/6BU
 7iMgP3KM6GyGEKc8/0ByJBkDbn94csLTtbQUbVaXLPJUuHkKYdWm6rKnizQFrL4gSvzu
 gVgT53qUCE36dObvFBxz0lOeC0wex05o1AKrD3a4Uy9lNf4d10vvOLLrNUO9bCwv0wax
 F+gn3NdMo8JsK9MfcF+GBp5HVkmGYuuVp16lOghvGo7BMCKSo9Hcn6ZZlmfis5zu8QFi
 F9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462500; x=1754067300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C5ybC4+556kRb3jk6R1jU/KZj899M/K06S2SGKx0ZJ0=;
 b=IIVa0iAEazu+jZ0Vv0B4NVTNfePxCnDoj9fQUjnmY+DzV4+S9fcq5wDcf9I2Llmx8w
 KN+4BLBudQW0+3ct0wdLjNmyZReJ9zmH5I7ADidvwxNq5A4t3ITiX8NhmJ6vVg+ZFOPp
 QPANCuuxCJ+W57JIGt9xRoaMBHrzLvD7YiKwcti3i20bY6XzeGICR7g45O7gGBrYOcGk
 ulJvWjrKn/CfyCX5TMSKExJyckMzR3gEiwJV7I2HLtF7xJATFPRfb6lVuoJwgrdNT/mQ
 szcYtDH0oAGoJ7YH6yqlEkUyTf0YMTfOa5I0a/gv7LDYget2BSWUH6qno7Zp6XOeNjPB
 VkZQ==
X-Gm-Message-State: AOJu0Yy6GyYXoCze2+J5gcvIjllINdRx/dLyZo9PI/diUNBnOiYDbxzz
 PlZOIrZ7JK1bXrPj52drOULTyiTQZmvTJ5DuNYy5vKpxsb89sZt1w+5i3Sq2GP7Iyh0Dy8n4i5I
 yt9aA
X-Gm-Gg: ASbGncvkMvUYS5e+6IubQ8aj+Io91RxSjXvcZnxjaZXxSG31uRGJJAOoePhX0y8y/5E
 vFsfebYS9Ig8kedZ/urExhfZnUY9K59WIC1Wf9WwFYSGpYlNiBMNC9BN0JyqugJuWuJotNK9xHX
 n0nbwhLwV/qUPZ/2C5Rt7I4BzYTmZGzUKZJ5Gq+F1P0i4oUwWiFMcTsBReAt4263wZn7CDeubPo
 L26D+d23mynvfTyj59PHTqS0Z/onVKJqD3VBvsRxulwSKkFtXo8kgMXADr8O6Mmxyjli9XlVQDb
 NlN6n/xyeQ3h96d+liM5zMTL5dZe/FdSVm2PhpfJarZW+rmKiKo+ldvDcfZCIxDt8I18Sj0kqPn
 icuA7pfIMFcx0P06SeyJuTMNLDQRSYOcCgKLRseIR9dHDCSQ6TvKmEx3MKHxOWj9pNHZ+Br8BlP
 ypxg==
X-Google-Smtp-Source: AGHT+IHxvDOvidd46PQvzeHuj+SPyidqxD9WJNxgYiLxTSeLlmLjyncFWfr9o7KoWQk7BFoWEw706w==
X-Received: by 2002:a05:6a20:1585:b0:232:b849:b906 with SMTP id
 adf61e73a8af0-23d70052685mr4395683637.11.1753462500593; 
 Fri, 25 Jul 2025 09:55:00 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f568ac1sm258204a12.5.2025.07.25.09.54.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 09:54:59 -0700 (PDT)
Message-ID: <8308e195-9c3d-41af-8dbf-497122bf0950@linaro.org>
Date: Fri, 25 Jul 2025 06:54:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix width of third operand of VINSERTx128
To: qemu-devel@nongnu.org
References: <20250725061736.1096206-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725061736.1096206-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/24/25 20:17, Paolo Bonzini wrote:
> Table A-5 of the Intel manual incorrectly lists the third operand of
> VINSERTx128 as Wqq, but it is actually a 128-bit value.  This is
> visible when W is a memory operand close to the end of the page.
> 
> Fixes the recently-added poly1305_kunit test in linux-next.
> 
> (No testcase yet, but I plan to modify test-avx2 to use memory
> close to the end of the page.  This would work because the test
> vectors correctly have the memory operand as xmm2/m128).
> 
> Reported-by: Eric Biggers<ebiggers@kernel.org>
> Cc: Ard Biesheuvel<ardb@kernel.org>
> Cc: "Jason A. Donenfeld"<Jason@zx2c4.com>
> Cc: Guenter Roeck<linux@roeck-us.net>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

