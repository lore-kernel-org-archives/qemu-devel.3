Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E6DD41D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 19:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTm4U-00020D-Ig; Thu, 11 Dec 2025 14:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTm4S-0001zl-Hz
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:11:24 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTm4R-0000bK-28
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:11:24 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c78d30649aso312613a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 11:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765480281; x=1766085081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lO+LAA+IUh1wGB6Mg5yqETSHcE5h/ZK8m4P1AN4vlOg=;
 b=X8mz5TE0z31RlX1nI4Z6QLLKUXdtfjrKLBFgFEQ9ErVMp273pMdbNyfWdmieLDfOqB
 YKcJI91DTUvByDsYaZ4ppaw//Eo2tX+2fZDp67He4OmDEtDnPbBmigqsdCJL0dddPwwh
 zp/7L7fdb4NIr2iEFAUOhXcKwyUpeYThb0T5h8j675iIc6EDzI4zOzQYKYb4kPM97F4W
 oJEvweENQcVmPbh4Qg8aYf6gMCZi9aTi+qNdQ5GIUJhvLAoWfcTQQCJucuc0wJZUpO3s
 AVbGzvZoz6JcE6c2ti1OCr12ZLGQS/tDKlV/9mMdFOtL2v2gt4JEuqTaCEzKnSe2T1eq
 5wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765480281; x=1766085081;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lO+LAA+IUh1wGB6Mg5yqETSHcE5h/ZK8m4P1AN4vlOg=;
 b=iGST2NwMLIimlA4lHaQdmKyk654BfNlfwVPzBq/dESwYx57kXFd9xxsZ+Ok28w8acE
 YP7gHtwYptWjHxYJ3vJaJgCU7NhSLprN3QS+E95JRFfMJ5oPiSfpIfYsUAnbs5E1sMYP
 MBiJiWsNF+J70UPMU9k2W9gU+oKP4cEjVzVvzNE2HXM4zTJvnD0viQTB5Ssq0iEFTD97
 t3+OzMzZETZA+GQiowuDP+TT1BhQToPaEhmW6iQ5KruC+L9a0uZShmTyCtVFpKd1uepB
 Ch6QPVukZ7Wu/sDHtg+r+1iIv2RSUc9yU0SP625MarHM2VJ+7JdxW3FFiW6+AaVhkt1x
 PxKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRFkEVn0AIXw+jbhovxaCoPoO/kQgPjveQksTO4RydWKvMdiOxw+D5Mxi53siaswqN35/CcHpXnldq@nongnu.org
X-Gm-Message-State: AOJu0Yzc1BqpsN4UQhKJusKvVimcBHM+++vk90siI/+Uz1POr0kMszcv
 Ig+rNr68yjZWuuA5UZDZhf3Dxt9PPBu/e+WcwIr4JJ99QetHd/Jnm+jqr9VfNd1oRPI=
X-Gm-Gg: AY/fxX6ukP3N8B8E8NXKEsKBK8qKXluFETSR/I1dzBht3Q0hTPI5yAHQ/MDBj6T2KDQ
 zeb9g9iDKOSB7YTtQ+GNbH6vjiHzg+y7cHwmOnNgOZ5AUXPtDhK9cv81MVF/PmszFfbWm8mhiUG
 TMAVh8u8FyqIinlqUSjR4sZwJs99f/5h5qIxhSHPkHuqUbdGay7yuBqwND2F9uevBS3myosnlkw
 ZODshtPdc23H2bUeOf9UCzEAMzaJidJLG1HJXyJ/FqHwFUYGmTnKCKSYVupOCxbKAFqF/ZvHrH7
 rzaDgBW2p4zZVdg3FakSdW+whSOohGeHY+TC8PDwlTDrix5TceJhYcKhc2iO3wD5ix9E/q91Cc1
 Loj6xxIpjtW50iua6Lq8QkkuItQl/ervm/KlHu71JqyZ1L+GhnH3JHco2eB968RhalL/sMYqO6t
 pS6VpMo4xnbdgzXCkIia1XUMh8b2hciebgqoPy6+bEXhkHsmyaqwXeWRZetl+8mF2f
X-Google-Smtp-Source: AGHT+IHb8DdICB2DaWFhsiw7G+iX/DneljDStiVl4+0t3I7lL5lNBduDt2L7vQfh4F40zYmIx4tnSQ==
X-Received: by 2002:a05:6830:4c07:b0:7c9:594f:2d16 with SMTP id
 46e09a7af769-7caceae4b27mr3961251a34.0.1765480281474; 
 Thu, 11 Dec 2025 11:11:21 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1ff4desm2065202a34.7.2025.12.11.11.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 11:11:21 -0800 (PST)
Message-ID: <46a7f05d-c810-4112-a2a7-84c014e4de22@linaro.org>
Date: Thu, 11 Dec 2025 13:11:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/i386/tcg: add a CCOp for SBB x,x
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-18-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> This is more efficient both when generating code and when testing
> flags.

I guess sbb x,x appears quite frequently in x86 setcc computation, and the testing of the 
flags is much less important than the straight line code generation?


> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index ecca38ed0b5..314e773a5d4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1515,7 +1515,18 @@ typedef enum {
>       CC_OP_POPCNTL__,
>       CC_OP_POPCNTQ__,
>       CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
> -#define CC_OP_LAST_BWLQ CC_OP_POPCNTQ__
> +
> +    /*
> +     * Note that only CC_OP_SBB_SELF (i.e. the one with MO_TL size)
> +     * is used or implemented, because the translation produces a
> +     * sign-extended CC_DST.
> +     */
> +    CC_OP_SBB_SELFB__, /* S/Z/C/A via CC_DST, O clear, P set.  */
> +    CC_OP_SBB_SELFW__,
> +    CC_OP_SBB_SELFL__,
> +    CC_OP_SBB_SELFQ__,
> +    CC_OP_SBB_SELF = sizeof(target_ulong) == 8 ? CC_OP_SBB_SELFQ__ : CC_OP_SBB_SELFL__,
> +#define CC_OP_LAST_BWLQ CC_OP_SBB_SELFQ__

The documentation here could be improved to note that CC_DST is always in {-1, 0}.  The 
fact that you can derive all other flags via masking less immediately relevant.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

