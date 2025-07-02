Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DB5C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzXP-0002RM-4l; Wed, 02 Jul 2025 11:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzXN-0002Mp-04
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:38:17 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzXK-00089p-1t
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:38:16 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso3315233fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751470690; x=1752075490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AOSDnQveofmQKWcy3OSuqQqbF8XfdA1MaHWVomHmGBE=;
 b=adrN8OHxLOIGopM/7byHUxr9I6MQ2a6Odxtko3PcOHOqWbSIayvnvdCTGRMz2BmhTm
 kGtVLjgcnjANapgDn8BBoCNbBKWIW1E4CleG1iY8qzuQcY4jhmsmmSy8xwU10Vg0EGv8
 qe8VSDu2Gh/xu4/UReAI9RYjsMP8Ohi1mzRePyVXYLTUAvDxe+6zotRid1B7BkpFiBQe
 iFu0FwUMx9/RrNl2Lbyeg160eFdcB1XxjiW/BUT47eMA6UiVzl/KrMm2R1e/OMWfmHnH
 9975sreTzDfF619rVLKeqFQ4f9wuub6nBMYQffinC7KIv2SPWI6xi3LVLTDMXlZmtusL
 xhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470690; x=1752075490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AOSDnQveofmQKWcy3OSuqQqbF8XfdA1MaHWVomHmGBE=;
 b=t1JU+s1G6ku8EBn6IYcP7VmxWQpqwHRzseXhjcfDXMrxP3CdE5FgU6B1JRKqS00YNK
 034zfFBgvJ2beUVvkTi14rVWNC+MUc1Xq8fvCHNhrmI/45a4bpL8G6xKQ9SocmEh/dgv
 MIJbkWDwo2XfXMRBEPmKobtF50ZvhD+VdHFTOcqj5haVgIuczq/5rEwH/7dZVtU7vnUs
 hRlWTHQRWXPmIRntvy39rTeZRK2LfzNuEep1rGQ9mzi+DQAjg1uJgyWo8hr4aDNfXm1A
 Bj3m6fsmH7e4Un+puE9CT1Qb3+BWIbG9RF41qqqrE/bJ52XcZRMlAtwjQU3cs+6J0bqj
 43ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ENS8e1ft6/6LNuoNa7RUzIMvlLOl2YGM0QXLj1r1bEqSSi/gg2ioShzEVCE1PaRaKyNaxU4NzDhk@nongnu.org
X-Gm-Message-State: AOJu0YzAGXXSWudToxRR5HUKEw0OrY1rzlX94t+8XO8Jk54WEcVkbX3P
 Sa4lGH40jkTr9GGLkx4ZsTaJMG9dotrzi/3riCuIICoqo35WmpisD3qvzzIQkbi60Ow=
X-Gm-Gg: ASbGncuc4s6D9LIP9NAdSF2N0g8L2L1yjBgLdZdRCOA8TeGCkuFnCExTHv2P/JhvUDI
 6vuNKpFk69cnn9WKOsSywjffZDx8arNBsN4nRZo08yxJF/cRGLRO8aADDHZo0ovYoT3euIW6YqN
 RvJfYTprMFOu4UpLjhvQINsRW5gAR2Yz1w1aSILRrBMcpoug9m7WrXamKCoRWw3rpaavQtNmjyc
 K6UY2l1/ngJLANCFa7m3+GNJWxh2NIELqF0fJ3qnCpuAD9VCHaNq4p0m57ZxoCy1pqRv1sE7oCo
 mR2VIIVMS64iZqsW1TDFx51Becu07DlU6KRW4h6ZgpV8mP1Qm6fnYnBzbRo2ENHYz/h7QZRsoBO
 E
X-Google-Smtp-Source: AGHT+IEm7ygzpTR1gi/hXlG7wjNUndwUak5U9FZYCLNw8mOR/YKqEU7G0r7M+1KLZ1ZNo85gGTfNAA==
X-Received: by 2002:a05:6870:392b:b0:2d0:4a2c:7c22 with SMTP id
 586e51a60fabf-2f5c7c3ea4dmr2602651fac.18.1751470690519; 
 Wed, 02 Jul 2025 08:38:10 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7f75sm3960072fac.38.2025.07.02.08.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:38:10 -0700 (PDT)
Message-ID: <be938f98-f590-40e4-a1ea-74492ceb046d@linaro.org>
Date: Wed, 2 Jul 2025 09:38:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 63/68] accel/system: Declare init/exec/destroy vcpu
 hooks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-64-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-64-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
> index 28e29cfa06d..f98a1c9b662 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -43,8 +43,11 @@ struct AccelOpsClass {
>       void *(*cpu_thread_routine)(void *);
>       void (*thread_precreate)(CPUState *cpu);
>       void (*create_vcpu_thread)(CPUState *cpu);
> +    int (*init_vcpu_thread)(CPUState *cpu);
>       void (*kick_vcpu_thread)(CPUState *cpu);
>       bool (*cpu_thread_is_idle)(CPUState *cpu);
> +    int (*exec_vcpu_thread)(CPUState *cpu);
> +    void (*destroy_vcpu_thread)(CPUState *cpu);
>   
>       /**
>        * synchronize_post_reset:

These could use some documentation, distinguishing them from e.g. cpu_thread_routine.


r~

