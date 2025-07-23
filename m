Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CD4C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYL9-0007KL-MM; Wed, 23 Jul 2025 08:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueYL7-0007AJ-8I
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:12:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueYKz-0000st-9x
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:12:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso3962525f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753272761; x=1753877561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SkEGo6VsCznhDpms3T9HiDB427zOaqvA/xUszzAoVRk=;
 b=wMzAR4ZIGM9u579qqz12nKD7KF7ohoazP5z1EApEgzAHK74LysnKjxXU1R0WAqDt3x
 tTrt6sYU4Qq/xoMriSrbiZuxV7DoEMMuJVv9BryIqtp7PTSkHp5LbWfjI2MQIzyGEZU6
 ksfGKaIqa2OSFYeF0+7d5gyMn2i6HEg2zZxAAuRBMn9Jl4rs51xM1ie2C4G0WfvYqvz9
 eEznt+XNCmmyDVjt9E6SllVvBugeVQUq0fRaUhcWkcIqPx/eiER1Ot5faOK/AMfZn38p
 EZUFdUYOcgw8e7bzs0xlo3+9iEsyU3JsEEwznMLrplfVTY+ASr06zKgUAYr1NVmlsMl8
 MliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753272761; x=1753877561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkEGo6VsCznhDpms3T9HiDB427zOaqvA/xUszzAoVRk=;
 b=mFoCYJq6Sy7Uxhvz3V1ZE5inUXmqGJI7bK2fd4vg46v6mfKDTQqZ5O0exhGuQIJlY2
 5rHbXCozlDJFgM9ry8swx2Edx2S3ni3A6H8hsBjCygxptOzsCIdov5QZT9IOcczoX6yb
 wAG5QHFWRMeiKFQkGdgcgTn7AhbAhGlT08NvWK8RmkIKRV4JL8uEYGIM0kOX391PTqt/
 Hl5fexSC2FoV3qN4b6C24I7a8UrgeQVIuEeO4gm/bISQE/NI5yw+QhrJA8aPvh/m26Gv
 SZdDUTAUMhGBW9PmIqF0IkVdy2bSBcawpduWKZLKGfVjaar/ZCITf33qeTFh8jTB3cai
 sHxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv60WaGOecsnsB8ml/FUdh6dHJPbPlcRPlQFX4Yi7JgaNll4zGYgfGyHDxmyJrUnlLVgrfN5TdMwEN@nongnu.org
X-Gm-Message-State: AOJu0YwU7Cm5sq1Diwp2UrdAQGSibKmtB3nyh28IM2T+6SUD6oHI3zYB
 riSvu/inpXdxU/hBMtP3RJM0z3w7Zof0kYI4OacTnryEZL/REy5dmUpNvD1zWaUd52CLP8nLL6q
 jUH1N
X-Gm-Gg: ASbGncvoxcKxVxFpkiPYwhR+7o/G3jHHeoKDcUnX4wvkL7160DYYbtYY1hEjVuOrwXe
 pmZvbVHnjgEGp9D84gXP8P7Lp9v5cp4+VsvwnWr6pQp5WQ4fMUCFLwFnFMqUD9xf1+/d1RLFTfr
 uPo5bl5YDNq1zwUV6B0V0v6zYjGQ0RWWIkxLdzZAxPn+AxOm6LbDKW1ajnqA0mJ+TwU4k2RqTgq
 hWxEFUEEm6GK3F3wWSgoz6v6vu06Q1FzRE0brOHO3gf6rgE4ZC4XXo8sqEPpvq4gu1cNWs7/047
 p8Rcrl3tLshHSStGYvhl9ohrUAlXeBNSOSc86j2aKvk3ckj+ywf8dSH2Lyie1WQge/tgfd6i3Tc
 wibTBT5/XB1hkiL4ohfQsQi8m3/R18y9bCEdYonQ0nESsXXW2F7hE2+8t6FxK0rbRARPwJS8=
X-Google-Smtp-Source: AGHT+IF1F1TfJD0ueFulF2LKuoUKjMJX7b1L1QFhnWs/BpAUUnAKZA1ZrKYqcBTzoRLOBKj0/dVJiw==
X-Received: by 2002:a05:6000:1885:b0:3a4:f70e:abda with SMTP id
 ffacd0b85a97d-3b768c98f5fmr2247123f8f.10.1753272760887; 
 Wed, 23 Jul 2025 05:12:40 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf4bsm16056820f8f.31.2025.07.23.05.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 05:12:40 -0700 (PDT)
Message-ID: <62a3b621-d078-4c2b-be2e-9bca1c569119@linaro.org>
Date: Wed, 23 Jul 2025 14:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: fix TLB huge page check to use 64-bit shift
To: gerben@altlinux.org, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <20250722101816.16528-1-gerben@altlinux.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250722101816.16528-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Denis,

On 22/7/25 12:17, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> Use 1ULL << psn to ensure the shift is done in 64-bit arithmetic,
> avoiding overflow for large psn values. The 6-bit psn field allows
> values up to 63, so 64-bit shift is required for correctness.

If you are really worried about that, please use the simpler
extract64() method instead, it is much clearer to understand
when reviewing than (unsigned long long) casts.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   target/mips/tcg/system/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index eccaf3624c..b8b8747064 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -652,7 +652,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
>           return 0;
>       }
>   
> -    if ((entry & (1 << psn)) && hugepg) {
> +    if ((entry & (1ULL << psn)) && hugepg) {
>           *huge_page = true;
>           *hgpg_directory_hit = true;
>           entry = get_tlb_entry_layout(env, entry, leaf_mop, pf_ptew);


