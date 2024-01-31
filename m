Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9879DC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 21:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVHwa-0001qi-HE; Wed, 31 Jan 2024 16:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVHwU-0001qU-MI
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 16:16:24 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVHwS-0000xk-V4
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 16:16:22 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so220673a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706735778; x=1707340578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vewnQobiaf44xJDr6UCTiW7VIyUsXzfOXJv7R0rJsSU=;
 b=rgbn9HaFM3OrJ2ty578gC7f5QHTROLX6mWjA9RC79C1WfnauhFCArGqmulPIDN7vCl
 jw1jWw1uBGUxSX3+nTRDS03zXjA4jqykgLt60hKbnPViln90NL4YPBX8lktvMn8tP0+0
 8ERRMz1SxJ4HzY8UZLg3aDcNMCauizCLxQLBRcPVTrxQTYuVHPB+eexI/lDzj84WcC0c
 tuaWInmHIp58qZrujS67IyugjvFwevodrX9TdcwJ40M6mxYhOrXSFdNQZhSDZjSOCdvw
 isfCZoEgY5wKoA1t0GfMDFXLXKKkt9Gn7gdwbuXQgxdqnsL/Ub9lAIXxluvPytHioZk0
 t5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706735778; x=1707340578;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vewnQobiaf44xJDr6UCTiW7VIyUsXzfOXJv7R0rJsSU=;
 b=QY1r2KZ7KivW9/qqyXkhcqAbDdwlmOiZe6JvzBipOJJqGRGhejTJzFfKVkJezJqW/D
 2apFX0pX4Q2W101T4pMJr3xUPF/e58gkgLECQhJ1SJl4Ce13KRDIoTELdyrQeGFSvyjx
 tiorV2S6p+o4ji1qsJKLsHzaKgWHDivltwr3mhxGthXXiVLPtb7XWY8//bqv/lc1pjNZ
 z4y8t0dVjkSAl4O1oYHJNet79+6IaTuJWOTNV9Vd3ZP2lgoRNz0MR/GxfIoNUhokZfdV
 PJQ0RrJswRo6lUWi+bnzjOzMaDHraxJVOcswvE32oTNbAA93VNWkLlO6MzGAbDoKdZ6V
 ln/g==
X-Gm-Message-State: AOJu0YzuXz7fzJzrLfQeIB08Jo0cCpkTtm3WOUTRJrfYwwNOW6bkU6gf
 Sn/0R6t9FziUib31AaeDNsLGsXDftjEUGIzASsNt3Wwdr1Y20sQWJ7iNfqoVaZE=
X-Google-Smtp-Source: AGHT+IE+uaPQYTi0FhLFzrVWEHOKuOxyY9WToFurVZ3s3cJcW7K7DXFTeLTs7l7YM1gsdze1uZfniA==
X-Received: by 2002:a17:90a:f992:b0:295:cf16:17fe with SMTP id
 cq18-20020a17090af99200b00295cf1617femr3005033pjb.34.1706735778620; 
 Wed, 31 Jan 2024 13:16:18 -0800 (PST)
Received: from [192.168.0.100] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 hc7-20020a17090b318700b00290f9e8b4f9sm1966761pjb.46.2024.01.31.13.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 13:16:18 -0800 (PST)
Message-ID: <70186760-61be-4b44-8c0f-eb6acb4587f2@linaro.org>
Date: Thu, 1 Feb 2024 07:16:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Fixes set const_args[i] wrong value when
 instructions imm is 0
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@redhat.com, git@xen0n.name, maobibo@loongson.cn
References: <20240131072740.2569850-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240131072740.2569850-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/31/24 17:27, Song Gao wrote:
> It seems that tcg_reg_alloc_op() set const_args[i] wrong value
> when instructions imm is 0. The LoongArch tcg_out_vec_op() cmp_vec
> use the wrong const_args[2].
> e.g
>     The wrong const_args[2] is 0.
>     IN: vslti.w v5, v4, 0x0   OUT: vslt.w  v1, v1, v0
> 
>     The right const_args[2] is 1.
>     IN: vslti.w v5, v4, 0x0   OUT: vslti.w v1, v1, 0x0
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2136
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   tcg/tcg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e2c38f6d11..5b290123bc 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4808,7 +4808,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           arg_ct = &def->args_ct[i];
>           ts = arg_temp(arg);
>   
> -        if (ts->val_type == TEMP_VAL_CONST
> +        if ((ts->val_type == TEMP_VAL_CONST || ts->kind == TEMP_CONST)
>               && tcg_target_const_match(ts->val, ts->type, arg_ct->ct, TCGOP_VECE(op))) {
>               /* constant is OK for instruction */
>               const_args[i] = 1;

This is wrong.

I strongly suspect that the TEMP_CONST value 0 has been loaded into a register for use in 
another operation, and the register allocator sees that it is still there.


r~

