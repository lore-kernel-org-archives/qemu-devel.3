Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F0C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIJt-0007Np-64; Fri, 25 Jul 2025 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ufIJr-0007IY-BB
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:18:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ufIJp-0005RE-GF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:18:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so1396253f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753449515; x=1754054315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l/fasLajEXfR8f6aYZdkSFrtQoIABhB180kDg2jNhno=;
 b=DTpXbKY7Gsxr4K3WHC/3Z1PgcPXdiV3F7bnvcMq3Wdu4GUJ3D7rW3evlngH0LotGuc
 Lx0Za0kwUxui+6KpwtYhLI5CXm5Vl57OfhACrTtjgwSr5hLBZ9IXiGjvGXrC30eM347G
 Yl7Q6Pzh526VidgZy55lvf/dN+U8cja85/OuqM1gBLmT1652PC6MbTw1cdZ4yOjeESdh
 E2YKKdRtfTgRKpWxCvb8qY8ZPjQaTkVHBVbyJGyQlQRQhNB5XvCMUv0UAQ9NvXpciA/E
 fWOKEIum7kehG6yQgsSpF7HOplgMYdGDToGV49dNG2VhTpwgOM1dc7S6y0jMUxHkeU33
 f9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449515; x=1754054315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/fasLajEXfR8f6aYZdkSFrtQoIABhB180kDg2jNhno=;
 b=Ce2OydMGSA190jMAW+6wMEpzmhyHuxUez2eYqp2jJ4QekArpT4Q5I7o72dRYDmyUT8
 sO/aj4kSNsyE2Ro3Ze86kGYkmDFb5Lc5O7YczkIIWJNWmYZz+TxWEdLFT2IE4ygKGO/I
 XNPLjZdRCR7wYbP1wvmqH+kJafk/Aty1rWSccOExajrmVGQqc8uKgXHZHNpxa4v/ua9j
 n94jgoGt2D8gKUxhpO+pq580FCD0pPkJb1drzFPCqAnIqOy6wkp8p1h665ibqiYGL3/5
 A51AHnq9K7OndEB/8WHGdMjFPtwBtY3djcor7SE9zFcsiSRZ1LGdDIaIvJtrIK0ivT7F
 jEtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkdTdg8dcBlcq1zx5oMF/Tw8oKTMg66PiNNYV48vaYvn9lGAoct+Lt2TB8xrq/YZCAoMMecKBH9fow@nongnu.org
X-Gm-Message-State: AOJu0YwcvWfZn1gbQwsBlQkLJ1eNqcHSZzYBHCqlWgRHYe/ijSbmM0T5
 DaYCdSUKMZavZLDAxa52bPBwDu6/2sTPzRp8cnkqWm2n+5fEvwlqirt7iw+Rozji5lQnM6m5W8d
 Ea9fd
X-Gm-Gg: ASbGncs5qhouuOZu47NlN2HnpQPfIlzv7XWx1YBfcuEbID7kWqT0H9fe6H8t7tN59M/
 V0hrCm1Oll+D1kvqTxsDrL5BGwvdJ/OYwTW+ZXHUWcCOMqRtcMLcQXghrtxaSD47OrXnfl12MCD
 OMl3530jdHYzkUONMfszB89irw4/g+Y5HZZkJbNLW/0qgt/x/EDiDtGgGXnyIoqpE6LAPUxCluG
 XiO1FTbzjhRNDG4TnqSBdr/I4S4sZl5Weel5SnWoWEMiL+DpY61eeDYK2AYftt2uD9peN3i7hi6
 4XhjUvDmaZHqpRCqroQL5CN4MuQ37shBIRmfFLHzroY97l0cliSAzMW4AmlbsVJCQmh4he1LLoq
 H1ZsATFrWr1aHUstT1Alg+MfYMA3wKD6nquVkKmQPy19Q+/grQhunERBUEbB/osn3Zw==
X-Google-Smtp-Source: AGHT+IGYZ6x/pz3Cm6CCCp3XNwtOo89b8BDosvEZ581wOiUG0k7YNRWpmLxxySb4Mc+0jSwm/4JC1g==
X-Received: by 2002:a05:6000:1ac5:b0:3b4:9ade:4e8a with SMTP id
 ffacd0b85a97d-3b77666023fmr2354242f8f.21.1753449515312; 
 Fri, 25 Jul 2025 06:18:35 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcb87b9sm4952974f8f.66.2025.07.25.06.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 06:18:34 -0700 (PDT)
Message-ID: <17254b66-4902-4ee0-8c9a-4082146255e3@linaro.org>
Date: Fri, 25 Jul 2025 15:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Clean up of register field definitions
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org
References: <20250725014755.2122579-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250725014755.2122579-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Gustavo,

On 25/7/25 03:47, Gustavo Romero wrote:
> Clean up the definitions of NSW and NSA fields in the VTCR register.
> These two fields are already defined properly using FIELD() so they are
> actually duplications. Also, define the NSW and NSA fields in the
> VSTCR register using FIELD() and remove their definitions based on VTCR
> fields.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/arm/internals.h | 8 +++-----
>   target/arm/ptw.c       | 8 ++++----
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index c4765e4489..052f7b641c 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -113,11 +113,6 @@ FIELD(DBGWCR, WT, 20, 1)
>   FIELD(DBGWCR, MASK, 24, 5)
>   FIELD(DBGWCR, SSCE, 29, 1)
>   
> -#define VTCR_NSW (1u << 29)
> -#define VTCR_NSA (1u << 30)
> -#define VSTCR_SW VTCR_NSW
> -#define VSTCR_SA VTCR_NSA
> -
>   /* Bit definitions for CPACR (AArch32 only) */
>   FIELD(CPACR, CP10, 20, 2)
>   FIELD(CPACR, CP11, 22, 2)
> @@ -220,6 +215,9 @@ FIELD(VTCR, NSA, 30, 1)
>   FIELD(VTCR, DS, 32, 1)
>   FIELD(VTCR, SL2, 33, 1)
>   
> +FIELD(VSTCR, SW, 29, 1)
> +FIELD(VSTCR, SA, 30, 1)
> +
>   #define HCRX_ENAS0    (1ULL << 0)
>   #define HCRX_ENALS    (1ULL << 1)
>   #define HCRX_ENASR    (1ULL << 2)
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 561bf2678e..ed5c728eab 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -193,9 +193,9 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
>           return ARMMMUIdx_Phys_Realm;
>       case ARMSS_Secure:
>           if (stage2idx == ARMMMUIdx_Stage2_S) {
> -            s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
> +            s2walk_secure = !(env->cp15.vstcr_el2 & R_VSTCR_SW_MASK);

FYI register API provides helper macros:

             s2walk_secure = !FIELD_EX32(env->cp15.vstcr_el2, VSTCR, SW);


