Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352D3E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpCM-00046i-RV; Sun, 15 Dec 2024 09:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpCK-000468-0S
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:02:16 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpCI-0002jK-ET
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:02:15 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e22b2387cso2118557a34.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734271332; x=1734876132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BXEpFCfgyLA6ccA+AiMhOXma+2cw0LhCYQMKr2gdlUk=;
 b=rVweEon5F5nvZZiGMQfDoshP36JacyWdhYVtZYI2yN9yFHKRkwkyaafYh26Tb+9yvu
 VlRZKgU3JerZmin1iU+D/osFlOR7otDmss0ll6Inm4TlGe770q9TSkf/DR4pFBjia4ov
 9kvSS5K77thmhR9ih+FpkoaycQYQvGBGICIFb50vKFz60jcCL13PpoxxOo+15fsrMVv+
 3W4wG9C0yXdAWtLQtWFzpbBeHlpfqtHRyz3X8S8KjU+92WJHVe04TJrgLF540mKI+iVg
 QEnZVUwhWQyObdAyc4HeIIxXfqnYoriXH9AMBQN12kE9aSnRtxEwEj/OLOkKHCDFMC4o
 wN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734271332; x=1734876132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXEpFCfgyLA6ccA+AiMhOXma+2cw0LhCYQMKr2gdlUk=;
 b=ooIelTH8EudRoqm5ckcuOK/VI5R9emPsGR+/lhxsU++YWNVxwb06odZEFebYj5RzSa
 Kcinf49IHSTER2YEI7TPKXSbFSjL9VEM9tXxVz0a51EeUnA8vKxTo+cULwNX89LChUOx
 RWXsty8dBRlBtBwPNMwH0C6b9+a+4EqIndYBDqglgqQH1zIb5wAYVC3gundL8yuZb9E5
 3jaPgFvkhghmqlr12ZtPpE53jDJGtcNyxB510Fami/FGjrNg7WaLB80DEMbcq2nUF4YO
 k2/D20+klHRQtz/5JnDsbc4NhBQS8n5fUIN04lmhSIKkvXD0dGXfAHfuTGdz9JoYbsnQ
 Xdxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRvy3zL15x6I+wakK60bKWDiBIr/+HsQCoMfncmJatNdnUlWBdi4qdZgYLlDPnA+kfMjO5xaK/1RCP@nongnu.org
X-Gm-Message-State: AOJu0Yz3DpWjVklGiabzmFax41b2Bq+284iL4kB4bEv2Td8Cm/QgaOjL
 k9LGn9LMLw6XZvej4pAvub0S/bVp31daevW/xITtAXzqBFoeUWj6bFFISdbXjwA=
X-Gm-Gg: ASbGncsC1C3XP0j6uWXw6ZEW/HefmExqOQpibKAI+ESdvSW/mJuGdvQitn0QEmdGA7y
 /qlCdLeqLkASt1tc9Bi1SPmRNfn+89sgh8k40t+aIC2x9DvpBANMrPDC80EPxfkXH4jhIGoMbl1
 MvGpwy98Hzq9aydfwAopLwX0ChXMAG5+t22hmVs0gzjexy/l9EcYMjhJ8TpUSlNx3XNfVrGE9KE
 zl9E7r8jytJYbyXto4C+Ryhyfl1D8R90j42XXnLnqivVRs1+qYowlIYPlVSuvoHU0jGR0jOuIK7
 Yz9isHef6q01ITNIK1LJaI/7mOr5xWTs1GY=
X-Google-Smtp-Source: AGHT+IEk8Jxrffs8AZTFXvABHojZxS+mm1wxcFo8ZhkU7zSxcBBPnqYLtZ4F0hyISNSRdOj1Qa+BTw==
X-Received: by 2002:a05:6830:3149:b0:716:8e7a:f0c2 with SMTP id
 46e09a7af769-71e3bae2919mr4221392a34.30.1734271331910; 
 Sun, 15 Dec 2024 06:02:11 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a6af60fsm895552eaf.1.2024.12.15.06.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:02:11 -0800 (PST)
Message-ID: <c12e2a28-8e84-4334-9874-c5b1fed5b720@linaro.org>
Date: Sun, 15 Dec 2024 08:02:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] target/i386: inline gen_jcc into sole caller
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> The code of gen_Jcc is very similar to gen_LOOP* and gen_JCXZ, but this
> is hidden by gen_jcc.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 8 --------
>   target/i386/tcg/emit.c.inc  | 6 +++++-
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 5d729e68c98..298842d46b6 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1846,14 +1846,6 @@ static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
>       gen_jmp_rel(s, s->dflag, diff, 0);
>   }
>   
> -static void gen_jcc(DisasContext *s, int b, int diff)
> -{
> -    TCGLabel *l1 = gen_new_label();
> -
> -    gen_jcc1(s, b, l1);
> -    gen_conditional_jump_labels(s, diff, NULL, l1);
> -}
> -
>   static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
>   {
>       CCPrepare cc = gen_prepare_cc(s, b, NULL);
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 785ff63f2ac..8d18407facf 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -2276,8 +2276,12 @@ static void gen_IRET(DisasContext *s, X86DecodedInsn *decode)
>   
>   static void gen_Jcc(DisasContext *s, X86DecodedInsn *decode)
>   {
> +    TCGLabel *taken = gen_new_label();
> +
>       gen_bnd_jmp(s);
> -    gen_jcc(s, decode->b & 0xf, decode->immediate);
> +    gen_jcc1(s, decode->b & 0xf, taken);
> +    gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
> +
>   }

Watch the extra blank line.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

