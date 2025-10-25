Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151EFCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 17:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCi6j-0004jr-P7; Sat, 25 Oct 2025 13:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCi6a-0004e1-Ew
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:31:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCi6G-0005Gb-Rh
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:31:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63c3d7e2217so6154953a12.3
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761413440; x=1762018240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gl25XAqWRPsYRwvsZLyzU4+TpVDf9M2ABrCF3/nkOsk=;
 b=tMFTrUy5CZpLSrFaPZNd5R2f3AVLb+y/i1aQ+LcVq6b7ImD1NN20KFxPNv0hpV1gpi
 8OAFay4LCHLqWLDHSkUyS6nNC9fIDchhlIli7xCbnPnV/FnHHqNZVwhOWkJxSUf6Hj5+
 Ar/fUTv132gWnmQC1kJ4HH+So9KjX3euFRLtsUEF62DY2bZZrDQlpvtX/XUd6K89yagr
 c5kitZiTvxbi++rtsun4jkJTZbXZA6SFg4jUfMQpPrTlVwHpwtx4CWR4H1GGC3asyRK+
 6CLysBC05E6WGuhu0wSrNtzWzpMmnZhUNRwnZvq9H02g/kxfnXwHaWRYIOX2Rwcu8rac
 VsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761413440; x=1762018240;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gl25XAqWRPsYRwvsZLyzU4+TpVDf9M2ABrCF3/nkOsk=;
 b=glymOjBBGaTAxhez0slOEQMESx2tZo6NBDY2QNA+Wu82peGcTM3QOI5vD8R/UnyE3O
 AtuKhmB1WfeYaZL3kJm1NZBC9meKww89IKGiFEd3MEGKsRrzvmmTSiWrzf4Bh2a9J6+v
 /+3otY8zzMl4ImbCU1YZwbbGhUtGQAeviV8tP3493S/NAxpsUOi7Lo2i88J6X6dzCSzw
 kHMMGMoiNL2Yf/L+0nIPKDfZ8sNjYySzUl/LSFFSciOcSMVVpUD+uKxztPGrFdTLm8OY
 EUgn1G1tVMqyKqBxzYdp38hrmByZ+Ic1mMvZc2VnWpqSv9qP9ZSxxVjMu10LOaVpcSGh
 z66w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMoogQkQF6C6hflqyQyGV1yRPOrJnQrCT2lkz3Osc2ucVoRKekW3HxduaJoyqHqMBDpqKX6sP13diT@nongnu.org
X-Gm-Message-State: AOJu0Yxo52VyMqE6IhBvdCWa6gnTDQ0AcMgUCKlcpzkkjkOkeCk8dZj3
 1cyxfwgtNY669t1qkjvI8h/jaw+xRXRSvuOj2q+4TtrVEcKiH5Oqvhy0g31tJ8ZeaRc=
X-Gm-Gg: ASbGncs9breFluMyPWC4y+uK3qWw0+PpGrwRgJpkvlX7JsoW8AoobJ2fLJveCNZTECP
 CVysWzxDpqauUlN5HmpLZFIfOGpFt1U7GgF0eQgG6CU+P3ZA5IQoEpdLUNa5XjF7FWKRBFx6uqg
 7B3gm+E66uYt1gp9RDp5s6aDSvBAkadgMZc1t9t6R5EfN/TJpvuqisNP7OcdmrXVHeTw8PgXsAH
 Q7bTV0BFmE4JtALTJsBd5Y7EO2L17RdQYR9I+lFbap+BW1k+Djde9vuUuBQEGKdI8V2hDKH/0p4
 t9jhx81JwVZLWFEY7JwCPEHoGF6DrVKX0gTFWgoPE/NjStJg2LhtFeeyDsXfuhS+emS/yUmYppY
 Vgk2v9YgumgzCP1r68EvXGbooslMOn/vTBAOVgKZSZYeNRsZsiYLH1viUHS8W+H57AgHjpzNln9
 ayhuzY0cQ3CZbVH4j9fcrTiZj61rTpq1o+Ix7EMD0+2H2ZSArNvNeg57Q3a7nOuD4idLRYnq02f
 g==
X-Google-Smtp-Source: AGHT+IGdRVBM/lcC5c8NarUVjuL/5FWNvD3hKEYQNXNG4bhVRpulkQqmMGG9q5e75x7oVXrJKPb5og==
X-Received: by 2002:a05:6402:3506:b0:63e:19ec:c8e4 with SMTP id
 4fb4d7f45d1cf-63e600e9e15mr5591341a12.28.1761413440389; 
 Sat, 25 Oct 2025 10:30:40 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef6c0e9sm2099548a12.1.2025.10.25.10.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 10:30:40 -0700 (PDT)
Message-ID: <e54606b7-9aa9-4e70-a0eb-d9bec2c8438c@linaro.org>
Date: Sat, 25 Oct 2025 19:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/58] target/arm/hvf/hvf: Document $pc adjustment in
 HVF & SMC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023115311.6944-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023115311.6944-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x533.google.com
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

On 10/23/25 13:52, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b5fdd86837e..a045f83c9e2 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1947,6 +1947,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>       case EC_AA64_HVC:
>           cpu_synchronize_state(cpu);
>           if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
> +            /* Do NOT advance $pc for HVC */
>               if (!hvf_handle_psci_call(cpu)) {
>                   trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
>                   /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
> @@ -1960,6 +1961,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>       case EC_AA64_SMC:
>           cpu_synchronize_state(cpu);
>           if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
> +            /* Secure Monitor Call exception, we need to advance $pc */
>               advance_pc = true;
>   
>               if (!hvf_handle_psci_call(cpu)) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

