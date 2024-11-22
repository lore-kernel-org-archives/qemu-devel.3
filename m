Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B80E69186
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEY1f-0003bi-D2; Fri, 22 Nov 2024 13:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEY1c-0003am-GP
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:05:00 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEY1a-0001Fi-RZ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:05:00 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-297078d8eaeso1563763fac.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732298697; x=1732903497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9osE1jozsxDIu0u8DqUFBG659cF6BEwupOzdrisrJBE=;
 b=BOEUhH7htJy9My3O8qmrwLAhHteSVlPVtIe5jFQbw7zhkA48f0JS+WdurxsshjNvNc
 oQRl0WsI6+F0KTE1rrRX4VTGUG6IzrVKQZ0ZbNtlsDRBiinHjeRVB+QUcVGCVqbL4SiH
 xFqrvyIBysGaPifHdvmq7Pw9z7/BfSXY6xoC+OPkB8dmtlxkR9puu7UVCj+m6XFr4+oi
 WdEBYOHIFT93ZGit/5m/LKDnU0jy/etrmBlbIFd4KdzAA4KbMCigCUcHQDOrkMVrpQw+
 0iOQgWkVf7D5UZ3Scyac0QltWJeO2VGqCtQvH1GqSEyPxGzbltiJxtAOnkiYW3b1Q0n2
 iHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732298697; x=1732903497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9osE1jozsxDIu0u8DqUFBG659cF6BEwupOzdrisrJBE=;
 b=pf3eUDxHyArI91AhI/rsqycJlpEdvGrKdnNJ5BL5CwJUqHVp5hW0zs9X9AnhmMT+th
 KLOnbdLzO+kQpPj8Yt3FqgNrgQEddlYqezAKAurc5oKgSdCDdIzybFyVnwRfpVz73Hsk
 3KdQrqDibW8UYIUlWzgbBoOC4qay6eaMAkTdZfKmBDR/jCP331D6fRWJBmpgqfk1+Dci
 2DjlqVHTCfkr/mUwGw3YP4g3TbpEZkzKWRg4IL9qmgd9Edzo4e/GYxGsdg3A+u8lslbe
 TYS2LxzoOHqLamQKi/ILhVBV1FamktHSh0kOWkAMdKJfoTAYLJwHJO6Hi1dwe+caJSh0
 +tCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpnFrS8saKiQeBgxDITkeSM6fbZWcGKjtnwmQAIK5XcpmQWZD3aG8aD3gw01gLb09zpvU8/vUTlnMe@nongnu.org
X-Gm-Message-State: AOJu0Ywo/XyNLXgqPbfnOHCmMU4LOOV43xMVQDuVqf27+uqREQ6Vmk3D
 GL72AjniQ/HcjOwb7o21W9ikqZkXtwFXUZSP1d2oHoZndYQc3m2D37qnSwAneR6dFa1NVv3lp9I
 LpTg=
X-Gm-Gg: ASbGncuS43EVVs3ZR4sdPSB0hbL7Ly6N3cHs/DIGv8+L0Menm8JhxnjfVSrQO4sMs16
 eLKvUuqpVQHIGevp20eV+3xYBXwo37iyiJGwBJnCbQ2k6GiYYuE+YLH22/JWcWkEjYnrAwSUkj1
 EpQo9flHKgVkwDS1CALRxxgHwFD/IZba+Ubp34t2UcOLGczgYpczo+7Ub/ol7vHWUvLbXUGCnLl
 xN5DFA9V7RouvYtvCsSNa31R2v+/tx7N+V9w4x/6D1Bc0HnVnLG7DzNP0R0K2Y5qoaCLvQ=
X-Google-Smtp-Source: AGHT+IFtVyKfdQ0stXJmSKWycZsfkuBzq4sD+RIpavPAv0FLyG6/9M5ISSjQ+fczvzdSfJh6iw7oqQ==
X-Received: by 2002:a05:6870:e0c8:b0:296:e289:138c with SMTP id
 586e51a60fabf-29720ee4bc3mr4285074fac.30.1732298697311; 
 Fri, 22 Nov 2024 10:04:57 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d5e29ebsm686591fac.14.2024.11.22.10.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:04:56 -0800 (PST)
Message-ID: <1e4bfa65-715a-4ac8-958f-48f0f6301218@linaro.org>
Date: Fri, 22 Nov 2024 12:04:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 05/43] tcg: Add helper function dispatcher and hook
 tcg_gen_callN
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-6-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Adds a function pointer to the TCGContext which may be set by targets via
> the TARGET_HELPER_DISPATCHER macro.  The dispatcher is function
> 
>    (void *func, TCGTemp *ret, int nargs, TCGTemp **args) -> bool
> 
> which allows targets to hook the generation of helper calls in TCG and
> take over translation.  Specifically, this will be used by helper-to-tcg
> to replace helper function translation, without having to modify frontends.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/translate-all.c | 4 ++++
>   include/tcg/tcg.h         | 4 ++++
>   tcg/tcg.c                 | 5 +++++
>   3 files changed, 13 insertions(+)

I guess I'll have to read further to understand this, but my first reaction is: why would 
we not modify how the gen_helper_* functions are defined instead?


r~

> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fdf6d8ac19..814aae93ae 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -352,6 +352,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       tcg_ctx->guest_mo = TCG_MO_ALL;
>   #endif
>   
> +#if defined(CONFIG_HELPER_TO_TCG) && defined(TARGET_HELPER_DISPATCHER)
> +    tcg_ctx->helper_dispatcher = TARGET_HELPER_DISPATCHER;
> +#endif
> +
>    restart_translate:
>       trace_translate_block(tb, pc, tb->tc.ptr);
>   
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index a77ed12b9d..d3e820568f 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -549,6 +549,10 @@ struct TCGContext {
>   
>       /* Exit to translator on overflow. */
>       sigjmp_buf jmp_trans;
> +
> +
> +    bool (*helper_dispatcher)(void *func, TCGTemp *ret_temp,
> +                              int nargs, TCGTemp **args);
>   };
>   
>   static inline bool temp_readonly(TCGTemp *ts)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0babae1b88..5f03bef688 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2252,6 +2252,11 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
>       }
>   
>       total_args = info->nr_out + info->nr_in + 2;
> +    if (unlikely(tcg_ctx->helper_dispatcher) &&
> +        tcg_ctx->helper_dispatcher(info->func, ret, total_args, args)) {
> +        return;
> +    }
> +
>       op = tcg_op_alloc(INDEX_op_call, total_args);
>   
>   #ifdef CONFIG_PLUGIN


