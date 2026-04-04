Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4B4E88D73
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 00:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8pG3-000836-Mj; Fri, 03 Apr 2026 20:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8pG1-00082m-6p
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 20:53:01 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8pFz-0002zn-OC
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 20:53:00 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so1417284a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775263977; x=1775868777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPJ63iilULL88u3gEx4TkfTpjRv7A+v7XbOor8AB2/E=;
 b=E4HST4tV8dIDycnpSzs/wk8cPs3gbtGqpBildIndKTrhYgEtLfQ8RWOjOJiWQiiCcJ
 7lcRMA+jvZ2vby49koiRPYkKSugi+qMXZzakvi8pqI2NKlIBSKXZqKTlKAD9VyiCWeq6
 Qc7+vXcU5kXcCCAEF2HRVJm4IUNfCCbiPkuj7a1jlWYXmRExuZgu4aEJ2fbj5pqxoFe8
 DKCsvo6H2UGYTunmhpsXDzvc7Rv07+VH8T1QilDNTgJVCnC0+hHmlLDWwoYYxqPzwuKq
 1HM35bVrO9pWwKzcR+E9A3Fc2GxCsVRK7PIvWmR1hVYHxmaf7uJYI32uubvUrgC3nXnY
 srCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775263977; x=1775868777;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vPJ63iilULL88u3gEx4TkfTpjRv7A+v7XbOor8AB2/E=;
 b=FjSL8SRVuJ74wXodqOFX8USQwWTvUgaJAkWU6A858YNCXePpPNfRftoaAapBQx2xsm
 QFGBF2xSTNwlWVrPIx5XPISq7jfsN+XwMISHB+clquVUfqWyfC4uk6aGZZp7+KO5aA03
 KD780sTlwFVyiUYGMuNU43Lugq+hYaYbNH7YXSr5p1UkaqFkzGC5w4BLSBL9+HHFOtuy
 6pV1IhX9V9/gMLHSVjarPge9cmXVyDpFTXwaJgyUFfiPBXwUEUcF0CPP87n0rLaFjLWi
 ETCSu2zpo94lAAEW0h6alRjY4A2jtW+CPkyjQQ66w1kGWYIsgzfNMFfbCLAG+QJ+8gJ/
 q+SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEV4yFJe3b5+RKrKvxYE/IEjtEA+MGadCh8bVjybZjCWbWyIAnRJysiMGDGvHWadXIVs4AUSGUEhxO@nongnu.org
X-Gm-Message-State: AOJu0YwB1mvKmrPbD68B+IFdUaBfEAgiKsrt0u1bklUG6ukMfrxheHsB
 1sHr2QunRBIpGeU9C1vKgCcBvhvtV7bK86WKXL37CUARpZSGCDLcMErElJe9i/ReRjdaiHzxijk
 VhsPOwEE=
X-Gm-Gg: AeBDietAFWd9+LYaK8S/altque/083hz5WBElk3O1DZKTxFa010xwj0C9WwpmcC2YbF
 3jiDe7HU85vwrEoNp4YN36JeCY49ajc1CvOwKgVpLS0xufZaxmordZ9blK2HFpRskiMKxEo4tru
 Ymkio3XlQwtEaHGXuPOv2L5tpCX+O8f0hPlWR8GAaNESAbvlCnEj/lTaAQhrjqzpVEvGp3XPCuo
 fDzlYo2wO5DGZjbO1XbcNul05M+J3q1/s5T6YMNB3pwvDYAkfyiz53ukVV5MPK3NuBMmeDVoqiE
 +00EnPHLprnEOdZ8u6HX8Q3A0oyst1uhhGy0rrLxr/EiYkE/6A0H3KLBOhf7sVwqws8Jzgcpeo1
 WHJQarCMtrFxl4kOg35KTxJHB1UaLNTAiaeXahtQhP3WjBIkBKIeOl5k9SwRTux+hOWQZB9PmQc
 Bs8lM1qd/XsYpEU2Y2qxLcJG74VSWj4UFCuTI0Q+QvlGole7Sj+JpTI9N4sKGVOQ2dO/g=
X-Received: by 2002:a17:90b:268a:b0:35c:854:d1d0 with SMTP id
 98e67ed59e1d1-35de69d555cmr3796089a91.26.1775263977164; 
 Fri, 03 Apr 2026 17:52:57 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe623754sm11574215a91.6.2026.04.03.17.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 17:52:56 -0700 (PDT)
Message-ID: <47236dc2-cb06-4070-815c-b4f12128b99c@linaro.org>
Date: Sat, 4 Apr 2026 10:52:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] alpha: Propagate CPU index via MemTxAttrs
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
 <20260401170454.32045-3-yodel.eldar@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401170454.32045-3-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/2/26 03:04, Yodel Eldar wrote:
> From: Yodel Eldar <yodel.eldar@yodel.dev>
> 
> Currently, a read of the Typhoon Cchip's MISC register
> dereferences current_cpu for the CPU index. To decouple
> Typhoon from the CPU, let's instead pass the CPU index
> through the requester_id attribute of the memory transaction.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   hw/alpha/typhoon.c    |  7 ++++---
>   target/alpha/helper.c | 15 ++++++++++++---
>   2 files changed, 16 insertions(+), 6 deletions(-)

> +static inline QEMU_ALWAYS_INLINE
> +MemTxAttrs alpha_cpu_get_mem_attrs(const CPUState *cs)
> +{
> +    return (MemTxAttrs){ .requester_id = cs->cpu_index };
> +}

No need for QEMU_ALWAYS_INLINE.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

