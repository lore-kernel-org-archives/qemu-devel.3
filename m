Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEF5D0E6C5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2wPq-0002IW-Ed; Mon, 21 Oct 2024 13:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wPc-0002HD-Ga
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:41:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wPZ-0005aD-Aa
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:41:46 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2eb9dde40so3806228a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729532503; x=1730137303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BNXZBs6f6NVmwJIAqcqK7SQ9wLULaON6OpQnkUk7TFo=;
 b=sJ8qd/HYiGdu/fRm2aO5B1FUYg9yFgR5rJndx+XIA71RVDMjdPXlh5q3xGXSfq4oZw
 +VhqgfE9/vCjVipl3ChkNpzmqXk40epXZ4OrgWJ0GFJKrFgodRnFrq3OU/VVB9s/yAhe
 u8FAclHUhY27oM+TV1RHuDTxGhVuqA2Dd4WBhGh+5bsE1B6zv05APfKhw+5OgxZgJPfG
 uIrVCRYRofRJXkiQxqO9uNZG6DCqtsKixO+l5MOJZE/B6e3Iba8b5ebukThHtCcN4KPo
 wHeROVCm26NOqZumF1kt7mWAkVhpxog06Y4C/MEZ8SqJud9DGtpMlEVu5p02dfNbiwRK
 Fq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729532503; x=1730137303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BNXZBs6f6NVmwJIAqcqK7SQ9wLULaON6OpQnkUk7TFo=;
 b=oWGM5CjG6BF6fYeRSs4cSJe/J8Dci21lpdAB3Rza4EPo1dtl2qW+S5JjTelN5XJMXG
 c7gsyj8Rh0e+5KBq52bEEqvg+NIfANYdxFBDn3CLN/d1VOwrtncxSSfRzxBxc5+BOOJx
 sQZjkIUNrzW+7IqkEGq+B5XRi+SZFcqkEfccoDgtWassDL2MccL2M2u6sNtWv0aeOu/q
 V8BtfdeaFtwusop0ZhhUJWdy7nkIdh3Dvaw5FWxWAQ1PbgoIvLV8Lly1BIljxlKD+9Vw
 yNYvSUJS1pgJIfzEv+JKMH8Uif01W7gwQxxGsY5Rv1BkO9OOCp9u6unrmAojckMpXrHG
 86zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR3HeqEKw+mvvaILB1h0hEpShPNvZSoQo/eR90b4BHXk9oDngMlA3De1sN0GfDkAIm2VU0pYf2fGYu@nongnu.org
X-Gm-Message-State: AOJu0YyxalEFXzzSiG65kxYPHeB8eltAJrICWWmZcQ5lQbm1nPXAlC6N
 oBvWYWrE9ndKCgsSq0ebrn6A0NtmWH9iFwW9NThjZVCQkHelkFGEaHSARnV6gIQ=
X-Google-Smtp-Source: AGHT+IG4IEJCmRgUvXdqUmsyBs+8DLgV/+madM+ru0mGJpltXcioxiI2sl9EeCqkP4ectf4jyPIFYg==
X-Received: by 2002:a17:90b:4b0d:b0:2e2:d434:854c with SMTP id
 98e67ed59e1d1-2e5616e6688mr14817164a91.2.1729532503506; 
 Mon, 21 Oct 2024 10:41:43 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad25cb15sm4146245a91.11.2024.10.21.10.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 10:41:43 -0700 (PDT)
Message-ID: <34df66e6-087d-4e27-9edf-e723db959d43@linaro.org>
Date: Mon, 21 Oct 2024 10:41:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/14] disas/riscv: Fix vsetivli disassembly
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241016193140.2206352-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 10/16/24 12:31, Richard Henderson wrote:
> The first immediate field is unsigned, whereas operand_vimm
> extracts a signed value.  There is no need to mask the result
> with 'u'; just print the immediate with 'i'.
> 
> Fixes: 07f4964d178 ("disas/riscv.c: rvv: Add disas support for vector instructions")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/riscv.h | 2 +-
>   disas/riscv.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 16a08e4895..0d1f89ce8a 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -290,7 +290,7 @@ enum {
>   #define rv_fmt_fd_vs2                 "O\t3,F"
>   #define rv_fmt_vd_vm                  "O\tDm"
>   #define rv_fmt_vsetvli                "O\t0,1,v"
> -#define rv_fmt_vsetivli               "O\t0,u,v"
> +#define rv_fmt_vsetivli               "O\t0,i,v"
>   #define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
>   #define rv_fmt_push_rlist             "O\tx,-i"
>   #define rv_fmt_pop_rlist              "O\tx,i"
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 5965574d87..fc0331b90b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4808,7 +4808,7 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
>           break;
>       case rv_codec_vsetivli:
>           dec->rd = operand_rd(inst);
> -        dec->imm = operand_vimm(inst);
> +        dec->imm = extract32(inst, 15, 5);
>           dec->vzimm = operand_vzimm10(inst);
>           break;
>       case rv_codec_zcb_lb:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

