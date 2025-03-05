Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683A0C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpePs-0007g2-0k; Tue, 04 Mar 2025 21:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpePq-0007fp-Gc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:23:22 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpePo-0007to-Ph
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:23:22 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2234e4b079cso115489445ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 18:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741141399; x=1741746199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=88oIzoZ7lfje+NFkURCPAzXxLmYiem6BilocNv06ZGU=;
 b=caBms9f8PGx5Pn8F2d1PbdzgpNFUrr49TjoPynUmCyqWh0oGGEd1656zRw1oSGgOmm
 FsXCHWkXf3EJv5sH2tGqWa0yirx9Xsz9w6OFvRlArVcG0t+7sPmGW3pT0P3GG6Mq8jXI
 baJeRaF9tAN3haY771d2h2jFvOMKtfyvOBGSfSeuSeTEhivAuwn9r5SW3n/NHdaaQw82
 ERH6kL8jRk/BkBO/YIKDpKdzahvmemDXvGXjt1oSdwjpwdYfcMZy6timjLJASN4YEAFd
 Uisykn9BIXt2yG5C1yZzsMtXjLrphDgAQfUI+/bhC3ionr8j47Vs8TzcR6JyzUQ2d978
 I0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741141399; x=1741746199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88oIzoZ7lfje+NFkURCPAzXxLmYiem6BilocNv06ZGU=;
 b=t34+wAI+FXh7FpD8ISomuz/CkqpO4vpSSlx36ejGpMvNQdFYvRMBxmfvMksyalC889
 L4m7jpHXw0GVatRnvQBqSzQ1oci3YrphEoW+hgYpNuj0xiAK8HvbDvcUTPk89UKoorqW
 r+4edToS12tgqBie+eM1xY7ShQ+mkLoCsjV/fJhlDFvLDWWuSDJlH+FpmU3WtH8m9DsS
 NqHDJBN2xhBQ3Ke9YyG+y0QO6EyagQTE2UXA6EH/YDIlHsWFz9IvM9PDeXDTY5ga7U+k
 qdaXUvpEAjabo1GeyEB1n3hdQSd4ZuvOEvt+Jyb3clXVxkRjmATpzdvp392GId20uqAk
 H+sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfULPxLsVannT3Rbgi+JDXZXcfgH6nQhHzecNFf3Tmu2sZAhAfJTgmVjWv6pE0P/K+VXVzeXQiAKeZ@nongnu.org
X-Gm-Message-State: AOJu0YxtltlJSL6s3bnFqSwBF3ZpowhOmY3Hg/FMd5KI26/F/S2NkafF
 Ftn9N72V+gyI0rioi91ya7ex8+vUrx3dmG/kzo5TFCHHe2odLGGJ8k5nXiUaSEM=
X-Gm-Gg: ASbGnctfkRyaJbhmDxHcxj/xBQqaqW0Z7eu45d6IG4Ctpg3k3/VKy774GPZo5P7ad4J
 oEZMPTdNKHL2Blpw01NGSpmhULoh6o2CyZioQvYCwY1DnEkmoWZLyFoBROQmYBTS5PmECvASSey
 +3Fv5SDnuAMAmY8gFRJ3lQqrijiRLwaMtynUWdDulIOO8qpZOC64X81YL5stm9O/+HIqOU2dVQ1
 M0zp1eMTxlS77s2SS/SvqEAF2CwW76ApAmhYeAHG4Kjnojm0PqespmxwzBoZicMR43NRWyMjTUJ
 EjuISASgqXkXMOBaD4XNskb6DysM8xrKdhMLQMahRBAG3MdPY2+eEKXsRc/kkvb26iohp1qRgRH
 UZUHzQgNe
X-Google-Smtp-Source: AGHT+IGybobAO0IGeOfrrvIpLKcyne4pCwc9CfGTNeSpkkTubdKUoFFVwm0fyGSPtSHVgV3dJ1rxIw==
X-Received: by 2002:a17:903:1987:b0:21f:85d0:828 with SMTP id
 d9443c01a7336-223f1d6cd19mr21457935ad.41.1741141398926; 
 Tue, 04 Mar 2025 18:23:18 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7ff9dbsm152767a91.32.2025.03.04.18.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 18:23:18 -0800 (PST)
Message-ID: <c3a1a692-4b8c-48e0-bebd-be9cf760c1a5@linaro.org>
Date: Tue, 4 Mar 2025 18:23:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/11] qemu: Introduce qemu_arch_name() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305005225.95051-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
> Introduce a generic helper to get the target name of a QemuArchBit.
> (This will be used for single / heterogeneous binaries).
> Use it in target_name(), removing the last use of the TARGET_NAME
> definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/arch_info.h |  2 ++
>   arch_info-target.c       | 34 +++++++++++++++++++++++++++++++++-
>   2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/arch_info.h b/include/qemu/arch_info.h
> index 613dc2037db..7e3192f590f 100644
> --- a/include/qemu/arch_info.h
> +++ b/include/qemu/arch_info.h
> @@ -46,6 +46,8 @@ typedef enum QemuArchBit {
>   #define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
>   #define QEMU_ARCH_ALL           -1
>   
> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit);
> +
>   const char *target_name(void);
>   
>   bool qemu_arch_available(unsigned qemu_arch_mask);
> diff --git a/arch_info-target.c b/arch_info-target.c
> index 61007415b30..9b19fe8d56d 100644
> --- a/arch_info-target.c
> +++ b/arch_info-target.c
> @@ -24,9 +24,41 @@
>   #include "qemu/osdep.h"
>   #include "qemu/arch_info.h"
>   
> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit)
> +{
> +    static const char *legacy_target_names[] = {
> +        [QEMU_ARCH_ALPHA] = "alpha",
> +        [QEMU_ARCH_BIT_ARM] = TARGET_LONG_BITS == 32 ? "arm" : "aarch64",
> +        [QEMU_ARCH_BIT_AVR] = "avr",
> +        [QEMU_ARCH_BIT_HEXAGON] = "hexagon",
> +        [QEMU_ARCH_BIT_HPPA] = "hppa",
> +        [QEMU_ARCH_BIT_I386] = TARGET_LONG_BITS == 32 ? "i386" : "x86_64",
> +        [QEMU_ARCH_BIT_LOONGARCH] = "loongarch64",
> +        [QEMU_ARCH_BIT_M68K] = "m68k",
> +        [QEMU_ARCH_BIT_MICROBLAZE] = TARGET_BIG_ENDIAN ? "microblaze"
> +                                                       : "microblazeel",
> +        [QEMU_ARCH_BIT_MIPS] = TARGET_BIG_ENDIAN
> +                             ? (TARGET_LONG_BITS == 32 ? "mips" : "mips64")
> +                             : (TARGET_LONG_BITS == 32 ? "mipsel" : "mips64el"),
> +        [QEMU_ARCH_BIT_OPENRISC] = "or1k",
> +        [QEMU_ARCH_BIT_PPC] = TARGET_LONG_BITS == 32 ? "ppc" : "ppc64",
> +        [QEMU_ARCH_BIT_RISCV] = TARGET_LONG_BITS == 32 ? "riscv32" : "riscv64",
> +        [QEMU_ARCH_BIT_RX] = "rx",
> +        [QEMU_ARCH_BIT_S390X] = "s390x",
> +        [QEMU_ARCH_BIT_SH4] = TARGET_BIG_ENDIAN ? "sh4eb" : "sh4",
> +        [QEMU_ARCH_BIT_SPARC] = TARGET_LONG_BITS == 32 ? "sparc" : "sparc64",
> +        [QEMU_ARCH_BIT_TRICORE] = "tricore",
> +        [QEMU_ARCH_BIT_XTENSA] = TARGET_BIG_ENDIAN ? "xtensaeb" : "xtensa",
> +    };
> +
> +    assert(qemu_arch_bit < ARRAY_SIZE(legacy_target_names));
> +    assert(legacy_target_names[qemu_arch_bit]);
> +    return legacy_target_names[qemu_arch_bit];
> +}

Given all of the other #defines checked in this function,
I don't think it's helpful at all.

I think you should drop this patch for now.


r~

