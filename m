Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A227D41D65
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjOi-0004dB-2b; Thu, 11 Dec 2025 11:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjOf-0004bp-Lm
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:20:05 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjOe-0008UF-3N
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:20:05 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c75dd36b1bso178941a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765470002; x=1766074802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h6QKCTSgDGos3TBOfGIKkSOmlzSCuJqvuiLAQlKOdiA=;
 b=YoZJeI8hY3V59wtPYOUIcpUeaBvGwpBgVumh2pQcDl2u5wij53daIPyoLWzUn2POc4
 XubIFX870HinER0ZnSXVc7pIA+sNKSaSAKEputwMWqK59yKaG/0C+DVvLl4ol2Vccm8A
 C09KGYe8dA2hYXlT725BTYGuh0WMLplCEXzgUUT7lO5mQl7G0Iw/UHVzG19uqWwv3hNR
 2X5FB0TBZBib5NxDdEusav7gSBE+QYucNrje4ELhoO00gy2TlTL5OLclCtsyOXSUmtLw
 KVDullQAtrxiZBzypuupmzgmns5R9W35cWIv0nvW3IdKeJxoqYIdYRzrtEiMYcQFkGfJ
 UYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470002; x=1766074802;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h6QKCTSgDGos3TBOfGIKkSOmlzSCuJqvuiLAQlKOdiA=;
 b=hH876epAZ6STTPz2xdFGbGMbj8te/1GvsH53s/s4TBwyj6QaDQV0lCMOkKPFgYsXgB
 fv2B8LVGWj+VH824rUQ4m9BEOlAFJzCSrw8bBiWTQjjDpOXEDL8x922mPwS3mu1zdOcg
 MDSsFzi6lQILHvBnyLEx8Ebz64fAfBaVlI81S3CI8MP7db8bOWqunZd/4KrsSSSKLsx8
 pd3bofI/vQyshf8Fx5jeLp5g9WwkoptaO13DQlcUaeclmsg+i8kiH74tnDXQHo9CdlRC
 Lup9OnykdoGWbkT69WHpvSXqIihoS8KerUVREguzJ8rxd0yCq9pU2xVGIHBq1toqKEhD
 EE0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzHc9rt2099srGr/nZ3ZIPj4vEyi6Pdc4CDI56gDzQLV4pbJyUOh08B48/SnWx79Hx92YL8LgVugxn@nongnu.org
X-Gm-Message-State: AOJu0YwU1eFA9/FNO3ioE4wcFhvd9wdppq2InPwUKFiBgtunkvs9qLo7
 shKIqk95WVfcoreNYRILC9xgTeokNCAWzxJ1LRcWo9UJOqnvpgQPpKmdgmmqWC/ZyeE=
X-Gm-Gg: AY/fxX5GylZsga/dK8+EP0qgriKUdaYg12t5/cjL/ulM8r35uSvQKNG0cCFzImH/cYV
 7s5qhYYTA3aA+6SW5RuJby4aevKtsm5SbZs/IabT8ioqqX6unc3KbGCx3bYj8iMq4nJR3KOV3fI
 nJgkmh4kvfJQlaQUWomKBObfaIIUDLIRxHqFnzlIqvl36EWijnig6MiO2RUNhFPfAoC4NTmZ/It
 WB9kpGvvetlzY78D3G6x5e1uurFTFPhfjCtz5Uve4+rT9azk1m9bVAs25l3oXJqZh6MbS6NifMN
 zZHK5amN45b6F/XON7VCCio7Rgu8L/gRzCM9ciaG9JjCbbXBxgIGha8SWEXVq7jO1u6mg6g7jMB
 UgcLEdTSZdCNJHZfnVogm/S71aewjaFeSaLDcbbCY09zOGB+EuXgyxafvPEOo1MOcmGT9pPYOp4
 6ujuyXlUEZ8YAxY9r2FFPjlKX135W1zE0try+0Hvy2yVgehkP7R9AQvg/rlw8yKRmK
X-Google-Smtp-Source: AGHT+IGYIm/SW0YNtAINcvZrK7c85yr18u1EUO9EJ4crxrN5xb+sof56rzCOc9nF7z83kwYQDzjxiA==
X-Received: by 2002:a05:6830:82fc:b0:7c7:6a56:cfdc with SMTP id
 46e09a7af769-7cacebc61ddmr5373982a34.16.1765470002476; 
 Thu, 11 Dec 2025 08:20:02 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb2fd262sm1694973a34.15.2025.12.11.08.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:20:02 -0800 (PST)
Message-ID: <819d04b8-5ebf-41ba-bfb0-f6f26116f235@linaro.org>
Date: Thu, 11 Dec 2025 10:20:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] target/i386/tcg: unnest switch statements in
 disas_insn_x87
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-10-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> @@ -2801,22 +2785,16 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
>               }
>               break;
>           case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
> +            gen_helper_fmov_FT0_STN(tcg_env,
> +                                    tcg_constant_i32(opreg));
> +            gen_helper_fp_arith_ST0_FT0(op & 7);
> +            break;
> +
>           case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
>           case 0x30: case 0x31: case 0x34 ... 0x37: /* fxxxp sti, st */
> -            {
> -                int op1;
> -
> -                op1 = op & 7;
> -                if (op >= 0x20) {
> -                    gen_helper_fp_arith_STN_ST0(op1, opreg);
> -                    if (op >= 0x30) {
> -                        gen_helper_fpop(tcg_env);
> -                    }
> -                } else {
> -                    gen_helper_fmov_FT0_STN(tcg_env,
> -                                            tcg_constant_i32(opreg));
> -                    gen_helper_fp_arith_ST0_FT0(op1);
> -                }
> +            gen_helper_fp_arith_STN_ST0(op & 7, opreg);
> +            if (op >= 0x30) {
> +                gen_helper_fpop(tcg_env);
>               }
>               break;

Leaving the op >= 30 check here?
I'd have expected

case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
     gen_helper_fp_arith_STN_ST0(op & 7, opreg);
     break;
case 0x30: case 0x31: case 0x34 ... 0x37: /* fxxxp sti, st */
     gen_helper_fp_arith_STN_ST0(op & 7, opreg);
     gen_helper_fpop(tcg_env);
     break;

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

