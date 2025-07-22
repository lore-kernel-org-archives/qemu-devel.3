Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB8BC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueE5Y-0006IR-Bv; Tue, 22 Jul 2025 10:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueE5S-0006FV-Qg
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:35:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueE5Q-0008EW-O9
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:35:22 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-235e1d710d8so60072365ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753194918; x=1753799718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NE4TtM8k5OYTN+7ssV3Undb4RQNht2hNnEovKw/hVHM=;
 b=VW+F7fNG5bc8wpFNUtP4UgYaRsw0FPt8TvlrvwamE7Bgvl8eiFKNlb1H2KGhkQUFDh
 3EHAYAUCAyt6M05NH8Pth94rFlOTIh6YRGwOsclyc3KflFh1wHbZj8w9pZzF5m7+EqeI
 ZcJf2WzxLeaPkgKFE8IsIH3hKP1BHwsrnm/svW//GXfzVzQRb7GD4RGbIv9xbqzPcTWk
 V2S3vBT0hD/RoIRn9KrqZBOgnRrvvDxlYnqENdcoJtK3oYiItQz/yy3ddq5umi/8fehn
 roHZsdLkaZqKv4qVyrygXh9WbtZaadkedy0sRB0b1tiSllcGQ6kcGzr9dycOjlaX2ixP
 qyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753194918; x=1753799718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NE4TtM8k5OYTN+7ssV3Undb4RQNht2hNnEovKw/hVHM=;
 b=DVyMbiZhYOzodeySnPnNCMaSI3wfsd1V3rg26DCL3jE7y5b3aAUqpQU+I4RKHoP/5/
 hO0W9j+f7BXI8vEHe6wSNzBiyYhodNvHdP7dGvPyA6Mh70a9ULQzN8/56SGu2bcRi3Nb
 StLB+d8Fd1CACJxdrPzhrOglyT5u1ZnpnMSnj1QaFQz4HhTy2OpMnUgxcm/ONYLIijoY
 HJStYt1mIMKkfEQCSb1rR7c/qMh+0YCwKm1c6npcrIHG1IV5k+9bMWaEfdPMvpvywdad
 TjKS9XaoBH1DBCqxDg+I15Y89q4xB/dR6J1/hxufvd5hhhdN+NtcjCsJMcqQDZfbjAyv
 VLSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC0utQrbk0nTS6G6pjlpzpHVFsxOp6JkdAe/GYvlhjCuG6x6MZ2GVptPcOYo8gW8ofsyLvmcbF7LBf@nongnu.org
X-Gm-Message-State: AOJu0YyY0qtozEGx9TXZ88IUxIleOQzmNyfegOgMqod5RjZ70C8cP0d4
 Eik7wQrmG5c/IqX/8b5LqZ7KA0gJNKQmbHFJY0+3azKR29/dsRALxWv+qbcs/kuyubxSmnFRieL
 yKJ+1
X-Gm-Gg: ASbGncu3yJJKmTIgJS74hKz/rrSIquOlJGBV5LoJ2kaLFS40xXhDLVZ6AEGibXDnpXt
 GJl7V9QcfMWnykY9U4OXcp2/pKs6bR+3VpZTuFrCov6bePUxtifZb8boD+9rAIoaTMqS0DEDDJL
 FTi5SKL2LQY3BAXDsCndXWPfiKjlTA0hAgJ+Nd6sQYWNhOTOU9wUZrT3fjBwScBzJ0AVWyZnTHg
 htrGFgH9oiiifbDKpJ9xZZUbV1JQeWes/JoC7rnFG7T63K4PUEe9Rf8tVTcJDH9v9vHJ2PdSBpC
 q3umFlR0psKkS+S++ys7YNM7p3TKY1efWFMgHeABQd8+NCLwYYehJYhb/t6c0MieAhON5AcZRjx
 0zJV+yu9B94zsYxIW/3D/rVXv3vopzgL2gORcZ1tsrpjwEkI=
X-Google-Smtp-Source: AGHT+IGdj+pK4CucFpob0WjS1bxOdwYcv3zhKjV8+hnBRp4Pao1CggYm1qcXA7447K4Qp3tkPBp/Ig==
X-Received: by 2002:a17:903:1447:b0:238:120:134a with SMTP id
 d9443c01a7336-23e302cad77mr331040765ad.22.1753194918236; 
 Tue, 22 Jul 2025 07:35:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e2e5csm77496005ad.14.2025.07.22.07.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 07:35:17 -0700 (PDT)
Message-ID: <5ab2be93-2551-4c82-886d-3cdf47360322@linaro.org>
Date: Tue, 22 Jul 2025 07:35:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: prevent overflow in BTLB entry size
 calculation
To: gerben@altlinux.org, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <20250722101902.16613-1-gerben@altlinux.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250722101902.16613-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/22/25 03:18, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> Cast len to long long before multiplying by TARGET_PAGE_SIZE
> when calculating btlb->itree.last to ensure 64-bit arithmetic
> and avoid potential overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   target/hppa/mem_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 9bdd0a6f23..0c196b5bfc 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -766,7 +766,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
>   
>               /* Create new BTLB entry */
>               btlb->itree.start = virt_page << TARGET_PAGE_BITS;
> -            btlb->itree.last = btlb->itree.start + len * TARGET_PAGE_SIZE - 1;
> +            btlb->itree.last = btlb->itree.start + (long long) len * TARGET_PAGE_SIZE - 1;
>               btlb->pa = phys_page << TARGET_PAGE_BITS;
>               set_access_bits_pa11(env, btlb, env->gr[20]);
>               btlb->t = 0;

(1) long long is always wrong.

(2) If there's truncation anywhere, it's in the type of len itself:

       unsigned int len; len = env->gpr[21];

     However, from the comment at the top of the function I deduce
     this is a parisc-1.1 thing, where gprs are 32 bits, so this is
     producing the correct result.


r~

