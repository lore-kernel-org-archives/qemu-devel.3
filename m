Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC0CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tz9-0000sa-6e; Thu, 09 Oct 2025 12:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tz2-0000pb-Gt
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:16 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6typ-00077t-Rv
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:15 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so1171549a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029138; x=1760633938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sC6HCvh07mO5QI4+g1Q6y8qqUCqJrgbN3GfB3ifDhWk=;
 b=AiosN/w3slZ+AhCLEbXVFnY/DDrXhMx3d7GxZwhw8ArzsndFl7hC5DBPfUEHBNcXHT
 dpCsi+ODNGRAuFFoyRqKa+C9TOTVusBPLJesItN33ajduxAbnp3LDGbZB+Il6E7Wplry
 wqVTWvyVEyY2KwsORwa/5RD/xllBhjpFpBNvNHjnRlyYSixeQEJ37S9O4FF6DbDg22tv
 EvwcKqQo6dVPPyRxLxLmfFz/wp9PAcrI38eaD+osRtXijNhjzORPVZrn+jLYja4KB0jx
 GpyMGNqQINfYNv7EeWymqCiDTNU6tAY8JD9AtiBH7/7uPml/MZFSilcSq7w70Du2nFEX
 ehQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029138; x=1760633938;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sC6HCvh07mO5QI4+g1Q6y8qqUCqJrgbN3GfB3ifDhWk=;
 b=MkihbI6OBaGT0pmcIUxFSrkSf/oZ25A9+628mCro7I71J5STSZizJXZXSKzt5O/kPa
 R7824/aV3m20f/WUXh0Eg9XcIYXPZMxX0gl1bVLBULT5dTMywvQfFZJ0iVZbWB6km/vE
 uSbEbykZP7TjglFyOloMG6nYo5J1qFXs2nySZfEgTyy711GG0FKARVyp4eLVhFharrLi
 BNiMcRt2Qe/zGO3zSLOazZ4bKSVLQq2CleXLT9FNHja7wfm5qKE7Yck6LQnzRBbCzhGx
 IhuXlCa4Vdj5RKWbZIXFMN/bfUi2QA6VtUYCdYY4CUYELArfrTpWzSRtZ8S4SY7YSCOI
 0ZuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB49SNc15lOJlGvOnkWDnYNCdB10osNmZTevl6u2jVq/PvbT1FH30SjMXuTgUFfHYQvOz/fsyi6oNp@nongnu.org
X-Gm-Message-State: AOJu0YxLrGjA+oh2Asfc2n7sneRga6lwbsqiLMOraVJ/KcD58OpVL+3b
 I52u5kAsCfJSR6v+7jIJJN2vlFUOMVC6/n1h5/m73JJj861G0lcCwHGB+MAuvexv/Vgz7qggc73
 ndfGKdm4=
X-Gm-Gg: ASbGncvJZaD/5GN8RLtN1ZN6t1BCFCDQWfRbQmt2iy/QMHMCgooBM9ZNYg6jV/k6Cu9
 eaBhZ2rayre3LZMgNiU+9ZXntPzH8vg1kLZ0b0i1NGNaJuvJreXZYRD43/hr1vTb31/QYRyEtXH
 BTKQeYEkZdJnUmTwplRUxRNu4bg3zG4DkVpjIZ54MdJZ2Qu2mt5ze18jz5mXZKlPqCOJWch5Fko
 6t+6QqWJnNwVczm0GivutAJKzER75jXeyN850hXepdQF/UziMI20c3o4J2fyP0G3lAzkAN0uS4N
 s7r5pA7SbcXpohanwZDX7w9xtn5b4i4aZ1AnrALdX5yzs8GEGwStRLjr/oc46g2v8IBUd0gRo27
 BzO+oRLiE6IZUlZDH3LXK+mTm7ozs41R+4ieytNqC3PkBWR1ZMleuF5aJJZQExAwr
X-Google-Smtp-Source: AGHT+IFjyWonieteNDRO6C7B9PW5BlIZwXloO8BzYZUk7XIKEKNy3gy5KYttEUw480DCEuII4v3KzQ==
X-Received: by 2002:a17:90b:1b41:b0:32e:6019:5d19 with SMTP id
 98e67ed59e1d1-33b513bdffdmr9872521a91.34.1760029138302; 
 Thu, 09 Oct 2025 09:58:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b529cec1esm3475135a91.3.2025.10.09.09.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:58:57 -0700 (PDT)
Message-ID: <90f326b5-d034-4acb-8f22-1f983ec78be8@linaro.org>
Date: Thu, 9 Oct 2025 09:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/hppa: Conceal MO_TE within do_load()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
>   target/hppa/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 859c6cf5f9b..ee0c874342c 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1676,7 +1676,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
>           /* Make sure if RT == RB, we see the result of the load.  */
>           dest = tcg_temp_new_i64();
>       }
> -    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
> +    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, MO_TE | mop);
>       save_gpr(ctx, rt, dest);
>   
>       return nullify_end(ctx);
> @@ -3302,7 +3302,7 @@ static bool trans_ld(DisasContext *ctx, arg_ldst *a)
>           return gen_illegal(ctx);
>       }
>       return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
> -                   a->disp, a->sp, a->m, a->size | MO_TE);
> +                   a->disp, a->sp, a->m, a->size);
>   }
>   
>   static bool trans_st(DisasContext *ctx, arg_ldst *a)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

