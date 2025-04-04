Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAB7C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0i3S-0006Yh-Dz; Fri, 04 Apr 2025 10:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0i3P-0006VX-Rr
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:29:56 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0i3O-0000zC-0C
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:29:55 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3054ef26da3so1685234a91.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743776992; x=1744381792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cYF1qDUhcFq5dLZ+xsTSgCSvgM0oB8JIgHyeSZnzA88=;
 b=MdGTxwD1F0M6QRICQgl5YItskBRw3wcWYvRAMMQGBsmY7LmL6eUrpBJiJXNH0UFmy5
 GbYr0Brk5QEQv4rEzKDk2kCR3JJAXp92sykGppUWMdcPjdmP7Twrt6zazPsjt4DQgOWR
 p3+jEuYfgXGSlG+Zxf9rEkLCokSObBjNjgSWIf+R7zcVW3rX5DKUmb2nV9RElhEpIIoo
 IViNKxsf/k/LOWAKAxuPgY6df0q+0kuFm/MPuQ/ozYA0YbrQ2toa3FHy4JszJTypE7M7
 PnBGGZjkdbG9uxLvfxkTZdOWZhGLeNJTfSMQNvwllXY52qGQ9w2Wxkd5EtrYF9AdHde+
 1h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743776992; x=1744381792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cYF1qDUhcFq5dLZ+xsTSgCSvgM0oB8JIgHyeSZnzA88=;
 b=uh+/KBlduFw5ANiAlTn8blpDU5QwUribw5Q/1M3G6gCgzzvOqLf++oDf6uuAmgOLpT
 z3fSmwnTPimXzkc+k4hdW23KE4QeJEpJLDA7Njara4FaT5uoD2odDlz0/fvAdxjiu2rA
 fXVdVsdhrYEN1LsZaGel36HfT7FddVKISBfsdyNl9REPMv7g3g/wCGe48Nm7gxXHSF2l
 a8+4ZcoLBx2NEGRIpx+YrHxvnTeZuQ17JcveUQiDx83lJfsDufnllQkFZRW1Uq3b5H2u
 5LQ9q/TlNvUijdYlnc7QNULQWmbGyFUTCMc2ch0r7cuQIIAi9WLdHIqhtwtFlptgWfwz
 3GPQ==
X-Gm-Message-State: AOJu0YxbNyTT4+FSx4uv8gkO1652mQTt4wRz00PpoB0E2Gp7kZPuZQCg
 FQfbxZ9DGF1lQDL4mjRekn+7v6+cG8qFdN41X+2IIYpmODtgiI0zyxfPutJ/xbyDuvVWMeX+SJD
 N
X-Gm-Gg: ASbGnctai0XZf9oDPvQSvxPvIRTVbZoRcmwXPDP8VZEcQxGnWzvEmVRo2hGllV0VlC+
 SV/rdth9I4Jx/ANKXXbBFWOBns/b9dlkMxOMhKGNSgWK2AS28Lp+D7QdeibnZT4tkkf+Xe0iJal
 H+GLdfqpS1OXA183DBwxsLvjtUFAp70HJ0Ma/BBQctwDH7JaUpdVAM+gft7bNtaA/nno58C9XMq
 7bLY5Q7o3KBzSio24inPWv53a1guPhFty1Fp6lcygvqqBN4a9hZyJxw7SkM9eiUebV044fBR1Gs
 O22iAg78caYcR5sdPgEddlxby/vE68m5prO+mBNYnAIN3mMB/T4Vu55g1W03wtnJ
X-Google-Smtp-Source: AGHT+IFRsv4R23X//Dqhq2L93oug6ekl0ty5Hg5ChzUXNSoxThWi8pMos0/CrOPHpqgvv47HH3BQXQ==
X-Received: by 2002:a17:90b:2f08:b0:2fe:68a5:d84b with SMTP id
 98e67ed59e1d1-306a483066emr4659752a91.1.1743776991822; 
 Fri, 04 Apr 2025 07:29:51 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca1f40fsm3715213a91.4.2025.04.04.07.29.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 07:29:51 -0700 (PDT)
Message-ID: <bceb2daa-61fa-49c1-8de1-f2162ef39e78@linaro.org>
Date: Fri, 4 Apr 2025 07:29:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/tcg: fix semihosting SYS_EXIT for aarch64 in
 boot.S
To: qemu-devel@nongnu.org
References: <20250404115641.258048-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404115641.258048-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/4/25 04:56, Alex Bennée wrote:
> We don't expect to hit exceptions in our testing so currently all the
> vectors report an un-expected exception and then attempt to exit.
> However for aarch64 we should always use the extended information
> block as we do in _exit. Rather than duplicate the code on the error
> handler just branch to the _exit handler with a failing status code.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/aarch64/system/boot.S | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
> index 8fbcba757e..81a60b9c43 100644
> --- a/tests/tcg/aarch64/system/boot.S
> +++ b/tests/tcg/aarch64/system/boot.S
> @@ -73,9 +73,8 @@ lower_a32_serror:
>   	mov	x0, SYS_WRITE0
>   	adr	x1, .error
>   	semihosting_call
> -	mov	x0, SYS_EXIT
> -	mov	x1, 1
> -	semihosting_call
> +	mov	x0, -1
> +	bl 	_exit

1 would be EXIT_FAILURE.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

