Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22F1C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u588Y-0004rv-Sj; Wed, 16 Apr 2025 15:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588X-0004rl-BV
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588V-0004xp-KZ
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2241053582dso401515ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830566; x=1745435366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9zOKYAT+VmXfZ+WX9Q/vYBbzJ4fDrhqR8iPGSX+qVw=;
 b=v6X7S0i0wyXPaPk4ZEjeK78sAkdUqazFzofiDoTIzhQa8+CN42v1e5IGBEMdy0ZoG3
 ubTZcgi5nRfCnsLpgVCLctJNgD9v56YK02ZJZu9MhBYgBk2apLh5DkG6MEoICr8deHzR
 HHYkPKiDZfD1d75XC50WOIjojE2tFXSWZkC/8i3kEqU1MUtNEYEwwbjan/oxMQ62SiTR
 GMRmCtCNlr2MNPOAUASI9dQnrJAi/rhJNsIM2hwWHWgBB76TCaMlwGVnLJLuzYVo6snQ
 e1yOkJ3z9QhD592fQiA/0jwPcku8kUTgU/SLiTMl/jFMBmwmGn2u/L5r3dRDyeoER+fV
 gxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830566; x=1745435366;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9zOKYAT+VmXfZ+WX9Q/vYBbzJ4fDrhqR8iPGSX+qVw=;
 b=ltlvhzq2fg1+t+/q/DAZdPc5OqjdLKO0QVlp6Flw/8gnb+3JFB8cV1qQVYSdf6sUjR
 /HU0Nc2TiiQxBg062RCmO8aY393Z0bzi2srClglLvWGmluxqGe3Vf8xMjJ3SaMjkhGkI
 tHMnbUL+T7JxZqlFAx9z4lv/o4Cm3nCt53nmCeoXZ9Z1HtW1i4zd9ogybARVNf3CE2WL
 c3O3XmL86ujO1WWPeUxnBbwHYqsTagVYGHV8S2k+7OcrIRYz0ljR/b8Y14P8EjifYh0b
 1TzGF1JHp0EiQAkfnKoB1yjqlfGRV37PErdVo0YIb7PSjaC+bQ1ct5bKxx5AzIIzDPKD
 c4jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVohVjOxaVcK6y+yjYY2Xv1IhDxYP7pDokTkDZV7lWLkO8O2VAk1B34pMXejui9VOM5Y2mebzhZLydg@nongnu.org
X-Gm-Message-State: AOJu0YwbN2wpLrYn39ZmLTRYRndjj9PQcIYgi/gzf7O9Hoqndz9LHUzC
 xxk4NDYw4AnCMXjZ/OPKWO6HthtL4qGQCvh+1LzEu/oSAAZ0SR8dZRFosKV7nIeQPwXap4yWSHV
 3
X-Gm-Gg: ASbGncvhFJKA5uuRRDNeWIgpJhnZn5MIgTiTGDX47N5C9YYEFGsh+J3vSZnU25ewEle
 NdQcserJDv2hAtY/N+KaRVuhpvkxskWEep3AHumzFQ37zzUFYWmpt+0oggGXMPMQhHueIier7lp
 iggqpPzqFfQCcUfvzV3HyD9P9PBWhxPze0KVtUkHqFMJ+vzhfJYqOUSsTWnMpPC/y0XCIfepDrc
 J/kWv1a757gspOi1s+BDAF5Bthby3QqW3AqVLQkihxXflWdQvrNSdOwXOIk/ICJX784szGJkrRm
 a0yEIgMSVAmCA3zSCxAkc7lx4urapGJXxJ1sQezDJiYLDTtdmaIj5g==
X-Google-Smtp-Source: AGHT+IH0stXewXYGZjOBEyekCNsqtCo0TDC5Bpv4/yn4W+KMqs1R7Hj/fRhC3bzLH9B/gCmigYenWg==
X-Received: by 2002:a17:903:2a85:b0:229:1717:8812 with SMTP id
 d9443c01a7336-22c357b1125mr49783715ad.0.1744830565872; 
 Wed, 16 Apr 2025 12:09:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2198ad8sm11182447b3a.18.2025.04.16.12.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:09:25 -0700 (PDT)
Message-ID: <a507a0da-a0c2-44c0-8407-36e6e6e05b72@linaro.org>
Date: Wed, 16 Apr 2025 12:09:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 130/163] target/sh4: Use tcg_gen_addcio_i32 for addc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-131-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-131-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sh4/translate.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 2ef48b1d17..e8029c0c7a 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -694,14 +694,8 @@ static void _decode_opc(DisasContext * ctx)
>           tcg_gen_add_i32(REG(B11_8), REG(B11_8), REG(B7_4));
>           return;
>       case 0x300e: /* addc Rm,Rn */
> -        {
> -            TCGv t0, t1;
> -            t0 = tcg_constant_tl(0);
> -            t1 = tcg_temp_new();
> -            tcg_gen_add2_i32(t1, cpu_sr_t, cpu_sr_t, t0, REG(B7_4), t0);
> -            tcg_gen_add2_i32(REG(B11_8), cpu_sr_t,
> -                             REG(B11_8), t0, t1, cpu_sr_t);
> -        }
> +        tcg_gen_addcio_i32(REG(B11_8), cpu_sr_t,
> +                           REG(B11_8), REG(B7_4), cpu_sr_t);
>           return;
>       case 0x300f: /* addv Rm,Rn */
>           {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


