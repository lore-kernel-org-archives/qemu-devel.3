Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F7BE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpKb-0008SD-8l; Sun, 15 Dec 2024 09:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpKW-0008RX-Px
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:10:45 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpKT-0004CJ-WB
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:10:44 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-29e65257182so1564183fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734271840; x=1734876640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7aLOrTTScnrPUmLlfVTQiML7vU4bmvSZgPaNUoqfW3s=;
 b=jaSPjdXU/sOmcnTJilBfXlNwNiNWxCeDCx3iaVm4ei9Mk1fnAmn4aFslaMbeJ98SHM
 Xjux41tAS6ckWFSY6waByo70mJdSROjWGwybBt/CWTu+7lxLwwx4Oz6kjSVMDgOsezh/
 Ib3hc5NlyhfK126rb/CEY5SQkg03KNSUBwDdm69xNyrZJrNz2DmnM0Scf5B66udqzUT2
 T6rnAvLFkzTCs9YDnWKd+lLmYB6WHtkGzdClOJ3m26t41EfoPKxul48d1Kbn6l9ZcV8h
 8h8vXc74Z6f5wDGBMViZaOkNviEtfPbTBDJsmfXwSoJIDjgdwkgHCxjscUZNxpSBElxI
 YPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734271840; x=1734876640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7aLOrTTScnrPUmLlfVTQiML7vU4bmvSZgPaNUoqfW3s=;
 b=TNmv4opj4f2atxSjC0MG4tMGlGm0qjH3t1zWv/Zz0gVUVJBnaeVxXG7Hc4LjXDIc+O
 G3rtVAzeyS/V+4Bj2MvoG0lcEJ9tlN1YjFIWjlNbEBo7xZZVwxlwEu2ocNzV7WTywEWj
 f5wnpjfUJuuLYS9uEAcy4i0oMaQbqVzD4dFNmGEfLuL8VR16bj1J6udcj4KGh4MaGHc7
 9rokx/D25REhjMS3ei6ga2Jo+U187nOTZOgjKIZv8JdOKRdCFqxPwEwHciaFcXVH+0b4
 WCrsvpUwR3wnA9hyfAB9tE68NvefA+OKoMzty9clhg4CtffnwlW1MLRXwM1AU4nB2cvD
 N8QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtxNqWAX5kzqr1STA9GQ1Th91FZzE62Ma+EOADF0IN1PLj/xYpqab1P7+FvQ+51GwXv98ltzbZ7eKA@nongnu.org
X-Gm-Message-State: AOJu0YzH1JH/RaTBrrLs/D1ynwgIb+amtDCPtSBp5UyBRVgOgEQMhpvy
 4fdxOlZdCRTFjfOAvs4wVIiYTqIyxQAvfPR+UBDDEWVmZlXcg9Ni/28XFBXjJgk=
X-Gm-Gg: ASbGnctjxy0Q7eaqC6n9URPDhQ8+zpa52P66/WuYu4y3v3TF6LnBqV9pxkvOPjPT8Xp
 sUo7mRoJsckcXag25Q32Jin6M6YE34HdUkq5KdI+D+WQnNugYuZqSIcnfaHixPcIEDYdcO4ZPGy
 V3Z54Qa5smPsiEOWmsTR5lrgPZpMlCAuBeYALPHxc5D7svqr6qjACPoFW5WT3Ei27uK56BGAwlW
 T/AVBvXnYv0AQ3AoEK5ceaA0xGtPRaHcizB2mOUVbcMtKBOofLvgDvXcJ3vz3SYatebiJii3clA
 Mj1XSLNWfgNZ20FG+g2An/oKY//9hyMa/FY=
X-Google-Smtp-Source: AGHT+IGs95t95rDztE5Df/O4w/3caEhTYEyhzdNQa5vndD68B6JeH6yf5RbWyR4mtvCDHDTKMJpCUw==
X-Received: by 2002:a05:6870:e24f:b0:29e:5dfd:1e17 with SMTP id
 586e51a60fabf-2a3ac6beb8bmr4453117fac.23.1734271840287; 
 Sun, 15 Dec 2024 06:10:40 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d291dd95sm1191770fac.43.2024.12.15.06.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:10:39 -0800 (PST)
Message-ID: <9b83983a-7f1d-4982-aacb-a88b6ca17388@linaro.org>
Date: Sun, 15 Dec 2024 08:10:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] target/i386: unify choice between single and
 repeated string instructions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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
> The same "if" is present in all generator functions for string instructions.
> Push it inside gen_repz() and gen_repz_nz() instead.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 12 +++++++++--
>   target/i386/tcg/emit.c.inc  | 42 +++++++------------------------------
>   2 files changed, 17 insertions(+), 37 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 8bf6aa1fcf6..63a39d9f15a 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1340,13 +1340,21 @@ static void gen_repz(DisasContext *s, MemOp ot,
>                        void (*fn)(DisasContext *s, MemOp ot))
>   
>   {
> -    do_gen_rep(s, ot, fn, false);
> +    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
> +        do_gen_rep(s, ot, fn, false);
> +    } else {
> +        fn(s, ot);
> +    }
>   }
>   
>   static void gen_repz_nz(DisasContext *s, MemOp ot,
>                           void (*fn)(DisasContext *s, MemOp ot))
>   {
> -    do_gen_rep(s, ot, fn, true);
> +    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
> +        do_gen_rep(s, ot, fn, true);
> +    } else {
> +        fn(s, ot);
> +    }
>   }

Why not push it into do_gen_rep?


r~

