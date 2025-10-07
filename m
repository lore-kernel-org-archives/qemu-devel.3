Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C12CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 19:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6DSZ-0003Mu-B8; Tue, 07 Oct 2025 15:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6DSW-0003MX-U6
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:34:53 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6DSV-0001aj-2q
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:34:52 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-330469eb750so7948347a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759865688; x=1760470488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hK11imdaTz/9kSP6U2WBRM1zcCe71JrVcoIwGxMmz2o=;
 b=ZK8NuF0Z0gVorluh+4c88HjNQlMRqEQK0uf86b8RMQFGTSHNuw7NfhJXBNF20VJVSP
 T95J8DVGcGKNlTn1hY5vCqthKOiPNnyrz0NS+DnI9OkxX1PuxAEGRAeANsiE9rZUFufp
 zISaSgkDwkoxplBM8cd+pGPXk9mvS+tk0ueEkJhbhjafEVtco0hveYJuL8IbtHrOHQfn
 HxzMQvsG+vWJ3dB+kwmQcwE7wghtEKcu5RWYPB+oEDmcjl2x9/zR+q/bC0OZykpcE04E
 NWNfBLVq07C98BfRu2/aqwQ6BgFh9fG/3ce2tOzhF9bdZz+SlHGIqfckUZi37d7nfWdr
 DX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759865688; x=1760470488;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hK11imdaTz/9kSP6U2WBRM1zcCe71JrVcoIwGxMmz2o=;
 b=PNOE+UihZrsaSAV3LCMM29XmOHxJr2rYpAcA7TRDEWr+4379uBaGNg4uZ5bE7zVpUj
 A5T+Wd3U/2Fd8vfOZsFQERhfE+2fRGaQZXVMu+k6RRwC/NRlgNgsokt7NUinfibq+93a
 1DhRz2a0AlgjFdJU5UOfBxN2DSiTqz4iIOrOMIBovLVCvECjtnVAECOreeBkOMsh0kLp
 mXSgaDKj9/NisNhYfEB0zzpA6orllmqCQvomGO97JT24PuaemgBuJ9vMs4BqfU5wk3oI
 R87yf9zCCGi8fIHMREj6rCDC8sgTXTbJaNW6NQ971vQwROwr6kDtGrw5oehHsK/8ewC9
 SFdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURwO7Dfg9fcRwTYYYZmhtfrSVnnxTm3vXsNQ2H6Sc5jRJiVahCDTPPqhySoPsagovjcSlhOL6GCoiT@nongnu.org
X-Gm-Message-State: AOJu0YyW4kKdqgGqGjiXLm4+Fs4OPVsJoam+7cypSYN1WpB9GiRx9jDT
 +H9GDjvyORsBupZMLBF+mSL5cGd4I9R+3tQK6XcwSZhFkuBr6b5kpm5dwP4zc/Jst0oerUTEH1b
 DmL++8Yo=
X-Gm-Gg: ASbGncv1TK47B8bDd5ztOHoKsJpBWtQKjmc268ybNQOqYufvQolM7p901Z5+7dxfxd0
 MGudXTsLQc28MZfcCANt2zKK3MrC27eCEsuzabILOctQJFXCYO4XUaodh4QTyZA/V6PdSTAPeGr
 UibPJ5f6Z92XddzXHJdJm6Z9TJiFTGg/ZXhor/P7a5NSWahxoTYtl9N3B6IaFCnmDo4fwxyJiIB
 UquAhnn++KcrMx/YFRXqMbANwfWhhBuJGI7GTzgj99ZPx4HMAtvneIT/rCCXcdnexXfnV0qHuF0
 2o9r5egpy/L60Xj0r146iVfujhw4drfsddkLJiSU29lN5f24Iqwg4/LDP3nC2iANbN1XW8iJW/M
 WaQRXDRIOAT47cxOuKn0ZQX3xnlZuOLlPcAwtz6rwZlhSbzoukw+TulZgOc4E76+b
X-Google-Smtp-Source: AGHT+IHMgvb4eiDC+f/3fPq4MU16Q1CLdXaymGYYOMEZRESJY7RgDg9MXmkTEj/9J0HXql/PMLFqDQ==
X-Received: by 2002:a17:90b:38ce:b0:32e:23fe:fa51 with SMTP id
 98e67ed59e1d1-33b511188e7mr799798a91.9.1759865687466; 
 Tue, 07 Oct 2025 12:34:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b5114eae2sm467807a91.25.2025.10.07.12.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 12:34:46 -0700 (PDT)
Message-ID: <1c8d0e1e-46a3-443c-9308-c6a4686979d1@linaro.org>
Date: Tue, 7 Oct 2025 12:34:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/kvm: Factor kvm_cpu_synchronize_put() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251007081616.68442-1-philmd@linaro.org>
 <20251007081616.68442-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251007081616.68442-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 10/7/25 01:16, Philippe Mathieu-Daudé wrote:
> The same code is duplicated 3 times: factor a common method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 47 ++++++++++++++++++---------------------------
>   1 file changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9060599cd73..de79f4ca099 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2935,22 +2935,32 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
>       }
>   }
>   
> -static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
> +static bool kvm_cpu_synchronize_put(CPUState *cpu, KvmPutState state,
> +                                    const char *desc)
>   {
>       Error *err = NULL;
> -    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE, &err);
> +    int ret = kvm_arch_put_registers(cpu, state, &err);
>       if (ret) {
>           if (err) {
> -            error_reportf_err(err, "Restoring resisters after reset: ");
> +            error_reportf_err(err, "Restoring resisters %s: ", desc);
>           } else {
> -            error_report("Failed to put registers after reset: %s",
> +            error_report("Failed to put registers %s: %s", desc,
>                            strerror(-ret));
>           }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For the to-do list: the arch routine really should be using error_setg_errno, not 
deferring the test of errno to here.  But it seems i386 is the only target that actually 
sets errp.


r~

