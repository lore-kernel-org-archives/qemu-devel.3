Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F939CCD18D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6oqc-0001cF-7s; Thu, 09 Oct 2025 07:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6oqb-0001c3-4T
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6oqW-0003un-EJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760009405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=anZnb7FGDnfo+uyqEej2Xh3gIZULvJpGNAIjXS0/XGc=;
 b=DsyATk8MGDZXtlyeNRM5MTV1mFd+J3mi2yOhcYRK3kdTMcfquOTa73cz0FYM5DulcTznH+
 i4ZEPv1os5hMmZ3Q7xePGk8sW5+PzvMSvur81b+Q63BI6SJ6JuU/TL2K6PiQEL2+5/PKfL
 WfykUjDYA5G25Dbe0PzGM2fP6U0D0xc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Dvi7edtBPieH-dpvda5Jhg-1; Thu, 09 Oct 2025 07:30:03 -0400
X-MC-Unique: Dvi7edtBPieH-dpvda5Jhg-1
X-Mimecast-MFC-AGG-ID: Dvi7edtBPieH-dpvda5Jhg_1760009402
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso875251f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 04:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760009402; x=1760614202;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anZnb7FGDnfo+uyqEej2Xh3gIZULvJpGNAIjXS0/XGc=;
 b=gQkqRDZbst6vliJ9o0kwytR4oGNUlBM9X3ebzqKprcU3vdguNzCjbaonxq39UJULjp
 7Yy+FoZi1J0lyscVBJqr4XlZy/giys7TJTUWBMto3HwF/ojUtjP7K/6CD9gcOMCa6A9W
 1bnIFaKJB4+0ipwc43S+epBTHCgMDapNDRecwGtVssuFPn6QkV7ibodLZoo+TuivMbrL
 ZtXXlVOa2VM4pXWibVrP61UD6Gg9d9xoIoODLVOBQERE58u1184BQOdqQ5Z0BX4tlP/7
 KDTvBy+7hnuJzxlr2V+VUf/u5JdvGt4XMakOHoWMlBs4mrXGPzbLTETqPLQZH4/MlJoI
 XOGQ==
X-Gm-Message-State: AOJu0Yy0qMaWSD7kFnfYM+Ghj1yfmv4LdIYyHyj+w4yam3YXuYYoJpck
 V8xm6J/lLsgVhgzmJYZOu3Kyz9AsFlzWqqyhmt2BUwEH6NealUIw/tOQhWl4VI7yVJxllITabt6
 zxd3aTTg88VYIFjbQY/K2xoNXxcQYNyQodRNnplHqqVcP3zTvXR59BHEy
X-Gm-Gg: ASbGnctKap+M3GiL50KQeTjSwEUGSZjNCKwCgXBzx0CmVHxTYp7s/yCyCv6RJj0Qohv
 mIglQH4b3Ix/84B42i7/DkcU/qITajr24wdXd1L3we/vyOuMvveYfNIMYR3XoqRqjN08JHQSDgq
 NtFDBNyDQ8lpRi5THfxtx4TEbkPEaj613qkeTCfReU32XyQtlri7BF+me9NEyJOGHLW7XGULLFX
 /oOACy67aUq2kw0mNzQLH0BJ8EZkc/p8fWVcirjAkXq9yZiZRJ/9qRbHzt3Q5AujMPhsXM9c4Zv
 j7nWOVeFtd+C5M8lUyUmF+pjym7ag+a3y6FbNHgKR/TVMyRi4yC6YGc+y7sz9+r0nyxhOlVUJpD
 hK83osckoeuK86Ym9BaAbgsG+DFzLqsK8/WG2nWbIJy0LMp/UNg==
X-Received: by 2002:a05:6000:2c0c:b0:405:3028:1bf0 with SMTP id
 ffacd0b85a97d-42666ac2d6dmr4468474f8f.10.1760009402190; 
 Thu, 09 Oct 2025 04:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERTxLYiMQ7fyg7AUq1KMTpPI33xEF9Jny9XfjxZSzAP1Uj6yPDkUrOygCRlA9GBVZ3SpMVsg==
X-Received: by 2002:a05:6000:2c0c:b0:405:3028:1bf0 with SMTP id
 ffacd0b85a97d-42666ac2d6dmr4468452f8f.10.1760009401715; 
 Thu, 09 Oct 2025 04:30:01 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.231.162])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e980dsm37379027f8f.36.2025.10.09.04.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 04:30:01 -0700 (PDT)
Message-ID: <86a16e8e-48ab-404f-9530-d21e5d30db4b@redhat.com>
Date: Thu, 9 Oct 2025 13:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/i386: Add TSA attack variants TSA-SQ and
 TSA-L1
To: Babu Moger <babu.moger@amd.com>, zhao1.liu@intel.com, bp@alien8.de
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/10/25 21:46, Babu Moger wrote:
> Transient Scheduler Attacks (TSA) are new speculative side channel attacks
> related to the execution timing of instructions under specific
> microarchitectural conditions. In some cases, an attacker may be able to
> use this timing information to infer data from other contexts, resulting in
> information leakage.
> 
> AMD has identified two sub-variants two variants of TSA.
> CPUID Fn8000_0021 ECX[1] (TSA_SQ_NO).
> 	If this bit is 1, the CPU is not vulnerable to TSA-SQ.
> 
> CPUID Fn8000_0021 ECX[2] (TSA_L1_NO).
> 	If this bit is 1, the CPU is not vulnerable to TSA-L1.
> 
> Add the new feature word FEAT_8000_0021_ECX and corresponding bits to
> detect TSA variants.

Applied, thanks.

Paolo

> 
> Link: https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf
> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v2: Split the patches into two.
>      Not adding the feature bit in CPU model now. Users can add the feature
>      bits by using the option "-cpu EPYC-Genoa,+tsa-sq-no,+tsa-l1-no".
> 
> v1: https://lore.kernel.org/qemu-devel/20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local/
> ---
>   target/i386/cpu.c | 17 +++++++++++++++++
>   target/i386/cpu.h |  6 ++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d35e95430..2cd07b86b5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1292,6 +1292,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .tcg_features = 0,
>           .unmigratable_flags = 0,
>       },
> +    [FEAT_8000_0021_ECX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, "tsa-sq-no", "tsa-l1-no", NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid = { .eax = 0x80000021, .reg = R_ECX, },
> +        .tcg_features = 0,
> +        .unmigratable_flags = 0,
> +    },
>       [FEAT_8000_0022_EAX] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
> @@ -7934,6 +7950,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           *eax = *ebx = *ecx = *edx = 0;
>           *eax = env->features[FEAT_8000_0021_EAX];
>           *ebx = env->features[FEAT_8000_0021_EBX];
> +        *ecx = env->features[FEAT_8000_0021_ECX];
>           break;
>       default:
>           /* reserved values: zero */
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 51e10139df..6a9eb2dbf7 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -641,6 +641,7 @@ typedef enum FeatureWord {
>       FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
>       FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
>       FEAT_8000_0021_EBX, /* CPUID[8000_0021].EBX */
> +    FEAT_8000_0021_ECX, /* CPUID[8000_0021].ECX */
>       FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
>       FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
>       FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
> @@ -1124,6 +1125,11 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>    */
>   #define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
>   
> +/* CPU is not vulnerable TSA SA-SQ attack */
> +#define CPUID_8000_0021_ECX_TSA_SQ_NO  (1U << 1)
> +/* CPU is not vulnerable TSA SA-L1 attack */
> +#define CPUID_8000_0021_ECX_TSA_L1_NO  (1U << 2)
> +
>   /* Performance Monitoring Version 2 */
>   #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
>   


