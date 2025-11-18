Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C3ACEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLH7k-00027A-Fi; Tue, 18 Nov 2025 03:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLH7i-00023E-MR
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:31:38 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLH7h-0007ui-64
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:31:38 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-4349044be0eso23253385ab.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763454696; x=1764059496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vixCdhuuRl9S/OQELV3U+ISbJ/s9s53g8UBfFwLm0Hg=;
 b=xoBtvGQoH3VkAER+FWIsOk4vPenwaIlZEu78jHpw6DLN6wizu1RdCkTk5XV62/GXiU
 R1Wh2EMzVVrg6AZju7VWVAArlF51IOjzzvcILuA3dXYaYZdgbSPnXPZ3P8SurvG643Yv
 Aq/3quBdaU4dXi9/GIxHXxGI3y3lSc7NSBeCmRJ6fM0IZWEcZJ4OxDRVwPbFDTFdo/uQ
 KfyIHMCUsBEHd1NIBRi7x1A3T62s2duFvHBHhnB3lYjTYGRD+8tW/VNIEFbtD/KFQwHw
 R2cG4B915xg5Nb/DKEOBzLhtqP/PFQSY3B+tW0g2xUQsR7oFyMTS8IuVgOxVNlfWJEcJ
 jogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763454696; x=1764059496;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vixCdhuuRl9S/OQELV3U+ISbJ/s9s53g8UBfFwLm0Hg=;
 b=iztG2FSOMi9/V8iBN2usJ+ZR2EFac5MYA4jbwoko7vuyGa+UHsjCgX3jjVpGT4QxGx
 uTYyjsFIWu01vpOpob+aTKr9aYtmm10woXeYtEp68yVm/bpX5Xu/oJJZGC8h+hqxHA42
 e5MnVMVD3QMmssAzdV9R/ghmGEMpC5HetnepCdtYCQAhpuTB4z4/vRaB+JQ68OC5R2gK
 MTCejtMi2HofoEQe+Nh0eZ2cgk6ZNTt/Mr4DaYsT7PH/0axEXcOeSYYjs9dK1JwwjdB4
 ySh+xlVPPZzGoakhQWbI0efBtxvm52nzYMoAwC0Fmgv+EDIuzjZtW73xQrWLRd9RxGgF
 VRkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ZIY/TQ41ot6v5Tqo4aksOiNcij1y2U5SzUsGucOX3RKHNWjzTNx5dqUxY4N2dU5ElG9To3eUpfJj@nongnu.org
X-Gm-Message-State: AOJu0Yw7CnMD7XtGxas/NdXd5ltCCNtnXmFA5cOC9kdVSLNiELeBxMQ0
 id9opwyLIPBwef50zeXCbOBJ2EOmhanHYBNegP6W3W8eJLPN2j0Yl+M7C8KA1+3bnsI=
X-Gm-Gg: ASbGncsj1/9yxk2GYyyAGCCYYzV+ZGeJHQonWEikwzs+Ng2w88b9gtgNQ7GWtXlS8XJ
 LltLUYYkBAdLxBggSNrQ3//izjiEjT9qCMs4hQvz0Lzfw6RBfLfLCVl+lKzXjasl1Ahg1BWc+Wo
 uu+nEiOSxjS+vax40qfoXPLMdmUIfHg9ZR4UGHv7+9zjtnsfJGQ7mYm1bK4svGnKddzeloUWIfJ
 LQjFkkcgR2Rb6yii8oYPhHFtm5v5/oqfZwAs/J/7e09b7pUzvsso6WTY7zNWW+BDtx7SfUAuVwE
 HEhtRpcKpGwb3PWiEuh3ZsMFbk8Eij81tt1eUWgFo8OZRTnu0jFfBOLpQU242Pfu7FpdWyV1kzo
 IHutOKR662CICNN9KiMcfgWj+GAbMRHj2xz3dyxhCyADVoWjkQMt+sjJRlcDqaIDBf0QJZnSZmN
 ChSt+hpyq1EJTjjh+4vrjD2IbeEJbQWiQR/CBZT/BXUKzCLKNfm+IHkYX6vAE51f4mamc=
X-Google-Smtp-Source: AGHT+IFOZsxt8HZhDwnlKbfex1C/Ww2WK56+ndOwzQle22ZGDbWqbci5XUsyGGOr4pbFSz1cEFYdgA==
X-Received: by 2002:a05:6e02:1d84:b0:433:7a94:6fd2 with SMTP id
 e9e14a558f8ab-4348c94f67emr233432635ab.28.1763454695836; 
 Tue, 18 Nov 2025 00:31:35 -0800 (PST)
Received: from [10.89.10.227] ([172.59.191.229])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434833e9255sm79253415ab.11.2025.11.18.00.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:31:35 -0800 (PST)
Message-ID: <24c4e4cf-ddce-4e93-8f0c-33e48cdc130c@linaro.org>
Date: Tue, 18 Nov 2025 09:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: svm: fix sign extension of exit code
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251115002644.103889-1-pbonzini@redhat.com>
 <3e215a17-11ed-4172-9598-42a2e1bd9e9e@linaro.org>
 <851ab1f1-c05b-48e9-a08d-2076fa9ab67c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <851ab1f1-c05b-48e9-a08d-2076fa9ab67c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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

On 11/17/25 12:32, Paolo Bonzini wrote:
> On 11/17/25 10:42, Richard Henderson wrote:
>> On 11/15/25 01:26, Paolo Bonzini wrote:
>>> -void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
>>> +void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_info_1,
>>>                   uintptr_t retaddr)
>>>   {
>>>       CPUState *cs = env_cpu(env);
>>> @@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t 
>>> exit_info_1,
>>>       qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
>>>                     PRIx64 ", " TARGET_FMT_lx ")!\n",
>>> -                  exit_code, exit_info_1,
>>> +                  (uint32_t)exit_code, exit_info_1,
>>
>> Why cast instead of printing all 64 bits?
> 
> Because in practice exit_code is either a very small negative value (-1...-4) or a 
> positive value.  For QEMU in addition the positive value will also be small (less than 16 
> bits); values between 0x8000_0000 and 0xffff_ffff could happen in principle but are for 
> use by software and by the processor[1].  So the high 32 bits are basically unused, and 
> the cast removes eight zeroes or f's from the log.

Then maybe you really want the signed int64_t?


r~

