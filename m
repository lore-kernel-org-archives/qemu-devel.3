Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DD8CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn7G-0004YZ-6t; Wed, 03 Sep 2025 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn6M-0003oA-R8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:00:44 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn6K-0006cM-0E
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:00:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b03fa5c5a89so645838166b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756904433; x=1757509233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yXp8mXCCvT42pSqBeJMxlW3fVjkyM6+EbCBW1JDwLP4=;
 b=tRvTfZDx1BjtyfoYu+/fW+s6hMOWzJiq26HVB1PoqRWCDmrbwNXh4NZ+6sqNgrb6s1
 +1hpReyArzZSQ23+mayKzr9k7jDliaA3smBGuByx4m0sHLz3QDRvx+D3uhhdOpIevxc7
 p7SfuU2kIEZBXrv7p/s3rQMBL89zD1NvSU2oxXD6OamUEQM5f1eNL9SEcZ+eFlxTVDaU
 y6hK3XegLjfysF157liQsJrP3MzNikkzOuKGvJigQ2jHI0eEZ5cygd+02x76ddpbf7n4
 ONRET8lpMilHLEx/JGCk+BhgRWLXR+eIE13mOvVJh5TtBHa62C964ADHKERe64LDOzx1
 xebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904433; x=1757509233;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yXp8mXCCvT42pSqBeJMxlW3fVjkyM6+EbCBW1JDwLP4=;
 b=AotL8cGKY2E9HKOdDlo0xjyQZdQ/cty+I2SIk5oZWoZwhHXJ1wLhLBREV7YVip/aB1
 w5F/0nXj0BN5jd+yPvXzdNK9zHHK4hZv9U6dNQ04n0r5SKOayHycxgSh42d1NS5h/9O7
 onBWmaV1eT0qLUmJTrTM86hm+veNmDac/3T4ZF+Iu2DHkCRaKXV7Iq3tjDAWf+uso8xu
 GBdJJp52kV4XJzxRCtfS7dbm78fP07Eci66Y039edLBSdpc2TnK3o1iHX/aNthieG+oa
 Dz0h9T9ZP+BeugRO9ftuBWidenohRJUCUz45XnVKsriRN4K9bcOAXgoGFiPw99hcnZAR
 Hgqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX40gIKYU7cU8xp1/btfI2jxceBNqcwOb363RWXqW5rsDwygQ8SvCB4tjgzkaUcXZhBj8hbUgARI+3X@nongnu.org
X-Gm-Message-State: AOJu0Yy6uGbPwlj0gYvMpR/ww4+VR9wOGsgjdtKoXeQVRshNflp9IzkT
 9vKrH1x/xp64r7K2IzfFFMQPvpEszVo/mOo+JZWtpqn6Eteo5BQOhGXvzYj+IINo6Z4=
X-Gm-Gg: ASbGncsYVIP1xxNozR7ESE/QaAbxgWeogtlT6TT47MdiWRknv1+gs0KxPUm3RCXPUZE
 O75zfBBkWTVtV9XWiZQMIEX72FV1evN7SdDyVIsbXX+LqKrgr/ebBZ15hVnGl0lOY21Xk9SjIRO
 Orfq3oTtbz+/NryOAbf/f+n2VZTUhgxeX9E6TAJdAKAjyWhsICGPjoG0LKitPm28CeymEI3CsYL
 6drBOjjaeKc7xVnnIMSOQyYBWJ4UVtgmKTOSjaFMIdzN7nwO6fa/qB/zqgZokyI/i740Ktg/enq
 8V/Q5f4b1jPvj7EDWppNH8s5q8jLEzTLkV2ufspRbzkbZW5q0Ao1LZlNeSl7X7ZaXD0TbCIs5wO
 ZQYFkPpd1MJkHhhPQ1dpd1G2alEj9nmyifgJbkhr7cNKzSkCNrjDhLV37QGNbaG0JiqnB8bY=
X-Google-Smtp-Source: AGHT+IHeC85KDtPb+VtO2yRR0f+ScReK15sg7uFrRHK9yLCuiZkNmIX2/TkstQag+4/mfvOhcAt9uQ==
X-Received: by 2002:a17:906:c111:b0:af9:5a60:3319 with SMTP id
 a640c23a62f3a-b01d8a8b62cmr1275651366b.19.1756904433407; 
 Wed, 03 Sep 2025 06:00:33 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff03e9ba10sm1284881666b.52.2025.09.03.06.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:00:32 -0700 (PDT)
Message-ID: <272533e6-867b-4dec-a398-e90381ac430f@linaro.org>
Date: Wed, 3 Sep 2025 15:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] target/loongarch: Invalid tlb entry in
 invalidate_tlb()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-11-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-11-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> Invalid tlb entry in function invalidate_tlb(), and its usage is
> simple and easy to use.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index c074c956a2..ee40684a18 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -161,6 +161,7 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
>           return;
>       }
>       invalidate_tlb_entry(env, index);
> +    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>   }

Why not move it all the way down into invalidate_elf_entry, after we've checked that E != 0?


r~

>   
>   static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb)
> @@ -340,7 +341,6 @@ void helper_tlbwr(CPULoongArchState *env)
>       old = env->tlb + index;
>       if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
>           invalidate_tlb(env, index);
> -        old->tlb_misc = FIELD_DP64(old->tlb_misc, TLB_MISC, E, 0);
>           return;
>       }
>   


