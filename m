Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F0C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzd8E-0007G9-45; Tue, 01 Apr 2025 11:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzd8C-0007FR-TY
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:02:24 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzd8A-0002kf-RA
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:02:24 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c764f2c223so1425223fac.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743519741; x=1744124541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SUPsPwGxfHLY5jNpys9gEFxOkP860CdegHkTsUnC8r8=;
 b=wcfFfKb+m/bmbsbruqyE9TsmKnXGwoKpnLITcCjXw5mMQBTPHhdOz0iDnBJhuBr22e
 gAcB0WarMAauiWQQiGfepHXSKtO8MJzxW0ws5kzhYlP5bVvV5exhlVqeLvBZRuxrNxsQ
 0IvqaImf6dsCS/2dUqc+fdLp+S3gybJYxz94Na9Zyn5gkcOvs/rq3d7Q+bQmUh00akOC
 QnKlN1zarr4pgZuCocBGdlmwzGKNI64XtGK4YQYBch34OdJCJnQI9AH3hkJkIMTn7ArV
 2MxJmuV09pz5ppWleWeFolzJjZDVvp51KWXmgwnfNNia4W0ek3tJwG5d9jQs+2wClHKs
 fbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743519741; x=1744124541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUPsPwGxfHLY5jNpys9gEFxOkP860CdegHkTsUnC8r8=;
 b=UAKNEs8ODkZ6D9nisXbqt64+eFsLTqcu5qAZ1CgHa+6Go3IkA7wxUG9223U/hlSm8P
 +N9A2mmVWE9zdHTOTQedF3tYFlkHxTdOXKg8UnL4viWEyKlT4z8ir9rsSiaiiufqszp8
 6dIyP4F8S8z6IxljfZlfD+Dy0s/Q3NBm9XUfvFDcxzgPF9vKLTzvfQBajYs3+rKyPFqg
 d//ovLKH/NK2D3gnfwRKJfxWez9nJPmCQN9TcJLTWlXWX1vvGerPG94Hazyw5zm6GUXp
 HiS/CX0z3NVd81ZbPjvmgOeekyl3YwEXGhPsiiTqGzh0QG029TxHYx+AIv+iPENOyBMH
 0nLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4HeaXLl7wtVyCvHM8qVt0tnF/E0AQFoipeP+m11EDGnMgOvszgkp34q82T6i2DJYwB41WsxjQVnZg@nongnu.org
X-Gm-Message-State: AOJu0YxyFYXw6IK9BCP5Fuzi115WFcr4x73jhpuuQTaxv3PkR13yQ1IB
 5EIJv3y+OJZtLnJ2bZ37gkyOoJPtv7USR0sw69B/8r7AA2aZQtQFfzQgRP5Z6eU=
X-Gm-Gg: ASbGncsv4qh68eXTilfGVJL37kLoDTLgNCEwtmdgXPJUnK5cvsHuDDcOnWqBQ8JD8nY
 J9mOU+Z5YSQv0N207PnW55QyND0B0LUmYibkuAaZcBVfcPVcHuo1QmQeb0aHClMXLK4sv+E0vQD
 Vv83jsxz5ytb5mZd0Ujk0lczWKM8QGE4cWa8ZbOintgS9VDat+4mYBH5ugg4kEO5Ztkrp2CCSNI
 um0gnryXe1lXxFIAhH8LeVqCR0A/CbhVAb3mmAM5kZ8txz8uOtROuRZponDp1vg8T8EAdRW+590
 92Q98AmUgYltJnZEnwZwHDQFcgDb/wT+bqCdx7uwYEm++QdAww2AqIvbtg+A7QOfB1p1lZovgzA
 VkpWcL0QeVMM0ZjkEMTLg2w==
X-Google-Smtp-Source: AGHT+IF9u0FGX551DEI1DSkEqx2UEg4co/ms3icW1X0Kic8HpfgaAE6XjC7bwEHhw+aUYrjfZDDyKg==
X-Received: by 2002:a05:6870:8a09:b0:29e:6f32:6d91 with SMTP id
 586e51a60fabf-2cbcf8060c7mr7685073fac.33.1743519740863; 
 Tue, 01 Apr 2025 08:02:20 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a3f3dc8sm2333691fac.8.2025.04.01.08.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 08:02:20 -0700 (PDT)
Message-ID: <3d1e544c-5e26-4690-b8d0-d25a34c0c7fe@linaro.org>
Date: Tue, 1 Apr 2025 10:02:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] tcg: Allocate TEMP_VAL_MEM frame in temp_load()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Helge Konetzka <hk@zapateado.de>
References: <20250401144332.41615-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401144332.41615-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 4/1/25 09:43, Philippe Mathieu-Daudé wrote:
> Be sure to allocate the temp frame if it wasn't.
> 
> Fixes: c896fe29d6c ("TCG code generator")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Reported-by: Helge Konetzka <hk@zapateado.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2891
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2899
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/tcg.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e8950df2ad3..dfd48b82642 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4671,6 +4671,9 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
>           ts->mem_coherent = 0;
>           break;
>       case TEMP_VAL_MEM:
> +        if (!ts->mem_allocated) {
> +            temp_allocate_frame(s, ts);
> +        }
>           reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
>                               preferred_regs, ts->indirect_base);
>           tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);

I suspect this is a read from a temporary that is uninitialized.  Ordinarily the stack 
slot would have been allocated by the store.

I guess I should have a look at the testcase...


r~


