Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E4FE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpwl-0001Eg-1l; Sun, 15 Dec 2024 09:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpwf-0001DH-Ke
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:50:10 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpwc-00013W-Ko
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:50:08 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb8bdcac2eso597406b6e.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734274205; x=1734879005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3+SOMXsvv2DyVisgAg5smWadlyq+rvl5eK3TOYUcCZQ=;
 b=W/oYwAjhirp5Pt5ItZAPr8aG9DxpeyO3NpfiH8p3+wj0Ms70Ofaq7Bc7UapHg9NhfK
 EiqLhPpydbj/aArTiR+57RfklI+9az3lHOK0hRCEiXbQoG9LvJ2tdpQ58bFCIqAMCX8q
 qhbl1d4JmWJrj8eE8gBfP1CrJSXlGvlZmizo+FsFwDpL5cKFrq+42oLDiM8XEFo3d8CQ
 3yJZZDI6WogaxNtgGEvHOBqGte9wKxDfag2V8iIaPOLdzuwXMZcaVkD2QOZCI1Z6/Uqr
 cqsEO9aobf2+G3aHL81sXR9pdMjTEfoiIoRBuq8K4hGTJ8TCk3wfvoex4TBiSh/9vqHL
 aWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734274205; x=1734879005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+SOMXsvv2DyVisgAg5smWadlyq+rvl5eK3TOYUcCZQ=;
 b=P1Bl1dzwP8JrXm78CHAirkEfRo/mPZ6RgBxw8WicJRg5zu7M5gV7HBF4tIsAfrOYWx
 imzDaRbZwrvzGzUQe/lELBhqcg29Q20i8MJIuKCKPW9zTmkO7eOHqiAlop72bn+vLiOW
 672SmhTveCovC5hl7rGjMjHMV+i81665nOhVM0akB0eNXxmi4xbzbGg3LvEAEVW9fPGl
 cTlqubQxIjp/++1S7IN2mf4OrO2eTLO/QVUho/f+p+2wjmAWUobCNe08Ge5OCxmOiYM2
 a+2zrLUplMmvWz2/AbsD39HWbR2LEAwgciR/AHZ7ioev04e/DE3rftxDc3PoP5bdeWt5
 0L3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSs6CVoEUppuo4WRZ7ohq9CbjG0IhrcEJgf7i9rTVU7MU6rvWTCywWFyugbGusj2JvKQLqFweV+Fwj@nongnu.org
X-Gm-Message-State: AOJu0Yx+Zba4W5DhTLvC5wlYBIiPFsYRhS8y2Wg5L9ZX7roA7X8gvUm2
 oSMDd793hr00mTDzeOlIfDYVnPaqoOJgIaVMzlEdb7Gz3XnYF2Q9q2wMrEAZBBROaeyQ3UVnet7
 bphdr5bWB
X-Gm-Gg: ASbGncvfcAOvAjemSgUMakA27LtQnSNK52mR9M5ZThu1otS+tTZHUBrcsCg0YAG6nyN
 7I+RscTHryVcksTbU5jFqUHlIk63fOVAtlhIbXk+Xo6wXCKCyO1XX4M9zpcxsT17DX+7T7yl2RT
 MTCTPiG0fd5jplaH07xi1grVnVKaXtMTrNtw1l13K8QMYNZKArdOmbjhTAFkMHgrohOAOZTBLc1
 1G8BMtUsju29p9hJBMJloGqnFlRytsMcn/bv5mz3d7w9KnMZVN/hVu2LHr8kxGGZUCnk+O0sMHA
 PNlyIwzS0iR/JTziU0AwLOGaCMavwu0Fi+E=
X-Google-Smtp-Source: AGHT+IFQt/oxofzfrhzRTMFHCQ/17vzUKJGRui5vWsUBpTeTFVJyWtAD8b68BfvDUTC9G2Al36ZVVg==
X-Received: by 2002:a05:6808:159e:b0:3e5:f4fa:5984 with SMTP id
 5614622812f47-3eba697e467mr4044827b6e.38.1734274204860; 
 Sun, 15 Dec 2024 06:50:04 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb492a328sm1011803b6e.44.2024.12.15.06.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:50:04 -0800 (PST)
Message-ID: <436ff2e8-96c2-4743-89dc-765e823d634b@linaro.org>
Date: Sun, 15 Dec 2024 08:50:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/i386: do not use gen_op_jz_ecx for repeated
 string operations
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
> Explicitly generate a TSTEQ branch (which is optimized to NE x,0 if possible).
> This does not make much sense yet, but later we will add more checks and some
> will use a temporary to check on the decremented value of CX/ECX/RCX; it will
> be clearer for all checks to share the same logic using TSTEQ(reg, cx_mask).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 4b53a47000e..8ef938372d5 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1336,6 +1336,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
>                          bool is_repz_nz)
>   {
>       TCGLabel *done = gen_new_label();
> +    target_ulong cx_mask = MAKE_64BIT_MASK(0, 8 << s->aflag);
>       bool had_rf = s->flags & HF_RF_MASK;
>   
>       /*
> @@ -1358,7 +1359,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
>       tcg_set_insn_start_param(s->base.insn_start, 1, CC_OP_DYNAMIC);
>   
>       /* Any iteration at all?  */
> -    gen_op_jz_ecx(s, done);
> +    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ECX], cx_mask, done);
>   
>       fn(s, ot);
>       gen_op_add_reg_im(s, s->aflag, R_ECX, -1);

gen_op_jz_ecx should become unused now.

And maybe gen_op_jnz_ecx went unused a few patches ago, when gen_jz_ecx_string got merged?
Anyway, I think there are some dead inlines which clang would Werror about.

With those fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

