Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82AEC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukshE-0003fE-MW; Sat, 09 Aug 2025 19:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ukshD-0003dx-1I
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:09:51 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ukshB-0001eT-8L
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:09:50 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-880f82dfc7fso237151439f.2
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754780987; x=1755385787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CLdg1uH5apvx9yNcEtQXWf8YEZPIBVbhLOxgv9htjnk=;
 b=SpZL6IP8KYCdEmz1iwMNVb6bnnlAFxmaegkbIm0riFIVuATw66pNym7ss9gNUDsf0N
 PDsDf8oBkeDCJX92cCy0QTViKfXctVRst6SsNzBKpGVfoMPiW42gy4jpl1goAxvRfe1T
 fcA68E8leWMgzD3JKs38udSvgYHqJ0LCP9myrNYGrJQ3FYjz+4vlNZ0d0vc3KGhY4Grm
 /paGHqhb1iCHvdDB6yDLXBmC9P2FnWYscwtHPRhPbUnvRC093OlixXQeWGNKTeLiebvl
 EUej7SZ+/b2ADeoEo22vjL5MxbOYknH2g2GtzDjVsPKmO1ufu2xfrVTRuFYmqFXpI6AS
 BOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754780987; x=1755385787;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CLdg1uH5apvx9yNcEtQXWf8YEZPIBVbhLOxgv9htjnk=;
 b=EW8kSkKBbx9QS+8cTFf0BCP3wulPmL/vOA0dnkPSkMM4F2ttCejSNB+bCPSMtB4mOz
 Nvo7mT83q95Yv8FWbgXAHN/71T+VfHEXy7EIyJMgCFL3ul8IqdFIPpZ/9eXElMTbxKs1
 zSZOFi6HMnyChGyKQ1rbfjBasGAgBPMPPuGJKHtGLhWyTnfsNb02xvzSao6OnKyB8D17
 6/2ozaM30s4rfw20RGHLcsnFt1R/xGfKena7HsA9a6A7IRPJ1zlO24MXSOj9s5JdW6DY
 sAYYMNJNZbWjpAIHfXjB26GHyPo44/CG5WQgdeWYOHvGLfVFQggaqWpVselSGLeA5U3f
 lOHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6CHcz+xiucq90bT6slS0zGi48WB0GbwlYFpgLm05scalQHxY7XTbzoibehkQNH0SSI0Wjh+ExEPg7@nongnu.org
X-Gm-Message-State: AOJu0YyODQ01xm7ozZ1z1r1zP/Xfj16OzquVk5grMpTYSisu6s8Avxnf
 F7b5dTSt/D5x/8HtU98PYRP1zQscEjBl2cWSgJs++NsPTfgKo0m8TRSns5mb7ebBJAU=
X-Gm-Gg: ASbGncu8tfj1u7TqGRajXdXVQ9DUcWwcaSI4p6sPMMPcmdzyfuDjKqU6SdpzR6vG3HL
 GLBojslvvcFZ6N/q2mrjUsphhxJ34/0nvunzbKBOCJ5CK6ZxpF01mWUnLO/fWBi58Yg1chJJHdW
 eaVMKUq1SL2WDi8v339F+BbrnVcpp1+8xhd15HIn6DceGOEa5ux1v2ePr2Q1yVsWusUzww2GEJW
 OTwwlFFFzIaxC7SRO8CDKFoNFgxM5MSALyOnXOD7GgksA1tN10B4R1P+Rpn2AzrcZuvox7Qm15H
 Y9sKPgUGbxkA1zekFephUJm9msAVRKdMv63UYpY93WVsYoA/gT8CCE9os4zZSOVQOd9kdH/JwZV
 n7aXWjRwKUHDvRlQc7SllKlxq1NiRbxjWLpE14EjfO+0T9Bm/EjC1LzCI5M2y5r3gEf1Zr953X3
 4UfAxCKxYKYeZzRF8G1STpXXjUw8s=
X-Google-Smtp-Source: AGHT+IELRNNltiE/lqR4zy56GDtCTgET+Nx0vo+wrQ1tweBGYsBmv2WUVvRhN/31Z8SqjosG9wpdVg==
X-Received: by 2002:a05:6e02:1d8c:b0:3e2:a7a1:8cd8 with SMTP id
 e9e14a558f8ab-3e5330b5f84mr145635925ab.5.1754780986824; 
 Sat, 09 Aug 2025 16:09:46 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.166.125])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e53e6f897csm10194455ab.37.2025.08.09.16.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 16:09:46 -0700 (PDT)
Message-ID: <e3f3a5cc-66aa-4e58-95bf-6f8648bf84ad@linaro.org>
Date: Sun, 10 Aug 2025 09:09:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] accel/hvf: check exit_request before running the vCPU
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808185905.62776-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/9/25 04:58, Paolo Bonzini wrote:
> This is done by all other accelerators, but was missing for
> Hypervisor.framework.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/arm/hvf/hvf.c  | 4 ++++
>   target/i386/hvf/hvf.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b77db99079e..478bc75fee6 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1927,6 +1927,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>       flush_cpu_state(cpu);
>   
>       bql_unlock();
> +    /* Corresponding store-release is in cpu_exit. */
> +    if (qatomic_load_acquire(&cpu->exit_request)) {
> +        hv_vcpus_exit(&cpu->accel->fd, 1);
> +    }
>       r = hv_vcpu_run(cpu->accel->fd);

This looks odd.

hv_vcpus_exit: "Forces an immediate exit of a set of vCPUs of the VM".

But we know for a fact fd isn't running, because that's to start in the next line.  I 
suppose this must set a flag so that the kernel's hv_vcpu_run exits immediately with CANCELED?

Does executing of hv_vcpu_run buy us anything else?  Is it less confusing to simply return 
0, modulo bql fiddling?

> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 8445cadecec..b7c4b849cdf 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -749,6 +749,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>               return EXCP_HLT;
>           }
>   
> +        /* Corresponding store-release is in cpu_exit. */
> +        if (qatomic_load_acquire(&cpu->exit_request)) {
> +            hv_vcpu_interrupt(&cpu->accel->fd, 1);
> +        }
>           hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
>           assert_hvf_ok(r);

This, similarly, I guess returns EXCP_INTERRUPT.  Is that better or worse than 0?


r~

