Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCAFF433D0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDAKj-0001ok-QS; Wed, 15 Apr 2026 20:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAKj-0001oa-0v
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:11:49 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAKh-0000tW-DR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:11:48 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3585ec417f6so28261a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776298305; x=1776903105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8lAjj0P5dQkTvz4hRuiYe6p8xpnhcy//4+/EqexHIxY=;
 b=L9KtyEpRf8ph+JmpdrKD/6mwgB6kXUVhHlWwA8yXxuMEEkqb95BXqr7zfEageNf2bP
 O0pXMQ60BKTZTDOzde4zBKqKzR4FdKec979sLU053FIc3uM1o8baHV2Nen8PWixgcW6H
 nBzvMEEOewTVF3dmSOU3J0SMsXwV5jaxyFdmTswet8Us5RKZ79OEPsL0Yimp4RoW/Z5e
 JY8dd+C/RdbU4xcyJsG+nSDz6T8Sd8fDT4vsa37fFKzSHzDZclapEHlkUicoTK2BagkV
 YVsPcVO9ivktdAsj6yj7bAF33zs0pGUzrBABl8B3350nU1dO8qfhBsC11mahwTqKVYDf
 eGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298305; x=1776903105;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lAjj0P5dQkTvz4hRuiYe6p8xpnhcy//4+/EqexHIxY=;
 b=hZaz5lSsiyG0Exc5mPGowI+gl9AuV3+TxSthJW8cf9FVoRQvqwJ4lph+hrQEjRPgBa
 50ZWMZOYTxKXs7wEcuvedls6hAdneBjnlEI06yQ3kkD++FhvMUaBU3Ug44Uutw8sNttt
 KOzgXpMPjpj1knz/r+nIU4IjOWiOQinbvqRDoDtibY5ROUuWFXuPHx/MQ3eQ3Q1sNhvm
 LY0cPRzEYOaezlE89tfAbJY8/SHnO8qGUOqCLRsqmC5U/qPfOV2F08HeSIRZ7ZxMCqRL
 jWXojoWP2GZl1xTYx0Ho1o6Jb7DrMgAPmrjrt3b/9lcd3OQNejwIuegDxuCYwbRYAcwG
 tJ/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8N95Gu043y6ir97e9o+YbHIDYs2RQMPaZU3nstVdZixNxb5erY9iBBuq6m7OjFPVg6U2+2oAFwW2Jy@nongnu.org
X-Gm-Message-State: AOJu0YxmfhiFEE+2vWJQyqguIDdNa2yyJW1zltIyqVMWij3mFLZ79W2U
 /hh5gdOk275Xkz6/IqWSQm6GZYFcL+2y6JEkozattR+ETfWxLXfOhtIsS8fTpHZ7hZU=
X-Gm-Gg: AeBDiesYLilP8f6cCA2CY7lgvrj7jNw5+xDfaJJMWx+RxhH1e55C1zTRmBIjB4i/QNf
 aMv/YGzTidandDXwE+Np9oi9j9D+Cve6fRrgoz5H/osWt5qw0e7yjEjVPzdCW8/qYooGPlxv5tw
 tfaPPSt+LOVVNwulm4P5uaKDb+8bYuT+UePpqFI+UOxmFjTvnx/l1IUtVrn3xhQJkOzO5kQyLFW
 w42DZbW5HgOL33+cfnE8zcp/iVE8TqbxpYj6o440vbjrwNP1UfRxf8SxhOtaOCgvSELZqlnjY7K
 9LvQWfdpCx03W5sCzZM5yGEOg+f/Woj2zp2auNsLxeidoSirT2TCcV7qC1dGsO/mIdElWX50YWV
 ReqE9yr9HJabjHadZEfwO6TSC+t6UuU07RzkouJQ6lEV2HCxrol33f0fuqSSk/alD38q3oriJb5
 fNDye+AgTm7L5yvNWjm6SiXJBGi98QbbROdMgj325FAadh4pb/q8JpRiovmEoqrCY5tOYKNMTY5
 7gJ9H4XB38MOsvam1ixYH109vfVBvMfCgRCi1+t2kC5PCEmZP3Vrfv4ptzw9uDud7VUeFjKdbZY
X-Received: by 2002:a17:90a:d60d:b0:35f:c6bf:2bba with SMTP id
 98e67ed59e1d1-3612f326a3bmr1259662a91.11.1776298305162; 
 Wed, 15 Apr 2026 17:11:45 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 (bg30dhzr9yyk68wp6s9g.ip6.superloop.au.
 [2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4780ef41esm42660205ad.6.2026.04.15.17.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:11:44 -0700 (PDT)
Message-ID: <befeecab-5485-4159-a60c-b0f07948bee2@linaro.org>
Date: Thu, 16 Apr 2026 10:11:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/6] target/mips: Convert MSA LD/ST.H (Halfword
 Vector)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260415202027.83008-1-philmd@linaro.org>
 <20260415202027.83008-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260415202027.83008-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/16/26 06:20, Philippe Mathieu-Daudé wrote:
> @@ -813,6 +824,15 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>           tcg_gen_extr_i128_i64(d0, d1, t16);
>       }
>   
> +    if (mo_endian(ctx) != MO_LE) {
> +        switch (a->df) {
> +        case 1:
> +            gen_bswap16x4_i64(d0, d0);
> +            gen_bswap16x4_i64(d1, d1);
> +            break;
> +        }
> +    }
> +
>       if (!is_load) {
>           tcg_gen_concat_i64_i128(t16, d0, d1);
>           tcg_gen_qemu_st_i128(t16, addr, ctx->mem_idx, mop);

You've just bswaped the architectural registers.
You need new temporaries here.


r~

