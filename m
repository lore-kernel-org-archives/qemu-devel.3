Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7130AD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 16:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ6LU-0007mL-QO; Mon, 01 Dec 2025 11:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQ6L8-0007if-L9
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQ6L6-0006Sy-AO
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764604880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0w55hQ+eXVZqzmQQ0BXJyh7tN55VxL9A5XlGAQlZ1qU=;
 b=VQEkcBw6hESOMasVoJRxgZLAZqIjsU/7xsWakxl0KdGaNak82S0ZPTOyvwS9oNezwUXNkf
 Wb86MeJPIVzb3SualR1MVK8kY9iADbzgV2X1BPBw7t2PlCtUqPUuXUHwHKt1d7lzYqrCZ5
 qVA+zt7zntfRQWVg6sRSoNfTNPv1ZWA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-_4kmfaIGM2KzXCmlUXHMxQ-1; Mon, 01 Dec 2025 11:01:18 -0500
X-MC-Unique: _4kmfaIGM2KzXCmlUXHMxQ-1
X-Mimecast-MFC-AGG-ID: _4kmfaIGM2KzXCmlUXHMxQ_1764604877
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b73586b1195so504577866b.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764604877; x=1765209677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0w55hQ+eXVZqzmQQ0BXJyh7tN55VxL9A5XlGAQlZ1qU=;
 b=I9m2xMM0/Hayy3pj/MSGwbMtHrijDagYmjGrpIa/8akEsWUX7BcaOU7ZZPLUVt5FBU
 E8xK4qlpia59h7urg0AdTNn9UA06q31k67ivKBvym4oJQZ5ufR803RHcngl3Gc6mc2Gx
 ggljd7Jr9UdcIk1Olzar2xHhonEIT7Ub7GL4UbszVavwoZ64w2vocJN/VHRt9zAp2YyY
 spYFCkurxjqZsUoX2sIEOmhGg1UXJ4OiKFC/TWSN2S/y+5HasOKroNTmOw9E6E6Y36lN
 w1PwH4VzI0LaaGTRO7YDOiPPt0PdYKenGDGSCiHwBvuK10hpxQsq44QjVGj6aE8M7vty
 g19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764604877; x=1765209677;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0w55hQ+eXVZqzmQQ0BXJyh7tN55VxL9A5XlGAQlZ1qU=;
 b=CGNPz4xIPLbf7XcE9J6bCj7EMpTmVXNdEeCK+oO/Fe9ErxjR+VCwgxG25VCMY965cK
 O8FLEPs7bXhTRzETrujk3gp45eu0sChNcCPxQP8WoTTbY5deBZ5GGpzeZp+mJyAe0uK6
 dL0Tyi0Pd/bmPX1+IYp5JcmeeZVmC6EbCSUjhOQeQoRJTClx6XAcnlqFze7N4xNOCtst
 lzptWhqimPQH/Z/5Z1TR7B5Ra5DIgfCGFqul71ndtTAwzW6ebu+slJy5enJbCRo1mtcN
 k71FiqCpBvtzjbSN52CaAekR1Nb3o9aaOaMwWqTEIi5nWpWKWDyFKHv4spkKNb9yIEcL
 3WeA==
X-Gm-Message-State: AOJu0Yy1+Fa3gGsAGli9Xm7CwfjSjnQImDLsZyTTlBgLpV2iBFj7WWUG
 eAoj1EHqS1/eDY8OvQFVbCuX45EaxjrNRkcZKgXrJyPIiXdU1vSMfQOEANsIK0T3OZtnASJNqPD
 2HyWmm61/ZuN7D32tH7jbjCn0MEsqP3d6TrzmOOSZ8RPAz3h5OPTslHWL
X-Gm-Gg: ASbGnct9P+V8/dAxo9i+2eQjE7QoFPnR2wys4bZf8YUw8Uh/QQvLbC11Cpn6TdZBPZG
 PeSADtYFa/5loXEPJFgMfJWRFZKVvDuMu0GgkkxcfBwwUzgp3PsFQJxmX2oUfVqdQRlw6WbjX46
 2zsVX57AIFj6/EHs9PvHbqmo6QsVqI63P2gXKCMiI3p+AhCNjZa7JJF8MXCDKgTcaMheZen6zWL
 9xAmH8jcdKD1Y63Ymfsm3gLLquz0TbKtENXNn88I8VSmTflhvB9LJAAZp2Foqii0au1SMiCCf35
 tD7r4GbdMGPxlkYs/GK4IC2v4rorMAUlSu89DvEYD/JB6kctKW0HBpGu5gZ+I6PgigqoUAfwcrH
 i00dd2Ww+7BFkk9gu5d8iJqlPfGXpnHAcHBOJekRX6eyOUrq0uWpweSOvBd3PWAUwWMNzzXgRsn
 yMrypMdxH8u81e3FE=
X-Received: by 2002:a17:907:3e15:b0:b73:b05c:38fd with SMTP id
 a640c23a62f3a-b76717332acmr4052588866b.50.1764604875356; 
 Mon, 01 Dec 2025 08:01:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtU1UITdt7IPgIFW5jxqCEQKvj8EGriEmYfhfxuTYjFDBNr4/3dxso9Yf8O55cM4UA9A+/ug==
X-Received: by 2002:a17:907:3e15:b0:b73:b05c:38fd with SMTP id
 a640c23a62f3a-b76717332acmr4052570066b.50.1764604873682; 
 Mon, 01 Dec 2025 08:01:13 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b76f519e8f4sm1273506066b.22.2025.12.01.08.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 08:01:12 -0800 (PST)
Message-ID: <5675fe47-f8ca-468a-abb6-449c88030a5f@redhat.com>
Date: Mon, 1 Dec 2025 17:01:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/23] i386/kvm: Initialize x86_ext_save_areas[] based
 on KVM support
To: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, Xin Li <xin@zytor.com>, John Allen
 <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
 <20251118034231.704240-7-zhao1.liu@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251118034231.704240-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/18/25 04:42, Zhao Liu wrote:
> At present, in KVM, x86_ext_save_areas[] is initialized based on Host
> CPUIDs.
> 
> Except AMX xstates, both user & supervisor xstates have their
> information exposed in KVM_GET_SUPPORTED_CPUID. Therefore, their entries
> in x86_ext_save_areas[] should be filled based on KVM support.
> 
> For AMX xstates (XFEATURE_MASK_XTILE_DATA and XFEATURE_MASK_XTILE_CFG),
> KVM doesn't report their details before they (mainly
> XSTATE_XTILE_DATA_MASK) get permission on host. But this happens within
> the function kvm_request_xsave_components(), after the current
> initialization. So still fill AMX entries with Host CPUIDs.
> 
> In addition, drop a check: "if (eax != 0)" when assert the assert the
> size of xstate. In fact, this check is incorrect, since any valid
> xstate should have non-zero size of xstate area.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes Since v3:
>   - New commit.
> ---
>   target/i386/cpu.h         |  3 +++
>   target/i386/kvm/kvm-cpu.c | 23 +++++++++++++++++------
>   2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 3d74afc5a8e7..f065527757c4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -609,6 +609,9 @@ typedef enum X86Seg {
>   
>   #define XSTATE_DYNAMIC_MASK             (XSTATE_XTILE_DATA_MASK)
>   
> +#define XSTATE_XTILE_MASK               (XSTATE_XTILE_DATA_MASK | \
> +                                         XSTATE_XTILE_CFG_MASK)
> +
>   #define ESA_FEATURE_ALIGN64_BIT         1
>   #define ESA_FEATURE_XFD_BIT             2
>   
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 9c25b5583955..2e2d47d2948a 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -136,7 +136,7 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
>   static void kvm_cpu_xsave_init(void)
>   {
>       static bool first = true;
> -    uint32_t eax, ebx, ecx, edx;
> +    uint32_t eax, ebx, ecx, unused;
>       int i;
>   
>       if (!first) {
> @@ -154,12 +154,23 @@ static void kvm_cpu_xsave_init(void)
>           if (!esa->size) {
>               continue;
>           }
> -        host_cpuid(0xd, i, &eax, &ebx, &ecx, &edx);
> -        if (eax != 0) {
> -            assert(esa->size == eax);
> -            esa->offset = ebx;
> -            esa->ecx = ecx;
> +
> +        /*
> +         * AMX xstates are supported in KVM_GET_SUPPORTED_CPUID only when
> +         * XSTATE_XTILE_DATA_MASK gets guest permission in
> +         * kvm_request_xsave_components().
> +         */
> +        if (!((1 << i) & XSTATE_XTILE_MASK)) {

This should be XSTATE_DYNAMIC_MASK, but I don't like getting the 
information differently.  My understanding is that this is useful for 
the next patch, but I don't understand well why the next patch is 
needed. The commit message doesn't help.

Can you move the call to kvm_cpu_xsave_init() after 
x86_cpu_enable_xsave_components()?  Is it used anywhere before the CPU 
is running?

Paolo

> +            eax = kvm_arch_get_supported_cpuid(kvm_state, 0xd, i, R_EAX);
> +            ebx = kvm_arch_get_supported_cpuid(kvm_state, 0xd, i, R_EBX);
> +            ecx = kvm_arch_get_supported_cpuid(kvm_state, 0xd, i, R_ECX);
> +        } else {
> +            host_cpuid(0xd, i, &eax, &ebx, &ecx, &unused);
>           }
> +
> +        assert(esa->size == eax);
> +        esa->offset = ebx;
> +        esa->ecx = ecx;
>       }
>   }
>   


