Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F55AC0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 21:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teho1-0002xH-9n; Sun, 02 Feb 2025 16:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tehnz-0002wv-Em
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 16:47:03 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tehnx-0003Ac-Ay
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 16:47:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216728b1836so60288175ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 13:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738532819; x=1739137619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HfpE/R9iLcGVeARr5s0wabl+HdNGI9pRHFGDnTtin5Y=;
 b=jgR3WQUraS6RGkqZE5itCm7xAmAS4YaFaFSVrH7+e8diGEd9/b1qBb5UHIs/eglpxD
 Or3SzG7kBhvnmxBp56K24+V+Peh0/G3/bXDXnjaG+1D/kYJAmouotpJOlJ8W+KfORwEJ
 CVmUqtNAKTKo6dd2ImbdCYV1sJOq6JLzaP0GrmRdgtGzVzhSpYvGxgJJpHpWe3olrSQ5
 zZUfeVlu1MEWb9hX+3p9nzCC09yqygUzt8T+v6ScOIKyXMcsnxt4hKOY2xaLhANvPlvO
 lTY7crHT1eqpT7y9Viq+FZ9YcSYxGpI49gO02OK3b+xEzBLEm/BPdVKuc0OQcy7nzXoS
 yQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738532819; x=1739137619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HfpE/R9iLcGVeARr5s0wabl+HdNGI9pRHFGDnTtin5Y=;
 b=wzcXaDZ/WIgpqiXeXrTOC1H3qlJ9aG1aOgpFJpuVIeF81k2S955dokBELSrQPYzSsi
 YwWwn281s7CzGX9OPo7DlWHutl0XB6cdUehCqB9wraVwM3mYRsHGvAmLaE4glkUonvXf
 dFH6z+h3LBD1uVe0RJliz/jKpCT7Dlslsdr42cTlEBkv9kp726ib/Z8DxmfGFGNwd1Ln
 8H+2tZzB6rGz+NvTPDm1JPZxbro70nZ4dt/EbGzDf3Kf9eQwMo5h55DOb0vjzsyM8kMo
 hZZGoNiJOV/hBQ3TZQf56zIFwVFPulxQ82aWylxKY4DO4kXvKoqvz08j2HTQJfOCfffY
 y8Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/z9aIHpmALVnaHe5oJ6GkjoxOZ1pLoJJvoMVh/UMsbhdtqgRkBjIIRvfTHdMTJWw4XUe+ftqRIlQH@nongnu.org
X-Gm-Message-State: AOJu0YwiqcwtHKTXexK69L4Uf/sVRCAsELFbE740Kf1rBjA4TDUTOvZg
 P6dy5lNjiyf/x+qlG/6ZjM6pHJNMla1YHAfFacsECgkn25rpiCb7bqbs2lnmNUU=
X-Gm-Gg: ASbGnct+9gLCg9KGyUvs1AUgT27wcvDIbrRMIlAIjet5iXuC07Kw6fch8pdRHuKx+FL
 EKlYWS6EzkCR+r9igSZn+NbGx6Lj8mPeoxYOGZnEeTrE3vD94lR06oXFoyoMOv4QAsX0leBEcWu
 vI5TGeRikyUz0EvYpne2Qy3hxADCZSlihax097ItC+yg3m+NccZVMvxDNq9ZaxdF7yUgUDQap0S
 QMkpBELF8rorm4q6zpsqjvwroSHcRfsWj54l9zJ31ZKzJvQqQGmVTm7oEExzw107H/HkPnzZecZ
 KygQpFv9FSdApavKVrWbDaQZkrv94vcJ26SDaeM0mxpDFaWDMZhlYJI=
X-Google-Smtp-Source: AGHT+IE7y2M78+08sErnIBZnhxFQRY9Ki7GVycvbnsIWa2Q+4YBudk5MZZYcTWf7yDypvm9qkema7w==
X-Received: by 2002:a05:6a00:e8a:b0:72a:bc6a:3a87 with SMTP id
 d2e1a72fcca58-72fd096a0a5mr29285553b3a.0.1738532819173; 
 Sun, 02 Feb 2025 13:46:59 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba322sm6967923b3a.110.2025.02.02.13.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 13:46:58 -0800 (PST)
Message-ID: <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
Date: Sun, 2 Feb 2025 13:46:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: fake UltraSPARC T1 PCR and PIC registers
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250131214528.117846-1-atar4qemu@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250131214528.117846-1-atar4qemu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/31/25 13:44, Artyom Tarasenko wrote:
> fake access to
> PCR Performance Control Register
> and
> PIC Performance Instrumentation Counter.
> 
> Ignore writes in privileged mode, and return 0 on reads.
> 
> This allows booting Tribblix, MilaX and v9os under Niagara target.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   target/sparc/insns.decode |  7 ++++++-
>   target/sparc/translate.c  | 20 ++++++++++++++++++++
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 989c20b44a..504147563c 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -96,7 +96,10 @@ CALL    01 i:s30
>       RDTICK          10 rd:5  101000 00100 0 0000000000000
>       RDPC            10 rd:5  101000 00101 0 0000000000000
>       RDFPRS          10 rd:5  101000 00110 0 0000000000000
> -    RDASR17         10 rd:5  101000 10001 0 0000000000000
> +    {
> +      RDASR17       10 rd:5  101000 10001 0 0000000000000
> +      RDPIC         10 rd:5  101000 10001 0 0000000000000
> +    }
>       RDGSR           10 rd:5  101000 10011 0 0000000000000
>       RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
>       RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
> @@ -114,6 +117,8 @@ CALL    01 i:s30
>       WRCCR           10 00010 110000 ..... . .............  @n_r_ri
>       WRASI           10 00011 110000 ..... . .............  @n_r_ri
>       WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
> +    WRPCR           10 10000 110000 01000 0 0000000000000
> +    WRPIC           10 10001 110000 01000 0 0000000000000
>       {
>         WRGSR         10 10011 110000 ..... . .............  @n_r_ri
>         WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 7e5c7351cb..285c9b0a59 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2882,6 +2882,15 @@ static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
>   
>   TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
>   
> +static TCGv do_rdpic(DisasContext *dc, TCGv dst)
> +{
> +    tcg_gen_movi_tl(dst, 0UL);
> +    return dst;
> +}

return tcg_constant_tl(0);

> +
> +TRANS(RDPIC, HYPV, do_rd_special, true, a->rd, do_rdpic)

Surely reads are not allowed in user mode.


r~

