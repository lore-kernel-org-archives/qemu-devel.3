Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB12C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mvx-0002zf-Aj; Thu, 17 Sep 2026 20:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Mvv-0002zP-Or
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:58:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Mvu-0003Va-5K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:58:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2dd68a16955so13230145ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789693108; x=1790297908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HejJbwUnosBTME5QGv9OeqCLVdq0exrnkgrR0TjJy7s=;
 b=SflUYTLPmy5JWV8qqHv55hdPxVIilocQvJ3q9Hi4aYeppyFxyGoZXeXTKySjQNVTqr
 CF7w2werj8bE9tl9dRqn+irE5wmUVSU44Gg8VD7OVRqelCrkWwH6qYwDhCqXsrkAVikM
 cqMwuomjmSqlXgqzJrB9CqQxiAdgHvABZhE3D/04Lv2bn+iPtsnfmy9Xh6cu32Nh61d3
 BPXfCDsd9DZHhFkPXM21wBSfX10yYkkqVeZYjKb0WVze/kb60OpD0enugfg04SiuAx+9
 R6TrHjhXeN/MIrP0h0zV1YWluf/tjJqL3CWxYpwMzhogD2KZwElbsmxd8KnT6ab1TArF
 3ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789693108; x=1790297908;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HejJbwUnosBTME5QGv9OeqCLVdq0exrnkgrR0TjJy7s=;
 b=blpCcPhDMUvSJ5qSVXJ45Mi4SNf/CNhUvAyEbs3yuaoGQb+rpBtWvv50vqw1hUkhpS
 LpBAw3fRa+x75VIiUMkp5wiqNxylV389Sw+UK6jjsnj+JFE2J/hFzuVUtlJk6GdPRUf8
 vSyZXMN6N44lZvoflVWo7KUF5rCq71EWzVWUgndgLlQhv1z4ythPerdwB/FQlvWVt40h
 eigsYgLsJtjzLqgVaDpWNO6eWWHMswcmhu2XSKo32lm6nBKuNrikEyCoBYEhlBa46mKp
 ppaaWqEpxa3pB6bOcKXI9ahRWc3tkuAjGop4GL5eJIrSQ9yh7xlUdShQ0GJ9+0JXoSie
 1XlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlCcVnt1DO8mzQPSjdrKlM7AFopuM33XI9gxas4JRGhenegQDJ5VN9DwOOwfm5/xzbnEZIPlqV+ZC3@nongnu.org
X-Gm-Message-State: AFuF++no0XhJiVP4BuLGlLE0LJrpsx42gcIX982OogcHjx5YPPMrqrIe
 GKHJuBjzYHoDJO02lbU28lQgIfBHScHeCfHOQzqRCusQQ3VTPK/Mb8oR0rtowcxPgi8=
X-Gm-Gg: AYBFou2WdUKKjBG/Y85ZAoUqIIn0PQUvgM1U5xH9CTFWVAClfBjpjUyKEP2L9dnbJgx
 Sb1Y8K34+iZm1EDK4Gg1hltp1wZHm+spZ/OO4EXJmpPuZFufUuav2whSDJD4JlkC8Ah8e2zOako
 mkonwf4l9uePIv98Bst4F5YD7f2VjP5XOAr6LNaSPEkIOYR5/K4bLJQYQF2tftjJ2xsdZsI3ltH
 Xv/DjFjozMZPJfRJmYIohW8qcRKZKf06WePzZTupSGSK98eXVsoOcIO3n/xY3jUxPM10FLObX/7
 GrWOV3Ef7bhJ+Vf5VSP0Mrc9dl1oacT7mH5ZiTdX8fDT9m1KTCxwAq9ixLOGZG40ZkXRPhU6aQ/
 zHRZc8Td3IC7IcnZ2XtBCMmRFBKTUmxZQMhMaUh4sfrW8h186LLtZVz2gp8fyPgJkQilL+V0b3U
 8vRl9Cyr9QLHhP77GNeGOKR1Nno5RuWxlaYBlVrLlDfz+Qq/swR7PMCgEwW+65MxDyE9kKISw5/
 fFsVV3VhyjGvGD52wuwvAxIIeLfAFMQmvSqHRI2U8R0VCR0WgzjA+pDFrQBrA==
X-Received: by 2002:a17:90b:498c:b0:39e:5481:54e with SMTP id
 98e67ed59e1d1-39e54810a5bmr1291107a91.19.1789693108461; 
 Thu, 17 Sep 2026 17:58:28 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:83aa:9d68:3956:350a?
 ([2603:800c:7900:ed00:83aa:9d68:3956:350a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a175sm19421264eec.9.2026.09.17.17.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 17:58:28 -0700 (PDT)
Message-ID: <db731c3c-69c3-4c4d-b1d4-27e2a943d900@linaro.org>
Date: Thu, 17 Sep 2026 14:58:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] helper-gen: move helper_info extern into gen_helper
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-3-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918004225.827-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 9/17/26 14:42, Yonggang Luo wrote:
> Declare helper_info inside each gen_helper_* body so a comment on
> DEF_HELPER attaches to gen_helper_*, not helper_info_*. The extern
> still refers to the global from helper-info.c.inc. Silence
> -Wnested-externs around the HELPER_H expansion only.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   include/exec/helper-gen.h.inc | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)

Huh?  Why does comment placement matter?


>   #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
> -extern TCGHelperInfo glue(helper_info_, name);                          \
>   static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
>   {                                                                       \
> +    extern TCGHelperInfo glue(helper_info_, name);                      \
>       tcg_gen_call0(glue(helper_info_,name).func,                         \
>                     &glue(helper_info_,name), dh_retvar(ret));            \
>   }
...> +/*
> + * helper_info_* is declared inside gen_helper_* so a comment on
> + * DEF_HELPER attaches to gen_helper_*, not helper_info_*. That is a
> + * nested extern; silence -Wnested-externs for this expansion only.
> + */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wnested-externs"
>   #include HELPER_H
> +#pragma GCC diagnostic pop
>   
>   #undef DEF_HELPER_FLAGS_0
>   #undef DEF_HELPER_FLAGS_1

That you have to have to have this workaround makes me less than receptive.


r~

