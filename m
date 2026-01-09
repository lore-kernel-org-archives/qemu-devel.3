Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCF0D26D9E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veK4Z-0001AG-Fs; Fri, 09 Jan 2026 16:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veK4R-00019v-4G
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:30:59 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veK4O-0002aa-E4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:30:57 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c525de78ebaso1138560a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767994255; x=1768599055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M7RDNb9Z313QJTwU51j7WmpBiuI7QmsrAd8tQee+98w=;
 b=yAsylq5S/8yZDT7ELVPc4SzIq/LABAQ0l2NQavl894mlK7etLMX3uSLXUqU4rZNRuK
 sVVD5aSMdBfKRs2OSfskh3HZrGRZPhjy1KzI+FUMQxrG2Pz4uSFSBRxZcw5t7pXnJyPZ
 1NhTeZ8ZKEnfagqPoGdA2Is5BUn03geQi6GiFRhonWuG6jWgejjzkC8VCKKqtuwHDsSA
 KMW0mHwz5xb+EFDcM5KObnJlpqC5/HCEAuL3PiNb2KhtJkUddMlx7aEW54q2U3thlr7+
 1SeZBtmmJONFBl7ha7xFVpK8tPaG3hC/Wgw77oWJhVUye8n/dgzJdttPsf2QkZVaMpKf
 VIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994255; x=1768599055;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7RDNb9Z313QJTwU51j7WmpBiuI7QmsrAd8tQee+98w=;
 b=voAMIFdp6Tgg73vuWtIDZHKjVv8kJTaIefuDlY4uQ/trY2I61yuEWQwmVhlT4XDyYU
 CE4MhYgqnvWXH3ExrqpetrwVQYHmlva7AMN79PRhINNo2mVVJtedGGbqf5F08M4omaGt
 xJrG+du13inIJgzwn2GTJpIG62IZe6+/zXd/ZSNbo7p3spJnkEUeHOSsX6TB1MQW7uhS
 kn2hfnaW7XElUnixVKiIOgNeYjLFy7agTxzYYic8p/t9df3NiwW2XPbGahveGdhM3JB5
 JoA0XHZCeIR5A3AyrFbkrIJCDu2oMt/HvKQrcA8Eu7nrUkmCpoGMu48yeoj8uto7f+an
 SkhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrbPZDe7o8f1cp9gklMds26LeCVISjYtzLHzzqkdkkJzwznM8bWm/ZdNB9o2uSj4QfKH/F5+DccgEI@nongnu.org
X-Gm-Message-State: AOJu0YzqomKum/9uHrWAo6CYvPSRIAxfRiTp3V+hx5vnMykJyC/Vdj2N
 +rjCYAEmA8IyKPqFTdXRLowJxTkxSC+v0X0TM6KHCb2r9J+2WhAiLWZwvOlC8qTxasI=
X-Gm-Gg: AY/fxX5kn5xtqLiA1FB0G8jkWqq6Sbi6GAi90LJkoCyYr9ZQj6/sNj/rC4BbzmsdmwU
 6eulprMrO3vDkHF5/Udb7C09TiuNtVHZio/j8fV5wQZTomE7RPBGTKRqLgyO78+t+PJ21Mr+ctF
 ORleTMSUqFLU7MfyLJciBOPQ912PRRvJoT3B5T5+1a+vS7K9q/C0OpGnrrZEnCMvIEsgUi0ZycQ
 3dOa5rdCwyQ1ZaVK1edCUxs9fKnHnHKitmFMnDlmVx5n+Z7PYN23wULaCwliUAj7MP3RrNW8o34
 cnS/Ak2zBqM3EHcBhHODFbpPi1Pqjq5VevFZ3ADlpvtNp5CHbjXvCXDWZ+33Y9a1qoI4Pz9sk0w
 S4EfXMTq5wEoP+Hf3qyqPEKp96g1Wr2D+DpjijOpW0JnHtuHRFXbvBuqBHwflVJ1G8+9Z2KfUve
 d9wjymA1Cb0ZLObF1SRsO7ASDVRQ==
X-Google-Smtp-Source: AGHT+IFZjfRRusHAtxKclTkVni3z9UKvX96yEB49VyZXTgO8IpIjjfKwSXycwU/eG9kEa3VQT+uesA==
X-Received: by 2002:a17:90b:5745:b0:343:d70e:bef0 with SMTP id
 98e67ed59e1d1-34f68c01e8dmr10046377a91.21.1767994254764; 
 Fri, 09 Jan 2026 13:30:54 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa78f4asm11447693a91.3.2026.01.09.13.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:30:54 -0800 (PST)
Message-ID: <059994bb-41af-4fed-a058-b100b4a3734f@linaro.org>
Date: Sat, 10 Jan 2026 08:30:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] target/arm: extract helper64.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -26,6 +26,9 @@
>   #include "arm_ldst.h"
>   #include "semihosting/semihost.h"
>   #include "cpregs.h"
> +#ifdef TARGET_AARCH64
> +#define HAS_HELPER64
> +#endif
>   #include "exec/helper-proto.h"
>   #include "exec/target_page.h"
>   
> @@ -33,6 +36,12 @@
>   #include "exec/helper-info.c.inc"
>   #undef  HELPER_H
>   
> +#ifdef TARGET_AARCH64
> +#define HELPER_H "helper64.h"
> +#include "exec/helper-info.c.inc"
> +#undef  HELPER_H
> +#endif
> +
>   #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
>   #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
>   /* currently all emulated v5 cores are also v5TE, so don't bother */

In the ideal case, only the files that require the helper data will include it. So, for 
example, the helper-sme.h data would only be included by translate-sme.c and sme_helper.c, 
etc.

I now see that while I planned for this with how I set up HELPER_H, I didn't follow 
through with the cleanups anywhere.


r~

