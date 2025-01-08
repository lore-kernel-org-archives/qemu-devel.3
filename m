Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD930E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaxe-0003ae-U4; Wed, 08 Jan 2025 13:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVaxc-0003Z8-Qz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:39:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVaxa-00038V-MI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736361557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCnhFQ4K1Ckai5xXmLz7xgvX8Bvb04aiQ0JK/NEBjTM=;
 b=HS5js8wMUkmkPBw+tfhTh6rE3oZkQ7q4zjBXn9fy1UBq30yAaakmEujlhGq9SyQGV4HAhn
 f5WtY68QLhZsP8xxJT0XTdhWHjU0vc8dSK7SipVUC29PEHM1OYrAPjbzMSW7b/GekoyZZS
 2KP0ZXZjk3PMx1rE7oxIj07TkGvSBuQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-KDDQ5wIPNf-GZHcs43kAdw-1; Wed, 08 Jan 2025 13:39:16 -0500
X-MC-Unique: KDDQ5wIPNf-GZHcs43kAdw-1
X-Mimecast-MFC-AGG-ID: KDDQ5wIPNf-GZHcs43kAdw
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa63b02c69cso111776066b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736361555; x=1736966355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nCnhFQ4K1Ckai5xXmLz7xgvX8Bvb04aiQ0JK/NEBjTM=;
 b=g5ZnKinHGGNDwpiIriQhP9ncOmvmc1Xqk96iqOKB00FlpCtQfOhUCqetQPsuGl+LVw
 PKokEKeJO41LFoSomJ/QmkiIIx9W81lSXkOriFzzXRUrzYvzM+I1RL9YP2jGXW5JCeE/
 fN5Bf78RAk8lkRnfwT1ijfCATVPASmvTdtWNs9p71svnJfeM9R2G+ktM/tlPUIpgqLdh
 Wk6MzdGZGZ2/xpiv1YA0Ah0inrFzbnP8Iek7fAC2A2yFCwG2mCawEPDUoxfbhVSxv4bX
 X+YbqHxmnFTVCSPANjqnRsPNf+NNND6PtpwePM30DH/tUpZgeJ7Ip3/YjM1SPiuSriFk
 8/7w==
X-Gm-Message-State: AOJu0Yy9lb0n9Kdd6ikFQfA+mB1YUs5rUJBp+/rM+BAu4IwKrEhWSuAv
 CP7tr2K4A0z4r+WW+vAHuZjQl8EzUoNcvvllX6Lf5Sl/wUYpJv6nerdhxIenNMNoFclBio6xWOu
 OvD/wN+KOI4DtYXFUU35AHdHUT8rtdv11bUs3Sjd4zRhe96pIqgKR
X-Gm-Gg: ASbGncv6Zb8u9gz7qY2Rj00Bep5eH7NAemqdVX5eL8VqeB0rehYSs1emwm1jE1pphbc
 EMmAeZIpZlUlK3aNquc8lbZJxCsj5Eji/35d+9+5kitbnJwXfkbtOSOFqfpqCWKQXf42nPJP1jR
 PnLlETem8QgULmV+im7Eka4LPAcNUSQRENEfYUn4HhIlkRl7ALvYqL/lIwxuvTpTDTKi3kWj5Er
 dQWGsOolniwnMpFiRh+bouMqglon4bNHFUFTuXTLwka4O8CQcM=
X-Received: by 2002:a17:907:7e9b:b0:aa6:9540:5714 with SMTP id
 a640c23a62f3a-ab2c3dab0a9mr26626766b.25.1736361555049; 
 Wed, 08 Jan 2025 10:39:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErDbgQ+xQbbT2Dm/j8sa93hHvPoIfDvlfg+jULS/iKer54Sa6majgWFcodweH8qTHq378S0w==
X-Received: by 2002:a17:907:7e9b:b0:aa6:9540:5714 with SMTP id
 a640c23a62f3a-ab2c3dab0a9mr26624766b.25.1736361554593; 
 Wed, 08 Jan 2025 10:39:14 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe4c49sm2538790466b.128.2025.01.08.10.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:39:13 -0800 (PST)
Date: Wed, 8 Jan 2025 13:39:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hendrik Wuethrich <whendrik@google.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net,
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, zhao1.liu@intel.com, xiaoyao.li@intel.com,
 peternewman@google.com
Subject: Re: [PATCH v5 6/8] i386: Add RDT feature flags.
Message-ID: <20250108133826-mutt-send-email-mst@kernel.org>
References: <20241213172645.2751696-1-whendrik@google.com>
 <20241213172645.2751696-7-whendrik@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213172645.2751696-7-whendrik@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Dec 13, 2024 at 05:26:43PM +0000, Hendrik Wuethrich wrote:
> From: ‪Hendrik Wüthrich <whendrik@google.com>
> 
> Add RDT features to feature word / TCG.
> 
> Signed-off-by: Hendrik Wüthrich <whendrik@google.com>
> ---
>  target/i386/cpu.c | 30 ++++++++++++++++++++++++++++--
>  target/i386/cpu.h |  2 ++
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c6e6cff19d..6f14d6fc62 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -869,7 +869,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>            CPUID_7_0_EBX_CLFLUSHOPT |            \
>            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
>            CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED | \
> -          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
> +          CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES | \
> +          CPUID_7_0_EBX_PQM | CPUID_7_0_EBX_PQE)
>            /* missing:
>            CPUID_7_0_EBX_HLE
>            CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
> @@ -906,6 +907,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>  #define TCG_SGX_12_0_EBX_FEATURES 0
>  #define TCG_SGX_12_1_EAX_FEATURES 0
>  #define TCG_24_0_EBX_FEATURES 0
> +#define TCG_RDT_F_0_EDX_FEATURES CPUID_F_0_EDX_L3
>  
>  #if defined CONFIG_USER_ONLY
>  #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
> @@ -1063,7 +1065,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "fsgsbase", "tsc-adjust", "sgx", "bmi1",
>              "hle", "avx2", "fdp-excptn-only", "smep",
>              "bmi2", "erms", "invpcid", "rtm",
> -            NULL, "zero-fcs-fds", "mpx", NULL,
> +            "rdt-m", "zero-fcs-fds", "mpx", "rdt-a",
>              "avx512f", "avx512dq", "rdseed", "adx",
>              "smap", "avx512ifma", "pcommit", "clflushopt",
>              "clwb", "intel-pt", "avx512pf", "avx512er",
> @@ -1651,6 +1653,30 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .tcg_features = TCG_SGX_12_1_EAX_FEATURES,
>      },
> +
> +    [FEAT_RDT_10_0_EBX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, "l3-cat", "l2-cat", "mba"
> +        },
> +        .cpuid = {
> +            .eax = 0x10,
> +            .needs_ecx = true, .ecx = 0,
> +            .reg = R_EBX,
> +        }
> +    },
> +    [FEAT_RDT_F_0_EDX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            [1] = "l3-cmt"
> +        },
> +        .cpuid = {
> +            .eax = 0xf,
> +            .needs_ecx = true, .ecx = 0,
> +            .reg = R_EDX,
> +        },
> +        .tcg_features = TCG_RDT_F_0_EDX_FEATURES,
> +    },
>  };
>  

Should these be made unavailable if rdt device is compiled out?

>  typedef struct FeatureMask {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index a1ec2d5dde..2b5a5986de 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -678,7 +678,9 @@ typedef enum FeatureWord {
>      FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>      FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
>      FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
> +    FEAT_RDT_F_0_EBX,  /* CPUID[EAX=0xf,ECX=0].EBX (RDT CMT/MBM) */
>      FEAT_RDT_F_0_EDX,  /* CPUID[EAX=0xf,ECX=0].EDX (RDT CMT/MBM) */
> +    FEAT_RDT_10_0_EBX,  /* CPUID[EAX=0x10,ECX=0].EBX (RDT CAT/MBA) */
>      FEATURE_WORDS,
>  } FeatureWord;
>  
> -- 
> 2.47.1.613.gc27f4b7a9f-goog


