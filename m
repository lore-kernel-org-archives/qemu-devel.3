Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444F8C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0fw-000342-KX; Tue, 25 Feb 2025 14:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0fv-00032y-4v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:33:03 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0ft-00083m-BG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:33:02 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so9288259a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740511979; x=1741116779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RH2b2NxWRL91xnWLQzOoQu2c0sMgkFiCzptnPcMJp7Q=;
 b=aoKyLU4/wFCRCM7vvZ7X+z8NxUlLvV9tWdPpiaRqCHX9VteNOI2QOj8e4e5ARJW6oy
 8maVjmPaIkfNhFMm//rjBIAvweoXgQnZCi4Za19798mc8hyzp53HptIAGCIw7x35qfvq
 MLgwhLP9QA+2YnMiIhKNFyiHCmXSbtbKZZ7lhWHkamh7Df1/ZC12whyBaSfqHVZW4fon
 dty74SNTbwZUfFbkpmhxrSzGn2oIiJzuLI6dAmpwv0XWEnXv8HxGcg6oIhwsGgNgxpb1
 CH7LhKPwXeVhDvTW1B5hAKKCqt1cLs13PgAtxE8oRqTGsHkEnb7mc+XtIQcq6MouMso5
 9fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740511979; x=1741116779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RH2b2NxWRL91xnWLQzOoQu2c0sMgkFiCzptnPcMJp7Q=;
 b=qVoeZSttCuTelYK428qj/MiASGxMDayTPl4GRBO2MIp3NpuEo2ps9GN6DL8Iv7QLBD
 l2whFy4Uxlncdmcf1qKkk+8YTXwuUEJK7HMxXmZr91ndXlQ8U9AbjKmPiNR4MaOK6+1p
 KR/02C3d5wzUO1OJCmo5xH+ZM9N/DF4ROz1DE565rCg3sBFAnwAO4i6pzumWD68usKRk
 GB9itC/Hq6JczpasbgSIRUcmeFvvMJTupdSrO3KRN2J5nQekeFrNe96V9yMb1iRJv+dA
 6MjnRIDIHstOJtbbs6af3OiCIhFBQPRBgd5dkPgRNPrnP8V0h8T4AVdjtyfIRrmaDMGX
 dvdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgivVYpxjFkmFLKHO4E8XnXYRohobUHMIOG3MVCKRDk3Rb4nPkKGA8LpQuhtM3YhrNJBp/4nrilTbr@nongnu.org
X-Gm-Message-State: AOJu0Yze6+4Src9ar8XBLmlKRxrDqueF+qEj4Yrjz1/nbtIiTzoyTc30
 7Zq9V8lMFVSQDavSGCmm5Fj9Ht5BxHm2dwhF2OEdBLvdow1Hi2AlSKCdXanb6EI=
X-Gm-Gg: ASbGnctlr2FoOiM4C2VMPjYmC8Tf/DhH79qj4XbAQi3MOc+iJohG9a3ghZOeFpMOQ6z
 qM0F7bfbXSsvaWjO3Bgwp8iwYv8+YgtIx/FOBiJnSP88K5AVz14Ue9qUXATydTkO3AqsrUGdZw3
 kMbS4HywOsG5uYwAibEsmIEcFLz/T2fsv7qNWQJvH4BSz07qxXPeynI7mZ1UznhTxYJ4yHYAJT+
 nfMULjzKaKl+6Su18E08dziS4kD0JfGQl6tRDVBM8VIi1i9MMN8CG2vNw4c0A61GpALduoyKhQa
 6eUNRNW098HOqPIIbgg8p1g9L4OtXCwuOlXECS2UvnV03eVh8FYO3WASj5h1RuFtXdG4cPUt3RZ
 mTCBnf50=
X-Google-Smtp-Source: AGHT+IGLl778Sq4ThKhv0A9PafQhJ/Y/dftDb3zxWd8fYlryHRmNxHpSJbBKKA50MLBjdhohSIyj3g==
X-Received: by 2002:a17:90a:d44d:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-2fe7e2f745emr978552a91.11.1740511977946; 
 Tue, 25 Feb 2025 11:32:57 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe6dec6dc2sm1121755a91.1.2025.02.25.11.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:32:57 -0800 (PST)
Message-ID: <a9a32d96-c19d-47fb-b262-1f1eff2038ec@linaro.org>
Date: Tue, 25 Feb 2025 11:32:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: drop ppc_tlb_invalidate_all from cpu_reset
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225184628.3590671-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/25/25 10:46, Alex Bennée wrote:
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 062a6e85fb..f987b75c4f 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7242,9 +7242,6 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
>       if (tcg_enabled()) {
>           cpu_breakpoint_remove_all(cs, BP_CPU);
>           cpu_watchpoint_remove_all(cs, BP_CPU);
> -        if (env->mmu_model != POWERPC_MMU_REAL) {
> -            ppc_tlb_invalidate_all(env);
> -        }
>           pmu_mmcr01a_updated(env);
>       }
>   

Nack.  This is flushing the thing emulating the on-chip hardware, not the softmmu tlb.


r~

