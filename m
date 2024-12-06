Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B241E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaSl-0005KX-EZ; Fri, 06 Dec 2024 10:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJaSk-0005KI-Ef
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:41:50 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJaSg-0003mY-PW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:41:50 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-29e61fcc3d2so2027021fac.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733499703; x=1734104503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ms08QldXX/ED7nCLpfRG+Z113ncmVLelID9xK3JmOuc=;
 b=fZRf5w5eWSf9lu7akjhMyU/Be+0RhGaYiIabefLDypLnJ2mCXHAhg5UH+iiQNZCfmV
 EcpGf3FYSQK0t/2DR8ZTzQPJsZL16dJPh6v4r9azbfqTjJn43GKxRTNKBSdVSJRnkLjI
 Kvv2DRxZr8u0nrEyfD2JYJOQUk3sAaIxz69Wf3d6j+Mof1yB2cVPNVzARz+K+adx6urv
 Fhu0fWlJHfhL57IiGIdY7n3X2ifqQXZSqo5yz9CDLJnbBKZ3l6vho6O+SoDDxgBIGg0a
 uJ0SoicKkmPxRJcK3HwQwinDcJEGNW1ugkn/Jx8z9ZqxmESJwGy6/LoQ9gwHcjtj11MQ
 1/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499703; x=1734104503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ms08QldXX/ED7nCLpfRG+Z113ncmVLelID9xK3JmOuc=;
 b=hBmD3uLeugjwEg5JHrYJis+lN9J05CyBFQfKLTVxfpTznWFiTN4fApQwWiHISSwiK3
 qzrgwVOv9o/IA32YuVJjrHcX/lNAkXDzpPDYfSlrK/D9I2YdopTjke/5cYCOwZAQr/6Q
 +EgUNTymZNRU79aewRnCRq58cYYIAoGQvy1gjlJuRJl0fdXyW6yEOdv1ELm6m6xnnJTB
 d2sgU+V1rxYjMXnuAqZxDrLb6ha2OaKVNPUDuKNOVFDzeLJeXkhvq/LWxb31jqk4LTOf
 wpP3LTF9Bb1KYvpAXKebPlVgOSPbn2qi709X/RWzvP9ji5+gMXvPULrVIV+nGtS7CFAF
 HY5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUjZQS+y1grzpCqKYHdOPIdDm1xDhonii/ge9yAuoKI/f7MuIGxo2aLuhWUGr/Mijl2v8W0wQbBUCo@nongnu.org
X-Gm-Message-State: AOJu0YyQdoFfdrnli+hGA9q66Frxw3KtMjcM7+xMQ0JT2dha6djI6lnK
 Df0ZPY+KkB+014Y6xQVPWrW5oaNEaUmDDq+Irkpp3xPkrdxxheSfbCi+gM8pxwY=
X-Gm-Gg: ASbGnct/5J6ckXpecjeuuF6A6tIxTpM7ExlBDSdjRRjY8NJmMgAadhThPw2GkaXukJP
 l+o2MzcKSVjrW9MGZbKgNU6VHE7l5Cje+1NV8+O3HGefh52bIyD/QDDSb7HmAIlymZANXbDu36X
 RCsE12Q+tcuHPAMpwBykltoifZV8ebsszmFMZyrQN6hmDTMfvfmXQXtmj4vLGad5dvL5N5948Zr
 89KQoGUjB72T30vx4r9AvwSq6VOVFynpEUIz39P27Z457dtLsoUD8kv+0Wwq7hEvqogsDNLFj4n
 qEalyzZg9PIiVKMJMr/i5txI5wAW
X-Google-Smtp-Source: AGHT+IEO5anCOAUZppqNMUhyg/74+EJx9ZPBColLQ2dhY8VretHkjettBHE1hWs7JgGZ3Llmav7gsQ==
X-Received: by 2002:a05:6870:808d:b0:29d:c832:8402 with SMTP id
 586e51a60fabf-29f735b84damr3157001fac.41.1733499703638; 
 Fri, 06 Dec 2024 07:41:43 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f279304a96sm723637eaf.32.2024.12.06.07.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 07:41:43 -0800 (PST)
Message-ID: <f4cbecbf-9b11-4fbb-aabd-080f83c608ce@linaro.org>
Date: Fri, 6 Dec 2024 09:41:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix constant folding of setcond
To: wannacu <wannacu2049@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20241206095824.281216-1-wannacu2049@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241206095824.281216-1-wannacu2049@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 12/6/24 03:58, wannacu wrote:
> The `z_mask` field of TCGTemp argument needs to be
> properly set for the upcoming `fold_setcond_zmask` call
> 
> This patch resolves issues with running some x86_64
> applications (e.g., FontForge, Krita) on riscv64
> 
> Signed-off-by: wannacu <wannacu2049@gmail.com>
> ---
>   tcg/optimize.c                   |  3 +++
>   tests/tcg/x86_64/Makefile.target |  1 +
>   tests/tcg/x86_64/setcond.c       | 28 ++++++++++++++++++++++++++++
>   3 files changed, 32 insertions(+)
>   create mode 100644 tests/tcg/x86_64/setcond.c
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index e9ef16b3c6..e580b8d8b1 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -834,6 +834,9 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
>                                ? INDEX_op_and_i32 : INDEX_op_and_i64);
>           TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
>           TCGArg tmp = arg_new_temp(ctx);
> +        /* Set z_mask for the follwing `fold_setcond_zmask` call. */
> +        arg_info(tmp)->z_mask = (ctx->type == TCG_TYPE_I32
> +                                      ? UINT32_MAX : UINT64_MAX);
>   
>           op2->args[0] = tmp;
>           op2->args[1] = *p1;

The problem is stale data in tmp's arg_info, correct?  Better would be adding 
fold_and(op2) a few lines later, after finishing setup of op2's arguments.

> +++ b/tests/tcg/x86_64/setcond.c
> @@ -0,0 +1,28 @@
> +#include <stdint.h>
> +#include <assert.h>
> +
> +uint8_t test(uint8_t a)
> +{
> +    uint8_t res = 0xff;
> +    asm(
> +        "lea -0x1160(%%edi), %%edx\n\t"
> +        "lea -0xd7b0(%%edi), %%ecx\n\t"
> +        "cmp $0x9f, %%edx\n\t"
> +        "setbe %%dl\n\t"
> +        "cmp $0x4f, %%ecx\n\t"
> +        "setbe %%cl\n\t"
> +        "or %%ecx, %%edx\n\t"
> +        "cmp $0x200b, %%edi\n\t"
> +        "sete %0\n\t"
> +        : "=r"(res)
> +    );
> +    return res;
> +}
> +
> +int main(void)
> +{
> +    for (uint8_t a = 0; a < 0xff; a++) {
> +        assert(test(a) == 0);
> +    }
> +    return 0;
> +}

(1) The inline assembly is incorrect, and (2) the test does not fail without your patch. 
So it is difficult for me to tell exactly what you're trying to test.

Problems with the asm:
   - using edi directly instead of having a as an input,
   - passing uint8_t a, but using all 32-bits of edi; upper 24 are logically garbage.
   - not adding edx, ecx as clobbers, or better as temp arguments.
   - initializing res, but not adding as an input, or in-out argument.

I *think* you want

unsigned char test(unsigned a)
{
     unsigned char res = 0xff;
     unsigned t1, t2;

     asm("lea -0x1160(%3), %1\n\t"
         "lea -0xd7b0(%3), %2\n\t"
         "cmp $0x9f, %1\n\t"
         "setbe %b1\n\t"
         "cmp $0x4f, %2\n\t"
         "setbe %b2\n\t"
         "or %2, %1\n\t"
         "cmp $0x200b, %3\n\t"
         "sete %0\n\t"
         : "+r"(res), "=&r"(t1), "=&r"(t2) : "r"(a));
     return res;
}

But as the test doesn't ever fail for me, I can't tell.


r~

