Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739EBE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLl9o-00083L-Sd; Thu, 12 Dec 2024 10:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl9m-00082a-2m
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:31:14 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl9j-0001XW-M7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:31:13 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e3167b90dso236096a34.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734017470; x=1734622270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WlfERbgb4riEySlZ/Stz3jSYxbr7KJDfl/iu475vqeE=;
 b=rvmvJ4Y2jx8zcIV9R4/uq5lmHuYQ/SvkMAMjBCehhtt/4lXlnLIZBoX9cUvh0QVKUx
 2jKDXvMumoJwLcjmyt7k70ayGahBW9J2kzuRj1aPiumZzCH3OUV7+w9V4Uzyda6tSpbY
 PEPlpWIUtFHZNz9/m5slP++sAzleey1tSrYHZMTxC/wLH/f6EPWOdm9pNXm95j9v4lr0
 ryH9rGeoJy/02a8s0LAtlM2rJnhP3cIVgVkcR0WHIJvx439dAlJzHXMtiJ/2reZxTxEp
 S1AKVJmsqsRCpp+ZetnZmWT0V6jNqwwzaLgqGhGBcETp3qdUkr61Sp4y1LA+lGywdEe6
 T1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017470; x=1734622270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WlfERbgb4riEySlZ/Stz3jSYxbr7KJDfl/iu475vqeE=;
 b=Qhkn+Q+ZAnvSEkGl5ufi6sFrQVTesw7ms9HZKSVOObfvcq9j7WiaJ5ayLJQbix8zLj
 FEx+vhrCqf5/uc2nzwLkRjjq9a/Jh/TKzkXs+cRwWt6EV8uhmKXojIjEG3bkwVHVWqQV
 OicJR/2dpYKCexQBTM6FvQ6OLy/t080mUfG83h/Feq996iNye5guC+jdqDj+FOkMxsaw
 4MqbUyTpA4iMR7YFMHXGrf+xRI9n+lCcV7Z33OqFxIiMfSGFs26gw8zc96B0dXXyMzBP
 bwvBZMzpTn1BI7HHQMBTSmzwfSQe/Dc8RwFBnkvGgsN4SPKTdazzyjH3z7/gwQ+XDnR+
 KWLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyxw87dZdStB3NF/ADRZ8BlmcIoDLV+lxAZN94JGjOBPHhHu5brjcX71PABL6VLVCOODxodJGLJUdC@nongnu.org
X-Gm-Message-State: AOJu0Yw+GUilRkOs34YWvMgGho4sF80uQeJZP55P1ygxYIBlN0tzWcm8
 QFLp2A8xnSciGnGIWj1caxjtG0of20Rtchf8UqjRXRpn8arvgNedEvght8EhY5Y=
X-Gm-Gg: ASbGncuOGa8MSsU7OP3Hn0lpmFheFf005aUeCRiEvS7u7zKoQs5Tgmr/vVr1TaWM+xz
 DM+mlaE3wD0Mz25xdFhG4uKxIiEi1C5oxZeexWIsWx8CRAZlBTiwQYwq+iHLtmfz1PruN/opvrw
 8k1uCzOjqRDXJaL73AvInSkpOwPTQHLQEg0vNse6eNjtBKgezrxHpSrDmceJfoFCks4CHq1ozN8
 AV3hG2Gqu3TYNcpMABpcqCxkdLwRisz5s8JSbSCnFh+3bBsAQiyiCqLwk8RLOTaPF7oyfoB3vqJ
 VOUZpd4Az3pr5c3npveZ4tWMD1+b/p2wVH4=
X-Google-Smtp-Source: AGHT+IF+dJHYMTT1Y0d7YkvmjxkGSbo19YTta71fCj8hKRN8NPAQB+IRt+4PL7tgOSdK1gH0L3Ms9w==
X-Received: by 2002:a05:6830:f84:b0:71d:634a:e0d6 with SMTP id
 46e09a7af769-71e36dddc30mr424285a34.6.1734017470084; 
 Thu, 12 Dec 2024 07:31:10 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e2a8f7febsm421128a34.9.2024.12.12.07.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:31:09 -0800 (PST)
Message-ID: <12e76b66-d81d-49d1-8440-8325c4e86dbd@linaro.org>
Date: Thu, 12 Dec 2024 09:31:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] target/ppc: introduce need_addrswizzle_le()
 function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, npiggin@gmail.com,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-6-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> This function determines whether the MSR_LE bit should be used to implement
> little endian accesses using address swizzling, instead of reversing the
> byte order.
> 
> (FIXME: which CPUs?)
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4c47f97607..1211435039 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -208,6 +208,12 @@ struct DisasContext {
>   #define DISAS_CHAIN        DISAS_TARGET_2  /* lookup next tb, pc updated */
>   #define DISAS_CHAIN_UPDATE DISAS_TARGET_3  /* lookup next tb, pc stale */
>   
> +/* Return true iff address swizzling required */

I've been scolded before for using the iff contraction.
It confuses non-english speakers for little savings.

>   static void gen_ld_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
>                         MemOp memop)
>   {
> -    tcg_gen_qemu_ld_tl(val, addr, idx, memop);
> +    if (!need_addrswizzle_le(ctx)) {
> +        tcg_gen_qemu_ld_tl(val, addr, idx, memop);
> +    }
>   }
>   
>   #define GEN_QEMU_LOAD_TL(ldop, op)                                      \
> @@ -2619,7 +2627,9 @@ GEN_QEMU_LOAD_64(ld64ur, BSWAP_MEMOP(MO_UQ))
>   static void gen_st_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
>                         MemOp memop)
>   {
> -    tcg_gen_qemu_st_tl(val, addr, idx, memop);
> +    if (!need_addrswizzle_le(ctx)) {
> +        tcg_gen_qemu_st_tl(val, addr, idx, memop);
> +    }

These are wrong, in that the load/store are omitted entirely.
Something is missing, like you split the patches incorrectly.


r~

