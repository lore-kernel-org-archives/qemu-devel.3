Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3139CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gRc-0003fE-Jo; Tue, 14 Oct 2025 10:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8gRa-0003es-4N
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:56:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8gRX-0003Oy-MC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:56:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso3235771b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760453762; x=1761058562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jEUu8iAjg0qFf7fVbccEIesXFK7DU9RWuhhi3V2lIJk=;
 b=hv3k1rCak8S7/aZLiNlFN5JZH8m8U9fptVSaZbSSxtQmxwAkNaRX2TPv0tc7PXtGFX
 AExKBBTglXbzDgEtIPtGYGXDHOMtyoRx0gpzBvvDbQsHsEe08/9B7zXiRKoE/okBFque
 Oopkicm7WuJg0qmW/67s8CGVipNt7XoahYa5zqmz7cS1QnbqAR2tYnOrY0qvK1aYd5So
 mNZk/aKgUkVa6Pjs1bvINXTihX63q0nfa0l6miaOY71/ZqqymcSDtNCysBNdI2zp/GyP
 W7UHaK9fvTLC6oIUwVvyBPuVTRHrBukyhWh7ut4wvd94ne+nCL41RjXqYU3ciTU2Ln3Q
 SZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760453762; x=1761058562;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jEUu8iAjg0qFf7fVbccEIesXFK7DU9RWuhhi3V2lIJk=;
 b=hTiLKxl9zTsfQmIKFzG0/Ea05ynpE6owxyJ/Izt+My+lAatPK4GqqA7rTHNAmQG9ki
 ezB9KgW6P+3tDOVcO3m4Yg/CPX68lmgtN4Vv0VdBQUKqwsaEjpIHGH+mCo8mteJZA4y6
 A14V38pgaAjTTZppIlebQQHJQLdPjtuVqIClf9mqUHeQ34NFvtPbJMBeE9vGEgALLu15
 qXRLeFbt22RXy4YBMA/+b00V0i1v7NdMnOSisVo+zdpdZe0vwAQd9kOSx29mXlurUIIZ
 JznZ01DdgAsqKzLxwybsd0kcZlu6VxbNRuslg/Su1zC8+Is7r2e/Zr0ztrXk5dh6Fu7N
 qxSw==
X-Gm-Message-State: AOJu0Yz4sP6zGwOcfeAqwhtT09yvw8TtT7appBmxuK+aJVcbptf3l0OC
 J3bkHGqlLAvdIFWbHgKUEhyNnWkuV6SHrY+fM2x7gY7NIyPuJCGHz1KCxrs54yu6o3EeU5nWjQw
 CliaZ0/4=
X-Gm-Gg: ASbGnctQ3MKV2jPNzlwK0gUa0ZUzHgnHZRxVBxcSgvG+Iu8U5yMVZb8K5E8TwXgEIVI
 XDoN95IqkTYiAvjI/TYCyvmUvuoHNWJcf4f1otQHvWJPTWqppES0c6NMuwtY+b+8dCsUNhHD8Gj
 ppJ1jISwqPYR5wwlSAxFZ6d1LeXYiy4WvMNOX4FCUE2Ud1mOy7mnRZt6NTZFi8OLsl3Gy5bhzdH
 NN2mNhL3f7StlY1XKXLRzMnuqjlqTeXADgP+8yFVXb6ZcvnzUZY5cwpXcgjOIcj9RpmDAjszGNM
 yg+VGL3cBDhBm5ylsKD1CYPAEonU+j406V72aqXwWSAqICpllXYqOAjo8fziHV1758rYzj4mCbD
 gBsa4BY0TUsAt1coPX/Tm7ArIxADVJrSQEMdSDRh16d8upUREluhQckyT7rAEx2kVhUUpSA==
X-Google-Smtp-Source: AGHT+IGp3Ip4eidSuWz0CvgR9okMkzMBpjOQcOHBfdCe4kdEG9n53q/CpFxh9qaLrRt/zM5IAILH0g==
X-Received: by 2002:a05:6a21:3393:b0:32b:83ae:567d with SMTP id
 adf61e73a8af0-32da812f3b3mr31392370637.21.1760453761419; 
 Tue, 14 Oct 2025 07:56:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0e2c6csm15299585b3a.57.2025.10.14.07.56.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 07:56:01 -0700 (PDT)
Message-ID: <7060e943-3aa4-42a3-9f94-6250c9821ae2@linaro.org>
Date: Tue, 14 Oct 2025 07:55:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
To: qemu-devel@nongnu.org
References: <20251013161040.216819-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251013161040.216819-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 10/13/25 09:10, Peter Maydell wrote:
> In commit bd8e9ddf6f6 ("target/arm: Refactor default generic timer
> frequency handling") we changed how we initialized the generic timer
> frequency as reported in the CNTFRQ_EL0 register.  As part of that,
> we chanegd the linux-user version of the CNTFRQ_EL0 sysreg from
> having a constant value set at compile time through the .resetvalue
> field to having a reset value which we compute in a .resetfn.
> 
> This accidentally broke the reading of CNTFRQ_EL0 in linux-user mode,
> because the cpreg is marked as ARM_CP_CONST, which means we translate
> it as a read of the compile-time constant value in the .resetvalue
> field.  This is now zero, so userspace sees a 0 frequency value.
> 
> Fix the bug by dropping the ARM_CP_CONST marking.  This will cause us
> to translate the read as a load of the value from the CPU state
> struct cp15.c14_cntfrq field, which is where the real frequency value
> now lives.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3159
> Fixes: bd8e9ddf6f6 ("target/arm: Refactor default generic timer frequency handling")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 167f2909b3f..1e1c0e41415 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2306,7 +2306,7 @@ static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
>   static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>       { .name = "CNTFRQ_EL0", .state = ARM_CP_STATE_AA64,
>         .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
> -      .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
> +      .access = PL0_R /* no PL1_RW in linux-user */,
>         .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
>         .resetfn = arm_gt_cntfrq_reset,
>       },

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

