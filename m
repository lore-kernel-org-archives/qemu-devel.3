Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87009D277C2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKw3-0001MT-Rf; Fri, 09 Jan 2026 17:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKw1-0001MD-EJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:26:21 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKvz-00065H-U3
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:26:21 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81f3c14027cso60790b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767997578; x=1768602378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1OF3q0o9euMM2ods/E8W3WlOTj2VmQ/dc34wabppG8=;
 b=W0r/PWh7W0Ee8Yu/Ckvx7aLdGuiXuqHLAK0wAe+6B2Cm+yvpdzOaCwkyr7Gjvp9xmw
 g4Q0FdXpcfhr3kfRbEugK9noJiBRYLC0HGCbmXhVHW1FCGJbH2KK/XG3V88MUvdRtQkr
 OoSmuNl2wbSkGJVqT99QBsJbOVfkLZPYs3WimKaR8nT9pK3Yk2JehNpLtrffffRq4kck
 PjJXU9/6eanbOGQbqzBHSKwf2S6Z/MvfmAectgSUd/YiABExDcJ7eCZjgwj/t8v6VJsF
 f58mYjtUdyBUuIk+RQvcQ7W8+Fq8/eiE7SNcqiq1ubmeD3iD4hE4LtEg4VEPddY5j3t4
 71/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767997578; x=1768602378;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w1OF3q0o9euMM2ods/E8W3WlOTj2VmQ/dc34wabppG8=;
 b=he3iZB1lL7fKNId52XTWCs++PbBdaMt+ueqhNSIxqU/CFALDqKEN4crECSRYOQyX4R
 +aV8OUH/HGGQ1g8GaNXQU80ThRnIdyRY8/G6Qnj+acaPtLDrjjfnUUXhsBgkPDTQhES4
 TUmEqUMF8juvFmkrecEhNNsUv0+MVrue+yMmWV2+nYtD4OYshzqY8SeIbE3w7eTWkKzt
 xKkzog0peU7ZiZ4jhFWj55xueXQsyrZaCDHlATdqjNYwQqdsIGOUJb7gt50+DxWk7U31
 d6YPOb2anOMDp/dC97fuk6Ep16Yx2/aLvhyOQ5OavfXh3+7JGrYeoLSGk0pyy4zPoRGe
 0ZpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnVpYNmx8dW2dzO98s+tnP2CRcOQpfb4zYssJYOfYoAaf3aS3Gm+uMr3eZdH1fDtuoxuvf63PgKcqR@nongnu.org
X-Gm-Message-State: AOJu0YzdbCPWCkR0mAC+qPl4soZPF0zMv3K7ZYCnH2WIh0howAK3aAqy
 qIPNnGz39dHFcKKRN6y2QI73Ks0NgNcz1rysu0LzPAwCIq1Xvzo1AInSuH4fAzK77r0=
X-Gm-Gg: AY/fxX5OcvHtn1nSsfxeNvnTYA042KXa34i5WcHpf07O9qLw0okhMccaLYG6EffoAR/
 VYscyDmQU5a9x9ZUSB1rVcOVffCqs86PTBl2IP6D6xgt7K5utt23XncHPKEONxcP7Nu6cnfnnLq
 nTmd83nXRB7JKmetflCdnWSMrnFjY4S/LbL71nIH3pHFKFEcKdysqYpANS76p6afwiAPZCanVyl
 ZI28LtM2vDlQbzGEq6Ckl/u48cMHXgoGaRMAlTKdpNALM1N73KUGryNzQl+e/3ypMImk2C216Zx
 YtVUKALZxRXIeRN6QI7EJTLX+b6NP8dm69ZVB3abbuoqfJMFEMdfn+UcIljnLqw13ezbSNIF5DN
 zsiYnkknivxTdNsftUFOyrGkTXaa4KPg5C3yJ+d+WC6HfJxGUuXgpXN1AWNJ7vEIbuN6/MmlGKn
 jwkpnXxn+z9F06CqVpMydm3/8YZg==
X-Google-Smtp-Source: AGHT+IEcmu6jRUBtdaU4alCd91odtrUr504VHrRrad6uLIA2OZ/6bKlNZeNaJnY3sQsbnjH5pCoDvQ==
X-Received: by 2002:a05:6a00:1a15:b0:7e8:3fcb:9b0b with SMTP id
 d2e1a72fcca58-8194efe1e5dmr12121574b3a.33.1767997578362; 
 Fri, 09 Jan 2026 14:26:18 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e7c16sm11249944b3a.53.2026.01.09.14.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:26:18 -0800 (PST)
Message-ID: <aebcf6b4-50af-4c12-aa23-28113b814095@linaro.org>
Date: Sat, 10 Jan 2026 09:26:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/29] target/arm/tcg/gengvec.c: make compilation unit
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-23-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-23-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/gengvec.c   | 3 ++-
>   target/arm/tcg/meson.build | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
> index 01867f8ace3..99bc4e1cfd0 100644
> --- a/target/arm/tcg/gengvec.c
> +++ b/target/arm/tcg/gengvec.c
> @@ -20,9 +20,10 @@
>    */
>   
>   #include "qemu/osdep.h"
> +
> +#define TARGET_ADDRESS_BITS 32
>   #include "translate.h"
>   
> -
>   static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
>                               uint32_t opr_sz, uint32_t max_sz,
>                               gen_helper_gvec_3_ptr *fn)

This is misleading because this file *is* used by aarch64.  But there are no memory 
references in it at all.  It's strictly vector operations stuff.

So this should be common via not including stuff it doesn't need.
Perhaps by splitting declarations out of translate.h to a new header.


r~

