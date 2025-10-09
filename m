Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA016CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tzF-0000wC-PF; Thu, 09 Oct 2025 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tzA-0000uK-Vj
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tz4-00079k-U6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:23 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-781206cce18so1348032b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029153; x=1760633953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+5kKEwaEHhwik6OFM3ZopihJm7ydHLDa9A+R3Rp8Cuk=;
 b=xIxB3rdfEb0MhDOEPVDqw9ueLgUk0hp25DsnkggG1D/lyu+OJOihT4HZHreEyN6ebH
 IpTeUF6Ygk5WRkfY9ysXXDEG3InXkpSyQh88s1oVKWEHMs7JllhuktCNezcOSlU72g4d
 yMv6MX70rYoSDz5YTCL1qOeGI3NDx29CQpgSmSVi6ngx9NQPoPb2V+tPs0krafwkDNqi
 jf7KO99JA/UwznslaNZFjNROHo/34fIE7SYZP4bwpmkChjlRJ1j1DDZsa2Iz7wTFQBwg
 Ow9bILP3iwmLVvWWYJcopPzdIVmhDPFm08cm2XWTk9q6bTqj26eGOBPYv9+iTi0Z5Z2G
 fQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029153; x=1760633953;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+5kKEwaEHhwik6OFM3ZopihJm7ydHLDa9A+R3Rp8Cuk=;
 b=Ig5Z7N6arQZ3exilB5dhhI7JzAteTzdc4IYXFpiByRxa/sXmldvoc+vv/uyaY8eIzM
 x4KhR7cBFRrRTn8Ofe9U6CRkc9/FqQjLqREV9cLv9QN6TfDRURfUvsbIaOwYVRE7YL36
 phrqVa2FkvQQxxbN8HOdhAKorbrM0MQyB5ZVizMEdOUYXO/TkRVMJAHEutrRbMTMpJSC
 A1HYqeyyqgAUACj97HDOb8o0oVbZoolGZ8Sy9ZvlakDb/OHPdPGNxB7FJyQMtWCWnz1p
 HJRvRkvrgmiRQU4NgTHAtP7y+eYhi+5sPLS/c/+vKFAXOqS9WAuYAMU6Zh2Bl3hLGPmw
 DcCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrII5WVaeWzARUUVSNcys/Ob5wGA+bXzFYgdqQMP9bs+79Nfz/KQI2Arwjt4IXIuM+1a4Neo2rhiB3@nongnu.org
X-Gm-Message-State: AOJu0YyVOnG4fr7N/L1wK+BVeFKXY7AaHCUq/saLPTdGnfzmzVlm8OcT
 XlY9WKfS2ykGvyWIA0uGDQQqkyYQ5A6wmvafco6FP04mrvT7EysDP+e14aChx5JLzwc=
X-Gm-Gg: ASbGnctgAk532UrPcGySW3tqcTOpu2b9tn8chJFSMaHbw6xSSxQKetjSzWaeCrZTdmG
 sz1eZud10LcclSRJRztj5VxzJ8I5jx7I/SPjlvKmsmzKZNAa45SCfq7WII4bRMna/uNv4A+nCO1
 tCpbr1Ltj/PP04lciuZvdnaRLDXPbPqYksbOXBEvRIp0/nehEgngdQNiTbk7s247nHCPJXSE0S2
 dcDWKgxI/gzKmBR+0SsIYORCdEE/lAv9PWmu4yuhxzamCE9PcXRQP7ojuspKHNgsY4tpwLbgO8t
 hhmCpanXRjX75Kk9/wUSLBEZLL2/o+iWVVPj/M4JjX88ycqkUdMurFn7w0Z4ttItNCIkqc4rNcy
 rKAuZApGyk8Js2+nJC2Q/USh922frzobT7cYihrBGA8G+xxGDHQ3TzWKIqQQ1ZDiC
X-Google-Smtp-Source: AGHT+IEzzj05DLu63fIJ3p1QXzfWBFsklvJtnh6GCdDYRYHFJxcE9dC3Y9AOACv1wO20qAmXp9OJtA==
X-Received: by 2002:a05:6a00:3d51:b0:77f:3826:3472 with SMTP id
 d2e1a72fcca58-79397924911mr9565447b3a.6.1760029152626; 
 Thu, 09 Oct 2025 09:59:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d993f7bsm209860b3a.78.2025.10.09.09.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:59:12 -0700 (PDT)
Message-ID: <4fe30b27-f492-49bc-84d7-7306a1431198@linaro.org>
Date: Thu, 9 Oct 2025 09:59:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/hppa: Conceal MO_TE within do_load_32/64()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index ee0c874342c..4680d826345 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1599,6 +1599,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
>       /* Caller uses nullify_over/nullify_end.  */
>       assert(ctx->null_cond.c == TCG_COND_NEVER);
>   
> +    mop |= MO_TE;
>       form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
>                MMU_DISABLED(ctx));
>       tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
> @@ -1617,6 +1618,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
>       /* Caller uses nullify_over/nullify_end.  */
>       assert(ctx->null_cond.c == TCG_COND_NEVER);
>   
> +    mop |= MO_TE;
>       form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
>                MMU_DISABLED(ctx));
>       tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
> @@ -1676,7 +1678,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
>           /* Make sure if RT == RB, we see the result of the load.  */
>           dest = tcg_temp_new_i64();
>       }
> -    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, MO_TE | mop);
> +    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
>       save_gpr(ctx, rt, dest);
>   
>       return nullify_end(ctx);
> @@ -1691,7 +1693,7 @@ static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
>       nullify_over(ctx);
>   
>       tmp = tcg_temp_new_i32();
> -    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
> +    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
>       save_frw_i32(rt, tmp);
>   
>       if (rt == 0) {
> @@ -1716,7 +1718,7 @@ static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
>       nullify_over(ctx);
>   
>       tmp = tcg_temp_new_i64();
> -    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
> +    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
>       save_frd(rt, tmp);
>   
>       if (rt == 0) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

