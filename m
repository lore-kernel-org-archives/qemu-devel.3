Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB722C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX1zI-0006AK-Ou; Wed, 02 Jul 2025 14:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uX1zG-00069i-FS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:15:15 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uX1zD-0002Wh-VQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:15:13 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-612033bb26cso408154eaf.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751480110; x=1752084910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AxQhK9pKqs9jAdyZ3RE1U011mfYv3GPygX6VrXFjJDI=;
 b=nYcPKTzj7w+3beAzr1tc+x03jezXJSPu/74/r7WjmfplfYvgCuD9b6UP21h3f2zPCe
 V/X63QYszGmdtSqXNMvlw9GDRM5R/8KzUXiRNFqSDJ+8kgZrt2zijHKLey1sBJb1Md+1
 OlQZ7U+7bzXGeoAnqjF5XRCvNp9LCiSLjWeq5oB1BkSPZc6REwdy8bQ3ZndVGeeCNWTJ
 C4tjEb3P30JCC65Iw+w5OYJAf0H7BW7TMWp3OHTTuFT3e0JcUEYwOKQ1IDxJJjvA0i/s
 m2tYJo0Gv0nUzGPDskBRs5cAsTjBFeEV7iiETwUJP/bA+lv4VAyRaL+inuhsmBqNGItU
 9CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751480110; x=1752084910;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AxQhK9pKqs9jAdyZ3RE1U011mfYv3GPygX6VrXFjJDI=;
 b=a4tEIotb2423GOFkg8KMnFqSQyi1IchAAKzQrJ/fRhgfqq4qfhm+g6Zj18Zf7nasbb
 R1S1bHmSSTi09X5xVmXuML+/3f9Ncc8fmM59XOZggt8QmXq+QETf7cADzmXJRXveHv+G
 Ttq38gCjzQtq+0k6dkdKgwLfq2VfFud21UlNDLLTpa0fRGMP4bvFq5AmWysvbttIO08Z
 Sg84m4UMJJ4Y2YOumIJGDfeueE8j7ffYqLKCNN66ADj2jsCZe/a4qd7kURc3D6U/qVvf
 3WxH+5RbwR6HhXHU2a38mfsX3ha/HEU3NtkTrvPDcad8IKa8gKIeEs64KOzCEcWPeJEs
 riog==
X-Gm-Message-State: AOJu0Yz1ceUhT8MkZ0/YNXUY9TGoeuYqWTP3EmLOIoPqSK2MNmo+P95N
 es9r24QQKqzveN7cTRlVUWriXBLgXI1zVVN7Uvss8XkS/69wiLD0HuEURUDbR+3ozz+U5IZWSKh
 XswbnHz8=
X-Gm-Gg: ASbGnctejq3ojEkBBYtYTfYNy9QFyomVb0NpAEq/ZgT3hNPN+o6wvhldxacQ0nn+4YP
 myuyXFpkXqJIgd9yuUOj4U4ffBp12Rw8gdLQhgSVKoz1KUagQyMiiSDoHu8gLxIInEnmEiKiCFS
 frgxu0ifsqxD2QZiIZuLZCg+AcYm/DR4H5XsnRc9hfnsscBwo4shEa+vyjLucw6ojfzqoSV20t5
 8eNoK3pLEhaQbYRZNNr8MIB5y1sUu3o/lQMAJ8VZeFJ5X5I5to5NSgJV0JkUMV4BRBUaW3H1koW
 Hq7pDLhtka+nns4vxGkHdADpEBJ9nYoZXlhojOFz4Cg5S5LE5Vo54zU5bx/YNo2PdMnfzDYj26Y
 4Z/rzmye20+acSmU=
X-Google-Smtp-Source: AGHT+IFAWPf2q5OegzoRVxy5LwtkzSOLnEuTgExX1Wkl7lEtXIoy6QgC/w8MKRb6XZQGSwDyFZtBtw==
X-Received: by 2002:a05:6820:198d:b0:611:e30a:fa1c with SMTP id
 006d021491bc7-61200f7034bmr2463789eaf.1.1751480110083; 
 Wed, 02 Jul 2025 11:15:10 -0700 (PDT)
Received: from [10.225.72.227] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b85c84afsm1777352eaf.40.2025.07.02.11.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 11:15:09 -0700 (PDT)
Message-ID: <78bb2fc1-bdd5-43b1-83a8-b4e3a37d1825@linaro.org>
Date: Wed, 2 Jul 2025 12:15:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] target/arm: Disable FEAT_F64MM if maximum SVE
 vector size too small
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-7-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250702122213.758588-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 7/2/25 06:22, Richard Henderson wrote:
> All F64MM instructions operate on a 256-bit vector.
> If only 128-bit vectors is supported by the cpu,
> then the cpu cannot enable F64MM.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu64.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Ho hum.  The idregs reorg landed overnight.  I will update my branch, but will not re-post 
right away.


r~

> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 200da1c489..c5c289eadf 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -237,6 +237,12 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>       /* From now on sve_max_vq is the actual maximum supported length. */
>       cpu->sve_max_vq = max_vq;
>       cpu->sve_vq.map = vq_map;
> +
> +    /* FEAT_F64MM requires the existence of a 256-bit vector size. */
> +    if (max_vq < 2) {
> +        cpu->isar.id_aa64zfr0 = FIELD_DP64(cpu->isar.id_aa64zfr0,
> +                                           ID_AA64ZFR0, F64MM, 0);
> +    }
>   }
>   
>   /*


