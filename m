Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72305CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uZG-00022W-G9; Thu, 09 Oct 2025 13:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uZB-00022A-VU
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:36:38 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uZ5-0004c4-CK
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:36:37 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3306b83ebdaso1099291a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031383; x=1760636183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+2mqU4Qfsz06aSMKjuySZ29iDhl1xy/YYAlUuSzJ0LI=;
 b=SkXp1pd1kY0Y0/S6C837V8ErUv9wufCwt5U+17e+rEs229d4IZLKyAZGhveYPwUWmp
 xop84rh8HVoxzLkEl21FWxvzQRHXIgBjI7ytr2YP/sNnyl592xKTn+jS6cfp47FSvV8u
 15x/bdYkktLmj6DkMSYOGKCW+QOmvwbYViI0yA6LMEsFlPPKK8IhlIsABOU8i+bVZNq3
 pOfoRN1NRNFdwIPo2oW9j2GGiXo7E7MEdwxLw6oXkQaPbLmrs2wzig1yMb5xnZ2zhorh
 ojqBmafMRsLBHRQZ97N4iD0RreXpK5djpLAREmLxgrn2EdhuBbUO09wnJETHnZHSUvqF
 28OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031383; x=1760636183;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+2mqU4Qfsz06aSMKjuySZ29iDhl1xy/YYAlUuSzJ0LI=;
 b=NpQ9UKSxak1zvTX4jHFpeLGlsti7/gegWi5b5kwJelnt/G6oN7vP/BeDm2d98u40Wg
 rX3N2fRsl/bz1DzLX3pUmg5IEBCsKnJtkEV43HK+YAyaJ12lYXyj98wKRVbctMGTfzXO
 9qjIwbdHk8gmFU4JojmuX0E7AxBGJgMTgkBj/IRrXIr/6QU7RgjZrBaC2h/kYPOnnXV9
 a8/seRtQDny2ESCMdfcYx3biGfLV4HZsia/BvonbylHRluXIJm9ORx8j7iNZz6/knktn
 uCwN/i5XZhoXVI9LrTJjGm1AuCJFeMoLnHHWdWFbNGZsSv4dxJeJEv6lArfvKCNSpRMw
 0rXA==
X-Gm-Message-State: AOJu0Yw83iOuXOyR71CowB26mGE+2Z+fTkFHKeaemzV0ZU7St2xo0NyN
 6hAcIAX+L+Uj9SDhuJlqK3xVBwlJ71uINtjzLgrUluS405FQQEoxz4DATh672D+j3aRLlTvqAUE
 MaVY9KWY=
X-Gm-Gg: ASbGncsM4J1LVIztMSfdJwe5qe8oVv8TbiGPu2AiynqEE6XqHHZIZIT4RrAQ+dXFzfE
 V7JjIkKyExEEPTIGAQ/YpOCpDtBc1D7d62JVVegJnzcFC7D71kV5T33B+kXRdyEIVplNIv/d3NY
 E90zcuRitbyQbl5Y7ZUeHkXopP7fOokza0k0GpNSxBoox2kvrukhvzDrzhWTjyExsndCHlH6utz
 I3u1Nz0hBJ9Ku0Ey1BfbvmyYlFgmlki1LHg0QWpujEeo3+T5/6OlRP6MSAdYJsHF/6VRdnQFlyq
 exPmOaCuA2+N4IoFu2FFLiU2W/jHEdJ2hirGReZ1a8U8tC+BkozxXCSGYv0jiWmHi6B0EVA9t/f
 El09QXOmuWiD2ILmuH5FkwfOoGNTnSMUt5eAPE2/CdZu3ExazvogfgL7scuhFVb2Yi30JVnQIXg
 s=
X-Google-Smtp-Source: AGHT+IFcjEVH4ucJOzjOwzr4vyYf8B9MFYy89fAEjwN37Ja8v9Mas0dn9RBIoYw7kXy0drJ6M0znlQ==
X-Received: by 2002:a17:90b:1b11:b0:330:7f80:bbd9 with SMTP id
 98e67ed59e1d1-33b5139a422mr10038297a91.31.1760031383508; 
 Thu, 09 Oct 2025 10:36:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b529eecf9sm3405573a91.4.2025.10.09.10.36.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:36:23 -0700 (PDT)
Message-ID: <b4c8e9e8-fcaa-45b7-9e19-dcb4ef3780d4@linaro.org>
Date: Thu, 9 Oct 2025 10:36:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/rx: Expand TCG register definitions for 32-bit
 target
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> The RX target is only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/rx-*
>    configs/targets/rx-softmmu.mak:5:TARGET_LONG_BITS=32
> 
> Therefore target_ulong always expands to uint32_t.\
> Replace and adapt the API uses mechanically:
> 
>    TCGv -> TCGv_i32
>    tcg_temp_new -> tcg_temp_new_i32
> 
> There is no functional change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/translate.c | 322 +++++++++++++++++++++---------------------
>   1 file changed, 161 insertions(+), 161 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

