Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE5DCCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6orB-00022k-Sd; Thu, 09 Oct 2025 07:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6orA-00021E-O9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6or4-0003wt-SR
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760009440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vehNq207aKynKEYYCVHxT4GQfQAO9JInkmFzUxjvzdQ=;
 b=Q7p/XFWxg2B7yomH3xql7nF0Hn++0wNJlzK1v4NKnvkGfITcKKbqhYmfpu49yqEd8oB0iW
 Hh0p9Zbl+TP0NUZbpP7qIHYC2PUQJP8XWvL0AQF/8cKsRsWDUFIW0t4UDAsQCxfg3bl5+X
 IaPArKbEWr0N2X+/5BtLv6QK+QCdQ4I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-cImstnBJOAGmO9cZaEbnbA-1; Thu, 09 Oct 2025 07:30:39 -0400
X-MC-Unique: cImstnBJOAGmO9cZaEbnbA-1
X-Mimecast-MFC-AGG-ID: cImstnBJOAGmO9cZaEbnbA_1760009438
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso876407f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 04:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760009438; x=1760614238;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vehNq207aKynKEYYCVHxT4GQfQAO9JInkmFzUxjvzdQ=;
 b=miMT0K0det4uAMVnbgOHrWL3osfLrcMVmhqSif+AFzUp1gPaofmEUeb5dhoL3ryB9m
 JeC4FG1JvUR1ij05/FMTKzu+iEDI+yldRMJLgtbn+ZQtlolnTe2WWQs0emnGRohnfxXm
 J2fU7qAh/UaF8X9kjAIH40OyY7Tuh9QzxyHL413TFXb8FRaMuyLn8cSd92AyyiB0dPzl
 Ne3EzzgxqIFF5TAi+Cu764OmupwVR5uRr7m2I1bIrtYc1skGXsy9ErZaz58G0uQMFH4G
 KBzu+kL3M9K/fTokunA4FeN0R5pvUuCtlGpk+3EXhKAOjpuBHgZJLvmGK0gK7+mrC66X
 FqqA==
X-Gm-Message-State: AOJu0Yw73unt3pQYW5EhsJu1eFhfehgSon+Bybc9xCFM73IAqz8BBR9F
 6FfVwpgN+KPt5qgpeH/mPdDwgO5yA816GhIpgLPzKPW0s6vBdecCSN+MpTie299jzwCxa31c0AX
 4t0GZ9++hRIOVL8ksOXFuTffT0iLWdAs1McPk46PyxnP+fMSelSf6mBDz
X-Gm-Gg: ASbGncsuNzY+0Z0GJfDQylrj4GThC7hUlAmstUohL3P9GLBZ20Rioekl5vYEBsbggAM
 5VHp1EcqRjKRBJ0QJjG9fOrwDDfbl1nfsiynG2wClyZzoPPCzW9SnvyCEUqGS8XqpPnZio774G/
 2ROjihM+1kPWIGYEFNssLemRPH1887srVGyLNdEL577uEOtr1CpJETwUKIuvtGvFjbmIdWaEoin
 /PpCIm4QCHCwoiQ7TzqtP2QLNdumndTNH3qpcFBNXfn4ODVOypdW+DHjHTzEwraq7QkAqsbXNx9
 xap8PKH4iRNNyeRxSrwV0ZS63jOYdo1t8l3yy4TXRhnrAY52MMpuUlKXYsumZ+Tgy0CudDCCFTr
 H8QFCKFlHtOneqW6/+4AdM6JKTQr2XC4bojAFZTHtbKOiLbWBkg==
X-Received: by 2002:a05:6000:1ac8:b0:3f7:b7ac:f3d4 with SMTP id
 ffacd0b85a97d-42666abbbc1mr5654673f8f.5.1760009438242; 
 Thu, 09 Oct 2025 04:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlP8l8EyfW7rcYqytt3jcelkFrNeuCHobP5tZUApaXWt6cy00Cg4gyA/v9+mAmCJ5tZDAP4g==
X-Received: by 2002:a05:6000:1ac8:b0:3f7:b7ac:f3d4 with SMTP id
 ffacd0b85a97d-42666abbbc1mr5654561f8f.5.1760009437420; 
 Thu, 09 Oct 2025 04:30:37 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.231.162])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9703sm34718441f8f.30.2025.10.09.04.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 04:30:36 -0700 (PDT)
Message-ID: <9e9f5f0b-ad40-44c2-97a3-9845f2e1ac6f@redhat.com>
Date: Thu, 9 Oct 2025 13:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/i386: Add TSA feature flag verw-clear
To: Babu Moger <babu.moger@amd.com>, zhao1.liu@intel.com, bp@alien8.de
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com>
 <e6362672e3a67a9df661a8f46598335a1a2d2754.1752176771.git.babu.moger@amd.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e6362672e3a67a9df661a8f46598335a1a2d2754.1752176771.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
> information leakage
> 
> CPUID Fn8000_0021 EAX[5] (VERW_CLEAR). If this bit is 1, the memory form of
> the VERW instruction may be used to help mitigate TSA.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf
> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Applied, thanks.

Paolo

> ---
> v2: Split the patches into two.
>      Not adding the feature bit in CPU model now. Users can add the feature
>      bits by using the option "-cpu EPYC-Genoa,+verw-clear".
> 
> v1: https://lore.kernel.org/qemu-devel/20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local/
> ---
>   target/i386/cpu.c | 2 +-
>   target/i386/cpu.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2cd07b86b5..d46bc65e44 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1274,7 +1274,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
>               "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
> -            NULL, NULL, "null-sel-clr-base", NULL,
> +            NULL, "verw-clear", "null-sel-clr-base", NULL,
>               "auto-ibrs", NULL, NULL, NULL,
>               NULL, NULL, NULL, NULL,
>               NULL, NULL, NULL, NULL,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6a9eb2dbf7..4127acf1b1 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1102,6 +1102,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
>   /* LFENCE is always serializing */
>   #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
> +/* Memory form of VERW mitigates TSA */
> +#define CPUID_8000_0021_EAX_VERW_CLEAR                   (1U << 5)
>   /* Null Selector Clears Base */
>   #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
>   /* Automatic IBRS */


