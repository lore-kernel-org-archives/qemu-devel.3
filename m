Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC27FC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLH4-00087Q-Lx; Thu, 03 Jul 2025 10:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXLGZ-00080l-UZ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:50:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXLGW-0006vW-Ox
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:50:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so7480605e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751554210; x=1752159010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hR1eMIb4LPiCsHEVHY3I5i1T1yeKzcBgMic5GN3xhe8=;
 b=IStXaUPENiT7qSy0SLVnnY9QTSHosy0ojOp3r8ZTOFa3yQFSibndoACuxaqj4V+cof
 amBvQtVX8hZ3H71Th5fApVAaEv3Sbq7IsHxuHSjEb2f3VA4cKGVnwQm0CiXftDpx9Oin
 rGHVTs6JEi2LlaLL6tfxSAX7u745IgBpdowg/Q6HJHl3rE2vuzrF6CbBknC0t4XCjDjg
 Y4aItrK15k0lbUYP/NqlUPaPjXMfU19moia1PJGB6jX3upB3wRpYog9i0VjM8XS+pRhM
 19uZcBIl5s6/oTH2W0JQ7eDEBCDfvoUIUB6Sf+4PmhiG5577UkY0HXW+CrYG9FUb5PMv
 YQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751554210; x=1752159010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hR1eMIb4LPiCsHEVHY3I5i1T1yeKzcBgMic5GN3xhe8=;
 b=wC445802XCwVsLLYCIDcefVPn95TjolIIiS9fdJYrlBiE92r6t1J4c6kfflc4TPhsz
 yX19zXCVhuOxDVeQzZOTuN7auWaaByawSLQRNDn+tAW/1F6n/qD4xuPyZUvT2a9OqIyO
 eytpN02R25uvBmlXAbS/8FBEiumHJWNTbjnKeXO+EcINgNccpg5ZtDqOC8bkVXHEms4B
 IsAYvkrGUIaowTJQLfBLghx4dRBOzzXEiY8JARCC0m0o6my0DOcBTwrTdnjpnEq8X4Nn
 tbM9/oWoZXVQYkYqL5v3AfCBITcS/6oFPHS2dkhb10hJIMneqw6SA48Hi8Qg99wkUoGr
 yD9w==
X-Gm-Message-State: AOJu0Yzd7O0cznLiJvCc3TM8FGyuNAmS957+sryQ3El1M6sVdpD1bDHl
 AT49D0Awobx9Q8d4hXxGa94CpXMoXeiE3nWuKK7rBKa7iJ/5DONzEpqGYQITCXBajW9mxYSrPDP
 Y8W8Q/nE=
X-Gm-Gg: ASbGncvuxQlyECRum59e1roxWltCDoXgnyzybe0o3WOh8vQjDtW4DiVaqA4TX5FBp5a
 S6U+rXejN7OfUkMs1ZGRo8p3MFzo5HtEv9+3tkYxPks3CXg626ZhyYhdAABcKAbsUvhTd5r7fvI
 MwY73+otTNAVHj6FX6xm3NUZeFwo7oFhVZVDSc76gA2AMPiniczhNAJUwqYgLMkRDbwpN8Tn/Ss
 rM+BDQNvsByAS+rMMDau9aE4+XljH9vzxDmMrfT4oiw9aH2kP62GEy8b5DxgWzOXKZcnq9iZWVQ
 ZXXgKB9tGYPeTw9khoWxWbIFD6OFyoMiucr/6hQl3vSpFT0G284JWewnuA8CQaTIPxaGzo/WeZY
 DhBWogC3PBtubGi9D3H/4rLsdQRuaCHueufAgRWrV
X-Google-Smtp-Source: AGHT+IEJS52ksXPoSSMORIw5HdnklhB8TGerbP9Z7G+RRa11LqUNfOSNCl/2xUOUio4JfnlAUReEVQ==
X-Received: by 2002:a05:600c:a31c:b0:453:92e:a459 with SMTP id
 5b1f17b1804b1-454b01ad46amr11043425e9.16.1751554209719; 
 Thu, 03 Jul 2025 07:50:09 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde954sm28359795e9.33.2025.07.03.07.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 07:50:09 -0700 (PDT)
Message-ID: <9dc5921c-5698-42fb-81f7-efc98032e6a8@linaro.org>
Date: Thu, 3 Jul 2025 16:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/69] accel: Move cpu_common_[un]realize()
 declarations to AccelOpsClass
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-21-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703105540.67664-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/7/25 12:54, Philippe Mathieu-Daudé wrote:
> AccelClass is for methods dealing with AccelState.
> When dealing with vCPUs, we want AccelOpsClass.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/accel.h       |  2 --
>   include/system/accel-ops.h |  2 ++
>   accel/accel-common.c       | 10 ++++++----
>   accel/tcg/tcg-accel-ops.c  |  3 +++
>   accel/tcg/tcg-all.c        |  2 --
>   5 files changed, 11 insertions(+), 8 deletions(-)


> diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
> index d854b84a66a..fb199dc78f0 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -34,6 +34,8 @@ struct AccelOpsClass {
>       /* initialization function called when accel is chosen */
>       void (*ops_init)(AccelClass *ac);
>   
> +    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
> +    void (*cpu_common_unrealize)(CPUState *cpu);
>       bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
>       void (*cpu_reset_hold)(CPUState *cpu);
>   
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 1d04610f55e..d1a5f3ca3df 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -102,10 +102,12 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
>       }
>   
>       /* generic realization */
> -    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
> +    if (acc->ops->cpu_common_realize
> +        && !acc->ops->cpu_common_realize(cpu, errp)) {

Unfortunately this breaks user binaries, since AccelOpsClass -- which is
declared in system/accel-ops.h -- is system-only.

This is the same design flow we have with the cpu_reset_hold() handler
not being called on user mode.

>           return false;
>       }
> -    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
> +    if (acc->ops->cpu_target_realize
> +        && !acc->ops->cpu_target_realize(cpu, errp)) {
>           return false;
>       }
>   
> @@ -118,8 +120,8 @@ void accel_cpu_common_unrealize(CPUState *cpu)
>       AccelClass *acc = ACCEL_GET_CLASS(accel);
>   
>       /* generic unrealization */
> -    if (acc->cpu_common_unrealize) {
> -        acc->cpu_common_unrealize(cpu);
> +    if (acc->ops->cpu_common_unrealize) {
> +        acc->ops->cpu_common_unrealize(cpu);
>       }
>   }


