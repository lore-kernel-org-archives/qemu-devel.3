Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E68D10F2861
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6B0x-0005gO-Lp; Fri, 27 Mar 2026 13:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6B0u-0005fx-Il
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:30:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6B0s-0006UJ-DD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:30:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fe36cfabso17940615e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774632624; x=1775237424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l5Lx3JK81pqLAUzWvhxlraOcK3hBgKuV6WCWXqOBalc=;
 b=w/AHbNeA1WuXWQjwLubnAsew88cn+UMQY2o0K55y2W+mXxPxSKgFx5Ji/FyJMXJ+Zi
 VVeDHFYp93wEAk6ujM9mCu4Dj5wkN4GkxcqemmmnAtLJ3STNfGJaE6D78HwQ4tGTgC4K
 SuAfhvgrb1jiJNbR7sAd7ZVeUw235W85IxKIns2FXH4nL749znImVp//pvrCyLwqA1YU
 xybcaNSEYuHwtJs9qdAl+1kt+C+pW/f8h9UdRK0aRNjJi2fRSnvPUd0gHEZS8FubeFkH
 OGGDv3j9N0lClHHcREPx38pd9+QC/9bpgA2zZS6tEmzDh3okSuYOKcao9LU0hcP4sp/0
 QgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632624; x=1775237424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5Lx3JK81pqLAUzWvhxlraOcK3hBgKuV6WCWXqOBalc=;
 b=SoU+ClCTTeCOfq5g/h5Nc8VGjKZ6ha4W854zYJ34KX+OJMEQkB0UpR11mt/kPgZLcT
 eCzq84t2jjj0SbyjfUwcXhJ4M1bQlJUXYlEW2o96dL4QtsnCZfhyZTBxsCCWhQcqfF1d
 hVdXZHZdP+oxWzpwcQRHHs4TVfQGjjeKvwCIpdYTGb1n0Nnv5BFjZawct2J/AjFM28EU
 ehvxRk7gyRqPIWOgguikxdYqogJqewYcUhNmEnFnqQHRara5nQlsYRxxJOXX6YfbL4xf
 rwDrV2JyoFKTSzOYc73HdujQYsGi3tymDBZdqJJO+9+jQesoo3hz77ifHXYUkMMxIjeO
 AGNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2BRCCmxvydYavOUirMH2EzDsVECtRcl/ZeoOG5hpTh3spp3e6y50uDaUItOlEAaADrG+PjSuxM5GL@nongnu.org
X-Gm-Message-State: AOJu0Yziwhj9I1Gut6SWpdOTXMVwPb3AeYuXv9iG7Poxbjr2tkiLMC9K
 YQ7GaFx6USrSJUmT5xC/uXfdQM8CZ8lNPJ1ZatD17aAbw6wlw6h64piPyaeQJSbZfms=
X-Gm-Gg: ATEYQzwxejlzQ3wEnO6VAulITsdyqD5gClExEKil+EqCT5ZBifRCTXZ2yY76B5L78q3
 TPxsRJjnUHG+eit1Mm9wrhoI7RjZV84AHySvf6uF8++y8yZf3g6a3mcM4/RRHFGZ1Pkcoxpnczs
 RHJJoeJKgvdaBb5M50AmIYP7q0zY6AVXu04iw7uYr8BdE0KspxwpholN7m7PVNoiN9dm2dp8o/M
 pti6XBIvmZZNyJuOhkCedfeEhHaBBaUUpnahB7e/1WCaBKy5y4dS33AOz25vMUIuXsOQ0gf428W
 1lpX3FgsY2rIrknxrlW2UJvOYpIfF9av6cLt6/I+37F9Tbe6ubawZn5By8hYMKKe1fzTJjmLZOu
 YnsQ1FkWKgBwOL0tyRweHhD3EzqwZvW3Tf8+63EXcvKhzDcTSrwOmokaxBcJ8bMiRsC9SP/nX6A
 ylM8OTdBWIHuDCV2TJ7fGX7ia525eRqgONHi1IW/g7Ub/Ottg/7zvA78wRRdQp0BP3ilwZIgB4
X-Received: by 2002:a05:600c:358f:b0:486:fcc7:6811 with SMTP id
 5b1f17b1804b1-48722be4497mr126283025e9.10.1774632624307; 
 Fri, 27 Mar 2026 10:30:24 -0700 (PDT)
Received: from [10.202.147.66] (109.243.130.77.rev.sfr.net. [77.130.243.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91945b28sm14709421f8f.15.2026.03.27.10.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:30:23 -0700 (PDT)
Message-ID: <9a7be223-0b30-44e0-b6da-fcf614a1a052@linaro.org>
Date: Fri, 27 Mar 2026 18:30:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-13-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/3/26 17:50, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 4546bbeeeff..204f9657993 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>        * fields here.
>        */
>       uint32_t condexec_bits;
> -    target_ulong pc_arg = dc->base.pc_next;
> +    uint32_t pc_arg = dc->base.pc_next;
>   
>       if (tb_cflags(dcbase->tb) & CF_PCREL) {
>           pc_arg &= ~TARGET_PAGE_MASK;
> @@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       bool is_16bit;
>       /* TCG op to rewind to if this turns out to be an invalid ECI state */
>       TCGOp *insn_eci_rewind = NULL;
> -    target_ulong insn_eci_pc_save = -1;
> +    uint32_t insn_eci_pc_save = -1;
>   
>       /* Misaligned thumb PC is architecturally impossible. */
>       assert((dc->base.pc_next & 1) == 0);

I'd have expected vaddr, but uint32_t is correct enough.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


