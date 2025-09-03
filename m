Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76E1CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmty-00041h-D7; Wed, 03 Sep 2025 08:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmtn-0003tG-Vy
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:47:40 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmtm-00006m-H0
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:47:39 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-61ded2712f4so5917570a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756903656; x=1757508456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7S/LmPrUf8OTa/1fKX8Ki+2e12aBrBZZ85MNAYc3XN4=;
 b=B7esMSlpl6des13Y9IKOdqhrPaRjj3wqHjstNhsjb1WSkwe9c4xWqrlQFjzZt8nbXd
 snJbfMMJg2lDpDmMZXtUPWqAPJdicwbpD2OEVLI6xHU8S5on23nDEXHLG835z4SIvY+c
 5fDg6FjMZQXmwc5M0TGrPdsZ7H21rqMqb9GP5lKdkMJqBPnaM2GBJigWP7wL0105qCom
 hYRc/hw7GnK37v+YdlLJj9TjZK+dBnFybsS31wwFAxUUdE1rBSN0yOY8HskvFWP3DNtj
 eEX9Da+kuqBvpRZUu7jeYAxaybJSqWt04ToeGjT5ZBSnJgKb9F8HQo3lZE0fVou+zQnf
 r8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756903656; x=1757508456;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7S/LmPrUf8OTa/1fKX8Ki+2e12aBrBZZ85MNAYc3XN4=;
 b=XCVnH2phafSIN+Z5z5hf/rOWyL3uc7Hf2JssrTTDQgHrL+AV+Sxeqh2tdlXZuGxRSI
 AbxGrry4zWDK5lmkyJNC51KroHGOlAEaGuy0m3lJG72GyNbFFtMYqe6PY9syfODrulh4
 jHyDGyV7tuvTntld4k/Nzd16gZwu/GHkokQ4UR6XKc6xEfNJakZQctk5W/+ee+VFKno1
 FxQ3nz1fVqoKLvgahUUUlaTEwL/KIh6DK6Y30iKeEX+2iy1I7Z61YTaXXhwiECgIZ2HU
 /n0okh7/DbY2fxVZKBF7PDj+Er7HamL3jgWmQXvZMtS7whby0J7ydZq3vs43qEHhbBIm
 RMBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFV/Ai7l/E2Da5j+bIVSKZLu82gMhgwWDUrr222b1ZZYqHp5cak5iHDE9QBO7ArZyouIVKDausNGl0@nongnu.org
X-Gm-Message-State: AOJu0YwyU5oU/1jZOUuN4P8C37ZcY9biRW7CowxlSC/tGSFjiPH91A4q
 8BzUzzqRVQbHl35bedjWLcNbpb4crvtMwpsv64kX7DPtVoph0wEOUK0k1XA3eIMxGwc=
X-Gm-Gg: ASbGncsScdXcIAXP+fv1Aq7+aIUh5YcRsqqzZDbED7tRx5bSdNMhgtkwmVZn4YNZ5DJ
 L9u3S1m2z/9TW7toCZHM/nWMMFlHmsgg2HN/xailbTjvT/lfA4j+ioHXWhhh6ESixDpgJLf8B+0
 uLvKIeAhKZoEnljLTyZ/HeXO5joykpVncOpBkKl96DJj3yRNu8MhlZVD0Iu+KNiWehd7esan5DR
 n2v3aLiXfBENzfw42lRJ+eS11uqYK0EQz/O7uyAazT+o7bXOKFOJ0CcNrY/83KbzSQpq4hjtu7c
 PHesGnOgN9xuduplUm3IWcJ/d71iSGv3EJr7AdWzEU2rKrQQcRB8xagPVmxFshrAeGWlJeiI7fH
 yxRXqf7GU6kOO75afkGyXjTdiq2iayxL6MpyyZ2OsKdeWUFZoYsWcKtptCiBtV0t6vS0PXtCTTr
 Es6awl5g==
X-Google-Smtp-Source: AGHT+IHmTDUI3qzHu8h/EKwFplCXnKt6PHGJ+EkkTJYMhhF+67ZO9LQvbgEeZrCf+1vG63P8tlu42Q==
X-Received: by 2002:a05:6402:43cf:b0:61c:5d76:3a8b with SMTP id
 4fb4d7f45d1cf-61d26db48a6mr11685745a12.32.1756903656342; 
 Wed, 03 Sep 2025 05:47:36 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61eaf588377sm5147405a12.15.2025.09.03.05.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:47:35 -0700 (PDT)
Message-ID: <dd8ee31f-9ca6-40a5-b5ab-f548fc95319c@linaro.org>
Date: Wed, 3 Sep 2025 14:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] target/arm/hvf: Factor hvf_handle_vmexit() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> +/* Must be called by the owning thread */
> +static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
>   {
>       ARMCPU *arm_cpu = ARM_CPU(cpu);

Likewise don't double-cast.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

