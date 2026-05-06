Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B68FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcoG-0005p9-VA; Wed, 06 May 2026 10:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcnz-0005Ip-IM
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:56 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcnw-0000as-Ni
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:50 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so2953891a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076047; x=1778680847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iDA+dq072yUY0/2j22IQWd02WnCyJu7JuO7vogkNwzU=;
 b=P8YL5mMeaDFQY7s+yOaBql7MKD8rMRm0VhASRExNpnWs04IG6K0s7MyRwCTZ22Evp7
 ZPPmeSTR2hTnBboKhB2WR7Vk8Rxg+xBh8WjFr7K6PRUKDdL5vhrbVAHFIW4gIpGDwtL0
 hZ2HFOcpNui+kp6q4W6JvzEaWGMrxgMcAYLHS+1tocqER+jqBh55NAZd9u338ydQgJfi
 bSxrYAnRm96j6ceT8yMGpTZhLNIB/bJsw+g4B4li2bgDFHD2tKN9OR1HK4iUWSitvksG
 WEqyxVROKJU0aoQAUbOzcZcWwE2J+Bvl/tBmg30diovs0PHSPGSevqMy6AwSi0AQIYF4
 nkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076047; x=1778680847;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDA+dq072yUY0/2j22IQWd02WnCyJu7JuO7vogkNwzU=;
 b=X4wnZaQPo2GC5au6G6qZ+2SQTaL1jiIg5u4Rig0Z5NUmoLslmBfQHZaVaKIYMf19Ah
 L9lwUzNS4g/8AI70fn9GaOI/3eb+bhPNw4LRwi34DVWlaSgLDHhIia4qVlCNLEc4zDjF
 h0aLOYr0CIfn9iuuQYhpoLETdt4RH5FPtJiMxf0/j6E0C70srrLAbIwghnr10sBtKPFl
 D+Jfk4yBGXr1md2j704gUlk6T4yECaD2ZQfo6iQELnzyO9KT23eah0Q+XcJAKKQw+fdW
 /IKnCSrbw8uEg1iEW+gdy2JKZ8z7gVo9HJPfzeqG91KP+OlEO2xy5Uk+Yfwpqn5iKdH8
 RM9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ++dq9p43+7/6u3Zj/rjHtCEp64MqvRq/NTbyYNT8mwRX7GLlnhYKWOvGnE+DMYkSxBBS4cFLGL74Yi@nongnu.org
X-Gm-Message-State: AOJu0YyGYlgpJO6a18SCTWHk741EPESJzupxwt1ZF+8nymojVOQhHBOp
 Ihhq9cmJ9CnV3vANFHIszH0BnV7kz5K/iEuTZqXzQhIUjoop03Z9Pd+AmKQq5tCsl48=
X-Gm-Gg: AeBDiestgUcCwR7KV7N7QVB0Y/Pb/NCHT3oiWuh3ikSzdh9sktX/GjR/lYz9IJLQDlw
 +2rEYNkSqbd+1uAeuXELqE9CCEQe6bx/sGtgdpNo6OLGyuj6BtPiBmnxPMCtrx/+PFkpuCERf51
 mXcn+iYMQxcdBzu3QXXbKPrz/0+z/DKb4xBkRpxkkR8o2M1/YpL1tjHL1B20s12suXZhaIhucV6
 ZQDO/RWclVBPEgUQ4g4+ft1YpieFdDV/QlCyJwMntanGN9SC4K7RoGmrQvAch7GC/T4hPRxPNTQ
 Xd35IXh4ss9E1Rtya8146qe431bAZpR80XbJZQVOse3JXRhIoxWyLbckOOYvljl4LzI6E7rj9yK
 wekElBKmbZJUy3gLJPgqJJwzCnUD5GzZjwPTU85JmhksE75mIGzuzBEQfzhJFCjryUGgU6jJznQ
 6r5ShDAZWLNu/kMog+4c+gfeY2HVdjLxChNxDIN/C+S0szAkb9yjWxjELS96jXMWa8JAHesxAgp
 ym6LaY6z/IXYaNM9JKn
X-Received: by 2002:a05:6830:d86:b0:7d9:f50f:968a with SMTP id
 46e09a7af769-7e1ded2af42mr1658654a34.5.1778076047102; 
 Wed, 06 May 2026 07:00:47 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca7a5e75sm12040005a34.2.2026.05.06.07.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 07:00:46 -0700 (PDT)
Message-ID: <eb2e62ba-085f-4d2a-b339-d8113853acf8@linaro.org>
Date: Wed, 6 May 2026 09:00:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] target/arm: load on canonical tag loads ext bits
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-9-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-9-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/4/26 10:50, Gabriel Brookman wrote:
> @@ -304,7 +304,7 @@ int load_tag1(uint64_t ptr, uint8_t *mem)
>       return extract32(*mem, ofs, 4);
>   }
>   
> -uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
> +uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
>   {
>       int mmu_idx = arm_env_mmu_index(env);
>       uint8_t *mem;
> @@ -317,6 +317,11 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
>       /* Load if page supports tags. */
>       if (mem) {
>           rtag = load_tag1(ptr, mem);
> +    } else {
> +        uint64_t bit55 = extract64(ptr, 55, 1);
> +        if (mtx) {
> +            rtag = 0xF * bit55;
> +        }
>       }

Better as

     } else if (mtx) {
         uint64_t bit55 = extract64(ptr, 55, 1);
         rtag = 0xF * bit55;
     }

>   
>       return address_with_allocation_tag(xt, rtag);
> @@ -458,17 +463,19 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
>       }
>   }
>   
> -uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
> +uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
>   {
>       int mmu_idx = arm_env_mmu_index(env);
>       uintptr_t ra = GETPC();
>       int gm_bs = env_archcpu(env)->gm_blocksize;
>       int gm_bs_bytes = 4 << gm_bs;
>       void *tag_mem;
> -    uint64_t ret;
> +    uint64_t ret, canonical_tag_val;
>       int shift;
> +    bool bit55;
>   
>       ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
> +    bit55 = extract64(ptr, 55, 1);

Sink all this...

>   
>       /* Trap if accessing an invalid page.  */
>       tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD,
> @@ -476,6 +483,35 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
>   
>       /* The tag is squashed to zero if the page does not support tags.  */
>       if (!tag_mem) {
> +        /* Load canonical value if mtx is set (untagged memory region) */
> +        if (mtx) {
> +            canonical_tag_val = -(uint64_t)bit55;

Down to this block:

         if (mtx) {
             bool bit55 = extract64(ptr, 55, 1);

> +            switch (gm_bs) {
> +            case 3:
> +                /* 32 bytes -> 2 tags -> 8 result bits */
> +                ret = (uint8_t)canonical_tag_val;
> +                break;
> +            case 4:
> +                /* 64 bytes -> 4 tags -> 16 result bits */
> +                ret = (uint16_t)canonical_tag_val;
> +                break;
> +            case 5:
> +                /* 128 bytes -> 8 tags -> 32 result bits */
> +                ret = (uint32_t)canonical_tag_val;
> +                break;
> +            case 6:
> +                /* 256 bytes -> 16 tags -> 64 result bits */
> +                return canonical_tag_val;
> +            default:
> +                /*
> +                 * CPU configured with unsupported/invalid gm blocksize.
> +                 * This is detected early in arm_cpu_realizefn.
> +                 */
> +                g_assert_not_reached();
> +            }

This doesn't need a switch.

     ret = extract64(-bit55, 0, 1 << gm_bs);


r~


