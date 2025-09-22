Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA078CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hbE-0004dZ-CT; Mon, 22 Sep 2025 10:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0hb6-0004Wg-R8
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:32:56 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0hb1-0000GB-DA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:32:56 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-330631e534eso3943608a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758551567; x=1759156367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnIto/GQYDlmsKylEytC6CMj8s30fTU96pcx7k883zE=;
 b=t+LOTHLdT5umT+FTl60Qf6atLlpC6dV6oCztK5MnGlyjnAj+HOsGTJOZxr/cF6Z/Ic
 +JgXl2Fx0HpBh+V/mktWJPFfRyd4V5c2w/HoNpw8ATxcDDcltR/LI+x4Y1/nT+TyF+WU
 xhBwczOPyPGO3j5nsqbE0r3niYHEwR5yt14WXgG5GvjJqz5q7QZNgv04pxHNTMH2mmKj
 JuqErLqdl9JcNA50UaKqhOMcpSKr+JQq1shbrhxC65LGiQ0sl8RxpXOfUPEm5ZggXDOL
 mkckH0O+DworzpSjZNXGQM7JjVgUQ3WzgDd/sTxfrSVZy1XO+jR54i/075JR7DiAByoD
 JDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551567; x=1759156367;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnIto/GQYDlmsKylEytC6CMj8s30fTU96pcx7k883zE=;
 b=qi2rLRBkNm16MDBA7p3ASTAZDxHDdfJFDpEz9F/4kkJZzSOU8SR1z7o3w5lts0QO4F
 e9AoLy5wGM6J++pE5zPuf1QEtWjRk1avOHhjQS7gQ6zz6fv+fA0bbgP0TauBXwar/eTD
 2SkaBKPnC8LBDsEAjFtWNERrWq64qRuu9xjvD8w+XdeNiBM2HLNQ15FamMzw7l3kK1Sn
 hlbLFLEeUdTAAkbenFQF5MY1/6vDB1F6/6XROUfq4RP4upBXBQCnX5vYqfe7eueTvQN6
 4AVx18e9as+SjX7sstMf6fm4EiIDeuW/7DzreO1w9EKf4lWiqa8H3qVomKtLd9afdQcD
 MgYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDBhs26CuulbTyq1CpWa+Jt7TNthRBm5lINuoqtS0riF/Q5qg1+4Bqj/dFDZGuz1eQekKXpR4m82Wu@nongnu.org
X-Gm-Message-State: AOJu0YwpCmVuJgODKrAiMUuJeXHgySGDpJIgwEddVKvEs1urKXX3ZPJz
 PltKoYbDPFVvBQcFFGZkNK7+kbooBZRg4Ksdwg6FFQPsBmMzs6NQOMVxauLNrggsczA=
X-Gm-Gg: ASbGnct1HpEZUoAGQ2KazGkbxG4vq+PbMP9hMFtAY7GmVJfKI7H06sjCh6/Q704NRqU
 z33DkfrLxg0+JAZAVjBcaWNQyxZY19XrbJlj+fWLXaMmllcct6VKiskc3J8L6Yj9hfNAMhSvGXr
 2tHWEXFXwZwGMK6JPsNuAoVog0srIHOk2hbZlvfUpec4pp/d6oHSuw1eXzpx/DNnv7ZLKe7sBGN
 RsgsA2C+XwVRpWKRbPLQR9JXtrmnwMZZi8O5ahYKWU0mj2gKRQ4EGRqQw+fBE+DkLcTx5ioatOv
 WqYOGZbJS/7WYukOzLcCTiX/OMSpnM3LsXx5JHm+fZNDfXspi47v+TQmYjX6v39i8fzr41+M6bV
 yRkawYwXdx/Go1BKFUXiqibY3hdBbVwZDHzc6
X-Google-Smtp-Source: AGHT+IFvFV5lIFMUOWmQMVstAVwHelwtZjR16VzK0MY0Y5B07Q2jQktf7z6zHab77NCdUClaFM6qJQ==
X-Received: by 2002:a17:90b:2249:b0:32b:c5a9:7be9 with SMTP id
 98e67ed59e1d1-3309835ef66mr15274196a91.25.1758551567574; 
 Mon, 22 Sep 2025 07:32:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f34d416a9sm3711174b3a.101.2025.09.22.07.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 07:32:47 -0700 (PDT)
Message-ID: <c61f6bee-8dc2-4a61-9f95-5865731e7544@linaro.org>
Date: Mon, 22 Sep 2025 07:32:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/loongarch: Define loongarch_exception_name()
 as static
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250922073400.1308169-1-maobibo@loongson.cn>
 <20250922073400.1308169-6-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250922073400.1308169-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/22/25 00:34, Bibo Mao wrote:
> Function loongarch_exception_name() is only called in defined file
> target/loongarch/tcg/tcg_cpu.c, set this function as static.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/internals.h   | 2 --
>   target/loongarch/tcg/tcg_cpu.c | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index e50d109767..29956f0fbe 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -24,8 +24,6 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
>                                      uint32_t exception,
>                                      uintptr_t pc);
>   
> -const char *loongarch_exception_name(int32_t exception);
> -
>   #ifdef CONFIG_TCG
>   int ieee_ex_to_loongarch(int xcpt);
>   void restore_fp_status(CPULoongArchState *env);
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 59b5800ecf..82b54e6dc3 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -45,7 +45,7 @@ static const struct TypeExcp excp_names[] = {
>       {EXCP_HLT, "EXCP_HLT"},
>   };
>   
> -const char *loongarch_exception_name(int32_t exception)
> +static const char *loongarch_exception_name(int32_t exception)
>   {
>       int i;
>   

Ha ha.  My comment vs patch 4 was anticipated.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

