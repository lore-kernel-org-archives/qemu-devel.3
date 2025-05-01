Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691F7C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVth-0003jS-1q; Thu, 01 May 2025 11:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVtc-0003iw-1i
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:32:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVtZ-00011U-Ma
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:32:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so1060327b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746113536; x=1746718336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iAnD1GmafUPGhBO+bMT+SirMBKARuf2EvO+yXD9bfRQ=;
 b=p/g6+6xDgP+6stWnTIztV/dxzkz2eJNDb93Z8hnm+k3ImaSUhXLB9Mvn7kCT9tUSmv
 G45LZRGh5BlKcz62IDh9IbdGK3Lx8fjBE6Y2P3G1tu42ooRRDW78d8ixRrIQtpZR9RwN
 xX656o/3pZF2X3M+gbK9vospj4XAfOxdlJjMbhnKDGigFVu9CnSFpFy3y7OYpURSRvRC
 DfXHpBSY6X/gPuI9GL2H8V5i4jUdNvKgoBKYEbMbftw6z7Yy74KOO0WgZjxPo+EKfwsY
 vRGgQz4pRD2D44s/VPtlBAKTlc5zsioCm0F1qhvN2dGEf0tPxJUD+CkLRUCKam1RqIhk
 svqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113536; x=1746718336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iAnD1GmafUPGhBO+bMT+SirMBKARuf2EvO+yXD9bfRQ=;
 b=QvoRWRrLoXytCRV+5RDo7hgxXyNMqZy7TVtmSOq0sTAa6SwxCgVHas5iYrG49yn2/o
 e3aA4P3U58TGs32y+J159xDXDNR+fn7U9uEs389lb5CUHUirUd3f90/Frl5wxoIZONJM
 0ll+wEa4m3B1bqoS8TzI5XSrvAEdLNzuNMDpep7s3DnR7srm2Z5Zsd5gmd1dUCVTBY+m
 wsZiGIZ8GWFSFrHmvscQ3SNaCP1QDbyVbw4ILLPUXSUNGOJWDrjPqYwwgJZbT6UY2ik1
 WICLhPod+yUWy63vY9rHCSOjGrF353bdrAIZgvp7BMV1p+69FSyJzppd/2+bpWhcfv8s
 YQpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6W5Yv1ix5uhAIKcCA6uHE9RrMm/k9COYHPGcKT0NEOmI13s15vIFXkfZ6GP1JjMS18DJCH5Osex1z@nongnu.org
X-Gm-Message-State: AOJu0Yw2i0/SCnQwMx4VzamiyaJbIPoltHvNzYKVZTz1yR0Sah08xYFo
 NFJcRS8Oj0Qv2M0RhZw+9Nqon38n8+PwyJRranbX5eAcfEQxTg1xOfZm//8MEQQ=
X-Gm-Gg: ASbGncsJf5G151IXQ5wqYmO1orGufiGCUbn0sbDPKW4mc1ljwjA2HYxu89bsVLhEcEo
 +6bA8m13PIXhrvDBgH/0uxI9+O5hLKeHoQzG6Ib3zAwo0jKoc+NzsWp+yQenvzT2yJdaSHF8AOu
 MQ3kM0LnbLjhHq+GRlBOEY0fm74dWJ9B1qXuNXv3mXuEgUeYmxJ6xXY/ruqJNM/ILSs9ly6bjhp
 xuU++JWJhpSWgWZ2HsY+FHv48bQaLI0PSYcmQd7XKhIPi1tn7Zebqh76lESZGm3W2kGosVTTaaa
 UBkorOgu5tEdbGvr+e6/M9szNqrx/lIZrNu5R2r9Bq86WS08g0EwTEPUe8apOK7q5MHO4Zt8FK8
 +0BS1xgQ=
X-Google-Smtp-Source: AGHT+IFoBxe2DZWgkVAHcucJCGrG3ZLN/dT4JrPNYQVEAuSwRAoP0fHb5trrXL+sMuISG7evBmLnFg==
X-Received: by 2002:a05:6a21:3390:b0:1f5:6d6f:28e with SMTP id
 adf61e73a8af0-20bd8644d34mr3612391637.42.1746113535710; 
 Thu, 01 May 2025 08:32:15 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404eeb11b6sm946606b3a.2.2025.05.01.08.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:32:15 -0700 (PDT)
Message-ID: <0f81e684-4da0-4e6e-8e88-7a9f9fde24f8@linaro.org>
Date: Thu, 1 May 2025 08:32:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/33] target/arm/ptw: replace target_ulong with
 uint64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-30-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-30-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index d0a53d0987f..424d1b54275 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>       uint64_t ttbr;
>       hwaddr descaddr, indexmask, indexmask_grainsize;
>       uint32_t tableattrs;
> -    target_ulong page_size;
> +    uint64_t page_size;
>       uint64_t attrs;
>       int32_t stride;
>       int addrsize, inputsize, outputsize;
> @@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>        * validation to do here.
>        */
>       if (inputsize < addrsize) {
> -        target_ulong top_bits = sextract64(address, inputsize,
> +        uint64_t top_bits = sextract64(address, inputsize,
>                                              addrsize - inputsize);
>           if (-top_bits != param.select) {
>               /* The gap between the two regions is a Translation fault */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

