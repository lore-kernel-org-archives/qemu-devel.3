Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045A8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEma3-0002xu-RJ; Tue, 13 May 2025 06:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmZk-0002iO-If
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:09:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmZh-0007zZ-Hw
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:09:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a0b135d18eso3121114f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130964; x=1747735764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qAj39my+7Ge5Cp7+If3CmQHkrz/P16jjralaU9o8Ftk=;
 b=c34S3gK3tU15WNSCUaKu83p5hCRXXBdnlWyva8g8wE0ImHs2m3oD4LYqXT3bhc9HLY
 qAOiVhtbKbKENS64W2K7uvq3v036VDwZPsrU1bxp1r+gDSnb8jdxuBf1ngxFZvMO/gYA
 b+OFzTJntc2GNAmoipjV3ekfgDT37CnOGERZcWyzOHA2B8WvpXh8J6i/k8cGGJcsSglt
 ocZY59C//l5NCXOVXap9W0m1ZBjWGOaXcKMQJBJWnotkFeCuMGl+VHgHneX2v9wBh8Vm
 aNU/bjwks+NJGXRjCz3FrBk1EUZh8UiVb6aqMeZFTg08iMgjzUUmk+PcO3y2lgAnqNCn
 Fqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130964; x=1747735764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qAj39my+7Ge5Cp7+If3CmQHkrz/P16jjralaU9o8Ftk=;
 b=q4blCEPy8T7S2N/8YdoAaliL4ckxsAFcISs4nKYM+Mvmn2/V/JoKEIl+CEOOyMVHcO
 e1KPE+lsrRsDfDC5exRYwQJ/+CdSP3L8Tty3GDp4B36mi2uepj7Gb9VOkwT8UbhKZi+0
 EklnP6dFdPhjK7VdUaTFXurbOJ8SEIOxYVmjjjLtTDV578XMEmi/XvZpT4fze2LPV1GZ
 bCbMnw6ra73sQqxSEP5zPywA6CH07V7Tbv35vcLKKneGcjxJeRXRL8TEcZIWWNpFbUuM
 cSmMQTgbgnhZVO5obENhi65VzXXxpBw1spamiF0qtmp+guAeepFzzyOOAK+R17Td4kYs
 6lUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMY6x2H8O45iYk03KdpXfX4vaSeOPFqqsai0jjgzGRHyAILEjiWCU4GgBAAIeU72+13pLZghcU978M@nongnu.org
X-Gm-Message-State: AOJu0YzD8hKx567jx2PWY0QHZE/bn/k9uoy18Dbxa8FPYb3OEcWQJSTh
 C3sRJ0uMAsMaY+WChowHHrSO7yt5mPMNL3fOiOoZarkPPhY0PUZDHxoSqHp0D6Y=
X-Gm-Gg: ASbGnct5GlW33+PdN8o3MWPIwOErL1IpigRyDl9vwP+IXbFwcNy2R5emAX03d5LpYzg
 p7qq/QS+hHH5dIzABzxyQEVrq3NT/dS/bLB2K2LsxKlvuujEwLRpVR06QcVMsOwUW/Mbom7ZzwK
 dn+gR85Ge2QStFmznk6fYgTXwKNOnugEQepC2wfvrBBZVbxsO2F3hU0jjs1AK1miCn1XnNx9qcB
 4VHShsp5KyBtPmDmCu6lDEccIZEzW8jd4otdadtsNwh8uthHqc4xZqztgt0POGsRJ8O+WZiX5eS
 emz1jA5XMzo6VPZg/vvd0QwGQdfVwIjPFZSqNUcTD+U7x1Ozy61Qlza19Tmahon9DRA/yTHecmH
 kepbr7i0aeMvl0aLd/g==
X-Google-Smtp-Source: AGHT+IEUHm1wZNdfyUY8NiVVrmc8c22MR+Lj4Y4EqfglE9tVmzbAAQqqaSGPkDQdsGEihgYnq0Ecxw==
X-Received: by 2002:a5d:59ae:0:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3a1f6421bd5mr14438192f8f.2.1747130963996; 
 Tue, 13 May 2025 03:09:23 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2b29sm15846995f8f.53.2025.05.13.03.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:09:23 -0700 (PDT)
Message-ID: <59b505e1-3cc7-4308-a546-d9c4663c5333@linaro.org>
Date: Tue, 13 May 2025 11:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 29/48] target/arm/ptw: replace target_ulong with int64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-30-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-30-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi Pierrick,

On 12/5/25 20:04, Pierrick Bouvier wrote:
> sextract64 returns a signed value.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 89979c07e5a..68ec3f5e755 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>       uint64_t ttbr;
>       hwaddr descaddr, indexmask, indexmask_grainsize;
>       uint32_t tableattrs;
> -    target_ulong page_size;
> +    uint64_t page_size;

Subject mentions int64_t, description mentions signed,
but patch uses unsigned uint64_t, is that expected?

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


