Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA7DC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACQp-0001B5-UR; Wed, 30 Apr 2025 14:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACQo-00017L-0w
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:45:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACQm-0007v3-AS
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:45:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso359054b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038715; x=1746643515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fsQTa6aM8pUm6+W+yQoeVEUdk05s2En8LozWleTdmgY=;
 b=gbukrHWIohVrI3n48L0lROw8RqJTsI11LVSfxlWcUYMJCQI8fV93hd2ixIyyrW+K30
 afd1ZtAo3KpRYRU/1GZnbcSIAM7fx7aHqxqR3KLJBRFOgB0Jc/Ttdm7x+dTrxvKgrQJt
 TA6q/BFavOCkQkCVIG9YbXciSjBTO+kayYeiOi4m8lcV1mLck0KwnXIZmNRDuACsHAzz
 5cnU3a232NjQQbvPDv58LMfGJkSfsGcZs/Dsdiuox3723628/ziPiL9NsJTY0jVKM+Ex
 DcN1lK1tcqMQi9vkpLzz68j4eymfZUS6EubNnLtUspQrN47DUmIMiPYg/idPF94G/rVY
 k9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038715; x=1746643515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fsQTa6aM8pUm6+W+yQoeVEUdk05s2En8LozWleTdmgY=;
 b=W/4xQ5VpX9thd+tuf34xjK1vrXT0no0URJKpiJJbyBgbn9TBcPMR2EvZFYUHqNbMDY
 +G0YQjJmkfvMwxu16w4YAAY4XsNWDh2Le3/rClpvwgxSOYM3vPBb07tf13SDwFKgLL3h
 4NxX/DUiEkzWujxdwYM2BNWWnreR910JNFAh12289DkmNEpJCyOS/p8ZBzn/e3ynv9Ad
 0OhdaWLMJ43JvvaBl+1IFNWepw/sG3roou5j7skEbqiCDHu7x5bbppWzwOk4ZO33TuBd
 JaPO/yF2yYe+NEyihJziLD6VnvwEiDbwpQkpnuD+g+EhjxftJJVd0izIqP12W/PPC9qH
 7CRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9mfLCS5Mq2QYLShWkHSvEGszkOhRYDZPLKTEtJE2lUnz6olZ56alAdfMGUVI5hHasi7N+RKCAqst/@nongnu.org
X-Gm-Message-State: AOJu0YxnfuRAND8ND0uQXer6mckW3juZsCQ75QApeJM7ZGC/i8EciVLa
 CJkTJJbhSAqybk959/IfhEaj/hvTBkn4NvAgyL5eCStmqozP7iAGu4FPl/CwgbU=
X-Gm-Gg: ASbGncvpKT0kWU2s8Pa93yfnmu2XoWKTaw934jivYRW67yQacNRxQMG/l5EA3bqNHxZ
 KuzMNS0rekWUL//HYklchCHhUCW4FZvrE5vd/GDfNjlCDbFYpEcnz+p2PJSBif64+Q+aiGRX2ve
 B2T+41dcBwYn9bozBIxI19ySPN2YqD26EqLXf66aNd56BaBiDL+MLMr5MBf9CgC+FcaHkNUshSi
 N4hTPB5MX7Yi6nZpfyLyLe/Bn+NAvgZDWROx5eCHfEXENR+3PGsUioYtSkvcCzG7Go2B2uo99wQ
 UpJ6ekj2DVCTeztdQ8RrGV7WTHb5kq4ej+ev/0vPa7cACMze2OayErvHemEcBCi5m92b6zvjB4/
 WTp7ZdBw=
X-Google-Smtp-Source: AGHT+IHtC2XOyb5ncAh/Gm1bPrXbAXsePWuOtbVjsr2pTjPf8jIhNQ0VPaT8JV5fxgSAeyHrhuC3lA==
X-Received: by 2002:a05:6a00:1312:b0:736:6043:69f9 with SMTP id
 d2e1a72fcca58-7404790137cmr19770b3a.19.1746038714831; 
 Wed, 30 Apr 2025 11:45:14 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740398f9a6csm2038201b3a.7.2025.04.30.11.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:45:14 -0700 (PDT)
Message-ID: <f076ffe9-09fa-4704-a816-98c5bae61dbc@linaro.org>
Date: Wed, 30 Apr 2025 11:45:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.c | 11 -----------
>   1 file changed, 11 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 37b11e8866f..00ae2778058 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>   #endif
>   }
>   
> -#ifdef TARGET_AARCH64
> -
>   static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
> @@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       }
>   }
>   
> -#else
> -
> -static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> -{
> -    g_assert_not_reached();
> -}
> -
> -#endif
> -
>   static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);


